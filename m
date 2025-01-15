Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B92EC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6Mn-0007R1-1F; Wed, 15 Jan 2025 11:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6Ml-0007Qo-QG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:35:39 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6Mk-0001cr-BC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:35:39 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so11372f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736958936; x=1737563736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxPVgTnwJ+3G9kHhXmy7+cuvtjTdA95WIIzPZ54H9vo=;
 b=FYu8dKxZg2c06eughp8MpcT/ycU/fIMIEGaSTbz5k2xpZT94SU5S+xtAOZFocpHRic
 0rdIdqYBFgqsxCN0QJ4BvFTpkwj790llAMLr+Bo4GDgv4PKKM4AUK41MAaz00CkpfrEE
 2CFS1+7lrq0zWrDUSmjYu/W5iCJTxTQi01O2WtGMhTmtHVENUMlBePaTXSlUMpu3DZ65
 aYs+gwFyxu+nkINevyOJ5uvpUo07N4B5pTTOJwa2iLIS6dUvpCpa3zrJOc6qz4ov6PxN
 mDVOT8xz1L43k/0Afgine3+9Fqdmn0jKmgk2tkxoLix1pfCIaf0Z3btRc/DM8EohHNEg
 e6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736958936; x=1737563736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxPVgTnwJ+3G9kHhXmy7+cuvtjTdA95WIIzPZ54H9vo=;
 b=wv/ItcPnuNTbUzS7OnJGnsQ0UVWUYNafH/mWrJeAC9g8gSW52bh8K5gMhZc8YbXypN
 uBgJuUBSN9LDceZdP+OZkPRhOOs+L5bgMs48kQF/vws7kkAUtiUllvBeooIDGX+Vwomb
 nK8ZU/SkOcjzhOCzp3PDfs6Gbsilfuz8k1qIhxRA/3Qh9rGAnC+nlqfL3JT5MCjx0qLv
 lnUw56CGeZaNkRVeV0EHUoT9Im9xFVHfb8xi8hSGPpomGCafCdHwWkcXEK6jompcQeVk
 NFI7ZivB1l+SdUETcSxRAS69b6+lt8I2bJ+bhvBwpQM9t5m4vC20+yXn5s5EMvS0mYdb
 8LLw==
X-Gm-Message-State: AOJu0YzuQ0A5K1W/Oh+9FasWF1BV/tMx1cGkHcdl3GPZeIMi/VQ0XKPs
 B3oxTsA0OgPIPzOXJqOGU4FWz7jJVu6K4kBVwJZ2lEiaYxsusVAuP+eCHw+IStY=
X-Gm-Gg: ASbGncsF9EbpvN8TREzU4eCqn4H0klOhLaysflWr/2brTnLOpBGZaxe7zeCJ4OrwNx8
 OOUQQspw4lan4N7ovIYnMF7OECBCE4aC/tfDnu+ruBCZNyRO4b8EpUPhjkIesSfBPui6Gz2RKEu
 s4pQnwdZiVxP+YyJkvGoyzjm2BetIPT74GyqXzotzdvWWHOlbzT1ns84I2/KqG03Qi0KBEQe0cC
 t4T+HAVWvX1hh3+1fjtkYvv/s9YpqyUtLsq4owubAfjsXsrCgErA02ulOkN0O7CNUKew/39Fn91
 fNt2sRG5j+7N6E1/QVJj01Gwq9s=
X-Google-Smtp-Source: AGHT+IHqslZrIHYqUxHTtub/K/LCerOdy7TyfMMafb/8+oA4Oz6munWZfvk2C8Pt8DoQG6FxiEHV7g==
X-Received: by 2002:adf:c007:0:b0:385:eb8b:3ec6 with SMTP id
 ffacd0b85a97d-38a872e9356mr18050651f8f.29.1736958936605; 
 Wed, 15 Jan 2025 08:35:36 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81ccsm18312944f8f.65.2025.01.15.08.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 08:35:36 -0800 (PST)
Message-ID: <a20b0629-78ba-4ae6-981c-bbc1fbf0a866@linaro.org>
Date: Wed, 15 Jan 2025 17:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] s390x: Remove deprecated machine types v2.9 up to
 v2.12
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/1/25 08:38, Thomas Huth wrote:
> These machine types have been marked as deprecated two releases ago,
> and are older than 6 years, so according to our support policy, it
> should be fine to remove them now.
> 
> Thomas Huth (8):
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9 machine type
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 and 2.11 machine
>      types
>    target/s390x/gen-features: Remove the v2.11 qemu CPU model
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type

Should this be documented in docs/about/removed-features.rst?


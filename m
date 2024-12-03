Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D8FE64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIV3F-0000Ut-OF; Tue, 03 Dec 2024 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV3A-0000PZ-Me
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:42:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV39-0001ZA-7t
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:42:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1775010f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733240573; x=1733845373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOdRSxLkZWYqYuusmuaS5IxGsMnnjBO43S0fLPPvzcY=;
 b=MM1/m9CFjE7kM51XzhT3q2pfoNMSFilV3oFQdynGk8XlODunYNCZo5lDm4RLC+KtpR
 Y6qCzcm/1gWmAz2o9eX68VkJlp/9zDocuyJ7i5HWmqGxZ+tW9sspIhhmK63PN3kMzbq1
 zB3VBhSYMuBEqKttrPVEJWyHAvpyD+cK+6ftZKxz238QRAUZ2xXMMliVpzJqGgwODyAA
 8GNugwc4b6gUYsocCwUcUG+IruUj1DO4xmHqii3/SHCvOLX27pecU2xiA6eJcNgXB7TN
 PVlIizgS6R8XoEl9HMwGMywQhZ2ruAw4SiGVOQuvicRuGrTCVEcxgnxU7DYfMTFXOmPH
 F2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733240573; x=1733845373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOdRSxLkZWYqYuusmuaS5IxGsMnnjBO43S0fLPPvzcY=;
 b=Dd8xTipKzTdCflnGDkj/91eb6C2JqYO0268Cmw04NT/KhhA+O2QyWuFmcOYz20AMLb
 iG6idr4bB0KYN0rqXbEtEF/3KRs+0+vn0M4DNuT4Wfbntl5YTaZdsjqghhEzvteK5Yxi
 3RgyXSga0FonD22qryQFGM/EzXoA61zR8V77CobdnptVNKOQjHRiz57F5SlK5273ivVr
 kkgGCRVbSGtp/LdCRdE54OqKpeFaWszIiZyb+dxyrHfVrAbRxKcv6i1XsiGeW8T9Tjlp
 k1pNHRw0TLCHOQmyhkL8eGzGJ9vbgqGkTl1jgfQE4iaSC+2tLdmPn8R4uLl3N+Ve2Oj/
 AkOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuibiHmhB3kyPFbSgEy4h3s+MitnmkxEU7qgYGkJmI87/K4C4MoRKKKl5mbUeUl+1E0tUJ3T0htM7E@nongnu.org
X-Gm-Message-State: AOJu0YxbJO/yCztt5ikQH/s1KeDm8RnQE8RMaaIUFy+Ja3muvSs5NQMh
 c3ZdzlZPHMBunutr6NUXq9Iox/jHksvDmP1w3hBzd7/3qUwpEdOBCXl1n81G0etATJxzmTJOr1q
 na9g=
X-Gm-Gg: ASbGncukKDXF0b3onlt09Q76tLbRa5sNbzPmXSYE1WoHRPo/qqL0AW7kR4aHNShsJ5Z
 byrxAk8txvOIDV+x+Wlp5A3V/AWcQvOKgE/vSBk6FZnxI0s3Z/ftrSDDhOg5t9ccZcVjMbek/GI
 9Q1Gl95REcjNXaiUXmbxPuPA/zc9rK7WRK6tXa01mDW4XCAgMFBsUFuYL/t7mVoTkic8g4XWD1Y
 p1nQBv1DJZDfEskb0koIrLLgVyVpNApy8vCQ5G3IzcWrdbOn6XVjMwRnl+XbKf3ZA==
X-Google-Smtp-Source: AGHT+IGRAaxp1tGbXIpVugHJEQbPg8jZXnlne5+GINUp/wX/BgfL12yPIPPFqXtrySK2VI6lPY9Ntg==
X-Received: by 2002:a05:6000:79d:b0:385:f2d2:2ef0 with SMTP id
 ffacd0b85a97d-385fd53ece7mr2812053f8f.41.1733240573479; 
 Tue, 03 Dec 2024 07:42:53 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dd99504csm13874738f8f.85.2024.12.03.07.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:42:53 -0800 (PST)
Message-ID: <ce4d9bce-e80e-44de-9e0e-013122a2f293@linaro.org>
Date: Tue, 3 Dec 2024 16:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3 for 9.2] hw/virtio: fix crash in virtio-balloon and
 test it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241129135507.699030-1-berrange@redhat.com>
 <24ae6e7a-1cba-4898-bfbb-5f5d3e5c3256@redhat.com>
 <6bf49e96-8939-4ee3-aa4c-4ff5ae5e4e21@linaro.org>
 <20241203030839-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203030839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 3/12/24 09:08, Michael S. Tsirkin wrote:
> On Mon, Dec 02, 2024 at 08:50:55PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 2/12/24 18:05, David Hildenbrand wrote:
>>> On 29.11.24 14:55, Daniel P. Berrangé wrote:
>>>> See patch 1 for the background info on the problem
>>>>
>>>> Changed in v2:
>>>>
>>>>    * Add qtest coverage for the crash scenario
>>>>
>>>> Daniel P. Berrangé (3):
>>>>     hw/virtio: fix crash in processing balloon stats
>>>>     tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
>>>>     tests/qtest: add test for querying balloon guest stats

 > Series:> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Series queued, thanks.


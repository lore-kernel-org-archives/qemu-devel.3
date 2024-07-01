Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392FC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGXo-0006nF-M6; Mon, 01 Jul 2024 08:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGXj-0006mP-DL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:54:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGXg-0004Zl-LY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:54:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so1519045f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838439; x=1720443239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FM7/a57zjSm0v9WQ5iNfP2B2cVIOlhll82HRvAXzdgw=;
 b=IEPZHC3M9UT7dlJmrQjmTeuTXxbXqUx/1DSBfTLSdDO7gndzZUdhFRIlely5dCSU5G
 WqFIR5tt767lqt/bGh4fEmMwdG3EummjvvBEDkW254dfjAArKsnstvc12IacBJ7N7ltG
 8n/gCzn+b+sCuMIQLPGLgQNBRf44EP17pX0jXUUi6rfGBs5U/apWywRUw+xDmwg0uTz1
 AhaVfpwOY/1SAZNeUBU7/hmvO+9AMVarvsaUybrIWowCH2AQdO+PKIpDPK9TyClskUdY
 162iKsPOLCFCtSt6Y5EtfP/C0JpHJ7Dg/Kcy7SV8JnrryZ7tYgoTHCYAif5PpGzcLyKL
 yO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838439; x=1720443239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FM7/a57zjSm0v9WQ5iNfP2B2cVIOlhll82HRvAXzdgw=;
 b=LplmCQs9+qTUOYekN4F+YD6wVX44dr4pu1bQlOTdoFtiFpwGULp+aXN58SoCRG/LYu
 Re/8uwplwDy4oPema1PipI9Z0hbpMsIRJJ6m50G4bjlQFej58G+vR0YpyR7gezYvcYLM
 Zgt4NA2EgUdBEbI7MZmPSrhvOgk2ZZIawIPMahbq0TmWKEdosvMw5IZCcL70Ns/9UsMl
 /Ale+VlFgMHmCOFXUVjcmgtnLHKnCF2os3kTXKQv3u2eyJTK2xADqZOqYeD50Jw1TiWd
 MJ6c8oa8TLxTNk/4y8MbN/hXPRyhr1NQ5PJwcFmAwijHPOgXW00CLCVqQA7XxLGXUKtY
 +iUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlnr3NLGrmZgFQcc3sAKST0sAKSURV1JLjDQujnVSbcAgUzcKJJy4lY8jzTvHoIpHuVkpvxVwWur6kXxxi4zPeZr+YuCQ=
X-Gm-Message-State: AOJu0YwWyJFAziLts5ubjRYd0mNJRPHNCEKj4z4zCeIBB5w2UsZUCX3m
 hgH2QxwjAolZzW8McDvjpTPaKYkoJJDnHsm0Fg4eKpbqu3FZ912hU3UnpdueTyE=
X-Google-Smtp-Source: AGHT+IGUTate5I9Ivefjb4Ar9vWUT46qVMHawZDDX5r0UsmJiPYoqT/SUHNDE3t8oldlfsG+2OhH/w==
X-Received: by 2002:a5d:498e:0:b0:35f:275c:fb63 with SMTP id
 ffacd0b85a97d-367756b8794mr4315787f8f.25.1719838438936; 
 Mon, 01 Jul 2024 05:53:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6d9sm9926515f8f.12.2024.07.01.05.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:53:58 -0700 (PDT)
Message-ID: <08200c74-b354-419c-be4c-d08f1b119128@linaro.org>
Date: Mon, 1 Jul 2024 14:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] hw/s390x: convert 'ccw' machine definitions to
 use new macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This changes the DEFINE_CCW_MACHINE macro to use the common
> helpers for constructing versioned symbol names and strings,
> bringing greater consistency across targets.
> 
> The added benefit is that it avoids the need to repeat the
> version number twice in two different formats in the calls
> to DEFINE_CCW_MACHINE.
> 
> A DEFINE_CCW_MACHINE_AS_LATEST helper is added so that it
> is not required to pass 'false' for every single historical
> machine type.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 96 +++++++++++++++++++++-----------------
>   1 file changed, 53 insertions(+), 43 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



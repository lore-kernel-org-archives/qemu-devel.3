Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A83FB44C3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAiC-0000sV-Mq; Fri, 24 Apr 2026 03:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAi9-0000ra-Is
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:12:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAi5-0006VX-W9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:12:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b150559bso59536375e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777014740; x=1777619540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGc63FaR06AY3Nv65WcPy133f6qAJJ6V/ll3V308U7s=;
 b=Nj7/BSucFPBqIv4VyWQdmh1HvC8WOwbQ5Fyh4QbbLD2VJKbd4/PgV/2v90zYRsJXiN
 L5Ej4BRWagqIzYqOEsSj514+jKexuSDtRCP80HaMTZfbKtSdX3+jhf7ZxegOUobrdBM2
 MiTkVMdJ8DWZmcQm/itAhmZbGUIVoi33mWllNNJfiHZ6mlmXBQOjs9XtJFWaJ0cu5xIz
 eFof0rJRPGpogHO1lYZ/R3Ny5JKBmAQX5mD+kwJzirc3kXSN3xO/2P7vBSiEt1O+IZHS
 fHnaZ1jCq9GIKGRFT1GLa6mIzggNI/GNQrpmA+pG/JVJi0sJfolu9PsIUHtGErVYBPhM
 xUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777014740; x=1777619540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kGc63FaR06AY3Nv65WcPy133f6qAJJ6V/ll3V308U7s=;
 b=A/8RDnwp5VMPjYmx1AWanB28JOzE3BF+r2CX5mhX8hNfonPcaqtCoKAqqm2t1RqDuo
 UBfSxcAM5bWboDnpQIOog4xl62rRwMApoHx2r9UNMB9ipqz0P7P+4LIClQBYK77AO348
 xwCMjmJOg0RTza7jKj3wpKsgG48ZOpaW5IZbj6mDrdKu46/w5rcN7vFRJHt0bKpR3xbs
 Trm/bsURCYvQ6CID+pl1+a0yNylME3pEb5kcyv/+XNdYmPY4zyg1l9VibBjBD6VlqsSK
 nTpiJ7ILa1HGVcWLGKP54zi0Rh3L3EC3N8X39GKupBBRKV9g5BVxWib4k0Y0BZBcu3cy
 YxWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81l1CEwovigG0Eb8wxXkJIipZYFaIUTwF/Tgd3d4yJMtaaFvjT6ttPDcVs8C/tsprGksYc0sjpBeo1@nongnu.org
X-Gm-Message-State: AOJu0YzgmlAWfvB83HHtL5EkEXEn3Fy8pnLhGjxj/gTbRcMVn6NOKC0Q
 v0QukMCt013VJI1aNPkSCilAlTQk8Fy5K0V3tnOsSfOhM+W0ZRxY4Kpg0XQ8v0bMbRc=
X-Gm-Gg: AeBDietwcmHzV/IMSRCtTc5lrUKylHfMqa3qh0X/rg5hTW+ondQ/z8vH9CYLG8e+VXv
 fu1pmIZUO1A95q3mtZHBfd28vKjhj6yWu6y3jWZuauIfuS9bye1HVBD5eIW15HOpV2By4j/OLKG
 gRDjujHcY6BJmHhakw41qKGTt7CrJHD9pK686S+gP78qtUmK89LFIsuVakeK7jGTcAw3PloZ3vR
 27mXSQcrXqn921ASHWO9RR1ZgKgghQYZZbfBCwMRHhSRFAJRdGuJM7Bbx01TPrl6UOB/37zrp3/
 o6Q3fxxRAQjGaUCfcWh2n6ifRQYyumRKLX1OQ60YIi/75YdCpj3T70KOvaqvwcFZ1uUTq+DieZy
 YrTvqnCUlkv+xaAbIXseoydTn5OuTFtju2X5UobdApqDfTEm9Wup24LYRB8CJibFp1wndEbCoKR
 pGSBPIpe1WZQx/pPmxHOF2eL84WhdGqRi4f4QfYm3oyQZohYtkcu1b+SHSBeUxjwGwhw2DOCZQZ
 5qD
X-Received: by 2002:a05:600c:c04a:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-488fb73ddefmr305082975e9.2.1777014740348; 
 Fri, 24 Apr 2026 00:12:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5a579bd3sm205580515e9.6.2026.04.24.00.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:12:19 -0700 (PDT)
Message-ID: <52c42443-f729-4f75-8f96-04ec23dc399f@linaro.org>
Date: Fri, 24 Apr 2026 09:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest: Add regression test for intel-iommu
 8-byte MMIO access
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 yi.l.liu@intel.com, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@bull.com>, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com
References: <20260420170523.17908-1-junjie.cao@intel.com>
 <20260420170523.17908-2-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420170523.17908-2-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/4/26 19:05, Junjie Cao wrote:
> Sweep every 4-byte-aligned offset in the VT-d MMIO register space
> with 8-byte reads and writes to verify that no register handler
> aborts on an oversized access.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   tests/qtest/intel-iommu-test.c | 36 ++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


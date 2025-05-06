Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6055C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDRb-0007Ze-65; Tue, 06 May 2025 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDRW-0007UV-NW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:14:23 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDRU-0002YM-SQ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:14:22 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acb615228a4so1224899066b.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519258; x=1747124058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gd026/TkYZkdVDgSk5HJrxmp0OMZ09O2CF/u+jYZiMs=;
 b=R+l1NJnuRutzO+PlhQcPNZJuFDvr3LRIumRQx2B9Qo32xKoOXZSdeC/G2nzpDsCZ59
 GhEQuKDpsqhEAi7xmjkXVU99m53Oz58gcGGHlcMn513sKHIRHNTga9O4vgCMOybHJIzF
 V7d+b/VHRPQKQ3G1IE3t5Axc+Zviyu9F7y7n/uIggTsuEx0OYlLe4sxc2ioK5KYBJIAw
 L3msVN8q7gS4nAAcrPDEteFbUFhu+RWrrUHB1IVPaN0SrLi9clkcBxs7235GF1SyU9bv
 xSpPxVM0aElm0LztyPsXezhNSLTq0ewGXrT7Eo41K6QymnFxaoiVm1QAqd5t28XK8WrB
 2RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519258; x=1747124058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gd026/TkYZkdVDgSk5HJrxmp0OMZ09O2CF/u+jYZiMs=;
 b=QQBipisr7lYfJl8T3eD89Te3VqYv20ZLr60TV0JKqOJUQ0mXS6lVGrzSfkfXfRnq7A
 wUVEgMrTKvpiFE+G3q0WR4uY4IBRW5KJtFbIIXGQh18hRKejv70KkflF8BTUmxE6EFW5
 N9fg8PMDsp6nvPPJ3S95Q1FW/4RG0q+VcHMXG0eueFfwV3wwD10uBV8X3nG0McUx9lcZ
 amxLySgYzbI3y2vNAUIGMFMncarYyqRzWWNDJivZLtrLVlRgEy7zmH4umJ28LxVvEdyr
 1dQJBAoe5EtfCprQ7y86H4TKJn8ze4Wlk6D0T5+08KcZ8maqAuvpWvTVY/s9aBuXYszV
 FOrQ==
X-Gm-Message-State: AOJu0YxMGz4VA47r9icnLVKwHk4gka0PtRf63ZeEcHXZVjBptGnIIVMd
 Ll6oLxi/bnXCZoQer+yhhVvW4F0VrWPKK4yrg71E3EeKwCrBety9orIxsNFZ7q4=
X-Gm-Gg: ASbGncsZ9i4Iwwn8W/fystHFXk3JDJqX8F8xVOieqMiL+YhA4ndkSurr2Jqa3Gx7Lbz
 kwq1sYhOFXsW4mPi4L1FHIhCO4kTSKxuvRUm6e2hUpLfsbbsApUfZ2YqErtIzFNH3Y95cMi9kON
 WrxMt5NFTQgU7EIZLUpeeRIg01N4UK/G1mXAwZzmxeD5u16AUKgpOXjSQi5w9tGmYVgl+zr1a03
 IMtK/NWxcM2iEXtznirk6H1p8bDnYmm4fFo0T5bDvn6kpnLhoInvlX313aXCd0qE5bSL9J3ZaO5
 nn0gbWbRv2Dy2ES/eYT3p3gahKLOFSV7I+E+Su2t9Sau4VBTw5hTH5mlyCchdBQvatL+KN9Mu+W
 cxCM=
X-Google-Smtp-Source: AGHT+IEeNvQ7CYo2YX1nxHwfJORr2Zwcp083+KYLTU1/g6gKDDPF4gQ9Fs0sK2Dbs29kmUnpLup1xw==
X-Received: by 2002:a17:907:7294:b0:aca:d276:fa5 with SMTP id
 a640c23a62f3a-ad1d2d28f39mr238303866b.0.1746519258373; 
 Tue, 06 May 2025 01:14:18 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c0310sm650985366b.88.2025.05.06.01.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:14:17 -0700 (PDT)
Message-ID: <befca9cf-973f-4e53-b94c-e0fb5bc0db43@linaro.org>
Date: Tue, 6 May 2025 10:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 3.1 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-9-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-3.1 machine is older than 6 years, so according to
> our machine support policy, it can be removed now. The v3.1 CPU feature
> group gets merged into the minimum CPU feature group now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c  | 16 ----------------
>   target/s390x/gen-features.c |  4 ----
>   2 files changed, 20 deletions(-)


> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 754fc843d24..4346b92431b 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -849,9 +849,6 @@ static uint16_t qemu_MIN[] = {
>       S390_FEAT_GROUP_PLO,
>       S390_FEAT_ESAN3,
>       S390_FEAT_ZARCH,
> -};
> -
> -static uint16_t qemu_V3_1[] = {

Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       S390_FEAT_DAT_ENH,
>       S390_FEAT_IDTE_SEGMENT,
>       S390_FEAT_STFLE,
> @@ -1055,7 +1052,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>    *******************************/
>   static FeatGroupDefSpec QemuFeatDef[] = {
>       QEMU_FEAT_INITIALIZER(MIN),
> -    QEMU_FEAT_INITIALIZER(V3_1),
>       QEMU_FEAT_INITIALIZER(V4_0),
>       QEMU_FEAT_INITIALIZER(V4_1),
>       QEMU_FEAT_INITIALIZER(V6_0),



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913E9CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9s1-00067u-Jc; Wed, 29 Apr 2026 14:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9rp-00064a-Kh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:42:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9rn-0001SE-J0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:42:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so846575e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488154; x=1778092954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kyP7dILdhqqu7QMIF3xGaTiSW8Leb41A9fFUr/EASvo=;
 b=C+EGrygU+GB6Jn8DSp2E0IanE5Dy7HXtoMuHGpBbSchLxJHLItvv+XwoFr5/AHajzs
 K91hupBt9JNciiltsHeBsH1WHYYHJwDy+cCovLXVlm4nybbUF9twH8Rgkt2nmKbJC8Ti
 GXtguNhSRLkWlH8DPyDrAsv8hvKl017c09LvKp04nZBzZWsgrBOnTfpKkj+45UUjtL/H
 TWYWthpW5x4DCEqxktfQmRfFO/j5EFUleFyDl4H7zQ9BYo+LVKFkyBMEzS0GRwMtDcGB
 U1kU3DBAwg9FmEDIXDeq/r0Ayb8YVNhllWMOSFLN4VZ+S79dlcbSkvIKST8wXLsu743I
 r2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488154; x=1778092954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kyP7dILdhqqu7QMIF3xGaTiSW8Leb41A9fFUr/EASvo=;
 b=lqQYuhU5HV3pOPgRD26fVplUblyi5FKkoQDP+gUad/86fLmWnPthfp21CXspL6eOeu
 56KSIguAiK2ZSSa0sKQOQL5PTr36lYB3MtauC0pH2Et3YnlwYFix2CyAOv3vRbAnsr1J
 Gossvxrdlq9HhBa4Gti3Lpl0dhKlZttdxo+3pETCygmy7rdjBYM0PcbHd2WNDfxFCvNQ
 QEiPbvt0wtRCijPEUPTqAnSEq1T1kbJvDyYKfs6wYJWWOLhHebybijRLX6BP7WKTEKrb
 gVkGCJtsJ/OQp4j7FA32Uw9oQiDXioMeC8Nr10cp0tJlFnkviFA8rC0IkPcH/+zzNn6z
 0GlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2AurxdDMl6p4a7d3msR8TSgdm/QZB7TU30Bj7wwlle0ExYXNlo69s5nRCQuTumUm9khBySJZ+O2jw@nongnu.org
X-Gm-Message-State: AOJu0YxlHvelnaSJ9Yy+bVBuFNtUmqyAC2DA1PQTMkCn9cSWoXBhyr9d
 +Ch4qxoIwJvcyFMhsdToGk+g+kxfnSDf3dzWm5xJaGoduRp0HpPADbERuWx8f34rPvQ=
X-Gm-Gg: AeBDieu12I/Jtw31/PsIAfF6Fvp+zdTPr3mwf98QTH9UZjZnuxy2t2otuoE68EtGmn3
 OiVhD0UIaWdnxK8w0IlZoz79KNq3MPGLUNWPpKmwyKToYJ5X9GL5cKH+jylw6IVz0uvR0BIp66O
 iuRHJAIz53MnV0uc64lFZnjL1GAY/2B7uI+9qqOcG3zuL3yws1DbP1oxO6LHqZCdah6wz67oeUI
 5Wn4vWvjiDpSjU3gavck/cSw4/zxYCYRyId8SrgsTGwoCcsj1xBIUmQLX93Ul99Wx8LCy12MkbG
 9dMCia84fvqabtr2/dht6diK3b6GpZiD4gaKMIaPk4kncodVsTwMwo7og772TZ88USGwRKoQniR
 NB2Mk7dtcysH5+5qSw5aTaH0ojKWvE1VkgYYM1TAPF/PxNNHaMV9cw5fuT1tjmwUmlowfgEB4R+
 CGsz3KEh6Va87p/o1VgU2LHdNb+92DCw6SYwpYcKU1zaPoAiAeDxpGl57WzzI+DYfXwAqTmW/cr
 CQ+
X-Received: by 2002:a05:600c:3496:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a77b05c83mr153200475e9.18.1777488153779; 
 Wed, 29 Apr 2026 11:42:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f28sm13344805e9.13.2026.04.29.11.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:42:33 -0700 (PDT)
Message-ID: <24027350-7437-4cc7-9485-4eb1f1d57e0a@linaro.org>
Date: Wed, 29 Apr 2026 20:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/84] fpu: Return struct from float4_e2m1_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Inline float4_e2m1_unpack_raw at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


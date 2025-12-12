Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF804D4336B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 06:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTwuY-0000yT-Ms; Fri, 12 Dec 2025 01:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTwuQ-0000y1-Ft
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:45:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTwuO-0003r7-Lw
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:45:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so8954905e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 22:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765521943; x=1766126743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQkenrVoYXOppPDscf9+i06O0cer2RWduFbVfCZVRvs=;
 b=T9+oKVWl3eVF+mBGn2OFM/SjsLX5lNeF5USAS/O9P2xQQcSv749sx+x34+Af/h4ctN
 3SrNfAFBREE5h8JOlpND+6bikz+c3nRstP70rxxEF2cyMueTeAUPUKNfnVda7/j6iG6R
 BnafPO1u907MO47TFjsGCcZ38V5gKgqp9qLA5TqyCPt3TiUwJU0yS8HD+LVCnUMNhP5P
 6HZi/Gvtbl5lnyCJx6oaWLM0/Q4xsN9VvdqWdvX7El3r0eEKZkV9sw3maDgv92caWlmu
 /1SVDpftpfwga7mRHpWSmnoUnMPNHEKBtOiR+xVHVN7/uqJDE6YhPSPIeulYE69+ONG5
 yjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765521943; x=1766126743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQkenrVoYXOppPDscf9+i06O0cer2RWduFbVfCZVRvs=;
 b=tSJFsmXyDg5VZIpBfBQTSlS5nafNCM7Qx4w3XYr0n/Htsbu8za8KjZpj8ZfaN42/cn
 GlPxRyE/Rhu0QvU2gOnCNfRRIM4PfKsNd26uTb3cBK/K144/np1Hd3lGyeGCkXkvI8jt
 0uGEiGPpUMN1LIKew0azbwNkD1+fAtuND80WphWv7hq6P0QkIyeUQFwJdj3WyIets2Cp
 bAaRQZEVPXHT3CBjs1o/2sY4XWNM4A77MslnPYLlkCNU6oVhMexoEFsqwxtM+5/kftqO
 U2c1wJT3o9A7bs4oijMK88Xt6fRjdmBQKR5Jqx+HQFBpCA2BYUV2eURhlXk6Y6H/K3OG
 p7Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTOEEpaJrCffdmB0nQiLCrGETLZ7pPvHZXUMiFnc7DdrNwRIWsexZVtp+5ufSSLzjbIXhcqm13x80r@nongnu.org
X-Gm-Message-State: AOJu0Yx8gifAeNfW/7fBi4hDuLFkZQI2KKHRpEd5d8HidhLbQyBUAUMj
 uNfG6OnYs4j3cF7qiBsYrlrAp0eHE4CgKmZxrw8KplKTakiyJiNJXpTp237mizXbX/8=
X-Gm-Gg: AY/fxX5wU9lh0RIWyEC/tPfVPhgLvfl8WUXpGESEOtp7wLhzQaDCLLm8BZsZObvKcLV
 CcbdT+AiamXy53OIHczuimkIg57MlIQ3PyHa81t+fg4yO+anT6LdBHhYC71DebcXRRmwsPyidpM
 RLYJ2GqmbwgdpRD34oKVXOzZOxYqZ53lFEbCEEMTLi5mLeG1tDSLW7k2/XxjrcKcEJ9AGBRgSRu
 7HqFeOTTUWSUIzFioL+cYjUTiu/iosBQ142TnfHjLa6CRkZ5Vr9mwut+PJam5H83SjtA9fvAYoy
 /t+3OJekusDv9eqxQXEyh1klKaUxVm4mLed9A4GgmR+b5wKjdJCqz4/pbqesrN96nT6TSkYR7+J
 cxXoAJe5Gklt8D5X+MQ+J7nvM//ZPXxzS7zFedNC1nlLABuk2B4S86bBvr59pa6tytYG1QgE7PE
 MVZHb7OkZbouS0/KHHT7QMJVQ3dYgp93jFDTiF7c1l3wLP/e0VtCTQa30jikT3Rjzc
X-Google-Smtp-Source: AGHT+IEKB7wvEa0uvprOW2ZpTAY6o8zCwwEkSL1t4tbKHZ4peVH3SMaTuNzDPh47UXWBWywSUYk6CA==
X-Received: by 2002:a05:600c:4f86:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47a8f9071c6mr8319095e9.21.1765521942667; 
 Thu, 11 Dec 2025 22:45:42 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f38a455sm15975665e9.1.2025.12.11.22.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 22:45:42 -0800 (PST)
Message-ID: <7f479d0e-1370-4574-9966-e373405ddb1f@linaro.org>
Date: Fri, 12 Dec 2025 07:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/9] MAINTAINERS: fix libvirt entry
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <20251211180132.3186564-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251211180132.3186564-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/12/25 19:01, Alex Bennée wrote:
> We have a particular tag for lists so lets use it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05b644cfc9b..a3fdc4ca911 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4466,7 +4466,7 @@ F: gitdm.config
>   F: contrib/gitdm/*
>   
>   Incompatible changes
> -R: devel@lists.libvirt.org
> +L: devel@lists.libvirt.org

Maybe keep both? See:

commit b02c9bc35a03c099600693d6909f4566078880b8
Author: Markus Armbruster <armbru@redhat.com>
Date:   Mon Jul 16 09:32:26 2018 +0200

     MAINTAINERS: New section "Incompatible changes", copy libvir-list

     Libvirt developers would like to be copied on patches to qemu-doc
     appendix "Deprecated features".  Do them the favor.

     Signed-off-by: Markus Armbruster <armbru@redhat.com>
     Message-Id: <20180716073226.21127-3-armbru@redhat.com>
     Reviewed-by: Thomas Huth <thuth@redhat.com>
     Reviewed-by: Cornelia Huck <cohuck@redhat.com>
     Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 20eef3cb61c..666e9368126 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2194,6 +2194,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
  S: Odd Fixes
  F: docs/devel/build-system.txt

+Incompatible changes
+R: libvir-list@redhat.com
+F: qemu-deprecated.texi



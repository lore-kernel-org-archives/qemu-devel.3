Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD3CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PjD-0001xB-MD; Thu, 02 Oct 2025 16:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Piw-0001sJ-CJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:16:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pie-0005k3-HF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:16:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27edcbcd158so18354375ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436157; x=1760040957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6S7Si3aWK4/KWNQhIU3CSvmmWkgcXPS23ZR1s6WUQc=;
 b=MlWCG9p5YFz2+2raW/e9mmv4RuaNtEMd/r1W4KpTWHTpuOTehJMRfLuSamZbVF3fr+
 O+aGw0MoKg1gPsTsMSXQgdF6p9VqlM07tmMvkpxslAHrFITx+kK/JmTI/UuvIgoDcKXT
 i/9L0nPbR44IEfy8SqrbCnvtnOwHNDcz8Jcqo5SfS8XEr31U4XbJ2xAJzGYMNFbiJ5bG
 YVn49Mp6IiDfTi63s1f1rGp+FaiejFqc24AC1GcWoWRoPQ95e9F9x4AxsAnDOPiguxLi
 oHe8L6EHO9vWzixsEfMKlCmn6o7tVC3KAPcsrmYg/OeZQRXd6+QdOwyoq7phMn3v6+Ez
 8t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436157; x=1760040957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6S7Si3aWK4/KWNQhIU3CSvmmWkgcXPS23ZR1s6WUQc=;
 b=FpUrv60cOWmn5VUjkI9Q9z/c/suN+RxpVJ1g7+D+KPSkVRySwzfFLCWtbEH9LutIsN
 XRD94SKBN55FH5dadC6UPkFyg0gegcFGgFVfsWCfuKuXV/1KekD9qmip0TaABnJa8zy4
 m/0EhYw2NL8tdTTUIzi77ZhpTKQvhAiJN5BtLLo99tLBOYccQPWt+LUkUzd61Rvxwhbv
 IjSgXA1E4Ir2sw9Pqaz1kUwtP7ojYo4xoV8Y+NLWyBEEt36XSvOx9RzytjKIZ1GZYtXX
 w7Jb58XqBCKG/WGyEJw2JpLBRV0q+g3Zovfq5C7TYRpoEyYYotOdP+ylxVrnBRsOYbyj
 tXRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7ZPS89KBCrCCSLGcs9SXQVJ4b73Oxif0PlxO6IqT8OlvlEF8+io0+nfxAqSNuR42qakNlm5i1zhA@nongnu.org
X-Gm-Message-State: AOJu0Yx2tFSphGvcFwB5qD/XZnEeoYyUEAGo//DR5plJ3rgbj1FPnr4M
 0zIaAecYEsGpgzqw06KZlRA2nEhNZZMyBV1J7iArJwk+i3mOaG6/uHcJD3AgGPN1MJM=
X-Gm-Gg: ASbGncttv60924Ix3LKJSp7PFl4OUmmdKKiRcOlhO78AWJbU2fERSV84el4zzqfKn4t
 u+8mzJ1dYtWLag54qPvKhA0ngtserfbGxDAOdFnWoVUQ53CPb0ydYaPgWqj4UPRnENBiqSydq/U
 V4UqdMjjpezp9O92LBBmeo+hIxlqevFgMjAJGzmVz8PC5SC+OUC72QKbCyfjHDl0cmsMvCCMDEm
 vMgSck2IMlQIww5c7oaMtvlLI6aTHYL4PjAbCCN3WpAXD1jOC/ZHMk3cDmF+UzmohyYEl+9dmx6
 JPHMzte9KsNKvC3SajccktGzxMj5rX9vFt3iEpGRrJsH6yoLka4m6tQY2lnHN8K3uZCTtjPQ6gT
 sLQwWaTDUNR+kNYQLgDPDulKjPgaIDS2QUBUoEUYq7AHB6tv+PwN0cweGMePSxyn2RJVyUopuAA
 ==
X-Google-Smtp-Source: AGHT+IEAKfOI8hCxTnuyztSUJMu0M7CyBt/aFhRf0zh64NYqEQIy7uz19VsAQ1IqodrF1NLDRoWbCQ==
X-Received: by 2002:a17:903:2f0b:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-28e9a548f1emr6105715ad.19.1759436157565; 
 Thu, 02 Oct 2025 13:15:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b87dcsm29051805ad.90.2025.10.02.13.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:15:57 -0700 (PDT)
Message-ID: <a6a599c0-5ace-4848-8075-7a26b3467a79@linaro.org>
Date: Thu, 2 Oct 2025 13:15:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/33] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-27-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-27-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Fix cause argument to 64 bit to match env->mcause.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



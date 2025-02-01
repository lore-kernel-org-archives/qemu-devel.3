Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B86C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 14:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teEWF-0000Wq-6K; Sat, 01 Feb 2025 09:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1teEVk-0000SD-LE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 09:30:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1teEVi-0008Sk-V2
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 09:30:16 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38634c35129so2293381f8f.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738420213; x=1739025013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZecNtASfh7rrAlvwFbfUE2XXOpRJhV4UbpJBSEoNxZc=;
 b=t5U5PIZ6Slz8Q8c4XYZrdP6LBstWw9fDdYE9bqsViBvLQzN73tLxfv0L3uVwJARKjb
 55kEn1KRnM3syJw91nt4SHD0pO7fJwiF5dzBfIXUon7f19WdeFW8Ug7tfv/iZSnHoRRQ
 qzB9vtFUcUFG7cB+TawwWYWl1uTfoG9eJ0qtNWOqfycSFdghByKjD8WNxb9Od+sotdXG
 LLE+2LS7gmlblVylBdPCnIxpe4VYpsdhiAZRwJnIzVdPnpfl/m1YakaNYkH5XVhrVSUi
 JJXNdw/QDglehm4QtliCxc3zEYpiefligJ6SYUETNN1IUIu6EB3MpQEM++ZgkmkXUZVr
 /xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738420213; x=1739025013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZecNtASfh7rrAlvwFbfUE2XXOpRJhV4UbpJBSEoNxZc=;
 b=G/xlPbaLzqBeVn9d4vgxDoYNsCLWxx6kzcZYITvfSxHgKkTsbB0PwdWX3U8OByHnYK
 tcvhbtOr3ePceXo/K+x7FoX8ljbLyS6NDouZr7xZW/XcQXZ45qHRZCcY61JVk8J/iNif
 C+dfkAfc0bAa/OMmBSO/UTbzlxPTbxyp2hvqET48QbFy2LGulBKCcLjJjCM1x5BgJfSX
 I+WQXdd8KnNw/z3QE8pjjw7R6VM5vzveuny6ST/d5DT3olQv33CzApk9vgF5fApS+eQI
 7nvRbxcb++vKZAAjJQkdcXe+zCTr5Hfkj4MMzCe/2Z4mswySB6prRhguwjjH45hBg9E1
 ry9Q==
X-Gm-Message-State: AOJu0YzqujwPJECFayGRt92kH66rffm4Iic6Sr+Ek3F5QjfGHGtjh/iB
 A65R7bwPU6NB78/bJ+SyDszk/6wfDWQgWfeorymbONMcK0Hyatguyd8toCoUPf1t6db2Eo33Et5
 Oi3o=
X-Gm-Gg: ASbGncvpvwTgW3td8xRf6EvpHLhnBuW6SrBREgoDapieG3VfbaCGloSdYanG378AnEw
 +jedcSdVK80aU+qwZNtOC+LzCNyUI8eAkSq9Alugi7x6wVQK8rpkPh4Yn3rXrbZlbPwMoecb3Sg
 ot2RmaWDXJbohXIESf/EWi+TRzjEgMelec0aJWGl2m3nMWz5+8K24NYBSbPeArgpCRzf8TOekJ3
 hALAO0gd/aZFb00IJUkmQ4kDbFGFMkttflD3Fk9e9+u+PvzZArmx9FTKsvXFeF430RiJmNiHS+s
 84oGDOKcaGibVbMnOa0y8qRWsFOj+MmiDIzBUsqRDkBQdTbax1jEPEy90g==
X-Google-Smtp-Source: AGHT+IF6vu94R6YJceN1F4aDs46wV2+3WTAR7OYi9ojTz0+CA7jg8xfaRONh1jLyXcfTJ6a6LZnAVg==
X-Received: by 2002:a05:6000:dc4:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-38c52097596mr10568743f8f.41.1738420212739; 
 Sat, 01 Feb 2025 06:30:12 -0800 (PST)
Received: from [10.85.240.213] (217.170.88.92.rev.sfr.net. [92.88.170.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf571sm7291868f8f.82.2025.02.01.06.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2025 06:30:12 -0800 (PST)
Message-ID: <4f8886c6-32f8-465b-a243-b5fa510a8f9f@linaro.org>
Date: Sat, 1 Feb 2025 15:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/arm/raspi4b: Rename as raspi4b-1g / raspi4b-2g,
 deprecating old name
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org
References: <20250201091528.1177-1-philmd@linaro.org>
 <20250201091528.1177-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250201091528.1177-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 1/2/25 10:15, Philippe Mathieu-Daudé wrote:
> On 32-bit hosts, rename 'raspi4b' -> 'raspi4b-1g' to clarify the
> machine has 1GB of RAM.
> On 64-bit hosts, rename 'raspi4b' -> 'raspi4b-2g'.
> Keep the 'raspi4b' alias but deprecate it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst | 6 ++++++
>   hw/arm/raspi4b.c          | 6 ++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

>   static const TypeInfo raspi4_machine_types[] = {
>   #if HOST_LONG_BITS == 32
>       {
> -        .name           = MACHINE_TYPE_NAME("raspi4b"),
> +        .name           = MACHINE_TYPE_NAME("raspi4b-1g"),
>           .parent         = TYPE_RASPI4_MACHINE,
>           .class_init     = raspi4b_1g_machine_class_init,
>       },
>   #else
>       {
> -        .name           = MACHINE_TYPE_NAME("raspi4b"),
> +        .name           = MACHINE_TYPE_NAME("raspi4b-2g"),
>           .parent         = TYPE_RASPI4_MACHINE,
>           .class_init     = raspi4b_2g_machine_class_init,
>       },

Forgot to squash here:

-- >8 --
diff --git a/tests/functional/test_aarch64_raspi4.py 
b/tests/functional/test_aarch64_raspi4.py
index 7a4302b0c5a..891a8135b6b 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -37 +37 @@ def test_arm_raspi4(self):
-        self.set_machine('raspi4b')
+        self.set_machine('raspi4b-1g')
@@ -67 +67 @@ def test_arm_raspi4_initrd(self):
-        self.set_machine('raspi4b')
+        self.set_machine('raspi4b-1g')
---


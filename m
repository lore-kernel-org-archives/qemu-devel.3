Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B464CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvHK-0006sx-8i; Thu, 11 Apr 2024 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1ruvHI-0006si-GS
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:19:48 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1ruvHG-0007iN-RQ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:19:48 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b10ead8f5so26299666d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712845185; x=1713449985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZi6EZlMCSwTIOE5HWH3P6AYsvsBMzQX3hgCcaeA0MM=;
 b=l+GP1hPmOGjMN0VmZmdGFLGyNm5V8WVsJuS8/FDr9KL4Y19PBviNUSYqXsLjTVnTlT
 3wWZzGawfpElugRGdDVeH+2bewPl3VCvWTYYDCCHgUmKsS4t9HgbF4eyvIoEsW5JWunb
 XiG4qsOggnBESd1wc3W1RQD6YNu6EBPLkkOXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712845185; x=1713449985;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZi6EZlMCSwTIOE5HWH3P6AYsvsBMzQX3hgCcaeA0MM=;
 b=fEo2/RU424MHkVlVqlK+DfZrr2FeruL5p0Mm3um5SksoHig59CLbFW3UY2KPbUhzHu
 Ym/v2OvXFo4zfK6jxVr15ErZ0QjGBr740V681EVN3GuDAA3Ngp0v5JF1TBk718yePB/B
 +ZdF9ssx2/TRGo9/Bqc1umRPY9tNa7ews4r1nnqrWHz2AY0pyRNuI0eGNt3u5UDyF11g
 ome3jG03gCzOshI3MXt1O17XooKoRdo3aP1xnNc426+XAxMcKJJU1TT4GccyEq/dhnT2
 OZ0MHOtgllYmNFC90bFXSaWoJqLY8V2aRcJw6qbgJNI3hjjeZxYYm9uP6+vymvVus07k
 m0Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFDSdZA4aZRs0BKY9oyKthoe6H0B2OHOhV4KBpuiTWL7BsADBoxCHhOeXEo/Fg0mpkGZ0HhLNZbb+NTi14o4dN43wb69w=
X-Gm-Message-State: AOJu0YwSSP8zCljt67K1p4Yep0YXtGyboyUIwCC9obAZjuv7DnTY1Zu7
 7/Aa9Q1uUCRRfdBulj/qZjor1Kl315ZmUmjICwrYpB4/4zD6uB3ELTafWeXmpaU=
X-Google-Smtp-Source: AGHT+IHFq58JEsmIe4Jon/zA4gkpGb3tgBbX6KB2yjTvy4LDW36276+zj+keg/EOkMMwT+1xV0paYw==
X-Received: by 2002:a05:6214:766:b0:699:274b:2173 with SMTP id
 f6-20020a056214076600b00699274b2173mr5127650qvz.14.1712845185434; 
 Thu, 11 Apr 2024 07:19:45 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 dd9-20020ad45809000000b0069941839737sm1002421qvb.3.2024.04.11.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 07:19:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Fabio Estevam <festevam@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
Subject: Re: [PATCH v6 0/7] Resolve issues with booting distros on x86
Message-Id: <171284518298.255737.6903946545215484016.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 08:19:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=trini@konsulko.com; helo=mail-qv1-xf31.google.com
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

On Thu, 04 Jan 2024 08:10:35 -0700, Simon Glass wrote:

> This little series reprises the EFI-video fix, fixes a USB problem and
> enables a boot script for coreboot.
> 
> It also moves to truetype fonts for coreboot and qemu-x86, since the
> menus look much better and there are no strong size constraints.
> 
> With these changes it is possible to boot a Linux distro automatically
> with U-Boot on x86, including when U-Boot is the second-stage
> bootloader.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom




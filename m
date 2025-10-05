Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9ECCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 15:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Qte-0006zs-FN; Sun, 05 Oct 2025 11:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5Qtc-0006zj-6W
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 11:43:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5QtZ-00088h-R4
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 11:43:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-26983b5411aso26340065ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759679012; x=1760283812; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pbx5TxDrhospeg3mAe1q2oaZh1OL3jT6kMymIr0TxRw=;
 b=mqKWrI/O02Rbf/15UhrTc0sgKhThXCOaW9/ZI6hfkT+a2sNlLgzqx1SCDK+lsg2Qgt
 1M62y52l80qH5tBq+JE/Uh595mDasTXycNlJkPBJlIXFM5YBj2Wc4Aa563niPkz1n7ch
 OtTew4Xwcq5K+vVoURShPJZtcTXaPYwhMztyMBEnLHyiCYVxuX/crCYtT6IK8FNw1Yud
 HJlC/FcfFCrmFkRshLouaBFm9XbNO0HZo13JFYcQVTkp59mYrLm4bsMT8nXfVQBTA1S6
 oAlPbXETlvOzwUvK5gX5jZNzIGJp2YxOP46LmVLG4YRLyBAaP5ziCC0RB8I7cMPbaQYr
 LlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759679012; x=1760283812;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pbx5TxDrhospeg3mAe1q2oaZh1OL3jT6kMymIr0TxRw=;
 b=DI0TY5DpM4kHhmq4p3inmdMqFN0PfZoRjSzIvW07FoleFnYLnlAYBxyIoyac4XmX2q
 Sy4wiElGcW4m8rChKUg1xVwFa4gMN27dV2fAyh8jm1/LuUoK5Qj39tNj0CBXVNdqPXJ1
 aeoLJSSWcwXmt8JNsPy9ICFHZXSDLEfFHjsaGXSUTmSSNVCx+w4S/JnF1L90dssEk+/x
 DrONecJXoMUDTiGbozwFEtgXaBjvk3HC2eOeWnXfSxSfT+ZY36KPeVKtQPD0f6x7/xlL
 NsPLuh7YuzYZywmT1RmGsSr5IraIP/y5JOfxdYbpbJDBPoUxxBz1FppHA1p0UOqEVGhu
 c35A==
X-Gm-Message-State: AOJu0Yx0/A7dgvrvp9Lxn3mKNywbQPNes/fOCJR2uoNf8r8OUxWbjQ+F
 SjYqx6xTO+dRkeRDFiZkNDN18RpJAjiVvF4VTCFu5TTcoI31S3oyWMs0
X-Gm-Gg: ASbGncuvTc4sgVEukbGpYZKonQJE9riR/yvIt1Yumq4SJ45wovLgYvbCoC8C0xrougj
 x/wCkdIjpwXGHtbOeWP756TwnDI352s2COo5avc7EYAqCH+mbdoOQeZBVMgIrn/yeluKyrpC251
 i8iHGSckeaxrrsZU2+pFYV86iSy1MkhTBv66SgOrY13cZ8RreQfxAgqWOIwMIAWL6czShekWnvC
 qmfGIRgVo8xDDvdsDKOqlLVltYVWDRfIvGOw3AxElV+hkhhES0Ukr58JZQdEPrZksDfklqWTHfY
 Gdd0OdZ1N1pa96GUHUri2+op+z2SvPg8NHVvUzRLDWX4QY+1vWpVIcwGv7ccnpbvHP8be11agni
 kyg0Q/E6iHziv0ifNa+af/Mcs++r3MBo8YVbHRWU+wEAMyVzrOuf44bGKa7g=
X-Google-Smtp-Source: AGHT+IHaLKMtLOLbQvScGeB8e0npEJtp2patMOnVa7dTUH76DAu3LThFv0GwIh6Unp1VfJKM0QaMUA==
X-Received: by 2002:a17:903:28f:b0:27e:ea82:5ce8 with SMTP id
 d9443c01a7336-28e9a57468bmr114263715ad.14.1759679012077; 
 Sun, 05 Oct 2025 08:43:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28ea1d99ab1sm67912675ad.9.2025.10.05.08.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 08:43:31 -0700 (PDT)
Date: Sun, 5 Oct 2025 08:43:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
Message-ID: <6c23f546-c135-4345-93a4-25d75a038902@roeck-us.net>
References: <20250503212708.3235806-1-richard.henderson@linaro.org>
 <46ea9b87-cc73-4408-82c4-2de96dddca0a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46ea9b87-cc73-4408-82c4-2de96dddca0a@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Oct 04, 2025 at 05:14:45PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sat, May 03, 2025 at 02:27:08PM -0700, Richard Henderson wrote:
> > This should have been done before removing TARGET_ALIGNED_ONLY,
> > as we did for hppa and alpha.
> > 
> > Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> When trying to run sh4 emulations with qemu 10.1.0, I get quite interesting
> error messages. Bisect points to this patch, and reverting it fixes the
> problem.

Actually, it is worse: Commit a4027ed7d4 ("target: Use cpu_pointer_wrap_notreached
for strict align targets")  claims that "Alpha, HPPA, and SH4 always use aligned
addresses" which just is not true. At least sh4 generates an unaligned trap and
handles the problem in the trap handler. Result is

ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached
Bail out! ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached

after reverting this patch. Also, hppa64 has the same problem, meaning
the hppa64 (parisc64) emulation no longer works with qemu 10.1.

I thought I can revert a couple of patches, but the problem is too deep
for me to track down. I'll have to give up on using 10.1 for the time being.

Guenter


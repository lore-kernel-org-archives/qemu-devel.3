Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A97C02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgaH-0001yw-U7; Wed, 05 Feb 2025 09:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgaC-0001xd-5m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:40:52 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgaA-0005mu-Ie
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:40:51 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaec111762bso903049466b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738766449; x=1739371249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7f8lQu8DOfVQpWsQDR4Zyz3zkf04IhQ4x1uKW1bV3HI=;
 b=dneV62T0JzmVex6UJmvLuGbTxj5t/bVH9Q49NImkrj5+6Ded1/dUXHb1AGGbqlPpLt
 iF/GAcUCRntAfoQ6exkJs1DugsMPiFgIGsGm0NI/cHCSwOiBZwbFY1KcTmit+CEtrmei
 YsgVxo9QZApG5iXGIxgAEIGXIRGcwpXlzq8eAiHUp1VWizFnVz6oY9K+fnD9YdLQgX5F
 BKL67o74o/9jfbdIsCmsU/R5jit63j499CdAHjfaIr5QA+y4ykU24LCti3YPXybiLdw0
 TiX20mUmecttmJB7WXl8PyxCUZsgDbwb2Ie8MxiSTjS4t7ZDBHSW+Nrtxzqqsnj4MbuJ
 4WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738766449; x=1739371249;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7f8lQu8DOfVQpWsQDR4Zyz3zkf04IhQ4x1uKW1bV3HI=;
 b=JYg2iIV/M94J06MOiAQI/ykOHNujp74kcQJcHnKFMyGPgW4+AK9R0dSt9I+Mvj0pyv
 rXDm+eeE0DAHFP6xfCGyO6MFHjFi65JzWvV1aRcQ/3PBVxhuccvgaIF63fCRfKjGyhaH
 K9+PiTzsC4FLA2v6SIdLOBnzU08mJpzWM1tQDjPW5w07LL51kMq6hzrBy+9undj852we
 dyeNhW/hwtJyYKZwzDBHASJpyIzKhW3sH5Ogfls0R9FnPAL8M+/TEZw5WBOd1rAvAdps
 mKMoicIw1U2cAEOyrxvfcWqUTibTNKEeCp6CByQGpX+xxZ5RnDMIZtgbdXjduNfVFcw8
 N2qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxyRaXZOjMwCadhk7V5oATrRHMgSvCJVmhPPr0KKCcMR2uv9trQS6giASYMkLH2lAMAS9uK5flmyNM@nongnu.org
X-Gm-Message-State: AOJu0YwlFJZj0eA4JWYG0kGCClqiGgacK/iWLrhhjSlTuVwJ3a2b0jHY
 OJEX1YRlviNxkr6CafLAw8OUpFKIniy+ZsRWnaStK8UZAhLkFx9C5paXNeEZrcY=
X-Gm-Gg: ASbGncuQpLp7vn3ZjV92mcS8sUN96mORcpNjUvMYzPtSA8VxlyNoCwrhG7uAXjKkd7q
 FdCTSMTyl9+pqaxiLj5wGIuyPbDq1zN7GdqzPFK7d6Y1dnk/buYijAjeTmyjjkoxQLRbx+aUBou
 Du20NpzhZ6rM2HN3cqMbYTGSNYYZEbN4c2ZMH39zQ8AG4DEyfRj1Ca0RtTRwfMIv6/rFIWIct6t
 kG+op4Uom69TrZqAl4vzY+8B9fQ24GepAKNIsVPrw5Q7N6fDTlMLBVlaY33odN9vBQqbOsrTDWk
 lS9AtsQf/TsBTZQ2Aw==
X-Google-Smtp-Source: AGHT+IFNW0c9L1C4VSq2e3nj99jjzepSunI4J0GD6lEhq7Otu+/kAMKyxPM28zywRzsBobokLfFLHg==
X-Received: by 2002:a17:907:9485:b0:ab6:d9f7:fd72 with SMTP id
 a640c23a62f3a-ab75e362522mr331797766b.50.1738766448732; 
 Wed, 05 Feb 2025 06:40:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7656d5d5asm77162866b.48.2025.02.05.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:40:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 686F35F90B;
 Wed,  5 Feb 2025 14:40:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 07/14] target/arm: Honour SDCR.TDCC and SCR.TERR in
 AArch32 EL3 non-Monitor modes
In-Reply-To: <20250130182309.717346-8-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:23:02 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-8-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 14:40:47 +0000
Message-ID: <87seos8nf4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> There are not many traps in AArch32 which should trap to Monitor
> mode, but these trap bits should trap not just lower ELs to Monitor
> mode but also the non-Monitor modes running at EL3 (i.e.  Secure
> System, Secure Undef, etc).
>
> We get this wrong because the relevant access functions implement the
> AArch64-style logic of
>    if (el < 3 && trap_bit_set) {
>        return CP_ACCESS_TRAP_EL3;
>    }
> which won't trap the non-Monitor modes at EL3.
>
> Correct this error by using arm_is_el3_or_mon() instead, which
> returns true when the CPU is at AArch64 EL3 or AArch32 Monitor mode.
> (Since the new callsites are compiled also for the linux-user mode,
> we need to provide a dummy implementation for CONFIG_USER_ONLY.)
>
> This affects only:
>  * trapping of ERRIDR via SCR.TERR
>  * trapping of the debug channel registers via SDCR.TDCC
>  * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
>    (which we already used arm_is_el3_or_mon() for)
>
> This patch changes the handling of SCR.TERR and SDCR.TDCC. This
> patch only changes guest-visible behaviour for "-cpu max" on
> the qemu-system-arm binary, because SCR.TERR
> and SDCR.TDCC (and indeed the entire SDCR register) only arrived
> in Armv8, and the only guest CPU we support which has any v8
> features and also starts in AArch32 EL3 is the 32-bit 'max'.
>
> Other uses of CP_ACCESS_TRAP_EL3 don't need changing:
>
>  * uses in code paths that can't happen when EL3 is AArch32:
>    access_trap_aa32s_el1, cpacr_access, cptr_access, nsacr_access
>  * uses which are in accessfns for AArch64-only registers:
>    gt_stimer_access, gt_cntpoff_access, access_hxen, access_tpidr2,
>    access_smpri, access_smprimap, access_lor_ns, access_pauth,
>    access_mte, access_tfsr_el2, access_scxtnum, access_fgt
>  * trap bits which exist only in the AArch64 version of the
>    trap register, not the AArch32 one:
>    access_tpm, pmreg_access, access_dbgvcr32, access_tdra,
>    access_tda, access_tdosa (TPM, TDA and TDOSA exist only in
>    MDCR_EL3, not in SDCR, and we enforce this in sdcr_write())
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3CAC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 13:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATf9-0000Ur-12; Thu, 01 May 2025 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uATf7-0000UV-Pv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:09:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uATf6-0001oH-38
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:09:13 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so1450375a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746104950; x=1746709750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdWKSdW+afajHbOuCGOS+D/P7KG+k+KG/QYvgP4sbX0=;
 b=Kq8gCvxSDojetyKwWCVbE0sP6/7jbgaDIkQctjTpPAb6Ihe3lq6ZTJzmVvtYPBdMdE
 D1KaP9lv7LM0fs1B9m8Hk5BnfEW8YNjLAcJFxe7Z3O2+sfOs8C8GhZeZTvlmRlSCkWBj
 6RqGqN1euwH6BH914KiWikey1lvSvmCEkRF3I+14hxte2GdLkHNXE9E7pZsTlK/7yPSV
 Eml/miD0VMCXNoKhoC4JTYtbXljUMw/sVUm4chJCQg49GNwcY4SteuS8GdDWZDLn62Mb
 b4AmTyU1k1fsVUPc1t99RGpU/LBP89gLjRSrNHX9PxvxwUKAoBRabSJN31VcSlb+jGzy
 wgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746104950; x=1746709750;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdWKSdW+afajHbOuCGOS+D/P7KG+k+KG/QYvgP4sbX0=;
 b=G9oT4X5CFGsk0YerW3MHbewLy4Cryl4qH2tVAHTzn0XpP5TBnx1gLO2url7FxGhzKS
 1oTKq8lDjBFYWHfTQhWdpd2hY17d7AHDMKHlEA+o5WJZHPa+UX2hkq50vELQIoHwf7d+
 lYLXILGDhPK0TYAUKNKKkdwyedkbkVeHG1zifacb4Wtg8KZSs82D62q/XWJxmEClKmBN
 TP7rTrV3KMByuqIkvCklIcOKtZDq/dLzCof6GkkP+cHg9BQsWE173mxIBmeyicBGcp5f
 78fFURrrcTCPuCHs//5WualDnNCfzeAUhlHMzEGr4CHmQbt8t/MwZS59RJhg+mkYdkdF
 5UeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa/CwcGwVDcWnNBgngq/7JH36Y6GCEewmmrw2xwF8+TsdnbaJVp7c73AW4gU137LMsxCaCaZ1vsH3p@nongnu.org
X-Gm-Message-State: AOJu0Yzt/LkHS0ge40zryduQpRbgzFlyDnUp3MmPKly7j1bw4s6ErOAn
 fyZCSB6oW+9p3tBSzhIycInP6eEHMZluLwx2bP0nKksIa7pEP1vIHRAs5jXrEK4=
X-Gm-Gg: ASbGnctmVc62ozcDfvqwItNKZCfQIJbX4CzKyUhgK63F6EF+InNIEMFpSc/f5kfL+3x
 WbWg0e7SWzOsiXauqS6s08Af7shbjL5sM+PqyH4evcAK9z0j7s6yeRc1LMRy27CRMZhJkuVXu38
 5+P3AxLVGK7oaNGqRGv4nHP7mYyha+wssb275M5HAkeBBF8r3MnBuOXv9StTG0uXtx3yZJRC0Si
 W3tWgwLWxfWvqm5o5YUPm1FZTo1p60A0Dpo+PfmH3uw/Y50FPo+sbBPyCuzmcfSqDZYBJEBujQz
 XW34wAHE2yc/3yO5CIET8n+O46HbM8bVXx7i6eaxg4w=
X-Google-Smtp-Source: AGHT+IH1GQYKFDp6XBXaS4JmwNZQCPd6UbPwmrRe+XYnf36tIceDGvDzcTLHNS3ZGak5Mr/0V2SEqQ==
X-Received: by 2002:a17:907:1b1e:b0:aca:a204:5df2 with SMTP id
 a640c23a62f3a-acefbfd52a2mr253503566b.49.1746104949667; 
 Thu, 01 May 2025 06:09:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad0da517380sm37749166b.89.2025.05.01.06.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:09:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6287E5F9F8;
 Thu,  1 May 2025 14:09:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 3/7] hw/core/cpu-common: Don't init gdbstub until
 cpu_exec_realizefn()
In-Reply-To: <20250429132200.605611-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 29 Apr 2025 14:21:56 +0100")
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 01 May 2025 14:09:08 +0100
Message-ID: <87r018xytn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Currently we call gdb_init_cpu() in cpu_common_initfn(), which is
> very early in the CPU object's init->realize creation sequence.  In
> particular this happens before the architecture-specific subclass's
> init fn has even run.  This means that gdb_init_cpu() can only do
> things that depend strictly on the class, not on the object, because
> the CPUState* that it is passed is currently half-initialized.
>
> In commit a1f728ecc90cf6c6 we accidentally broke this rule, by adding
> a call to the gdb_get_core_xml_file method which takes the CPUState.
> At the moment we get away with this because the only implementation
> doesn't actually look at the pointer it is passed.  However the whole
> reason we created that method was so that we could make the "which
> XML file?" decision based on a property of the CPU object, and we
> currently can't change the Arm implementation of the method to do
> what we want without causing wrong behaviour or a crash.
>
> The ordering restrictions here are:
>  * we must call gdb_init_cpu before:
>    - any call to gdb_register_coprocessor()
>    - any use of the gdb_num_regs field (this is only used
>      in code that's about to call gdb_register_coprocessor()
>      and wants to know the first register number of the
>      set of registers it's about to add)
>  * we must call gdb_init_cpu after CPU properties have been
>    set, which is to say somewhere in realize
>
> The function cpu_exec_realizefn() meets both of these requirements,
> as it is called by the architecture-specific CPU realize function
> early in realize, before any calls ot gdb_register_coprocessor().
> Move the gdb_init_cpu() call to there.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


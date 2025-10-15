Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AABCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96wG-0004uW-5C; Wed, 15 Oct 2025 15:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v96wD-0004uA-VP
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:13:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v96w0-0007S0-SZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:13:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso43019455e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760555586; x=1761160386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbOGzIaEsodhx66RkyVC041Zj7ZhLUsmLxMucbS38Hk=;
 b=XfacpwZvK1roIBs4eKKt4mbOdsHKtPn2ZeaKMhDPnlXQ702b9QeNUKi69H2kXxnpND
 /tHvCBSPicQJQIOOmQt4KVd1rlh3PHCQNA1XF7lF10ByUhQOa4b0kOS/LjyrcUj5nVYP
 s80s7yoG51c0wtGu0icEhUECZmIVNGXeQt+UjSP3rbwvJHtidQXr8/82/JAn5gZUOvIq
 8K4YGsYeczji9imBuNjqihs9J5aXdbqggKRQJdKvJEr7RC7/q6nc146v42RBPCYvfbpH
 YLJxJH/Cd9mX6/TT15l7a8bmSsGY2AU1v0tQBFSeDhjG//uOi5ujyEx4DWek0S95pqtC
 46lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555586; x=1761160386;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbOGzIaEsodhx66RkyVC041Zj7ZhLUsmLxMucbS38Hk=;
 b=R5cSClWeCgx0ieMle0Imz9eju3MKiJtlu2XDR58Gt9sZNhW5oYS1exbYbgpRvwcaFM
 egnl4XaSfN8HXcalCtcJyc9d8MaW80PIaBsdBsx7Nrn50eWoxcFLnH7/TvGQSS/kLm/W
 rLNcZPszGcUGnOgEyRMHzsLCdSAhpYzzAj9OCiF+QGVcVT1ohWZrjDJDDrZZCTC3M3hz
 kQXWbuByehBBt83+Mn9rC8UaCKbD5GgWGQXOYRPuXW5NF+MBGDh8dyShJSzZ47EPGUHp
 RKvkbTWHgs2bJ4xLse+4I7ZrMMc2sOPPQtk05Gptbn5gfGAKdbkbawB3qsVgqA2OotJ4
 uWEw==
X-Gm-Message-State: AOJu0YwnvdrPiUEno+CiUwpDjaoijD1Nfw/ko7V1/yNlzS9/hyhCmg0l
 9+A4+2d2zIid51flii6ibV07wb43Rlawwvru+2ynkN2ySf3bMzTVhZ1k
X-Gm-Gg: ASbGncsrO+AivNM/4uN+KHD8hoRo2M0tlb0pyyizTsRbc75QqMcjX/ZyBQ8HENicvuB
 jh5DZzW0X8PKoyO5ELLuD1kRH+JdeKLKux5vGqGBo3FmiN3uSfOtgpF9LBbQfdfLmcghqoPF1Tj
 cYhCPWTeKBZmNagl9ylZhKNpzvtl5mKSmV2TtL3lNwyElowog67gk/3pGsQt94UBmx7N1BdQUsv
 lbrFOMmleeSr1XLhURRheglGwRwDk0hRC1Yso4uOYJ+SVZjv+iFGZvFxoNlph2lP04UOhCHdmSW
 xrhaRWLFxEr46tmoErBuEWn92DUbH9AfIBQeh32VjekF/dU8PemhRAhd9dRvVyXz9B4ZjXrHLj2
 GN2gGdY/X/wpZbQ9PJZqUO3TlBZwXLltylZydMxB+DxeH3+tRksvSLt0OtFXqY+n9zy99Iu0Lc+
 Gl/g892MKnF8a5FWC+EaSx2aQXB5XEx4VwFiT3iw==
X-Google-Smtp-Source: AGHT+IGSdiO0aJqy1QYPNp7WcId1zHqMZ8equEa5lAc/7I6ChphlWOXIMj0hg4u1JLcQzUtyw63E1Q==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:528f with SMTP id
 5b1f17b1804b1-46fb32e52e3mr165255815e9.5.1760555585805; 
 Wed, 15 Oct 2025 12:13:05 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400584b8a9b5cfa81e2.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:584b:8a9b:5cfa:81e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c21805sm46527655e9.10.2025.10.15.12.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 12:13:05 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:13:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
CC: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_hw/ppc/e500=3A_Check_for_compati?=
 =?US-ASCII?Q?ble_CPU_type_instead_of_aborting_ungracefully?=
In-Reply-To: <20251015111243.1585018-1-thuth@redhat.com>
References: <20251015111243.1585018-1-thuth@redhat.com>
Message-ID: <2E16FBA2-5B65-4606-86DB-DF561338F9E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 15=2E Oktober 2025 11:12:43 UTC schrieb Thomas Huth <thuth@redhat=2Ecom=
>:
>From: Thomas Huth <thuth@redhat=2Ecom>
>
>When using the ppce500 machine with an embedded CPU type that has
>the right MMU model, but is not part of the e500 CPU family, QEMU
>currently aborts ungracefully:
>
> $ =2E/qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
> qemu-system-ppc: =2E=2E/qemu/hw/core/gpio=2Ec:108: qdev_get_gpio_in_name=
d:
>  Assertion `n >=3D 0 && n < gpio_list->num_in' failed=2E
> Aborted (core dumped)
>
>The ppce500 machine expects a CPU with certain GPIO interrupt pins,
>so let's replace the coarse check for the MMU_BOOKE206 model with
>a more precise check that only allows CPUs from the e500 family=2E
>
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/3162
>Signed-off-by: Thomas Huth <thuth@redhat=2Ecom>

Thanks for caring, Thomas!

Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> v2: Drop the old check for the MMU_BOOKE206 model
>
> hw/ppc/e500=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index 723c97fad2e=2E=2E3d69428f31c 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -20,6 +20,7 @@
> #include "qemu/guest-random=2Eh"
> #include "exec/target_page=2Eh"
> #include "qapi/error=2Eh"
>+#include "cpu-models=2Eh"
> #include "e500=2Eh"
> #include "e500-ccsr=2Eh"
> #include "net/net=2Eh"
>@@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
>         env =3D &cpu->env;
>         cs =3D CPU(cpu);
>=20
>-        if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
>-            error_report("MMU model %i not supported by this machine",
>-                         env->mmu_model);
>+        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
>+            error_report("This machine needs a CPU from the e500 family"=
);
>             exit(1);
>         }
>=20


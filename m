Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A442C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTemL-0000CH-8q; Mon, 23 Jun 2025 06:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uTemJ-0000Bq-Pg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:51:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uTemI-00049z-6V
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:51:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so26072935e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750675911; x=1751280711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=p63UtGusaW/J/6tJLAu+3fN9mOSfv7i25YnwIzVwmUQ=;
 b=IFE/FL8Mwu5buZF6PZoyPNVakQoWxVw24Bf42hCvsD2GRhX1xiqJzGEPaw4/IwKl/m
 JV+zGzLMM6iVA7jv0w87aufHWClxEFtTL5feCDaUrYZlUie3IaJoXHA0Eekxuj4tn+aK
 RhG1zhtOdryDM+J+7wu1ZV7YRa8fwPnSsOpJTt3d871grJoZ1ngc/5DXrb7vN9dykQxn
 fMX0TemtJKbLZyKR9raWbbu3EdK84UCbGXaQL9RpnyoqTEDkM6CcjQyrrgl3pR9UpVC7
 a3gaSvCe27Ci/ZYjBHn4fxU3LlXkkiRrqQmL2T+6TFS0UNUrSnoaor8qpLI0Hm2826Ql
 gR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750675911; x=1751280711;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p63UtGusaW/J/6tJLAu+3fN9mOSfv7i25YnwIzVwmUQ=;
 b=IwZ+eymUFZ40eLmqYVJOiFJ83GYkDX/a9TxK4HiGmlr7wrAkbo3xje7otY13rTIhGa
 SGK3rkPeqYyPXPObVmOqnixk4vdmsDC0mZtx1zDT2iaZbWcE4Ciq8IM/K8x9qaBPl3c0
 oZsVe9kryQKl7UCr94+o/mQcCzZ338kZZZQRQSmm3GPxT/lmRDKe/42dVh7xwlvpUbeu
 qu0cPKIAHr7zQVWda6QdTR6NccK1WKgI93300M2xk6WTCRmAn1i3ZDaitaHiy7dIyA4D
 srZWjfjjuBSCbDJsWIyJkx4s3DCYPx7WZFDhUqcR4+n8CyI7tqcIuJGhEw8tUGxPx2D9
 i2fg==
X-Gm-Message-State: AOJu0YwDOKsP4FbGsJjnZvXqYVXD9B7NFNROqNEQ5rlyJrv56cbh4ABf
 R9uTe6c/AWm+656zMtUOJduu15eE/ZlUR2ZVCBqB2g3LW1oNrqYpk3Uy1veUsg==
X-Gm-Gg: ASbGncsZ7k2soe1zErFEIg3meNFZDp+QjWTXzFexOog9UnSO4Lt4X94Licq860ibkXw
 /+oiuJ27YqGCFuG9vbQ/HHsf5IDvImC1h+9jlq32+NzET4nmsMBnvFC24JT/n5r9LYX/QzmiOoz
 DeZ7/Ka0lyHAThqubHIf6Poy+nknsNvipRMIa2UTtmr2A4t7v6zjCfGQSXGInyhJCMKJX1in9i3
 ghPyxlKXrxIdtMZVD0W7aTPuO4FXSKFPmswYXFk1cqCKppd9iY/nPEKgyp+08Qfc78E1lLxd2+G
 JVohc2bnL2sa62wSLIYwYBnsokM8RNPY5quBu0uirgpbSSYsrtWNZU5I
X-Google-Smtp-Source: AGHT+IFFje/YwD89jUuwwFtgCINDfJOwitqihI+74BVOOAQeiNQFcoAA4ctjCqP7lsTJHeCEJn2cfg==
X-Received: by 2002:a05:600c:a20a:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-45365dd57d3mr57344585e9.0.1750675910830; 
 Mon, 23 Jun 2025 03:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2a5fsm140301635e9.34.2025.06.23.03.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 03:51:50 -0700 (PDT)
Date: Mon, 23 Jun 2025 10:51:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/12=5D_hw/i386/pc=5Fpiix=2Ec=3A_assume_p?=
 =?US-ASCII?Q?cmc-=3Epci=5Fenabled_is_alwa?=
 =?US-ASCII?Q?ys_false_in_pc=5Finit=5Fisa=28=29?=
In-Reply-To: <20250618112828.235087-11-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-11-mark.caveayland@nutanix.com>
Message-ID: <04FE3431-DAB9-4FDA-99C9-648A63C1D00B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 18=2E Juni 2025 11:27:15 UTC schrieb Mark Cave-Ayland <mark=2Ecaveaylan=
d@nutanix=2Ecom>:
>By definition PCI can never be enabled on an isapc machine so hardcode th=
e relevant values
>set via pcmc->pci_enabled=2E

The inverse should be true now for pc-i440fx, so a similar patch is needed=
 there as well=2E

Best regards,
Bernhard

>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecaveayland@nutanix=2Ecom>
>---
> hw/i386/pc_piix=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>index 03bd09f680=2E=2E279eab10ce 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -462,7 +462,7 @@ static void pc_init_isa(MachineState *machine)
>         }
>     }
>=20
>-    gsi_state =3D pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
>+    gsi_state =3D pc_gsi_create(&x86ms->gsi, false);
>=20
>     isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>                             &error_abort);
>@@ -483,7 +483,7 @@ static void pc_init_isa(MachineState *machine)
>         x86_register_ferr_irq(x86ms->gsi[13]);
>     }
>=20
>-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
>+    pc_vga_init(isa_bus, NULL);
>=20
>     /* init basic PC hardware */
>     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,


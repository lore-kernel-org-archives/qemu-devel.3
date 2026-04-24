Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693AAFED3D9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHwl-0007Wn-79; Fri, 24 Apr 2026 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGHwj-0007WZ-NX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:55:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGHwi-0006Yz-6V
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:55:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so5446221f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777042553; x=1777647353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sAoYJPbY9FIZ+jM/sV71aDZG1XRPYmzJyLJiM6Lq7ws=;
 b=Zz5v/A1Bkym69xN0K+Gp0e5ezfv+uYycvP7Ix6kuKhrn12QG8DT2K+00BwvXcd+GAr
 tuJLAXU52AXps00UN1gPX46b/cvW7ALzKLNtOoUl8PYLEDPl3pe3L/EmwWW4Ufkv4vAy
 3c/h7+IOi+cKF+dgM161EbleJmaMpzsF7jLlB0xdurhMbT/Lp6sqnDaM1a4WzFPnA/u7
 JJXMGH5upNRCOTDdINEwF+/wjGZFRq0XI2tWVTHiwxi2kPbwj/UzVXVAv7xzZGx5gvV9
 ib7uk8rw8THSWGiCFAoi3ORJS1+2ja6qcQIPIeY+qk50yKHc17u2EExnZFfuiy3H9Wjw
 OVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777042553; x=1777647353;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAoYJPbY9FIZ+jM/sV71aDZG1XRPYmzJyLJiM6Lq7ws=;
 b=QKah+u+oaS2YdMdp6tCBd7RNjRe++XrDFdEL+n+XG/rojA+aRQCfR6HBzPLxuF5EzR
 rdG1OdXWANL6KrHCC1FFhVr9rG++evphN7eFhD3CrOTtdhhJnboPeQlSskRNCVJ7mEuY
 U+ewhLwUG5UjrcHdoY3E8f57xJv25GZaNPuaefH7llE2zIlMLXiRSwVYwF4D6lVIlXGI
 IA4cEShzFzgf6W+VOG2FiuXUgUfWlwHIIE0B0vPV2gc+c12z5Cspk4dQPB5/03wsupeQ
 QSnhdU0XaY4/JMs461hYskdNGrp2mh3pYBQyw3zeF1mY5WXTIpaGCkP1hL4Ab4VmYrho
 68EA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/W84xkilBo/eAdEOEuW2JHrkWZHAVtpvb835KG/fOSffXuG1vpuo6N1rGSX3WfuPh7ShSHkbHxv8jo@nongnu.org
X-Gm-Message-State: AOJu0YycP/Mgi2a/2VtqqA69d8sRbTHKxMbBoVAaKCEEvFmp9+84wRiK
 XahVGr/2jHvum7198xzZ2KnGsZA8WKLTnXluoi3GoLWJRRi+AbMw4GpcP5yEITyPC5c=
X-Gm-Gg: AeBDieutEauoP6ZX0vIuc0iYpd3bIdV7emZZMgRg0SlzSf+pcWBdcyy1jw6a2//nArL
 S818kTRFyhVZ5STZsNbr6mhUc46HwBAoEr79J158oSaiKa3HO+4hRwXAMh8004as40o0Wmx/vXL
 buZpSCDLIVwPEZZoBm3iWCiQkw3AmQh6b5CI0TCwxCouNEch9Vxc5NlSRhH4WAFcRcBgBV8YYGO
 yYELhELFQHpagc/01smYBibt8yLAOU6di1hx+aSUVYrP/cZ9Q7l0uQJjJ4YgSKsPl3HQPAvgZbN
 zCVO2IcB4O+dMSfMVAkuHAV9ARYJ71m94JvB/ZMFt6NCsJMCFKQXjGLKSpQNNC+luKtZA/me47j
 6oXMBnQJTaoomkPK7Gcq+Ei73yl9ytUYMYO/q+bH8Kel2x+8cuHhlU0zOBRqnhoW73GLKch9f6i
 Z6iODVs+D7b1eWenMqi7iJTWBtw3BwZ6m2ew==
X-Received: by 2002:a05:6000:2f8a:b0:43d:9bb5:bda5 with SMTP id
 ffacd0b85a97d-43fe3e0ae25mr47785109f8f.40.1777042553120; 
 Fri, 24 Apr 2026 07:55:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm61966131f8f.10.2026.04.24.07.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:55:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 495405F7C7;
 Fri, 24 Apr 2026 15:55:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, Demi Marie
 Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 28/4/2026 agenda items?
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 24 Apr 2026 15:55:51 +0100
Message-ID: <874il05rwo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
28/04/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


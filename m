Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547C8C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpp1-00067y-Rf; Mon, 08 Jul 2024 10:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQpoz-00066i-My
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:58:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQpou-0000Co-Sz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:58:29 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso5952885a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720450703; x=1721055503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xRYWuK17PqCMu4JRVhkPrOPgxNMNXkRCGudvKJEjm2g=;
 b=CROGj/WWB0J7tYabKZfTq82uJ3An6siGmv2/EeJWW4i3ZZpeLFZ4CczIyzf5jKWS4E
 cbS34SO7BDBmAwwsl8+tlwS/U0UnlAthKazKG9Wyb/ZG5rTMESSkAguIzV7Lv0lSKvTv
 4BONI7cp3oLdnuwMeuNm0omWn8z9rmOaB8Z8YfGnulj3j9ByKx1NdCipOHE074c53K5s
 GlKJO4UcxXRYWGlgzcC0/GW2at9963KEmUUC1miqLXa/39JhNaRA/rSuM+1cNR8eaUli
 pl7m5APwcrz2kmgj08CkbqMLgAEoiP8OTqpv5XHPzAzvwBjmTRHYiOrZVhnxt0EHPlDD
 f81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720450703; x=1721055503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRYWuK17PqCMu4JRVhkPrOPgxNMNXkRCGudvKJEjm2g=;
 b=MYUw7c6qYW4/5lyVMLNh3B7KmkNOksQCkqp0/o1VVLj8XahEKl6pyrahcr2E2uEQsS
 jx8qTmLHGDKio1OXCv2OzSy1l8wqp41Pn3dq5OclliVpVp1Vd/WgdprKlIrszp+CLo60
 OIOMpXT4bxKAvP/QGmByCrUmOp7ocBq4/7fehACyfqWZX0gmxwpHGs0XrhIuTXWS9CIz
 34uZ5H8PjvvcoBDqINuFFH/cr+TWQtmkCx0ugQDScetDxE3jAbferzBoKjsHYjw0V3Bv
 lCMNUDCfwe1sarWAtLu8xUR2xX92HQrlPdPg1sTqJHqZDyzcNBa8ZOSDH267AW61ZcVZ
 bWWQ==
X-Gm-Message-State: AOJu0Yyu7TIv7LpeoK5kbwLtgwd9MPdx01v4xC/9MhpvSQAAx9e/Dhiu
 daCx5a14aadQZfYEYkeafQngY1QdYPWqr/Fg/ZQofqVKg5j5wcGyObbPKZZW1ik=
X-Google-Smtp-Source: AGHT+IFz9n8qh3XDUDmudiQwZwMK+hLfomgnukuAgwJRI42LzOfitLuk55G74LdKSw42K1cy7VmuHA==
X-Received: by 2002:a05:6402:518f:b0:58d:5562:2c36 with SMTP id
 4fb4d7f45d1cf-58e55f9e91bmr8964946a12.0.1720450702866; 
 Mon, 08 Jul 2024 07:58:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58b4a97b1f3sm8195170a12.18.2024.07.08.07.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 07:58:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 339DD5F7A1;
 Mon,  8 Jul 2024 15:58:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Andreas Faerber <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson
 <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel
 <luc@lmichel.fr>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang
 <wei.w.wang@intel.com>, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: QEMU Community Call Agenda Items (July 8th, 2024)
Date: Mon, 08 Jul 2024 15:58:21 +0100
Message-ID: <87cynoszg2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Hi,

The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  8/7/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


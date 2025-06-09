Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC4DC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaYW-0003tc-Mj; Mon, 09 Jun 2025 07:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uOaYR-0003t6-GT
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:20:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uOaYK-0000Kd-5L
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:20:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-607ea238c37so2469407a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749468027; x=1750072827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hbAFR8dpaT+tpvYJJV6xvVeGuw82jyaWwAlg0j/xdgQ=;
 b=l7RJrZ/1NFhGGk0Bs55gJvS/QOjY8RLSqmvO0ShWmB332rH8vjGcpb0JGEw3ZlgFex
 OokYsMfCx4Z+7yC0CsN4x13hbEUqZMHeG1Zky71Oa/mbjR/tNsgDtu9573psv7nFJDQQ
 Uh/ZbU5+Jh0icqLLt9dN8jCOsNwM8Fbkkgs805aZMRCBQgg9H3Y+pwry0hVFc3ERQgpn
 ozrtfrMMoamlAGBASWL7mjjfB/XWJqQtZVXUDD/IGcnadUzUybhYgvg1EJB/kv6Hy8BQ
 sswsZRAnX2wMJycXgggFCKNxODC1/vkQV9e3FqGY/EDZ5wlvyVvY17J5SslIkwA32CZC
 0l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749468027; x=1750072827;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbAFR8dpaT+tpvYJJV6xvVeGuw82jyaWwAlg0j/xdgQ=;
 b=jVd2mKAm24smkxo+NShq9qEqUgX5mryxzkUH5rlSoG1BcGFbMKOrYN+2L5JU5ulqr0
 REc7YZ79jwYrl7aSD7Z6buYKT2qtHEQ6gP5PAX26nxRNDKaNDXoedpAMDOJ4jU0/GnOM
 GLKmezYtPiDa5e/Krq2azz6OSv16d9fcM9uan4BpYhYkIgHxlBsUWixRpIXA/158987X
 DIbMN/J861LYBz9CQY2ZxTNWPa4dNhPuxd6VQqroZvlZ2HeXrp/Or6tQL6LH4nNYpmKJ
 z//Rt8QhE3EdVIFQAozcINOR+ltSV+h0SbtvPV5r7veW1xoah5na6ZCLVmK40o0c5LV6
 L6HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOk8wa0ynT8YJudOaStOtTv6DrVLDzwUcHeROc+NVe3p8Efdv0LFcsG21LQtL56cpuY0fMaw9CI7X/@nongnu.org
X-Gm-Message-State: AOJu0YwKKo8YL9cxZIJxtAXSYQGytFLLRpXvSU++cYg52Noxidz9NAuu
 bdWx/y0Axz3M2zOU78QbqKEn34HL+RqLOfPG4hGGTu5WZ3CQEERL5PMuRv7niLVqcjI=
X-Gm-Gg: ASbGncuJDYXQ2U2nfQxQBno3sd6g82Byoi58eSyvCKtIDGOhAxpHLGBSqWskcADtT+R
 lOqUTQYQgyCGjBG3QMACwdurGEGDzzu0yA2nZd8Ljezv2ZRuhOoC/I3NMj14e3KDKBGYMzuIXNm
 o3/z2wZNmt6N9DjLn8bkhH82MXGrsVs/Q2Uaeak7DJNlbw9V+EI+23FlP6c7/RiL0Yrf+iZJ6A2
 T0Ud9q9mys+QsO+tsr0kMdEn8YjNvZFXP962uP4v0aOY3xnY1TiHqk/c+3DKpwZEDos7s/qV+1E
 yPJBLx1qODGs92TeTSRMkhlDwTar5w82g1llNkY2TdBUuLouACYAf2IHN/5vhZs=
X-Google-Smtp-Source: AGHT+IHZVmgI4IKHWWtmMlwcw1eNDH1cDX5+KYsVVEHoXhImXYh3Yz3KliZtU6Vc/FbtKaobxq8u7g==
X-Received: by 2002:a05:6402:1ed4:b0:606:f7bf:86f3 with SMTP id
 4fb4d7f45d1cf-607735120e8mr10695357a12.6.1749468026909; 
 Mon, 09 Jun 2025 04:20:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783dd48esm4469676a12.56.2025.06.09.04.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 04:20:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D0CF5F8A4;
 Mon, 09 Jun 2025 12:20:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 10/06/2025 agenda items?
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 09 Jun 2025 12:20:21 +0100
Message-ID: <87qzztkvpm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
10/06/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0239E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtgE-0002XX-KI; Mon, 02 Feb 2026 08:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmtgC-0002Ut-Lk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:09:24 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmtgA-0004bU-T7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:09:24 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b883c8dfb00so1043957166b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770037761; x=1770642561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwNmnOPM47yFnPGhN9CfJoe+VCQ/lPUd3PMcU6JWptc=;
 b=g/xul0TfTMrZOuNBd5FXqt44pr85w4H0342bLGNJ3JeHBk9pHBYRO6Kwi4J8v3BESW
 Y1vmIAmbZJUSSPd86+Zz/3gQiqE+ZKBGhb+WfWYcmlHgvEGN0W1BeTj+ZZHgzepKdpn4
 TQPeqXOLp2U9KmfXFWPZkgYZ2MrkJPX3DefCebLmecdHe+OSrdwMX6frMgeIzJUzbh74
 bYTQl8GnoYY6ZK0ZXzMTIcpFR4KYVWRZDsqH1DzsWG1Jkgd5yywn27CtDjTS982Wr8mI
 zv0xqRwudKsDIvYbiokQuPDQiU+aWP1PXHFEsT1j8TXMkBl3j0xFwq4VOP0mXQPimCl6
 qayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770037761; x=1770642561;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwNmnOPM47yFnPGhN9CfJoe+VCQ/lPUd3PMcU6JWptc=;
 b=qrY+54XyQeutH3Uzx8qtfJZdjsV+vKb/IFKheaB9udy/dgYs68eaBADYPhH8xfjYhE
 Go6jg4J2L97bkNlA3vFuDDadlKNf7c9ZJhlbkN0hkQBFTZeRWtT4V5QK0+T/I0DqRBG9
 J6lfdScRmlBsAG8etajVDfEGXppLXpqgAOX0RBcW1uJVX0eeGIRDDYA16pTAdgv7Dty8
 v63vKKDSb9Ido0i2+FZDKji0v+2DMP0o50SXRJTcxovYPjv/rNfNzyvw6lFukpA0u5en
 TVTJeGXl4ExbFKSoXVXwVrrJpLZGt+Rlp0FJM3xCvcDMKytufSbBqm1gr8CUnZxaeAPc
 Qw3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7KD4Qcpp43e8Xhqd2GtUY7+Fe80g3qHiDCxyks1Sh26jCapbIJdNjnpccc1tdpgVW86D94L65cOw@nongnu.org
X-Gm-Message-State: AOJu0YyB/2uAe1T34XWW3jlHw64EMgsMrzKau+LxVmkDPK/8XCnFYCoz
 CSWwufD4qjhJrZED5s/1c374Iu9N4SAM9ccjqyV+opz4BFDjqIIp6YNGUeE67o3nsUA=
X-Gm-Gg: AZuq6aJ2iJKaMQLX1CaL0yTlmkGosCLFQ3xMXLeKFFmLax0NAv7Q8A319ulspQSNQll
 9R6MY7uslMGtuHQbxUG6C5ZBGlk9Miz42Tp1hAFSerqGw2NpFclZ2vW7yBvfSQUvT1Lf4X81YRt
 PD8xwzq8AMKuFKwWW3epQm7rHFIj1yPigjZtwDQaO72Jv8UMEfVNFlLdg4lwVAIla6E6JZRqs5c
 GNbKU/z66vnxrX/oOkUnFPXegieedbUJ3qDb7CdfNvLEBf57B+1a0PMNjDK8pVgB0fMVs5XAEzc
 W87R2rKVu3ZTyF5sgkmO5fQDK55+MtvGNd0nrubc3RCng3Oj48qs89a/YzGof2iam7C9+ubzDQa
 riY0dzflSbcTab9MnY2Rc0ybPGurZiX2awuB1vkTyC50MC/17SMkdgT56GVUvuWcVter2P4vytu
 mPnbnkWM8ZeSM=
X-Received: by 2002:a17:907:1c19:b0:b8d:bcea:438 with SMTP id
 a640c23a62f3a-b8dff6df73bmr804570766b.44.1770037760089; 
 Mon, 02 Feb 2026 05:09:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8ddcc71f56sm739956766b.11.2026.02.02.05.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:09:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 856445F7D8;
 Mon, 02 Feb 2026 13:09:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community call (3/2/26) agenda items?
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 02 Feb 2026 13:09:18 +0000
Message-ID: <875x8fpa0x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
03/02/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


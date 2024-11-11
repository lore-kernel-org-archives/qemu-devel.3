Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0FD2E9DC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASaa-0008WJ-6X; Mon, 11 Nov 2024 06:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tASaX-0008W2-Lo
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:28:09 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tASaV-0003Yl-O3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:28:09 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso5994516a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731324485; x=1731929285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q2NB6/0VsmMMh+6mc17Mu+mQRNIWduqptGhk1VGyML0=;
 b=r/QdLARThFlzkpyzw7TSty71qtjtVmEgxYg/YKuVNW3AG5NPi31cRpWgLG9MtMbopL
 uUVIciTrj/rxOI/CbucrSU+qAz6fiUUGc7emUaQI1U0EMxPYUbGIQPEgHnaM501UFh0j
 0NaHYV+HzS2oofrbSzgjC26Z1oNMsgethzOjlqK3y8nJ+9Rhj43YZWbOCNqBuejGyl6z
 Kq1PdEzAk4pUxWoUd1qTFSU7RaHA9tboaMdyCNs6VsIQEjrObr4iWvlH44YMJWIa0/3s
 VQIysCjB4tf9H6HOi186nm2x1IYKKHc5pDf10g36TI2zFK+e5d+f/4yj5jlxn+FZ77NP
 c8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731324485; x=1731929285;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2NB6/0VsmMMh+6mc17Mu+mQRNIWduqptGhk1VGyML0=;
 b=IKQmAXDURkCFVoso28OqM4Rxh9NpJeKnlCVoyi3ZhH93wmIjhFJARc8/9rxQZUvZQA
 WYm9ffELeXVFfyvkphPsBEO0vIZghsO47wq8ILc/GmqN8RAqv/I7G7rnPcPWjor4NgWp
 Q15Wk+Bwohi/gxXMb7G8TZGrZNSvM9CSCJM0gUH05dgbUaQhRaPXyQWnavFNuizU6gLP
 SRCkxKqIMvO+xKSAakh4HrgzgHNXfKfxAo83Tq2kX/QL/JQSlN8Dgl9X2bWgmfAW9Psk
 Jm1C3GzVZgIUIvN786ZSBZFWHWqGTZw4OO2Ghw/mBnLf9KwNGcyk6oI83/HeKKC8kaKv
 zolQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/bLaD9b7/yTRv3OI7ugNdZ5Iulgu8oYszlVE6IeMC71tXEae51TEUKhoJxtjYnqU69SWMJhl4xCnZ@nongnu.org
X-Gm-Message-State: AOJu0YyRK4xJs/smT03Ds5aC1X9pkkA58GNNqogEXLvTKkKIWdxj3sFq
 FtSP0V6u9f5drUdgO1mw2T5I71lJ5oGtmXR0wcu05j4Ax/zjf/rsuhWzk2c1noc=
X-Google-Smtp-Source: AGHT+IH8geHOPXutfANDTLKpowiwHm+FMjuvp+wufyQVPacZtIJtTbYZhdUhSCuP25WjouAXPyEmxQ==
X-Received: by 2002:aa7:c444:0:b0:5c9:76ca:705b with SMTP id
 4fb4d7f45d1cf-5cf0a478e7dmr8859563a12.34.1731324485274; 
 Mon, 11 Nov 2024 03:28:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b7f680sm4816053a12.35.2024.11.11.03.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 03:28:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 800695FA09;
 Mon, 11 Nov 2024 11:28:03 +0000 (GMT)
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
 mimu@linux.vnet.ibm.com, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 12/11/2024 agenda items
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 11 Nov 2024 11:28:03 +0000
Message-ID: <87y11qovr0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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
12/11/2024 14:00 UTC

So far I have the following agenda items:

  - Rust next steps and merging strategy (Paolo/Manos)
  - Rust as a device API (Mark)

Anything else?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


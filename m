Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A06CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBkc-0006Iy-Cl; Tue, 23 Jul 2024 05:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWBka-00068M-Ir
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:24:04 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWBkY-0005Tf-Pi
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:24:04 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so4853266a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721726641; x=1722331441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4bOERTlCFPOnaRSpw2y6UWoUBnn4SY6N9SkCbwpnLYc=;
 b=WcZnFetcIDMB8wwSWBbYWggclBoVCKnqG7RxPn2YPevreGG/JHF/r7/+nE8E/EUOkx
 0e9bCBrqka0isCZIzUfOVtpOtWBM9f/8v5GCP7IkwYfYXTD31EJO1LLfBg/Qs3s201q5
 5IzLW/U6iUxSwF2LB9Cm8roI3vfT6/47nDsm8d+xmO8abmccH9aGfhCtZiH+HHYsjNYn
 9G/nVUNNsN5qbe/rjFCNiBtsRzqY2p9jI/t1sql/D5qUlr5gTTD2ITW0rVTm/lrt1+FR
 D5RkMGDQ8M7XImxB8TFGPEvIm/gmwj5qDeir9hws0jvFFGwxVWxnCT3veCZUINN8g0H9
 cWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721726641; x=1722331441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bOERTlCFPOnaRSpw2y6UWoUBnn4SY6N9SkCbwpnLYc=;
 b=brTqGvb6ISNPchAbjXsQuy8ELlE49iU6GTfqXYT9S0nh0VOYvvsiyhtImx3jKTZJG9
 nLbcEriUNZCvmuLrTebMDhCNPiIUGoeSRwDoNh8hf1EH2UnaDW8dQIRubc04aaCV/sDu
 2Ln+NGBJF7arxWoPSfi90dbv05kDV4hLAjz7T9ffsDAwI/KXfYjQ1Wl7Wbhh9Cb0E8Du
 kCg3kw4cs++rgs2bJqTu39FW3nnEJBdGOWg/gw47cYB0xK4Q8hkx2+69PTCx8pj0rrX1
 Rj4ZgTLaJD9tKSXZQRmq4zvldzhJnW8YeXFwKNS1yHPs3k9+HKsLLmSrecxPIy433h+P
 V1lA==
X-Gm-Message-State: AOJu0Yy9AmgIE4JzucnbEWgc3hgdj41T7NKGLdDQm3zrLoNFw7Z1DV/7
 fXk9FuIUxLEqgJ3xSfJfp640zAUKFBQqHC0oZo6Pkw9drA18KMgSDNZg6TPoeQg=
X-Google-Smtp-Source: AGHT+IEAtB2KRrxMyuDppIoiXk4q9eCx8DkZrgvFnaFd6GweoWBuesy0nHDf0MV+JJhwYFH+Y1PENg==
X-Received: by 2002:a50:cdd8:0:b0:58d:81ac:ea90 with SMTP id
 4fb4d7f45d1cf-5a943cf6ed9mr1208548a12.38.1721726640503; 
 Tue, 23 Jul 2024 02:24:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f87d1sm7285974a12.70.2024.07.23.02.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 02:23:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D295B5F931;
 Tue, 23 Jul 2024 10:23:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU devel <qemu-devel@nongnu.org>, #@draig.linaro.org
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
Subject: QEMU Community Call Agenda Items (July 23rd, 2024)
Date: Tue, 23 Jul 2024 10:23:58 +0100
Message-ID: <87ed7kxxzl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
23/07/2024 14:00 UTC

Unfortunately I won't be able to make it to chair but everyone on the
invite list should be able to start the call and edit the notes (see
link in the invite).

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


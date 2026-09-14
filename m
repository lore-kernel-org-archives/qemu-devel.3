Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45679C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68S0-00042q-Ex; Mon, 14 Sep 2026 11:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x68Ru-00041x-Mp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:26 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x68Rs-0002CQ-VV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:26 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso26002935e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789399103; x=1790003903; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fvOXAzZbmxL8ZIngJVpa41ewlC3JCUiLWJ8uo908XFg=;
 b=YZq/+sMFuBbp5B2bqINUC8bt2glkvYA7LzMCNS1fDB/pKFKk+DgPg11C/qtxo94oox
 s7VDQSIBbKwcTKuFgOsYX7Cgp0WBTiO2mKJaBSy3WQ/IGoGdP1QSvW3AqatQIN6/7x+4
 KNRGgLSCIdXZqmTvbwfi3qC2/l6xn7Sca6wCmLffd6d6rO426O852dx5N/3eXt5Lwfn0
 D1KnwhChH28eB4Cyw/PEEDHSEAHZqsr6KI3v4wBMXNM4jLcaZ6qt3uoBlyAOyI8pDpmR
 7JCObFbN+8XdxBm+narQx4846lZ6xOdlhrvi1KSDsNDr8WT3xWCyO8pJQzBAjdKkTZDQ
 tvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789399103; x=1790003903;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fvOXAzZbmxL8ZIngJVpa41ewlC3JCUiLWJ8uo908XFg=;
 b=HI0YeBUpjLpjKX1yGLFaeuQJW3XnkAHmfJ/HyxOgFL9Opx5vcSre5twaawDZ99gABh
 okwIBg2sHPwJ65SwvZiSebt9XE211uWOByQcdVk9iJhFX6tdGA4qOKoRy7I+ryeEV7zM
 OtgjpXcAdBxbqSTxm5qX2PHIa54HpuebIcWT+/QeXm8+EXNbTqo1VWEbUhkWb6msQAhe
 ifm6yEKVWV31LcN8xrAX+ScUTQs4YC9HPpBtOFORsNXSruJ0GXU7aQTALHjW7qjMA0WR
 5fUoQHzWHdbG+ac2R0KolDslXL5N5zadg+VhWWzFzU33Qefydg+Nq02/P50ei784g3ZF
 0Y6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ5rdWPUVlrJX6pLHwEGDkRVcWibOnotOKk/FS6KwFhPZSeJT1fLZoxl1e587doewCNPqr4BCMAMT9@nongnu.org
X-Gm-Message-State: AFuF++nsprVnHZdTGdWDQfnvMBt4kO2xzwncRrW2t4yYtu9pI5B1RkJ1
 ngxy1kCXClmgwSkveAEg82Re6aVSZyFK64G7mBF7lBpcc9IvdcF6UkwqOcJ3IDRJQd0=
X-Gm-Gg: AYBFou2/amcQLq3k5wPIz3ikIxSTE5uGJcl4gnlPatSPCHMLy0I1esgNRm++kZiLKmT
 N/W0RTqghQkTm9Od2HbqFWqNRm/btogX+d6YxmiJsBGXsg3/V7axU5UELpAbtvpeXxbVBMV9DYS
 kDYILX5cZ+bObWx63+XKquQMmnZtMhjiXKI5qq6THPYoIWrg10awAjAsmYdbuZJ0NhTwmqTHXZf
 WO0Fvb00gKY3M0WfCCVC5mkNg6zy+EQ++6t+MNkyxYTLf6z+yyHadhZi2d1UDPAXaFfL6d0nasH
 f/vGCGd9TxBcofXNWLGmldQpUkiHXHcxdsYnxEAsbxq9fa/+Oy5XvZgiSZZd8iEgVcJD29nMI0z
 7OKXPBfYIDhDc/BdES0gFnE3DgnIhWc4hzM5rvCCyz2nujnIJgJsxqYsCWNZ3t1yvtCb55xuoCN
 4FDkHjf7s5K1R19uihFPzx71oA3AcOBuHJn/rHD91TwfaX0vKRp4nrVjtRd+4I6qLMoePeXzI=
X-Received: by 2002:a05:600c:138f:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49e7a5ede89mr57072335e9.0.1789399103312; 
 Mon, 14 Sep 2026 08:18:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e636f7fa2sm326497745e9.15.2026.09.14.08.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:18:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 306745F81D;
 Mon, 14 Sep 2026 16:18:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: KVM/QEMU community call tomorrow - call for agenda items
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Mon, 14 Sep 2026 16:18:21 +0100
Message-ID: <87ik47dfpe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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
15/09/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


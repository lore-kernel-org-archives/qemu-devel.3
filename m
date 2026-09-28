Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C498DC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB5z6-0004x0-8w; Mon, 28 Sep 2026 03:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xB5z3-0004wm-2F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:41:09 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xB5z1-0004nv-Df
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:41:08 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so20807085e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790581263; x=1791186063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N5nZcyq5gupAF8IpYrjIiOMzkCSMgwxI08D4OrVWZRo=;
 b=FdH4y15/kYHGwNfvdNgJyMwYg3qbSjW6wVlob3GoAgAnmpiSh7hrkVnBqvcaepS1Oo
 HEJqUysysVv9EJYrMkqMx2CVHbzgDd1UWL8Is+arBhUAsSHAjIBU6qHgwIuy8HEx/HtK
 n3U18UOOWgReHXvHJE5yCdfJbMYv/LGFouSWg/aQ2oFmwZWuYU4+LV61o1l/E2eaqYdI
 fCmTGJZ9uScVSdBkPUY6SHp4ZXFbUNWuBZAcxollYw9GrSsK8kqgVVvTTZMHaIaSGXyy
 ELzi1YrBdK09jGfxS7L1nwfrY/ncJHjQF9DIB3x5/aaSflnSvnIJ1j2u0YO1TELyP4cO
 gSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790581263; x=1791186063;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5nZcyq5gupAF8IpYrjIiOMzkCSMgwxI08D4OrVWZRo=;
 b=VieRpPiCMYUVJveH3MlvlG4Q4DgC2jB3+HM7bPIxdjmtN8KAJJjGMF0Q1iAZ1odz4T
 4mp0GqfJokU++flJ0WwgoVterXcMN/elyzlDhYAbP29vFgsDSDaBGR2dDaIgl/sSbK4F
 ujYVxzCsLRPY+ZFQ7jntA0SOuQXwU5WJenbG808blRN1z/ulbznlkd00F+OjLUDJdtcO
 IJf+wlzEoXjAbFANXoXLnSf5GIspo3Mst7RC3Rhwa79y5rxqqASK9kROaXLCCtovuzAW
 OMaxsZDhupaWER2a4XqP+Zq7ybpvoxmec0RI9jfod8wCzfTNUWczRfSQePT7aFwXWPKI
 C39g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy535tpDNjVsNEA2vRnHZh+3bTZnLPnyL15LoDEhuKefK8jXlzyWk7l+Nuu4mtNUzkszYR3Cff7RK1E@nongnu.org
X-Gm-Message-State: AFuF++lt2XnLWE97+gcW2bbvzGTGA3Ck4qWadb2GmuZ0sbBsYtJbyIAy
 Af7uFoBfuhFC+yHwxzQII4L4x+C4DLiz6AvHXEHjbop5O04X0+e7VyibtrGkkvwXKbI=
X-Gm-Gg: AYBFou3C2ptHgYAJbmcuZohGgPSGqFH/51tFqOiZu/vXTKqv0GLgf5RJRq03LBFHKRL
 MGWrDVONC7t3ruz0MI2XFn9Y+Kbp0aUsrB07Ta8gIwQmW9k3BV7zruzLRawuHKZ0T1oj8W5E3pu
 6aSDG9orL3aRBHJjYbnVojLCcsrYHaD+1/w7AYNqoJ/prB9lOapeLeAVayHAgOwP3gGlyoZQ9aN
 S5avtsE9B/zu7JKz0G9Js0B9gjoVZlAXT4Qlmj0/HhdMDebSS43XCQB1sdMK7ZqnII/b2R7j9GW
 35hPwinmi+DK92nnxbRe5aQx7jCyRuwbhoXMySCzSAzzYlAVBSojJjlsfvoUkdQiM87clNxdXg1
 M3UdM/l12EnsAtQu3MIh8XgxNci1ezAzT3NTewifeXVucNMuF0i+5IAWuJPq1G7WI5Y3205EyAq
 vAphE9fr33fbXG32wfuVjn1kWtHgCp7Wh42NXXf7L0mukkPcYYqOt5utNMuetRzK5ANbh9ew==
X-Received: by 2002:a05:600c:3111:b0:49f:fdca:c34d with SMTP id
 5b1f17b1804b1-49ffdcac53bmr87941535e9.8.1790581263316; 
 Mon, 28 Sep 2026 00:41:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3627a8sm27743747f8f.23.2026.09.28.00.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 00:41:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC7655F832;
 Mon, 28 Sep 2026 08:41:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: aesteve@redhat.com, afaria@redhat.com, ale@rev.ng, Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>, alistair.francis@wdc.com, anjo@rev.ng,
 armbru@redhat.com, bcain@quicinc.com, berrange@redhat.com,
 chao.p.peng@linux.intel.com, cjia@nvidia.com, clg@redhat.com, Chris
 Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com, demiobenour@gmail.com,
 dhedde@kalrayinc.com, eblake@redhat.com, eblot@rivosinc.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net, elena.ufimtseva@oracle.com,
 eric.auger@redhat.com, felipe@nutanix.com, helge.deller@googlemail.com,
 hi@alyssa.is, iggy@theiggy.com, imp@bsdimp.com, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, jgg@nvidia.com, jidong.xiao@gmail.com,
 jim.shu@sifive.com, joao.m.martins@oracle.com, konrad.wilk@oracle.com,
 luc@lmichel.fr, manos.pitsidianakis@linaro.org,
 marcandre.lureau@gmail.com, matthieu@minio.io, max.chou@sifive.com,
 mburton@qti.qualcomm.com, nelson.ho@windriver.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, rbc@meta.com,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shentey@gmail.com, Stefan Hajnoczi <stefanha@gmail.com>, thuth@redhat.com,
 utsingh@redhat.com, wei.w.wang@intel.com, z.huo@139.com,
 zhiwei_liu@linux.alibaba.com, zwu.kernel@gmail.com
Subject: KVM/QEMU community call agenda items? (29/9 @ 14:00 UTC)
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 28 Sep 2026 08:41:00 +0100
Message-ID: <87zex1zuur.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
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
29/09/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


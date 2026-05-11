Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A506CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNKo-0006Ye-Mn; Mon, 11 May 2026 05:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMNK4-0005tW-SK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:53:17 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMNK3-0004ai-1O
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:53:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so3791368f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778493189; x=1779097989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYX8i4zkLNSF9eGrbBQO+nE0WQHxjA6s1hqkPcogq0E=;
 b=t11DbCmYHW2vU7R5XWtWGmPkQqKxrknlnoScsST8qJc+MnwfrnnZaZj7wCOqLD4l9Y
 EKUk5CC+DA9ayT6pjaQFkacWip9gFcSWpQsAydaTz9QBv/7tPKFHrCYxDW781tNlawcr
 nVJi3/047J+dpvEDDgbDZN6JdirFyELn7ZXoMYPttAMzO+zKGYWCAcVgwPHNS6JjoC3s
 pj0nKb48ee8teKRAWJpP48ANH1Ur9cYohuD8kCkLmZ5ooz1SKSVR6XhhfRRKkI+NFLlx
 MzP1YApzIJVaTGeNkKPISUE70nqvbOdS8Z4+925Ujxbb//omQy2oYrVDeMJH2SvUYCQ1
 db3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493189; x=1779097989;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYX8i4zkLNSF9eGrbBQO+nE0WQHxjA6s1hqkPcogq0E=;
 b=H8RLu7Yy9fkHaJnhGJGxsJtvRPLTFOao0E8DOLZi/NbrS+Gd7x7z0JXAv36oz5g1D3
 9vYmwqAyDRE5H4jT6jnT0IQpNyv2KVRk+mkK/NT5BWYYnKe5xFkw8TZFGlNVsH5wEMQv
 6v3/lnYu+gcu13s3YqDV+vsa/ZBT+7jFuKI0MVwGaXYsY9sy7jcUYTyVbSXjrSxY/LBS
 bpo8tSLvC5u8qQXr5xy8Qk7paQHHcGOIWJAhxUs8Sxrddx4HBN1gdI5K5BZ4KnyvLK5j
 ZzDyPpXMggXl1UZFLnysLsBQoBLA0DRc8XvJTko9PF2MSZMtpbjiry0hVzoHTnzssjo0
 sKlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Lo5MsgbsTTFfeh7ZGGDWTCgWDkRQkdwnd6GDV/BM2N+6gBypU+lC1TWlmKiCmlLchl0lNAxfxXUxU@nongnu.org
X-Gm-Message-State: AOJu0YwjCEeiHYizLd5uyemXgQKXGK3PFZyDUQduLxU032P4SxpjmKr5
 di8Ny+hRcBxULyLxdLaeGkH33w2X0J2q0PovBLFcFFWhr1MfJT+PL9CkogSVIO+2V5c=
X-Gm-Gg: Acq92OE7D7h8Hki/Bk2eLXuZlfAY3lRH1CQiZKkQpHzDYbeMF3fHoeOfBYedyofKIGX
 9jgPU1zXEAy1cjJMrfLDeEdIle/EFhClQ98efL5M3KDUkJN5LXzeXVo2noUJ0/ZT1LB2ke4fkNZ
 1a7+eUDwF7Zx/wxWa87rpQDl+eqPL3smt1y7VA6pyn18JofDO1Sj+uMPPv4rLLZAtOzoIf8PyeQ
 WoVkuEOYmtE3uc9V3M8+cMu/N/tFXs02R0Tiwxs77ZtRtwzSKUO1elYjSzH/EPva8u2nHQC2bnR
 JTsB+1lZN/XhrqypZOLyhwYKvmhhBdLDTWuNtABHNEnUILdbbXXH/FyJUhc94LO37EfxEfHe7F0
 Yx5mcrOg7GQqu/3LFmn3KlKMkjFE36eIakUmSxZx9T07fBAK5sx1CMZ4he6SM0DA4MaUQ8hVHR3
 SSU2Ain+1P2ysph9/NSAcabDgvwNqqxAg1Lg==
X-Received: by 2002:a05:6000:4210:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-4515ce1c6b0mr37226637f8f.23.1778493188427; 
 Mon, 11 May 2026 02:53:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6be40sm25694158f8f.12.2026.05.11.02.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 02:53:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C61E45F838;
 Mon, 11 May 2026 10:53:06 +0100 (BST)
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
Subject: KVM/QEMU community call @ 12/05/2026 14:00 agenda items?
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 11 May 2026 10:53:06 +0100
Message-ID: <87tssew9vh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
12/05/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90073C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq7A-0007qC-Cu; Tue, 27 May 2025 04:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJq6w-0007ms-FA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:56:40 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJq6u-0002cc-Ck
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:56:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6045e69c9a8so3782066a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748336192; x=1748940992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p6+CwtoaTw/Tv/5Nn2fZkJAsQIZSZLxVYxAanr8wvck=;
 b=CchMo2nib2/u4nTmBzB0HMp5Qeq0qMwYgOiFPljS7LRV6ev658EpXuU7NNQXtKqpSj
 qS6D2218zCbY8C8XTJsV++LihyH4jM3KuQT4mU7sz+BQwHqZ+Rl3nLhHQ33dVysqpDIf
 Dz/xYrlaqg/e89f5FjPqitTgn7ErwqQacvrpI/ZhBGZy93dE8GK8bFwegaYoP+AZAHbI
 P3KZBx7wSjgVnd3kI46KQ+m2cLeR4WWRBn5fkLa67YoezzClCrqQrklWHoYYGe/skb3D
 sUd2VUPB3Z1bmJuUFfs65llAfoQLB9702f6YlaxWEOFlMP5jDH3AYouUDt9CvdyaNrSQ
 vKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336192; x=1748940992;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6+CwtoaTw/Tv/5Nn2fZkJAsQIZSZLxVYxAanr8wvck=;
 b=rILNeV7VeIm7UscQBQU8xLCL1zOSQ/xP+Qr5x+RATOrA0x/u/K0S1KfaH4TOt96+LD
 uZ512OkjHq3FIYi9QHzaEgxzVbCyoQaUU1VU5IhwMEI30Nxz6yJAgZZPoHN5LUvAlHo+
 xA6wGmCtweK2g1AHfOQ6LWN0RoFoWmXSAORgIRRkzb4C88SOq62X1h2GZkPreZKIEIdf
 s0SqB3/JbQuk1AplLCy3YULyex8vAukJ7b34bSswG6lEgOlq48pshs6TwoFsnxDjDQR+
 sPMj5upxVEcT/cxBF/1UfE8iGO2d8pDdlK9G6l+9ss5olucaHcPxxxRYZ/CYW1LV3JAH
 kazw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmF2vVq/PRGGXwjyjjJTs59nRhIeQCEf0CU7KsoEYYz95AIsPPABJLklz3sDGMAL1eXMWe9d0e+tw@nongnu.org
X-Gm-Message-State: AOJu0Yyw67S7z1aPmGeaSF7r53lCOY6YYojjxTt7iTV0J1HBbYUMezyh
 h20ugpUXnh6EVIn7ZSy27WAuvP4ZoPk1YZ73ctHdpBCzfbZ01ymVqFVagDEBF6BfXPw=
X-Gm-Gg: ASbGncuohL0uH87TmO/9lcl79i6CrschzZQjj5LvNkXG5R0Ms/eg9tl9MTq4xUQTxKs
 SgB+rx8J64le9fGUmN31Jf2EXHmv0snS+5BxTnNbrR24Q7mSv5xKZYY0iggyalRr6vtyBZl0YLZ
 8x1prR7F0hjEvEzYOuxNl4CytX0cxwgtfOO0sjxnhcGtGLf8mS50zu8vwp5slIewDh/ppfYfkud
 OsryA8TYHmNYEzCx8AF2RmTJsoFYDJEH+rhMMYpEWK4TSnWYGLUGt2OO65YPkqRzxlA6xaia3vr
 hHRPhrtzrxiRlTYV0j7V3UYmTUWpWzcpQHwXqUQ6L6UHuBfthwyh
X-Google-Smtp-Source: AGHT+IFsnZOgDDrSRnp8xE6/xrvw3s5VtuvyrrvirL0t/MSbBuH4kpj/oZtH8xbxFBPR9te0Cu4KIg==
X-Received: by 2002:a17:907:8dcb:b0:ad2:5499:7599 with SMTP id
 a640c23a62f3a-ad85b0d2777mr1056928066b.18.1748336192567; 
 Tue, 27 May 2025 01:56:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60456b448a5sm4180724a12.81.2025.05.27.01.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 01:56:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EDD95F80B;
 Tue, 27 May 2025 09:56:31 +0100 (BST)
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
Subject: KVM/QEMU community call today @ 14:00 UTC
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 27 May 2025 09:56:31 +0100
Message-ID: <87cybuo2io.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

I forgot to send this yesterday due to local bank holidays, anyway the
KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
27/05/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


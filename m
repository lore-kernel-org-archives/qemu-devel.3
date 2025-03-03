Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0063AC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6C3-0007OX-Bu; Mon, 03 Mar 2025 08:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tp6Bo-0007Dz-FK
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:50:39 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tp6Bm-0003TM-Id
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:50:36 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e535d16180so1843655a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741009832; x=1741614632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EhHrZGEZ3gZn2e+I/2gT92Wo21OEVkxHllhPjNAnTOE=;
 b=feaANhtmE8Q68LdytbbVJdNCS3d4cPDaFy+odqrLzWtd1Phw4MC3NZB5tq9HsNm5+z
 Y6JmvIyVw/yXvm4fFZQE6vqEsFssxMElSUEqiCs3Gj3Ar5Xm+G1W0/3IV/YYPSqsBpkr
 5w0ksR6/G4OO8NIdHxSaS/q6PIoA6iUYQrjwNqEVXDhxI6M4UD0hxRzV72ETjLt+km+m
 tYp7QypVHJLeTwA9KObflthxuQcA8FSEE1oMeK/cqDAoqhfJlVHaWD9d16rTGd9zD1bs
 deFt0aQT9I7T5UeNAVuvFw5UhSHf5cL+ru4h9E3LqLsZSXEhVAKkbb5kfCn/ULFWvcTR
 bfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741009832; x=1741614632;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhHrZGEZ3gZn2e+I/2gT92Wo21OEVkxHllhPjNAnTOE=;
 b=vrJZ4LbUtjPFuqLOkj91h0bgDTw4nn5QBX7XZu/QiTGIHCbya7+mEOQQ5SieKpWcjC
 l4gpatkouQIFTZ8c9cprGknn+EVuc8L/exR84k1w53Yfs/vm+U9xLTRHJUu3Ej18PvEg
 H60r59/6aqjNbofdw65PMReZaOXYL94gSk8ZE74P6QNuAxnwGh95ZvpDujjGC41+Cs5y
 InH06lIx5GUOneNT5qU5brU3L8aDt6Nc2v6XOVOKL9Xsm4IjbhGGrfqpP8cv9EPwUEzH
 WCODXI1TZad+gf62prhYnY/OMK1+LfKVZUfksIHpq1834fPV6TRwtZ1inU7wdAmXsTtK
 c1DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwNELQs9gyf2XgLmOPbX58wwuQGV7BoBKF4f5r1/SHkqUk+/Or6EBbgFcgdpZ8ue5Gd1gaXkIax07w@nongnu.org
X-Gm-Message-State: AOJu0Yw62w5YLrMm71sR3vmFey43StHdIe4AwQQXZsXhKfCYXi3Yr+51
 9ZHpPUoPxGvgRcvJ30XW8C2z1sOb+WeYK4A5C23i6EkyWmLEv7oqrEnd0eUsGOI=
X-Gm-Gg: ASbGncuK1X66vB4ysIk1mgGEuAwUAACiMtO0VUEeyKHMSH0+ePiOhcdobuH7Ji2Vy5C
 Ay/7GsxY1p+7CMy/aILp8SXQ5XNYmqHhUq0jeWHmEQRVxgD31zSlc+33dksee0V3n57NXBWYyKu
 0oodQx3MhAu4S4jmzC/ScEU0Zr5tnDnBi3S1DqrB4E8QKIaDYGO9ekfcLriNdrrQ48SUpZhqF+5
 HUeDKQaXKdfpVC4nyUl5ilU5SOyOw3Hm42U71YlgeuUxcEncpzX85C4+E6YMwj5KPtZGsSaSVIp
 xMbHA/DNTNG8fIAVZ15wzJDNjkXfLG+v+YvBUG8sJwt/UxI=
X-Google-Smtp-Source: AGHT+IFFFJi2/9Ns2F4OH30BbQjiiUz2nIp6L3gkjm3VMz9EMQqA+vY7batGWVaUhlutiy74nMQcTA==
X-Received: by 2002:a05:6402:3902:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e4d6b63059mr31102440a12.31.1741009832575; 
 Mon, 03 Mar 2025 05:50:32 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6d279sm6963915a12.23.2025.03.03.05.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 05:50:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD5025F909;
 Mon,  3 Mar 2025 13:50:30 +0000 (GMT)
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
Subject: KVM/QEMU community call 4/3/25 agenda items
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 03 Mar 2025 13:50:30 +0000
Message-ID: <87h64a6x5l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
04/03/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnA6-0004mH-3g; Mon, 21 Jul 2025 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1udnA1-0004gs-Jr
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:50:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1udn9y-00011q-0f
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:50:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so762785866b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753091410; x=1753696210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xx5s3atyecip487fPk087EGaGjTPnevcK/xxI2IXe9U=;
 b=UqfAxQxiu3Jo9K2Uj9PoDuMpSZHb/bpoAf3IReRQCNm/9RDBGXHSl71LuGOcEthJBQ
 3D8iGI/HyMw2eCHUGJ3MjyiAXhCQpJfDZVUkulsdSZHhccL6/1epVoTRZrvAd0MLH3UW
 rMlMtBf4eGFJE7/qaDLMtsidban83yJyufAn7utPaplPxaeaInyhrkf0UbtGOsF0GDwT
 Jcdj6w7uHawUFDka4VpUf0Y7SnuqRTTnsL7198ZIIUvev52bBs9qdupk5a1sWeLSrO0f
 JjMFl86MCb4bqvCo8HaAw12BAruyAQo8olptd9WXlam4MGXcDplpUnP5mexLNj74fjCF
 GtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753091410; x=1753696210;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xx5s3atyecip487fPk087EGaGjTPnevcK/xxI2IXe9U=;
 b=UBD3PMviG5xiJjAvyq08nXUQjZxK1rokp9QA0rWucWV+t6c86wRSoTqQC/YmSAr5Js
 j8A1cSTpjiLiAUrBDHN+L05BVkPN0q3wwcDu2iJxMCm21W16x5ZPRmgFAuDWc1xvBUT4
 No5re27/KLugTzLO32B3wjTE8E8+9p/vLiiinPLBsGMJg9sa6iuy76HnId1BBdkpFu1x
 VfsERokk8L/Ncs148fv6fzI1Hu+QSjjrZ+1qCh1s81ka32ltixxBSA3xQR4soZJTOjyF
 TEneTw4+tsqhz/X0bKVUoU73pDheFnBhxPCWjM1LJpu7bnUJ6oyUqhBM6QS/81fSr5xy
 h0nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2PKOohPTW8dqO4tWnX32uOXmGlGSQciLXXCyFpRbDanec9BcvB6re13bQKPS9K4enPzxx3Lj/EWv9@nongnu.org
X-Gm-Message-State: AOJu0YyuWG/qvUpBcxkgdOUHx3J+qeelx+MXoBZEW5ZCA/9laNX/csbZ
 OVjSQLLSe/f7P8x+v7UJprYLP2mfq792f85IPa6wXFEUEVqLU3+HJYkUw/ntRrN5M8I=
X-Gm-Gg: ASbGncsS/FenUvDDE5q2C3XcQtr/+pbBGMU4MCXn9HkVXXRtOA9mTw5DsbSLqFAcAfe
 3nZG50O5XGEERjJsP5sMl+NCR1Jdzc4HCyUE/tpBFfNUTwj7QN5w1DaUJhJwRlBKOoEXXVzGji3
 7ts/2b75JeKs3bu7LgDpIJsGvxH7QxGzAaz2y5t/eVFyssNxMSWdeufywM9t56TfjLG2kTXr6aH
 CYbc/iHSBzPXfStW3HgmaD+UPiJOz0CN1SFEAfcKDT/MeU7WRvOsiNbVu14WsIR6gGC167C4Z10
 tRzxRnTwz9zljpZYjMz+VEmaekXBXUQOks+CfTD/Dxr1smplJjYeEgZ9IuzXjIgXbcopaq8mBQA
 uvBfXZiJuQUvpCpkKhdkxnXQ=
X-Google-Smtp-Source: AGHT+IHHqnRIftVJ+UlnYnZKG2wGyrmICGNlF21O9ZSxIWBhuvTCU7Msroy0uso8DiAJ+vmHMrh7qw==
X-Received: by 2002:a17:907:72cb:b0:ae3:d021:9b05 with SMTP id
 a640c23a62f3a-ae9c99be1e9mr2089209366b.15.1753091410188; 
 Mon, 21 Jul 2025 02:50:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca30f68sm643495366b.101.2025.07.21.02.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 02:50:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5815C5F83D;
 Mon, 21 Jul 2025 10:50:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
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
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call for agenda items (22/7/25)
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 21 Jul 2025 10:50:08 +0100
Message-ID: <87a54xx48f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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
22/07/2025 13:00 UTC

Are there any agenda items for the sync-up?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2651CD13CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slRpY-00022t-6t; Tue, 03 Sep 2024 07:36:20 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slRnH-0000l1-Q3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 07:36:06 -0400
Received: from [2a00:1450:4864:20::32e] (helo=mail-wm1-x32e.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slRmJ-0005K2-T9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 07:33:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bbbff40bbso34583195e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725363057; x=1725967857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+fGPC1wDmdOjqjwrba3D12kfEOkz5D69Adf6z44nxo=;
 b=jrI3N8ngCZSOeAibVswMbTY1bmA19pHZQT4OSudc6UhZCdcnTjvN3cM9I7ZkfVz4Gp
 ifGYvdNOhQgkpQm+Lw3B8sD4gxc0LHEd1kNwNkZ28LZ9d/2WsRo9GD/lnapTIxuyfoj8
 O6EBJZUqcMSSJhuy92tBjhiKAuSUDfHQfVMkwko8cajN1naGVpZpMc0K3s84t8uiTn6P
 jfWHEVNf0YUHVLyw+RFzlO1WqL2n66Vggx+38vdGC+8JQ7aVC3AA8V+gYSMsInIx/2r8
 iRsGkCn21wyL0GmWz913QDOOPuPvzCu0ssPK7g18InyJk5hpzI2Oys72jGuj01RgPFhI
 HX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363057; x=1725967857;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+fGPC1wDmdOjqjwrba3D12kfEOkz5D69Adf6z44nxo=;
 b=h46Aj300iMr4smAUaTeFFNtDzGHzgGZ78h0PaTwX2dw/VRePBmDXdXo+wByXpMKwkd
 6qL/fZRcMUDUTAVcia7Mf5jEw/2/yoML/Ugzk4euVojCM47xjSmnMSbL7y8fYWWSzK/t
 JaD6TeUHjtwHzvDgn0yz3wZ2NFatCscQ6r1U3JeuYrMmfTBVpfjaWjzeKLsdSCLBC/FS
 MnoZxwXCw5TBJI2FIFlNsados+W1etQdc2ONlYMo00tQCHkrXUD8SxZ+0G2dvmAFpYOq
 RAb0cgrSOsPuTP75mxpNNgrFTUufTWV8Vir6l9eLKNQmSJ3Tb4bmtcmMmZ/f1RIhqR/s
 tX9A==
X-Gm-Message-State: AOJu0Yy0jzTAJeMtASDkKI5cHdW2XXV/0avNTIFSwCwARH3iJlsFeEVT
 FkhJEeebJ4wHTQlkyUmOuox20bZmW+bSYMArv3fgh0SzxPhMIRwyXIfhjNJMNBgXNEbVSbGHJm5
 XEMM=
X-Google-Smtp-Source: AGHT+IHtvau88qx4sqmOB5vKlcWDnN+UZJqhDg3EH6yNFXJjwgUFSqkKCcjkX71QJ8G61LzMw2DRhA==
X-Received: by 2002:a17:907:3684:b0:a89:d0be:9d1b with SMTP id
 a640c23a62f3a-a89d0bea0cbmr716897966b.52.1725361134066; 
 Tue, 03 Sep 2024 03:58:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8988feae40sm677040466b.15.2024.09.03.03.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 03:58:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6E8860A67;
 Tue,  3 Sep 2024 11:58:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
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
Subject: QEMU/KVM Community Call (3/9/24) agenda items?
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 03 Sep 2024 11:58:52 +0100
Message-ID: <87frqhdmvn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1450:4864:20::32e
 (deferred)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
03/09/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


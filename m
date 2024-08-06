Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6478FC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 11:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbIZ4-0003SC-Lx; Tue, 06 Aug 2024 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbIYv-0003Pa-Nd
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:41:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbIYr-0005cI-Ep
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:41:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aabb71bb2so44970166b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722944463; x=1723549263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Dc/JhvQV3MYznAUss0a0lfM6OJ+ecEDlNo05+0yLks=;
 b=Kvsf38GdLwYIGAuPF8PnMecf2ntMNhbm7sCUnO/57eesB8p4BSNGi59jgFu4YYwU5H
 sQ772vvzTPvXQZw/79EmFp/VUnWjbeqmTquuciQf2NpwL6TdZxgGtF24YOl8Vby8aQqw
 a4mOwmU0uevWgvEU7h9ZZHUWoMJn/SJLUXND54Syhcz63jw2oCNb04LgKUsSpEdaRTnU
 U+5pIUdKUmEVwTbysYqYbyyEhinal+rGTgeWa8Zo0X3u9M3vIRTDdc+Ekm741N6y4sxK
 BH4j3jiHI+wgi00eyVWKQgF27J+KOtbXh9hR4t9oNLaqpKsilvpUtTqOTTSSCOl3jqIC
 p4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722944463; x=1723549263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Dc/JhvQV3MYznAUss0a0lfM6OJ+ecEDlNo05+0yLks=;
 b=YhrwVJ113gkwREBsXETIWNGiM3s7uLj0rD28Zy6qxrQJSOON3iz5A+fItBoKHnyPav
 /dtsHtdRZ+RqN91hP9TESO3O4TSUdOpiHLQC5k1gbS+BJ9NbfgK5CF5THbKqqBCLToV/
 qjlc6W6Gjrc/mabBOPm9nyoY8Oxs+Ekh1jN/Ntcly9sHQovx++ha1flGpfDSfC5Ya7xj
 1I3kgZP/9742mXnNqEELpWKS6xAXL2q6irdzExsRcvh1oCLwr/U+r7FJy45N1oKzfQG9
 sd3qgajy80rmndcSGXMjT4l7IbVhysxDSLn9074Jr+3RSFuFqOROhy3UhjlNFVLR6xFV
 Il2w==
X-Gm-Message-State: AOJu0Yy86cyPJ93o2CqoWSTEtAXrbyA9gWY4/oBthQ5PlS3mBTOspFiH
 v/1h1rVouEZhaXCjcwOWkDOAw8a4UE0qE3pZH2ZoOLOUjW2DSvrMtg1DtWh4P0s=
X-Google-Smtp-Source: AGHT+IF1LMwKFlLZsq3ysMuV1i7qy/qdSSxG1csVLKgsK6sHkYdqp+E0f+d2DLFnUvR8dGVjgqbcoQ==
X-Received: by 2002:a17:907:7e87:b0:a7a:9f0f:ab2b with SMTP id
 a640c23a62f3a-a7dc4e89950mr1106938666b.32.1722944462503; 
 Tue, 06 Aug 2024 04:41:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45447sm541213066b.100.2024.08.06.04.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7806F5F8A1;
 Tue,  6 Aug 2024 12:41:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU devel <qemu-devel@nongnu.org>
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
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM Community Call (6/8/24) agenda items?
Date: Tue, 06 Aug 2024 12:41:00 +0100
Message-ID: <87ed71swtv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
06/08/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


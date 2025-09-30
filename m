Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD1CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Y3h-0003pd-Na; Tue, 30 Sep 2025 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Y3f-0003pV-RI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Y3S-0003u2-QR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759229872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tM7/rHONoHeuybzErYkKzpXMrHla858n5Fxg9v9fPKI=;
 b=ZSwCZUO+K8HsypLw1UN05ihbkB9QpT41ToftWlkfF352GxWMcO8GdlKQf0DyVplKMxil7s
 Xu2DizeGdx/WkeENboIbOY/dSEh31pPtVf4NsCBEEB+iGkVfjnEl+N1vVqPfB5Iam4Yv0u
 Ta31yula6mER4zWgYr1dWSV1f3m97uA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-VDur9nTSPcGb9j2eicLLOw-1; Tue,
 30 Sep 2025 06:57:46 -0400
X-MC-Unique: VDur9nTSPcGb9j2eicLLOw-1
X-Mimecast-MFC-AGG-ID: VDur9nTSPcGb9j2eicLLOw_1759229862
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22F63180034A; Tue, 30 Sep 2025 10:57:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8BD19560B4; Tue, 30 Sep 2025 10:57:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 517B821E6A27; Tue, 30 Sep 2025 12:57:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Alessandro Di Federico <ale@rev.ng>,  Alistair
 Francis <alistair.francis@wdc.com>,  Anton Johansson <anjo@rev.ng>,  Brian
 Cain <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,  "cjia@nvidia.com"
 <cjia@nvidia.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 "cw@f00f.org"
 <cw@f00f.org>,  "demiobenour@gmail.com" <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,  Eric Blake
 <eblake@redhat.com>,  "eblot@rivosinc.com" <eblot@rivosinc.com>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>,  "felipe@nutanix.com"
 <felipe@nutanix.com>,  Alyssa Ross <hi@alyssa.is>,  "iggy@theiggy.com"
 <iggy@theiggy.com>,  Warner Losh <imp@bsdimp.com>,  Jan Kiszka
 <jan.kiszka@web.de>,  Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>,  Jim Shu
 <jim.shu@sifive.com>,  Joao Martins <joao.m.martins@oracle.com>,  Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  "mdean@redhat.com" <mdean@redhat.com>,  "Ho,
 Nelson" <nelson.ho@windriver.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Roberto Campesato <rbc@meta.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "z.huo@139.com" <z.huo@139.com>,  LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  "zwu.kernel@gmail.com"
 <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call 30/09/2025 agenda items?
In-Reply-To: <533EDFC7-8233-4164-9791-BACF096E30F3@qti.qualcomm.com> (Mark
 Burton's message of "Tue, 30 Sep 2025 08:15:36 +0000")
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
 <87ms6cz7bs.fsf@pond.sub.org>
 <533EDFC7-8233-4164-9791-BACF096E30F3@qti.qualcomm.com>
Date: Tue, 30 Sep 2025 12:57:34 +0200
Message-ID: <871pno9pi9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Mark Burton <mburton@qti.qualcomm.com> writes:

> Hey, we could add a discussion about whether we need to expose the BQL over the TCG interface, and in the end, you would be RUNNING back to the dentist, begging them to pull your teeth out :-)

/me waves white flag



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D7CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VUp-0004M1-9A; Tue, 30 Sep 2025 04:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3VUl-0004Lk-Pq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3VUb-0006Ma-FQ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759220024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUGTE5rn8OH7WzCv0pQMUqfKpK2mvNYSfvFTXktcL0Q=;
 b=DkVrKZNvO1sAtKfqAsXicdkV+zkWawcR+ERCECLVPKfGt/n7sPlHzJLJA//6XZBWFDG7zM
 WCm0w2QlFU7XVRSCmGa9kNx5kncF4xx2s/77XC1a6OGNQPYFytVZuz4pPBHL5Nxc+8/W34
 X+AJRgIlJhObysWGGp7s7v2thhmLVq4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-_27IA7g8NA-PT7fLOrj7zQ-1; Tue,
 30 Sep 2025 04:13:40 -0400
X-MC-Unique: _27IA7g8NA-PT7fLOrj7zQ-1
X-Mimecast-MFC-AGG-ID: _27IA7g8NA-PT7fLOrj7zQ_1759220016
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86E4519560B3; Tue, 30 Sep 2025 08:13:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBD9E18004D8; Tue, 30 Sep 2025 08:13:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB61C21E6A27; Tue, 30 Sep 2025 10:13:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Alessandro Di
 Federico <ale@rev.ng>,  Alistair Francis <alistair.francis@wdc.com>,  Anton
 Johansson <anjo@rev.ng>,  Brian Cain <bcain@quicinc.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com,  dhedde@kalrayinc.com,  Eric Blake
 <eblake@redhat.com>,  eblot@rivosinc.com,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  felipe@nutanix.com,  Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com,  Warner Losh <imp@bsdimp.com>,  Jan Kiszka
 <jan.kiszka@web.de>,  Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com,  Jim Shu <jim.shu@sifive.com>,  Joao Martins
 <joao.m.martins@oracle.com>,  Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com,  "Ho, Nelson" <nelson.ho@windriver.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Roberto Campesato <rbc@meta.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  wei.w.wang@intel.com,  z.huo@139.com,  LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call 30/09/2025 agenda items?
In-Reply-To: <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com> (Paolo
 Bonzini's message of "Mon, 29 Sep 2025 18:52:25 +0200")
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
Date: Tue, 30 Sep 2025 10:13:27 +0200
Message-ID: <87ms6cz7bs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> If anybody wants to talk AI (or rather, thinks we should---I cannot imagine anyone *wanting* that), we can do that.

You're offering to make my dentist appointment this morning *not* the
least enjoyable part of my day?

;)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A909CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi9N3-00009x-7v; Fri, 10 Jul 2026 07:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wi9My-000093-Ac
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wi9Mp-000621-Dj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783682762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGiSMf1yY5uaUvaVfFTdhY/xLAI+a5U1g1666EgGa0s=;
 b=Rqe9plyAffF4P+4uw8ECGtfdMkpmFoxoZ2GUc1oGT1gyvvd0HTUS9GpLzMGFZrlP4AsVlw
 LXKymlDpoTU01Z+6FaPT0vg0RLWh1P5cEnwJMsx1YA+DpR4Xwkq84BI+PbLI5aqRqmcoOX
 OATfVR5ONqs4QnVPWa9J6MRzMAlYJtU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Bg4mqQ2MMsWQOYAATjJsMQ-1; Fri,
 10 Jul 2026 07:25:59 -0400
X-MC-Unique: Bg4mqQ2MMsWQOYAATjJsMQ-1
X-Mimecast-MFC-AGG-ID: Bg4mqQ2MMsWQOYAATjJsMQ_1783682756
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6D31955D7A; Fri, 10 Jul 2026 11:25:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96D311800675; Fri, 10 Jul 2026 11:25:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0453C21E6920; Fri, 10 Jul 2026 13:25:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 integration@gluster.org,  Zhao Liu <zhao1.liu@intel.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Mark Kanda <mark.kanda@oracle.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  Glenn Miles <milesg@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
 Ben Chaney <bchaney@akamai.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 06 May 2026 14:01:46 +0200")
References: <87y0hwbvbp.fsf@pond.sub.org>
Date: Fri, 10 Jul 2026 13:25:38 +0200
Message-ID: <87a4rz2ij1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Followup after two months.

Markus Armbruster <armbru@redhat.com> writes:

> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
>
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:
>
>     $ awk '/^M: / { m++ } /^S: / { s=3D$2 } /^$/ && s { if (!m && s !=3D =
"Orphan") print t; m=3D0; s=3D""; getline; t=3DFILENAME ":" FNR ": " $0; ne=
xt }' MAINTAINERS=20
>     MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>     MAINTAINERS:1792: SH4 Machines
>     MAINTAINERS:2022: Machine core
>     MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>     MAINTAINERS:2555: vhost-user-scmi
>     MAINTAINERS:2862: XIVE
>     MAINTAINERS:2872: Renesas peripherals
>     MAINTAINERS:3165: CheckPoint and Restart (CPR)
>     MAINTAINERS:3719: Checkpatch
>     MAINTAINERS:3746: RDMA Migration
>     MAINTAINERS:3894: Record/replay
>     MAINTAINERS:4029: OpenSBI Firmware
>     MAINTAINERS:4153: SPARC TCG target
>     MAINTAINERS:4233: CURL
>     MAINTAINERS:4238: GLUSTER

Now down to

      MAINTAINERS:1762: Microchip PolarFire SoC Icicle Kit
      MAINTAINERS:1842: SH4 Machines
      MAINTAINERS:2623: vhost-user-scmi
      MAINTAINERS:2959: Renesas peripherals
      MAINTAINERS:3814: Checkpatch
      MAINTAINERS:3990: Record/replay
      MAINTAINERS:4241: SPARC TCG target
      MAINTAINERS:4320: CURL

Most of these have R: with S: Odd Fixes, which feels tolerable:

    SH4 Machines
    ------------
    R2D
    R: Yoshinori Sato <yoshinori.sato@nifty.com>
    S: Odd Fixes

    Renesas peripherals
    R: Yoshinori Sato <yoshinori.sato@nifty.com>
    S: Odd Fixes

    Checkpatch
    R: Chao Liu <chao.liu@processmission.com>
    S: Odd Fixes

    Record/replay
    R: Paolo Bonzini <pbonzini@redhat.com>
    R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    S: Odd Fixes

    SPARC TCG target
    S: Odd Fixes

    CURL
    L: qemu-block@nongnu.org
    S: Odd Fixes

Two claim to be supported:

    Microchip PolarFire SoC Icicle Kit
    L: qemu-riscv@nongnu.org
    S: Supported

    vhost-user-scmi
    R: Milan Zamazal <mzamazal@redhat.com>
    S: Supported

I'm going to post patches downgrading them to Orphan.  Please reply to
them if you disagree.

[...]



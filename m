Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077ECD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKaxD-0007nB-93; Wed, 06 May 2026 08:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKawz-0007bG-I3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:02:07 -0400
Received: from us-smtp-delivery-204.mimecast.com ([170.10.129.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKawx-00026D-W8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778068918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hFnQp09cMfydHTmYtD+zwMwCBjky20lb9iWrW64OenM=;
 b=RJrlzKGZ8MhFOOq/TBU0uH+9Ezo/DzSzn49y4/SpAH2JMtgKVcMebkVXaY8CI9kZ+6y0Tv
 3UcS0ek9XEu+Bdo7IUcb5jJM6W8BFzwAbfO0kUVyoxNYNUk4QCWxXHWzdHlF6puuKaX1Fw
 56aCaOvRpR2uHVtYEkhbLIG9Vj2XJn4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-A7XLZpmQMGei1BYS2LFHmw-1; Wed,
 06 May 2026 08:01:52 -0400
X-MC-Unique: A7XLZpmQMGei1BYS2LFHmw-1
X-Mimecast-MFC-AGG-ID: A7XLZpmQMGei1BYS2LFHmw_1778068910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F018A1800359; Wed,  6 May 2026 12:01:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9095A3002D2F; Wed,  6 May 2026 12:01:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2827F21E6A01; Wed, 06 May 2026 14:01:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Milan
 Zamazal <mzamazal@redhat.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Mark Kanda <mark.kanda@oracle.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Glenn Miles <milesg@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Ben Chaney <bchaney@akamai.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: MAINTAINERS entries that aren't S: Orphan but maybe should be
Date: Wed, 06 May 2026 14:01:46 +0200
Message-ID: <87y0hwbvbp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.204; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-204.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I'm cc'ing reviewers and lists mentioned below, and frequent
contributors to MAINTAINERS.

There are a number of MAINTAINERS entries with S: other than "Orphan"
without M:

    $ awk '/^M: / { m++ } /^S: / { s=3D$2 } /^$/ && s { if (!m && s !=3D "O=
rphan") print t; m=3D0; s=3D""; getline; t=3DFILENAME ":" FNR ": " $0; next=
 }' MAINTAINERS=20
    MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
    MAINTAINERS:1792: SH4 Machines
    MAINTAINERS:2022: Machine core
    MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
    MAINTAINERS:2555: vhost-user-scmi
    MAINTAINERS:2862: XIVE
    MAINTAINERS:2872: Renesas peripherals
    MAINTAINERS:3165: CheckPoint and Restart (CPR)
    MAINTAINERS:3719: Checkpatch
    MAINTAINERS:3746: RDMA Migration
    MAINTAINERS:3894: Record/replay
    MAINTAINERS:4029: OpenSBI Firmware
    MAINTAINERS:4153: SPARC TCG target
    MAINTAINERS:4233: CURL
    MAINTAINERS:4238: GLUSTER

Some of these have R:

    MAINTAINERS:1792: SH4 Machines
    R: Yoshinori Sato <yoshinori.sato@nifty.com>
    S: Odd Fixes

    MAINTAINERS:2022: Machine core
    R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
    R: Zhao Liu <zhao1.liu@intel.com>
    S: Supported

    MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
    R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    S: Maintained

    MAINTAINERS:2555: vhost-user-scmi
    R: Milan Zamazal <mzamazal@redhat.com>
    S: Supported

    MAINTAINERS:2862: XIVE
    R: Gautam Menghani <gautam@linux.ibm.com>
    R: Glenn Miles <milesg@linux.ibm.com>
    L: qemu-ppc@nongnu.org
    S: Odd Fixes

    MAINTAINERS:2872: Renesas peripherals
    R: Yoshinori Sato <yoshinori.sato@nifty.com>
    S: Odd Fixes

    MAINTAINERS:3165: CheckPoint and Restart (CPR)
    R: Peter Xu <peterx@redhat.com>
    R: Fabiano Rosas <farosas@suse.de>
    R: Mark Kanda <mark.kanda@oracle.com>
    R: Ben Chaney <bchaney@akamai.com>
    S: Supported

    MAINTAINERS:3746: RDMA Migration
    R: Li Zhijian <lizhijian@fujitsu.com>
    R: Peter Xu <peterx@redhat.com>
    S: Odd Fixes

    MAINTAINERS:3894: Record/replay
    R: Paolo Bonzini <pbonzini@redhat.com>
    R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    S: Odd Fixes

Only R: feels tolerable with S: Odd Fixes.  However, S: Supported and
S: Maintained are clearly wrong.  Unless somebody steps up to serve as
M:, we should downgrade to S: Odd Fixes.  Volunteers?

These have at least L:

    MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
    L: qemu-riscv@nongnu.org
    S: Supported

    MAINTAINERS:4029: OpenSBI Firmware
    L: qemu-riscv@nongnu.org
    S: Supported

    MAINTAINERS:4233: CURL
    L: qemu-block@nongnu.org
    S: Odd Fixes

    MAINTAINERS:4238: GLUSTER
    L: qemu-block@nongnu.org
    L: integration@gluster.org
    S: Odd Fixes

Likewise.  Volunteers?

These have neither:

    MAINTAINERS:3719: Checkpatch
    S: Odd Fixes

    MAINTAINERS:4153: SPARC TCG target
    S: Odd Fixes

Unless somebody steps up to server as M: or at least R:, we should
downgrade to S: Orphan.  Volunteers?



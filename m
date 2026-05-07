Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D7CCD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrid-0006WE-Be; Thu, 07 May 2026 01:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKriQ-0006TW-VF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKriO-0002Br-RF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778133363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fP2IWt5dYZ2WI6Olbsxym1Ms/Jn6bOqhmWgBhEkVd0=;
 b=RdCjkXtINxTLX9LHR5j9je3zgP8nEz5P+4vQRIBEdN4/qKXZPULHazJ4B6fcyngCDjxMHm
 0I/OGJsK1tZ3HDOcLGzY5mX8PdpyLgc6XY3WRFOvzNi2ovzy5q88LUf/ACGKN4HsFy1k3B
 OJwKpXJMD9f3XMecADRq9UMP5ol/YuE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-an2ebYu2N2ulv4tgc7RHCQ-1; Thu,
 07 May 2026 01:55:59 -0400
X-MC-Unique: an2ebYu2N2ulv4tgc7RHCQ-1
X-Mimecast-MFC-AGG-ID: an2ebYu2N2ulv4tgc7RHCQ_1778133356
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CEBF180034C; Thu,  7 May 2026 05:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 409D518004A3; Thu,  7 May 2026 05:55:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE8AD21E6A01; Thu, 07 May 2026 07:55:52 +0200 (CEST)
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
Date: Thu, 07 May 2026 07:55:52 +0200
Message-ID: <871pfnoj9z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I'm going to collect MAINTAINERS patches.  So far:

MAINTAINERS: Add myself as maintainer for replication
MAINTAINERS: Rename Replication -> COLO block replication
MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
MAINTAINERS: Add Doru Bl=C3=A2nzeanu as MSHV reviewer
MAINTAINERS: update HEST maintainership entries
MAINTAINERS: Maintain OpenSBI Firmware



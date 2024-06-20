Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKL6w-0005O6-2J; Thu, 20 Jun 2024 12:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL6u-0005Ll-P6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL6p-0000sz-7K
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718902680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4HbnQUuOQS3cIi86liAy6Yj4hu5P2TTA0k+oQscPEc0=;
 b=Y7Z9MsBGxkZp/2ovFbDsoVddPAhQkVIEMFMOgJIO15SHEwJzxXgNQhBnl2L6aG94zzDtW2
 1QgBup63TLWnIeYkgqTWSw+nXYxDMumRp5ohvspUW7HwiOgFMHHwHgiJ9jpoTSRfHDzLJP
 m6hO2Rul/op34oElJ5tcRByAs1c0yqE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-zFEmxgAzORattmptFWOLUA-1; Thu,
 20 Jun 2024 12:57:58 -0400
X-MC-Unique: zFEmxgAzORattmptFWOLUA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54B7419560B1; Thu, 20 Jun 2024 16:57:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB03919560B0; Thu, 20 Jun 2024 16:57:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/14] hw: define and enforce a standard lifecycle for
 versioned machines
Date: Thu, 20 Jun 2024 17:57:28 +0100
Message-ID: <20240620165742.1711389-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thomas proposed a new deprecation and removal policy for versioned
machine types that would see them liable for deletion after 6 years:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg04683.html

This suggest was met with broad approval, however, I suggested that we
could take it further and actually mark them deprecated sooner, at the
3 year timeframe, and also fully automate the enablement of the runtime
deprecation warning without developer intervention on every release
cycle.

This series implements my suggestions.

The first patch introduces some helper macros and documents a standard
code pattern for defining versioned machine types across targets.

The next 6 patches convert existing targets with versioned machine
types (arm, s390x, ppc, m68k, i386) to use the new helper macros and
code patterns.

A further patch introduces some helper macros for automating the
handling of deprecation and deletion of versioned machine types.

Two more patches then enable the deprecation and deletion logic
across all versioned machines

Finally we do some cleanup and document the new policy.

........a tangent about VERSION file handling.......

One oddity here, is that during the development and release
candidate phases the automatic logic in this series has an off-by-1
error.

This is because when we, for example, add the "9.1" machine type
versions, the VERSION file is still reporting '9.0.50', and then
'9.0.9{1,2,3,4}'.

IOW, during development and in rc candidates, we fail to deprecate
and delete 1 machine type. We should already have deprecated the
6.1 machine types, but the most recently deprecated is 6.0.
This is pretty harmless since the final release does the right
thing.

I wonder, however, whether we would benefit from changing how we
update the VERSION file.

eg instead of re-using the micro digit to indicate a dev or rc
snapshot, represent those explicitly. eg "9.1.0-dev" and
"9.1.0-rc1", "9.1.0-rc2", etc in VERSION.

We don't use the full QEMU_VERSION in the code in all that many
places. It appears in some help messages for command line tools,
and in QMP query-version response, and in a few other misc places.
At a glance it appears all of those places would easily handle a
tagged version.

For release candidates in particular I think it would be saner
to show the user the actual version the release is about to become,
rather than the previous release's version. This would make the
reported version match the rc tarball naming too which would be
nice.

Anyway, this isn't a blocker for this machine type versioning
proposal, just a thought....

Changed in v2:

 - Various docs improvements and minor fixes from original
   review
 - Rebased and resolved conflicts with Philippe's merged
   series

Daniel P. Berrangé (14):
  include/hw: add helpers for defining versioned machine types
  hw/arm: convert 'virt' machine definitions to use new macros
  hw/s390x: convert 'ccw' machine definitions to use new macros
  hw/ppc: convert 'spapr' machine definitions to use new macros
  hw/m68k: convert 'virt' machine definitions to use new macros
  hw/i386: convert 'i440fx' machine definitions to use new macros
  hw/i386: convert 'q35' machine definitions to use new macros
  include/hw: add macros for deprecation & removal of versioned machines
  include/hw: temporarily disable deletion of versioned machine types
  hw: set deprecation info for all versioned machine types
  hw: skip registration of outdated versioned machine types
  hw/ppc: remove obsolete manual deprecation reason string of spapr
    machines
  hw/i386: remove obsolete manual deprecation reason string of i440fx
    machines
  docs: document special exception for machine type deprecation &
    removal

 docs/about/deprecated.rst  |  13 ++
 hw/arm/virt.c              |  30 ++--
 hw/i386/pc_piix.c          | 220 ++++++++++++---------------
 hw/i386/pc_q35.c           | 215 +++++++++++---------------
 hw/m68k/virt.c             |  53 ++++---
 hw/ppc/spapr.c             |  96 ++++++------
 hw/s390x/s390-virtio-ccw.c |  98 ++++++------
 include/hw/boards.h        | 298 +++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h       |  28 ++++
 9 files changed, 681 insertions(+), 370 deletions(-)

-- 
2.43.0



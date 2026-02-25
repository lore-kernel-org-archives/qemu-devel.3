Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E61FCEE94
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDdh-000711-4P; Wed, 25 Feb 2026 07:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvDdc-00070j-6C
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvDda-0003bv-E5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772021104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DGfNgZNFDLRMIJxlJNW+u95AO1+LmpPR1wOLNF34j1g=;
 b=hyroccrkqjNElqn7EC429O9zq+hP8gJ+cLZAkfDRVv49c2sRAyuggUkr8RZuip18hF8gUG
 MY4BpqGvK7TDTuIKai71uYyr+stXWsOpA/qSOIfEvMgZq7c+bbH9WeBXKnn2fvSJnFDCbD
 9QVIPqUI8Dek3yxtSPB7jPzm6jBPOk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-8Z9mnVqDPzeTZ63qUbcPnw-1; Wed,
 25 Feb 2026 07:05:01 -0500
X-MC-Unique: 8Z9mnVqDPzeTZ63qUbcPnw-1
X-Mimecast-MFC-AGG-ID: 8Z9mnVqDPzeTZ63qUbcPnw_1772021099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CA991800451; Wed, 25 Feb 2026 12:04:59 +0000 (UTC)
Received: from localhost (unknown [10.48.1.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B54751800465; Wed, 25 Feb 2026 12:04:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Mark Kanda <mark.kanda@oracle.com>,
 kvm@vger.kernel.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/14] Make RamDiscardManager work with multiple sources
Date: Wed, 25 Feb 2026 13:04:41 +0100
Message-ID: <20260225120456.3170057-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

This is an attempt to fix the incompatibility of virtio-mem with confidential
VMs. The solution implements what was discussed earlier with D. Hildenbrand:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238

The first patches are misc cleanups. Then some code refactoring to have split a
manager/source. And finally, the manager learns to deal with multiple sources.

I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
device. It would be nice to have more tests for those scenarios with
VFIO/virtio-mem/confvm.. In any case, review & testing needed!

(should fix https://issues.redhat.com/browse/RHEL-131968)

v2:
 - drop replay_{populated,discarded} from source, suggested by Peter Xu
 - add extra manager cleanup
 - add r-b tags for preliminary patches

thanks

Marc-André Lureau (14):
  system/rba: use DIV_ROUND_UP
  memory: drop RamDiscardListener::double_discard_supported
  virtio-mem: use warn_report_err_once()
  system/memory: minor doc fix
  kvm: replace RamDicardManager by the RamBlockAttribute
  system/memory: split RamDiscardManager into source and manager
  system/memory: move RamDiscardManager to separate compilation unit
  system/memory: constify section arguments
  system/ram-discard-manager: implement replay via is_populated
    iteration
  virtio-mem: remove replay_populated/replay_discarded implementation
  system/ram-discard-manager: drop replay from source interface
  system/memory: implement RamDiscardManager multi-source aggregation
  system/memory: add RamDiscardManager reference counting and cleanup
  tests: add unit tests for RamDiscardManager multi-source aggregation

 include/hw/vfio/vfio-container.h            |    2 +-
 include/hw/vfio/vfio-cpr.h                  |    2 +-
 include/hw/virtio/virtio-mem.h              |    3 -
 include/system/memory.h                     |  285 +----
 include/system/ram-discard-manager.h        |  358 ++++++
 include/system/ramblock.h                   |    3 +-
 accel/kvm/kvm-all.c                         |    2 +-
 hw/vfio/cpr-legacy.c                        |    4 +-
 hw/vfio/listener.c                          |   12 +-
 hw/virtio/virtio-mem.c                      |  290 +----
 migration/ram.c                             |    6 +-
 system/memory.c                             |   83 +-
 system/memory_mapping.c                     |    4 +-
 system/ram-block-attributes.c               |  279 +----
 system/ram-discard-manager.c                |  612 +++++++++
 tests/unit/test-ram-discard-manager-stubs.c |   48 +
 tests/unit/test-ram-discard-manager.c       | 1234 +++++++++++++++++++
 system/meson.build                          |    1 +
 tests/unit/meson.build                      |    8 +-
 19 files changed, 2359 insertions(+), 877 deletions(-)
 create mode 100644 include/system/ram-discard-manager.h
 create mode 100644 system/ram-discard-manager.c
 create mode 100644 tests/unit/test-ram-discard-manager-stubs.c
 create mode 100644 tests/unit/test-ram-discard-manager.c

-- 
2.53.0



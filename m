Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE509CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OD-00027j-Vv; Fri, 10 Oct 2025 04:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OB-00027P-7d
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O6-0000zz-MN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q4lxVt8/FFnxBjoexqWCnPwPdoNa45gC6XR0ABhZsvY=;
 b=YjC7Ogw98XN8GCkXLMwOCE9NOCfiWoiOI7Esm5tBcvDeZd76dTofSuUhN+9ATLzEsajMGu
 U/QgewIQu+YyxFoZSWBmc+cTRMw9jkdPp+0k5FP7Bm2FGfFXBom8/wlCTGiJ7pJoAOnST8
 8aAno2UEteDVH6y1mfRHB+U5qlrfp5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-CEC7IgALMG2GkxTSl8Om6g-1; Fri,
 10 Oct 2025 04:21:49 -0400
X-MC-Unique: CEC7IgALMG2GkxTSl8Om6g-1
X-Mimecast-MFC-AGG-ID: CEC7IgALMG2GkxTSl8Om6g_1760084508
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1E5C1800292; Fri, 10 Oct 2025 08:21:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CECD21800452; Fri, 10 Oct 2025 08:21:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/9] s390x patches (+ 1 functional test patch)
Date: Fri, 10 Oct 2025 10:21:35 +0200
Message-ID: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

 Hi Richard!

The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:

  Merge tag 'pull-loongarch-20251009' of https://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-10

for you to fetch changes up to 47ea7263701e85ea03270d34c9a90f3971597e06:

  s390x/pci: set kvm_msi_via_irqfd_allowed (2025-10-10 10:02:51 +0200)

----------------------------------------------------------------
* Improves s390x virtio-pci performance when using kvm
* Fix a problem with losing interrupts on s390x in certain cases
* Replace legacy cpu_physical_memory_[un]map() calls in s390x code

----------------------------------------------------------------
Jaehoon Kim (1):
      s390x/pci: fix interrupt blocking by returning only the device's summary bit

Matthew Rosato (1):
      s390x/pci: set kvm_msi_via_irqfd_allowed

Philippe Mathieu-Daudé (6):
      target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (1/3)
      target/s390x: Propagate CPUS390XState to cpu_unmap_lowcore()
      target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (2/3)
      target/s390x: Reduce s390_store_adtl_status() scope
      target/s390x: Reduce s390_store_status() scope
      target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (3/3)

Thomas Huth (1):
      tests/functional: Drop the "Attempting to cache ..." log text

 include/hw/s390x/s390-pci-kvm.h     |   7 +++
 target/s390x/s390x-internal.h       |   5 +-
 hw/s390x/s390-pci-bus.c             |  22 +++++--
 target/s390x/helper.c               | 122 +++---------------------------------
 target/s390x/sigp.c                 | 117 ++++++++++++++++++++++++++++++++++
 target/s390x/tcg/excp_helper.c      |  19 +++---
 target/s390x/tcg/misc_helper.c      |   4 +-
 tests/functional/qemu_test/asset.py |   1 -
 8 files changed, 164 insertions(+), 133 deletions(-)



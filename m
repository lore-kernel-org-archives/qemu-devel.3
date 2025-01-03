Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5348EE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTisz-0002ME-VT; Fri, 03 Jan 2025 09:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTisy-0002Lg-0Y
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTisv-0007CL-BK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJX2TJZl88HvqYjwyWjZCqZMdRAD9JwFRMP+EhklT84=;
 b=iKHgFYVt4I4BX2dBhTRkOjWNLDFlGsf+wtCQehEHZzOV8giNX+XULx4Z4ZADYu9RM6SvwI
 M1vZRw0wUKrJvaZ0wBO1XKsaNU5IzFf3ue2OW8Iba+8MWz9VWjvFREF0QYVTQYjXYNPp3h
 spnp4SP9CDyhkDVf5zSI1RX0E0ZW/4s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-ImHAgsY7P0-th41vnkIlmQ-1; Fri,
 03 Jan 2025 09:42:39 -0500
X-MC-Unique: ImHAgsY7P0-th41vnkIlmQ-1
X-Mimecast-MFC-AGG-ID: ImHAgsY7P0-th41vnkIlmQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61FDB19560A3; Fri,  3 Jan 2025 14:42:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90D143000197; Fri,  3 Jan 2025 14:42:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 00/10] hw/s390x: Remove deprecated machine types 2.4 up to 2.8
Date: Fri,  3 Jan 2025 15:42:22 +0100
Message-ID: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to our support policy, we don't support machine types anymore
that are older than 6 years, so we can remove the very old 2.x machine
types now. Let's start by removing all s390-virtio-ccw machines up to
version 2.8. (This also helps to get rid of the problem that has been
described in: https://gitlab.com/qemu-project/qemu/-/issues/2213 )

Thomas Huth (10):
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4 and 2.5 machine
    types
  hw/s390x/s390-skeys: Remove the "migration-enabled" property
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.6 machine type
  hw/s390x: Remove the "ri_allowed" switch
  hw/s390x/ipl: Remove the "iplbext_migration" property
  hw/s390x/css-bridge: Remove the "css_dev_path" property
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.7 machine type
  hw/s390x: Remove the cpu_model_allowed flag and related code
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.8 machine type
  hw/s390x: Remove the "adapter_routes_max_batch" property from the flic

 hw/s390x/ipl.h                     |   1 -
 include/hw/s390x/css-bridge.h      |   1 -
 include/hw/s390x/s390-virtio-ccw.h |   6 --
 include/hw/s390x/s390_flic.h       |   2 -
 include/hw/s390x/storage-keys.h    |   2 -
 hw/intc/s390_flic.c                |   9 ---
 hw/s390x/css-bridge.c              |  16 +----
 hw/s390x/ipl.c                     |  10 ---
 hw/s390x/s390-skeys.c              |  10 +--
 hw/s390x/s390-virtio-ccw.c         | 108 +----------------------------
 hw/s390x/virtio-ccw.c              |   5 +-
 target/s390x/kvm/kvm.c             |  16 ++---
 12 files changed, 11 insertions(+), 175 deletions(-)

-- 
2.47.1



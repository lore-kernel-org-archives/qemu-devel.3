Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E9EC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lZd-0001Fs-Gz; Tue, 29 Apr 2025 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZc-0001Ex-6E
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZa-0005Zv-I0
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745935473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SMBovFAZMNvCOHb2FkLzLZCT++8W3Fs8vcZyQ75LiNI=;
 b=cf7615YxFGUfSab3dPhjjeooAfquG5H+R8TTeNhBoz2V2kpjNd5HIzOMgkukAGnAyaD8FG
 xL5q7sTAAb0/I6oADTEyr7N2DIbGanYfhL5HCjllIbN2vFpt5mO9rKuurWawrREPQjs+9Z
 jiGR2MMmIqu3LNXjmyjzRLm7YOMgJgo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-qhB7HPQmMVeeMcn9QUJbPg-1; Tue,
 29 Apr 2025 10:03:16 -0400
X-MC-Unique: qhB7HPQmMVeeMcn9QUJbPg-1
X-Mimecast-MFC-AGG-ID: qhB7HPQmMVeeMcn9QUJbPg_1745935392
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8CDC18009AC; Tue, 29 Apr 2025 14:03:11 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E95330001A2; Tue, 29 Apr 2025 14:03:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/6] qom/object properties cleanups
Date: Tue, 29 Apr 2025 18:03:00 +0400
Message-ID: <20250429140306.190384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

While reviewing some related code, I noticed array properties are leaking.

I also wonder why I refactored object_property_del_all() with a HashTable, and
whether it's really necessary. Here is also a RFC to simplify that code.

Marc-André Lureau (6):
  qdev: make release_string() idempotent
  qdev: make release_drive() idempotent
  qdev: make release_tpm() idempotent
  qdev: make release_prop_array() free array and idempotent
  tests: add /qdev/free-properties test
  RFC: qom/object: simplify object_property_del_all()

 backends/tpm/tpm_util.c          |  1 +
 hw/core/qdev-properties-system.c |  1 +
 hw/core/qdev-properties.c        | 18 +++---
 qom/object.c                     | 18 ++----
 tests/unit/test-qdev.c           | 96 ++++++++++++++++++++++++++++++++
 tests/unit/meson.build           |  1 +
 6 files changed, 114 insertions(+), 21 deletions(-)
 create mode 100644 tests/unit/test-qdev.c

-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1813C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLWq-0001m7-2G; Wed, 08 Jul 2026 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWg-0001jr-CU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:12:55 -0400
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWe-0005n8-5T
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:12:54 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783491167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OakrGP+i5Wbv3La58u+R3NJ58lVHXdE6bN/zrezavE0=;
 b=wmX+A6ZpFxRMw64Ml1l/fc0Cd86wo44Jn96nIva0YbxWm87NonXwZ8SrsZMPZDyAMUgL0v
 RvakQbWthHy8UnNcM84DbHISNKZnV6hJgZBisbmYm2i9o982J89VKHSKNXvHrmzYQ0V+p/
 9hEb+8wA/U68hz3f7v8cMJOlaXwoOaM=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 0/2] accel/kvm: notify management of vCPU run errors
Date: Wed,  8 Jul 2026 14:12:18 +0800
Message-ID: <20260708061220.53507-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ae;
 envelope-from=cui.tao@linux.dev; helo=out-174.mta1.migadu.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
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

From: Tao Cui <cuitao@kylinos.cn>

Today, when a KVM vCPU exits with KVM_EXIT_INTERNAL_ERROR,
KVM_EXIT_UNKNOWN, or a failed KVM_RUN ioctl, QEMU logs to stderr and
calls vm_stop(RUN_STATE_INTERNAL_ERROR). The management layer then only
sees the derived STOP event; it cannot tell which vCPU failed nor obtain
the kernel suberror / extra data. This gap is even called out by a
FIXME in kvm_handle_internal_error().

This series adds a KVM_VCPU_ERROR QMP event, emitted before the VM is
stopped, that carries the failing vCPU (cpu-index, qom-path), an error
category (KvmVcpuErrorReason) and, for KVM_EXIT_INTERNAL_ERROR, the
kernel suberror and extra data words.

  Patch 1 defines the event and the KvmVcpuErrorReason enum in
          qapi/run-state.json.
  Patch 2 wires it up at the three unrecoverable-exit points in
          accel/kvm/kvm-all.c and removes the FIXME.

Tao Cui (2):
  qapi: add KVM_VCPU_ERROR event
  accel/kvm: emit KVM_VCPU_ERROR on unrecoverable vCPU exits

 accel/kvm/kvm-all.c | 46 +++++++++++++++++++++++++++++++++---
 qapi/run-state.json | 57 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)

-- 
2.43.0



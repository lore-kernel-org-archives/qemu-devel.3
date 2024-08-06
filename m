Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4251C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLcZ-0000wd-1k; Tue, 06 Aug 2024 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbLcX-0000vW-Gu
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbLcV-0001v1-GY
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722956222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W/aKkyXxYZUM0tYwF5kW0KgLJk4jPm0rOG5Ib1LbPBo=;
 b=BR/ezGLY+O6BjmvJcpgyyNj3faMP2iF6z+moijvmb6PxjW+3uiJCnYCUVf7WaZjCLkYgrA
 iTdAKRJUFOkfWnfH0M94yjtWAVGHJBd0tlDZLSOs8pgbd1qVsgtHYN4D7rNm6r81LKFcRK
 mHXbclqhf5fF0IYRyLkqqF4w8rh24ho=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-2Rpcnu3JNJyjDEtQM1_L4w-1; Tue,
 06 Aug 2024 10:56:59 -0400
X-MC-Unique: 2Rpcnu3JNJyjDEtQM1_L4w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EDC71955D59; Tue,  6 Aug 2024 14:56:58 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.106])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43FB319560AE; Tue,  6 Aug 2024 14:56:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/5] Report fatal errors from failure with pre-opened eBPF RSS
 FDs
Date: Tue,  6 Aug 2024 15:56:48 +0100
Message-ID: <20240806145653.1632478-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The virtio-net code for eBPF RSS is still ignoring errors when
failing to load the eBPF RSS program passed in by the mgmt app
via pre-opened FDs.

This series re-factors the eBPF common code so that it actually
reports using "Error" objects. Then it makes virtio-net treat
a failure to load pre-opened FDs as a fatal problem. When doing
speculative opening of eBPF FDs, QEMU merely prints a warning,
and allows the software fallback to continue.

Trace event coverage is significantly expanded to make this all
much more debuggable too.

Daniel P. Berrangé (5):
  hw/net: fix typo s/epbf/ebpf/ in virtio-net
  ebpf: drop redundant parameter checks in static methods
  ebpf: add formal error reporting to all APIs
  hw/net: report errors from failing to use eBPF RSS FDs
  ebpf: improve trace event coverage to all key operations

 ebpf/ebpf_rss.c     | 118 ++++++++++++++++++++++++++++----------------
 ebpf/ebpf_rss.h     |  10 ++--
 ebpf/trace-events   |   6 ++-
 hw/net/virtio-net.c |  53 +++++++++++++-------
 4 files changed, 123 insertions(+), 64 deletions(-)

-- 
2.45.2



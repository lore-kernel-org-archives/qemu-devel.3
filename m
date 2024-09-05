Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E2CD98FE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGzO-0005q3-3b; Thu, 05 Sep 2024 14:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzJ-0005oX-RE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzC-0001Gs-L0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725560017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LASPBN4SvHP1zmEuygy/Ff5goNjd8SPXWx32K/CJPQM=;
 b=BnYW8VtRscioNEH+j5PP29wOAvGNA09fddmmSG9C/1bcIBN9Qsnq5xJfx5XftC1LTETDWt
 o8VdYTSiKOAt0tfSK13M136Y6gSKC/uuOrzCDIll2CmwLMONzn7SDTCVLYpxbi75/hQlEV
 eHE1hFCwW5WOSXMT1Pe1MdGfUpDYVbo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-b_p5TXv6OIaAFU5FJNBtuw-1; Thu,
 05 Sep 2024 14:13:36 -0400
X-MC-Unique: b_p5TXv6OIaAFU5FJNBtuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 010781956048; Thu,  5 Sep 2024 18:13:35 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79CE019560B0; Thu,  5 Sep 2024 18:13:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/7] Report fatal errors from failure with pre-opened eBPF
 RSS FDs
Date: Thu,  5 Sep 2024 19:13:23 +0100
Message-ID: <20240905181330.3657590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changed in v2:

 - Split 'ebpf_error' probe into multiple probes

Daniel P. Berrangé (7):
  hw/net: fix typo s/epbf/ebpf/ in virtio-net
  ebpf: drop redundant parameter checks in static methods
  ebpf: improve error trace events
  ebpf: add formal error reporting to all APIs
  hw/net: report errors from failing to use eBPF RSS FDs
  ebpf: improve trace event coverage to all key operations
  hw/net: improve tracing of eBPF RSS setup

 ebpf/ebpf_rss.c     | 118 ++++++++++++++++++++++++++++----------------
 ebpf/ebpf_rss.h     |  10 ++--
 ebpf/trace-events   |   8 ++-
 hw/net/trace-events |   8 +--
 hw/net/virtio-net.c |  63 +++++++++++++++--------
 5 files changed, 137 insertions(+), 70 deletions(-)

-- 
2.45.2



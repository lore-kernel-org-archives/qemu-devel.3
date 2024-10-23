Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE8D2E028
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5O-0000Wl-Lr; Wed, 23 Oct 2024 04:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5K-0000WC-UT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5H-0007qu-Ka
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XlYJmQzBZOkRY5RN76DdoccEdJsxyfuHvP9iUkBHaYk=;
 b=Ly2eDW1/JESJpSgvbqEF6xzQqAHWcIc6pq/ZhjR38o2k8kod+Njq2GXl4o3YW1icXzN2si
 qy5Gyg82Zsw/u64PHe0G41YhN1yGKyWoDJ3l4OAnjqvHcYMyO4rC6thPu8Aqb9MUmy/7a9
 3144UcqUBArjszu1FWk6nwlWegNePSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-3bg7ruRlOm--EqrOJT8K2g-1; Wed,
 23 Oct 2024 04:51:09 -0400
X-MC-Unique: 3bg7ruRlOm--EqrOJT8K2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95DA11956077; Wed, 23 Oct 2024 08:51:08 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F5121955EA3; Wed, 23 Oct 2024 08:51:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 0/8] Report fatal errors from failure with pre-opened eBPF
 RSS FDs
Date: Wed, 23 Oct 2024 09:50:55 +0100
Message-ID: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Changed in v3:

 - Fixed bpf stubs for new Error **errp argument
 - Added fix for pre-existing flaw with libxdp build logic
   when bpf is disabled

Changed in v2:

 - Split 'ebpf_error' probe into multiple probes

Daniel P. Berrangé (8):
  net: fix build when libbpf is disabled, but libxdp is enabled
  hw/net: fix typo s/epbf/ebpf/ in virtio-net
  ebpf: drop redundant parameter checks in static methods
  ebpf: improve error trace events
  ebpf: add formal error reporting to all APIs
  hw/net: report errors from failing to use eBPF RSS FDs
  ebpf: improve trace event coverage to all key operations
  hw/net: improve tracing of eBPF RSS setup

 ebpf/ebpf_rss-stub.c |   8 +--
 ebpf/ebpf_rss.c      | 118 ++++++++++++++++++++++++++++---------------
 ebpf/ebpf_rss.h      |  10 ++--
 ebpf/trace-events    |   8 ++-
 hw/net/trace-events  |   8 +--
 hw/net/virtio-net.c  |  63 +++++++++++++++--------
 meson.build          |  10 +++-
 net/meson.build      |   2 +-
 8 files changed, 151 insertions(+), 76 deletions(-)

-- 
2.46.0



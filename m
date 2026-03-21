Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBB31094468
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 10:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3tC0-0003hr-1q; Sat, 21 Mar 2026 06:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBw-0003gQ-RT
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:24 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBt-0002wX-Ri
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1774087459; x=1774094659; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender; 
 bh=Ut+/qKR4p/deumhqLABBLOUACuyOcH1nc98y7uhdlV4=;
 b=jr2bDnkkXibtx1vNd8X+Cuy9JimSEuci9NYz112QfLTFCkWDV8w2qqNEL5UKEKcP0bfzza5HIa0AaVQUEIQ1fmS6adfYRQ4FjFWIzU0zltQAApLVUfm9+J5uVrSCORlAuO5bDHS8quaxfTKL1qK2RiFyTcIh8I+3NAmHKWTDGVBrhXFazenyUxcAofUAJVjuhR0JjoK8xVQyqVIEkTpPMQgi54ma0c+L7nOW10MqM6RYvIJX/srSqEsxwEnFWBhfOCdIr22Dk2T7shpopi0waQJzlOuDS9BrWujJYKgBNLCaFMCjiDKhm8nPv+6KerjWJRq5G+p4YIcBKfx7TZ8m5A==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69be6d234146bb649678b932; Sat, 21 Mar 2026 10:04:19 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v3 0/3] hw/qdev: Consolidate qdev_get_human_name() and
 qdev_get_printable_name()
Date: Sat, 21 Mar 2026 11:04:02 +0100
Message-ID: <20260321100405.1525059-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v3 addresses Markus's review of v2:

- Drop g_assert(dev) and final fallback comment
- Adopt imperative mood for doc comment (Markus's wording)
- Add "<bus-type> device <path>" prefix to bus-specific paths
  instead of deferring to a follow-up series
- Rename qdev_get_printable_name() to qdev_get_human_name()

v2: https://lore.kernel.org/qemu-devel/20260311215003.664815-1-alessandro@0x65c.net/
v1: https://lore.kernel.org/qemu-devel/20260308160040.354186-2-alessandro@0x65c.net/

Alessandro Ratti (3):
  hw/qdev: Clarify fallback order in qdev_get_printable_name()
  hw/qdev: Prefix bus type in qdev_get_printable_name() device paths
  hw/qdev: Consolidate qdev_get_printable_name() into
    qdev_get_human_name()

 hw/core/qdev.c         | 38 ++++++++++----------------------------
 hw/virtio/virtio.c     |  6 +++---
 include/hw/core/qdev.h | 28 +++++-----------------------
 3 files changed, 18 insertions(+), 54 deletions(-)

-- 
2.53.0



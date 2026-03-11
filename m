Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E7E103E2E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RRm-0003Q9-H9; Wed, 11 Mar 2026 17:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRj-0003Ph-3D
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:27 -0400
Received: from v5227.v57ae4e16.euw1.send.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRe-0000pR-1U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773265817; x=1773273017; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender; 
 bh=5pehhixL0m9Cbk0EM+r4K/OsxIusaT8jRnZdLBksfzs=;
 b=eIp31uBNnJRVIfUdSab+lxG/RQpfhrvyEkaAv3qB+XaMfADeZZ890ibaXXQVB3KTgZSO1COSJHLTXWmXvPF5A1i0LSN5+A19LQcOHe6/BdQPXLB1nza6CBiVXV4vyUsnPo5HYQY7+sZ6wiwimbnrllYeUANwKrijRpypAvXIIb7ZBm0sSJ0RtqrQHK82/CwPYKwoTsVkCqVImVS8wGE36sCpnQr7ixWuS/vBrRTGUHVuGEyJQJacazAhoW4CiNvxj3F/bhLTGTqt+gCDWD3EaMVatPjIey4hXAf/rfvi7V4xMl4B3AGmeHT54AMpKdJjEXM0zS6spvIB0E6eJOUUtw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69b1e39998822f2c9b78e18d; Wed, 11 Mar 2026 21:50:17 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v2 0/2] qdev: Consolidate qdev_get_human_name() into
 qdev_get_printable_name()
Date: Wed, 11 Mar 2026 22:50:01 +0100
Message-ID: <20260311215003.664815-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v5227.v57ae4e16.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v2 addresses Markus's review of v1:

- Split into two patches: improve qdev_get_printable_name() first,
  then remove qdev_get_human_name()
- Fix comments to accurately describe qdev_get_dev_path() behavior
- Drop unnecessary comments and the "<unknown device>" placeholder
- Rename @vdev to @dev, add g_assert(dev) precondition
- Update doc comment in qdev.h to reflect the new fallback chain
- Rebase on current master now that the prerequisite
  qdev_get_printable_name() changes have landed

Formatting bus-specific paths as "<bus> device <dev-path>" (e.g.
"PCI device 0000:00:00.0") is left for a follow-up series.

v1: https://lore.kernel.org/qemu-devel/20260308160040.354186-2-alessandro@0x65c.net/


Alessandro Ratti (2):
  hw/qdev: Clarify fallback order in qdev_get_printable_name()
  hw/qdev: Remove qdev_get_human_name()

 hw/block/block.c       |  5 ++---
 hw/core/qdev.c         | 37 ++++++++++++-------------------------
 include/hw/core/qdev.h | 25 +++++--------------------
 3 files changed, 19 insertions(+), 48 deletions(-)

-- 
2.53.0



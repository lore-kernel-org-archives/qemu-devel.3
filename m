Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF86C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8Nv-0000Sk-Hd; Tue, 21 Jul 2026 07:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wm8Nt-0000SX-VN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wm8Ns-0008UM-BB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784632294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAGVtE4mS1mRBh32A+qz5rjD0mVpAxLTUHb3KnaYWII=;
 b=RFuNr+djrFLf/gvldgMbmoaospCN3aZSiTwbprf1k3FjFUFkQQYXwXvdravJ08MaJqNB/E
 u/NbFUs9I8Kwa+vIduQ7I6beZ6PCb4em/XKDticjFwueSghJ52gsmmOZmjcBifd/XcxAjy
 A6PzCPFFhjslmWQkVqIcLG/PI6/ceJE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-moMcPo9RPR-HG3KVjdjwDg-1; Tue,
 21 Jul 2026 07:11:31 -0400
X-MC-Unique: moMcPo9RPR-HG3KVjdjwDg-1
X-Mimecast-MFC-AGG-ID: moMcPo9RPR-HG3KVjdjwDg_1784632290
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97D761944D42; Tue, 21 Jul 2026 11:11:29 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB651597; Tue, 21 Jul 2026 11:11:27 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/2] hw/net: fix rx_desc_len on migration load
Date: Tue, 21 Jul 2026 13:11:24 +0200
Message-ID: <20260721111126.3278244-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

rx_desc_len is migrated as a raw uint8_t from the stream in both
e1000e and igb, but it is a derived value that can be computed from
the register state. A crafted migration stream can set rx_desc_len
to an invalid value, causing a stack buffer overflow in
e1000e_write_packet_to_guest() which copies rx_desc_len bytes into
a 32-byte stack union.

Recalculate rx_desc_len from the register state in post_load,
ignoring the untrusted value from the stream.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869

Laurent Vivier (2):
  hw/net/e1000e: recalculate rx_desc_len on migration load
  hw/net/igb: recalculate rx_desc_len on migration load

 hw/net/e1000e_core.c | 2 ++
 hw/net/igb_core.c    | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.54.0



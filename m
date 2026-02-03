Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE3E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnErL-0005en-4M; Tue, 03 Feb 2026 06:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vnErI-0005eI-Vv
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vnErH-0002XZ-NL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770119174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nr4gzpwAbpiFu89VA91Xp1jojv0Jzg50xqp6p1J6m3U=;
 b=BUHYrdBSCockviRT/2xENPHwF975fLZSIScOkHtFwKMboaWbnBhaMz+EOcdiH8b7VOLkjc
 Zr/tnosL7OVVy3l6+ZvAQ/2kA/DGFFfk/St19AI+gxZJ1Oy/ASPv5nj9tLI4TKeXF1txdp
 TwQoS293kuzj+bLO9IL4LvGPUE2Qum0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-uujjewBSOS2rHlHd3_RUng-1; Tue,
 03 Feb 2026 06:46:11 -0500
X-MC-Unique: uujjewBSOS2rHlHd3_RUng-1
X-Mimecast-MFC-AGG-ID: uujjewBSOS2rHlHd3_RUng_1770119170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F6F18003FD; Tue,  3 Feb 2026 11:46:10 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD3C41956053; Tue,  3 Feb 2026 11:46:08 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v3 0/3] scripts: render_block_graph: Fix with new python and
 improve argument parsing
Date: Tue,  3 Feb 2026 12:46:04 +0100
Message-ID: <cover.1770108741.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

New python doesn't like '\l' escapes from the 'dot' language.

While at it improve usability of the script by employing proper argument
parsing.

v3:
 - rebase + resend

v2:
 - use mutually exclusive group instead of hardcoding it (Pavel)

Peter Krempa (3):
  scripts: render_block_graph: Fix invalid escape sequence warning with
    python 3.12
  scripts: render_block_graph: Implement proper argument parser
  scripts: render_block_graph: Avoid backtrace on error from virsh

 scripts/render_block_graph.py | 80 +++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 23 deletions(-)

-- 
2.52.0



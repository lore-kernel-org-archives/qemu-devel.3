Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7E4C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971H-0004Zt-K5; Tue, 22 Sep 2026 16:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9702-0000kj-U2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9701-0000Cq-Ao
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAUeWAG/sMzqfzbZKjFlT8bLd4yW86qBnoWJQkgaWNo=;
 b=TMn+8b6eifPNdDVyPQvjVJI6J8fpqTigCb09vYVFQozzYw38ino3aJsM1cHcaPyCJOdpns
 8H/Wii6ZqMr0j4+zZtnBi7797tVnmswsO3FaVJ74qIbgS8XMcx04lOTOKEppbLyxOGZ6iI
 YZ7RzwZMeEpt5LNlRVA/kAnYbyOlyYE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-R7ehMu6aMqmVsyMUBxwXaQ-1; Tue,
 22 Sep 2026 16:21:51 -0400
X-MC-Unique: R7ehMu6aMqmVsyMUBxwXaQ-1
X-Mimecast-MFC-AGG-ID: R7ehMu6aMqmVsyMUBxwXaQ_1790108511
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D4A1834504; Tue, 22 Sep 2026 20:21:50 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE21B180034C; Tue, 22 Sep 2026 20:21:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:52 +0400
Subject: [PATCH 45/88] qemu-iotests/iothreads-create: doesn't actually
 depend on HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-45-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Q4eKZ6YKOzR/5nSmc3Z6JIhVY2m795xMmLa7w9CCs/I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxxn02cPtV5cQXLj28amL3A6z4dzud+G2nP
 B8nwZAFtTSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5VnVEACjMassW+LA8hkhwz1y4j5n1mjIZ8SZ6fiTEGaWQL8rYjLxOgUgXGkYFm9pvN+J7QLa/J0
 kwfUDQC2q63pSaxDuoYPd0bKkAtHT0cIhfOHwShWZHJFHYlhM2kTWGam3lqBlNWSbmkaJ/PSFJG
 izjAuTQpr/hGSAtUaODKmZAelCteNelt+QKJPNSEx/oNYgG4qix4Hu6y4jaRoY8lEkxPLMgcX+O
 ynv6sf806KQtyFdoHHFWOCcvva+wnrXdvqUOHlH0rqQRM0nX4QsQ6lwE4B2+5hD9OZRT4p7xvXy
 WVaKmgnRUrMZ8vTE8IBIBzegPXJEUG9Ju1MphDcScp8KI/pRxCS8Vl3Gwg4evzpguovUeTXyZSO
 GPHs2ogxZ+Ncav7183eMqyL6ZwwOiXZgHPokXPi0fPHHPmj2JW5YVcFUqJMT8veyifJ1TcXfiII
 nc2sjtw6qbUeeTqk4T96JFRgdSFSYBQkSGkEwsHTMXZjbhbWNdbaVON7w2W68N4NosMq2osrKE+
 yIjVw2zOxdnUTx69Bc4tDeMqhoEXfkT+u7jpa/fVuMPxHRR8rn5q2kEia5qFV+JdMV1ermlYpTD
 i/qVlgENzYqQZKEMYXa8icxpQcTx6cVbBVKlyxnKW5pFFGQjFCmx97TPKhVsx5Y9FtUyIpcRd7V
 YRqW7paZbSGDPog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fixes: 73baa14be2d5 ("tests: skip HMP-dependent tests when HMP is disabled")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-create | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/iothreads-create b/tests/qemu-iotests/tests/iothreads-create
index 09fe57a09ac0..0c862d73f20e 100755
--- a/tests/qemu-iotests/tests/iothreads-create
+++ b/tests/qemu-iotests/tests/iothreads-create
@@ -22,8 +22,7 @@ import asyncio
 import iotests
 
 iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vdi',
-                                          'vmdk', 'parallels'],
-                          require_hmp=True)
+                                          'vmdk', 'parallels'])
 iotests.verify_virtio_scsi_pci_or_ccw()
 
 with iotests.FilePath('disk.img') as img_path, \

-- 
2.56.0.rc0.29.g47ce80527c56



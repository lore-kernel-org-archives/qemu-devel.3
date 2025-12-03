Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD6D1BDFF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 22:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQuux-0005zx-Aw; Wed, 03 Dec 2025 17:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1vQuuv-0005zM-Bv
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 17:01:45 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1vQuut-0003YC-6X
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 17:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=LePw1VNyQr6vNE/oGtZh5+sYM9rrAL+6CsvH+qYkE9s=; b=tTot88r1y1r5
 mymcR3YU5Mo55cuVz5MtkyujH69J4oNHcvl9UUyzA/0pUALNau0R14wEEqfOaPLQ+gaa6xnFt+ggr
 qJkABxxWKrR68CbddzHeeicOxYTIf7nquW/yNwND5TrXDcI+T1TdLK2o2DBZakNUAjvsD6T5QbPIx
 PmLVmP2xW4hCJdRYlh4gtuCTDu1kQpXgXLrhMRROyVEclMqiMpQoLOx5ZlgU1t8e0sDDpErOx6C6g
 JscVSr/8ZYks3ga6krCwxboUAcuTNi66stHrn8jZwsaEMwHMmZ6O43mT1DeH5eSqUNGxzjNzkLThE
 p0186JF4JPf+MamUbSM27A==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1vQust-008hm7-0h;
 Wed, 03 Dec 2025 23:01:38 +0100
To: qemu-devel@nongnu.org
Cc: den@openvz.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/1] scripts: fix broken error path in modinfo-collect.py
Date: Wed,  3 Dec 2025 23:01:38 +0100
Message-ID: <20251203220138.159656-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

sys.stderr.print is dropped long ago and should not be used. Official
replacement is sys.stderr.write

The problem has been found debugging building on some fancy platform
derived from Debian.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: John Snow <jsnow@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
---
 scripts/modinfo-collect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 6ebaea989d..db78b16c1f 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -41,7 +41,7 @@ def main(args):
     for obj in args:
         entry = compile_commands.get(obj, None)
         if not entry:
-            sys.stderr.print('modinfo: Could not find object file', obj)
+            sys.stderr.write(f'modinfo: Could not find object file {obj}')
             sys.exit(1)
         src = entry['file']
         if not src.endswith('.c'):
-- 
2.51.0



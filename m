Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF2606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzTvOdbf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfo-0003Ak-Dk; Sun, 08 Nov 2026 03:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyff-00037o-GF
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000vj-KZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AC8260D45;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9B1F008A1;
 Sun,  8 Nov 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=s/CW4Lo86N8uedhjC71Ed80A3/qQNRmMfhoExm5L3SE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JzTvOdbfcgKVBPi2BBsqnkCirnwyRnP603UjWKrTlVp9eRwLnNA1tGLUKbgMLSy/u
 eBCj1Xo4OuwdRBmwZ2uaxo4eZjPXXPWp0ODeQ+Axggtz+fvg3n5MWol9jjdNyqJ579
 E1+fMnFPidLidOPxeK684d+HLdAaAKD/JiRaqA997vUSPsU+lsia+udzGLxMbz8sRT
 El80lvUW+HnPkLkFxccbiMtARlqdxoav0EchjN+G5lOeIIQLwYIEzAQ3gUiN7K3Dwn
 EUFVDcXdRj7wXRQZ7BkNFBRvYiNr5JPtmu1uDLNzUj+k7ev8LMeweabXmLPO8CHGgf
 VerL8D0bSDwJA==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uih-0p51; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 01/13] scripts/qmp_helper: add a return code to send_cper
Date: Sun,  8 Nov 2026 09:54:14 +0100
Message-ID: <ca83c3f2cf9acc9abaabcddc1757744148921c3c.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When used inside a loop, it is useful to have a return code to indicate
whether a send cper command succedded or not.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 521612fb9461..a921a114cdc8 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -526,7 +526,11 @@ def __init__(self, host, port, debug=False):
     # Socket QMP send command
     #
     def send_cper_raw(self, cper_data):
-        """Send a raw CPER data to QEMU though QMP TCP socket"""
+        """
+        Send a raw CPER data to QEMU though QMP TCP socket.
+
+        Return True on success, False otherwise.
+        """
 
         data = b64encode(bytes(cper_data)).decode('ascii')
 
@@ -538,9 +542,16 @@ def send_cper_raw(self, cper_data):
 
         if self.send_cmd("inject-ghes-v2-error", cmd_arg):
             print("Error injected.")
+            return True
+
+        return False
 
     def send_cper(self, notif_type, payload):
-        """Send commands to QEMU though QMP TCP socket"""
+        """
+        Send commands to QEMU though QMP TCP socket.
+
+        Return True on success, False otherwise.
+        """
 
         # Fill CPER record header
 
@@ -594,8 +605,7 @@ def send_cper(self, notif_type, payload):
 
             util.dump_bytearray("Payload", payload)
 
-        self.send_cper_raw(cper_data)
-
+        return self.send_cper_raw(cper_data)
 
     def search_qom(self, path, prop, regex):
         """
-- 
2.56.0



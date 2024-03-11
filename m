Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BA4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje7l-0002fI-A5; Mon, 11 Mar 2024 07:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7j-0002bV-9z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:19 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7h-00020S-JK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:18 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710157621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+1CumBR5I1VKf7ct0/vCUjKk29R1fI/pfV+LJH6q3k=;
 b=t9qIXCEvhL9/qkiSufsD9EAQ8zqiDZIN5CFMdd2RsM6PipWhBD9Ei+muCbdZLfoBdhjiDY
 bNplayuam/cS+GQBafm2fjeEmcr9Vf04f62H7dhWrJCmjNzT5m6K3sUBvshPtkEKOSCVLt
 cmtVAnFxaCGzvezMUF9aSzdj14Jq+ID2cjuhXqKXCEIC6S2fCpN0aClhta6aUnA3QU3Sq6
 E+03vxUp4mwFoTphKvoGFnQPHRLE73DEQ/eJvfJkja2+7H1OG0mfDOnbL0TokJGCzpBNsw
 Xhy8cRiYNxaQdSPpVDafR/TvQqnShmmj5s9kL1dZU1aS8NpLJh3MyM2oLIlcGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710157621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+1CumBR5I1VKf7ct0/vCUjKk29R1fI/pfV+LJH6q3k=;
 b=+nDdStU5TWqDCBYuLYTI3WN0PehRGGtC9py7gNkA0tNjoNrV8h0+0ikUDFKRThVw2H+kHq
 NQg41AbMaycBZiBQ==
Date: Mon, 11 Mar 2024 12:46:59 +0100
Subject: [PATCH v3 2/3] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-qapi-firmware-json-v3-2-ceea6e35eb4a@linutronix.de>
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
In-Reply-To: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157619; l=1620;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0xHVxXWzD7VXqa5T4/TbmKlq8x2ymLkKndr+ZaAbuaQ=;
 b=x8vyiRjC6r+u1kSuZboX7dsEEmNEdAiZf+0YvX2VDlcwVr1wr479wzULc3tZ76lEUDSUZI/jA
 SIc0RRG+d6xCBuHz9hHqoLz0s3q3AlytlSFpJHgZlDqFtmmI+mScXP1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Only a small subset of all architectures supported by qemu make use of
firmware files. Introduce and use a new enum to represent this.

This also removes the dependency of firmware.json on the global qapi
definitions.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 0e619e8780e7..54cae6a51b43 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -14,11 +14,13 @@
 # = Firmware
 ##
 
-{ 'include' : 'machine.json' }
-
 { 'pragma': {
     'documentation-exceptions': [
+        'FirmwareArchitecture',
         'FirmwareFormat'
+    ],
+    'member-name-exceptions': [
+        'FirmwareArchitecture'
     ] } }
 
 ##
@@ -64,6 +66,18 @@
 { 'enum' : 'FirmwareDevice',
   'data' : [ 'flash', 'kernel', 'memory' ] }
 
+##
+# @FirmwareArchitecture:
+#
+# Enumerations of architectures for which Qemu uses additional firmware files.
+# The values are a subset of the enum SysEmuTarget.
+#
+# Since: 8.3
+##
+{ 'enum' : 'FirmwareArchitecture',
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+
+
 ##
 # @FirmwareTarget:
 #
@@ -85,7 +99,7 @@
 # Since: 3.0
 ##
 { 'struct' : 'FirmwareTarget',
-  'data'   : { 'architecture' : 'SysEmuTarget',
+  'data'   : { 'architecture' : 'FirmwareArchitecture',
                'machines'     : [ 'str' ] } }
 
 ##

-- 
2.44.0



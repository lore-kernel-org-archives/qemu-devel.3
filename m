Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF4606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EuADX6hS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoux-0002sB-Jd; Fri, 27 Nov 2026 00:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouv-0002rD-Br; Fri, 27 Nov 2026 00:54:41 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWout-0007Te-Fu; Fri, 27 Nov 2026 00:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=RvGSrjUl9fuu5uooqpGH/ivpThxsmLKVNk2sM9mjfMI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EuADX6hSMtQYVx2oDgRLDiU1ar+YuXguv04wRl3PWpqvpe8h7nSieI6jOODbAVRB4
 LiyefTM8oADBe/YhOxpOG9wCvz+Z3K14dQ/Ew/U7Sb3eZutOSeaR4eD1evvo9bttMi
 /KXzWunIWwNq7+Th8i+WIo/VxFUbKTpXsD3g5BWfsEPqlEU9SMkJO0QvcjhvM32VWA
 ZpKwENycbe+lPubBk8fFRphNeXqrO+fxIXkCo7hwjhwHYui2Kl2jyYTrGhumPgH3XG
 uSSOt2GIiRSRA5nzD2wPJD+lqF/EBbhV/izJO13avohOrKz9F3iOe9fXRU+8dhhalm
 jNUhcgYX3ErnA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9BFC81EA2C3;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99A20469901;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 92C1DCF20E; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 060/140] hw/core/qdev-properties-system.c: Don't
 leak str in set_drive_helper()
Date: Fri, 27 Nov 2026 08:52:46 +0300
Message-ID: <20261127055421.39015-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In set_drive_helper(), we call visit_type_str() to get the value
being set as a string.  This is an allocated string, and we're
supposed to free it, but not all paths out of this function do so.
In particular, the "block backend already exists, change the attached
node" code path does not free the string. This shows up as a memory
leak under the newly added virtio-scsi-tests/replaced-node-size
qtest:

$ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
  QTEST_QEMU_BINARY=./qemu-system-i386 \
  ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
  ./tests/qtest/qos-test --tap -k \
  -p /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi-pci/virtio-scsi/virtio-scsi-tests/replaced-node-size
[...]
Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x55f7744155e3 in malloc (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-i386+0x20115e3) (BuildId: 271ffb42d2e322de7813813d8c6cc85351e48a4f)
    #1 0x713dbd345b79 in g_malloc /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gmem.c:100:13
    #2 0x713dbd35b988 in g_strdup /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gstrfuncs.c:323:17
    #3 0x55f777208021 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x55f777208021 in qobject_input_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qobject-input-visitor.c:542:12
    #5 0x55f777204d1c in visit_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qapi-visit-core.c:349:10
    #6 0x55f774df80d1 in set_drive_helper /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:129:10
    #7 0x55f774dee9fa in set_drive_iothread /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:224:5
    #8 0x55f7767cc5c8 in field_prop_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties.c:89:12
    #9 0x55f7767ec12b in object_property_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:1562:5

Switch to using g_autofree so that the string is properly freed
all all exit paths.

Cc: qemu-stable@nongnu.org
Fixes: d1a58c176a11b ("qdev: allow setting drive property for realized device")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Message-id: 20261105114635.3286252-1-peter.maydell@linaro.org
(cherry picked from commit fc8bb17e47617cee165469fda64293909d0e8ec3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6b73127123c..bcab681fbe9 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -118,7 +118,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
-    char *str;
+    g_autofree char *str = NULL;
     BlockBackend *blk;
     bool blk_created = false;
     int ret;
@@ -153,7 +153,6 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
 
     if (!*str) {
-        g_free(str);
         *ptr = NULL;
         return;
     }
@@ -207,8 +206,6 @@ fail:
         /* If we need to keep a reference, blk_attach_dev() took it */
         blk_unref(blk);
     }
-
-    g_free(str);
 }
 
 static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.47.3



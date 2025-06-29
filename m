Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3478BC54ED1
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 04:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVjKS-0003Sk-EF; Sun, 29 Jun 2025 00:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVjKO-0003S6-Hd
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 00:07:40 -0400
Received: from che.mayfirst.org ([162.247.75.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVjKK-0003gm-UH
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 00:07:39 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; s=2019;
 t=1751170054; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=i8dX8alJGZ3xQObwr9oOs0ma4XzSxDxH8aPZzjvzCko=;
 b=SDJ3jxU+fUU6YgtGXWuz8LC6THKdaUi3Y4yTMUVhAKivIDCjm3+4XQ4EAgqXySYTawCzd
 LPZdVkmXjdRTfh3Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net;
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1751170054; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=i8dX8alJGZ3xQObwr9oOs0ma4XzSxDxH8aPZzjvzCko=;
 b=Q3JWMJAtwMGSUjFYNmvyJDmuhzvUM23Pixljs9FLleDrCQHnqvlP+nzkH9tulAR/HggAM
 EGXXIDdVLG9We5VFkXiXMWL7mhn83gFYTOhxHIwoK+eT+2vMScapWJ0vw9ZpvYhiK1brZJw
 u/2nCU+bmujdTuiPBJifw1o98cLbglYAvDFoLRmW+Y6T2IV6tcna20AWTXoMYy7sIHAUAlb
 SAmtUSww0VWGG6ZVUvZaodFche4rdDp0fOrxWRx3r3MATyVnlsXur8MRCO7OrzK4Ew6dFRX
 66jU6YTs7mB2J+Igc08zxr4gQqrMIAfa6ovqQ+ccG3hxdxGhrGzX46BnOsqw==
Received: from fifthhorseman.net (lair.fifthhorseman.net [108.58.6.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by che.mayfirst.org (Postfix) with ESMTPSA id E72C7F9B2;
 Sun, 29 Jun 2025 00:07:33 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
 id C769513F6BF; Sun, 29 Jun 2025 00:07:25 -0400 (EDT)
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: qemu-devel@nongnu.org
Cc: dkg@fifthhorseman.net
Subject: [PATCH v2 2/3] Socket activation: get FD by label
Date: Sun, 29 Jun 2025 00:04:00 -0400
Message-ID: <20250629040723.1696325-3-dkg@fifthhorseman.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250629040723.1696325-1-dkg@fifthhorseman.net>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250629040723.1696325-1-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.247.75.118;
 envelope-from=dkg@fifthhorseman.net; helo=che.mayfirst.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This uses the cached copy of LISTEN_FDNAMES to find the first file
descriptorlabel with a matching label.

Note that if two file descriptors are given the same label this will
ignore all but the first.

This is another step toward addressing
https://gitlab.com/qemu-project/qemu/-/issues/3011

Signed-off-by: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
---
 include/qemu/systemd.h | 15 +++++++++++++++
 util/systemd.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/qemu/systemd.h b/include/qemu/systemd.h
index f0ea1266d5..6b3f9a97ff 100644
--- a/include/qemu/systemd.h
+++ b/include/qemu/systemd.h
@@ -23,4 +23,19 @@
  */
 unsigned int check_socket_activation(void);
 
+
+/*
+ * Check if socket activation indicates named file descriptor based on
+ * the colon-delimited LISTEN_FDNAMES.  The "label" must not be NULL,
+ * and should be a simple text string that does not contain a colon,
+ * matching the FileDescriptorName= directive in systemd.socket(5)
+ *
+ * It is acceptable to ask for the empty string as a label.
+ *
+ * Returns -1 if no socket activation is in use, or if the label does
+ * not match any file descriptor.  Otherwise, returns the lowest
+ * numeric value for a file descriptor matching the label exactly.
+ */
+int socket_activated_fd_by_label(const char *label);
+
 #endif
diff --git a/util/systemd.c b/util/systemd.c
index 1eca2bd69f..7bf4a847b2 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -97,9 +97,44 @@ unsigned int check_socket_activation(void)
     return nr_fds;
 }
 
+int socket_activated_fd_by_label(const char *label)
+{
+    int nr_fds = check_socket_activation();
+    if (!nr_fds) {
+        return -1;
+    }
+    int curfd;
+    const char *nameend;
+    const char *nameptr;
+    size_t labellen, namelen;
+
+    labellen = strlen(label);
+    curfd = 0;
+    nameptr = fdnames;
+    do {
+        nameend = strchr(nameptr, ':');
+        if (nameend) {
+            namelen = nameend - nameptr;
+            nameend++;
+        } else {
+            namelen = strlen(nameptr);
+        }
+        if (labellen == namelen && memcmp(nameptr, label, namelen) == 0) {
+            return curfd + FIRST_SOCKET_ACTIVATION_FD;
+        }
+        curfd++;
+        nameptr = nameend;
+    } while (nameptr && curfd < nr_fds);
+    return -1;
+}
+
 #else /* !_WIN32 */
 unsigned int check_socket_activation(void)
 {
     return 0;
 }
+unsigned int socket_activated_fd_by_label(const char *label)
+{
+    return 0;
+}
 #endif
-- 
2.47.2



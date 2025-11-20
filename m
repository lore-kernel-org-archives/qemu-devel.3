Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79DCCFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM9r8-0002FD-Gi; Thu, 20 Nov 2025 13:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vM9r6-00029L-98
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 13:58:08 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vM9r2-00039N-QE
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 13:58:07 -0500
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AKFMA6G3828522; Thu, 20 Nov 2025 18:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=jan2016.eng; bh=FjOqyQa++JE6TOrpbSI0lMyf/aOkx21PN
 lgOXB20SU0=; b=ZDRmc0AoG+X3Y2Rzd2nYNgE7gIlQqlHtN2hBGYXTua/3QfTdR
 l1uNLUojiQ5/pBHgIPr6pUsGBU+xNGafeOSyT7M+VcCg5jZx0ZvYMrEiigahNsSq
 96YGh/2o4kiKtrAebf3mNufSAowRpO4MHAvNop5Ju1y1iQCDcoVup14jemqWcSRp
 V3VDkze4nrOv1Vxpg9vkk8MUVVtqiQ+upn2By0i+ijv39ZnXvOO4H5iFmb15QS2g
 FFK5IRbYDoPW87imXzbnLHJLp/MRWka8gBYOPcY2hRqpUHqJPMM82PJvO6EN8uPp
 2R3xpXGKVNv+T9PmXxH5o1lPhhdO3BHz4TQ2A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4ahph5044e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Nov 2025 18:57:56 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5AKF3juU003505; Thu, 20 Nov 2025 13:57:55 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4aenr1r0ph-1;
 Thu, 20 Nov 2025 13:57:55 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 121CF83;
 Thu, 20 Nov 2025 18:57:55 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
To: berrange@redhat.com, farosas@suse.de, peterx@redhat.com, armbru@redhat.com,
 mark.kanda@oracle.com, qemu-devel@nongnu.org
Cc: johunt@akamai.com, mtottenh@akamai.com, nhudson@akamai.com,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH] migration: cpr socket permissions fix
Date: Thu, 20 Nov 2025 13:57:33 -0500
Message-Id: <20251120185733.141912-1-bchaney@akamai.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_07,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200128
X-Proofpoint-GUID: WNJ9f3YiN1AlqtPcPKZ6IZfc8HEFN5I4
X-Authority-Analysis: v=2.4 cv=HIPO14tv c=1 sm=1 tr=0 ts=691f64b5 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8
 a=npA85jkPZQevBsCiEFAA:9
X-Proofpoint-ORIG-GUID: WNJ9f3YiN1AlqtPcPKZ6IZfc8HEFN5I4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEyOSBTYWx0ZWRfXxPFSz0aJOZyc
 43FI0jmgP1ERhJklcAjPcSKidaoIlmpLGcWBQkAHZL8zwYMQ3Uf+E3H/9+ifhoRfV55q/56LnUQ
 yFFbhVix0pgTJRAuEXIFPPW8DtxRcTbIr/3jQQOUpkg5E7UrY5sqtzB1cRqqM09HyuTZUUtKxkn
 kmy5b01Ym6M/U1rqnJRusZFwxsdAI2VJKDlXWZOT44uf/2fKKN/Cp5NO8XwrvaJ8EJgdRa+GHAo
 0kcxfPmFKi2dO+y6UMrNUhXEN4Y3lLvyUepZeeJKE3LBJPO/vNdBPKJe94dva9d8IsKCvVhbnu/
 5y/G16RXo3QxLjpf7pUiBGrr3gfveP9ybAAPDN6AQ7GFiJX96PJYf+uhzxRAbc21XJVikJTmYoL
 xgfgyiIsodjDFWVeRZZx9hF1pKdN/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_07,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200129
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix an issue where cpr transfer fails when running with the
-run-with user=$USERID with a permission denied error. This issue
occurs because the destination host creates the transfer sockets before
it drops permissions while the source host tries to connect after
dropping permissions. Fix this by changing the ownership of the cpr
socket to the lower level so it is accessible to both parties.

Resolves: https://lore.kernel.org/all/3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com/
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 include/system/os-posix.h |  1 +
 include/system/os-wasm.h  |  1 +
 include/system/os-win32.h |  1 +
 os-posix.c                | 12 ++++++++++++
 stubs/meson.build         |  1 +
 stubs/os-file.c           |  6 ++++++
 util/qemu-sockets.c       |  6 ++++++
 7 files changed, 28 insertions(+)
 create mode 100644 stubs/os-file.c

diff --git a/include/system/os-posix.h b/include/system/os-posix.h
index ce5b3bccf8..e4b69fc316 100644
--- a/include/system/os-posix.h
+++ b/include/system/os-posix.h
@@ -54,6 +54,7 @@ void os_set_chroot(const char *path);
 void os_setup_limits(void);
 void os_setup_post(void);
 int os_mlock(bool on_fault);
+void os_set_socket_permissions(const char *path);
 
 /**
  * qemu_alloc_stack:
diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
index 3abb3aaa03..eeac092183 100644
--- a/include/system/os-wasm.h
+++ b/include/system/os-wasm.h
@@ -57,6 +57,7 @@ static inline int os_set_daemonize(bool d)
 };
 bool is_daemonized(void);
 static inline void os_daemonize(void) {}
+static inline void os_set_socket_permissions(const char *dummy) {};
 
 /**
  * qemu_alloc_stack:
diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 22d72babdf..79e42ec297 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -103,6 +103,7 @@ static inline void os_setup_post(void) {}
 static inline void os_set_proc_name(const char *dummy) {}
 void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
+static inline void os_set_socket_permissions(const char *dummy) {};
 
 int getpagesize(void);
 
diff --git a/os-posix.c b/os-posix.c
index 52925c23d3..bbd17ff2b9 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -94,6 +94,18 @@ static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
 static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
 static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
 
+void os_set_socket_permissions(const char *path)
+{
+    uid_t uid = user_pwd ? user_pwd->pw_uid : user_uid;
+    gid_t gid = user_pwd ? user_pwd->pw_gid : user_gid;
+
+    if (chown(path, uid, gid) < 0) {
+        error_report("Failed to chown socket %s: %s", path, strerror(errno));
+        exit(1);
+    }
+}
+
+
 /*
  * Prepare to change user ID. user_id can be one of 3 forms:
  *   - a username, in which case user ID will be changed to its uid,
diff --git a/stubs/meson.build b/stubs/meson.build
index 0b2778c568..4a4342344b 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -24,6 +24,7 @@ if have_block
   stub_ss.add(files('ram-block.c'))
   stub_ss.add(files('runstate-check.c'))
   stub_ss.add(files('uuid.c'))
+  stub_ss.add(files('os-file.c'))
 endif
 
 if have_block or have_ga
diff --git a/stubs/os-file.c b/stubs/os-file.c
new file mode 100644
index 0000000000..c32cbc7efa
--- /dev/null
+++ b/stubs/os-file.c
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+void os_set_socket_permissions(const char *dummy)
+{
+}
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4773755fd5..77b2d9287b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1026,6 +1026,12 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
         goto err;
     }
+    /*
+     * Change the permissions on the socket to match the permission of the
+     * counterparty process
+     */
+    os_set_socket_permissions(un.sun_path);
+
     if (listen(sock, num) < 0) {
         error_setg_errno(errp, errno, "Failed to listen on socket");
         goto err;
-- 
2.34.1



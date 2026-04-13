Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE4DF34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKa1-0004Kc-Ru; Mon, 13 Apr 2026 12:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKa0-0004KP-27
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:08 -0400
Received: from qs-2004g-snip4-7.eps.apple.com ([57.103.84.70]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZy-0006Ns-I8
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:07 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 0110B1800279; Mon, 13 Apr 2026 16:56:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099365; x=1778691365;
 bh=ToEMsnEimqSsQl70dsHQJi59glSBxpGleQUdKNrc4Sg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A1WZd7/jNpV6XPtSPQXNrZ/1LPOL7qzxFE/drbXPvN0H9TUKkQgu3T9FWsuItq2quM0cIiIfQB4ZexJfDiovnTsT8AX9OjG1z2PbakqwtjdcoYJEssaxreNGJXFjvrgNTDU56IhSJNpE2kPT1ka4iy0+z0KYUpvnyvPoKvQgl6YlqWnVV3/6nAwRaxGRObZJvRdYYeaIydZ4MzmO7693Pqjk5JNE5qsu7JbViqso0guC84ZjwJ3qKNvNBWM6hnlCdVJC2m35yeYOIEEJAr2Jx/zsNkDgMgrCZNY/hdu3dZDK8UaAA3Y3g27OhqYb1LKgyMVy6VY+C5regAEysb4IFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 3E94E180057D; Mon, 13 Apr 2026 16:43:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gal Horowitz <galush.horowitz@gmail.com>
Subject: [PATCH 3/3] tap-win32: allocate separate tap state for each instance
Date: Mon, 13 Apr 2026 18:43:38 +0200
Message-ID: <20260413164338.42894-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413164338.42894-1-mohamed@unpredictable.fr>
References: <20260413164338.42894-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=eKYeTXp1 c=1 sm=1 tr=0 ts=69dd2023
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=UVr0gZAdEIgvgD1kzycA:9
X-Proofpoint-ORIG-GUID: t4_NenBNUQtl75rsT2b_LVfeaU-PQDb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX5ISTb7o41Yzd
 9DxXFLQWZFJtSnGaJZ7yuxgqgCN5ndD1BjAjJDzHtBOXdHXnA6Zei0+rCS2B7lNSN+e6heVTfgz
 ZFlzfYC3fq2iR/onmegYq2fhpquldLAmgZ+C9Y0jhYDb4EJD/oRIbla+1fKYCqac6vBCSlKLuVL
 nmVS9+dnudFvceKBIO/QlOrcaR57CYqUydr9QODulUAsKtcvejuXxAZF3gm9OjVcoZMy52EyiaA
 YGi2PyF84wTs9yf1irbvn3cHpaCQ0pp8MmaWxw5Aa87Xik8i9t1ybMFeL12IslM+tAxnJP6iLIB
 AWiO2SlIQqJT++Rr2fNqBXZJfiO2ouqCaORq2eW+seUhWcQWyw8H3UMYZj8vN8=
X-Proofpoint-GUID: t4_NenBNUQtl75rsT2b_LVfeaU-PQDb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.84.70;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gal Horowitz <galush.horowitz@gmail.com>

A static global is incorrectly used as the tap state for all win32 taps
created. Instead, we now allocate per win32 tap.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index ae25e5a883..3d7227fcf4 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -115,8 +115,6 @@ typedef struct tap_win32_overlapped {
     tun_buffer_t* output_queue_back;
 } tap_win32_overlapped_t;
 
-static tap_win32_overlapped_t tap_overlapped;
-
 static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
 {
     tun_buffer_t* buffer = NULL;
@@ -403,8 +401,10 @@ static int tap_win32_set_status(HANDLE handle, int status)
                 &status, sizeof (status), &len, NULL);
 }
 
-static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped, const HANDLE handle)
+static tap_win32_overlapped_t *tap_win32_overlapped_new(const HANDLE handle)
 {
+    tap_win32_overlapped_t *overlapped = g_new0(tap_win32_overlapped_t, 1);
+
     overlapped->handle = handle;
 
     overlapped->read_event = CreateEvent(NULL, FALSE, FALSE, NULL);
@@ -455,6 +455,8 @@ static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped,
     overlapped->tap_semaphore = CreateSemaphore(NULL, 0, TUN_MAX_BUFFER_COUNT, NULL);
     if(!overlapped->tap_semaphore)
         fprintf(stderr, "error creating tap_semaphore.\n");
+
+    return overlapped;
 }
 
 static int tap_win32_write(tap_win32_overlapped_t *overlapped,
@@ -625,6 +627,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
+    tap_win32_overlapped_t *tap_overlapped = NULL;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -666,10 +669,10 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         return -1;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
+    tap_overlapped = tap_win32_overlapped_new(handle);
 
-    tap_overlapped.thread_handle = CreateThread(NULL, 0,
-        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);
+    tap_overlapped->thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)tap_overlapped, 0, NULL);
 
     if (tap_overlapped->thread_handle == NULL) {
         tap_win32_close(tap_overlapped);
-- 
2.50.1 (Apple Git-155)



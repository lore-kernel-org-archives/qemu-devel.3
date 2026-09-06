Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20959C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dm-0002Iy-Su; Sun, 06 Sep 2026 04:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dl-0002Ib-SA
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dk-0000mb-7y
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHplSF0uv9FiqiAOekaEuFDuITCtR35X5p8OCNEkDU4=;
 b=TPwb01J97Jddb4qLj0pOYOJRH2yBQapnpsUl9ChcVTwClBqog+vyomZx8ikaFH9R0aofpO
 txnutkJPTpdNT2TVbxhlMX/v7gZdovMWIpf6ydvzaQ8n08XuhNQFFgtRoDxfwHE+HVvBTN
 CXKLMWKa1GA1fRouKfBTiLUwplAPPJU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-puCfoicMOO62ykvfd6_SLA-1; Sun,
 06 Sep 2026 04:54:12 -0400
X-MC-Unique: puCfoicMOO62ykvfd6_SLA-1
X-Mimecast-MFC-AGG-ID: puCfoicMOO62ykvfd6_SLA_1788684850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3FF81954234; Sun,  6 Sep 2026 08:54:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D47C1800598; Sun,  6 Sep 2026 08:54:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:37 +0400
Subject: [PATCH 5/9] tests/launchupdate-test: correctly release qs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-5-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KV3NOMsdSPu91AOYmgCOfD8KeD0yoFJPlKPZaUobNYo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoYF2ZdHROn+xfabhY+IDnwOoIL2tZfqvF7P
 pQCbBdjYHOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5WKFD/9XYOrtNOdlsmxZeylVk44Tmlg0QTw9+nIqKWHeCK/MPX/lVH3bXaG4pUwGwT7J9Fl8aWZ
 DZTK6ynC0M59OkjOpgn+A1eaixm0cw4CrvWlXLjZpjeaHoCBP1TQlgGDbnzFsDJNvCLLJ/ON9q7
 /3xy6bNPSkNFH0jSkw4WK8ytI6elcBU1TOv8oOKu2CCn4qWEcde+Q165LDf7MpMt+gyAZNYptZy
 JTnnJmYrAq0eSVqrB2dRGsNd8itdgKBQ2oKfXxviulB2gMatkDj07AsuKaSRMQCfQkMIrGJuDar
 aTSjXl5iM95K6Us9b1Shpj4qJ7jFD2PHEadZXeFZWrd63EaPQYfOrqaGM1cnJx5rlAxUxMOhEUi
 y0WY6M9ZTtDOtbGmvc+Qh8LYHwkjWF7hFzvJwcn2F+wQTLMOOtRJ4o2AOV3VugcMGaVaT3i8wvE
 9ZKf13S0hR9XIPDJg8GHG/3pAHxmNJgP45ec5c8mXKK3tQSgqIuxAm/Qnz4wT7xSPvNjOV7LVVw
 x78XAOBewMu9yN9QUp2dlR+wzh/aSSPfvbX9vSdn9Go02jq0RsFu+DyWSd7ETqFDq561i9X7Hj7
 0yWLc2VKHMGSBP7+lhlUc/tDC+t1+ztMiMjN4Gu+0lBAoMaJpuwfopnubrgivcB/11KQ0VBvJMz
 KZLY/uk3lQfVQKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QOSState must be released with qtest_shutdown().

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 14 +++++---------
 tests/qtest/libqos/libqos.h     |  2 ++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index ed007cdce29f..12a09079ae91 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -51,7 +51,7 @@ static void test_vm_launch_update_capability(void)
 static void test_vm_launch_update_disable(void)
 {
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
     uint64_t control;
     size_t filesize;
@@ -95,13 +95,12 @@ static void test_vm_launch_update_disable(void)
     g_assert_cmpint(VM_LAUNCHUPDATE_CTL_DISABLE & control, ==, 1);
 
     pc_fw_cfg_uninit(fw_cfg);
-    qtest_shutdown(qs);
 }
 
 static void check_error(void)
 {
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
     uint16_t status;
     size_t filesize;
@@ -149,6 +148,7 @@ static void check_error(void)
     status = le64_to_cpu(launch_update.status);
     /* should fail with LOAD_FAIL since it was not IGVM format */
     g_assert_cmpint(status, ==, VM_LAUNCHUPDATE_LOAD_FAIL);
+
 }
 
 static int64_t get_image_size(const char *filename)
@@ -326,7 +326,7 @@ static void test_load_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!trace) {
@@ -456,8 +456,6 @@ static void test_load_igvm(void)
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
-    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
-    qtest_quit(qs->qts);
 }
 
 static void test_set_ctrl_once_and_reset_to_host_igvm(void)
@@ -475,7 +473,7 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!qtest_has_machine("q35")) {
@@ -585,8 +583,6 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
-    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
-    qtest_quit(qs->qts);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
index c04950e2b19d..b2d02825a9af 100644
--- a/tests/qtest/libqos/libqos.h
+++ b/tests/qtest/libqos/libqos.h
@@ -42,4 +42,6 @@ static inline void qfree(QOSState *q, uint64_t addr)
     guest_free(&q->alloc, addr);
 }
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QOSState, qtest_shutdown)
+
 #endif

-- 
2.55.0.543.g5ebe2ebe4ea8



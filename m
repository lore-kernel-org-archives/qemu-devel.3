Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KgYjG+Ah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrGs-0006ft-GJ; Thu, 22 Oct 2026 07:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGq-0006el-EC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGo-0007C8-Qs
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unQXSTQTZoQiah9mbg1f2OYCq0ukmOFPU3aCLL6PWvQ=;
 b=KgYjG+AhYWcpvNFjBJhQBglkFFfXFuXQ8duivCxIM9O377jyEuel2fF3PeOQzIL5TqUY83
 /9Easi+mg+ioPVxyGzBvjV3F9H+sag8yYyrD+i8POhnxpw9Va5Ry5A/6vkX81QVEwwWTaQ
 BNBmYfv1Wi6Hhc5bD8qMOZvaGoRuatM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-924toFSGNaGXadNsJ7lNOg-1; Thu,
 22 Oct 2026 11:47:40 +0000
X-MC-Unique: 924toFSGNaGXadNsJ7lNOg-1
X-Mimecast-MFC-AGG-ID: 924toFSGNaGXadNsJ7lNOg_1792669658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E09E518011DE; Thu, 22 Oct 2026 11:47:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D22AD1800642; Thu, 22 Oct 2026 11:47:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:15 +0400
Subject: [PATCH v3 02/10] tests/launchupdate-test: correctly release qs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-2-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SIfxG9op7mrpLLVcQw4l/GNNVlnSFKeBptsXHMfpnlE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffNT2E7uYx5WkzYIH8aCzY4N1jYpiiEHgYcA
 qAAgvO+nwmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5er6EACrfimLDCz1+JmJMXF5rWkqxMphDRQkH1QSVRAW9POODONAkqjiKW5TUkcIPwF/BNTr+w3
 J3D/1wf00dCQ5zO3z90DAxNAt41Ra8VPgzEwY/eLdIU8bbThi3L0KtvgQ4FfoURQdtw39cSiI34
 RbXiS3Ao9dJr7gVITW/tFLf3g/iZ6vfbuyOtRtc4HW4JXJRq1MioI3zWu72uDNYBJ0Ziua+unCq
 EwoBJuKCB6wYJ8DyseLJb07SlYrIWlxCN7NUuCtfu0qvQ2nDkWhgoX16XyFVTjHyt2Eg2+3YX4g
 SA2mXQliyqfN89uSaCJy8oa3yDaFFV3a0sgBiqBEtxNCIRbztTZ3vBhJLVLLlt156Q6ptKdLYwo
 wnb6eLwFgWn5TbATB7vftLx53Wwk2ebPw+pCVagQyDBvwsyV4+Ei2jlAOUrxalh0ZwemFgdy6Sg
 YTC0k9WQN99DG/rgpR8xRP02PBDzT6DPierxOsK2FCT2QYJjhSbAGCm/YHSfy+qw05q96traM/a
 P7ffNF2HYJDM+FItua7ZTgaAJAkeIk4+o1fGwUS/31ifUJm8fXS4Cg11pprul3aXHDh0th4wZJp
 MKTtsLfHduCXY8UHzCvCDNqhN8eHS3DiDg4HPf478C7oO5IiOTa1AfpMe23IAUlEpbiMY87vdU/
 m80Z9Rtdp63lzpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QOSState must be released with qtest_shutdown().

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 13 ++++---------
 tests/qtest/libqos/libqos.h     |  2 ++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index ed007cdce29f..ea35da81feb9 100644
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
@@ -326,7 +325,7 @@ static void test_load_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!trace) {
@@ -456,8 +455,6 @@ static void test_load_igvm(void)
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
-    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
-    qtest_quit(qs->qts);
 }
 
 static void test_set_ctrl_once_and_reset_to_host_igvm(void)
@@ -475,7 +472,7 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!qtest_has_machine("q35")) {
@@ -585,8 +582,6 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
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
2.56.0.116.g6de20f6092dc



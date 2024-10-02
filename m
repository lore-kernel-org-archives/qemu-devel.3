Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8389DCF31A4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svusA-0002sa-Ir; Wed, 02 Oct 2024 04:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svus8-0002lY-9n
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svus6-0005lq-Ld
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8/u+VPoMiEM0MMm1KzR655zodS3TzdLVN+AaPgKy20=;
 b=H7C9dU0nVyxS5SY3q7d0y0D9xi1RmyVy9kwT5e4djqWtelbwOxHqHVRK/aa3VlNC7yxzIY
 OY7NdBk2TD3j4ToVG+HAU+F/al6G3sZqm2HIKaLlSZ35Cs5SHfZVbO7rp15HQCt7HuoSM/
 Xk05Kw/trZDxKP5yIEkCm+UqvW51c1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-fAqlNs8uPiesTnKiNgRS1w-1; Wed,
 02 Oct 2024 04:38:08 -0400
X-MC-Unique: fAqlNs8uPiesTnKiNgRS1w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D095B1955E8E; Wed,  2 Oct 2024 08:38:06 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9054D3000197; Wed,  2 Oct 2024 08:38:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 16/22] target/loongarch: fix -Werror=maybe-uninitialized
 false-positive
Date: Wed,  2 Oct 2024 12:36:39 +0400
Message-ID: <20241002083646.2893078-17-marcandre.lureau@redhat.com>
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../target/loongarch/gdbstub.c:55:20: error: ‘val’ may be used uninitialized [-Werror=maybe-uninitialized]
   55 |             return gdb_get_reg32(mem_buf, val);
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/loongarch/gdbstub.c:39:18: note: ‘val’ was declared here
   39 |         uint64_t val;

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/loongarch/gdbstub.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 7ca245ee81..3a03cf9cba 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -34,26 +34,28 @@ void write_fcc(CPULoongArchState *env, uint64_t val)
 int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPULoongArchState *env = cpu_env(cs);
-    uint64_t val;
-
-    if (0 <= n && n < 32) {
-        val = env->gpr[n];
-    } else if (n == 32) {
-        /* orig_a0 */
-        val = 0;
-    } else if (n == 33) {
-        val = env->pc;
-    } else if (n == 34) {
-        val = env->CSR_BADV;
-    }
 
     if (0 <= n && n <= 34) {
+        uint64_t val;
+
+        if (n < 32) {
+            val = env->gpr[n];
+        } else if (n == 32) {
+            /* orig_a0 */
+            val = 0;
+        } else if (n == 33) {
+            val = env->pc;
+        } else /* if (n == 34) */ {
+            val = env->CSR_BADV;
+        }
+
         if (is_la64(env)) {
             return gdb_get_reg64(mem_buf, val);
         } else {
             return gdb_get_reg32(mem_buf, val);
         }
     }
+
     return 0;
 }
 
-- 
2.45.2.827.g557ae147e6



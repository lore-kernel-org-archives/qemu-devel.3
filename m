Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC11C61DDC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03PE-0004zB-74; Fri, 28 Aug 2026 16:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P9-0004st-Fv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P7-000817-VL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH342i7ovU6fuSWv8VZMyWgs9nCmCum2lZ7GYnWp7ko=;
 b=a4QYLEuhCGaSGwlyVqrhALkQm20Yi8toj+mExkojvE9czZUSNv3DuTTRTKSavmQh5mkxck
 Ef3dPTFQpipREvz6vUts4TNpyZ6WjWqUK6ctBnOMEH23k8ConpMP+qz7NRRel3Q9mkz7Ad
 8aduTzjVwO0djHYtnHldOwPomZJB1SU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-b-gvuYlqP6uFmS9La_ZU6w-1; Fri,
 28 Aug 2026 16:42:23 -0400
X-MC-Unique: b-gvuYlqP6uFmS9La_ZU6w-1
X-Mimecast-MFC-AGG-ID: b-gvuYlqP6uFmS9La_ZU6w_1787949742
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFE31802579; Fri, 28 Aug 2026 20:42:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A65673001D3E; Fri, 28 Aug 2026 20:42:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:45 +0400
Subject: [GIT PULL 06/50] target/i386: return an error for invalid CPU in
 hmp_mce()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-6-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ri5Qp3clebQ3Ozsg1j2jOh9Qizc+flc2SoDeyDGSLp0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKTf7wih3WGXkDwAGa3nzzjJcmIhfq423VZM
 9D3VvD1iIKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5XS3EACgAbHGkHiI0KeQ/vbAwAG3n8bWGi09TwrngWngrO8l6YxSHmvDUEXN2LCwQLVMzEQhqie
 aeQhT8chNv9TBRQFOTZDXk3LC71Viqf3NOrAhCYHLr52XA9wevB7Yt7alBO/QCPgw2SPYa4XW2Y
 wssiAcbLlcWDV1DeI8/Erw5j/IG7op2BUUO0QbVZi3qJFOOZ42ASch9DVFFJ+fQYV0bUwZU/P9T
 oQYdYOh5m64W5JEDM8yrofIgTz/mGeQ4TudUoqAjvs/OMjCWrJgDahcLqCu6sJ4DjpdMjyZTMrE
 J8FEw/qH8QsbwIIvYht0mcxLpb5GAjJcYYCK9Ux4i6zwplPKU8t+SC8+Mk+WdxY1q9gsSixkntS
 z+tS4onXtWNvCM3G2mLWQA4yvNPrdH8JMy+L3Yu2B3GwR6EUfEY4dEkanfiervxiM4QhnWw7KIe
 ToRVqJdAkaJvAAvmzFeyTGZjYYNpUmnLiXQwhUhq/9lZADOD+TYA0F9lyDyfNM5KW7n+wOtDwQA
 6NZkU3idFk9DyyEmqbGte56WIMwulZHFpAE6oLqYGncIocgJ/FvaUbqoHW/OG+3zg1cs2eeTvhC
 emUYTLKN6xnkuCYV4NvcqaAFBHZrr3ajt5jl1lPhNkR8+7jfQ1VEH/kZmivO5Qb28MY3j0SAYFH
 gl0JzUerB5LTLjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than silently doing nothing.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-6-9227de146347@redhat.com>
---
 target/i386/monitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 785a13dd7107..9ed772e6d7f2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -586,10 +586,12 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
         flags |= MCE_INJECT_BROADCAST;
     }
     cs = qemu_get_cpu(cpu_index);
-    if (cs != NULL) {
+    if (cs) {
         cpu = X86_CPU(cs);
         cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
                            flags, &err);
-        hmp_handle_error(mon, err);
+    } else {
+        error_setg(&err, "Invalid CPU %d", cpu_index);
     }
+    hmp_handle_error(mon, err);
 }

-- 
2.55.0.543.g5ebe2ebe4ea8



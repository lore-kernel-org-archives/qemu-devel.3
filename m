Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C385C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXg-0004Oo-S0; Tue, 25 Aug 2026 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXa-0004OB-6Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXY-0003tl-L3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryj4j8cwb+L87RB5THQx359dU0bCD3EIL92GqKreHVI=;
 b=aJ+xVkq1Z7umEqPRcT1tCcNRNFqsBxZhcPL9u3yGIauKIYczjGKDrMU52CHICpON2Dh2vn
 W3YpWzDrR3kjCK81JVJP5Jpub2cbZH/gYiTRVzM//zkjMpIxqQlnKi+25/EDX33lQWppyF
 y2L4be/WiavnJIe9QtIGnggMHbYZFUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-4vMwDe4AOUSToOPPQoXIqg-1; Tue,
 25 Aug 2026 15:10:28 -0400
X-MC-Unique: 4vMwDe4AOUSToOPPQoXIqg-1
X-Mimecast-MFC-AGG-ID: 4vMwDe4AOUSToOPPQoXIqg_1787685027
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A455318C0FC9; Tue, 25 Aug 2026 19:10:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 482EE30002F7; Tue, 25 Aug 2026 19:10:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:13 +0400
Subject: [PATCH v4 06/49] target/i386: return an error for invalid CPU in
 hmp_mce()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-6-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TKMHsISeJFnOg9PU9gqpis8lZrnYbUihXFpgcYqdi0w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiGqM9WwVS4Y2nSmBNTZSwylyveYfkGoZpO1
 v1mImSGiX+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohgAKCRDa6OEJdZac
 5Up2EACLlkc6zCy2Yfu8ik+h5akwz85iFWyMrtJ7S6CtRXot65WURkLLWv3R65YiIOgKkhflnfp
 oIYRWJATiCbW28lkgiX9dH/my9CnriNhYDGA3tDGf5j8uffsqZkyXeshq/K5pyJ/bQDnszOlqj2
 RRTYImJdkGAKiPUbkluGAv+C23uq4rTl1cfX1HrkeC5ayjLKnYfgbCmgyh4snbPWQNoVYFTI0YN
 8JWLWylga1IfonV/cvqDjVk7umwXy6NJyGowJjCrd1eMrOEqD5GFJEv3PdJwpOs5ISjioZKnO7y
 bXlgIBqTRkaBZjEHHoQzvHlbVvWUyCfVlTIRxfvnRbW8pKXeruCr2NiAmWQgEybZg4kX79KvKQu
 CRnQe3pngA9nNkubAWCyS9/ko+vdFe+RD7NFWE16zhrRxdV+ub2ymAu275Xn9ycjg7PLGe7LIn8
 CsoD5a2YKUdE2Wt74Nz1YWf4g7tKAftDFuEoaNGX1zLQh/ZhT80V3hrtJ+3OccEFHAuyRuS+LmG
 eJAmCeb7W9KHglfgBvFUPFCH9z3Babdz6swTSdr2M5nLDo1elOOpM5j7HorB4LZVx8MN2h5sa/f
 rQkdu11HIytO7I2MneKFcVlyScUik7SLkR10ViVn/tmWj4cYBTOPtScUp79PAf2SwxCs2XxmH3P
 Kbv17N/3IEWJ01A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



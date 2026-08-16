Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F2DC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIZ-0008NV-01; Sun, 16 Aug 2026 15:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIO-0008Kh-EM
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIK-0007Hq-Tb
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryj4j8cwb+L87RB5THQx359dU0bCD3EIL92GqKreHVI=;
 b=VglvaMB1mIIvqL07p/XWWXA0SIHYNsX/L7TcNbRCR0LbNKLscHbiLajCcHNsVYfhl0lvA3
 mGAKIj1ZyOhI1td9d1J1ufXucp+aUVl2cYaSodHPosygNnpgvSeV4d2vwcGyqdN4nzzrae
 FatkGFJvV8taKFQhEivyO0r75/a095I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-KVXtn_asMoeoWKj5HxfNsA-1; Sun,
 16 Aug 2026 15:13:17 -0400
X-MC-Unique: KVXtn_asMoeoWKj5HxfNsA-1
X-Mimecast-MFC-AGG-ID: KVXtn_asMoeoWKj5HxfNsA_1786907596
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BF9618004A9; Sun, 16 Aug 2026 19:13:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BC1918005BD; Sun, 16 Aug 2026 19:13:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:32 +0400
Subject: [PATCH v3 05/49] target/i386: return an error for invalid CPU in
 hmp_mce()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-5-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TKMHsISeJFnOg9PU9gqpis8lZrnYbUihXFpgcYqdi0w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguwZtExIYvtqBlpUM2ZCcMdXuU1TQdSl0nbD
 ft0JxNV+QmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5aJ8EACQlLFUtB76czn0TH8+B6lkqCawWnN6mqikLSB2U1AMhyEsHqmNHjh/IpP4AFBcKHvbIkL
 65pZZmBIeFPpcZy1kZgOwOBU4iYONKpVXgUTd9lBu7C+pExo73e9yPtv34VMrhItTgnZN+GY/j9
 9pIPBOt7K3JPfLtykXZxFSt2iqp9QuC16R2W6qE2JdaNl3XjQmClSzqQ2tXi7UYmhZmifyFrgH3
 IkR7B8aAcG7XAJHjBtuGBOaDUv0zXwFeGbS9IZeVazzbc+cVv+Zr8w6jmrSqTFBZVZMIY7AjKIk
 mFgJKEu3iXvzS2mmjbn4+idOHNNLTs7Lb6fpDX7+8Bv2UI25CcAX79LGLm1idx2s3+mM6IjG1yx
 T6RIk2YdcXNUSCm5ZgUaGSDDPvDIeqYpkOdFdxMzB3U48Uyy/XNbtXMcLUJalpXjCUohCS0HQyP
 5dkpiWrGRC7QkvzBCu7qHocsXn9JV+GIs8jwRo+7ds5Z5gmHJHin2XgFFB4WlfKYE0aNP1jkiBG
 Z9ZcOKbz31egB54aQtV1GLXfPNYBki0ul/Q0Vqrmn7rRV2/D0jI9lfNwa+I3M8Q2CDY6yG91jnn
 97XK/iLsJazMU0vXffvMKTOIhVTcf/B7e6+hC/HvJlg2GL9ZvJC17Vo1Q8qjRzVYEtyLedAKy1H
 YOBVtNJWU0+h7gA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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



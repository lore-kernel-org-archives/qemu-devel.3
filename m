Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21CCC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwD-0007oG-5L; Mon, 07 Sep 2026 06:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww7-0007gI-Nt
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww6-00081z-6D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ST0fyxzJrNhhEnLARHNRMF08O5d8Q0ORWVDRaq2tVSY=;
 b=gF5FP71A6DCXdWPMQD6gqktLZxxMCQTx6k/hpZ3L7TLkCmh45ULd/niP9cY9VsWHWfXb0J
 8hry0Y2M3qHCqEiEAskptEaCHiz6ZX115c5m1R4hEvOV/Rh+6CGWUY9jlCtnAxlYH0Z6Fo
 2WlvprEtuEmbJv8kzlEbC7X5eRbaiHI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-aY9AYc7LOWq-lYKFlDuDqw-1; Mon,
 07 Sep 2026 06:50:48 -0400
X-MC-Unique: aY9AYc7LOWq-lYKFlDuDqw-1
X-Mimecast-MFC-AGG-ID: aY9AYc7LOWq-lYKFlDuDqw_1788778247
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C8C218052C1; Mon,  7 Sep 2026 10:50:47 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 321FE1800348; Mon,  7 Sep 2026 10:50:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:09 +0400
Subject: [PATCH 11/17] qga/vss-win32: avoid CRT calls in DllMain debug logging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-11-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=64B+Bikb2SGpjZ5/w751HOhMYINM9fWlaj0840TMvBI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjxC8GjeDh8/r6d/kfMN2KBvl3mxko8n64f
 nxEfSWxhKWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5U9BD/0dkfDj1FXwJBiYzXvqbBiZUR9RIq+dDLYpkiwZrwj4HctrDlFkgAm8aAGWPqh3tcJnxFd
 kFzYxblfo0tqoMqm1R0swMfOQKI6VedoHiXZzpq8NzKDp455Qn2vKxGSww2UQxrJHeEdtnsvJ+8
 036o65e87IvFvz+5yKOVz6Z32L1Z4dxXEYNVsb4ayFUklFtvW/qFulhIaNw9ckW4WjQbnAQgEi4
 m4fmRYyOaQgnNd+K9U/UBDHKtZ17jQx6rm4Uv4tpzd3pYhH0mowFQvbq4D6oxgIya5XQ1PTl3/A
 LIo3+f5SIhabuRLZrirmlGaD6x8fpSzNg3Rstp/Ud5kP26OkE6b50JboSPcKTBeCVRQszcBzJzH
 ZlYIkn/NKGMXkzL5xYsNeqBP4GsokxtA5HFmq13WWb8LqY3/N4xgYMMxUTuObWKkE0E2QhEJaRb
 Rv+4jvakPyntPJSQVt9Z15acEB6D4xomAEBMPn+LubQTdz/k9uiaWDum7MARF9naGLC9wP+BsQ2
 9ggyD3zvcLskGVLm/CfdaA1BoCqIAPjqqLp7gNGNDV9Ii7CsE2oymtALf73QZMcfNqGjuINqEPR
 jn500p42Iu2oS48nIkvXbiCmiUZy73EIVti/Zxgo3uGx45/ZfCMybReFX2owyDvRnnLwQI6RnTT
 yQ72g8ZlJa9Wupg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

qga_debug() uses vsnprintf, snprintf and fputs while DllMain holds the
loader lock. CRT I/O can deadlock under the loader lock. Replace with
direct OutputDebugStringA calls, which are safe to call from DllMain.

Fixes: 61df91b33caf ("QGA VSS: Add log in functions begin/end")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/provider.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 44c3c74bd2f2..1c8eb236e57f 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -536,11 +536,11 @@ BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved);
 EXTERN_C
 BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
 {
-    qga_debug("begin, reason = %lu", dwReason);
+    OutputDebugStringA(QGA_PROVIDER_NAME ": DllMain begin\n");
     if (dwReason == DLL_PROCESS_ATTACH) {
         g_hinstDll = hinstDll;
         DisableThreadLibraryCalls(hinstDll);
     }
-    qga_debug_end;
+    OutputDebugStringA(QGA_PROVIDER_NAME ": DllMain end\n");
     return TRUE;
 }

-- 
2.55.0.543.g5ebe2ebe4ea8



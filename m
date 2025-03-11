Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0626DC282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trplG-0001g9-Fr; Mon, 10 Mar 2025 22:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trpkj-0001TR-Ud
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trpki-0002OB-9W
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741661634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqWv3s46457E9CoDM5Mt44gLjKm8kjNR0SxjNbrwIWs=;
 b=MUOThAH9bHGmx9DiUsBOFPaU7T4bBqgTxFdu9NCGejZDzAPIsIymMRyCVZMPgF0JcxWkz1
 gO34SCtaPIxkEJ5Vxtm5vaavYwDQfky0ySuQXswmQmeD7l1GbfIINIorYUAiggNbAl2aZ6
 NJqu4DYtVXss+DX9okWmLual/8n/zbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-6fmw1eQmM1WMghgaLqV7zg-1; Mon,
 10 Mar 2025 22:53:46 -0400
X-MC-Unique: 6fmw1eQmM1WMghgaLqV7zg-1
X-Mimecast-MFC-AGG-ID: 6fmw1eQmM1WMghgaLqV7zg_1741661622
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B971519560BC; Tue, 11 Mar 2025 02:53:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF81B1956094; Tue, 11 Mar 2025 02:53:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] trace/control-target: cleanup headers and make compilation
 unit common
Date: Tue, 11 Mar 2025 10:53:31 +0800
Message-ID: <20250311025331.598234-2-stefanha@redhat.com>
In-Reply-To: <20250311025331.598234-1-stefanha@redhat.com>
References: <20250311025331.598234-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control-target.c | 2 --
 trace/meson.build      | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index d58e84f6dd..57ceac2108 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -8,8 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/lockable.h"
-#include "cpu.h"
 #include "trace/control.h"
 
 
diff --git a/trace/meson.build b/trace/meson.build
index c3412dc0ba..3df4549355 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,6 +1,4 @@
-system_ss.add(files('trace-hmp-cmds.c'))
-
-specific_ss.add(files('control-target.c'))
+system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
 
 trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
-- 
2.48.1



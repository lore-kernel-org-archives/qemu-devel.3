Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167AFD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 10:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV5hA-0002PL-Rx; Mon, 15 Dec 2025 05:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vV5gR-0002HK-D9
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vV5gP-0006BF-Nv
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765794001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcEAzUsRqwAcsvOrlw1Vzcf30xI8U7+FKwpRgtCmPgA=;
 b=gwHV7BLzNy4+IEYERlPJwaiy5jRaO72OxRb+Z0PX7Vzz44x5R+6jc0up8qUHlMr7a50rpH
 TKIEIV41+KZV/Dx/OSr0kSJpfptGgJ4XbaaMeGtZYHwv/xAysRCakUKF1G9M6ktczeUUez
 dBlUWR1s7yI3iF+2W1Dm/dpZFI5yUL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-bUs0c8MtMQqQSribOEecBA-1; Mon,
 15 Dec 2025 05:19:59 -0500
X-MC-Unique: bUs0c8MtMQqQSribOEecBA-1
X-Mimecast-MFC-AGG-ID: bUs0c8MtMQqQSribOEecBA_1765793998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B6721800610; Mon, 15 Dec 2025 10:19:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 154FF19560A7; Mon, 15 Dec 2025 10:19:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 4/4] gdbstub: Fix const qualifier build errors with recent
 glibc
Date: Mon, 15 Dec 2025 11:19:37 +0100
Message-ID: <20251215101937.281722-5-clg@redhat.com>
In-Reply-To: <20251215101937.281722-1-clg@redhat.com>
References: <20251215101937.281722-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A recent change in glibc 2.42.9000 [1] changes the return type of
strstr() and other string functions to be 'const char *' when the
input is a 'const char *'. This breaks the build in :

../gdbstub/user.c:322:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  322 |     pid_placeholder = strstr(path, "%d");
      |                     ^
Fix this by changing the type of the variables that store the result
of these functions to 'const char *'.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 gdbstub/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 2e14ded3f01053d4d4a36426c509ce7a6b81cb67..e233c598165ca1b10a5f2a89c87136df9af636ca 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -317,7 +317,7 @@ static bool gdb_accept_socket(int gdb_fd)
 static int gdbserver_open_socket(const char *path, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
-    char *pid_placeholder;
+    const char *pid_placeholder;
 
     pid_placeholder = strstr(path, "%d");
     if (pid_placeholder != NULL) {
-- 
2.52.0



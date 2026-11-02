Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D96070399
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt1v-0007mw-9T; Mon, 02 Nov 2026 09:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt1r-0007mU-Rj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt1p-00077V-Pb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793629733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1m62k7l0Q/iT7x8yExV1dEHGGhNHo8St4Pmv019YViQ=;
 b=Xa411/n2RBanZXVMl4A3ApLezRFY1dnZuhnpwdWyFnoe5KpWPpHCeaVz8SdZR/BDSZa6B1
 qHl6KxSUCBVi7eHF1gY0EzFgCjTmBVKHC4a06B3/csIcMsYQzQn/ei6bwk1i6YApidIEoL
 qaGcd49w7T5IX6d8ou/u8+XF2k0uido=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-56OTi2ErNeKxTBhjuRAYWg-1; Mon,
 02 Nov 2026 09:28:49 -0500
X-MC-Unique: 56OTi2ErNeKxTBhjuRAYWg-1
X-Mimecast-MFC-AGG-ID: 56OTi2ErNeKxTBhjuRAYWg_1793629729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC94A19541A2
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 14:28:48 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FCFD1800444; Mon,  2 Nov 2026 14:28:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 01/25] osdep: add 'ignore_value(x)' macro
Date: Mon,  2 Nov 2026 14:28:20 +0000
Message-ID: <20261102142844.3464712-2-berrange@redhat.com>
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Functions annotated with 'warn_unused_result' cannot be cast
to (void) to silence the compiler. Add the ignore_value()
macro which tricks the compiler into thinking the result is
genuinely used, avoiding the need for manual workarounds where
the return value is intentionally ignored.

This clever macro is derived from one originating with the
GNULIB project:

  https://gitweb.git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/ignore-value.h;hb=HEAD

but simplified since we don't need compat with old GCC and
optimizing on clang is overkill.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 50c7ce33b6a..b27d159d5bb 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -251,6 +251,14 @@ extern "C" {
 #endif
 
 
+/*
+ * Merely casting to (void) is not sufficient for functions
+ * annotated with the "warn_unused_result" attribute
+ */
+#define ignore_value(x) \
+    (__extension__ ({ __typeof__(x) __x = (x); (void) __x; }))
+
+
 /*
  * For mingw, as of v6.0.0, the function implementing the assert macro is
  * not marked as noreturn, so the compiler cannot delete code following an
-- 
2.56.0



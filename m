Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C7CCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 07:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOWFA-0005LV-29; Thu, 27 Nov 2025 02:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOWEg-00055M-Ou
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 02:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOWEc-0000fU-ML
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 02:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764227769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=5ATOxMhkGLko4Zy4s1h3G59TmbEZMaU1llgiJL6KMz8=;
 b=LlBQ9hh6n/zrZa08s8FP5PojayNPOetwcmb92dqjsOhLEhxZ9ingIauIL0vfRwr6SUZ/f2
 4wXo10+OtpsTZ6FQHz9EblHeixkw1JNfhRE4sdbYlPRioNSdmt0DQvdsZ3Ef1JJZ8j+ysn
 ffymOON8K5m2qOoVhTji4f9to00FQ4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-R5jDUe6GMqC6TIjlIRPOrw-1; Thu,
 27 Nov 2025 02:16:06 -0500
X-MC-Unique: R5jDUe6GMqC6TIjlIRPOrw-1
X-Mimecast-MFC-AGG-ID: R5jDUe6GMqC6TIjlIRPOrw_1764227765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1507195606C; Thu, 27 Nov 2025 07:16:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36671800240; Thu, 27 Nov 2025 07:16:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C47421E6A27; Thu, 27 Nov 2025 08:16:01 +0100 (CET)
Resent-To: peter.maydell@linaro.org, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, farosas@suse.de, vsementsov@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 27 Nov 2025 08:16:01 +0100
Resent-Message-ID: <871plk9c9a.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Thu Nov 27 08:10:46 2025
Received: from imap.gmail.com ([2a00:1450:400c:c1d::6c]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/377440; 27 Nov 2025
 07:10:46 -0000
Received: from blackfin.pond.sub.org
 (p200300d36f125200d4b07119e720e6da.dip0.t-ipconnect.de.
 [2003:d3:6f12:5200:d4b0:7119:e720:e6da])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a396sm1704874f8f.22.2025.11.26.23.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 23:10:29 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C34B421E6A27; Thu, 27 Nov 2025 08:10:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, berrange@redhat.com, vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name, clg@redhat.com, peter.maydell@linaro.org
Subject: [PATCH 2.5/6] error: Poison g_autoptr(Error) to prevent its use
Date: Thu, 27 Nov 2025 08:10:28 +0100
Message-ID: <20251127071028.2745789-1-armbru@redhat.com>
In-Reply-To: <20251125204648.857018-3-peterx@redhat.com>
References: <20251125204648.857018-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1849926541202783082
X-GMAIL-MSGID: 1849926541202783082
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The previous commit reverted support for g_autoptr(Error).  This one
should stop it from coming back.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f3ce4a4a2d..2356b84bb3 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,6 +437,26 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
+/*
+ * Poison g_autoptr(Error) to prevent its use.
+ *
+ * Functions that report or propagate an error take ownership of the
+ * Error object.  Explicit error_free() is needed when you handle an
+ * error in some other way.  This is rare.
+ *
+ * g_autoptr(Error) would call error_free() automatically on return.
+ * To avoid a double-free, we'd have to manually clear the pointer
+ * every time we propagate or report.
+ *
+ * Thus, g_autoptr(Error) would make the rare case easier to get right
+ * (less prone to leaks), and the common case easier to get wrong
+ * (more prone to double-free).
+ */
+extern void
+__attribute__((error("Do not use g_autoptr() to declare Error * variables")))
+error_free_poisoned(Error *err);
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)
+
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.49.0




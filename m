Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576ECC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWU-0002FD-4r; Thu, 15 Oct 2026 07:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWT-0002Er-3w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWR-00044D-Kn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kn2yPrDKKgwsS0hJAc6JBW5Mc5UxaTcj3bqOOrNgn0U=;
 b=dY0q0SJLlPCmWRmMacnVURBV5GOJkj5siul5zpxAb3Im5RnhmDwBq+qRA8wqQXDF3J/f33
 vd+wQvcUljku5Aysh0HHHNnZqBK9J+99VHGEB3pjtbPeb9wPwJFEPYdOFr6YOm6cosylzc
 uf4bieYbEKYQkjszxn3hlnWKZY2vCBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-6StLNXmrM8ycDjz6fJBXXA-1; Thu,
 15 Oct 2026 11:21:15 +0000
X-MC-Unique: 6StLNXmrM8ycDjz6fJBXXA-1
X-Mimecast-MFC-AGG-ID: 6StLNXmrM8ycDjz6fJBXXA_1792063274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B8F18009C7; Thu, 15 Oct 2026 11:21:14 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1EF71800677; Thu, 15 Oct 2026 11:21:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 06/21] osdep: provide dummy siginfo_t definition
Date: Thu, 15 Oct 2026 12:20:29 +0100
Message-ID: <20261015112044.1999748-7-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Windows platforms lack sigaction and thus also lack siginfo_t. For
the convenience of later code, provide a dummy siginfo_t struct
definition when it is missing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h | 8 ++++++++
 meson.build          | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c1ca2c127b6..fdb61d5d51e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -635,6 +635,14 @@ void sigaction_invoke(struct sigaction *action,
                       struct qemu_signalfd_siginfo *info);
 #endif
 
+#ifndef HAVE_SIGINFO_T
+typedef struct {
+    int si_signo;
+    int si_code;
+    void *si_addr;
+} siginfo_t;
+#endif
+
 /*
  * Don't introduce new usage of this function, prefer the following
  * qemu_open/qemu_create that take an "Error **errp"
diff --git a/meson.build b/meson.build
index b383c7fceef..c6207443365 100644
--- a/meson.build
+++ b/meson.build
@@ -2709,6 +2709,8 @@ config_host_data.set('HAVE_OPTRESET',
                      cc.has_header_symbol('getopt.h', 'optreset'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
+config_host_data.set('HAVE_SIGINFO_T',
+                     cc.has_header_symbol('signal.h', 'siginfo_t'))
 if libaio.found()
   config_host_data.set('HAVE_IO_PREP_PWRITEV2',
                        cc.has_header_symbol('libaio.h', 'io_prep_pwritev2'))
-- 
2.56.0



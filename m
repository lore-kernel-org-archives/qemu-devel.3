Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AC5F43695
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhxJ-0005Hu-UQ; Fri, 17 Apr 2026 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDhx9-0005GX-0o
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDhx6-0006Zg-BB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776427537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkrEgX75jNy7p50vX4ufIbRArxGERLn7U2N8OKwD/5I=;
 b=II4KKfT9dvyNwfNEttSs1vBwifcItByFjqUHCRUmV0opKZhfvN4CPvBFZIZl787Rg5/7f5
 YnHbTYUyKiBZgunJRtTUMmqZ5Ubd4tig8mv9sI9N1PAO2pWklNCMcw2Zfgr5422weP47Dm
 FJiv89TjlJIKVD2WWuLkrmu9XlmS3Sc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-55EHQJJGOtuGW0MFDiFZjQ-1; Fri,
 17 Apr 2026 08:05:36 -0400
X-MC-Unique: 55EHQJJGOtuGW0MFDiFZjQ-1
X-Mimecast-MFC-AGG-ID: 55EHQJJGOtuGW0MFDiFZjQ_1776427535
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98C21956062; Fri, 17 Apr 2026 12:05:34 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49D3C30001A4; Fri, 17 Apr 2026 12:05:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] util: fix use of pthread_get_name_np on OpenBSD
Date: Fri, 17 Apr 2026 13:05:31 +0100
Message-ID: <20260417120531.2215549-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The pthread_get_name_np function is present on FreeBSD and OpenBSD
and has 'void' return not 'int'. We didn't notice this build problem
on FreeBSD since it also has pthread_getname_np which does return
int like Linux and we use the latter preferentially.

Fixes: 215235d365e49c72a85ea2940751e45419676031
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3399
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

This is a regression in the 11.0 release, but on the assumption it
is too late for further fixes, I'm CC'ing qemu-stable so this can
go into the future stable-11.0 branch

 util/qemu-thread-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index bd1c2ad2a5..089606c93f 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -568,7 +568,8 @@ const char *qemu_thread_get_name(void)
 # if defined(CONFIG_PTHREAD_GETNAME_NP)
     rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
 # elif defined(CONFIG_PTHREAD_GET_NAME_NP)
-    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+    pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+    rv = 0;
 # else
     rv = -1;
 # endif
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59DFF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjV-0007zq-CZ; Mon, 27 Apr 2026 05:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjJ-0007l4-9u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjG-000873-HL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNbVD6raZBOlj/4NNQ4I4wPe1E1uFOyftINCiLZjXj4=;
 b=PFygMa1Ne48S38cH2M1dgnxvdmgMBID6Sb8s/k1rdBeIbNgeTr64S7+audyaIqfoaZLrDg
 a29hTSsaEZZo0ItbYmFhLK76onXIv/utoHenlQNewy4bNH/XJxt+4pgdkaKQNKTfiEOa6o
 0tZxWRZ2UkgUlRl49O8uDufYPDwrpSg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-5zV8gRxpMEGWDpmkx0uoqA-1; Mon,
 27 Apr 2026 05:58:12 -0400
X-MC-Unique: 5zV8gRxpMEGWDpmkx0uoqA-1
X-Mimecast-MFC-AGG-ID: 5zV8gRxpMEGWDpmkx0uoqA_1777283891
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06CF31800378; Mon, 27 Apr 2026 09:58:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8ECEA3000707; Mon, 27 Apr 2026 09:58:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] util: fix use of pthread_get_name_np on OpenBSD
Date: Mon, 27 Apr 2026 11:57:42 +0200
Message-ID: <20260427095747.1070244-6-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The pthread_get_name_np function is present on FreeBSD and OpenBSD
and has 'void' return not 'int'. We didn't notice this build problem
on FreeBSD since it also has pthread_getname_np which does return
int like Linux and we use the latter preferentially.

Fixes: 215235d365e49c72a85ea2940751e45419676031
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3399
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260417120531.2215549-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/qemu-thread-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index bd1c2ad2a59..089606c93fb 100644
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



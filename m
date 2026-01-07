Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C1CFD62A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTVj-0006ss-4F; Wed, 07 Jan 2026 08:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTVi-0006sa-Au
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:23:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTVe-0005Bo-Qr
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767792214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=gONgRn/GNyBGob63kNT426dkqmiq4qN/s3arf4kHFSI=;
 b=iOGx6mDi6I7JWQkCqxKA1Sf5CXyrCtH9rA/SLFpRUsQJh3iH48H10F1N1wfDXnZ+A46iUI
 Lp2XiuQIfdDXoGh0mkI19OMR7i2MI2LltmQLgf6DDVC6TN78zyEK5a92R4lBeTv1hOq4w/
 f2lzboewNcXt4mU1OP81/ZdeFbDFOYg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-FKJ20vT4O5G4wcrUmLUQOw-1; Wed,
 07 Jan 2026 08:23:31 -0500
X-MC-Unique: FKJ20vT4O5G4wcrUmLUQOw-1
X-Mimecast-MFC-AGG-ID: FKJ20vT4O5G4wcrUmLUQOw_1767792210
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0F0C1955DC7; Wed,  7 Jan 2026 13:23:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68AB71800240; Wed,  7 Jan 2026 13:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BB1B21E6937; Wed, 07 Jan 2026 14:23:27 +0100 (CET)
Resent-To: philmd@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 07 Jan 2026 14:23:27 +0100
Resent-Message-ID: <87jyxtimk0.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Jan  7 13:43:41 2026
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F1D321E61B3; Wed, 07 Jan 2026 13:43:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/17] tap-solaris: Use error_setg_file_open() for better
 error messages
Date: Wed,  7 Jan 2026 13:43:32 +0100
Message-ID: <20260107124341.1093312-9-armbru@redhat.com>
In-Reply-To: <20260107124341.1093312-1-armbru@redhat.com>
References: <20260107124341.1093312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Error messages change from

    Can't open /dev/ip (actually /dev/udp)
    Can't open /dev/tap
    Can't open /dev/tap (2)

to

    Could not open '/dev/udp': REASON
    Could not open '/dev/tap': REASON

where REASON is the value of strerror(errno).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20251121121438.1249498-5-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/tap-solaris.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 75397e6c54..faf7922ea8 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -87,13 +87,13 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
 
     ip_fd = RETRY_ON_EINTR(open("/dev/udp", O_RDWR, 0));
     if (ip_fd < 0) {
-        error_setg(errp, "Can't open /dev/ip (actually /dev/udp)");
+        error_setg_file_open(errp, errno, "/dev/udp");
         return -1;
     }
 
     tap_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
     if (tap_fd < 0) {
-        error_setg(errp, "Can't open /dev/tap");
+        error_setg_file_open(errp, errno, "/dev/tap");
         return -1;
     }
 
@@ -107,7 +107,7 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
 
     if_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
     if (if_fd < 0) {
-        error_setg(errp, "Can't open /dev/tap (2)");
+        error_setg_file_open(errp, errno, "/dev/tap");
         return -1;
     }
     if(ioctl(if_fd, I_PUSH, "ip") < 0){
-- 
2.52.0




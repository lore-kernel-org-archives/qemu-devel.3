Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F71CF31A1
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuso-0004bm-Fy; Wed, 02 Oct 2024 04:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svusX-0004Ip-1L
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svusU-0005nI-QK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1JuQuL2UkuXBJWfc7ll+XmI7QlTCOtmrJShYAzAwNE=;
 b=OvaaijcDCr11OaKI4dnx7O9u0VPR9LMqKbjaS8KXtBS50p6u1SL24ZuvTWyLhqMnWpHhhM
 CspAX9fYzr1yusrG5xxhBumVVeIJztuoJbAjIhOU4Cp1mkEUS2fG73P+TlEq7iB6jJjTd6
 QJ5aSCQ8sMM3zAHvtDcLIsnFTmw7Ous=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-k8mOC4ZhOwi5eFX2xPJHcw-1; Wed,
 02 Oct 2024 04:38:32 -0400
X-MC-Unique: k8mOC4ZhOwi5eFX2xPJHcw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A4C019560A5; Wed,  2 Oct 2024 08:38:31 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5B7319560A2; Wed,  2 Oct 2024 08:38:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 21/22] fsdep/9p: fix -Werror=maybe-uninitialized false-positive
Date: Wed,  2 Oct 2024 12:36:44 +0400
Message-ID: <20241002083646.2893078-22-marcandre.lureau@redhat.com>
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../fsdev/9p-iov-marshal.c:93:23: error: ‘val’ may be used uninitialized [-Werror=maybe-uninitialized]
and similar

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/9p-iov-marshal.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
index a1c9beddd2..0c5a1a0fa2 100644
--- a/fsdev/9p-iov-marshal.c
+++ b/fsdev/9p-iov-marshal.c
@@ -84,9 +84,12 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'w': {
-            uint16_t val, *valp;
+            uint16_t val = 0, *valp;
             valp = va_arg(ap, uint16_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
+            if (copied <= 0) {
+                break;
+            }
             if (bswap) {
                 *valp = le16_to_cpu(val);
             } else {
@@ -95,9 +98,12 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'd': {
-            uint32_t val, *valp;
+            uint32_t val = 0, *valp;
             valp = va_arg(ap, uint32_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
+            if (copied <= 0) {
+                break;
+            }
             if (bswap) {
                 *valp = le32_to_cpu(val);
             } else {
@@ -106,9 +112,12 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'q': {
-            uint64_t val, *valp;
+            uint64_t val = 0, *valp;
             valp = va_arg(ap, uint64_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
+            if (copied <= 0) {
+                break;
+            }
             if (bswap) {
                 *valp = le64_to_cpu(val);
             } else {
-- 
2.45.2.827.g557ae147e6



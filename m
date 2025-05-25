Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABB1C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBOG-0007YG-QU; Sun, 25 May 2025 09:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOE-0007XO-TN
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOD-0003Lw-75
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLku0fleFOmUk4q9nyUVYXtVJGIVygN4ILzV4cARliE=;
 b=YZF/lpa0Y3iV+wexO3dN/7VurlVjTcdRxHveDm3N3YLSpjueUDv8LWzb6dgO3RBC5KZuxN
 0xA8QGn7+kLWXyszkcbCmx5u1HglOaEMNL04FSpqTzaLLtakxrBeeuRUR3fj4I+aLaW2dg
 jd1n69M0VQ6CwYf6t29+p7ZarakSIP4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-oLvzES_uPX-V1savboGTeQ-1; Sun,
 25 May 2025 09:27:40 -0400
X-MC-Unique: oLvzES_uPX-V1savboGTeQ-1
X-Mimecast-MFC-AGG-ID: oLvzES_uPX-V1savboGTeQ_1748179660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E5219560AA; Sun, 25 May 2025 13:27:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0081180045B; Sun, 25 May 2025 13:27:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/9] audio/mixeng: remove unnecessary pointer type casts
Date: Sun, 25 May 2025 15:27:13 +0200
Message-ID: <20250525132717.527392-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

A simple assignment automatically converts a void pointer type
to any other pointer type.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20250515054429.7385-6-vr_qemu@t-online.de>
---
 audio/mixeng.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index 69f6549224..13e1ff9b08 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -286,7 +286,7 @@ static const float float_scale_reciprocal = 1.f / ((int64_t)INT32_MAX + 1);
 static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
                                        int samples)
 {
-    float *in = (float *)src;
+    const float *in = src;
 
     while (samples--) {
         dst->r = dst->l = CONV_NATURAL_FLOAT(*in++);
@@ -297,7 +297,7 @@ static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
 static void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
                                          int samples)
 {
-    float *in = (float *)src;
+    const float *in = src;
 
     while (samples--) {
         dst->l = CONV_NATURAL_FLOAT(*in++);
@@ -314,7 +314,7 @@ t_sample *mixeng_conv_float[2] = {
 static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
                                          int samples)
 {
-    float *out = (float *)dst;
+    float *out = dst;
 
     while (samples--) {
         *out++ = CLIP_NATURAL_FLOAT(src->l + src->r);
@@ -325,7 +325,7 @@ static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
 static void clip_natural_float_from_stereo(
     void *dst, const struct st_sample *src, int samples)
 {
-    float *out = (float *)dst;
+    float *out = dst;
 
     while (samples--) {
         *out++ = CLIP_NATURAL_FLOAT(src->l);
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99607FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdam-0007Dz-BQ; Tue, 28 Apr 2026 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaS-0006mO-Mr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaP-000670-FT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XgOkAjsKIJNpzlp0Ng9zVsL4Sb3WXmh337O8gNtq/A=;
 b=hiDfKQwaGA/b8YGznp5bo5pcu61N6fAGahoT9JqtEYd3XTBjE8TpbolBJs3YmFEWFCFYNp
 kdqn3nIMRqPQIPDZu5xcF9KbXYTmhKqeoALGRndi9YbotByKVmaae+AQWvnAymZk9zU4D0
 KmXSAxhE205aceByujYDfkdqH9ACSk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-I6z8aNFDNBmpQ3YWx-2M4A-1; Tue,
 28 Apr 2026 04:14:23 -0400
X-MC-Unique: I6z8aNFDNBmpQ3YWx-2M4A-1
X-Mimecast-MFC-AGG-ID: I6z8aNFDNBmpQ3YWx-2M4A_1777364062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FB811956080; Tue, 28 Apr 2026 08:14:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6070519560AB; Tue, 28 Apr 2026 08:14:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/15] audio: Clamp unsigned sample conversion
Date: Tue, 28 Apr 2026 12:12:59 +0400
Message-ID: <20260428081303.990973-13-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

clip_*_uint32_t() returns 0 when v == 1.f because it computes the result
as (IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF):

- (v * ((mixeng_real)IN_MAX / 2.f)) + HALF == 0x100000000.f, which does
  not fit in uint32_t.
- (v * ((mixeng_real)IN_MAX / 2.f)) == 0x80000000.f
- ((mixeng_real)IN_MAX / 2.f) == 0x80000000.f
- (mixeng_real)IN_MAX == 0x100000000.f because 0xffffffff cannot be
  represented exactly in float.
- HALF == 0x7fffffff, which is implicitly converted to 0x80000000.f.

Clamp the result to avoid the overflow.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260423-audio-v1-2-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/mixeng_template.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 881653c44bf..5b0014bdd9a 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -65,7 +65,9 @@ static inline IN_T glue (clip_, ET) (mixeng_real v)
 #ifdef SIGNED
     return ENDIAN_CONVERT((IN_T)(v * (((mixeng_real)IN_MAX - IN_MIN) / 2.f)));
 #else
-    return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF));
+    return ENDIAN_CONVERT(MIN((int64_t)((v * ((mixeng_real)IN_MAX / 2.f)) +
+                                        HALF),
+                              IN_MAX));
 #endif
 }
 
-- 
2.53.0



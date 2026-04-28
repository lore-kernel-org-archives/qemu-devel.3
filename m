Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49528FF886C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdab-0006m1-Cr; Tue, 28 Apr 2026 04:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaJ-0006bt-Eu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaH-000657-SO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhT5V+3dF1BVb/3WlHE7gkPc89Ly/aUzFnqb1nH25dg=;
 b=TeMV2Hkp06P6nTo+U5k3WJQk/MFNoLeJdpmQPZ8Afy6WUBMoEWEN99ijkpI1koqZIo5w/Q
 eCGZXaHJ+taSQLKxQrSKwTVMNRODisOvlGvJeD9O0RA3H4POBeKHTLNiYxB0chKk+MscxS
 XEYpRXupZOvAsFZDwpAo3R8BeGyyo/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-7Pj9aKtcN4aLg_q50CJprg-1; Tue,
 28 Apr 2026 04:14:17 -0400
X-MC-Unique: 7Pj9aKtcN4aLg_q50CJprg-1
X-Mimecast-MFC-AGG-ID: 7Pj9aKtcN4aLg_q50CJprg_1777364056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FFF71955DBD; Tue, 28 Apr 2026 08:14:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F6071800446; Tue, 28 Apr 2026 08:14:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/15] audio: Avoid unsigned sample wraparound
Date: Tue, 28 Apr 2026 12:12:58 +0400
Message-ID: <20260428081303.990973-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

When !defined(SIGNED), nv - HALF will wrap around if nv < HALF because
nv and HALF are unsigned. Fix it by casting nv to mixeng_real, which is
signed.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260423-audio-v1-1-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/mixeng_template.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index bc8509e423f..881653c44bf 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -43,13 +43,13 @@ static inline mixeng_real glue (conv_, ET) (IN_T v)
 #ifdef SIGNED
     return nv * (2.f / ((mixeng_real)IN_MAX - IN_MIN));
 #else
-    return (nv - HALF) * (2.f / (mixeng_real)IN_MAX);
+    return ((mixeng_real)nv - HALF) * (2.f / (mixeng_real)IN_MAX);
 #endif
 #else  /* !RECIPROCAL */
 #ifdef SIGNED
     return nv / (((mixeng_real)IN_MAX - IN_MIN) / 2.f);
 #else
-    return (nv - HALF) / ((mixeng_real)IN_MAX / 2.f);
+    return ((mixeng_real)nv - HALF) / ((mixeng_real)IN_MAX / 2.f);
 #endif
 #endif
 }
-- 
2.53.0



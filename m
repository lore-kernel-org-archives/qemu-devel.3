Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B20CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2b-00069T-OC; Mon, 28 Sep 2026 09:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB10-0005Qp-FF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0y-0004P2-JG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zw66y0dqHiAFlKwC+PrqW0WKcZn8ncWgvsu+fbY0LQ=;
 b=G6xOwXLByxrX1cfUGod+mehy5YJWYtHQgP4zsPSo/qjrqghp/pLgAGT+mREwq7Cx3FTuC1
 68ir9nSv45le1a9LWVIcbSvsL4KmmqeOTHfduVlVlxTQloDs6Mw3oD1BgO6skps5Lnv4o3
 XGLdtgctYHRcHR0Oh+wVJpGQFBfwTfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-I7YFpHElN1qRb7G4xBQw2A-1; Mon, 28 Sep 2026 09:03:26 -0400
X-MC-Unique: I7YFpHElN1qRb7G4xBQw2A-1
X-Mimecast-MFC-AGG-ID: I7YFpHElN1qRb7G4xBQw2A_1790600605
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6862e924so23907205e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600605; x=1791205405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Zw66y0dqHiAFlKwC+PrqW0WKcZn8ncWgvsu+fbY0LQ=;
 b=M90L4q1MmG9a4Y+Hv70IGv2v/vl6PVrzSnvq5ueweoRuKYstJ4dZrV2i62DHGhCiZ6
 7Y1NuASKS4WU/V6wrl+tdQ+GTwUg8U7hc6TNGeHu+8nGZw4uQv8ZLPK4Du6gPeKBQqM5
 wbV+I4kTfNv9KvIWUxUIIhki0izgFRvD7wPmQ54vC+uVjIqmrLDe6khJoa9Ctm5/XNZY
 CRA+HzUkg94OaXuWrx76CTP/rBcuKX4BskfrceOs5hvrkfqxjdBnFfeUjzAX2Z097Jeh
 zPA7SOCKDi3/i4q43p/kP0BY4CCgWnpN1dPzyWCYvbaVkeiUoRCc3Szu+dIrM3ED2yd4
 kIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600605; x=1791205405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Zw66y0dqHiAFlKwC+PrqW0WKcZn8ncWgvsu+fbY0LQ=;
 b=e2xdzwaYS94/fa1dJzSpuZI1tGN4iv1w3hzHGc4VUOoLJi0f2oML9qSuaP5GzrFQpS
 4MI9tKWV5tKr1YGiFbtYhvMDaP0D1C6ne0i/1q4tE9evsWhWEa4AZTzFHETc0hsfG6wQ
 /hBUzGQ3CUH4Glvdot9kkMTe52a9SMzas2AeJDmuW3baB+w7TlLzz0q0cryl4w3M0jFC
 Ct6zq18cRZCLgLSeeHrqoa5cdSw5OgzDH9k/PH5qhm0/IQg5oJFx+JIKx9UBaWGBgUFz
 hDTRjz4aYO1WniIWPyFcgNX4qBXs7oR2COPtG39sizRx/z28MBMK9n81lqa74czJrmq0
 mq7A==
X-Gm-Message-State: AFuF++mSTBMWWpRyEbSxDDiwcDWNO8oO62TPnkUgVYQPqYQ+NegUDYyV
 IXU3ZnDLJdDnnOdajEw/6t6tCIdPhLovXGycCufMvfRu6ny6wxOoQfaLhF4qYFV05ErYu+fHy08
 0y5nBpMtE1BZZZskCBViszpeO6W51cHbllKQkSb2GxgCiWnJ1Rd0T9R20ufSukJm708MwE2CB7w
 89cUx4wdLs5JgMDSurTd4/waExlWIBjhpXuDPIUekS
X-Gm-Gg: AYBFou0Lz49VG1HyqFAhwFmXCcGYzpRibWBc20pSvKewqxJGxbhIBCOBSRhe0rhUewX
 LeshCCUnuSmkcpMpo/AOHDi9PrZjNsWqAKmuOo+nckydwztesJUBVC5ooyLEnXmZYNRykLRf9rP
 cgG54FsSdG4HVqaPTo4MD66pixsf3/fNZuFKx4N+8k5m19gemcwgIjmnClrcjI8BSh0+nkNdyzA
 qJLp9thS9jxOZ5mq/wAZui43UrJhBk15G3iTXyJMLqSDF7VdZElS9BAqbzVRKGLkwIuXBcUSXcH
 2kmJv9ha8HM407dLCUb67gKQ0QHVxkmFMC0k3Ny6M63y/JbhY6MCdemtghneTxtzrTzXmq4btq1
 42L5UixQ9JxFGIY7XZDMUknGHCByvA4P6VFY96TMVeDchLwX7jypczACsiq20TPEPAOgY/SalkD
 jpIpVf
X-Received: by 2002:a05:600c:310b:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49fe66c6289mr221340345e9.14.1790600605067; 
 Mon, 28 Sep 2026 06:03:25 -0700 (PDT)
X-Received: by 2002:a05:600c:310b:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49fe66c6289mr221339965e9.14.1790600604557; 
 Mon, 28 Sep 2026 06:03:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c076dc3sm2197625e9.0.2026.09.28.06.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/30] target/i386/tcg: add definition for REX2 prefix
Date: Mon, 28 Sep 2026 15:02:15 +0200
Message-ID: <20260928130228.877003-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7fa2604a220..2e48e3a8898 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -50,6 +50,7 @@
 #define PREFIX_ADR    0x10
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
+#define PREFIX_REX2   0x80
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -208,7 +209,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.55.0



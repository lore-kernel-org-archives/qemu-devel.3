Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C88C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKn1-0005EF-UV; Fri, 21 Aug 2026 04:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmz-0005Be-RB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmy-0008LN-3R
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=Yqh1i/R+0RWvIy4DeFn90H00N2uuakx+aPWeZT5lQt7JilHd0pWzND7cDD/JVAZS/S0+10
 O9KM9MPunyDfnSltre46KK9bqJD0cxfzsNp6YJeMt/zGv1HoQHIIxBYQk+NPHx4dC09f1g
 7+yWlOVypSGZEJpkTVM8JxekiZiNztw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-9n1RwhKaNLC-sdX6_KuLqw-1; Fri, 21 Aug 2026 04:39:45 -0400
X-MC-Unique: 9n1RwhKaNLC-sdX6_KuLqw-1
X-Mimecast-MFC-AGG-ID: 9n1RwhKaNLC-sdX6_KuLqw_1787301584
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15c6a68406so45346966b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301584; x=1787906384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=OI3LniH7huxRBl6kNLWBzVBy4S8TXJ/bVow22SQ46i7w6nHRcVKYPdEGWKrgGoufdS
 7TrLUBMb0pYrMDQfdCYCdMsgxm637E1Y23BiKs7K+CnWmPniei1E+Izk9ZbGN20pUT6/
 fKscc5iWlc8o+KLQ2jPBekNg05N1wbRgUFDvRZCSjDaOEi97JP35OMsNQmYQ2u6Q5Vrs
 72Qh72misSk/pN9rP1K1lXUjmwueKvtVJ1mB1JRo9keqD8bpgn4ORieL9DmCi7j8rcyw
 lGhEjN5RWlFwwTvMjtmIZL/2rRfhRSs7tcwmgYmcyGXASH8V1ISAiuBxAHn5gaSdrB4M
 I8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301584; x=1787906384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=qwybFkbK9lJ3yFAQ1agob7idO7HI78JlcL2cEZuMmk400CKB4aPfjRHHAHYgvimeAJ
 3sQAyjcwqfwATB/lY5hexF+/ZprrrI7EAhGBInoXAmrUfo/mWZlX4N3Y7xoiLD5clw3D
 uRl3Fi0PKxZ7+PLLOW/9fYDa0qzXv/YEoewdRA+03gsQVwwoPkmdSYrqaupvpJBnsTnh
 e/mNNxUOOiCo+Clw6UsLOJ4cY013HAEMs2DUn4CbQ+MK81aWyBUnAKkpm5b8UXIzNwtI
 u81UiWFPE1sjFPzwfKRmF1MzlPl9jyTPuoEAoYTbzbjj2r8r/NO74aZXFtofzVlUVkYm
 JJBQ==
X-Gm-Message-State: AFuF++nk4BwIn8mirGIy5wp76c1wPE3YK/ZXlfr9Pt03WX4IXY8UQhMY
 BrY1hTL2mmLLbKGar4bM1BtoSGm/2hwKHhEM6PBUkP1M61Fhvsj2zjGEXY/ctLalKoqO+SaYndh
 StnxJGkR1NwP9CaA2cyjwtFOWDeaJJZcq4+TpZhCZ8fS9JLI0l4sfSKxR57ncOLNglnroMCkR0u
 qMVV3dkndeS+gM+XxJ+qDoutMRlV9ywxJsTbi449Lo
X-Gm-Gg: AR+sD10fYOEs1xcqJBxptMD0CUEOF5Hn3JsiZ+LOYQoDkjtAifw3FWUFye0J64VlqiH
 cxqAcYYKOqTBge21+lxPlQQ8AYndkEpsiMg1SzyDwz2sx/grDDz01DFGeE6ABqkWZqkuu2kBGQT
 hqpBlDJFGZy1i30lNJSrrjauEfUUdWKQqfUTAcYWQ0xnRF00yFAPXTcaWaOGulpaqROuB1KdouC
 d+rwYoYYXxjuW6TBMKeJv7yZg8NBHVUvaAFrXhAtmeMEU3f1ijVhcoA1H75haeTfiMeA3oWgxps
 g6z1zITwaZ6AU77kWJlhgPYGj9sIuemwXUJH2QTLA1wLWSz5hp4IiMaUH4R84D1HQsHh0bBR2xQ
 GYbx9X8FJnsJb9VL2hUYErNrubduUjV8V/cWhZAReSgLXComDBu1FXpBeebpGWTa7LD4tTps6g0
 H3LoU=
X-Received: by 2002:a17:907:9628:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c2469f94a1bmr483606366b.0.1787301583879; 
 Fri, 21 Aug 2026 01:39:43 -0700 (PDT)
X-Received: by 2002:a17:907:9628:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c2469f94a1bmr483599966b.0.1787301583427; 
 Fri, 21 Aug 2026 01:39:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e224dsm363825566b.2.2026.08.21.01.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/9] scripts: add the possibility of a quick update of the
 pacakge
Date: Fri, 21 Aug 2026 10:39:22 +0200
Message-ID: <20260821083925.2008135-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index b3ae5a2c284..a26fe135eb9 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -166,10 +166,13 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         orig_dir = section["directory"]
 
         if self.dry_run:
-            if orig_dir == source_namever:
-                print(f"Will install {orig_dir} from registry.")
-            else:
+            if orig_dir != source_namever:
                 print(f"Will replace {orig_dir} with {source_namever}.")
+            elif not os.path.exists(orig_dir) or self.cargo_registry:
+                print(f"Will install {orig_dir} from {self.source.origin}.")
+            else:
+                print(f"Will update {orig_dir} from cache.")
+                return
             self.changes += 1
             return
 
@@ -181,10 +184,19 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         with open(wrap_file, "w") as f:
             config.write(f)
 
-        if orig_dir == source_namever:
+        if orig_dir != source_namever:
+            print(f"👉 Replacing {orig_dir} with {source_namever}.")
+        elif not os.path.exists(orig_dir) or self.cargo_registry:
             print(f"👉 Installing {orig_dir} from {self.source.origin}.")
         else:
-            print(f"👉 Replacing {orig_dir} with {source_namever}.")
+            print(f"👉 Updating {orig_dir} from cache.")
+            subprocess.run(
+                ["meson", "subprojects", "update", "--reset", wrap_name],
+                cwd=self.top_srcdir,
+                env=env,
+                check=True,
+            )
+            return
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
-- 
2.55.0



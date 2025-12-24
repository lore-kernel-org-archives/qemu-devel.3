Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5D6E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRct-0002JU-Nq; Wed, 24 Dec 2025 11:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRcV-0001jd-Id
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRcS-0002lW-TO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so2599505e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593304; x=1767198104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSYIxHlg3NNpq+ldR9ZFqrwBxHO04iSdDtP058zFnCI=;
 b=fxHUZNUBjyoYxSwSXg5gi42SPB32ChPjWoxPOAGqVs6JEU/8Ine1jXfNWw/0xiAtWP
 PDYgA6Bu8eCr5uCMhV3AE3MCPboUjDH4MFrhI02GD/ezv0/cGw0kX2BKl1sQhPLng13/
 /ufXtbicnIIeYTKCAF1S6yIcFsokOrQJlHPNBfvx4GD5pAtASr6H1omGl+5c7sEhe4R4
 OOEHXfoUDhzSP/4NJ2lV4HLX+x6+X87AKhSDn5RsuQsOXRoQyPbRC+6uuI/2r7GrtukJ
 YXhLI9vdEXkze55Vgh54aK3pfWFMN1ZrytlaYaUzrwPsty9VB0XqNj9ayAYLwLGvha4+
 FH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593304; x=1767198104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSYIxHlg3NNpq+ldR9ZFqrwBxHO04iSdDtP058zFnCI=;
 b=SSMYFGlsFZKM3f53yQiPcGLjphMdrs/JuRHYEOIb4+vykEEMD3b5vMhb0e1vX2YepT
 hoglrnjgeEd7JxGCuX7VEEG8XkLSRqx1v0glYEWT1LL7kwKckZ4WMfGFyGPfWAqyMsan
 OabP9nAF9XnmGmwBc4vYNFwaArNQERovh2LVI4vXqPC+VxjNmKxu+U5xpSOoSaa5jGv3
 lKaMpxppDo/jXxiMU9hR6E7aMHvxaSDilTdFb0emKk6yCDOfE8kIEn281a0OQAglIu/A
 TguuMSKN3nPqXszVTQqDKugYBjQ3dll33N7IEK1XFAvggJ518TbXM5m8eqNuxoC76o0L
 xLzQ==
X-Gm-Message-State: AOJu0YxqXfPdQUUAO/555dvne+xhEghCss1LPSauV6Jp1O4UhnGY+lPW
 URnBc701ATHykQaPImC+7pTkIDK1yYjY0yX+4RpiTIeGZDu+2jQZMXYEbzixxqnu161Jq3D7HCv
 riEh1Ihw=
X-Gm-Gg: AY/fxX5HDLG/KDuf/zydPvwAcUhnHV1xozSuCWQC4NBoLq5CaJm5Vi6/TOHVZM+k3V4
 vJy2/84DaZxWtOPjlscLvm82z/gET+zfpCJj8CgUahDxDact4AGhMDGaVWXdBUSlxJIx8bb6LYQ
 6+AsEhq0ZV+K8RmukOA9+YTjKtlobWRE4ZNsNeeRTbMFdZ0u5iW7ZKG5ZQAFkiarcN41zNkjm3R
 i8k2YRAXklu5eXm+feGtY1EgF6J0kDufhv0Jg7amd14tGIx/Ukupfi+oFmSfJtRlgQLNG9vTnjB
 gbq1hKstureBraJURsu+NQh1QhPcwAFfgUInlSAa+XplfTuUcjqmTZZ+QHqJUDgQoLOWe3UKVU0
 LyC0DU9qRHBnfCub+vCgdp57m7udVpLEw8ZTGnTA8nMcq/ldZAOtVkOG+Zu1HXTzt6nJ0O+LEkV
 LFNuxG97aZl0hxHcdo+Iumx0TAkRsqE3ku8IAZPOXVzyGe+11f8cArZvI=
X-Google-Smtp-Source: AGHT+IEfTlHG9HebKmzADt1nskBT1wZtpW8hhMxhXQdJxH2V8nwQP5xlKNq3OP7FqI1JigjAy2T/4g==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-47d195a9834mr174867285e9.34.1766593304257; 
 Wed, 24 Dec 2025 08:21:44 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm325748095e9.8.2025.12.24.08.21.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:21:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] target/s390x: Inline translator_lduw() and
 translator_ldl()
Date: Wed, 24 Dec 2025 17:20:34 +0100
Message-ID: <20251224162036.90404-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

translator_lduw() and translator_ldl() are defined in
"exec/translator.h" as:

  192 static inline uint16_t
  193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
  194 {
  195     return translator_lduw_end(env, db, pc, MO_TE);
  196 }

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the S390x target as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index db2276f1cfc..e38607ee18c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -365,13 +365,13 @@ static void update_cc_op(DisasContext *s)
 static inline uint64_t ld_code2(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    return (uint64_t)translator_lduw(env, &s->base, pc);
+    return (uint64_t) translator_lduw_end(env, &s->base, pc, MO_BE);
 }
 
 static inline uint64_t ld_code4(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    return (uint64_t)(uint32_t)translator_ldl(env, &s->base, pc);
+    return (uint64_t)(uint32_t) translator_ldl_end(env, &s->base, pc, MO_BE);
 }
 
 static int get_mem_index(DisasContext *s)
@@ -6408,7 +6408,7 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    uint64_t insn = translator_lduw(env, &s->base, pc);
+    uint64_t insn = translator_lduw_end(env, &s->base, pc, MO_BE);
 
     return pc + get_ilen((insn >> 8) & 0xff);
 }
-- 
2.52.0



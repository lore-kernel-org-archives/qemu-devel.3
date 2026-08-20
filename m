Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123F3C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5y1-0003fj-B7; Thu, 20 Aug 2026 12:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xz-0003ej-VL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xy-0005Kf-5a
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20gk6XOZKesKo8nbqKHg9FBtClUl2/w6AAmH6nkDmwo=;
 b=MNFxKdpdPoqsWaSg7HceFOJm0xp9bvAFkbOzP4Qf130oa3tV8Kz/0K+aHYAHV/TnMfBL/F
 8i2ZFMIQAeYgLY1oYMgd+qOrB2CH5+OBRYSwKivdtW9h5j+6hU5yYNfRSwgrLvK8wl561m
 afxuXTyHu4M6ut1dMF5EAFYPxhL5mu8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-bWFtZJPpOy2LA2sGvVHqcw-1; Thu, 20 Aug 2026 12:50:07 -0400
X-MC-Unique: bWFtZJPpOy2LA2sGvVHqcw-1
X-Mimecast-MFC-AGG-ID: bWFtZJPpOy2LA2sGvVHqcw_1787244606
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so382325e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244606; x=1787849406; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=20gk6XOZKesKo8nbqKHg9FBtClUl2/w6AAmH6nkDmwo=;
 b=ZIXKa5a8agC6LEymZUGQeN/ZFyDzzMHSkeIRXjn/rfbjy/PLZlB1l39MtJHjFzfiZV
 P2STVwt8fwV96B9LpbFXqSrDX7TFU4HsfsNyztHhmORgpRV15jScj1FNsYOWOj3GPVbu
 vN8cD6BvErusM9erMdOS3ykjuyUBAPtmGRjzKMW1Ht6y6yh5oj8XOKyKtYqV2PB0+rMP
 ZQfiuRQ9OcJB1h3LbaItQT4XD88/asbV5xQ4e9jmX5G1Kr25ujISagze/yp3PFCzFbOa
 OabRJxIjC3THvHkN6XyB4rhTeRbYeR+VUHDxJr9gFTnsmd+czup6dKZjorjHNh+2cHCT
 WO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244606; x=1787849406;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=20gk6XOZKesKo8nbqKHg9FBtClUl2/w6AAmH6nkDmwo=;
 b=G+c8LFHQ7Lzy3MglVwXGy4btXkc2z6SAym8edPJ+AwKukpTe3iIknUzfMWAk4/3IuG
 awXFqbmRcgD54yDRQZ5TkZ9MHTLXUO4cHOBfoTxQydnGu4i2gLFzNvhUF3LfPnua/hAH
 TBL0VCdDjKSY6q3g/fOdouhRX1bbOMmT7yTHN2r7oKmF+rY4fF5ax/JAoWhMrzC43WNm
 MkUawqqaJJUE7alWu7q6XZbB8/ihah2811+qImjQZ90O/kCE/W2WJQ7m5nZg3KVcDuj0
 eSD+IR1TeoAOPImImDfZCYMMWHHE6Q0zyTOxO5e/uWoizu3RW4oy71DyfjkjDVf5Wl4n
 +ZmQ==
X-Gm-Message-State: AOJu0YwPSxfGmSsmmlhtnQewmuUgDo+CoJYN3Me1TxjcMVNaxRGktZr4
 HxSEHzwBvU5UqJDNtZ77WVartj/oL8xQyy8NXo7UqQ3PaahTW2tn6gMxK7BYE3aL02CCAbBAE5N
 mcnV4duBEx+733QLOd/nyIqh76MGC2wKCWqZJalePK47krS4rCViMkIkG8zyL03jXRossPXk/aE
 ipv8N+1enehAMKQfGndGwD7gww0yDE9nh/jqUayH7L
X-Gm-Gg: AR+sD12jaYN6bxC9lf2ywaRFOmN1Os2hvJNrhTOVkmPCFRRdr+hTg4VZIoRdXxlWwv7
 A/KDUlomSuKyU0LjIImoC5sNtX/5A7jsIZr0f9Wava0Hv8pis0Kc789LYbOk4dWVHk/dMg/nVSJ
 4ol2Z9qVToojPymEFlJMy945Pd6FQxRSokVYXAuiSTq4EeXzzy8HWVPZraJ0CSLfgo98mXSWpkD
 ux1KJtz0nHxo+QgHV1ktvnMoHFuJY3PtyeMtdUVkBtWiEi8ewdVYyGhLRzmx0fwlko5qeH08aMI
 K/oINqzMW5m9NfCdK+svvNE1F7ENTscVzad6zaLiXIla1zwiWzXF8i6UuF2C4GzaQumWiD1WRYj
 XFwBJEiUEq5a6zSnG/uzsm7MqFWt7mRGuf2vVVhwL9mIF+qS+LIIcg5xbGCBvHoAgHBBUc0A9jW
 J3qYQ=
X-Received: by 2002:a05:600c:46d1:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499b8469f20mr2358555e9.15.1787244606519; 
 Thu, 20 Aug 2026 09:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499b8469f20mr2357505e9.15.1787244605985; 
 Thu, 20 Aug 2026 09:50:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17fc80sm166886685e9.14.2026.08.20.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 02/53] target/i386: Skip supervisor in xsave decompaction
Date: Thu, 20 Aug 2026 18:49:05 +0200
Message-ID: <20260820164957.1895963-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Supervisor state should be skipped b/c there is no slot in standard
format XSAVE buffer for it. CET State is being migrated via MSRs and
other supervisor state isn't currently migrated.

Fixes: 8612deb3f4
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260702124746.450228-1-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |  2 ++
 target/i386/xsave_helper.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d8..fff701c6c42 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -655,9 +655,11 @@ typedef enum X86Seg {
 
 #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
 
+#define ESA_FEATURE_XSS_BIT             0
 #define ESA_FEATURE_ALIGN64_BIT         1
 #define ESA_FEATURE_XFD_BIT             2
 
+#define ESA_FEATURE_XSS_MASK            (1U << ESA_FEATURE_XSS_BIT)
 #define ESA_FEATURE_ALIGN64_MASK        (1U << ESA_FEATURE_ALIGN64_BIT)
 #define ESA_FEATURE_XFD_MASK            (1U << ESA_FEATURE_XFD_BIT)
 
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 625bae103ab..1fa3133b1a2 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -332,7 +332,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
     size_t i;
     uint32_t eax, ebx, ecx, edx;
     uint32_t size, dst_off;
-    bool align64;
+    bool align64, supervisor;
     uint64_t guest_xcr0, *xstate_bv;
 
     compacted_xstate_bv = *(uint64_t *)(buf + XSAVE_XSTATE_BV_OFFSET);
@@ -383,6 +383,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
         size = eax;
         dst_off = ebx;
         align64 = (ecx & (1u << 1)) != 0;
+        supervisor = (ecx & ESA_FEATURE_XSS_MASK) != 0;
 
         /* Component is in the layout but unknown to the guest CPUID model */
         if (size == 0) {
@@ -433,8 +434,14 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
             return -E2BIG;
         }
 
-        /* Copy components marked present in XSTATE_BV to guest model */
-        if (((compacted_xstate_bv >> i) & 1) != 0) {
+        /*
+         * Copy components marked present in XSTATE_BV to guest model.
+         *
+         * NB: Supervisor state is skipped b/c there is no slot in the
+         * standard format XSAVE buffer (CET state is migrated via MSRs,
+         * others supervisor state isn't migrated).
+         */
+        if (((compacted_xstate_bv >> i) & 1) != 0 && !supervisor) {
             memcpy(env->xsave_buf + dst_off, buf + xsave_offset, size);
         }
 
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1346E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR1-0005XK-GE; Sat, 27 Dec 2025 04:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQw-0005Q7-Ic
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQv-0003aI-6j
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5r1dlz6k+9YSG4rC8cKOerFMsHuLeVrkakCHQYVz+64=;
 b=awXag1O0SoG2ECWrEJ2ANGe6lHQ2K+RPECR/KGgNX3V6XSkraektqOSyFGVv37AV9PpQjU
 Xpp64ZSQKuYOPj/kO4Fk76y9n4iL5BG9vVSnehw9C44xtKkvLkNQooN/fWoWdWEHADntol
 tL6uvclwPGv4HFW6mIzw4MvPdTPbCvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-6LNsBrPjMMKi6REZy6rU9A-1; Sat, 27 Dec 2025 04:17:54 -0500
X-MC-Unique: 6LNsBrPjMMKi6REZy6rU9A-1
X-Mimecast-MFC-AGG-ID: 6LNsBrPjMMKi6REZy6rU9A_1766827074
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so53225145e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827072; x=1767431872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r1dlz6k+9YSG4rC8cKOerFMsHuLeVrkakCHQYVz+64=;
 b=tqdOAEFivqipjfzuNz2zsOGH1I/EVOEyhF2IAEyQCXsSpNRp0vRwo7E+QxW7KlTV9Z
 W8RQVzGBXsV8xFt0ieu3t6/9fvLxezJs6CD0NYdhi6JCEgyVminfGYA3CtlNRwi3Z8wj
 7kAjFHn/N+JU0X+niAFpq6hfQKUdk/Mex6AiLBBDzJV/qxZjG8Io5j2/CdP+977zbqxN
 mBBbDpp1xSLRGmyuEawj/qov14T9wloPCReERPoVoBb44otaUWfMLUheferd1e4bkV0s
 m9N713glgd+A+SQMUSVQRXyGIO9Ow5S9jOxqNrg6mV+qCWIaPi19jKwtzDa0RVFoPCsJ
 Bgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827072; x=1767431872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5r1dlz6k+9YSG4rC8cKOerFMsHuLeVrkakCHQYVz+64=;
 b=ctPwngLn2V1PP8UyGwRF1la/Wt3zyQ+Ykc6d0yj/Z9K+ev48FnQ5NM/pS4qiYpjY1E
 c4bW3/CqWgq9r3xnwy/A9J2nW94VEQ1n6WN8WuoPgmyuO9VzG1PJLBt5k6CzfYZkVhZc
 D/KA+cLhav66XMwXluI5paAn08sMd06Je2UEvr9hvMM+1DN6MEzzl7H19K/zD40fhbaM
 Me7yD04+dBtGEO1TG2AXvHioiIcMmLQ/50+MAvnxOoObUfSbWQ1N/AfqkBOap6DmAE/W
 OOoKzJxVCyJCwQJP2J316CtXdOhtJqJoCP1gBhrlOGzI9IqbnqtI1s9sACRdY0Mt2ZmE
 LLYQ==
X-Gm-Message-State: AOJu0YwVrGkn1yL1BCamsahhz2A8w1iKUMoBmtCuqLIzRIrdeGRV4sO8
 396KhZ+gHDtbhtR2r1lieTb3xov8RaIYGz+kyOA6F+hpC4Hw6JqG2Ja+FswVYw4J626Hvgw84jg
 JmGaT+Cm9NlVpE3aT0/9izqy5dN2WN1i7Yu9kztI+pWnWkO3knZzf4tS1KN0VfEJnWHaAFjzyft
 g22tBkXVU5QHlAhv+0daFf5VHmUOJvKMPddPRVJo8A
X-Gm-Gg: AY/fxX4xBeW/NJACaDWop+NS8ClWeOePO+t8GJRq4eBYRGXqFAl1AJWY0plQup6uta1
 3P0TZKCK3EExPTRlMBRE4Y0kxzq9pa3rnLbCqxrOOGEqw5NfsxUeE6OPFoJyIQFjDhpxrsBqOV3
 nS8oGp+mz6C3uoEzYaNe1uZQZK0904vWomHC2zX5Y2uLcY4vrXQVkwCLeqRwLU9siuJexXeskUa
 ImFlrnD0N+oPyKsDkqHj9vRn8yLnQIKgQv9+8/Zhc6GNySdrwkVObPrhPXNaeuF0HPzt7Y0nTFH
 Iez+wbjjMxET7S/0H3PmAwQ5nTtEwetZt3GZgTtKUnvS1771ta/spXaiRGPrtP8wETR1eibBJ2V
 Exq5KOdZEsvxYQTv3GihPcK1cUDLMeYmuqz9lCEbzOJ1Jl+xGVOkNAkSvVAM0Gjd4Lj+vfPGyrA
 yDPzZNKEZVlTE1bWU=
X-Received: by 2002:a05:600c:608e:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-47d18be1812mr309056625e9.16.1766827072271; 
 Sat, 27 Dec 2025 01:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIPcjVqkXNhoaFYL/RfB8+ABKIQEcXfngKAhmmox9EdSPEa3Os4sOuFvBqh4kM4rQ3ort1dw==
X-Received: by 2002:a05:600c:608e:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-47d18be1812mr309056395e9.16.1766827071912; 
 Sat, 27 Dec 2025 01:17:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm442664075e9.12.2025.12.27.01.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 047/153] rust/migration: Add Sync implementation for
 Migratable<>
Date: Sat, 27 Dec 2025 10:14:34 +0100
Message-ID: <20251227091622.20725-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

It's common to define MemoryRegionOps<T> and VMStateDescription<T> as
static variables, and this requires T to implement Sync.

Migratable<T> is usually embedded in device state, so it's necessary to
implement Sync for Migratable<T>.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/migratable.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index ce603867502..5700554f7eb 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -340,6 +340,9 @@ pub struct Migratable<T: ToMigrationStateShared> {
     runtime_state: T,
 }
 
+// SAFETY: the migration_state asserts via `BqlCell` that the BQL is taken.
+unsafe impl<T: ToMigrationStateShared + Sync> Sync for Migratable<T> {}
+
 impl<T: ToMigrationStateShared> std::ops::Deref for Migratable<T> {
     type Target = T;
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE96BE8FDDA
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxW-0004gI-Vq; Sat, 27 Dec 2025 04:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxV-0004UQ-Dk
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxT-0007VN-RY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCaG1nwgpbXIQ3m8UmXg5hYwFvm7L1S7HW3EI+DXVS0=;
 b=UzuPnwDJ4QXD5gHOylb1D/ygUtbTERkUf0HAX6M9VDo1SeFgPc9ACcdqq6MC7/xMh4cuVQ
 SiwNGw7McAh7IEnmbbK25B3gIfn+lGBJwFXy2qr5APolf0vDSJ9MNvvPJVytCtK/oHIEBx
 LEQEH3g1TlbDsBHQIEVGfOnF3yH/fBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Ukb74MjcOAuldMS2cAQYxQ-1; Sat, 27 Dec 2025 04:51:33 -0500
X-MC-Unique: Ukb74MjcOAuldMS2cAQYxQ-1
X-Mimecast-MFC-AGG-ID: Ukb74MjcOAuldMS2cAQYxQ_1766829092
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso99694635e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829091; x=1767433891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCaG1nwgpbXIQ3m8UmXg5hYwFvm7L1S7HW3EI+DXVS0=;
 b=c0orhhwpcWeYZRXuRu8v9/7jchnQKyokR9x++K0H05tWm4r+1iTKTZAy1oYF4tl/Mi
 5bQ0rubrYEFsQcCTV1GKY4uHDqwg1ly6/ZDfJbBh1GHiQHu0DYJXjmDVwH8Jxl1B3TSn
 9S47sG5e/UGMu2BZ60EHcAfczLJkLc3/sj88nuX/ShpUv1aS5f8swc1E/3Gcyx6lrGlY
 YLiW3DMtyvyC7AVtaB0dyf5S1ZG7ZG/5m80fIIdDqKMOV/4VhTxJU1bSRtJ7O341aiAR
 jbbW3wrWUSAbIDetGFTCUk+4Luq/BEBQD6XzBWOHkmi2wfR562weEsbkV8IG9JTzGWqH
 GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829091; x=1767433891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCaG1nwgpbXIQ3m8UmXg5hYwFvm7L1S7HW3EI+DXVS0=;
 b=gytTmRRHy6gZpG9Q/TNfG4bxS7HPbRH3PU4MJQKweRNbjhpWZzs4QRh9WVa7BXAu+s
 3gpytXkIwNWDzJtj0TiNfK1X/dazZ3R+28lHthT49025b2mTzIih8ln3aKsN0+AXsB1z
 yebY/1omIsoN7JkkXFEbhDvbqoYZJB/x3shmNw5QNJURjF11vl43kritFQXfzAvPOvab
 JktnDWTFZefsOFK3k3jYc94dRJVzJ8y3H5+8KHjncgsZUR5f97L5Ax/WeuWpbnt9qUQa
 wj1xC0FcBX1DMfq1d1Wx7pkd5pDiCvDV28eu+yKJY/74ihrJt2J0JTgbx9UZbjUO4LMw
 p3hA==
X-Gm-Message-State: AOJu0YzJoR6bY0eZONpkfwJ/e2DLEGigGrbsTeU68DCNdv8zoS17HRxa
 BzxRgwnuIimpW5oI+TAlxmMe8V6gU1iFGJLPpOuoVKsMJthnf5cyk3/XF8QWYGTd2o/GG4iJlZW
 6wNcN0Rv4GEOnfzBYHlleTeouYzWpMb9ALX8jFdENiLX+LJ62xlczi6G3urWPiyWnh4G5vnA9AN
 Csk5uvui+oq0TVyAgCvSHyoBTERaLvN7JeQcix0C1i
X-Gm-Gg: AY/fxX79XnFOm4vLDBgqTzqVUctnQgSD+fO4EQzvpbri6U/cwss7wufanqxR0FNJtEZ
 4ITYBUYJt/SM+43LZxtIMRGt8owFCFr8vtWqSxLLvvyGUPhbgm2LxKhZFTLQY4aTI39X7PsBwBS
 ifjy2RLa/Mms7sXU+0dJX4TYp+9QvcHW+KcVAyUEfICMwfkFbXErGa0bX/RewH7QjT/EJvVrNfX
 iklX2HecFmPDfEcWM5hl8HX/4vDlHsXD6RV4Aoc+YESVLXAslqZzGucemKLpLmF+wtK1pXmJ8Vo
 Be9Ijn6PAiyQsE10zNTpYT5KuYNurDkp10JZWBeyq+J3Qq9Dl3QKUYZ4/9rXlQEncV682yO/BH4
 f8naFCnK5xkA90U7km/BbmiJJ82jQeQUV0szGbVg65MTSD5VuTEhy3MzdPwSh/yUYDc4GWTNp/R
 VWZYj7ZlFmg4ihYQU=
X-Received: by 2002:a05:600c:3b94:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-47d19566b00mr331933865e9.12.1766829091447; 
 Sat, 27 Dec 2025 01:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG02vpVJgDbUimjNabSyJZPvaoG7yRAQGXLwNRPfgnubTF/oCuQlpDmdtegaGiY8SIoshRHhA==
X-Received: by 2002:a05:600c:3b94:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-47d19566b00mr331933595e9.12.1766829091003; 
 Sat, 27 Dec 2025 01:51:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm483489325e9.5.2025.12.27.01.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 143/153] i386/cpu: Add an option in X86CPUDefinition to control
 CPUID 0x1f
Date: Sat, 27 Dec 2025 10:47:48 +0100
Message-ID: <20251227094759.35658-69-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Many Intel CPUs enable CPUID 0x1f by default to encode CPU topology
information.

Add the "cpuid_0x1f" option to X86CPUDefinition to allow named CPU
models to configure CPUID 0x1f from the start, thereby forcing 0x1f
to be present for guest.

With this option, there's no need to explicitly add v1 model to an
unversioned CPU model for explicitly enabling the x-force-cpuid-0x1f
property.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4ed7f4f1c99..49a8f30feb1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2313,6 +2313,12 @@ typedef struct X86CPUDefinition {
     int model;
     int stepping;
     uint8_t avx10_version;
+    /*
+     * Whether to present CPUID 0x1f by default.
+     * If true, encode CPU topology in 0x1f leaf even if there's no
+     * extended topology levels.
+     */
+    bool cpuid_0x1f;
     FeatureWordArray features;
     const char *model_id;
     const CPUCaches *const cache_info;
@@ -8014,6 +8020,10 @@ static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
                                  def->avx10_version, &error_abort);
     }
 
+    if (def->cpuid_0x1f) {
+        object_property_set_bool(OBJECT(cpu), "x-force-cpuid-0x1f",
+                                 def->cpuid_0x1f, &error_abort);
+    }
     x86_cpu_apply_version_props(cpu, model);
 
     /*
-- 
2.52.0



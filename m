Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA857EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvH-0005lA-Ck; Thu, 12 Feb 2026 09:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0005O7-LD
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXur-00066L-MR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/BATMQ1KN5pWJq8a9yC9CIZttopA3VSwHRJBsr7m+k=;
 b=OjN6t3Ko5Wtrfw9ipocX8SqK7hg0t/8LvCbU34xMa5mlsLFH5JQwByollUrnxtUkvDeVzC
 tZ5cVYQf9VCuxrt0so92rnwGHLPvbBSfjCpAWGMrX7UoETEjOonBagjT5hsPaLLAofqHrj
 VpOYB2hcYKAjliNg8WR2lKEMR9OEyWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-DaBHpZ-xNDm_KTlc8vvZwA-1; Thu, 12 Feb 2026 09:43:31 -0500
X-MC-Unique: DaBHpZ-xNDm_KTlc8vvZwA-1
X-Mimecast-MFC-AGG-ID: DaBHpZ-xNDm_KTlc8vvZwA_1770907410
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482eec44485so24802705e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907409; x=1771512209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/BATMQ1KN5pWJq8a9yC9CIZttopA3VSwHRJBsr7m+k=;
 b=Ko2OuYtzngI+FIC9kyndSQyiTn03T8tBEK1xsS7eZJZCKPW/cn5/a6vzTXOfmPBJs/
 qZziTyoxKM+p9xoVd82C8qlG+2XdOW1bVQ1DbTM93TXnOisOW7yBr24Ar6Pa6JQxnPBu
 X5SpmOmctTCfqCuCSHMs3U9kaToj/E0T2WlYzFGqIbcfd0xbcpqnYTprnidF6iS+qzp9
 nDo2pHw/o5aT4Cgm9Z6sv2VtYpnJ8LUjuwBHVXVMrDt2Te785/hnnvLwXRIiM8vUvvgv
 /AOyo/tv1zzg1hVVO1XnDm9gzsc4NJ8hVS3BiXm4wvpUQsG6efy8vOx3LRUm6ISZeo45
 yWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907409; x=1771512209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/BATMQ1KN5pWJq8a9yC9CIZttopA3VSwHRJBsr7m+k=;
 b=oHuTB2/k+XqbmwhQPgCqPAfBiMDz7et5wHO2PGjCRpytiTSjCIQ98KgkJPHC+go69d
 VxB/OJI1GjkbetIiNtDmT381wFmTW3mnBmLssTKMCLOoesXzSKG71VVwToIl3QSFdCxS
 kHDke+IVugq5LpoBG9Peg4l4L33iGJlrIMSPdTkiTjtOp2gdFXkzHsZb5UekeTuTWcOA
 TPSp2J/XKfqkscJ3GOmmZ2pLNlftL7CIbBpYe06i6eBKT1joAaYykFxy8PrpBMWDpV18
 w1xhxtOt8j4xOO6NZAfh33KAgJ+hsWKH0FAH1c+WgSNsT3bzlv5BXaiR7UXlST3tjjh6
 9cOA==
X-Gm-Message-State: AOJu0YzIbRx5Uy447NMtPXl2itVJSZfriKOVBPo1eud9lfXYQPTOh+dk
 Q2XQBdOaTAF2BBp9dY/Op7dBYCkcR8jYaBHFgFStZ49g7+EYKAB3fs6Rr2Gq1rqAoJkJpTXUgv/
 O52/A1mlBHXWbGBh7RFLQXWmLUoj60lBCGpaLVNlfA6d3s1eUyEp/q1pRC4/JC0O+2eQnL4tWl+
 Ts1fI1nfljcBAHrcw3pRWgXSZ2Mds9ach0ERtiRTNl
X-Gm-Gg: AZuq6aIbbodhuVg9SlA9yb4gzqYy3cD6q0uJ8NYsnrN6YRTHVp0kK+N1GY4HgXuu7oy
 y8KjUKhML1Vn02DrbnaxTyMvppRPiw3/IYLcgO/gUbd1vFh97HfoScp5zSNdWcNOk36+MtTAjr+
 ++XyNnvdzxx0JbSYpgLLzHHRqcYmjHEg/5WMo2XhLTG4jm2MRz3B+6+mnx6OJkpbtsggrBFMj6y
 qjrt4ElVMmJcmgL9VD709MixGk9uFhegR/tVfXfESBjRULKVhvi2wWzoRUXX6UkIykUmWx+oE+C
 NlyVLAgcyaNCi5FhyUf6KX2T8PmUMMQtFAKPzowpOLVgcO8yH/3baF9PcontrZqSRUtEW3u2qjD
 V/BtsK56ONoBsrpQ+pIku0QbaUwB7uFKgEc7QvnGLOSz0D8m8rtGe/1KTlxj90mDJ+5ilVApgwx
 CS52Hoq3NxLe9KV8n8zbBEG8mmQsCqzl02isJaGDcF5cG3IpDLjHw=
X-Received: by 2002:a05:600c:621b:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-48367113facmr34912345e9.9.1770907409311; 
 Thu, 12 Feb 2026 06:43:29 -0800 (PST)
X-Received: by 2002:a05:600c:621b:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-48367113facmr34911885e9.9.1770907408808; 
 Thu, 12 Feb 2026 06:43:28 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d8334a8sm204685175e9.12.2026.02.12.06.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 19/41] hw/core/machine: Remove hw_compat_2_6[] array
Date: Thu, 12 Feb 2026 15:42:21 +0100
Message-ID: <20260212144244.22579-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
pc-i440fx-2.6 machines, which got removed. Remove it.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-19-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 07f89387525..d6ff9f3d233 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -885,7 +885,4 @@ extern const size_t hw_compat_2_8_len;
 extern GlobalProperty hw_compat_2_7[];
 extern const size_t hw_compat_2_7_len;
 
-extern GlobalProperty hw_compat_2_6[];
-extern const size_t hw_compat_2_6_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856b..2664848c2b0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -293,14 +293,6 @@ GlobalProperty hw_compat_2_7[] = {
 };
 const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
-GlobalProperty hw_compat_2_6[] = {
-    { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode */
-    { "virtio-pci", "disable-modern", "on",  .optional = true },
-    { "virtio-pci", "disable-legacy", "off", .optional = true },
-};
-const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.52.0



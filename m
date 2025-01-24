Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7117C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFi-0006tM-8J; Fri, 24 Jan 2025 04:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFe-0006pE-79
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFc-0003t6-MK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD+mEfAdDUkodwsyNQ6ua+15ZST6/FVUt+cz1H6YqK8=;
 b=I4pek+epbOPb/JPCQ19AYus3pBUs3Xw1HMVUDIkcplJBng5ZkSHl9OEJdzwy1XpeXaFH7N
 IHYNgfmnhgp6I4l3YMDpPNevUbqeCK/BwIvycdQxvvvk9TmFqolNHduU2j/+wiOY1PprgA
 zNWCBEmudygNRR9HlehuPTMJsdSu4QQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-_23GfbwJN1eoTBd-JrSn5g-1; Fri, 24 Jan 2025 04:45:18 -0500
X-MC-Unique: _23GfbwJN1eoTBd-JrSn5g-1
X-Mimecast-MFC-AGG-ID: _23GfbwJN1eoTBd-JrSn5g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d80576abso1182532f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711916; x=1738316716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RD+mEfAdDUkodwsyNQ6ua+15ZST6/FVUt+cz1H6YqK8=;
 b=ob09QV00Dx5kEcU81s4lfHduH7v5LTNWbPzqxzRMO4sNiAE/lStQFTRGDBNwB7i1Kl
 f5aqPLBQQ3rhN46CEnr1Ly9ozK72/hyR0s+dg0jU3xW2SeGrErX1PHUTuX6u656QP5Dz
 6w6TslAh4KVuQRLIobCIfKYp0/uTRzvl1tA+ZVwY4AtdKWCGoD/ChAiBSln7oan0DtHD
 ZMrk3xWZfq1bjjsatvTzzv2K2kDYLRHYJlQOKf9Os0H8LeBZCxG0rnayRIH6aYaX0IaH
 xTyoTXMlt0M6KuYvnXLmpN3ChQ2g+xANoCgRlnULnJRfhnMtNZVpcLoKkZQ+WU5MPPYf
 U+Aw==
X-Gm-Message-State: AOJu0YxrCKI0bVVkM5EM6v9zFovpamKe8EyFYDhzaxNT4e36Aq6E7bVh
 GflYS5viZbmHZTdLvOXjjbxa5zf5lKrvX4JwzzBlrgpiy8B0EdBXxU+88MKRUU1tnXrQzrzzMBX
 4j1EZHCU/5bdyxClaBCX+J55gW8vbMVabI1FcWN2rw5hLfQz9xvQEDZT5wp1mrsr/xJL8N0RjUM
 kI/gZXSWfRcZaR1JpV+xEl06EY3twRTGGWVH4bPpg=
X-Gm-Gg: ASbGncsurzybJ/Hrc9E7X6O3YkgwqAnmH5RxZWx6lf6fkbbnw309xL7P4Y7NyFZa1Fe
 meblVOwnfOsqxA0ezt7Cun0UNLHi3y7sVSl1MLxnwnV9PQMOD1SWXUOT+mCRzsI3AhYzZZ2iOHy
 YT2esD3lMFFoIlrIUXTYEfsKMyduWX7GQl+gNXZWQGXROcWSnirQG7AL64CshdQD2ivR450NYZ4
 OTutFx0TGJW/ydJXZKeBML4cz0mivtT4clXb2B4vgXbindWtICQxv84KohNcdblbIMapqcVyQ==
X-Received: by 2002:adf:f48c:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38bf5659a94mr23984758f8f.16.1737711916528; 
 Fri, 24 Jan 2025 01:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdQpy974WgGHbEVD5uPHNT71/Z2lx0UkA0QVHLx9JQ7VIITD7kh44vZLFUj5DR0Zb4ZprZCQ==
X-Received: by 2002:adf:f48c:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38bf5659a94mr23984729f8f.16.1737711916116; 
 Fri, 24 Jan 2025 01:45:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm2213554f8f.69.2025.01.24.01.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 17/48] target/i386: Export BHI_NO bit to guests
Date: Fri, 24 Jan 2025 10:44:11 +0100
Message-ID: <20250124094442.13207-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

Branch History Injection (BHI) is a CPU side-channel vulnerability, where
an attacker may manipulate branch history before transitioning from user
to supervisor mode or from VMX non-root/guest to root mode. CPUs that set
BHI_NO bit in MSR IA32_ARCH_CAPABILITIES to indicate no additional
mitigation is required to prevent BHI.

Make BHI_NO bit available to guests.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121020650.1899618-3-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6db8d6c9bab..33fb27a6119 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1364,7 +1364,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "taa-no", NULL, NULL, NULL,
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "bhi-no", NULL, NULL, NULL,
             "pbrsb-no", NULL, "gds-no", "rfds-no",
             "rfds-clear", NULL, NULL, NULL,
         },
-- 
2.48.1



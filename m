Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9C0C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEc-00088Y-5Z; Mon, 14 Jul 2025 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1R-0001vC-JH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1N-0002Ba-AS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMfqWPvcVidmxEBK4/G1WoAxmiQybmAc7UCJEFyhd7U=;
 b=Eotwra1YZoIIbkOmkRxE0dDlEsnYCVok4/LtuAynh0rQcRrmcpSf0Uj9uUgQJneDwhRoeB
 4wsoC3nnTPK/yOsu0xeCM7N2cWlW3Wd9uI3ohqKI/PpK6bxMhpq45s123Yhu76/+gsWmPC
 P6WFF7uOoJ9v+FYvH4ZdmOtEew9aiyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-6pzZzK-xN92DCJHXbGK4HQ-1; Mon, 14 Jul 2025 07:06:53 -0400
X-MC-Unique: 6pzZzK-xN92DCJHXbGK4HQ-1
X-Mimecast-MFC-AGG-ID: 6pzZzK-xN92DCJHXbGK4HQ_1752491212
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so22106885e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491212; x=1753096012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMfqWPvcVidmxEBK4/G1WoAxmiQybmAc7UCJEFyhd7U=;
 b=RkYJOZUcSnJ9uJcLsZztZfkmkXsfanE/XLfGJZH3ct1QGDRKoVhON9I27w54oizDzO
 +mYLnG7Zlo4qt6cmThQ6EA+Ivpc3cQDP1ob7KFJPvCfOoDwHneQVojMv6K7jMtu51Qbc
 OWhvuHS55mNGCAfuG+793CGyzIEOeLwyG7eTcOvtabEN0IHuhs+/N7ZRRQPTniONMMux
 EFpC/4hsBPdvtJ185rZQC+keRiSqdLlhYI6FMOMz9MDswR3ZUfTdJoZzYDAMJpop5zDl
 pqnou33o6zsXSK+zSP2LtTWLvaQRXuqQBF1hOFvRTSa+2/N62acTOmsF24mxCPT7Bh1L
 df4A==
X-Gm-Message-State: AOJu0YwEjnTSqRDSYojruLfmpH+PvsRZINONCrO9sqDX8oGEs2MvvFjr
 qZRdy14CkaKtrhO6BagrerJ3QXZjoQoQJrWxAy83ko97ZZ6s2X8Zd6PEAibw51YGj91vU30Gjxw
 7uOSxbnuu34b1I2YhUi6AikooVCktjlkKnIyQCUUgyt9/RDHuHaA3nm2YkLcPTvhdMbeSKdAyPT
 rmbMMhi2rDGllZt3m8kJ9dOecNGoEbJ95l8Mwsxaiu
X-Gm-Gg: ASbGncvQVV6udI0vHNYa/WmTbU5ZMrEePEbXHMJ8Bme0u+c+pItqXAtFoIVJ+zChSsQ
 qrfSpHTkgIt15rW4wjqgRO1Xu4LisuGFZXtIFTHlzHrXE8q7d+yovEOsIX+CRVjnclIzQ/2T/II
 WPxkGt+yWOSTyatHsMZuitzT4XK17lF6COhsDX60mGDj7v3qQyPI72LtqE83XUcnng/fgh4jAyc
 BEwb8cz7qygAnFqsHL6iVwUmiFyG50OeujErxyy09q6ujE3n1aoORVkIN883Ef0NcxRG3YKDmLL
 4WahpekAEumsAesPgVCEAnLWiuS50sg9KTBgWtlY1A4=
X-Received: by 2002:a05:600c:858a:b0:453:5c30:a1fd with SMTP id
 5b1f17b1804b1-4556f8a7931mr59412105e9.8.1752491211632; 
 Mon, 14 Jul 2025 04:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv5bCRunCofTJumNggl6l+ykKbwR+Rw5um5Et3CuTryT2Tg1cTsH4xsquumTaKKuEAqfXJbg==
X-Received: by 2002:a05:600c:858a:b0:453:5c30:a1fd with SMTP id
 5b1f17b1804b1-4556f8a7931mr59411855e9.8.1752491211040; 
 Mon, 14 Jul 2025 04:06:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d867sm12298615f8f.61.2025.07.14.04.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: [PULL 63/77] i386/cpu: Enable 0x1f leaf for SierraForest by default
Date: Mon, 14 Jul 2025 13:03:52 +0200
Message-ID: <20250714110406.117772-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Host SierraForest CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 482979a4437..668f3e63b7b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5389,8 +5389,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with srf-sp cache model",
+                .note = "with srf-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_srf_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ },
         },
-- 
2.50.0



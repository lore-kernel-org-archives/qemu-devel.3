Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29FFC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuX-0002R4-Ka; Tue, 04 Jun 2024 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuW-0002Hj-7p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuU-0007GL-Lw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7mdmU+ZL8VSYWs6nhwkEFB6lBfA8fHVc8t5bF9lQSw=;
 b=DKe33pG6B1s5hBULdXNu1CBrl3oL2KixGsRE/MhRXBlkNQpaVSWpyOn6Y+esPhdPUU+GJo
 EI/71m6VBm0f801owDFoApCddPpLNTQDxG7kSQcLokO9n/Dh1flqXYTYmuMD/nXatEHZKg
 EXv2c2kej0wScrSxTJLgue8kJPLTE+k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-UzJTKk0bNZKF4HjBQ6fqeQ-1; Tue, 04 Jun 2024 02:44:39 -0400
X-MC-Unique: UzJTKk0bNZKF4HjBQ6fqeQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a5af3e160so313256a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483477; x=1718088277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7mdmU+ZL8VSYWs6nhwkEFB6lBfA8fHVc8t5bF9lQSw=;
 b=XGy3P5D2sJi+ApZaD3S841e/+L/7+FaC1xSXk908buz14+cydoT6JSeR2wndQTtL7B
 fTyevZ9zAWVRl6DSkUn/V5fFauyWGewsIGBKYOsRx/sFxEhVkWeT+TU+WlZ7GrdekxK2
 awVIHrtUkfOSfLPEdoT05bF0zJgtAdt9SOClGMXRmoHVZ9SUPAQ+GImIKJAFcXSaCzNV
 MpcjznyRSDOw/1XDnkG9dn9ya8it69hdoFBJfoXNlS4Oss7iM28zvU29hnNfMOc4FW/D
 BlgDEQMHKytpc7DL3W0W1QBEvbCo7f9XtIAH3Hbt8tdJV/xzLTxEqE69fQe0GeudBF6/
 gukg==
X-Gm-Message-State: AOJu0YyjTObSRVJT0PqL3wnPqIk6gOaNMqiYu06oJiS52dkvcFfO6lHs
 ngn6Y9CFwohiuyA7PNlqirNR7vnk1UrcFZ16USC9g9SXa2ehNWP0QeptS0yx5xBxahgbUI4J3fn
 8hSWeGjFV9MfwQbMmwyFm7yAT9UNZccWW3coaQgh32w4WVgYaj9SkW9nlXPWN23UFZNvwA+u4J9
 421XtV7NQzwxdpUd+Ba54k3pG87u7r+cWXVxq6
X-Received: by 2002:a50:ab59:0:b0:579:b6d:b8ba with SMTP id
 4fb4d7f45d1cf-57a3639596dmr7673349a12.22.1717483477264; 
 Mon, 03 Jun 2024 23:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhsbCvuvCIpdXV2UP0exMEMeVYatSUJptRIAuNlfH+KwMt9DctvvJbBJ0bRvZXmecMruShw==
X-Received: by 2002:a50:ab59:0:b0:579:b6d:b8ba with SMTP id
 4fb4d7f45d1cf-57a3639596dmr7673333a12.22.1717483476913; 
 Mon, 03 Jun 2024 23:44:36 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5cbece23sm3960207a12.61.2024.06.03.23.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xinyu Li <lixinyu@loongson.cn>, Xinyu Li <lixinyu20s@ict.ac.cn>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/45] target/i386: fix SSE and SSE2 feature check
Date: Tue,  4 Jun 2024 08:43:32 +0200
Message-ID: <20240604064409.957105-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xinyu Li <lixinyu@loongson.cn>

Features check of CPUID_SSE and CPUID_SSE2 should use cpuid_features,
rather than cpuid_ext_features.

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 27dc1bb146b..0ec849b0035 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2041,9 +2041,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     case X86_FEAT_PCLMULQDQ:
         return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
     case X86_FEAT_SSE:
-        return (s->cpuid_ext_features & CPUID_SSE);
+        return (s->cpuid_features & CPUID_SSE);
     case X86_FEAT_SSE2:
-        return (s->cpuid_ext_features & CPUID_SSE2);
+        return (s->cpuid_features & CPUID_SSE2);
     case X86_FEAT_SSE3:
         return (s->cpuid_ext_features & CPUID_EXT_SSE3);
     case X86_FEAT_SSSE3:
-- 
2.45.1



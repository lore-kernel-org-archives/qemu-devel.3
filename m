Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756EBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zZ-000807-CE; Thu, 20 Aug 2026 12:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zW-0007lO-GK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zU-0005iQ-R6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqq9Qg28PeFYQDhF8/CvyMcQOpgjlUe2VXm7wKnJLUs=;
 b=FvoNxA59xBKncOJAPe4yypkwdC4IJF74PWhT2egvTz0pIsnysSg7Brh4lf2BnlRQaDFEJk
 bSR+lNP4Ca4ov4rxaFzv+/rQeaHLAB6hksjUO1CxLEHKTKDSX20kTdzb9nXOEPWF53gGBl
 vJR6IdnNsVWgQsLrGHSwSyiQhx4X4ZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-klW7BiZ1Pu2uRmZxIuK8EQ-1; Thu, 20 Aug 2026 12:51:30 -0400
X-MC-Unique: klW7BiZ1Pu2uRmZxIuK8EQ-1
X-Mimecast-MFC-AGG-ID: klW7BiZ1Pu2uRmZxIuK8EQ_1787244689
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f83416551so83037f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244689; x=1787849489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqq9Qg28PeFYQDhF8/CvyMcQOpgjlUe2VXm7wKnJLUs=;
 b=hSYqyljfRiHnZm6p0c/m4nC8m4LaLotnvebtRs24x6NUyMCCmtv9G8TnxQivirf2V7
 Alces08WOHvKzhjOOZJD9qQxIuqeJlxw9+vBP4u+A1I9h6OCYiWLU8dbc13hTeK0B2do
 GHnQualOqOsc+d3eKgnRtj93gQdmwkLSsTfGuH7QVs/kzKqsdZRUBfp8/GA4uFk0gjVL
 2thOA63pF61u9roLATg0r5Fr6P9DDh5dVi7X2qcZLIT0yLM7h+cNk+i07C6cQWi3BVjX
 jpgSpPCqE/Z//91RIN0dnEqV43jropdyvbNjYwRgvydTYYQEjZwrSU5QpKIiarHONDLz
 tYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244689; x=1787849489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kqq9Qg28PeFYQDhF8/CvyMcQOpgjlUe2VXm7wKnJLUs=;
 b=Qmjps/9tzJe3Hg57CUsuOTJmA+wd0Xc+/S9f6UUb/+QmvjcZ5bGlzKqgYW189Pqqow
 LruZkkQi65CpgyvoRvn/zIcq9CaQV6U3OZ13s7KXWpKPTl0edT4bwalHZ+9gxHgWfZuy
 q9T2Us62RMdHT2morNxEl5ViZlwc0LJKQvAHQP5D+h+iTT7/QnZjq0RrdDvbmGRgDv+Z
 kFQMqdKrIiWkPgtkTuXc6Yqd/IGxPvaVf6QwPzKbhB77BfKMLc4N5QChpjOvn5EFt3k/
 tzA0AE64m4yj7rtes+V7I7pWzmr2218Zgkavx4PH/fFkNMdTT/cWwcr6TnKPBcV/wSU3
 qOyA==
X-Gm-Message-State: AOJu0YwbGDemHPDGZ/WcaPK6OhKi7WN67S9bsCkm3V9tA7qvZKTGtyJy
 j68MiECsZSRBlG8YFP2xSUiCATCzhowxUsEST6e9NLwOY0QfneafABMeukJTfo/w895Bb5sSvee
 pQcMAIT4g1KCK3s5XVgDZIYXJsqwV+RoJHOlR8oqMv2hNOIHFausIm4eL9NpgM8fDYqEjVlgNn6
 i7JArDnzTgiIV5nW/MmfEOYouVzMXn6C7jpT1RkWtg
X-Gm-Gg: AR+sD10OIa6CUpbMcsOvDIfZ4oZYo3iENcWFoy6a8sMJMMeJflRrjFZ1A/T/JFSPdOl
 pRqHVX0excW1ouzd3XevzzwUR6dR5MVL5SaFp6NRwwNwz8sV1pyWd9Efixwy4UjpwwRYiH3aof5
 f1Ezhmz58ORyHTge9TI9rKX0EXEdgrXqHGn9jTFhE9/W5smu4bzEsjmNjNYy5JXh0tC9BYBGPHv
 qA2/UrdOTdkFS5Nkj4y+15AOtBhEUN9P0pO4v7TDBHAv1Cwt3Z8SG10S2dDEPf5LBIpU6pf+jzg
 xahjo4euqfLxXUcQdJThpCDPD29hIIpXTpFgMKd6/MzWU5zpG30p1VprF9iNo9Ca3GDTqcqTmaj
 xmpiabaUjfAYqvvawTAF4tFmgewS/geytyPoYG66a9AZckEauWGpnOr0QhGSTzSzPuiUY1ZC83w
 omMzM=
X-Received: by 2002:a05:600c:3556:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499b8454819mr2932305e9.11.1787244689380; 
 Thu, 20 Aug 2026 09:51:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499b8454819mr2931435e9.11.1787244688914; 
 Thu, 20 Aug 2026 09:51:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b70bddf3sm3960275e9.1.2026.08.20.09.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 31/53] whpx: i386: fix xsaves enablement in legacy probing path
Date: Thu, 20 Aug 2026 18:49:34 +0200
Message-ID: <20260820164957.1895963-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Without this, Linux will crash in a configuration where
xsaves is expected.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-cpu-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
index d341e6f4fd1..3fb5ed79e39 100644
--- a/target/i386/whpx/whpx-cpu-legacy.c
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -113,7 +113,7 @@ uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
         if (idx == 0) {
             eax = supported_xcr0;
         } else if (idx == 1) {
-            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
+            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES;
             if (!whpx_has_xsaves()) {
                 eax &= ~CPUID_XSAVE_XSAVES;
             }
-- 
2.55.0



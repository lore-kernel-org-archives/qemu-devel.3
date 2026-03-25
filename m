Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4498F109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RM3-0004pW-49; Wed, 25 Mar 2026 12:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM1-0004p8-He
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLz-0004cw-Uw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrGcx5SIbojAJCYnCMhhFRMwGUlUPZaltqmhri0jqaE=;
 b=B4ISnXBrRlQIgN3neABoz/iQWgWI/p69ilIn5jR41eFKuhXXQiG7enIHtRNLzf9QOLSxEc
 vwRwTb4HuM7nKVxyYzYxM/Ff93OcnG5H3D+7vy+fFv3/+e9J9eiSfObBd9cwNZIpc2ry4J
 1wqk/i5BeWFRlRkjOchODuLPwdhSp7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-IWOal9oFOCqwZ-6WHyOZoA-1; Wed, 25 Mar 2026 12:45:09 -0400
X-MC-Unique: IWOal9oFOCqwZ-6WHyOZoA-1
X-Mimecast-MFC-AGG-ID: IWOal9oFOCqwZ-6WHyOZoA_1774457109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so556975e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457108; x=1775061908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrGcx5SIbojAJCYnCMhhFRMwGUlUPZaltqmhri0jqaE=;
 b=dNT427owXfs2JgHTZLYIy4ObrtHllnVxOQaeoU6C7aIz7osJITRJR2wnlD/KYqXBcE
 z40bMFP+NHwaFEVqzn4y/SODX6aC4zZJFcmSpZwGIeAi+qRu3x+eSB545LpgkqP98a9s
 dPKG5v4EElCrwRB2dpPxsWgeJ/YLEJw9jSyQrmZmCulvaKhAn/Yp4P+p5ubKPrpe/2B+
 y88B6Iyz4ZBUgQf3rtvGoSWKWXbzioePUXcp6yE6dwRrCJcjqSNkdXsiF8qi6ptWJMts
 MvACYjKk5vXJ5vu0jB7SFLAlCKkzETvlgs7sVew9WEtfibadk5iixgYoOH3ZXXgccw8D
 Toug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457108; x=1775061908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DrGcx5SIbojAJCYnCMhhFRMwGUlUPZaltqmhri0jqaE=;
 b=sGr4P/ZAQLLe4v4S8UxYZWZtxiIsX7Hzd7dTyHvNsoS6KuhLzfbb8tQvANKO4iPFdi
 IJMdBz+t50G65oSIAvrRzG08UhcCCZREg3C9isUE7zcQ7QjtoDd+KgBhKvGDrLN9kDQC
 xVPI70RSZOFeWVVQQHiBDsH8END7GjC/1ojljwmIlvDRux2Rza/WPh3ph/1BPh28N4GF
 u6LNsOEo0zCwOQpHPJ04lc8UlbW21pQCIRbK4K81TC/24cdZRiO4wIAPdZmaS0QFOxkp
 3ucvBiTKvnmHWBxLPdSo4tPIT2IqSk9T0d+vUgS1SO42fjxZ/6AnntV/lBYjjwgilmbl
 F8Mw==
X-Gm-Message-State: AOJu0YwiN91BZxyfLbMOCYiZpeTrC6yz1UYrOwJRYHt+gSPjyxouUQ2Z
 NCXD1+BWeWtW7VHJhmAAGvSBtoQzQ0LO5myqbwmB2mfeFwc4teIUAEDD+lYa4fmbI+kSY57DgV2
 Njjt+z9yzi6A5vEjsMuGZ/Gl9wEZf5aYS+N4NZQZ56P3HE+KHaSTkEtVKRdAgH4qj5hEVesxMyc
 UwEGzQbA8Ulx0gX+U+G/lM8w9hkkHd2IVAq2nYwGy7
X-Gm-Gg: ATEYQzzLcmZNUMktDyXDL3WGsuy/+mhCIQA/AF/nL8byfORWv1j1eI/lrf+l79N0BDa
 inD3/5iSx6MekX3uCqh5YmahHO5XlJElddRaGp/yoNBtJbqcyiwWC2NPMJFP4dj4VPPMBZnZbIu
 0QILVUds3jYFbLjUQ6LCmfnU7IROJXcvUYY6XLNRw3PHz3LFDSyflzNK4nhH/Ouv4505588DHjh
 O8mebvC8P/nU1XQg9sO9yejEyj/0p96iBR6BgZUw960tA5Xk087GHjyr7/d3LaTa8Miu1s/E8S7
 EBNkGST5BSI1Gt/p0r1r6Zj4UNetJvUrpa/rsNI2ot0sPksKcnHIAwPZNNvxD78OFO0Ms27RdJB
 TmWa25Q+vzquNZY4SEhOKXy23w/h59DjU0am4pH0veGs89OlaertxKI8wp712KfJW4858zwuBGr
 OuWv3PixEYMv2CBcdWk/jcR+Th
X-Received: by 2002:a05:600c:1f86:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48715fef87fmr66009765e9.13.1774457107833; 
 Wed, 25 Mar 2026 09:45:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48715fef87fmr66009325e9.13.1774457107300; 
 Wed, 25 Mar 2026 09:45:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116f17f3sm137715975e9.1.2026.03.25.09.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 06/19] whpx: i386: skip TSC read for MMIO exits
Date: Wed, 25 Mar 2026 17:44:40 +0100
Message-ID: <20260325164453.72127-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The TSC value isn't needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8f1835ee95c..ac03445d9da 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -606,7 +606,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (!env->tsc_valid) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
-- 
2.53.0



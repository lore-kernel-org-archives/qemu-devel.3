Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8FDE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZo-0007ui-Dz; Wed, 11 Dec 2024 11:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZl-0007KT-1J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZj-0000Yk-Fh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBgLfBS5ZuN9Z7jRu8BauK7VaaSsZ7DmRIPGkrNFP5I=;
 b=TU7KpsZlJvi+jxXzBcy/BDOLQBiEZ3MN7ofzGYMh0AVKbBKc42RN+RnrXDXY01Og5BUbBe
 S8rxwARRK4JStnqyILew1kkRKhi6uocTADYLhpCMS7Ic6P6D++34ZFrhirzDRs9iSBhxmE
 9ubcf2r3AD7/c9ZCjCyOXnCzCSRB1nM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-6lXsWJ30MoOnndM2wOt3Cg-1; Wed, 11 Dec 2024 11:28:33 -0500
X-MC-Unique: 6lXsWJ30MoOnndM2wOt3Cg-1
X-Mimecast-MFC-AGG-ID: 6lXsWJ30MoOnndM2wOt3Cg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434f3a758dbso36613005e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934512; x=1734539312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBgLfBS5ZuN9Z7jRu8BauK7VaaSsZ7DmRIPGkrNFP5I=;
 b=CwIufvZQ2pNRdO5ch0hWI0my7iznUO6kgPF9pBq3OvlMEGc9VaPptgxUIkcFVcApgs
 WIE15FvF0JkeYkf2mIoPrENNEd6YLtllF/Mxzr6y51azqIAnrbyv3uHb/QCT6tBaUdsg
 ko5MLYJMAC91bL2rTxIYxSGm3BJye4yRF/jjOwDLZsg3IVO6v3281zz3vkCiHHoKbtZM
 W3DbiqB1C+HDBWf1q+C4kJwaSM18t6KlWnkuAYwUSyukpUeLWZv+m+vf7O8+qq7FkH31
 Y6GIJ83gD64zd9sU5KMJdJHbKZSJqA/XdXQAdrTwDmgm8CY03gJccghJTDIgh6lENlNp
 41HQ==
X-Gm-Message-State: AOJu0Yx1kO+/vfyMpDav6UqpIiuu2/7oHChloIWBqjL8Vlu8f3JvTCu0
 9xXakbeArP6STZBDinKyyC7pL14FHh/hxCthwtwR+YWfjJSRAaF3gd+kqTA55p3k5lfVHwcn5GS
 XqoQlksm7qmbJrcWpPvVA465HRveK2viPm8ZcCpxUPlr1JcbULBf3j43K3J3nStnguSOWjnk9yf
 hmLWqLPJJXiGAMLvndnpx7zWbPeZ5sSLiJkvxj
X-Gm-Gg: ASbGncvyfB+MCuIMHiPxk0j37AB9Ek6kLPvbOOge7bitqovfC7jj8+IqgH4A/RdzwoI
 R0YjQBJ+cauHzCyQ8NOD9bMXFSqIzq4sOVdMIDNG45b+sp9+q++WE5ALF1cHu54Kk+rb39M/OUf
 lYo5ttljZch3nU+4h2SPW1oNMC8cnY24/Mip05EoktetMv5lsTmny+w7eRT+2Ac9U86lToxg1E8
 8mONY1yz2y1jNzcPgs7rASiNfrM6QiKHyQvZCdFcrlswwUi5PNZVLpD
X-Received: by 2002:a05:600c:5122:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-4361c393894mr28479335e9.6.1733934511712; 
 Wed, 11 Dec 2024 08:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+5y81OY/u8ufDzx1N4jxOVntpMsfsDLMSUQJzp/FRFvfFQs/FgDIJ4Lln7Zrb1FhXso1iNQ==
X-Received: by 2002:a05:600c:5122:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-4361c393894mr28478975e9.6.1733934511039; 
 Wed, 11 Dec 2024 08:28:31 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361b7a46c1sm32662105e9.33.2024.12.11.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/49] target/mips: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:59 +0100
Message-ID: <20241211162720.320070-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-12-zhao1.liu@intel.com
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c7..4feacc88c0b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -626,7 +626,7 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
         .class_data = (void *)def,
     };
 
-    type_register(&ti);
+    type_register_static(&ti);
     g_free(typename);
 }
 
-- 
2.47.1



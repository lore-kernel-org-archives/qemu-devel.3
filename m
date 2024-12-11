Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCF2E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZs-0008Li-9C; Wed, 11 Dec 2024 11:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZn-0007lf-9N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZl-0000ZB-EU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OIwR35d63e1rEw4wpchzcthjW0MxeFOPrWTnC7Wi88=;
 b=L9kzaSukodJfhdKO+o7A23ikWWsWe/l4rFcU6mg7gs18IeBKntM7e1Ll2IeS4/zBpZdavx
 Ln2aP7O82P3x3IIpAgLlZsvOccy0oM97VRUhIODQjeWJzeYYX22MCuEvrVYYO7rVkba6Jd
 vowu7eE75Mvuo9glCcCGk8HI1+ekCUY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-BCfykE_XO0uqv_nP199CCA-1; Wed, 11 Dec 2024 11:28:35 -0500
X-MC-Unique: BCfykE_XO0uqv_nP199CCA-1
X-Mimecast-MFC-AGG-ID: BCfykE_XO0uqv_nP199CCA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso2567934f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934514; x=1734539314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OIwR35d63e1rEw4wpchzcthjW0MxeFOPrWTnC7Wi88=;
 b=Vqf+EgPNshzxLgbzN+s2d798erHatUIDF9vOYgyS3xykFpynZzMK6B/NcHryQfWpS3
 kx5yYQhBkSU27bK/TPRYb0OgEC+D17KHvsE+q6aBwSeiAzYRCi0hqDXI1E1zsMNWid7S
 NZqqoeEy70nIplYsaU8H23rDaBuNqm/ji1rNNMbdXNq6n6hChH4TamgvD/kPKV/1GOM6
 HnARXLR73ne7C1cwRkF+v0D1aXd5stfpLBtlVlrWXIdqewsU//xmjnF2eAql+Aw96UyI
 YHlZ7Wd7gliQVeqsmCfs5Jro+YgTd/G6Q5hru//yNxZrjvq73s/9pwU6M22i2sw7TJmj
 djcg==
X-Gm-Message-State: AOJu0YzgP7zrnqNXM5B4KihizVcZmTEXXzCAawTLjXdgpV1fd81DTGuG
 oqvAriV64szQA4kkH1VsyTV7YMhQDcBUlkfk1x6dzogxpx6ElC2eYaDOSrCWGaxG01IERjRALd0
 fOZ/74EIJokSnaMCsOpQvdgQ0umYNPooOFO8GK2Qu+K7RnkIWvuE8si5bSlESjEIpyc8L7iiCI9
 fylL4hdLWo6gAPulzgL/HJycRjJ/zePR94rXp0
X-Gm-Gg: ASbGncsROq3+KYBSqQddFsXwQ1EX/cfJNbXsTWHrbulegcEDNTQbuCATce3lEO0QqwC
 0uJPGyaHFpLUCcMQaZPXsPq1b5m3fDRTliwb5/I8C7xkehbtHWeR2dq2WdrpFFGTULGbr8xuZ4l
 G9K4QVj9Bj4fmruLERa+mqbGtkVLvoExOBzUIZWWdWTsy7JMEsS2V8RKWJ7MvPYfO0KWu1Bgn/r
 emI280ykaZzlL8rHcqD1INRilWcPfK0Od1gZTDOMx3h3PQZ1BGyAYRT
X-Received: by 2002:a5d:47c9:0:b0:385:e2d5:cdf2 with SMTP id
 ffacd0b85a97d-3864ce96d24mr2798066f8f.19.1733934513809; 
 Wed, 11 Dec 2024 08:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7/QgjT1Pp9NCd7DV7Kt51LP7hQ4uWkoHPTs2nKS9PEidkIuOl+AQ8Hho/kCDMDXVOIP82oQ==
X-Received: by 2002:a5d:47c9:0:b0:385:e2d5:cdf2 with SMTP id
 ffacd0b85a97d-3864ce96d24mr2798048f8f.19.1733934513406; 
 Wed, 11 Dec 2024 08:28:33 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dadsm1614319f8f.68.2024.12.11.08.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/49] target/sparc: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:27:00 +0100
Message-ID: <20241211162720.320070-31-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20241029085934.2799066-13-zhao1.liu@intel.com
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de73..adba24af2c6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1008,7 +1008,7 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
         .class_data = (void *)def,
     };
 
-    type_register(&ti);
+    type_register_static(&ti);
     g_free(typename);
 }
 
-- 
2.47.1



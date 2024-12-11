Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EC9E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZe-0006CN-4X; Wed, 11 Dec 2024 11:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZZ-0005mz-Rn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZY-0000UP-0r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfR3bsD3EZkoCdmWNV8N9zfVxdC7BnuxFxYvftQbw4s=;
 b=BZAfFDHWyMJmHwgV7KzViAbsgBi94NHzk2HzT8XzWK7hngKkGnCER+FvEOC9NQqjWueS1n
 sxd1Ktct8EYLidtskMGiQPgNycpwJrO94EcLnDGvwM51hfLvgubACLb3czujMml/8UHvfZ
 Sw3nUEHdAics2yhDjtNoME5RC3ryWD0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-d-LKAo3bOKKYMxlCez4lnw-1; Wed, 11 Dec 2024 11:28:22 -0500
X-MC-Unique: d-LKAo3bOKKYMxlCez4lnw-1
X-Mimecast-MFC-AGG-ID: d-LKAo3bOKKYMxlCez4lnw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43621907030so5609185e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934500; x=1734539300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfR3bsD3EZkoCdmWNV8N9zfVxdC7BnuxFxYvftQbw4s=;
 b=DAWJb5bWL9ZMf9w6NRl1mw+eHsnI8oVH40deJAUlWcsGh2et/8hXE32WJa9LhCOf5D
 DCtcNMfSVLA6eYSiRYfNmmvKzDFkgMEfQ3YW8stvNFXYhFLwdgBWhlGtRWg6vlfQj9sF
 Cbn7qtP6qLHcxyncyUZ3W59gCcLgIH1VMpdg/hODdk5ZSZsn44gPrWmvYAsjr12AwsGz
 2gnQiWxM5SK02TftgF+KSj0HUjEeumaVjpv4mWcipc6ekks6Gxc1+iEHR+EETr3TtrGZ
 t4zh1dhg00lXbK5kjpV9km/OowCLOirjZEcVxyUhyNjdNGa+EcgHLI/a6nWjECnveIy0
 2Kzw==
X-Gm-Message-State: AOJu0YzQhrH83hb3ziFWmMGk/mFK7LCiv6IzDqPSkF2NKkxUTiM7T5KE
 EZ2nDHoeXnca9PFbHJjvC4/MdSqrKF3TkSMPOyYPjNi3seO1SCRv9ajP/nx26eEfDN5+gvG2yYy
 duHYWDjV8AokgM9KI7rHtPOc0iPVit5IVLf/fuT0dyi40wemJYWX80qXtrv/bYsl3nlnBRisARz
 X/i2cwU2fLnWpQZr/S7WNN6v1BbVkgeQGitGcF
X-Gm-Gg: ASbGncv7KHmsIsizPSgghsvGRUuVoGfOhhmckysLcNq6T9seEaNkzYtIheqJm7N3v+W
 e5zQQ9Gn/JMoRv0Tv0bPNYwZj/CyGpROJn/oVbdVfWTwQZberfiBa5vPXGbd0uP5XhzR8U2/CLE
 e5mhprR8KPrO0z8Hovw3g3CgQFzgrPKd/gkrafx5Y2NgBOncdbUyuvnwJy6gqMl/LZBdUuqNl74
 ny3R2O9/ClTrla/bnkNvhOtkOjlQcytJiW72TZ5KYcHpNBeW3NRn2XS
X-Received: by 2002:a05:6000:1787:b0:386:31a9:31ea with SMTP id
 ffacd0b85a97d-3864cea3c64mr3771950f8f.33.1733934500329; 
 Wed, 11 Dec 2024 08:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiHoZt3Gpwb3xgDhc5Nq79I/SiF74+IuReGehRxJI3Jlt8QrP41XcFNzLJIxtWLiGbG6nngA==
X-Received: by 2002:a05:6000:1787:b0:386:31a9:31ea with SMTP id
 ffacd0b85a97d-3864cea3c64mr3771930f8f.33.1733934499965; 
 Wed, 11 Dec 2024 08:28:19 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514f29sm1663118f8f.77.2024.12.11.08.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/49] hw/scsi: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:54 +0100
Message-ID: <20241211162720.320070-25-pbonzini@redhat.com>
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

Replace type_register() with type_register_static() because\
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-7-zhao1.liu@intel.com
---
 hw/scsi/megasas.c | 2 +-
 hw/scsi/mptsas.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index b33229d71a4..df58aeb9952 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2576,7 +2576,7 @@ static void megasas_register_types(void)
         type_info.class_init = megasas_class_init;
         type_info.interfaces = info->interfaces;
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 361b75e633a..c6bc3479e99 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1450,7 +1450,7 @@ static const TypeInfo mptsas_info = {
 
 static void mptsas_register_types(void)
 {
-    type_register(&mptsas_info);
+    type_register_static(&mptsas_info);
 }
 
 type_init(mptsas_register_types)
-- 
2.47.1



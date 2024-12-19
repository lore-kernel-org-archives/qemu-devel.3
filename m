Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2953CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByE-0004p7-Iz; Thu, 19 Dec 2024 03:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByC-0004lQ-Up
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByB-0005Ay-5G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbyntGtYpHsSrSs698oFtn5IEUzoH+5caUeaY/RmSYI=;
 b=M/HAknR3EraJuKrgVKMPvqYAc1Za5nkBWLCOcw6AsXOY0SZbwjvsPjDRp46souN53gWALv
 j68vNgb8viWOufweJofgmcCcefH6Nn7Fuh6TP7URkB3h1W+YXXsvnLjuHduw/waaXys3b+
 /ITSqCuEfPiqPGApJybgcTPDX/fiCkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-R8F32i5KPSWwhYb6OTf-mA-1; Thu, 19 Dec 2024 03:33:16 -0500
X-MC-Unique: R8F32i5KPSWwhYb6OTf-mA-1
X-Mimecast-MFC-AGG-ID: R8F32i5KPSWwhYb6OTf-mA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so2896555e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597194; x=1735201994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbyntGtYpHsSrSs698oFtn5IEUzoH+5caUeaY/RmSYI=;
 b=pohGNA9tRHv0ZNDlhxE7nSeD8NSG9EkgWnSdrWyXLzv8yq60UiHalG9gWV5Ln64+7O
 rEFCBdTMCvLFdbrT2g2ymOcVHeQIYrAlBVhir9sfiAxOpU8oTiXUi5sIUlqv14Aac5KU
 ABA0RmHumrMQFfCKVZcuXvCbsBZ16bxtn5jsCNnk5vz2DsgvIAIMwtOy9WjmYJpUW2NE
 aoArdrQl6GpP6FWfe9f2ilV/ZwIM/KE2kgqhR0S8pOr3NtXO96pu7JvnDgSIeZcXinsO
 UZc9UUg8foUECMXHj73ouS+MRu6q/scz3ersKM+CMBm7RpM1QPEuBpjiOigFVDLfNF12
 krJw==
X-Gm-Message-State: AOJu0YxkNeIFNnZ9S1LYbxMT8VDB1Ady6hB3zWmf7J/I5DpPe+EgHRpW
 ACWaI6lP99OYa1Ic5a/au7km1EDrzv8fzQSSlboDI1Si+Td2w+kkMax1VKm7iGXcIiTvlhmK7gu
 hKQfB80cigma9kGgY8mRYv4bThkEI0vugT14MUMnAq693xTfC/1sIsCjc2fD1dWrqWZZdPsicPi
 8IQWKofAV79RSbuwK6An5dEpufNcutdlSHwFvW
X-Gm-Gg: ASbGncs/ME7nyg1y+4xuiaViJjhdZEbyo+HvxSMJh4cSUP0+I9NZw9Jeh7wRxpdoa83
 iCl9bvqxG+mtXlMzhcSHH255UnJvHAyw/fGCaVesackTXKwcoPUUQ4pKBSNdgvudKElIg2UdKUi
 udQvBqouGFJjK5CIWmYUL3U2oOnr5GNC5S1Vuvqa8K+QF0sN8sikseAZ+TUzkXhtPLDspbPyY6Z
 r2OOpkInxP/WMWZcVaAUL9kfkQpwlUHydNsn2kDDdPGd8juT7G1lHrXaGgU
X-Received: by 2002:a05:600c:4f15:b0:436:30e4:4590 with SMTP id
 5b1f17b1804b1-4365540cd9emr48113235e9.32.1734597194271; 
 Thu, 19 Dec 2024 00:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfazPnguJEwALqI+CCvmNXE2Rq8USpfKvrbXr66pIPLzYS2ZIJCMUpdLvYDfsmgf+UZaPNQ==
X-Received: by 2002:a05:600c:4f15:b0:436:30e4:4590 with SMTP id
 5b1f17b1804b1-4365540cd9emr48112955e9.32.1734597193831; 
 Thu, 19 Dec 2024 00:33:13 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b1e8sm45823375e9.30.2024.12.19.00.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/41] hw/core/qdev-properties: Constify Property argument to
 object_field_prop_ptr
Date: Thu, 19 Dec 2024 09:32:09 +0100
Message-ID: <20241219083228.363430-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-23-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h | 2 +-
 hw/core/qdev-properties.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3680cd239fb..447767688b6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -201,7 +201,7 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
-void *object_field_prop_ptr(Object *obj, Property *prop);
+void *object_field_prop_ptr(Object *obj, const Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a3d49e20202..61929b2865a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,7 +51,7 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *object_field_prop_ptr(Object *obj, Property *prop)
+void *object_field_prop_ptr(Object *obj, const Property *prop)
 {
     void *ptr = obj;
     ptr += prop->offset;
-- 
2.47.1



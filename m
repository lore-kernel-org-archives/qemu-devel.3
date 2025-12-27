Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2BE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQL-0002aF-2s; Sat, 27 Dec 2025 04:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQJ-0002ZU-8P
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQH-0002X7-Qf
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMZbrpL/sbY9nggcHojULDzfnocTCN6gHzY1sKeWxnM=;
 b=bAG/agJUiH4Gy5UaHTLKU1xb7efFeZMneDS1UIlecIUoCI09+VEkJMtOrtZ/NdaprVNLP3
 62TKufcuybz11glfNa7kvDj/O/XvmAmlZq97P8Vcf+tQREsYpNRJ3oQe5yxEOZ38ZtZhpe
 qjTIC2/ELBPnQeEFS1FtJEA7VhdKzuw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-H4C-aD5kOYmXR9GZSrx0mQ-1; Sat, 27 Dec 2025 04:17:15 -0500
X-MC-Unique: H4C-aD5kOYmXR9GZSrx0mQ-1
X-Mimecast-MFC-AGG-ID: H4C-aD5kOYmXR9GZSrx0mQ_1766827034
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54866275e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827034; x=1767431834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sMZbrpL/sbY9nggcHojULDzfnocTCN6gHzY1sKeWxnM=;
 b=oM6aDL+7Dad/0GGUiufbjyGSsylzStyZdOl2RdVeUjzCqKFDgkLGoOcp2ZeJeNYURW
 38DW9QB5iaYgyM+xcMZtcMNCrFLxXM+03iDNBiQA00703WntBzRAFIrxsSOZ51S+Nnba
 nu5ZEocHUEMqjhn1leoPfGXWZFE+GfsBPJGfwPigL7EPsyG1bCwHXKwN5RdtfI5LkOtA
 omoO4Ay8zfa7d1yCZzMheiL4+b5arA9OirGKKBCfc8KLLKgHLXw+WX44TSjcUjA9UrVv
 I85jhNzYknGwDQmT6ZZBSdxhhyxf7I3oX4NLvJco1l8tPzl1oAMbOyud/gfnIk1jH89y
 COMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827034; x=1767431834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sMZbrpL/sbY9nggcHojULDzfnocTCN6gHzY1sKeWxnM=;
 b=T7Wq0D8irGHdJEKjTVgBSKFKypQnffs+UHDzWqmHDOw1K2QXq0vDKngl9lokx4wIDd
 sl+vhwqr9SGAh3JAney/WGnNvHUmHzC3Fy0ab74A1OwoHjRROgmnVG47mwKXF5g0WGUk
 pturOHQvIQsyFywZdiCszooVPL6yRlC45AMbXN2U/CveIPy/of6v50ArpJLYGA8l5GKE
 uqYHXJLAT1BrFJQNzTvWehzVw7ah6nsqiKM5olsJlV3ENHXtEp15y8FFg2UcPGquaBn9
 jBbLsjEvsWE8/Uat7R+pu4ekHADmb5zBJjqya5FK1byPuPEPD9SluJg09r9Gl1Pyzbmy
 NlQQ==
X-Gm-Message-State: AOJu0YxfXe7OPeo1ZvxeQNhDjp/tya0vtlBg4D06EbQqkaOnFiZRQBcu
 ke/PhMacioPoqIDY1zrGmgwFhpD/o2ZbtCeNsKAsGcxz3pb6NytmTlzIfwekCeTaX5GcoNuI4Tg
 Xc9IMTtUhXEj1dfL2lYx2AITQoqnruWRCO/0B6H/qpGrEvqhcwOC4UYLpAkSzenOJ3/RKjqPOpS
 u73IKpdJFnLxuNlUlrpnPR62N6yek7ZzCA136qNyf6
X-Gm-Gg: AY/fxX4rVdFXCpt//vD/lw1Yy2DpSc+Bqv+OzCWqSUdMktYZ99FsuMZUd0pLVGTIv9q
 519Xsm1B2g80AsX6zFA6fB/1XX+qnb27ExcH7wNLxkvcwufPsgtRWmfbPk8WzPk4oUz14VUnd5D
 QQyq6yMQFZRQeQbclzXjJOLhS/tLOAz2z2NLynaNVbhm1Qspl5s1xLN0Ti7MuOQrYzdDW4anos9
 +pRWM1fk8mijA3NP396+ZGLEKC0FES0U23Wv1RUSRWYwwgLkjf0OhPcb5HFrFDL2qxjCpvA5pex
 IZWL+GtogeSD4mb5BBh8t4OT7HrsYAXTCC6hIfwzwQwi2v+FKMG1DREbcaiWcE8Shp+xrmo/H0v
 MnNHHkOLd55m7Ko6xShRYUF73l5DHisaT2jtv6OF42oEcvx0BYK6h3PzgPqhrbJlCODd1Fi357B
 ML5KgXJB44eTcwyBw=
X-Received: by 2002:a05:600c:1d1d:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47d1957da90mr278533715e9.24.1766827033820; 
 Sat, 27 Dec 2025 01:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWOAWVregNtHZX0WsrdK0Z/nHD7fVFAyZVaEsnYXEEn9IABMduHdio9YHVuSR58nGkre4xJw==
X-Received: by 2002:a05:600c:1d1d:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47d1957da90mr278533405e9.24.1766827033228; 
 Sat, 27 Dec 2025 01:17:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm433083535e9.9.2025.12.27.01.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 027/153] include: move hw/vmstate-if.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:14 +0100
Message-ID: <20251227091622.20725-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        | 2 +-
 include/hw/{ => core}/vmstate-if.h | 0
 include/migration/register.h       | 2 +-
 include/migration/vmstate.h        | 2 +-
 hw/core/vmstate-if.c               | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/hw/{ => core}/vmstate-if.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44d84aa243a..5d33892c347 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,7 +3656,7 @@ M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
 S: Maintained
 F: hw/core/vmstate-if.c
-F: include/hw/vmstate-if.h
+F: include/hw/core/vmstate-if.h
 F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
diff --git a/include/hw/vmstate-if.h b/include/hw/core/vmstate-if.h
similarity index 100%
rename from include/hw/vmstate-if.h
rename to include/hw/core/vmstate-if.h
diff --git a/include/migration/register.h b/include/migration/register.h
index ae79794cdd4..d0f37f5f438 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -14,7 +14,7 @@
 #ifndef MIGRATION_REGISTER_H
 #define MIGRATION_REGISTER_H
 
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 /**
  * struct SaveVMHandlers: handler structure to finely control
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a87a5efa428..ed9095a4661 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,7 +27,7 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
diff --git a/hw/core/vmstate-if.c b/hw/core/vmstate-if.c
index bf453620fed..c39631c7586 100644
--- a/hw/core/vmstate-if.c
+++ b/hw/core/vmstate-if.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 static const TypeInfo vmstate_if_info = {
     .name = TYPE_VMSTATE_IF,
-- 
2.52.0



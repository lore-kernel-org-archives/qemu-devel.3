Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C0C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4o-0007Y5-Rs; Fri, 21 Feb 2025 07:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4f-0007El-M8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4e-00079v-5V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxbSAxlMP5lXdwMUAFqhrkgFZvw7oxzLClb5NrCtOYk=;
 b=EcmK2z/leP29xhHFABrNFIwQFV6lgX0mlPrzQtUsN3lj92dnf1rr7AE7hS4jjZLn9d4nna
 xENr13yabIo2+w/8JXM0To/CGNt8CNIPyVcCJTJEsk9mOdjGeHZW7tNepTrPvqOX+dK4Yr
 0Zya013SZs1KcXGJKqwvyHeIPdfzoxQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-dsls1Pd9PJ6JwVsRxy50uQ-1; Fri, 21 Feb 2025 07:24:05 -0500
X-MC-Unique: dsls1Pd9PJ6JwVsRxy50uQ-1
X-Mimecast-MFC-AGG-ID: dsls1Pd9PJ6JwVsRxy50uQ_1740140644
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4399304b329so11188365e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140644; x=1740745444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxbSAxlMP5lXdwMUAFqhrkgFZvw7oxzLClb5NrCtOYk=;
 b=BWys0hF+ZFQT0u6hWGqBTMb0uDHhIW+0NNE9vBpt1xGHMTCuvKC6xKtDU/J5xyET8C
 899CQZfMECimyXBwLi9PRc6cOD0mqeuVoYfU9YdLlZdEwtca9Urz5iLPs3LngrutrmWj
 RrAiLrMj31Ot93wap6omKcNVUYoCTIQ4DgXzrH9xfGPhWJUFwR7B20QD56Lat5niQw8w
 VspgjA4aSM1NsJDS8ELP8djguJgXJTPYWLj3TOYQRS36KdTRfjpbUBE1NII3ovLGyYiF
 3mQ3kROc0FRNFzu3QRF8o2/cree5ePI3yL2fGHs7AIz6jRiyQ+72idPi8BtUuPQpfcNh
 f6gg==
X-Gm-Message-State: AOJu0YxxlK7qvfWuvueBfqTGRrYCKsHjoglJQQC+wtONirzesCqXn/1E
 cziqFNSSO6FSI1BOeleQY1MobOpRYK3eKxdby4linf6hPpcHiqpwGMBmVKOLJpkmU4pA9HQqq6g
 l/MZbBftVr555LppshbduNtwBnC87tV1ICjJuu9hr5pcpb0nbqRFnmRz++0mQyOHobCBiiOEaa6
 c4wP9h+gT1srHPYIbsbF1s92fmJJExGw==
X-Gm-Gg: ASbGncvcAPqMQoAP47y+Yqi48lGeeB10HaAc4oMQ/utBnx3mXo127JAX3q1uUpB0KlY
 zXRakU0m8bhI+KK1PmQjyVqtSs5McV4vkEZaCQMjNOIJa58o+UgomEViS/09lFAR1/XqFHf0XGw
 KLMDhs1gQYyesHD+vt4ZPmYE30pLX9bgP4GK3FMC/STf0InNJ8fXd3AjOK+NcXvRa7AJ1343A06
 k2qksoQgHB/uoGhy3t+od4IKRzHCOaehEWomIQvdT5fgLbnMFVXACY12SQLSsIsXdEk3UX+yMRi
 2+5v8w==
X-Received: by 2002:a05:600c:1991:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-439ae1f15e5mr26765225e9.17.1740140643875; 
 Fri, 21 Feb 2025 04:24:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPAfdQzI9E5KCm0GX6LhCTTel3l5yQewSOkc69pQNDuhY1Gv70HxVjO0WnyxWH4qUdJMrhTA==
X-Received: by 2002:a05:600c:1991:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-439ae1f15e5mr26764905e9.17.1740140643412; 
 Fri, 21 Feb 2025 04:24:03 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030bdb4sm16054695e9.27.2025.02.21.04.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:02 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 26/41] amd_iommu: Use correct DTE field for interrupt
 passthrough
Message-ID: <63dc0b8647391b372f3bb38ff1066f6b4a5e6ea1.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Interrupt passthrough is determine by the bits 191,190,187-184.
These bits are part of the 3rd quad word (i.e. index 2) in DTE. Hence
replace dte[3] by dte[2].

Fixes: b44159fe0 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250207045354.27329-2-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b..98f1209a38 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1309,15 +1309,15 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         ret = -AMDVI_IR_ERR;
         break;
     case AMDVI_IOAPIC_INT_TYPE_NMI:
-        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_NMI_PASS_MASK;
         trace_amdvi_ir_delivery_mode("nmi");
         break;
     case AMDVI_IOAPIC_INT_TYPE_INIT:
-        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_INT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("init");
         break;
     case AMDVI_IOAPIC_INT_TYPE_EINT:
-        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
+        pass = dte[2] & AMDVI_DEV_EINT_PASS_MASK;
         trace_amdvi_ir_delivery_mode("eint");
         break;
     default:
-- 
MST



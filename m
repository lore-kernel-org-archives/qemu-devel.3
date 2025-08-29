Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGe-0007GY-6K; Sat, 30 Aug 2025 11:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhr-0000u2-Dm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhp-00083l-SD
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPkT/oQDCaPUBTKhrgjd7p4GmdrxFlTRzjrLfJsc/fA=;
 b=Tz6l3W9ucnq5lXFVPol3CydAz4rcOmpSqrqut6Soqhcp+9iW8ZquvnF2XRN8Qb6BNYCBLY
 c8gaaCEnJJheHf7r6auqu8WDAPDS3yDqRtgL6mfhMtG7SxVcdNqpoNw/4c5xuCdc8RbK+7
 ybH/uiDo5weJJbtCAd9Cns7XrhXuOj4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-0UE4bEoNNQiNOzticR_Epg-1; Fri, 29 Aug 2025 08:59:47 -0400
X-MC-Unique: 0UE4bEoNNQiNOzticR_Epg-1
X-Mimecast-MFC-AGG-ID: 0UE4bEoNNQiNOzticR_Epg_1756472386
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0c5366so13165355e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472385; x=1757077185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPkT/oQDCaPUBTKhrgjd7p4GmdrxFlTRzjrLfJsc/fA=;
 b=JfDPXuz4ecEs1H6O610yRll5/LboiochSzAiL6aEKMBpnUVFJUdMM/bjZqvzYS6+Z7
 /aYGTVGnbY94ZvHo2JIFbb/XwSpJo8psxAM5ORHiFCvF02xAXRO47hmzubuYkrq/F/QO
 oBD4dCoepzRy6PN0dgdiAF3Iy+DUp11pzPlLmi7ZpFdIPik4R3Pzaj8YyFzp/pAKAelv
 lTFNZpRzt/c721l5FCRHoBKzuRVlIPJbGqaKwsAmNKjGbGc5Hx3e86an9ZOCFU6g4IcL
 m7utAA1w4FbvCTL/DC1jnYO7YPgDS77BCfhD77due4Lly98xfkHzM/NOghexPGldSww6
 3nnw==
X-Gm-Message-State: AOJu0YxVy3Y6rVY+0jBWRWasVmHdpeBnYei6/IIYX7aWwQHLYr2gK8oG
 NwXmu3RDmE7xn5sxRJpG1PuZAJB/JmrhNsu1Z3IBDhm+TbjcXHlSnDq8yGrTSOD92UdgV8TWIUn
 e7isZ/lvsiRxMpYhJxV8u2dD1Ow+YdPLmFJjYxzNPQXBNxOnYJlr/b3n7LBNImv7Qs6pt1xQYhp
 f90G2Fznvjwm5MRJWT6wXYM4xQlOjjheZzYGM1Xotv
X-Gm-Gg: ASbGncuOL0QiE6IcMdZPk2JUomz92FIKYEhxGjs+POCsPHoEgTg1RK4Ay+l8t8rRwnP
 dyOLbszlvP0Za7iS8P8getErpgTNe1+dlK/PfwwSHbi6PHuiSiJxCQ5GKZx5AchxZ05x6o7y+sh
 flsorLiltypDMEaXSWRyW9pVVkH9ch/W6Jen1mhDlopFBZY3fu0EGbbex+lkqdfJFUzpQuS+a7u
 PBhkUiUDPjW0+W7bo1/jUKXjtRhH6/H6oV/uaNvvGQQN8ghktRWeW7JJRmWUag86Ojp3g1iVW4O
 0HpxRI90lkrv1ziArmeYXQFCMUTwyv938QDfye8RQlcUIUKUecn91Og6Z2ueOrf+kLAYLAXwuoY
 JWd+gQhfhMKvDVjcxaL6iXNYKGoj9B07EHV5ZDkRQclk=
X-Received: by 2002:a05:6000:2507:b0:3c5:9e0f:7608 with SMTP id
 ffacd0b85a97d-3c5dcdf9aa8mr22990947f8f.46.1756472385034; 
 Fri, 29 Aug 2025 05:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKjyQTnZgNBRmgGfrYpi8vfZVF3wS5qeq/xg88hLiz4h6gQC4vB5nhGyepkWCvKbZPpGRQsA==
X-Received: by 2002:a05:6000:2507:b0:3c5:9e0f:7608 with SMTP id
 ffacd0b85a97d-3c5dcdf9aa8mr22990912f8f.46.1756472384553; 
 Fri, 29 Aug 2025 05:59:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9fbsm3328765f8f.50.2025.08.29.05.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 03/28] hw/i386/pc_piix.c: remove include for loader.h
Date: Fri, 29 Aug 2025 14:59:10 +0200
Message-ID: <20250829125935.1526984-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This header is not required since the loader functionality is handled separately
by pc_memory_init() in pc.c.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-4-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9a3b5d88f08..351986232d6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
-#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
-- 
2.51.0



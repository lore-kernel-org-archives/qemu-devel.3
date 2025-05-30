Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE214C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvn-0008Ti-V6; Fri, 30 May 2025 03:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvk-0008R1-8Q
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvg-0006pc-JR
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AnmrsWO7Zf4jQvqc7hdOgurbp4085MGT48vgTwbmGno=;
 b=YdYwPJRIQ5+S7NqhNsFXYaX2MDJhk2Up9BaTGZRdzPO5bq4qGPfMJ2/5O1Pc6K28lBNO52
 D0DHm6UG6+o1+hwB9xv7Su7D3FFM/UgP4X8NFgvGR6AI/C/yGkhM2YziWTrEzAjsQlOFm+
 MEAnkmsVzcEwm29xJWzr3ytwWsv5S3A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-4kDa0ze_NauIyNhtlImWaQ-1; Fri, 30 May 2025 03:13:22 -0400
X-MC-Unique: 4kDa0ze_NauIyNhtlImWaQ-1
X-Mimecast-MFC-AGG-ID: 4kDa0ze_NauIyNhtlImWaQ_1748589201
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-604793191acso1592358a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589201; x=1749194001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AnmrsWO7Zf4jQvqc7hdOgurbp4085MGT48vgTwbmGno=;
 b=KEN1KUfrRXOzr6Qf8bsn7ehjjxrkrq/zlPzC6uYg3m9a4YPOlPqkZj/0fD8Ou5s1a2
 3dcRbNApzWu1qtVjYcQOnycyvFyp14dDt0GDsXdLwH/I+8Uwhdhu4+5OKgPq+zVWx+8K
 aB28OBPwkAPFybjz4OTKwy6+wEngDJ86BofLZtm+huexUScX3GT8A7lFkp6G2izgJxPd
 fv/h37Sf+pGHA7MmwnVR73jnH/lpof4ddmw/d1H/ehHx0efZ11fuNlS/C7zwNzIfTtqa
 r0mQbnZ22ie4/3ib8tSzXL9YE2p945V9KyHre+DjZWwBrzhAp0HtbqvdxjzcVXeRIT3o
 tDKw==
X-Gm-Message-State: AOJu0YydZaQYBMnentq95zHct8Sj0OjaWkR8Q/4zbGvjMPogsbswVD9p
 IBIH4K07eC7+xHEPfMgR6FDkhcHcWMcvXCoO7xBl9OGVbYe+5+fgEsovu2ydVnenes6dCu/qsWL
 Zv0bykubo2EO1Ps9zkFAwHU6nzBBHUXvHBs3YTi4fvf2s6Jx66ejIXj5rUNTt3d8XPRgWO/7dcx
 0SoVJkmTSd9lw86OOA/q5JSSgx7NSPEGzStqb5PLC8
X-Gm-Gg: ASbGnctPptROxekrBBQQnU8WnP+x+CdNwUfsbO8kYptZkPPLzlac759sJHKCRL573ZW
 AnjYUzwhcQmB/W8Mclmfu5UthKG0kLIuOpru0SZYi5Xk0VLe6X0bXQEIyI9gd3jpMHZeVo9X8PO
 uNWqzqaunZ8FK2IONt6cQSFG256tSXBaesEhlTdd1U93KNGT098GUZMbcy6js5UzjQS5P7LZDfk
 yO0wZTDxuexbOJPEgAsrXOv2YpmeNKcELUPt0midLOaGXFf/srTN4/2QEzKu7cBPG4skoVaV5Ry
 zJI1X5M5zbF+qw==
X-Received: by 2002:a05:6402:5c9:b0:602:cef9:a63e with SMTP id
 4fb4d7f45d1cf-6056e9156d0mr1698172a12.30.1748589200553; 
 Fri, 30 May 2025 00:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECshrReUbZW3wM9qIgHa3z/qCRiIcSBiiwQvyo34jPzeZ6DQw1zU9Y9YQMRHWY8Q/uRtuKDA==
X-Received: by 2002:a05:6402:5c9:b0:602:cef9:a63e with SMTP id
 4fb4d7f45d1cf-6056e9156d0mr1698098a12.30.1748589199362; 
 Fri, 30 May 2025 00:13:19 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567143860sm1177565a12.57.2025.05.30.00.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/77] rust: hpet: rename hpet module to "device"
Date: Fri, 30 May 2025 09:11:41 +0200
Message-ID: <20250530071250.2050910-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Follow a similar convention as pl011.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/{hpet.rs => device.rs} | 0
 rust/hw/timer/hpet/src/lib.rs                 | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename rust/hw/timer/hpet/src/{hpet.rs => device.rs} (100%)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/device.rs
similarity index 100%
rename from rust/hw/timer/hpet/src/hpet.rs
rename to rust/hw/timer/hpet/src/device.rs
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 141aae229d4..a95cf14ac98 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -7,7 +7,7 @@
 //! This library implements a device model for the IA-PC HPET (High
 //! Precision Event Timers) device in QEMU.
 
+pub mod device;
 pub mod fw_cfg;
-pub mod hpet;
 
 pub const TYPE_HPET: &::std::ffi::CStr = c"hpet";
-- 
2.49.0



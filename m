Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FF7D25931
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXx-0000oc-1S; Tue, 27 Jan 2026 04:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXj-0000g4-Na
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXg-0008U6-Lu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=Jvnz9LiG2iP1CmvIna3A99IR7wZvzcuIbdojEcslXImSx9NXRXS05hawO4lAK1PHT6tRhV
 my/FvEmy6G7m6QA3cr1i2C32cv7yyxhKZspBztQhs94/bju5GOgtbhaDwmhtrEnxDVI1ed
 6rkfgz21yNmh3hJS4zGAQyLy4oCLiMA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-2wZ6bHpqMMWcvJmnCaGrBg-1; Tue, 27 Jan 2026 04:39:21 -0500
X-MC-Unique: 2wZ6bHpqMMWcvJmnCaGrBg-1
X-Mimecast-MFC-AGG-ID: 2wZ6bHpqMMWcvJmnCaGrBg_1769506760
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43065ad16a8so3247612f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506760; x=1770111560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=pLvS0oWfKm+DqYuQkTQ5miqebbiItjvw9fMftNj5TUixdT+CiPXDS6AB8KktHwWpfb
 qzZu0rSUtgNMNPyWrb5L1UN6l605ghvyAs2eR3+JUj5LEz7X/S0u8iO1Zgoc7Tsk/VpL
 hNWbhxNHtLlGaiuwepEpAeFiru4SlXUhJ4QXJtvTnVAVsmaNVK5Zz6M4LnNDORrkPdyS
 sVumHV9F51dNRJ1Oc6S3P5sX0aQuAhBYwsDAm3gYd6jTAEsP4kbLa7r8ytVjGHhVHdfX
 y07p98dm6egosK00YuDa84+Yb5uU680wB6aYmqkBnFHa4RGRBkQlyJMt18sNirO+8Ndo
 3juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506760; x=1770111560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G12U7HD1qt2fPICoBOKA56jEyJjkaqdG/Ug1Zr9+Wvc=;
 b=dhaIoiyvtbf1KIq0xjFCMRcwFSBSPkCqH/9FDMAxpUh+nWnXk0P4OarHJGk50Qnsxl
 3TjIaOQLHP8g1MYWYQAWnl72Rj9ws8w2quwcvBw2vw7N5lEvKzkGC7a1H3Yy9hTPCH57
 J0De7ZOuVbaxBRs11c2yM1qL25+KxqnCssXg1VfW8K0m6//2zPpFYR7sUrha2IyXmRDo
 5zOPILx129ejt1g/1mwAlzYF84TT425/Uizqr7JuVYnwOYsGnIuBFRHT884Bt66k7d6u
 buizqxYDeX3Tdl6t6Ov0Iq8QgASf+VuTpxoizSFxJAK2Sq9OLPt3z6mPRYkNefqitUdr
 FELA==
X-Gm-Message-State: AOJu0YxaFcASvQUOac0zKWWV0Faewy4XsXbhuiWcGz+FAoT5dhdpcnLi
 9IDCCys+fkQ8S6z3QOqPeOSnECrc9w8F5kJks5QoPBayCOHpWh3zS2JObqBn5RqtaHheSHMGTAB
 ZYOgxa456nQskPB4KuJ/VqelS8orL+poXng+28NRpDwFAO32j6RCG8rlAK/M6DGIvl6r8n/ZenV
 Qv3aCtYDkgw6GtXW67v9x/qipdP3FjqIuAaolG9ERk
X-Gm-Gg: AZuq6aIc3uat0fb5yKpniLIvYA/Gc5nbenD3iMlJM1nbQFiu4fDrrQxjY0HDpP+gNQ2
 +b4Pe8w+xVGxX2BnoJ+93o41WjactU0Zym62i0PS25FbE+RcxJhuMJuhxLb8mNgm4YeKSnhjnV/
 LcsUDgS4c8pOv/Jvt9SyEOpTmrrgbJ+L9qyAjEJyCRBCRrakGuqMDCeaf8jlkzOrfYDoZY5xA0X
 13T/AQ2I5BWkhO6FphVQnqbjuqxs/r9E6Y/B7ve/SDRsAwL5BKckYYiMC8V3A8pCfczIdNxvH3C
 YTv6K0QIEWCnF1a5r03i8OtKGY52AhR2HLkzS80GK8I8h47SKReXPJHqLsPs7YFYKY8hDMrfu/d
 AljSTUxwDk/iV+AcJ1y/GSoJOfowWN1+V/4nsGBc3QSV15EhZqJ0FP5cDIEvca6QJS5cYp/T5o8
 xF4tcq1IRjC3SoGg==
X-Received: by 2002:a05:6000:4282:b0:431:752:672b with SMTP id
 ffacd0b85a97d-435dd05a81amr1414322f8f.14.1769506759598; 
 Tue, 27 Jan 2026 01:39:19 -0800 (PST)
X-Received: by 2002:a05:6000:4282:b0:431:752:672b with SMTP id
 ffacd0b85a97d-435dd05a81amr1414264f8f.14.1769506758982; 
 Tue, 27 Jan 2026 01:39:18 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c246ecsm37784916f8f.10.2026.01.27.01.39.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] qdev: add hw/core/gpio.c to libhwcore
Date: Tue, 27 Jan 2026 10:38:59 +0100
Message-ID: <20260127093906.353741-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

While GPIO functionality is not used by user-mode emulation, it is
conceptually part of qdev - GPIO pins are included in DeviceState
independent of whether this is system or user-mode emulation.

For the Rust bindings, having GPIO functionality in system_ss causes
a problem because, for simplicity, all methods of DeviceState are
included in the Rust hwcore crate.  On Windows, rustc is not able
to do dead code elimination as well as on other OSes and this causes
an undefined symbol error, because gpio.c is not linked into the
rust/hw/core/rust-hwcore-rs-integration test binary.

To fix it, move gpio.c out of system_ss and into libhwcore.
Alternatively, it would be possible to define some DeviceState
methods also in the system crate, using for example a separate trace
SystemDeviceMethods.  For now, keep all the methods in one crate and
link 200 unused lines of code into user-mode emulators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0edd..8a96567de8f 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -1,6 +1,7 @@
 # core qdev-related obj files, also used by *-user and unit tests
 hwcore_ss.add(files(
   'bus.c',
+  'gpio.c',
   'qdev-properties.c',
   'qdev.c',
   'resetcontainer.c',
@@ -29,7 +30,6 @@ system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutl
 system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
-  'gpio.c',
   'hotplug.c',
   'loader.c',
   'machine-hmp-cmds.c',
-- 
2.52.0



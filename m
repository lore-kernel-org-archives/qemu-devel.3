Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806B105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drQ-00042m-GM; Thu, 12 Mar 2026 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0drE-0003sP-AH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0drB-0001UA-Am
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=Fs/XaC5z4/XjLydt8qRRi1BPGX4weGB5QE16dqsr1y++tuZt9QPhTGufJPpMNnbZ7OfS6J
 EYV323VTxPcvxBmPngqOY1EiZE+u6r6A6OaPCmidtz9ZaQ9nGEOLVWL77oZiNqTWLqQap0
 hzIzUtBGh9Uts0FQ2GIWRcmr0lvg9/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yX6nyhS7OEuQl-2NKePXpg-1; Thu, 12 Mar 2026 07:05:31 -0400
X-MC-Unique: yX6nyhS7OEuQl-2NKePXpg-1
X-Mimecast-MFC-AGG-ID: yX6nyhS7OEuQl-2NKePXpg_1773313530
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48531e6012bso8014095e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313529; x=1773918329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=JBbCtfXeSdIrmy0QCRI/3j6umTlWx0mcySSySWG23ElVns3zrZI2Ap5k9e/glftTvZ
 lqTMmfnuCH2UgB1ua02oVCkKrK9ULJrddKnX3FbaURpkqKOK2P2zuy8Ks0hrE4qTz6QM
 wG9rzBh9zDVFGarLxOjqxPHApXA2XYoP4ssPnMStgWAcMHaRbrMMkoGqYVA+Nk2ESlxk
 kT2WlUErY7wBjsGq0HVr1U1K/bUS1LrD/btf96NiF+nEgryDtOZFUO+E6wjpSqsIG/da
 Tn5wFmV0p89HR1xiYhersC9Zm2VNXmz8Eni2f4B8kgJxR8NHtNVuNws1hmf6cMvHwTh5
 CqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313529; x=1773918329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=aTECEnGw4K1KJM15sdGBzPrkRhiX5ap5sQ752Ax/Ih0dHVm9s1PIuBBcKTQhNReVe+
 dbostyXlAbwDbyGniADrdQBjgLbzPIW1reLy0RIB4y7m7jLMwGOaLux5ARPYkg7MLpve
 wdEc/fGtNBJsYNTFRJkInbdvVJ553y/rO4lo0nfeOuS4/0ef1m++nYzkqDYp8juOJfx+
 Em22rK+coiOO2a0VEERaNgd3FxQ9zk9Di2gLZM8ZCg7DofTU8XXFeLWlh/2Wr/mlZHn6
 M/VyoYQnb3ckMi0dO81v3F14PRm1YMr6hH1W152SvYKBioUV2Qgot1MBRvcBnA4VTDnU
 cDXQ==
X-Gm-Message-State: AOJu0Yzt+pWOGSsIppTICGtCAKL1DR+mKp1fr7hCbpywMWJalLksyq73
 F+02ivjGbuzbJ6tZw+1hLXc0wwyKk/d4gUhtyZ0Xy5MtekAKfSW1pcnkxegCIaInHT4bV3B4xj1
 S5vINh36ecxjb0rYtg52QBFiqzj1MkOnAEG2SHVmS+MdVkpqQoubC5NWZgLRqCGGgI4MqZ0ZDNB
 TQWQ8JlbEGcG/w7tGOEioXCO4N5yTpQcDdPCptBQfI
X-Gm-Gg: ATEYQzwuMEQsAR5RYUtyPMdmeV6qqxDP0ZuP6jGxZvzgMS6ouJzzF4J5aYG/OOKH5uo
 7jDwSxqHnkAz+bHPsjWFaRLg8EFaR/RFBMNDOlcmgMyc3BbL2E41ES7WVlTni9Ug0klm+d5C9cH
 TGdv4JRL8/tlc3hcwY13a48KquvQIUcSRqGFqcyjhgSMcomBIC3rqI69BauCAD7mHtNeI8LOj/n
 f5avBgnC5D9aXTrkBDDY3bUze97o1jKBxwoXRQP7p54ZYh6m+bWIbMbfwlUtUJUcKVCI+yWAZJt
 Sfs4plfufN13dLg1Zfkx7yalGeAq0F5UnSLeTiHub3NaDrgR7BzhECHYA6sQ+4sF6b+7zHq0Fcv
 d7WmOuUKxL08/8rHLSyKOPOANl9T1f+SJ+TQg8y8ooBnFewVo9qaBHknK9hvDE0I8sqpdg5f55z
 suvFn4QCy6ILtRDYrRR3t7sLaKiVM=
X-Received: by 2002:a05:600c:8a0a:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-48554cd6ee9mr7751885e9.18.1773313529087; 
 Thu, 12 Mar 2026 04:05:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8a0a:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-48554cd6ee9mr7751475e9.18.1773313528591; 
 Thu, 12 Mar 2026 04:05:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22529csm6751399f8f.31.2026.03.12.04.05.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] typedefs: move QIgvm out of typedefs.h
Date: Thu, 12 Mar 2026 12:04:46 +0100
Message-ID: <20260312110451.685161-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Typedefs.h should only be used for really core types; QIgvm is
just an opaque struct that is defined in system/igvm-internal.h,
and the typedef itself can be placed simply in system/igvm.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 include/system/igvm.h   | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index cbe6f7f4c7c..416a8c9acea 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,7 +102,6 @@ typedef struct QEMUSGList QEMUSGList;
 typedef struct QemuSpin QemuSpin;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
-typedef struct QIgvm QIgvm;
 typedef struct QList QList;
 typedef struct QNull QNull;
 typedef struct QNum QNum;
diff --git a/include/system/igvm.h b/include/system/igvm.h
index f9231f03ec8..64d3542311a 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -13,10 +13,11 @@
 #define BACKENDS_IGVM_H
 
 #include "hw/core/boards.h"
-#include "qemu/typedefs.h"
 #include "system/confidential-guest-support.h"
 #include "qapi/error.h"
 
+typedef struct QIgvm QIgvm;
+
 int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
                        bool onlyVpContext, Error **errp);
 
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEEF1125853
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MIq-0000S5-Np; Wed, 11 Mar 2026 12:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MIo-0000Re-Fo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MIm-0001nP-7a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773246050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=G9JNC5dR8RVfvYmV8cSVRlqfPSjfUsJEm4OeDU+Ww8XeTw8GMoPmEPFHPr664/QPmeO585
 arc2/tFvHKtAy8EkeuPuQKPAb/E+nGekcPPO5Ff5Rf60XImBHWqgelNI4Gy0YsyMdtU2cF
 KO0r2OoIjTE8vXkpJ6xtgdTqtJXPFBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-9EPJRxkdPqqnawfPbhkjxg-1; Wed, 11 Mar 2026 12:20:49 -0400
X-MC-Unique: 9EPJRxkdPqqnawfPbhkjxg-1
X-Mimecast-MFC-AGG-ID: 9EPJRxkdPqqnawfPbhkjxg_1773246048
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso277275e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773246047; x=1773850847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=iQwWkPjGlcIwMgU5qk3XMVEe2izovqOtlMSE6Df7aTS2njNpmJ4PmW9ebXMlT4VduH
 Q0Yf8T4bAwLB1QrELrslbAFEVDnvIq7omQ81F8ZNHnEf5pvNLucMRiASlynYTwD9jXta
 i3U7wqJCsqNW43f6ye5JSPvR22C98RY848q+viTfxEmuj5gawt7wpvWhK6xDaSUgqmx9
 BkF/UY6nnn1dMsn0uYODHwt/X1x+8WNZDD/GqzfPC/OGj4TxaYVFIXCd/ZiddPgjviLo
 mf8yEtrr/jgWp6IR+egUpcouh5xkkl2wu8rTSh3vlBFtjEfOAE6ZpvN/OUtwRjq6R6Ct
 fF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246047; x=1773850847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=374Io3DYiNHLZOHU5ncwznFRWC8fHrRSFuMxbTrdgY8=;
 b=lWLZIWfcB1qKneeUG535xY6a5vvEYvZEexrSfnT4KS6x0y87MPXoRDwBPVJEy3pPEI
 yuX90zjPGoAsPwbYYyQbr+0JsbXR8BMmFTqAPUWjlgjjzNQ8iD2I0cXbf2UoOb1SIFhz
 kriTT7YMEUtUy2Cvz0UA4yGQW2nR0gXx3hDMUrXA9zRsZ88NxPpNEXhxc9EyI4gRVFiP
 +zqdlf9cfQ5Cut/VCEkIEz4EJRVNfRvjz/T5VR7eTU5YhCglQIBZhuU70nga/hebGVRL
 RlBRf/Hqqu/FTOk//2HcALs1ORi8BZJe4mrHRvB4dt7wWGOKWPw3AiW3LkSbKMp6zMZv
 fM2A==
X-Gm-Message-State: AOJu0Yzlcp+0bNJET792fABFIC7kCnpAKtsl6eIjRNjWgvEh8r5Cvr4l
 r1/ZIYMeHolk/fgIQeV1hAVptt2Py9WQ2sHbGCP94xdBqDjFAuDHZpwAlZkIGb4elGm/F5pxkaF
 pdC9LzbGzHXth5PSpJigssdGzd8n6DoRIugz+80gb3Bijuw9sTZf2lCZXtcFPSv+FZBPX6onjYX
 eWz3ewXFCC59R7CX8h0rYvqn4jO/BiA1bolH9wb74v
X-Gm-Gg: ATEYQzx5H2IX8sXDe8+2P9L7otl7SOpmSCeiS6XkY+0hatRLKhfOQWRx1a11rdrzVNz
 yYNLfSEYN2ngCHGGQu6pcgeiIwNVOnTK8oaUIxirT5m//Rk04Pxk0J6ioByaU3oWtvE3f+9SN7A
 F+3/Eojwwda75P0Uuq3RPsODoKtrBrfSh2n0V25cmlSDvNxU4z1bmsxIkd9lqaWo0RMGShqIXDf
 9s1WsSDXmzdAgnWdx5j6VK1eRJ1br3Kyw0AUn8jKHx8QAjwz6CpO6t16nskkgx6YkDBnqXNqibK
 zdJDK+pZIesPVNTV4x5/sJXQ0G1Yd3pQuBC2hEl/DcVc7KeUYHau8B/z3+jlkHUh3aDwJCElFHW
 2DCGcmxyzXQqNGY461/C5k0XzavWw2Qhxsj3Ou5cbU1JLY84Sw6Se/eXfJfLqLt28EIYAYGQDiy
 Ftwl1L5GvEujs9qr2nuPaG/gX74ac=
X-Received: by 2002:a05:600c:608c:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-4854b136ae3mr53823315e9.31.1773246047488; 
 Wed, 11 Mar 2026 09:20:47 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-4854b136ae3mr53822785e9.31.1773246047043; 
 Wed, 11 Mar 2026 09:20:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0d4de8sm36451295e9.4.2026.03.11.09.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:20:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: leonardi@redhat.com
Subject: [PATCH] typedefs: move QIgvm out of typedefs.h
Date: Wed, 11 Mar 2026 17:20:45 +0100
Message-ID: <20260311162045.563301-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BA8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNH4-0008It-7R; Sat, 30 Aug 2025 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryia-0001D8-8Z
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiW-0008Qs-Tu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+cbH5iTmjbmQ/4x7HUYbfFMJ1Aj9FerH5LaCs/lrD8=;
 b=CPlJoYm6Izz3Cew5wCAi6xGpbZ653dU2Y/n4MJCzX0D86ZsscMwJ6R7uXIHXAPUnn0oku+
 3/m8UPAop+9nw8Lbx9sQrue0fDRp884u2yy7qkbbNRmy5kws2bd6a2Mf5LI4lccYvYBmpf
 2U4uG8IPdb3PpBJcNSlxPC8jhfyXAo0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-UuvIeI3oM2S2_chWFnYtzA-1; Fri, 29 Aug 2025 09:00:29 -0400
X-MC-Unique: UuvIeI3oM2S2_chWFnYtzA-1
X-Mimecast-MFC-AGG-ID: UuvIeI3oM2S2_chWFnYtzA_1756472428
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3cef6debe96so667266f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472427; x=1757077227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+cbH5iTmjbmQ/4x7HUYbfFMJ1Aj9FerH5LaCs/lrD8=;
 b=qovs0LwwGEuGs1zR/4/nEJJnWCCrs0quPQanYH6ymfwOOD7jR5uSmGrXBz6/kNg8o1
 vOCMYMGrAdodx9RYtItrN/bV93kMhnjUQerwg4wruljyBa+mAN0lp7riVt9IaxIYvMbj
 TSYD1j7vLFUiV2/mUJSY2wqqN6lDHdla0my8tV73JHJwxtGZFhuq2OhljzC2WCCdMzjD
 KzQBrhbM23dHQT7tXNsi0lLAyxxuSnwSpkB37FpPihzOH2SNC2g0q4EZJH10oOTsVMy5
 PFR1lpYxOgzlq6uz4VfOSDn5k+q8SePyzxjSSyXvxEXm0FZJC/XGYjZXDmk1xGWsYVcw
 oazw==
X-Gm-Message-State: AOJu0YyJEw1aJadWPV7YkRxl5zXyHesOHjC15/XvbE+Xn5BK1eBbjx5P
 HcXnX6PU+CJ0RHZWYC3kabbQpZLWKzkTzLt27HFBHA3AwUV9/QZxejWQP+sj5YsidHtgU+Hw96J
 wA7KVaytdbJOzi4A/dPcG+j+18BCLYhgOFZ4+p3uHEQoz4iRu7vyh4Gb55Ge2N1fCAjaffNltRo
 VRPYNr+Iq47ALDtPzcE2RYU7p83pqrWKo6RD1y1ski
X-Gm-Gg: ASbGncuEN3+PppbS3H3sJNRQwXdd6i/mTlC7mjv0T/RjNyKZjZHmtMODQhyjtsuyYLf
 9r2dPy41KA2WS+FwjsJHnyzZnAjMJXx2S2YIpt/+lnMpFlttwuP65Tzu4h/qbPrj4HZxOY1Y7uz
 8nnd23T3yVpdNbL5UGLOO8sQiJK/vYyfQJkqr/ZPGizTsV2f6fKI+qQWb+7RyD9Ib/BBEboTO1Q
 Ctlluo8SJAjiD9b302cPLa8aROZDe5ghlQPhzYjUXL14iDkwsacoKtxK3ihsGatz7Ox9S1Cglpc
 2OKKBfQTGr96rFd0C+tkkqJnZtsrigK55uag59rrytsfLEdiAzBG95Sj4ofwujTSyYbJz8q0RDH
 Z8y+dn82CEMnfpB58zfDQ5KVRAJZLmLlz2FOaCb81bNk=
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id
 ffacd0b85a97d-3c5db8ab097mr23132364f8f.5.1756472427473; 
 Fri, 29 Aug 2025 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC39AnFlnFJOKwO17DxgdkrjB0FOZ/9F09oMhmKY3ZqiVwR6hWBRgd8SWEDOQ0wTR/2vPcrw==
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id
 ffacd0b85a97d-3c5db8ab097mr23132322f8f.5.1756472426936; 
 Fri, 29 Aug 2025 06:00:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33adf170sm3561616f8f.33.2025.08.29.06.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 17/28] hw/i386/pc_piix.c: remove unused headers after isapc
 machine split
Date: Fri, 29 Aug 2025 14:59:24 +0200
Message-ID: <20250829125935.1526984-18-pbonzini@redhat.com>
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

The headers for isapc-only devices can be removed from pc_piix.c since they are
no longer used by the i440fx-pc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-18-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 988c9edc32c..627de09c704 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,19 +27,16 @@
 
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/dma/i8257.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "system/kvm.h"
-- 
2.51.0



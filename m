Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4BAFCA161
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeeD-0002i8-00; Mon, 09 Mar 2026 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee9-0002gV-Ml
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee8-00026r-3j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=Ua0VQwxgOYPyIsO3ZiczdynNCtT4DWDMQd9nP1AoLMBzTDzZt7LePu4mGfY/t61tljO14o
 27HSMP6V5RoLl+b7f+BtFzoIONYlDkGv8zhZlsvfm0gSExF2ptgSf9b70QwrWGO4oyfOWm
 gWEc6rufoGN72a4d0CU6flhKxNl7DZE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-5L57NUo3Ob2fkCQwkbaCyA-1; Mon, 09 Mar 2026 13:43:58 -0400
X-MC-Unique: 5L57NUo3Ob2fkCQwkbaCyA-1
X-Mimecast-MFC-AGG-ID: 5L57NUo3Ob2fkCQwkbaCyA_1773078237
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b3011be7so5704397f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078236; x=1773683036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=IKy4LUdkbgwUEqYrldqJG/7Iz0zYWbQb/3Rv6uv6cW6iw+L3Q+QnvwTgLUGBBTWAyb
 HisSueaEgXFCbI66HBMstXroU/w5F/lP//ooagiKcxDLpsp/fCLhx3CWSxA/9Vxdqyco
 0i5zqI8kQ9S87olIjLIQmBrYBwdweXlAo7QHAGDQqkHoS6/m3MMa3BSc8+kxqR856RXi
 XzGQNnqqr9k4ZtuDOM/OiIx1c3vBR9p6wiPMNn9ZHhYwCTGc7D0YSjniZYgiaxJLV7t6
 qw2czFnVCMnAm0PSn/+tg9GnbOeARMxQXOqXorO9fhnhIVOajYwtjrX/MEKcE+5asgNQ
 Z2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078236; x=1773683036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=aQRczK5JiB3Tj7Z6YdOgj5PRJ4lB7ZeVSCvdeHi5sPRUO9zGgJ/xhxuI1tVYXosagp
 pjWObSKNnUoirv/zvYmJnxtSCGItibpthoTxed7XTsvVKVIljeRRgxj8zbUbvnTVbCSN
 BYnPg+eLkrcn1xbWx/tSF3HMo31OsYgMN+V8AQD3AP6xHF0rwnBv/U6VUWbFmuLCiHvr
 Hm96hkTR1pCam3UeBzKPbWxOKutyfw/eGJlhOIOpripeiRjTLq9RBudQc2YJcOOwuHFb
 twYY4+ChhKUds69ehSlNSBOxcOnkW+i/uDynsyO5hq3lWQIItWvvLJmRBrLm4lnBoXb0
 wZ0g==
X-Gm-Message-State: AOJu0YxzELmyxo+vAY7ZyJ7SKITnn1cO1gbOmbMTwrCh/ZcRWaX/iAVW
 LKMJtNzFXWs8jK4YCC2f3See81yd4OCxf2jBLbyKunHZCs+glhNd3ZInW4zQU8kRXb4CSdFHRxR
 o4MPpCUiAXLnF7eFE3W/w668tgjBl5ErDhwitkf9poMdvBZNaU6HQDyCX1Cep6dyXTaI/Lv6q1b
 HWpMFK/0tz71fRiGvkFwfx5itINWGJhR+WL3GNA1kv
X-Gm-Gg: ATEYQzwnDjlVOeupYAmcRX7h/WrVBxV/AC8+2e2jqgHt0ucULvgqbrUjAjATYBWcgIQ
 weeB72XyP59QUVrAIanijLHifd3F1CjeOpL1Hi3nWIOdA/dHWyr2+gdesCQr7a7F1+7qC3Z9dAL
 SyPnMSY/Cs747ADTCUrB/3/7sMsnKfda9DsMmehlyel0fdeLDSHC7UNvtJLB9ZKSnGGqPd/bPMn
 5AoFySucAugcETWnwh58pnL4LSxU1wP/d6P1I8Al3ykgXhsDKupVPDT2Aw0wilHBVTdJ7k/eusD
 flJfe1JqNjsyXpTzP/dNRzeggufLhuqyHE96RQYWmFqMxv0T4DrCLb21VgnZrZjBCNYICaGMf4c
 h5wgntohq1C2bbZJkdR0m3cADEontTgw/YFCokdBARRVI0jlmBjf++sAA0ZQNByD+Mm5Okvdqq0
 ZtH+5SFVQ6UOJTWKIDU5JhaOaQVKU=
X-Received: by 2002:a05:6000:310e:b0:439:c010:a316 with SMTP id
 ffacd0b85a97d-439da35f6d8mr21636845f8f.30.1773078236101; 
 Mon, 09 Mar 2026 10:43:56 -0700 (PDT)
X-Received: by 2002:a05:6000:310e:b0:439:c010:a316 with SMTP id
 ffacd0b85a97d-439da35f6d8mr21636800f8f.30.1773078235587; 
 Mon, 09 Mar 2026 10:43:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9fbsm28928894f8f.23.2026.03.09.10.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 07/10] whpx: i386: enable some more enlightenments
Date: Mon,  9 Mar 2026 18:43:37 +0100
Message-ID: <20260309174340.52174-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9c60295d553..bc82995b33e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2214,9 +2214,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.53.0



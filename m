Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF0CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7a-0006BR-CG; Thu, 30 Apr 2026 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6t-0005HB-9j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6r-0004Z5-6X
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TVppSkjsNhYMHQxAmEzqCx8qVYljwJJfpsf/snmUs=;
 b=DsKmNyg4wrUOQMIz0v8C690cekb700MHBXCrwYXrPX7gzbZ+PI265N0WrRtm8w6h8SY4jY
 I1TkqvaaPn1QCQ9UzrbwqNLVAoCUQBqPnM49whviNFUgsSyBApvx/0jgZaaOGQujMs6gRE
 xaI7wq7ltJkceTvayhKfPiJge90+pLM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-lLPhSDCkPWKFhFHGvuit4w-1; Thu, 30 Apr 2026 13:23:31 -0400
X-MC-Unique: lLPhSDCkPWKFhFHGvuit4w-1
X-Mimecast-MFC-AGG-ID: lLPhSDCkPWKFhFHGvuit4w_1777569810
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-611af0d600bso783493137.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569810; x=1778174610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9TVppSkjsNhYMHQxAmEzqCx8qVYljwJJfpsf/snmUs=;
 b=XFdY4mDuT0tA4JAyb9k5di+N4yIueAWM++d4juuTaef82mtoj1f3yjkAULdv2Z6Uzu
 0ucN1Jlpc4YC5bpBJmdK8IWjlR2C925tuahccaF1vRRLttNWi2OEXnVYpPNva6NrxV+j
 iEyvnQF+OM4JAV3bsAkKPopE1EOKsVgSxa/q1slVan6yedJ4P0NVj2EA3N5n/UXN0vks
 yjr7wOiHnBmmi6uZvoVwMtlnhCKwneb1Z2Jsb79FLcyD8U8EtEcbU3cCRWTpM2FLgAAw
 h/tlBuh2uhTvqbAXo0QNfg8YjqHDC8JibTUKW+kLrjKOqhYUlBeNvz0oswveZvTN8aJH
 v7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569810; x=1778174610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9TVppSkjsNhYMHQxAmEzqCx8qVYljwJJfpsf/snmUs=;
 b=NOiMHBgjw0c6Cn+hJupz0r4MsL6tasDji6DP5mSzccap4F23Wn1WH5XmymTndyBSR6
 ZrRhf05O1NtfGCfeJaTzswo5mugxz/GcbtdWMNjPRFSNSivaHtrydQlUjeHZtq4vPpkd
 DguCSWGWUDDRHgOV/NDxanYIqz4NhhwwWEDmLruz6tDI+BueeGxH8VH/0QfBtc9S9HFa
 DtK/+0bm4WPcTIl+KIGdVjxasg16xO+oiWqqtwm3fbVAv2deQHETdCNcG+EuUkc6MrFs
 HIakkfchy6qgoL4bc9HucdyWnOoGR82ynoKrzZYkll3lS4GFnsDwWL8oMeZC+E8x93up
 4big==
X-Gm-Message-State: AOJu0YwCLPsUmYqWwNOszhu1UlZCYm9pOnFJQXuBlWYe/NcgJKrqS8mn
 NnF9B6h0spvvun36Fr7cfpnQIKMSgR/QdURd7iDrhn/7RfIXxizcePjbMyNf30OekboHTOK9wLt
 Yum0EQReoidZa9kDtD/3wULPdWA03jU0YlX/eotbdhoQgjlhpaaGd5/82n6TJYRxcJ7DYqxwTyL
 TmIXvEsNjdrwuS/MSGEONt8W7p0HloQHsTMfC+mTOk
X-Gm-Gg: AeBDievfROhOQT9OTNQIBjNCuP1YIl65svt+qj+HvHp3OqE+P6qojg833A3UXL+fBWH
 J5SwBwhsqQEwXKwki2lZTMSxWiqW7b3Ixz5Z8jBWscEEEJj1W/pSC+gCnhJWP2heErJ93+IgtnY
 lbfMeVSLhv55VmMAl2jtkKBiKBG/Sf8H5Hn4Qs7/MCboVh/N5qCRgio4xroUwmg/m4MvPrCxHfZ
 9Qn/KcvyV1ODzrnye/hW85vrWHv1trfLnar+BDI1LgP4Hp554V+v8oN68Cn424Mf4+0mKfeovec
 8xpKYBJD7Ho+Xyy2x+QNdF548sng/+WGcxw9cQDKBAYEAVPrO0wdT68a5/o2DjytD6k9pDuNGMJ
 R2rO9SJg7E1p4Qv4qDOXYCJwOuOjWcSEAjpqQi6W6ER/zJG7f1qiD/o2FSvebkMbyJIM9AoRFb3
 5rhu4UvKs/BTsvlTb8ewsetLc695+bri8zFy0=
X-Received: by 2002:a05:6102:cd4:b0:611:c935:f9c5 with SMTP id
 ada2fe7eead31-62ad4261073mr1993015137.24.1777569809867; 
 Thu, 30 Apr 2026 10:23:29 -0700 (PDT)
X-Received: by 2002:a05:6102:cd4:b0:611:c935:f9c5 with SMTP id
 ada2fe7eead31-62ad4261073mr1992956137.24.1777569809235; 
 Thu, 30 Apr 2026 10:23:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43b912sm24880946d6.26.2026.04.30.10.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 26/58] whpx: i386: disable TbFlushHypercalls for emulated LAPIC
Date: Thu, 30 Apr 2026 19:21:32 +0200
Message-ID: <20260430172204.1006673-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

AccessHypercallRegs was present twice so clean that up.

Remove TbFlushHypercalls (and its extended Gva range sub-feature)
from the user-mode LAPIC case as it behaves oddly there.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d211b3f2efa..8f03616cb97 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2577,10 +2577,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
-    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
-    synthetic_features.Bank0.TbFlushHypercalls = 1;
 
     if (whpx_irqchip_in_kernel()) {
         synthetic_features.Bank0.AccessSynicRegs = 1;
@@ -2588,6 +2585,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        /*
+         * These technically work without the Hyper-V LAPIC
+         * but behave oddly for multi-core VMs.
+         */
+        synthetic_features.Bank0.TbFlushHypercalls = 1;
+        synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.54.0



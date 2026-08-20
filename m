Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A3C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zX-0007tg-LK; Thu, 20 Aug 2026 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zU-0007Wi-R2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zT-0005iC-0J
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRmNfr+tTC2oSlLCEoCwUUUkAa8qH6TzJ+zFQ3zw/Ug=;
 b=hIGrjnhnMggjoCWJz8d0pBsi/hY66hB3wN0KxywA9zkfxzbi6qVGx7Dj84oMjSXM0pACsp
 oeW0/BuCzZzQOF4SFzvBvc81LOCjL0LuywYU0ywaLhas9gGA3dHddh88gYnPp8gGmdjFh/
 J3YXQw/K6RerYEhcmRPpd/EbJpNezE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-HaYghHiVPrqAPvpLwXTD6w-1; Thu, 20 Aug 2026 12:51:41 -0400
X-MC-Unique: HaYghHiVPrqAPvpLwXTD6w-1
X-Mimecast-MFC-AGG-ID: HaYghHiVPrqAPvpLwXTD6w_1787244699
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso61362f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244699; x=1787849499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRmNfr+tTC2oSlLCEoCwUUUkAa8qH6TzJ+zFQ3zw/Ug=;
 b=CKh46tJluC8jtEYX41HvkK5Tg/+T2CZD/mWQ5/jl+i8AaSyUBq9Vtw+n7O4LLwtZTm
 qNguT+RG6mN/KdmyCk35ChU4Vk9XIfJYSUY/f4EMmuHJtRBQ/41T1IH01w1B0Tkjhxjc
 oMTauz91SoShRgTpqCsa/sMENCMNj4i/oTTmPtXjRZtQaAYi1yL/bpNs8PUPjcUBDffV
 rs809DCaXUAd9nbHObmWsKgoUZykmeLAbKH8ZaThgZJKgQzfPO5brcHO/OLzOJTYd77N
 Omq6tX7oIRPUwoIAiKVDrJqsZT7qSL9gxGoV0EAIdFjBla2zXWnkrheMHEbij67paQRH
 +8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244699; x=1787849499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kRmNfr+tTC2oSlLCEoCwUUUkAa8qH6TzJ+zFQ3zw/Ug=;
 b=DjY7F4o9GK0s/tq+lMmGXBhFTGjegAqSvrBn4s2Bs6dfgtlE2mHKRdN1+jswZj16tE
 0xMpY5Nxe+izAzLnjamFl6yY7SG+Xa8C5qdcyex7ywpaNPxsGLHKBhhBn40kDOZY7gsX
 DcreFE2zu5VYMh9H8TgPxBmj2xh8Bhftd6VS/rGyua4c3T8mUiuTCMoF9p5GAmKvN69i
 YLdzIWJwUOYs/40VoNFjK7m2f3bAU5yh3FL5eforGi7zX9FvnxKxXj67/6Z6MO+hLPkN
 JAQy9k7Gs9l89Fxk7Ps0L6Qsa8fBz5/gzWDfL5zMQXGhKUxPVO0LxN83g39LYiG2NfIo
 rolw==
X-Gm-Message-State: AFuF++mMWtCE/U5CnY7aQQyacKIb2T4silDyetsLZn0Wsg4+PuznX4rQ
 1fp6YtYj9Sav/UTduefi5+jO6hmT+127g8u6b6Bm1ZfSENzO8//AxQb1m2eQPRkXGq7NQWBJX7i
 HLCMHY8kRW9AAyywzAK0/IaJifA+EmOBqYjd4dMb3JUpcuO/Dbm0HHPn98D9gV6Q8tpbPniwQJ/
 4g97rf7VWck8vYXSrtl1Ya8DxmNeEo49qfZlfJEVfj
X-Gm-Gg: AR+sD125JbnpO2glfs8GKp6/vz5uos4UGy9g7StkuEGpguxxy+f41CiEf7ncj/P4jg/
 3GBwtJP2BlbYUJvFD0NXDpvFTupVgYYaEjZZlhmohr3v0mNPRrZ7aMxwl8XMGy61tSYLtS8i4Ll
 QM/TEQja/t5epSVWwTBGv/SqvZoCUChrZDjrOUnUCa8ZmromzDZ5XpUEo5yOVLOYtt98PlmVwLM
 R7PrRhLIwxrmJLxMiFcm1/+9YghcyvQa+1Hs/oMC7bEWCPmgL8/zsNuHM39LXztahtT4fBVyIcg
 82sE3IPtKa/h0Y3h1OwBLxQ5Fx6hKkOZ2LdN2WEyUSbXIHZJJh23x582y+562LtuNx5F3/Gi4k1
 DSGMjBfNRndMf66y6q9W1TIgXr9cSvU7Wb9fNy3fMPs05/zRaOcZYPA+3AnlezN2sYqDle8co16
 pOHro=
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-482c0b54855mr25932f8f.2.1787244698720; 
 Thu, 20 Aug 2026 09:51:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-482c0b54855mr25867f8f.2.1787244698296; 
 Thu, 20 Aug 2026 09:51:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d055dsm14262276f8f.34.2026.08.20.09.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 35/53] whpx: i386: work around Hyper-V FP state oddities
Date: Thu, 20 Aug 2026 18:49:38 +0200
Message-ID: <20260820164957.1895963-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Hyper-V looks like we need to fetch both the legacy
and new state instead of being able to rely on xsave.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2739a80da36..56a8b167497 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -614,9 +614,9 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
         if (whpx_is_xsave_enabled(cpu)) {
             whpx_set_xsave_state(cpu);
-        } else {
-            whpx_set_legacy_fp_registers(cpu, level);
         }
+        whpx_set_legacy_fp_registers(cpu, level);
+
         /* MSRs */
         assert(whpx_register_names[idx] == WHvX64RegisterEfer);
         vcxt.values[idx++].Reg64 = env->efer;
@@ -950,9 +950,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     if (whpx_is_xsave_enabled(cpu)) {
         whpx_get_xsave_state(cpu);
-    } else {
-        whpx_get_legacy_fp_registers(cpu, level);
     }
+    whpx_get_legacy_fp_registers(cpu, level);
 
     /* MSRs */
     assert(whpx_register_names[idx] == WHvX64RegisterEfer);
-- 
2.55.0



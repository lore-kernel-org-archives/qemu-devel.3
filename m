Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9310510F2872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Eh2-0002nA-Cv; Fri, 27 Mar 2026 17:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Eh0-0002ma-P2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Egz-0003Z5-A6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=cQlJ79XF4MqjS1D5uhNHAEFpZVhpbnlsm6JZI1ZgI24R+9TeCUYsX+Sunm7h/uNSrE3fvA
 SiJj9HQpQhAlt6yke4il92JfdrpN2qjKih0l1kfJW1kjieEupubRLS+e0poxdTwwik/gi0
 UVJgGuZa/xKQcOQfPTKQ5nxq3L1FXUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-gjcF7hhAP4e7VhACLEEk8A-1; Fri, 27 Mar 2026 17:26:03 -0400
X-MC-Unique: gjcF7hhAP4e7VhACLEEk8A-1
X-Mimecast-MFC-AGG-ID: gjcF7hhAP4e7VhACLEEk8A_1774646762
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso27542805e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646759; x=1775251559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=XyEIsS5X347kRqY+hkVNQ8uptXOrbKrIDmdK0QzNo0voteAoB/+kTDfMjKJnbqIfPI
 AmHy5DIgnW5eKF2fHDPSbLONXTgN6ADqSAFlsecutxLyJRiKTISjywJvk5UODZh59dMH
 nte/E1ie1wjM4ITovSRoQxK77vZopLUj8U0hi5S7ulp8VxPw1bakC6mUJ6tEvO47uU4L
 gWiD1YSiWncwa2tq4X3TJJSfXR7jjnQIYJC2wyyyWw0g/B6GVCE+L1haePVKeIKc1jcK
 B0JJkJJozX3JDi3glGSRpbCTgXnKP91c6qR6uRcInsEpqCscePm5OoigP0NUCYCZvF2m
 FXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646759; x=1775251559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=OoTprRt4KtinIwA9YJpT0KpSCM0vX5GQIni65nx65c2dpSztVSBNqedSfnXzZ5CPTy
 +KHewwnICegcoTK3xlQfSHF6R/UxgM6n5MeGpglu0Ve6O8JysIWl97Pu2fgpyqoo6iD0
 K04vRAUCmiZfSUy4iJ+viaC70A7DLvBD7KKEZfg+HiJ+5ABFfrQGpA3sISqmz/Wyb2d2
 /rUlO59Dn5um2FMHL4XjTSt5khQLR3TCgSuNKlS3gOrUSFyGs9z3N7UyATL3byDpERnD
 Mbts37C6LQtLJg/1CGRBQkREi7m/W703aqz6c+inwGfNisFo/tJNZoBjYnAlIkLGKF1I
 NvxQ==
X-Gm-Message-State: AOJu0Yyh6wU1fbluyPwvC9Ld41HNgt8kz/hH7jdWluYcHyekWf4oQiAz
 voarojzdIYDTURiZ2g6u9eMDt/cwSoc4xgqhQ6aOJ9D4BX4uNg6/uX9DgEuN3FJfwngtOWr4iBN
 lw7dv1ZwCqoy80SgMitke6O2T/HinhXGDEFWFHNld2U+sAVcwwfKajQsARnhxwFJmaNABF0jovX
 z17vjSyoFWdRmxU50PrLmrXpHuTBU8MEKfMub8fboc
X-Gm-Gg: ATEYQzxf3YhTYDOl0cMF6KW5i1vtO1n4k7m9v3seFlER4pPpkD4zlsaU3VXZ05QApaO
 tL2hkScEqddQN4XaE+IAuxifQ/lPyaf8tNXGEiO/E+F9QmNyaMf/t3YEG3Of8l3/4LEQwNnUGyY
 BuxPNrPFmRDo4rv2KQH+WlNYOtUt/m9InBj0pF823g5HMHLHnKHLCcUU/OFNB6BIbm7t0Sq5ovt
 fzQx2rxm2Ofc02w9O8qgbfoM4uW+7R5J9ilH1oI6hTZWuKpfu9823/FdnpoJaxa8R5yE+GGoIj8
 XD488EZn9HpiicrWh+WHzLOzuu7LGAHZJQuO1u64N7Av/j8+ZxRcWGUBE4BA2PQWJVwPSKQZRUv
 Rni+Al9SgKy7zKDLNUg+1RvKpNdgMZmaO9JCKH9rKUR2keF1gAewOLQluohFu7a02XGSmmxAFEL
 gTB5UxE94TEDHuFRv14htC48ra
X-Received: by 2002:a05:600c:1d15:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-48727ee9b10mr66677365e9.19.1774646759406; 
 Fri, 27 Mar 2026 14:25:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-48727ee9b10mr66677095e9.19.1774646758921; 
 Fri, 27 Mar 2026 14:25:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c957b9sm177875095e9.8.2026.03.27.14.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:25:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PATCH 01/16] lsi53c895a: keep a reference to the device while
 SCRIPTS execute
Date: Fri, 27 Mar 2026 22:25:32 +0100
Message-ID: <20260327212547.460420-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SCRIPTS execution can trigger PCI device unplug and consequently
a use-after-free after the unplug returns.  Avoid this by keeping
the device alive.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3090
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 6f43e500b3c..90643b26ab8 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1163,6 +1163,7 @@ static void lsi_execute_script(LSIState *s)
         s->waiting = LSI_NOWAIT;
     }
 
+    object_ref(s);
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1182,6 +1183,7 @@ again:
         s->waiting = LSI_WAIT_SCRIPTS;
         lsi_scripts_timer_start(s);
         reentrancy_level--;
+        object_unref(s);
         return;
     }
     insn = read_dword(s, s->dsp);
@@ -1630,6 +1632,7 @@ again:
     trace_lsi_execute_script_stop();
 
     reentrancy_level--;
+    object_unref(s);
 }
 
 static uint8_t lsi_reg_readb(LSIState *s, int offset)
-- 
2.53.0



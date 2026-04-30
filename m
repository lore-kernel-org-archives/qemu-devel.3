Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E82CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7i-0007GV-By; Thu, 30 Apr 2026 13:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7I-0005nA-IX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7G-0004kT-TB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+O7c0sQVJSOLKQosst2PQitoNQUt9dT5O6uF9z/efY=;
 b=OUTtoikPLpODORWHEiydXBv/qKIAvn3oHHVouWNrVMzPkrZSCQYcvAHMWednSTVfuThiCb
 OIMRiAugsQvfszuc9UuI02tGbCvD/Dl6IA3Nf34ymyJVfXufOfhJ9U+f9PAUPDgQnRCDcn
 SQg1t27LlLnjGIp6vnHLvTuOz3kkdQ8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WCuvdlI5MV6gkKwnZNSI4g-1; Thu, 30 Apr 2026 13:23:55 -0400
X-MC-Unique: WCuvdlI5MV6gkKwnZNSI4g-1
X-Mimecast-MFC-AGG-ID: WCuvdlI5MV6gkKwnZNSI4g_1777569834
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8ee9a11aa75so258386785a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569834; x=1778174634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+O7c0sQVJSOLKQosst2PQitoNQUt9dT5O6uF9z/efY=;
 b=DmC0Xd5ztVXC+r8rtrx1/2V0sz5ZGzbvgGZytjaE0v2dCLxudnZOeZYtkpDWHmI6zZ
 nObD4Nt2yk4jYAcRrbY/YLqBCPlZnFoulZ4ihFsWkjf+x+u3+PhR/pftObosKbDUv44F
 r3ne0V6mhTSYJhDgvkhiKI/6gIRRR4JmRviYG7uyxRV2DGBBImZGNsoUe9ZrlQXmuFBy
 On5raptv6WnVibt1VBM93g88xI8qDbcn05+TOARW1ombK9YoD8+GcTAA9/QW81V3h866
 CdP5GsO1VlSFPnNMb3gO+Jy5c1GbQNiE/tla3HudAXfzKvLOr7N7TJarnvcGfO+rMKbB
 +BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569834; x=1778174634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+O7c0sQVJSOLKQosst2PQitoNQUt9dT5O6uF9z/efY=;
 b=fASt6O5VEY20M+grAstfyvyIBbpLirgKCdYSc3Zwa31ww1aDrPWZz6xC6DhaeWWEQW
 WKT9v3+IdPwkVRWX9gBmrPR1xKyH7a565LEcwti7MglN9aHUly1bMZ7xt5W7wCFtUI3+
 st0nITKr2agogITQw+Hhspj27d7WAgl8IKju9Rgy9wwbdTFWpjxk+V94OWesl38xdJCW
 Pi5D1ppzKEc66WppvYIs2EgGZHrESVYePmdf52M1X5wtMLe7cONxmtrTarfn2m/+AySz
 9EWyBJsCph5cjYaVJiqDy0oqCz81jdb/GGRRKSVk2vsCVIu8iY8jhp/cFOZf0EUR9jNW
 sjGw==
X-Gm-Message-State: AOJu0Yy/yyaMDQx/IG7WD4EUq7Qj2QtxMcyHVwdFMwfPt/0y7XGo1tlm
 Ld8cG813nigwz8s7EpTjyQaTS0zhrAH7VKdI9zOMsuWnK05b5HglQcN1IQv1BRs0TYwfBA6m5G1
 susK+ru6EcIu8Bs6jHLNREsK5IZ2nbohWspYAmh6Q9lgGtPACmkEciJ2N7t+K7gmqHSCnBIBxk6
 YF5pFvMm7CwucDM9GjGzPwAwO/NR9JnVcgsl/0E5mj
X-Gm-Gg: AeBDies6/nxS83WFBDv2tL/287dVf9UFh+OcVwrUQefCXE2kG+6Df3ZI1r2yjVvr2Ld
 cbiOuVBKpT2OzIGZDtrNJB+gvZdMYkVVmS/8zs6/22BGogK0QmBvCR+ToeEvrs7H52MnJgxf7J9
 sbhuTsLGcxjt93Yp4avGjNYkS8Fnhp0goBuXRheVaq84apQ2ZWzjX9Z1zXmgf4bjyDwm7yPdetS
 yc0uF7D9IBXQK7yYxeVT/ROum6k+OG8YKQ+6pwdrEMo7fHS0ZTsCCv8in0C+bncV3WVtO2GDt/C
 J/aQ0LlMUNV8+JWoIcVXxYMLNJB1WRkbBxto3Ot7QdhGjop90dsQnx1WBtLEeKxsn0MbM8KDQpm
 21NQiCiLTSBSbtVC7U6qKRD/uuUR/7ubUMkK2jZ9q6CDdBEOE0sC2Oftotpiw90el1mvlcy3cg2
 I47qqoNvNAUV6P7eG7hPycfQwlE5tfe/pOzYA=
X-Received: by 2002:a05:620a:1a1a:b0:8cd:9b31:23b1 with SMTP id
 af79cd13be357-8fab1d46a8amr531593285a.53.1777569833921; 
 Thu, 30 Apr 2026 10:23:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1a:b0:8cd:9b31:23b1 with SMTP id
 af79cd13be357-8fab1d46a8amr531586685a.53.1777569833234; 
 Thu, 30 Apr 2026 10:23:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb0907d53sm26673385a.8.2026.04.30.10.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 34/58] whpx: i386: disable enlightenments and LAPIC for isapc
Date: Thu, 30 Apr 2026 19:21:40 +0200
Message-ID: <20260430172204.1006673-35-pbonzini@redhat.com>
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

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-13-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 75f0f062d44..cbcf1de7ae4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2546,6 +2546,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.54.0



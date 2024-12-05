Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0740E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIbL-0002lh-MH; Thu, 05 Dec 2024 15:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJIbK-0002iT-8A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJIbI-00053q-Py
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733431047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XttRe7v+NzoJCfxF4s09gbwX8AAPsfn4ims3/57ptFI=;
 b=UU38FgQdy8ljlmdWsw5RRuHfmvDhvY962taEaxl4kx4fpyOLpIC62AyueZ3gpdX65lI3zI
 gh2itSsOOSYonXOOCwZU6KtwP6Uw+br8dJwZ+ml3jwSCjxzXNFjBTUyGvE8R/2Ftxd6J1+
 wFD9PDQhC4wWYMoM4Iia/GJQ3tU9CIw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--ixjbMuWNQSMDRQilCUaRA-1; Thu, 05 Dec 2024 15:37:25 -0500
X-MC-Unique: -ixjbMuWNQSMDRQilCUaRA-1
X-Mimecast-MFC-AGG-ID: -ixjbMuWNQSMDRQilCUaRA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d88cde9cedso24877656d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431043; x=1734035843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XttRe7v+NzoJCfxF4s09gbwX8AAPsfn4ims3/57ptFI=;
 b=SqTmia/MupYbIV1+mOxU83jXm3ShRMgfhZfElRz8+tODmGucpbl0qwWMaD91kKjZi1
 Atx1YoitF9Snubqa23yVLuEIUec9mJAN34MiywsliRmokafe1Z+UedkuamNlEaNkrnIT
 67U3p/vCfdeCmKmUMvOekYM3kvLZcp0iMXz2arA/uJ8msvkVaFT2Tlmwo4MfkBg6u60F
 GJvzZsNZUYI5pDeCsVFwcM3fCL+hH8FP5ZNzNAgvcGKbfv6SawhwVvQV4GG+sHYwu4U/
 a/h5VAgkpop10hjDBJpshh+hde7mhGx+lCIIkrGtaAaIRCJtgN9NbGEs1qjM9ESJTh38
 uRTg==
X-Gm-Message-State: AOJu0Yyxu1/2j+7JTcBqiF/1Xu8llji11vPZigG07VCWJCjTxdJKyjer
 B7/5KRD6snq60HCX0gL9+TH/nOOn/229SNTkwmtpKydlfJVzQmgLr93EfTfbRLawcpzuhng6+ar
 xbuMeGOjYJ6pYa0ag0QNYplHGME/rV21svPuSoTLAiz3HEMQJtQxXrB8B9Whb1NVW8m8e86Wkb2
 TxkyFgMU5eL5qd6Ty7u1bjd8+apmKcCfYLH6kr
X-Gm-Gg: ASbGncvPgHynxvgCeuAiDtwAr1Xa7p84zlJgPVnbtiOWhma9Uty2gwB2XJrCeMZvgDz
 2PRXeN8mnL06ubySOjWJT1qk89NkjOkpHEas7alJxqNjXgRbGzvp2n5+lhOUnEfTmJTwr0lEOX6
 rdadpDeGz0OXcRFR+K3U62EWx1kmSyO1gknv8Eg1NmToxyKgnLlqFztdrX4/+mmy7W3hBqSqczc
 3gBkP2HwBAzwPakEVC81WlldMjBxfCP3Y0uzJwGI4aWM8iCScLS3PCp
X-Received: by 2002:a05:620a:2902:b0:7b6:b19b:e3e with SMTP id
 af79cd13be357-7b6bcb418d9mr94993585a.47.1733431043427; 
 Thu, 05 Dec 2024 12:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPnk5Z96yQZzDDW/XLkAEuIRiiHTmjAToOLKZ8IuTJRTEz8LI/VKST02wQzYlCwKmF93elJA==
X-Received: by 2002:a05:620a:2902:b0:7b6:b19b:e3e with SMTP id
 af79cd13be357-7b6bcb418d9mr94989485a.47.1733431043014; 
 Thu, 05 Dec 2024 12:37:23 -0800 (PST)
Received: from [10.195.154.128] ([144.121.20.163])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e60bsm94540485a.104.2024.12.05.12.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:37:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH] hpet: do not overwrite properties on post_load
Date: Thu,  5 Dec 2024 21:37:21 +0100
Message-ID: <20241205203721.347233-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Migration relies on having the same device configuration on the source
and destination.  Therefore, there is no need to modify flags,
timer capabilities and the fw_cfg HPET block id on migration;
it was set to exactly the same values by realize.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5399f1b2a3f..18c8ce26e0d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -275,16 +275,6 @@ static int hpet_post_load(void *opaque, int version_id)
                         - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     }
 
-    /* Push number of timers into capability returned via HPET_ID */
-    s->capability &= ~HPET_ID_NUM_TIM_MASK;
-    s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-
-    /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
-    s->flags &= ~(1 << HPET_MSI_SUPPORT);
-    if (s->timer[0].config & HPET_TN_FSB_CAP) {
-        s->flags |= 1 << HPET_MSI_SUPPORT;
-    }
     return 0;
 }
 
-- 
2.47.1



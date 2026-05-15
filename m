Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEE2CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNpwZ-0007Ik-8k; Fri, 15 May 2026 06:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNpwX-0007IN-SX
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNpwV-000534-LG
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778841533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f8IbwfAXFBp2iEY9hDuNfWW//pX7bZYeZL494F0BYDI=;
 b=OUYE/6NrH7oiV6EEv3Wr75KRLN1QwKYkFMSpk9kqHmgHzb7Nb0UrY9i56mvq/2VOpPOi89
 sue/hgG5/tQhqoE68Kp87NCE8HwYys6hlmO6YFKzJYiTJ/cgTdVwGPIJISH4GxzU9t1kvs
 /EHQsQmHCFNlNGMLN3xbJzI3IvDZN4A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-cywa73z4Pw2kRKI-cBV5ig-1; Fri, 15 May 2026 06:38:52 -0400
X-MC-Unique: cywa73z4Pw2kRKI-cBV5ig-1
X-Mimecast-MFC-AGG-ID: cywa73z4Pw2kRKI-cBV5ig_1778841531
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so7127810f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778841531; x=1779446331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f8IbwfAXFBp2iEY9hDuNfWW//pX7bZYeZL494F0BYDI=;
 b=Y1vkGu9urcJMfnI/NxaGxiC4eJ+VYNaaS6vaY3EttBNjls5DEJw77VCx/HtkUtpXCh
 CIXGfDmzde3ZOiVnTouKI//dswQG0iOrJOD4ibqaS6gWI/WIm187NRuPAEJI6ASrswMB
 VU7KgXfBF62LBBjONK+bMRrkZg22oY0TB4NemCychVV5RF6Y6233qMosinxsDWJvZu5P
 TH67KC/efXYE4Qwq0Jh+jGaw50vkMEgH/NiY9Bo3HpfxiWvUPRu1ATqBwV1ABYMPSzAp
 agOER0AJ/u/MP9V6BLuWxRsohiPuqkv6TydlEE+t4UWPN1NqAynkktsWqkG6kIz9dCgx
 E9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778841531; x=1779446331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8IbwfAXFBp2iEY9hDuNfWW//pX7bZYeZL494F0BYDI=;
 b=JcvKic0jYsvJe0JvzGkD45EJ831oC/qe7D+0BVFtm7bxRyvmcRqytArtsW25KtDFZD
 CSyYVZHBQ10bdXy1zFAGZyKkviAWg7BnYQstp5nv4iRUVACReJrk+1iFziZp+AbFaUtW
 TvEYu+XwMac9S/NngFJWW8MJYo8hQA/nvRQmuuw8sOSE0PFDmgk+Qqek5KdSdL+T5hkQ
 vEK8AGFHB3e/y+jG6ryKav8IFvfPHOJOJ+rpQKeFBNt7Fvhdw6m3l6DDoClPXvfN0Fna
 qhTo1rAZsK9GQu/2T2rhbZPOg7GTZVaikwfO2dDCqMX/7Z4b7lSUUW1PSoZ0hDGrz5SO
 E21g==
X-Gm-Message-State: AOJu0Yzo4cfs5PG1aA0mXhaJ8OpuH7AekJnLJBarRELoPdU1lvfcYStw
 YJXBii8oBM4VoSBHlPlxcXwjpbpDVxcZE3sTWb5iW4AwyhlyyW4vrpE8l2ll9mTxYD4o/vaff3u
 T7AR7KG/9dCSfhB6bgxYllY63OV/e5CRZjxLtdpruJOdVAcAaabIlD0xnELzQvxTq5VU1XInwV0
 s6PWZ+zMMnv3Do7oS9FlL3XHhQxNeoGehsIxW3Ncvk
X-Gm-Gg: Acq92OE9+gwkVHJzGbo6kUd6M8fVCW4pH+NP4fJLAbhxOJ4XoAoHb9XlzlOHu2m70yg
 cp2I3LS80pS0Nk5rkGOpc/ovK+QUvjwIOcc6HJcOuJTc09owtTlYmogkWhj5nOj+6JCD/uGQQJA
 dqn5wyGc46cyZhlG4NP+s4rRoYTzkcwo48OZBT3nufVOYfOnDjpzNENmIVjDQmjZU6SrvEb2zPz
 AxQB9LXyYj/AGWW58bNlzzTEzNxIrhJtRlfwfMwhbL9X+EfUIF75mD5lxz6VYQoBK75fNWej4h5
 RGqYw99bQM5XFzCo7y9og465mCt7xsEc6OC2b4u1Mpky5WCGzArrWeWjiaGDsWaANHK5lMellIj
 dfdEVuECrfkN7X0RA1mA/ZqW2iyvRdk5MEqdNfTrTaBD04cTO+pk5yC34s7STL5h/RfuvZ32SbC
 vooLa/qBCj7s8AeFEsRClD89PxF0gB
X-Received: by 2002:a05:6000:ccf:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-45e5c5bed3amr3619395f8f.26.1778841530731; 
 Fri, 15 May 2026 03:38:50 -0700 (PDT)
X-Received: by 2002:a05:6000:ccf:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-45e5c5bed3amr3619357f8f.26.1778841530261; 
 Fri, 15 May 2026 03:38:50 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm13547800f8f.21.2026.05.15.03.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:38:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Che Kao <skps96g313.cs10@gmail.com>
Subject: [PATCH] apic: fix delivery bitmask with modified xAPIC ids
Date: Fri, 15 May 2026 12:38:48 +0200
Message-ID: <20260515103848.3883904-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Self-IPIs (or all-but-self IPIs) in QEMU can cause a out-of-bounds access
to deliver_bitmask, because the access uses the APIC ID register which
is writable by the guest.  However, foreach_apic uses the delivery
bitmask indexes to look up the local_apics[] array, which is indexed
by *initial* APIC id.  Using the right id fixes both a possible heap
write overflow if the modified APIC id is too large for max_apic_words,
and a mis-delivery of both self and all-but-self IPIs.

Reported-by: Wei Che Kao <skps96g313.cs10@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index e5ea8312617..0e8932005fa 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -648,13 +648,6 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
     g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
-    uint32_t current_apic_id;
-
-    if (is_x2apic_mode(s)) {
-        current_apic_id = s->initial_apic_id;
-    } else {
-        current_apic_id = s->id;
-    }
 
     switch (dest_shorthand) {
     case 0:
@@ -662,14 +655,20 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
         break;
     case 1:
         memset(deliver_bitmask, 0x00, deliver_bitmask_size);
-        apic_set_bit(deliver_bitmask, current_apic_id);
+        /*
+         * The self and all-but-self cases do not use apic_match_dest() and
+         * directly fill in deliver_bitmask; the bitmask's indexes in turn
+         * map to local_apics[] slots which are never changed even if the
+         * xAPIC id is modified.  So use s->initial_apic_id instead of s->id.
+         */
+        apic_set_bit(deliver_bitmask, s->initial_apic_id);
         break;
     case 2:
         memset(deliver_bitmask, 0xff, deliver_bitmask_size);
         break;
     case 3:
         memset(deliver_bitmask, 0xff, deliver_bitmask_size);
-        apic_reset_bit(deliver_bitmask, current_apic_id);
+        apic_reset_bit(deliver_bitmask, s->initial_apic_id);
         break;
     }
 
-- 
2.54.0



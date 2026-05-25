Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0ECCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2t-00069h-OB; Mon, 25 May 2026 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2j-0005yZ-5g
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2h-0007Tb-2x
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpfDVA7DkFEEKD0uoA21t8IvgHUFiH16OkT5AHytVXI=;
 b=AUFPtATD8TpoSKIsac3qDfrun6PI6eUM3PqHu/V/2gV4fF3gWWG9MvQh9KDE936vOiNrED
 aDDZyy8S+kGeHRtJGAFY4fjKK1eC3kMMCRYluvgKnbkY7exQAKV28eJMVTr8YM/RfDIdlB
 OB6wyWghWx+me6yg2KXCL4buK21ylXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-4NAv5A77M3SZovkF_8iQCQ-1; Mon, 25 May 2026 11:16:31 -0400
X-MC-Unique: 4NAv5A77M3SZovkF_8iQCQ-1
X-Mimecast-MFC-AGG-ID: 4NAv5A77M3SZovkF_8iQCQ_1779722190
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490479c2911so33489695e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722190; x=1780326990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpfDVA7DkFEEKD0uoA21t8IvgHUFiH16OkT5AHytVXI=;
 b=X/XkbwfmOfTPuVgDcKK+B+JNCiKgbm4sPB0dMxbIdz1b6XDM5A7kyuZaKngpoGPkSv
 0fQ5lRveRukGSu4cKSHm0i3EWCWkdYoziNsd9zMm6lSfMGI9pjBemh1dGLlFW4Wgv1pH
 mvmWAwxqO1FKwl8C4q5QvUrjOiDpg0N1wcVK/7/P7+hlzEzVJcKEe962d0G03KAivlQW
 ri7V7XUxgdbbAMzz2Zl9h+ViZz0HmF2v/RG2ez9R2fogbP14wUMdt2TGRj3ywvAjzo9H
 ximz3Cp5Z0nKypzUQ8olb3wP0+P2yyKph3rft67ZbauItdxwxo37sU4Zt840YiLeL0GI
 sHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722190; x=1780326990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpfDVA7DkFEEKD0uoA21t8IvgHUFiH16OkT5AHytVXI=;
 b=Sb8lSz1GnIpDluryxRi17KlYUP+goMXKAt6BA7APAbtDRgpC6kLxW3V353Tlv6kPzP
 /w1saRCE4qcsztXsJecxUqOmotx/EXFLRUAW0ICyHvBiH+pgdKTasltSZNHW9xvNZLOV
 EaC7q/4Nn2pHW44r+bfeTYF5ZPA5e7+NTBkj+cuNIFnttO8Bk84PvtoyqZtzYsNCgkBz
 Qkrt1kl+GzSpB863mDLNmpWddXqfhQqqDhyZ01aP3hDC7MOEiKnvTJp2SlBdQ16ojSyr
 J84ekdTjqna11R/0np9yA6PR9udc2s6X1XUHmb33PWsxv/csi3FTA7+OvrUC4WwdJgUq
 qxoQ==
X-Gm-Message-State: AOJu0Ywq5FM1GkKQ+/H8wzqYn3uO0XhSTj+ij0r3Rjx1ZeDS0RlPSGQ8
 KGAN8CbW2pOjoHWXrEpy6Wng0JnplrIaZP+rDn3pRrwR+Ug3da4/GRLP2U8G65HSHUPliaaimOB
 BWRQSUj+NXS60QumsRFbxN37lSgDiaz9sBUIVEpaaVi5u5CjixytowowD2qy3zzm5bkQXXZrp2w
 dWz8PyCnE5BIxt+T4tPsxFi0ACC4p3HP17K6IfmuOt
X-Gm-Gg: Acq92OGx1qC1upd6Fz+mpZLg1UBEzDCFdEAHwBhwPLNg3uCij3EZmjAANXWP67/Ufcn
 91m7L5P0tSDlSDoVBmoPNRbbjzq5Z6aR6OYB2f0NlFJ5DpgCbwpzpsss65q/rLXBqOye+S691Nv
 CDjXhc5ttyLw6g8G85ZRgPNaRBcKwnxmZc83mrqWvzzgy+BcHKEBcHaikI4ZI3uMlf3vqBgl+NI
 mse3Gp/PNWRIx8NY5rU8C7aXX00AG2ltG+4Kw0GhCE6CZ4lIcNm19arY/xYdxxs3vlzr4nyLDen
 r6SbK4ZxtOCK37/zMVy3PIKGJTyvG4Xr8x3PkDQEHYai7jEwGtx5mZzZGZ/+nOM/XSq9UWvnRnS
 zOxhYBSKTtFM+ItNJgdI8OgVvJhUQz9Hr/Aqazf8a2VaZNF8G4Em8cuSst4qfx2p0ZP6d8jfJ6B
 VoAUgRFiLl29BbwT9OGxd86v08gL6J
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id
 5b1f17b1804b1-490426d1a16mr254875085e9.18.1779722190410; 
 Mon, 25 May 2026 08:16:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id
 5b1f17b1804b1-490426d1a16mr254874375e9.18.1779722189847; 
 Mon, 25 May 2026 08:16:29 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904333146bsm149273425e9.0.2026.05.25.08.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Che Kao <skps96g313.cs10@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 3/6] apic: fix delivery bitmask with modified xAPIC ids
Date: Mon, 25 May 2026 17:16:18 +0200
Message-ID: <20260525151621.395954-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
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
Cc: qemu-stable@nongnu.org
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92907C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8l-0001n9-R5; Fri, 11 Sep 2026 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8g-0001hC-UL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8f-00082G-CD
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=E7DF/5OXxus99HTw3uYRStp0qbmaJSJh1KA/jReyCe3Bqy+O4IP38rHBCNc98O4oAkL73a
 8aw4RgeXmMdHYD25UpTG4DbAt82769lWeYZP+rChSkZxKpVPrYqFZPHwkTNrIQOnvdV+uF
 Cs/bmJalHWcFcUCGFah1BfOFYgETDo4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-3HTsdQOfN4CJIelo3Nf2IQ-1; Fri, 11 Sep 2026 05:01:39 -0400
X-MC-Unique: 3HTsdQOfN4CJIelo3Nf2IQ-1
X-Mimecast-MFC-AGG-ID: 3HTsdQOfN4CJIelo3Nf2IQ_1789117298
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1156525e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117298; x=1789722098; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=GQtz/bjUTFciPfZBqD+r3ZaOUMQqCie13Tc9sL1N+aJ7agXjAsmPFf0VoMNUrwvgzh
 fMNs3pFZUtHJtsfu03LgxHk80LxIceGz+nT32II+lhk/Ez/O/RY0Y3fOUNqYrYbZ/1k4
 ojqqU764DUwWoHeQJoEZzT+34ThoZlrV8rocLFZwCxWoUXTIQ/vzyUidb6sTdKZZ2eoB
 LqzUpHbbqVfsEo0qUSXWCmmDkDTFbAfSTLeC3FokCd7lLqYltnwpJq33tUnZ/9pZyjcC
 V1CvmOUuUQfBYpcDkNoU5Orpa5aHdjall4nwKhOKlj6RH72COAiu7WY0hzZQAKI2wDD0
 8UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117298; x=1789722098;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=rR2kpHKCXzT/EOMbs6dvoROv+t4XESsEsw4EzgFtam23ZRUUDh986TqHheKm609/Qg
 JLGFCQupNux2d55W1UVBcbzSl98fPn/9r/Xp90AcbygGKHBPNiUpvrZOIQgitRT8Nadh
 M6lqj/Kb78ywT5ET4lAiQ4nUJCNZUsml9xxBJic7XGGQcqeWZ7nsNoe2Tc5odycOwEm6
 zNgs8fd7c2psIf2c/Obd/br375CYqyhSPM80+uv7AaPobZvmAokj6LygiKGmm3kRoSfE
 eFaSRr/PEvLvei9L1kTLqxIXthyQKrKuFXP21GSS0PT6FLqOxEJ5XfFQhn2Gq2HVyUre
 JRcg==
X-Gm-Message-State: AFuF++lUNJlznvrZpRNnDPL2cgBsO/fZ3NT0ZrLvXU6T6Pel5yPJnYcu
 aNiPUckb0xSWL+89nwZKLVVwOwfJKEHEGTscBynjPFYz7kck0G6VNc40uXZTV5hQyAiUEXE1lI8
 iFUpdIvUTn87W3heFcHPvw8imM5M9Y7/cnhI6ejVLfwukGzPR7q3Nzy8Cz4SBMjzraL2eIMYPxD
 Dm+ewtVlX2cDm2AkYqhPTsYNO/1Z/JyOtIhw==
X-Gm-Gg: AYBFou1DBgGFuDzygmH92r/okxeL3D92+OSTp9aVoSRSZpqGjRbbmmf9uDMIdl7AGjA
 da1Ym5fB9lb+gHF15MP6Td4uJE8BHrpjsPJqE8XsS9teRuGboqarPSC22tuwpORqf3RGWA4iLhZ
 WmppVnXMkI9WJsIrFVn2UZOAab2+mJxnlJV56e0tHseHB56E13Yp80BOmWYUsYqbgr0uJ9dFpsu
 za9Rl7Hlz09c0nXFK4lC36BTAdDchnHaCmWf3CybNExpfkyp6zlp/QJjETa50IRtb7zEOrZQkUM
 RyVlfBl8YK8z44h4Bb6lqus9gQrWLzESdcNhjcZb3vFeBgSeUcBwy/r32G4PQ9gvMWWZ3WdUbP3
 bh4E0Oxw341zuq3B3O2/9vdo=
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49e619bbccfmr33201745e9.20.1789117297674; 
 Fri, 11 Sep 2026 02:01:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49e619bbccfmr33200875e9.20.1789117296930; 
 Fri, 11 Sep 2026 02:01:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm44735785e9.3.2026.09.11.02.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:36 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>
Subject: [PULL v2 08/75] virtio: reduce code duplication for split ring
Message-ID: <47676bc33601a25a86fbe32f15a8eed2c5e1ce75.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jia Jia <physicalmtea@gmail.com>

virtio_queue_empty_rcu duplicates virtqueue_num_heads
for no good reason, let's not do it. As a nice side effect,
we gain better handling for misbehaving guests.

The virtio_device_disabled() check in virtio_queue_empty_rcu
is redundant because virtqueue_split_pop() is only called through
virtqueue_pop(), which already performs the check.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260726012857.1580646-1-physicalmtea@gmail.com>
---
 hw/virtio/virtio.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0b2fbbed3f..c9f9e5b511 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -717,26 +717,6 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
     return (avail != used) && (avail == wrap_counter);
 }
 
-/* Fetch avail_idx from VQ memory only when we really need to know if
- * guest has added some buffers.
- * Called within rcu_read_lock().  */
-static int virtio_queue_empty_rcu(VirtQueue *vq)
-{
-    if (virtio_device_disabled(vq->vdev)) {
-        return 1;
-    }
-
-    if (unlikely(!vq->vring.avail)) {
-        return 1;
-    }
-
-    if (vq->shadow_avail_idx != vq->last_avail_idx) {
-        return 0;
-    }
-
-    return vring_avail_idx(vq) == vq->last_avail_idx;
-}
-
 static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
@@ -1773,12 +1753,14 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     address_space_cache_init_empty(&indirect_desc_cache);
 
     RCU_READ_LOCK_GUARD();
-    if (virtio_queue_empty_rcu(vq)) {
+    if (unlikely(!vq->vring.avail)) {
+        goto done;
+    }
+
+    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
+    if (rc <= 0) {
         goto done;
     }
-    /* Needed after virtio_queue_empty(), see comment in
-     * virtqueue_num_heads(). */
-    smp_rmb();
 
     /* When we start there are none of either input nor output. */
     out_num = in_num = elem_entries = 0;
-- 
MST



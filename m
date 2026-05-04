Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F450FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSH-0001aK-UP; Mon, 04 May 2026 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSG-0001Zq-UK
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSE-0006mS-TW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGkVlnYi2erBoPK80hUhzVWStndRwTqSw481GkMPk/c=;
 b=gSh7LevRnaRzId/hxxepxsghafshvhra0GlNMSfoM+Ys6Tx6sNg8ZZZu7/JdJau9lybts9
 +zeqb1jxKF/B/Xe4o3ZjK1QEgtVGEhm9heaB24UU7xOJV+6Izx9Fu8jhUzpY2fHmWy4znv
 Ipuc40lc0m1bcVDi0nEyDc9PaKto6Nw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-64CvUP4YM8aO14eVSuh8FQ-1; Mon,
 04 May 2026 08:31:16 -0400
X-MC-Unique: 64CvUP4YM8aO14eVSuh8FQ-1
X-Mimecast-MFC-AGG-ID: 64CvUP4YM8aO14eVSuh8FQ_1777897875
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 569FC1956048
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFCB4180034F; Mon,  4 May 2026 12:31:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:14 +0400
Subject: [PATCH v4 08/13] system/physmem: destroy ram block attributes
 before RCU-deferred reclaim
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-8-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nOpdjVQvHEhmIuQU6j0EV8xKXqPPsp0XTTVv/TL3R44=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZvtSNOhVIdWeOG9YEznDXh0R+n3u3i5BTy
 iMQI48aMvCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5YKID/45JTxYUMVJyiAAJ4YgFYnDYy2TATp3t30f1CUiR87B4txIdYxo73Us90y4XhX2kde9jQz
 OJQd16nDaLf/stywoErB0CmezC8U6nVA2oPc4X3BszzGRBmzOzOE6wTWCXo2YpVuhnW4k2k9PKF
 T8+NYUhu5h5FeBnm1i8PmnNf08L3x0JITUJZNIyWgIkx2S1dGwjuXt8jtQYTwbkTYKWQ4MHAAVb
 o7DAmp8/cwTox/piFle6quuIy2YzNw8/JEg5m6Nef606G0Xf+ZMEC70CbCLIIpcrKHtqrO5C1To
 E3GZlbekoIwb8kPR4UXxqwuAZSuvq8xc+K//9Pb81UyNWuHuTdtn0yMFDhCE7krkeJAix3nWxN4
 BHk4LgJBb+mfMAOkKfO7Xxv003kfCb/lsR4FW2ud6YEkeqq0ivJ+/rHrxxxkYRMwbll5CE2UepE
 QI5AA/4jpdNShnWfP00oRdUQEhcbMoRxWOJ5gfxCLivLF2U8BAYVAVa8QFNBfeZIeOJahWMntiE
 MwIiEbUn157MeTiIkRws4qNEUY8rU7FJwFHobify5ksDEQ4ORSFAw8bYjSp3+0eAoeJL5THJIfh
 IDDa4k/q1RhVqHf43PVxbAiVsV0MMUZPcwtz0fD5/1Z27Q8+GqhdBRUEskO3n6nxGVlTdQqn+Y+
 qrB2DX82m5srAog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ram_block_attributes_destroy() was called from reclaim_ramblock(), which
runs as an RCU callback deferred by call_rcu().

However,when the RamDiscardManager is finalized, it will assert that its
source_list is empty in the next commit. Since the RCU callback hasn't
run yet, the source added by ram_block_attributes_create() is still
attached.

Move ram_block_attributes_destroy() into qemu_ram_free() so the source
is removed synchronously. This is safe because qemu_ram_free() during
shutdown runs after pause_all_vcpus(), so no vCPU thread can
concurrently access the attributes via kvm_convert_memory().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index c58d940e807..a8472c91dff 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2583,7 +2583,6 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
-        ram_block_attributes_destroy(block->attributes);
         close(block->guest_memfd);
         ram_block_coordinated_discard_require(false);
     }
@@ -2612,6 +2611,7 @@ void qemu_ram_free(RAMBlock *block)
     /* Write list before version */
     smp_wmb();
     ram_list.version++;
+    g_clear_pointer(&block->attributes, ram_block_attributes_destroy);
     call_rcu(block, reclaim_ramblock, rcu);
     qemu_mutex_unlock_ramlist();
 }

-- 
2.54.0



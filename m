Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8k-0000tI-JJ; Wed, 17 Jun 2026 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8Q-0008Id-9t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8P-0004UP-0w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioEHdTgFq9qa8zhd6HYeSxe88eNuFY6xLLuay6+h9W0=;
 b=ixrV/GX9yCQVOMeGHGGukBdbkUycgueAOAwJEqc9V1yswDBiualfRfud51+7+FFyJnW7+h
 lh2pL+U5Pqsf/MH2zUvGfaWNBc5MJZbfTHq1fLBS+xlA56SsmhhHxlXqNpIWxK8VnBsUaP
 cEUPkDSdTPdIuuxeUEuKK7Vnpdxq5ac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-92ENrqNhO8yxgO-DVHrs6w-1; Wed,
 17 Jun 2026 11:24:55 -0400
X-MC-Unique: 92ENrqNhO8yxgO-DVHrs6w-1
X-Mimecast-MFC-AGG-ID: 92ENrqNhO8yxgO-DVHrs6w_1781709894
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF571806C96
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39BC118005B6; Wed, 17 Jun 2026 15:24:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:13 +0400
Subject: [GIT PULL 16/27] hw/input/ps2: use
 qemu_input_handler_set_leds_mask() for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-16-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=933;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RilX2AJQ0+L1a/bzjImCyk0/jJjE/Lii7XaRdPtsNug=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpwVUl9V7bjsw3GQbQeCv3VJL6W1LQjgmlq
 ZwB4qBWl7qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5ZXyD/9uFH7pjzHU046zFvz1dh2yOqrbkmZtDPPO33D5vLb4oaPLWhukM/q22mUjOGUwcR8LTd/
 0GhXjEt4OIAhKcEfusqJtHHCUqCkeRb6Es3soXrAMYlfgMagLMYMFLVXnfG4RrXqQ5vsXu/jN4F
 z+Lgqoc/ykVPeyFKvLIoYBBFhOzp2hsnJNBMhCVOGy02izMrJuAxVIWjSVLYMJheJKvdqE2ktu9
 MIwrrnW2zjUD9zAI+/mwR5Ualq/sy3JOg0NoPFwrFfsi+yEZb50lzRBszmriXQuwMVOzOxA9VZk
 FoIKIxWMwM4pkbTfxA0dXINP5Cyw8CGc4KV2LuFUU0BsT/OUDtUFaqB7U2Gcz6LQixRd0jpxeol
 Kvtwi9Iy/VpvX87WZmYJohji5H+Pt2F1cQDAqzfN7D8K+wMtWGfgo318lHSxp6KHrsy/b4B0EbL
 xJsZcfqlG9vVnQdAmVJV14CdhQ7w20Y+Z5AAoS4Jwzw3Fnd57QNSYN3VuJGY/y5NxVBYgiviGey
 0auDmR6+oNDF+doSpgrmnlTC5oi3UghJrqBeYd4156fNb+xflBfNb5diCMS+caXI9xijA/H/AcS
 Z3A6Dv4iIntB3L5Aro9kILAx/cmAReX0p1gzuLFWfGJl3j0mRghTo+uuCJb2adZPl+rr2kLy46/
 bQzEQrKpBurFfoQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/ps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 97df7a9a43e..5516eb262d7 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -577,7 +577,7 @@ static void ps2_set_ledstate(PS2KbdState *s, int ledstate)
 {
     trace_ps2_set_ledstate(s, ledstate);
     s->ledstate = ledstate;
-    kbd_put_ledstate(ledstate);
+    qemu_input_handler_set_leds_mask(PS2_DEVICE(s)->hs, ledstate);
 }
 
 static void ps2_reset_keyboard(PS2KbdState *s)
@@ -1108,7 +1108,7 @@ static int ps2_kbd_ledstate_post_load(void *opaque, int version_id)
 {
     PS2KbdState *s = opaque;
 
-    kbd_put_ledstate(s->ledstate);
+    qemu_input_handler_set_leds_mask(PS2_DEVICE(s)->hs, s->ledstate);
     return 0;
 }
 

-- 
2.54.0



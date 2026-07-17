Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9F7C44521
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8c-0004gD-U3; Fri, 17 Jul 2026 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8b-0004bA-3P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8Z-0003Rn-JP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTpzX+M6eo5BMfGMYdfxPXrnNBGT5NtLbqGrbPxJzHs=;
 b=h+UQbkiVr1LCBy9ZTaZdTexBIxvWAqZGzUIqGfLNwbpNpT+jH2D8TZBmDJEtFc6iQnyngc
 YxL080o9z/E5vkS//hPqc57ycvwaNnOiXa2SOf7h7iORzPy2l93oKKx/WJqnXYxGu4ol0P
 Fsf9GGyODneiA+xPp0MV7S1iU12MtTY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-tlmDR1YJN46gvEF_PMjSgA-1; Fri,
 17 Jul 2026 07:53:47 -0400
X-MC-Unique: tlmDR1YJN46gvEF_PMjSgA-1
X-Mimecast-MFC-AGG-ID: tlmDR1YJN46gvEF_PMjSgA_1784289226
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6546C1954B27
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52E211956049
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:47 +0400
Subject: [GIT PULL 08/15] ui/vnc: validate SetPixelFormat field ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-8-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FG5CL8eAqS0Q4JiU5TvJg/DwgxeKGJI/nGnE2BmZm+o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaA4CzmtI7edy5sVYIdkpLCvV9uXxtiPq3n
 tcnWSs1xWOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5TrQD/wMFpp9DEifohnXpmLGd8xg7Pl56Ny4JicmO6tK9TMrR75GV9ZNe7RVcvSyPVqbFaybW3O
 tk2W7FGdt7fZyMEA+ot8FWlDJ/dQeNUf5a51ZIgUK5dwNAoqYXwGjLzukUejJtO8p6zzzYZAGp3
 DM9uxWgsLP8iz3MLHd/pyEPtJOkhF0Zp7kTJytus/bDdH3NDb4HxVexe0ZP/4TiVtSn4KSa8BzL
 ORP8y+SLGxA4kz0xE9l4YLCY4LkMC1Lf3/OmmAXWu9wT3OC8OpUpfuOAknjMrHzUXFqzSNCWCSr
 1qK0KniLAEe6l8zfHX1ll34D7kKhrD8bJ6TE3N6V4ldMnef1fQmhspxjXHiPx++efhjEdQvgJ4H
 Af3rTxMo6aeSoISRx7QEvlDfQqvID3d25X2DNVNHiuutcB9/engI0L25oc29kJeZBtWVtwnx1lW
 r0lSEDaqcBiYE9NGTMnpMqB/1bPlxXM5Uj9G/w5PFaSkS8emVOBU4wzjsX1FJGMSExWkItsIH9k
 QJ8DwtrDNzXdKWcTCeVs/W9A8l3ueryzXo2yJ/d+nYr2cYOyTiyh4vSsstAYxRzIN5vRIUFjc7r
 3RqHb9fkFDLVdluQMTEHa0XIrR4RebMc7CiL8qzltzuvtAawmX0Tw30WskCNkuBch+wjur4AD0l
 X51qZCzgK7cJlnA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
values, but PixelFormat stores them as uint8_t. A client sending a
max value above 255 (e.g. 0x0100) passes the existing non-zero check
but silently truncates to 0 on assignment, leading to a division by
zero in the Tight PNG palette path.

Add explicit range checks if any channel max exceeds UINT8_MAX.

Fixes: CVE-2026-15578
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
Reported-by: dong ling
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index c957731877f..24aa40f7308 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2271,6 +2271,11 @@ static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
         return;
     }
 
+    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8_MAX) {
+        vnc_client_error(vs);
+        return;
+    }
+
     if (red_shift >= bits_per_pixel || red_shift >= 32 ||
         green_shift >= bits_per_pixel || green_shift >= 32 ||
         blue_shift >= bits_per_pixel || blue_shift >= 32) {

-- 
2.55.0



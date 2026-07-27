Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E25C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsC-0005qQ-5b; Mon, 27 Jul 2026 07:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsB-0005nM-1I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJs9-0003gU-7N
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6oOziT8zKOhtMdie8wWL3BR8gN2kUeDZsiiPMBFk9M=;
 b=iVQCtNYsxGJy8hk9HxQgqZzOrrlsbZdFCXAake9B2evewog02Xg5zHq34KncpmgeUDpkwI
 COCa7hesPN40y0IKUkVRGzTd1JG9Pxhzput08nBzWw+Me6/cBgm8euQ/eVLXZ9jV+KvpAh
 Y10J/V1od4p1UfwGGqgVp7E15J4R52I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-_MtPq8RVN8eNQnWfyqNUaw-1; Mon,
 27 Jul 2026 07:51:50 -0400
X-MC-Unique: _MtPq8RVN8eNQnWfyqNUaw-1
X-Mimecast-MFC-AGG-ID: _MtPq8RVN8eNQnWfyqNUaw_1785153109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98E2A1955EAB
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:51:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B24E1955F22; Mon, 27 Jul 2026 11:51:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:12 +0400
Subject: [GIT PULL 03/23] ui/vnc: remove redundant rows computation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-3-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ui2GT2zPct7cr+xHjhQjJ+Nebg8xon+0MaA+K2O4ZJI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y++G1+SrhQRIC1tInTfFosa7YM/Ges4+eog
 XKwAQJVccSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5U+7D/9/gX+rsEWTlR7JvgWvE2B4P6M0bMQnKLZ8GjJQ4HhaIc+tHzsy4x/d4VwnZseSetRnFyj
 sUKujw4m1FxpnXNwXQivTL+3zffSGAU9Ldl+6iPzQx81iPiaFP8+8SLecN0Tql673LbqjR4QIWZ
 8sZYulVi63jp4q/yG/qpU6fw2ftDjV9RL8xML0n96Cb3bBlv8cVNPzzoGpnoKZSLfcuIgg4pHGI
 hsscG/3hrlHWgc4Ru8xCuQcpyn51jC7FbIk8q3+wGeG6L06OP5IvEde01lpD7E/i+c87TXlwlHo
 PA9bPeKQCob6spt6JwLxKFtlvPG9Z1a07xqKzGyWeVVKXDeGxucyYfdxYX9G3ApNyNSe77f6wBl
 hZngnT5CoSTbr41VAYJzpWgwaOqhSqB91MBb96xpWuzTXETT8cndhPVhgW4xGxUa+FXfGh0pU0Y
 3LimAWt1utdXSMPgn9TCDk//ZULRBPpkGFJoZ42yxEHzIrOGoEU/iMJH1qeLI61OlzTAXge4WIG
 wnIY7uUA4SsFB0ybro+O9PlXHjvakprnzis1EMZ9XbHhZ80r//TJNodDXhYDVo/jH2ONSxQJsI8
 YYhzgVnBMoe4y2MUtM4u1IQ/EMQPR6cMbp/vVtgAtBK1SkAXKpY2z5g6ko9WvL1xXHDPwZKQ0CC
 Z8+3sbpthvQs3gw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"rows" was already computed in an earlier commit 3543c2b855 ("ui/vnc:
fix OOB write in vnc_refresh_lossy_rect").

Fixes: e650e4fe0f ("ui/vnc: fix out-of-bounds write in lossy refresh dirty marking")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 24aa40f7308e..656768f9c998 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3016,7 +3016,6 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
-    rows = MIN(VNC_STAT_RECT, height - y);
 
     rows = MIN(VNC_STAT_RECT, height - y);
     if (rows <= 0) {

-- 
2.55.0



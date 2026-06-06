Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949E3CD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOc-0002D4-He; Sat, 06 Jun 2026 01:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOQ-0002Bi-Pl
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOP-0008E1-De
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAwFkj/6xMxLjs4eWHPsU8ZO9MF0yW+Kp2IWPAaAtK4=;
 b=MtzJhoJ+f682+Kgh+yNZO+EHGm2qZnzjKVVlj2O1ca31HTuNcGLJxuAqNmQ/0I4oM5wUFp
 JXqzlOuBVpr+7dzfibziEFk/qZj90DXMUP33lYjFyjVbEF+dmrez7QQC+Z817Q09Ld2THi
 j9BSjuCGYaILXrUGF9ik+LKz0UFFxsg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-tgDJXFiONhiDUfIBISgoxw-1; Sat,
 06 Jun 2026 01:16:18 -0400
X-MC-Unique: tgDJXFiONhiDUfIBISgoxw-1
X-Mimecast-MFC-AGG-ID: tgDJXFiONhiDUfIBISgoxw_1780722978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDDB819560AA
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A348F195608E; Sat,  6 Jun 2026 05:16:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:39 +0400
Subject: [GIT PULL v2 07/23] hw/xlnx_dp: reject NULL 'dpdma' property
 rather than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-7-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=806;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kJdZho7KPoZAyRTuY6SsmAMLdZDbGBB9QFQKogVkqy8=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGojrPSggU4DPZy6Jh+14kmslICE0ZQLk/sDHOENAJMXpG5x+
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqI6z0AAoJENro4Ql1lpzl288P/AkA
 NmaxNO5E3cPwIZEnvpEZO2r0FaASf0pxIbPXZrpN3uZX3KQ0Rb0hxdlrN3nLxn1wCAoThCvG2nw
 tDtQg4jwXTQbQJq3QRrT5AR9L5QXPq0u5L6pJff36QWnM2et0Ssxxfc5B2bDCK7X05EeXnm97R2
 zDhjU5B911zsPU6azw2KCL0KLV2CySe/g/gySuUk4eaUZ10v42RN4jHBldgBfxZrLddxljCjZfr
 v/S+8XehP7KGMLQWZwy7mVjBSBcyVy916pCdDtBusPs/bU/tufzNcaWtHaU1B1Ph3rZ9pZd89py
 +wiUcnb95eumUOM40lSxCACgi0gDNsX0Vzt9v0SrXvn7wWafOclSDOENF8Q9Fo+MjhKjUvpoW4Z
 1MKlPKPjC66ecYL/2xQln1q4abCv6Zl+Eke8xJkAEq/l+PACpEdGW9XJqkFpSdFFdSfMpAApVgO
 MJSxlbwElAgtFxbF8OdBO6iJ5HAIy21zxnmuFVXVkcA6ZQHjo/WHblYS0UoiUAAM/iRGZGmRqxh
 y0yzp5qjaTP4KKXevakTs0522ZIK1yD1jl9rYwkF1PQ+gCefC5E7R2FbQQB1byTR7dFt8YW+avm
 rWXpiANRHeaG7aUz9VZX7UBNSw4d8fM+H5Ds0WlZNKgwTrCYKHY5BjezIImXi2aKqKzwCtcI/vJ
 qlrCX
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 2486d9e5825..98126ef320d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
     XlnxDPState *s = XLNX_DP(obj);
+
+    if (!s) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
     if (s->console) {
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);

-- 
2.54.0



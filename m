Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D01ECA5FF6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQs-0004Od-Uc; Sun, 04 Oct 2026 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQq-0004A1-4s
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQo-0003Tk-Jo
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8xSh/KZRzsGWKr2YydskZm+3mKTx2eTNyNViNiHV0Y=;
 b=JhNl+80+CgSgmF23NBrS/gDuqbcZ6O4lktQTVBnzrYSORB8NnwDvJtAaAIxapa/8i/FgD2
 wsF5MPaFrvQR6zBXCAFmF6gCBfnTbV9+xKMzefg8tYj0zGuXWUHVSVKyCwNpHBEMKzOVnG
 5SGaFny7yJOGQ350qfYF2vDTOf4vfyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-IhwwiBe4NLaIX03K2IJyHw-1; Sun,
 04 Oct 2026 06:26:54 -0400
X-MC-Unique: IhwwiBe4NLaIX03K2IJyHw-1
X-Mimecast-MFC-AGG-ID: IhwwiBe4NLaIX03K2IJyHw_1791109613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B9AF18301CA; Sun,  4 Oct 2026 10:26:53 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93ABA30000E5; Sun,  4 Oct 2026 10:26:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:09 +0400
Subject: [PATCH 55/63] hw/input/adb-mouse: validate WRITEREG request buffer
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-55-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=942;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1PJdOHSD6hjtkVxlY2wnSjt+JhXW95vIfRYxKU2TkCQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikl1r+aG9g/OQ2+J7anaMiGTUK0UeW4apMVI
 b7nZ7UogDuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5YToD/9A+EXx1zbjiIONJOdRrQbaID2WFV6VTfS8yiyosv3wP48NVWg9Z6KGQWQizS+vJ0ctAoL
 fJh6VNZfEYmpKvrbN/XeGyZ68n79qBolOCVB1lYllJWG92ZTK2KedDtsnx/yLegrA7JW4ehk+1X
 TPsxlo8kU+J0/ZdqqpqDvNdpyODJwAIY8C8mcQTB9y7twTcgSomj92fqtrm7YCS0O/eQ0fbQpX/
 yNLwuA/X1JnVYF0ci4HjO36tz5aAVMk4FAAizE5sBERBB8/XNOjOWQCfwOT6crWeF8XqsONQVm1
 qB7hFQgaO1emMWt60homK7aWUPUlGQ3ttvYPyfbNtC2B44cLsKOLWQ2obLEmmuKvdrwkoNfOuwv
 Ll7B3KPTdjr9IFkySBBWR+JBd3MYB84I9F+OSJh2RuFDASBTiMrGwW60eq/GQuYUEQQi88ydgyj
 D3GdjeoJ5bEsMH2jszM+rxFRzhNVEpt/wqb8uas05J9ZSPJEFqw2YJb/O/iQoJKyLEXT/9hw1Dp
 sx8yyrnApp3fdG6WqGL25U4GlqhiJigIp+FL/ar6cD5/2E6FTPH3HqAEHqSRkwoJm16NdP3yoQ+
 zOE2YmrjPxZRCmIN4gVPIMsPsNJ7TsCkB5Z8IEFYsuGyBaQpOw5zQutxOziZZSQFDsMQanliwj2
 1rsDjt3MteyOuyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ADB_WRITEREG handler accesses buf[1] without checking that
enough data was provided, allowing an out-of-bounds read from a
short request buffer.

Add a length check requiring at least 2 bytes before reading
buf[1].

Fixes: 267002cd2831 ("CUDA + ADB support")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-mouse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 5dcdc851fcdf..80584cce1c6b 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -164,6 +164,9 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
     olen = 0;
     switch (cmd) {
     case ADB_WRITEREG:
+        if (len < 2) {
+            return 0;
+        }
         trace_adb_device_mouse_writereg(reg, buf[1]);
         switch (reg) {
         case 2:

-- 
2.56.0.rc0.29.g47ce80527c56



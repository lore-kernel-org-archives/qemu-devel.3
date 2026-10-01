Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203D7CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGst-0001CL-Td; Thu, 01 Oct 2026 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsg-0000KC-8e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGse-0006SO-JV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqIMFM17JRJH4GAHqZOi3jz6sMxriUkE8LYm7CrZ1w4=;
 b=dN1mJ/9S4oDEeRM6B576FJ245eGY4jnnpeVE7JFgoJyZiNH7moJdQqEzzDIEhl3nRuYmKI
 fimmyB4ZZMB8T1FyheVnMP9kplEy1c4LnnXqhMsIPx9H38kv1XBgIykkYyS5+TXelF2PKN
 xp9omAR7C2/VG7OPXMrEQYp6DNiSUUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-VEbavofhOEaSZrDRX3YHqA-1; Thu,
 01 Oct 2026 09:31:20 -0400
X-MC-Unique: VEbavofhOEaSZrDRX3YHqA-1
X-Mimecast-MFC-AGG-ID: VEbavofhOEaSZrDRX3YHqA_1790861479
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A45E918011F3; Thu,  1 Oct 2026 13:31:19 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA0441956095; Thu,  1 Oct 2026 13:31:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:06 +0400
Subject: [GIT PULL 27/27] hw/usb/ccid-card-emulated: free libcacard context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-27-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DdjWdK7TYZ8eR88HZapaS5WSyEaD7cpPnolJ+mF4/4k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBJSy6hkLtjK0rRfeStUuJoJo11D2CiJn6YA
 lYp78613jGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSQAKCRDa6OEJdZac
 5QJqD/0Q84vS4mdVT8VY3OD/UMppS1JhoCprApigYJRbq9DAEf6cG9e/ny4nrUyX7wPeLf6aLVT
 e14cY2VwEaRKUUogxuLHNUQt4DD2S0P6hIjw8HmJjJ+omkyQIEs1rV0B43C1eHtKx7OEzgXJucO
 FF9LZcQN+qjRwE41Lbwt/qZlGzRMARbNiMgozL2g94uNC0r20fOLg3RsuQyn5txTbxZ4X7JnUZ8
 Sbzr4aXpt15FupM5KguihG9PWwQgzJ6UukxTulCei9eWBPwIiG0aKRwGBIVlOHaVSkL+McsOOAJ
 tb7Z+n+5yxMgTtaaYI+VxECn1N221ztDk98EyhlqnDnjYyrLg6cq29cft9vL01jkyGC/9Os8G5f
 1WNnokMOtsUevX0YVRVLXrTPWXPeyaS1CrOrv8h7ZNH2RVecBVhlvUkK+3vwoMJ/A+xaXwDfmh2
 HphRk/lQSn6D2vEaipeys2aoOqVNk/4TLPDfO/6PfkFfEt3k7+2QobpfFNq2PcWea9/DDUF2cmN
 3jklT+79UfRZalf5IPr3ynXgT+Pe6PyE6iqhukgDIxxlHwDOQAgQHSLqN+6+BZA37R4l9KRYFyh
 VyNTktHHc3MdcyRqyz8tLWRmdfWmHtVrRMs7Xp1Kko+RUgDacdJK7bCLgXf62a8Llrx90HmnTBG
 8wFw+FND3g8+x3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

libcacard uses a global context, but we can call finalize since
vcard_emul_init() would have failed earlier if a second card context was
used.

This fixes libtss2-fapi leaks spotted by ASAN.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/ccid-card-emulated.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 985f21997aa8..6c8eec39faa9 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -580,6 +580,8 @@ static void emulated_unrealize(CCIDCardState *base)
     qemu_mutex_destroy(&card->handle_apdu_mutex);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
+
+    vcard_emul_finalize();
 }
 
 static const Property emulated_card_properties[] = {

-- 
2.56.0.rc0.29.g47ce80527c56



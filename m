Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01157CA5FF5
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJRE-00055D-7H; Sun, 04 Oct 2026 06:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJRA-00050S-5x
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJR8-0003Vo-SQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBce8GCS73s85ICtktrlU0PFp3qiaV2ip+eawwlmseU=;
 b=F8hnEiwbeFOmfCkY8zZ/C2tN+bH5pgh4gtk/f7XPXZh2RmOBYM0dlOtK1P5tAk75yO2s0W
 fFK6mUo3qqKbkbQm+My2mirEx2cjTF5ks/1Zl7x7xaohWwmVTSaeND17cs2lvw4E9xUwV6
 Mvzu5vsKuT3oU0aj8eaBwXjgmSRkBJI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-r2Ca-r2PNAGew67STrhocg-1; Sun,
 04 Oct 2026 06:27:15 -0400
X-MC-Unique: r2Ca-r2PNAGew67STrhocg-1
X-Mimecast-MFC-AGG-ID: r2Ca-r2PNAGew67STrhocg_1791109634
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 150721955F3C; Sun,  4 Oct 2026 10:27:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F9371800345; Sun,  4 Oct 2026 10:27:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:15 +0400
Subject: [PATCH 61/63] hw/input/stellaris_gamepad: deassert IRQs on reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-61-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7KzMy+0poj++yfNuCdw4qbIcAp6g/wEgP49l2AL+yhs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklOchfH8yWP6D6mIr72j7ycgOWR145JrgGi
 vhcpp50kXiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5X6LD/98cxZA8SuObnUFd3T7SCsox28NVBUyCqlAktsGqmGQNemVfrZodgn6XAo9YZwMQIiStf1
 Befh0J5zhBRvOmRAC8IO7DWo9WDMmCTdXPzk9yTNLvIv9Pnxj6Pn33Ph5NKPz1jLWt0XMlzPDRd
 VZuP6aQIh+/cwn9/KHQj/bo4dzsdrrFZGdhWfsqCdsXo+aFee5U9eH6DwPH3ZKsKRP1UgEdX50e
 I4CvKT0cbFhqMaKlweva95Yrcw2WVNCbUMpygodZBLAna4py/3iKBR1h+Dkine+VEIzFfSu3nnr
 YzK7PD1tGYi3gpH+IJf/s9/uwxHTQE7kCjGbYkU34mO1zF7W4LgE/Jj8j4BH4aZAwElADynZje1
 7FTwrV1WrRHWvYsfHAKQez3KWMU4IUz3q5fszYu/8/nOqw7demrpJJicdGUq+E3Pr1pKNSnRw8D
 G7mhcKavQiz/+uWN1NdKKcrlmJjB/3wg8FU22rfkUoCkoDSUAe7WgaNVgIWVM4xpQKb7eSSoh0v
 x2Zbt5MAc6hxbYvblmyEccmb623sIP+/+Hf53Tsxx6Zn8sUkaln4mH/We255Qymzb55+X9AEyHv
 5f/6/UFmdPlidWA1pih8Hg0JY53vSg2QRN6WfM3sFWhulRllWgLRoZ6/6iELfecIsqcEbuwhlyP
 FRAfRUkQYblv4Gg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

The reset handler clears the pressed state but does not deassert
the IRQ outputs. If a button was pressed before reset, its IRQ
line remains high even though the internal state shows it as
released.

Deassert all IRQ lines during reset to keep GPIO state consistent
with the pressed array.

Fixes: a75f336b97a6 ("hw/input/stellaris_input: Convert to qdev")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/stellaris_gamepad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 376d91abad70..90780613069e 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -76,6 +76,9 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
     StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
 
     memset(s->pressed, 0, s->num_buttons * sizeof(uint8_t));
+    for (uint32_t i = 0; i < s->num_buttons; i++) {
+        qemu_set_irq(s->irqs[i], 0);
+    }
 }
 
 static const Property stellaris_gamepad_properties[] = {

-- 
2.56.0.rc0.29.g47ce80527c56



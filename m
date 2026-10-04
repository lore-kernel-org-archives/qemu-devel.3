Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A325CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPz-0000FY-CA; Sun, 04 Oct 2026 06:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPO-0007GW-M4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPL-00038H-Ur
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdA2aLj1t1jF3XhKpnUGWIt7trRcxW86GTyfyIzk/Fk=;
 b=QKQguHqoLIzGRO9S1Pny2HMWzpavMLPBmT3D6iFGsLm1AHby/I8JlvXeqLyqLacheilyWK
 EE6Cf98fsoDMifcnE9rBf3KySiZ5fgKfH2AwDeYurlkzM/uCeta3oeJyVsEvX9/OZ4l5Td
 P+0BXlJEV7qY9aaxXsU8n3/Wy7afXws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-gtNzAQ3mNKy3zwvVcvWr-Q-1; Sun,
 04 Oct 2026 06:25:25 -0400
X-MC-Unique: gtNzAQ3mNKy3zwvVcvWr-Q-1
X-Mimecast-MFC-AGG-ID: gtNzAQ3mNKy3zwvVcvWr-Q_1791109524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48581800633; Sun,  4 Oct 2026 10:25:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3DA219560AB; Sun,  4 Oct 2026 10:25:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:44 +0400
Subject: [PATCH 30/63] hw/char/escc: validate channel register index in
 post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-30-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=d3wSfFI/qSNBXDzxJzyGoIWSNC2/v3e23jh/+madrOg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjpkqrepYPHJZemBfiF0/77uE+tf2YZdPhp
 tn65yqug3aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5fXTD/9eL/epMzgV951VIlRDXAgwG4SpoBAX4q23ouJwpOOR7Amp+zFzB0Ry9kbzhzAw14WeRw8
 tH4VLafZ0HweMUue2bOwEggvxu0452M5SKPvO4mqFbuppPylHsI8067QvlqYp+GlkaFs4jmC/Pc
 aobhi7CNBdun5n3eyC/B4XAICdQQSonPH7bIEVK9nsjSQTylHDhfB0V57L+GeqlTmcBx/OOlA1B
 oYoL3JYECyj/6T17z2s4Ne3JPVjjhH7gxpAOArDUcTAj+2IiGdAEi07uAIp0iU+AiImIcEkZzZF
 mN4HRd3zSaw+7WF1XLzyjcSf9StaFBCIuJI4wQ7fPYpi/MBIHwyVrM/uyvTbW52hgkSfFKpWKnp
 X3utgMmm4NXJxLnDYOOpoV3RSpxhEIUGRasQffUNRwkKSK32t6DHqlGBWHmAaBJKTBKYZ+Nap0w
 F8l+JXI6GfBYeWqz3XMl7xzIDmvaPUioX8Z1CUJE6pjo8MgXebukJUkN5C5Y1lhE46hwwG28yhn
 kgRNZUS8We9smBj3gaDqHTjClLLZTqNw6jd0TStJrdo3m3QspdE8bFfPVYaX3PiequkfI/mg3h5
 2E7X9sclzp527Wdh2x9ehTuwdqTkXGGpDuKZn7ddXa7e8KpO/83VlIrsAvKMli00KJDwC8VnQvM
 5JDHbYoq2vV80Mw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reject migrated state where the register index exceeds the valid
range, preventing out-of-bounds access.

Fixes: bdb78cae61ec ("escc: convert to VMState, vmsd and reset")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/escc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 7aae627fb48f..1543ca680358 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -764,10 +764,21 @@ static void serial_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static int escc_chn_post_load(void *opaque, int version_id)
+{
+    ESCCChannelState *s = opaque;
+
+    if (s->reg >= ESCC_SERIAL_REGS) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_escc_chn = {
     .name = "escc_chn",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = escc_chn_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vmstate_dummy, ESCCChannelState),
         VMSTATE_UINT32(reg, ESCCChannelState),

-- 
2.56.0.rc0.29.g47ce80527c56



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB6CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXW-0006qo-NR; Tue, 13 Oct 2026 09:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUi-0002D1-NV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUh-0004jz-04
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw6/SAOR604J0ZElkZDx986HAGXIen8Uc81Q3Ou+kyA=;
 b=eZoc4Rt47Og7fGP9mDEi+it0hQsCcQX956ZPpflBlvYY3tuiwtXa4pm4lG9rGcFTlHdcBI
 n4xCa8bvoM7S15CuuXXBCPxIOeE0Ug+f/s+E4ffY06X6GDkPxe9XAHpgaPV1DfzfqDyQy6
 k3Y5MKhpGem1KkGLBeaoCaaLViAuXHs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-tWfISrMnMlKAeD7aPfYN0g-1; Tue,
 13 Oct 2026 13:24:33 +0000
X-MC-Unique: tWfISrMnMlKAeD7aPfYN0g-1
X-Mimecast-MFC-AGG-ID: tWfISrMnMlKAeD7aPfYN0g_1791897872
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D48F51828AA5; Tue, 13 Oct 2026 13:24:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD8D5418; Tue, 13 Oct 2026 13:24:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:16 +0400
Subject: [GIT PULL 19/40] audio/dbusaudio: fix off-by-one in volume channel
 assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-19-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S4fZmUYht8rRP3z55DdSNAYDxQ7X8F9r7VhXfjGQllQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDpuzu/Krhc7Zs0knFNC7PN3owW8pzIB1Hg
 RHkS8nH9XqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5VICD/48DShxLC23fSiA2DRQ8Q6ulVNdlHtrInDdeMLs8V19+1WWg8Hqxsif7S8r7F5OsK5q1do
 hUIdU5pS6MyqZZM6oDBGUKbaa0jDIxoxpTJW2/HbDmwd2wD4WJ3ERWcMcD/iA1rgBKzJrkBIKKd
 xMA+gAOI+CMVeUIuXQwnaw5chM4q/HWkChMUv0ESkMK9T18bEgzCzxuLVKrJ8ExzYjEJFS22N8F
 c4i0QmYmjqx5X+L4WtIHibeGCtdxyqT5gOpCG1h/Zik0BITH3SP9dSPZePy0Nk1uhnZXu/J5pCm
 gdEpDIoiYnL/AfOCzx5bgZYbRO2VmqPN3b36rH1ZVJdTP0dPIoQwh1vT5OWfBj5Gga3C8i13pn+
 FXwUIZbU0H1Sg6qZGU4ISiQ9LYBUd8uNBhvomhwImM/Jp2oJBPWx7uUYDstm3n9lgZtjREveQhV
 m3E+2L9U39BbisUCbcJtbIE3GW2/BPdzXElxboA/NRD89W9dTYEBQpTWZv2dhPUZiImEy+B3VK0
 ji8JkmK/zX/G1sFbJ9Cqpte8mlL8YckTfNfUU+ReZ1ZwLoI7fFMsLM+x6g0PZ0FBUiqCnRMla9e
 lXr7eBqroG93IwdlUbJNHexzWqj/z6Ae/glokht8soMsUt52321pCRk1sOE9ZceEFnLxF1jjKnC
 lVQdeL6O7t4u95g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The assertion vol->channels < sizeof(vol->vol) rejects the valid case
where channels exactly equals the array size. Use <= instead.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-2-ccbef537cbeb@redhat.com>
---
 audio/dbusaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index e9bdf6adb5bd..7d762fe873cf 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -242,7 +242,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
         return;
     }
 
-    assert(vol->channels < sizeof(vol->vol));
+    assert(vol->channels <= sizeof(vol->vol));
     bytes = g_bytes_new(vol->vol, vol->channels);
     v_vol = g_variant_new_from_bytes(G_VARIANT_TYPE("ay"), bytes, TRUE);
     qemu_dbus_display1_audio_out_listener_call_set_volume(
@@ -332,7 +332,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
         return;
     }
 
-    assert(vol->channels < sizeof(vol->vol));
+    assert(vol->channels <= sizeof(vol->vol));
     bytes = g_bytes_new(vol->vol, vol->channels);
     v_vol = g_variant_new_from_bytes(G_VARIANT_TYPE("ay"), bytes, TRUE);
     qemu_dbus_display1_audio_in_listener_call_set_volume(

-- 
2.56.0.116.g6de20f6092dc



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E083ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJRF-0005AL-6D; Sun, 04 Oct 2026 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJRD-00055G-TE
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJRC-0003WD-Hu
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNZh7hZarGaHpEmUEyk0Isa/ZpQ2NrWJFbfqWlZtkRU=;
 b=K0LcSfYM11TVFL3JGXpodyRVtcgb0TYMgvE7r+LnrCjeCBzD3qCMPsINLFpiytH2Yul7Lx
 O86U5nzKZwgyC4YRd9O9Xo/97O13vD0vEd/fMHRt988aAKfuBpMVdQtDs3MIky5FLAOy/H
 rZKUYEsyaEWavrHol7fDDATZ+t3U5i4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-lTFbcgWHOG2oyGmOZC66qg-1; Sun,
 04 Oct 2026 06:27:18 -0400
X-MC-Unique: lTFbcgWHOG2oyGmOZC66qg-1
X-Mimecast-MFC-AGG-ID: lTFbcgWHOG2oyGmOZC66qg_1791109637
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B02D81800633; Sun,  4 Oct 2026 10:27:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B91DD1800345; Sun,  4 Oct 2026 10:27:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:16 +0400
Subject: [PATCH 62/63] hw/input/virtio-input: free VirtQueueElement in
 error unwind path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-62-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AyElH8/tNlm9RSims+vvA85zYyOSgckCGQr5dGID5Ic=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklAntmOrhvvKkBdbxN0hIWq5X2Y39fvZVxB
 bgMo4siihOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5cclD/9feOh1BLoibN1Xh9qjh/cVq92GVQrEsodnDxFWnj2DW+0BlCFFn/0quORbuqNpRqf+6Up
 tp+NvkTtJ702PEEMJ7sawhDw2zBAN89sFf312pa3FNsYtebUKcLA+YiLRXp7QUPB0QhmDLkpXh6
 gRawUBwX5QJcg+ixQ/FYNdmG2iZv+T9ou9vDOAfTq7xNKHQ0VeY83ZsponFBiBTY6KjuURJ38Wn
 mhW+o0IA5zaabBJbHa89cy2t57u10W1eljFZvU6hNn1XYpDSBmd9ejwWzBhlmqwCVKkANf4QRAQ
 w3ojFV2eUdvneeQOA3yBIc6ovdYdkvkhPRCaHbbk3+32iriK5R8AHzBm9tPILgtyfAyBQm1xdai
 SV3OtR5EIvHouJQ5iW/lIm+HWbmgKPozTM1qCd5vmJ4EVCBqIgyxqfCi0a+blk6fSQ2AvVSu/oo
 ATwPMetYuOIMv1EoAZRp3XcaUvg4ganwxNMNsOJ+g3Hijwr7kd5VFnySGuFNqrM4YuDm6c1bdas
 iTGiO1RO5DA+0IrNoGtmH4pINCIZ80VHarOpN8T021ml543I/Vllj/c0KYKcxhPlRqbKktTLLxi
 mbqSoYh1JhQHL/JSWWRx2V/ac2HzhbPkAmfKGg1l62y8/vcXg9AHMXa70RH/9QMHU+x4IslCHQQ
 TTH+7mG93zhgG+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

When virtqueue_pop fails partway through a batch, the unwind loop
calls virtqueue_unpop on already-popped elements but does not free
them. Each VirtQueueElement was allocated by virtqueue_pop and
must be freed by the caller.

Add g_free after virtqueue_unpop to prevent the leak.

Fixes: 57094547dfea ("virtio-input: fix eventq batching")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 6494cfbbe82d..dfd2964ae122 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -49,6 +49,7 @@ void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
         if (!elem) {
             while (--i >= 0) {
                 virtqueue_unpop(vinput->evt, vinput->queue[i].elem, 0);
+                g_free(vinput->queue[i].elem);
             }
             vinput->qindex = 0;
             trace_virtio_input_queue_full();

-- 
2.56.0.rc0.29.g47ce80527c56



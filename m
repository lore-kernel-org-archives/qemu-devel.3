Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6FBCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJNt-0004TX-Fe; Sun, 04 Oct 2026 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNr-0004TH-By
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNp-0002st-U4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waDd2JBYBSX0zjxw+i1TC3mgktqk/igLC0JX5D/cqNI=;
 b=CpHP8Ow+9j249IyUP2r8zBhs++J6yFxuofsXfuCWkObrhM7y/2f1qK7CR6edcimGTQE5Qq
 zp7VnzunnNvRlxUtmVjQYIGd4CrStvBmv3x0q0dHB6CFXZbAJ6qkM9BmmeevwpQjiIvYXo
 2nd9VgT99OAzclgVf/sOypWK/YOlFfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-BiA3OcPDPGuUMgQtL77WVA-1; Sun,
 04 Oct 2026 06:23:49 -0400
X-MC-Unique: BiA3OcPDPGuUMgQtL77WVA-1
X-Mimecast-MFC-AGG-ID: BiA3OcPDPGuUMgQtL77WVA_1791109428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A92D118007F4; Sun,  4 Oct 2026 10:23:48 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 704F01800370; Sun,  4 Oct 2026 10:23:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:17 +0400
Subject: [PATCH 03/63] audio/ossaudio: fix off-by-one in mmap buffer size
 assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-3-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vzS7JdNQhvKBeois7F0mDZ/KmYjvD7m0jUSyepZExNQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhDIrqqNIBqFTOwM9Vn+Ka9zPKT/VTvApKa
 BYm+nkDVQeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5XEgD/0eQ1brlx/gv0ZgtW8B+bv5BZ5DrvAjkqB8k4GTiWhBG7T6KDsbspFKMvCG+g4sZmOgeEG
 sbZtw/Hm+pYLHCwEtaJM4Ujx69CoIOTlQmcgrg4ywoFH2UNIFgAkeAjh+EmG58Vh7QWDfUayQ2z
 q/HabxYJarPz896sbrs7McZuQ6nnMrfXhCseTEX3rx88Wj/6fip0olGpUmQGmogThz9PgX0bGQT
 j1jTmuXPFmPObbID2rW5xGtAUEoLBs1Uw6tRRTqkTQEd1LcSULM53z4Gzw21JNGNIqO3l2515rF
 rS/DtzGoEImymwGaHGQxTsetI0fVHxWnSsT+xYOifOof1nA9V07TLTlB6cav+jBjk+aqBRmAoNM
 bM/xr35AA21HL1pNvrVu/HAKytmry1gzMXoihNloTITVbE515OrpEssiLCAVjlkopfxbSUs8xQi
 arix4ws0/mROImFbNF1JyZ30i2QpgSLyfEfQIVlZ4foBuSMdOg+g0zCnhKOWRfZvI5dJIotke9l
 pLmnw6dV8FGJ9ES6yU89fnJnhir7HzqMLAFk4ZLNFt5RbFVMI1B4dwXAy+gSQgb+V7FHbkAVa8C
 iwJQrA4LwsoAZUyQLHXWw9sfyUXIwD+I956YvvtzMDVsUgym+G4w/NSBOQwVHJialYHPCgwl2Km
 wxv6pJRRGtdp4xw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

oss_put_buffer_out() asserts size < hw->size_emul, but a write that
fills the entire buffer (size == size_emul) is valid. Use <= instead.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 3ba4066d085f ("ossaudio: port to the new audio backend api")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/ossaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 95a07ea1cace..e35eab3110e5 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -393,7 +393,7 @@ static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     if (oss->mmapped) {
-        assert(buf == hw->buf_emul + hw->pos_emul && size < hw->size_emul);
+        assert(buf == hw->buf_emul + hw->pos_emul && size <= hw->size_emul);
 
         hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
         return size;

-- 
2.56.0.rc0.29.g47ce80527c56



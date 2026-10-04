Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E078CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQM-0002Ro-8T; Sun, 04 Oct 2026 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQH-0001vJ-L8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQF-0003PI-42
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEi5uMPQVtP/04MMvYYCSvWyPSXfyXEzAqQgQ3EF5to=;
 b=LcCnmty86gi6dXMz3Ih9hPq6Lx9vIwxVrb+p/Eg9UT+/jxBFzW4Bhy5C7N3Vzh+KDevdHM
 XwYU4UTL8DQteSbjJeMDKFgSd0UFev1F30k1TBFb69ig+rV1axHEerugT63afvhCbh5CTf
 WNXZ5JvZqDphtxeFrB4VI6UlQulcO+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-c10rjtkDNzyEPeaB6JYr1Q-1; Sun,
 04 Oct 2026 06:26:19 -0400
X-MC-Unique: c10rjtkDNzyEPeaB6JYr1Q-1
X-Mimecast-MFC-AGG-ID: c10rjtkDNzyEPeaB6JYr1Q_1791109578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A66E180066A; Sun,  4 Oct 2026 10:26:18 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11C2C1956089; Sun,  4 Oct 2026 10:26:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:59 +0400
Subject: [PATCH 45/63] hw/display/ssd0323: mask SPI data to 8 bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-45-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KbjiFkjYr0wy4xwTuyz20IeolqwDX5Rtuu+pBr2shzg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkMBaxm9PVDspGGOwY0kHlJtQ6bVC7Mytet
 5QwRUCgMD+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5VDZD/0bl6baJ7UQd37t6HcBbyoYXmxTewSKgaObZNDwvdOAsOz1NJZpI2+O1iAneCnh9PdNPg/
 iITjrWrXbDV0TftrNa6HFYxioojX8aqwRdo0g4pl7MuuTqdYbK8takhNppTHqESA/LK4NYdGW0C
 mzl17wixDZuodNFmcYxBpsDs3L5iGzdJ9zUp6aKjpM7Xge/tugX74u3kI/PBFHnB1O8vmHNpwkb
 EMVXIQaRC6HviwtqO0wrODT7SmOqXLQn0VPyJZATnkjfk/E0FTMkYT55YzN/COoRU9uYb5Rg2ZV
 Vf4BneuVd/tRoR4TA+uWQhKCc9AFMkxy3t1/Bj1Kln5G2gVn3fH2dlC/pxVb1w9hl00ZkdsWLfZ
 JbHGeh59PMKTkeRqFYv4NDpOKkUeppSb9auvlaGuVLpN1UM6hF70YiTwH65TvMyVNJ46DRwEAqk
 HncEeAbXDZgbLN3iTor0nN8CfqTwS52HmhiwP2bu04/XdCe5rdxVEmvuiCMTEMyi808uv5tWDfB
 DIXGK6Lqzc+Nwte7oH90bqWDA8igFhw8cMxpjBobM5O635N51RqW7MrRfuB+px/Mz+V0lAUmrrU
 C9vKrIjiDsQpDBd3DuTPMOp6zmz2xyM5HY1GLdQ9VZqHQ1tSlLH2+EehAsj0/LPEkgVQEcwUgba
 6ZpyyMZ7+WqFjGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The SSD0323 is an 8-bit SPI peripheral, but the transfer function
receives a uint32_t. Mask the value to 8 bits before storing it as
a command or command data, preventing upper bits from leaking into
command dispatch and parameter values.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ssd0323.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index 9309d4d10c4a..6172596abe6c 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -102,6 +102,7 @@ static uint32_t ssd0323_transfer(SSIPeripheral *dev, uint32_t data)
         break;
     case SSD0323_CMD:
         DPRINTF("cmd 0x%02x\n", data);
+        data &= 0xff;
         if (s->cmd_len == 0) {
             s->cmd = data;
         } else {

-- 
2.56.0.rc0.29.g47ce80527c56



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJNu-0004Tn-1c; Sun, 04 Oct 2026 06:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNr-0004TP-WD
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNq-0002sn-5k
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbaaWXiHXhmVaMU0nWEhbYUaXsyhUT3YZBmrTo/DDHo=;
 b=Pr2TnZ2N2I5wtoxBLwmrTUPAvcZzrpjxQp2m4ZSuloi+29l3qTnPPd/oib4mRumAQqLG30
 igZ0CvSyXnUcSlRahaOz+l81KiE7e1BvaA13ZPYnmwVYu8+xzNAEHO2YQHRtVPqPMwVhLV
 JjTP/aGllZ32cnqcUlJAFfgcZ6Zgj5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-u1mbyN8aPLGSXWfHcMX8XQ-1; Sun,
 04 Oct 2026 06:23:45 -0400
X-MC-Unique: u1mbyN8aPLGSXWfHcMX8XQ-1
X-Mimecast-MFC-AGG-ID: u1mbyN8aPLGSXWfHcMX8XQ_1791109421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55B051800633; Sun,  4 Oct 2026 10:23:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05115180034F; Sun,  4 Oct 2026 10:23:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:15 +0400
Subject: [PATCH 01/63] audio/ossaudio: fix ioctl passing address-of-pointer
 instead of pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-1-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5NWzFvuJoAk8BcYKcTigsiQ1aB61q1lTXdilJWjsKhw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhqgJboqMTWdX96/cdih2b1M+g7aVvK69vL
 ugmL9zSV/6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5evID/9TOP+jDiWf7XgtykPIjpfjSVKmrUwUdhfhanbsjc7mi1m4NB2VLt47+7M7ZyBkVX2zDkZ
 nLXhFI3/WeyHmj6FLHMQdaSrmGvfk9hIVZ3s42IzSaDGHKJWdBZhQXW7ZGAgXWZZycSwbL7RbLK
 47d4ljI8U8Jsyv5xTiaqCzyRF0j4ienD0B4PpyUfvLclVwv2kYml9RRHskX9GMy+sxkAmAecj+K
 L7vQ7iVuX0kziEU+3SL60LCBRmmSXPQfE9Je9OsE+IvpL4Fjq7vWWDGAK8YACTSEj5SFXDIh0Pn
 r58fKhgR0EKpWjoIyScIplZ5IGRJyGxJ9g8DUk5lbEk5yPygiGf5crCjK3z6RkE+ZjFltEksNL+
 xVVRGztcYreaNjxzDAFQ+g1NreBZdemRQiaCszNXJVlTlqaoBdKRoWzX1owYOZ9gt1dfH66Nf2s
 x6IvcZ7I2NcLauBAvaDH8/92YYq6wUYDPcEImUCQWH3ZsGubiS10lRD2D3VuuBPWE5mLtANwH0z
 4hBRMji8qj+9RPwyziCA4Kt8iVl97vTuN8k12wtkJ6rOp21VH5CnWl82K2+0Yge6O2IazvQ1sDj
 sfu1fBz3rD+QsI/QKtJkXLBhOCwor1tEOyKLczOWlmwcwUkDi368eAa8mhT10fDKPccQ1jTDiaz
 tap+GUXMtPVSHCQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

oss_get_version() passes &version to ioctl(), but version is already
an int*, so &version is int** which writes to the wrong address on the
stack. Pass version directly.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 72ff25e4e98d ("Workaround for broken OSS_GETVERSION on FreeBSD, part two")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/ossaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 63c6e0a291f1..95a07ea1cace 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -204,7 +204,7 @@ static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, bool *big_endian)
 #ifdef USE_DSP_POLICY
 static int oss_get_version (int fd, int *version, const char *typ)
 {
-    if (ioctl (fd, OSS_GETVERSION, &version)) {
+    if (ioctl(fd, OSS_GETVERSION, version)) {
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
         /*
          * Looks like atm (20100109) FreeBSD knows OSS_GETVERSION

-- 
2.56.0.rc0.29.g47ce80527c56



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F71CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXR-00067Y-Na; Tue, 13 Oct 2026 09:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUq-0002M9-1D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUo-0004ko-JZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxYV3W2vbLN6aMWYQupQQHtXi7b6YGqiERL7KgDQMdo=;
 b=X/eZSrWN9KUOJxrnnE/88VlPin+w8OPm8xAvSY4k2mOd8op9mvxsu7dUvXg3vLQKz/kRTU
 zayMc3umX2xHKfRGcQjOTg9QXIsILWiq/keYbJBlv9zyxe8UQCg/zJjxCMzVIg4bZXGMRR
 FmcJJVbVeVHi1e+UBWPYr/zq62A/hpo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-0CzTJhp9ORe3tp14x5F_3A-1; Tue,
 13 Oct 2026 13:24:35 +0000
X-MC-Unique: 0CzTJhp9ORe3tp14x5F_3A-1
X-Mimecast-MFC-AGG-ID: 0CzTJhp9ORe3tp14x5F_3A_1791897874
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 600F9193F06A; Tue, 13 Oct 2026 13:24:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68E7A30000E7; Tue, 13 Oct 2026 13:24:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:15 +0400
Subject: [GIT PULL 18/40] audio/ossaudio: fix ioctl passing
 address-of-pointer instead of pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-18-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uyzRWVgZtKpFGIkpByvi9CcQJwojx+pNI+cWpZ1Fgdc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDI6J9u90+tzkfukA+kvn21UIL33ZrVp8jm
 H+5mLk8FkiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5TczEACKNagZE0zPe+Zp1AwebsxntbsuwzhgvDRWU5DaEqJ4qbsh3niLvTe3l1X7Y6oU+yObHxJ
 npgDl4vbPQATGkZ3F99e4h6k4oYdjGtD1Vn6/JTQShIoutPua8TYu9TVVxtUOqi21t+Wdqo2Uv5
 fvDUUIRi1RZps8XQZLgqc9/gHZte1EuBiXzEbJwodXkUqe4O+huJjfeOf3D9fSKbVEj058WFt6S
 WIF/CmCj1Zte0p93P5mH0tMMflW9BL71ekyOUExLJ6aiYzvP1pFViTJzjn+1m4DuwTqeV94CaJy
 mQKWAVTYqzYrFHiAsr3+Af2h/pMZHJHNfWzSZKzVdc5FROfUPWgsOq1WhJe9irmKEZRXSaifs0U
 pcTXykfdkONNVnvi0jqfSTyiLsQb7jeQSm7h0McE+BcPUwfHqX2V9feo67QxV8g+XVh49mtvsAf
 CAGApvon4nDVCXX9i3K9Yi4EYpna9KLHguBdsQPkJuZ7dMitkUcSa/FiPAUaGTyZhBKv6MHHFPU
 tAMuh3NYcLUV42t6pGKifdKUqlGZ073hOFLTctAyPi8dFYvFIE4q+UhmwLE9THEEpYIbVf90lIx
 bJH7rs9vvExQ/cUIPrPVmYEcbOz1F9G1PfHG/7rkxFYoYsMZncnD5kugclZgxPWs85OLnfDrS7l
 7jfTRyPCxWFZ+KA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

oss_get_version() passes &version to ioctl(), but version is already
an int*, so &version is int** which writes to the wrong address on the
stack. Pass version directly.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 72ff25e4e98d ("Workaround for broken OSS_GETVERSION on FreeBSD, part two")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-1-ccbef537cbeb@redhat.com>
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
2.56.0.116.g6de20f6092dc



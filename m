Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5628AD0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNttX-0004HR-OO; Tue, 25 Nov 2025 09:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtrh-0003Uu-1K
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:18:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtre-0001TM-P2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764080267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oR00OOZIOVzhqfRszwkgk6G0nKx9yJieVn0K7we5xkg=;
 b=iHZoFK9ir8w4H5+4S5BYnj4AlsrShxZk7S+zosA6a89X+Kn6MzyY+ILBT3eEcMvDwWFlkg
 JIogZWXuFCzvStQh6hsfyfUZD41gFgg28Lludvg643kZ/2qJN0uBqg1RiNk9qBev6dPZBM
 X0sDQwjff4n0MA5H+qDCLFqmk33ZaCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-0dFfpOqBOyGwf-Ry05mkrA-1; Tue,
 25 Nov 2025 09:17:45 -0500
X-MC-Unique: 0dFfpOqBOyGwf-Ry05mkrA-1
X-Mimecast-MFC-AGG-ID: 0dFfpOqBOyGwf-Ry05mkrA_1764080264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2684119560AF; Tue, 25 Nov 2025 14:17:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B59DA19560B2; Tue, 25 Nov 2025 14:17:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 2/4] chardev/char-file: fix failure path
Date: Tue, 25 Nov 2025 18:17:24 +0400
Message-ID: <20251125141726.1755276-3-marcandre.lureau@redhat.com>
In-Reply-To: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
References: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

'in' will be -1 when file->in is unset. Let's not try to close
invalid fd.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Coverity: CID 1630444
Fixes: 69620c091d62f "chardev: qemu_chr_open_fd(): add errp"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251014145029.949285-1-vsementsov@yandex-team.ru>
---
 chardev/char-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-file.c b/chardev/char-file.c
index 89e9cb849c..1f7adf592f 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -94,7 +94,9 @@ static void qmp_chardev_open_file(Chardev *chr,
 
     if (!qemu_chr_open_fd(chr, in, out, errp)) {
         qemu_close(out);
-        qemu_close(in);
+        if (in >= 0) {
+            qemu_close(in);
+        }
         return;
     }
 #endif
-- 
2.51.1



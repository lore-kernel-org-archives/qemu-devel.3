Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB712CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJP1-000605-82; Sun, 04 Oct 2026 06:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOm-00059A-OJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOk-0002wL-4g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/beiZTw1ej/CYS+F8UUnfhKHA5eMnPqyvo9flrxHk7Q=;
 b=BGXSZr7MDwA9LccD2AlpMeWbopp9RkTpawLT1K0mwRYe1CBGj/UCa1a0Tcz7GolVOuVHbJ
 CHcGxAVVaFOgO3xUAs0CZVp286a6FsSt1OZAD1OtMLVKeA8W7TH2l91O8V0wQZd3MXxBIv
 4iIEcwi2IgC0dC/MmCfqDDzcLNjAQho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-238Q8797MK2I_ZefwVlthA-1; Sun,
 04 Oct 2026 06:24:46 -0400
X-MC-Unique: 238Q8797MK2I_ZefwVlthA-1
X-Mimecast-MFC-AGG-ID: 238Q8797MK2I_ZefwVlthA_1791109485
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52270180065F; Sun,  4 Oct 2026 10:24:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BA7E41D; Sun,  4 Oct 2026 10:24:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:33 +0400
Subject: [PATCH 19/63] chardev/char-pty: free pty_name in finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-19-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=795;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=My6Vpfi7z3OyHVONHh5TAnk/Y0xbvqlBo9T2svLWTvs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikiGXavuITSZeXIptT+0xoOkJy7HOrZAWvRJ
 zjvUrCad6uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5Qm2D/94D1l1hmUoWtPHtlVfteCG+15nSkJdnlXDsgU+quQ9O1LciiodYQC8TF6lXf/K9GnBMQH
 HWo8qad6aMDM+RMtv7Q36owRVpFckhlp/3J/4vFMCbUj+TTbJ/HT/uc/+eWVAMvJptuGzfEQdMq
 9zI5finfSA1OffgiSj+rGkkRNpiOGV04LYkXCkDBcC7xHPL+wtnZA/TSv20nfy6EPNaShvnsGqb
 9Nu41NlyGluJku1BnC1NMvnDQmlmmSE5GipORnEf56bn52sdPpsCM+7jaDHFThPh6NuFgfKC7sG
 bvCXtOcyd/2MHwceNSJ567Rj+bxZB/ySOx+9oKMa2BFb1w/VETLOs2CwoJeGu9WpXyJV7PkKEB3
 QCT9nfeZc+FGbHyquS3iMh651HTySGDO4W5yxKT1yDLjMc4+Kp46o6ChqM1iLmb/OQ449MrNImP
 3qUDYMmOFI69cl8jA21vlt+cHgzELMMQQefAgq/fOc5WwZybviq97bVPsBNe+v2K4tygWTdDUhd
 NfBNcvSUs5ee4pBPtYHZGN+Gc7NRgycZ+NsdDaNXFHKf4QBrI/VygOtN2wJA0FwerB9TCN3CDVt
 9xYViMAXtthyp1RlP2Aotk3iCQuMff+yuA1pflD+Qd9Vnvovd6NEwSNIx9bUAIqziJiCVyXVC1v
 x1N6ThH6ojIW7kQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

The pty_name field was added to PtyChardev state but never freed
on object finalize, leaking the allocated string.

Fixes: 1116f5176e7a ("chardev/char-pty: store pty_name into PtyChardev state")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-pty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 7e95132cdbba..612607609c80 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -215,6 +215,7 @@ static void char_pty_finalize(Object *obj)
         unlink(s->path);
         g_free(s->path);
     }
+    g_clear_pointer(&s->pty_name, g_free);
 
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));

-- 
2.56.0.rc0.29.g47ce80527c56



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B83606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FqX3NAvg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtve-0007DV-Lb; Fri, 30 Oct 2026 17:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvd-0007CW-9d
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvb-0007oT-Qg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StKjRZ4UCeNGUs9EiDTpv4oGSqcJMl66L5lysLCxZKc=;
 b=FqX3NAvgqRvauzWZgGtm3EyxJ0OAzRl81n2sebVK1QvaYldgH9BJyIc+43zhKwpfktrEWo
 xyqMBPZkCP4npLMGG77UKHmNoz/Az/bKvM0t3JJImBX7GxTPATF+77bjCHKlc7KNCT0jHC
 aG00KHwzAEYBy/m0YJOIwl1rnDOfuTs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-rdBm8bvqNmWiVmi34qRWFw-1; Fri,
 30 Oct 2026 17:14:17 -0400
X-MC-Unique: rdBm8bvqNmWiVmi34qRWFw-1
X-Mimecast-MFC-AGG-ID: rdBm8bvqNmWiVmi34qRWFw_1793394856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAB491955F6D; Fri, 30 Oct 2026 21:14:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB8901803A40; Fri, 30 Oct 2026 21:14:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:04 +0400
Subject: [GIT PULL 01/10] tests/launchupdate-test: correct g_auto usage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-1-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OTAwyRO0so/cMGFgcQpr7Xakan0/uf7R4xg5CTUCGJg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigNH4d6sWyeKk5qVxjI81YnMHyUVTxU+G97
 09m6vTc2EGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5YX5EACmGldzJfVYYkJUaw57pmOCiEBMl7tPVQe/Sxdb+vO8Co5bXIqMdQltD/pFGsQB5bPpm5y
 Jg3nGqNSrDMjpZwith1UXFnUzbcuIFnwIez7p9X8V1B93AUw3SZ1kj07nm6YTB1ySMQEzm7a4s5
 HfleKY4xM0yD/djEGdc/7VWozQKVAUL7ITL7it065AF6IwHqUt264rnl+SX1/6i8izC29B+GR+m
 eVFJSvWiiey4KbYHYk0hdt2sHmheFRsamb/B0Qlq+Fr15bFwXzdoZwIK9kERnSri9Rs11AeHxlk
 P3S1Zy1HV5CHcXeEMiarawKO/B8Et3OENpgixisnHGWmOBRLpAor9/iH3bbRuYf4YffNWaJ8WBD
 KbiuTq53/Sh6pWBkGZ1i1mBiq5etfKM2KJjSN0YkjNFvTXTS4GxZPGs8wjWkpSsz/MsBP07NZGa
 iUdKMNhePBMQqjMEKAM3PO4djayHWQDZyqZ0mnuOsqk95cUkLhUGCK+qbdFIPX8o0CiJS1pK4Qu
 mvCakgIM74+Qk3XfXsrqRmXkbxzRk5RIVhiqvz8C8WhPXfxE1eS2lr6QMIVwemEohRxYGeh/QTi
 5XluErTaa/Np+qsSuhXafbzzcQSgrtab1WKf32ekSadpnBDjtqffSnmT08VexZfhQllCykbMouT
 K8xhxHE/HwSXw6A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

g_free() isn't the appropriate way to release those types.

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index 225c843df5b9..ed007cdce29f 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -192,8 +192,8 @@ static guint32 match_string(char *serial_f, const char *exp_out)
 {
     GError *error = NULL;
     g_autofree gchar *f_contents = NULL;
-    g_autofree GRegex *regex = NULL;
-    g_autofree GMatchInfo *match_info = NULL;
+    g_autoptr(GRegex) regex = NULL;
+    g_autoptr(GMatchInfo) match_info = NULL;
     gsize len;
     guint32 count = 0;
     gboolean ret;
@@ -214,7 +214,6 @@ static guint32 match_string(char *serial_f, const char *exp_out)
         g_match_info_next(match_info, &error);
         count++;
     }
-    g_regex_unref(regex);
     return count;
 }
 

-- 
2.56.0.116.g6de20f6092dc



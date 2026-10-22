Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B025606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtCxuO3v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrGp-0006eZ-Sp; Thu, 22 Oct 2026 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGo-0006e3-6P
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGm-0007Bh-I6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCEVMD1gyJAzZ9YtCPiB1iMbNGx4Ji4Gb/+PW9esD/Q=;
 b=UtCxuO3vR4XcQk69q3azpFRzUC8k8H3tqk5s7x8cVIU/AeYI6zz83DL773eXwOkPeGRfuo
 nTyfj+uhd7xUafbDtS3m0UIPzzyPdSnql2HPcCciPWO+NRyCm2Y6LPuhg2KgsgOMljTLrb
 pH0hgOqXvyy4XM2d5GQx/RkJLuNjKyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-u_s2ADT7PQ6OkvL4i76C3g-1; Thu,
 22 Oct 2026 11:47:36 +0000
X-MC-Unique: u_s2ADT7PQ6OkvL4i76C3g-1
X-Mimecast-MFC-AGG-ID: u_s2ADT7PQ6OkvL4i76C3g_1792669654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3214C1955F07; Thu, 22 Oct 2026 11:47:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3F351800642; Thu, 22 Oct 2026 11:47:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:14 +0400
Subject: [PATCH v3 01/10] tests/launchupdate-test: correct g_auto usage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-1-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=B4SuUYDYOYHdj6YNYX9ybX09sSVtBdqWgwmLhNkBr3c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffNmnHI++W3hjXq6LHUEnmdYKKmPtVEAb6zN
 vdhWIsBP3WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5QcYD/9hh6ly900E2Z1CwxUifDDzmfC1fZI1EQJBRVonyeomZm0697iwQVyj6sIL6Y//xYIsNZ4
 annXGjFxAdfDvnVaX9b3R1c3dmwOMelXiwiQSmprx5cnqpKri1z4J+08yVSnlGxIgbnGVplqkts
 u76Wk5rRswnAjG2syh0pnDFGgWdUoDp6GGw3rkgXkpck3juz9fAM59Qs9sWfG1a4YK5Tv8meKB6
 eOp1tyDKpOIGjiXKlTRVVOTmoLg7KH9+4iM8NjCNWBR3jHKNtlUN2in3fiELhF1XAaQjBivPXq7
 KPyOI7Xk7Z+hYaXC7hyeBZSPJdD+tpG/Tn0zvRWhGqLm9nL0PWE9JiyNYNmXryjSgqwlaX7EdJX
 7s924XIcu3+8g+j2a8K7q5T11WDxHwP5WJJ4Cm/dtGSA9PkIP5o4NumXmoRS/Fbigxua37Jl7+q
 9JtJW0nQdbzuuFnYHiNsg03kh7t2qV2k1QzL7R3dmipeYl7BTWPUH+6BWCgmwHl54prI//QuG4L
 P3rGvHH0chuQr/C55RbGY2wRBw7FMI+LsWS2W1dzjeWLa4QbcRDwmeA52iuxqegnHyQIyG6iOTl
 OuJlHTZDP41HM7XmVzpPf3FYx/FH003s3NiedSjdsVGzcTBztSc+7f0kSNSvAl/nkTTOkvZAME6
 xExIBmI8F7kODfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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



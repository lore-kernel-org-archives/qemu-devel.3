Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD135C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dj-0002I2-SC; Sun, 06 Sep 2026 04:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dh-0002HO-RQ
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dg-0000lz-Fw
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0km4qjkAFcD4lhaicMDtebzytg/5UCP+NpNlTDCWCO8=;
 b=I9yT124Cqh6z2AXPD6e0DTGdXNjZZQwzMEtVcUhIeTmoZzu7DQniCrZJwgsSCm8Z1QYv/d
 KKmR6VY+ygUF7zcmBo4hnSC2UuoWul5XxIE8m+U/R3Rf8wu+JFTVzPobzokmazIhEgF5Ga
 zE5rhXQu/4PirKdKGYq/G9xqKffHiI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-w5NnExbfNNa-aBZFMRYcwg-1; Sun,
 06 Sep 2026 04:54:08 -0400
X-MC-Unique: w5NnExbfNNa-aBZFMRYcwg-1
X-Mimecast-MFC-AGG-ID: w5NnExbfNNa-aBZFMRYcwg_1788684846
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEFB11955DD4; Sun,  6 Sep 2026 08:54:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 193C730002EA; Sun,  6 Sep 2026 08:54:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:36 +0400
Subject: [PATCH 4/9] tests/launchupdate-test: correct g_auto usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-4-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gdbpATPGnLOldGstBztdGH7CDvsOnIVMYXJ0fAL0KlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoYNG3KIJu29yJqCfs2RgASqkrv2dBAI987P
 Zs1G67BmaSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5X4gD/9WsoVvFff5maI6Sf/FqnPc3gvAMx4gq2QQSrhGiL3fdgyOPHMvP1RRvyNZCy53EGCzbkL
 7M/cDoCOi+zXHu4W1lVLb6fuWT8K11TaIflSr56YX9M18ozFgGjYwmD3ThLs7LjnrGUJDbb1KT+
 e0GG2g6ZAdO2Sy2wBmNDjymANksOgD13b22geucUpjptJgfFFNL2+Mb6wpF/NwfaHOLyzeXBrSo
 T9/KNsvqL+QZOJCcNa5uLkiKDZ31Ejrh7+jjiFTkLxzlodbsyvAhtZX6zXExeQ73KmMZhLlnHba
 JfTcypHUiyQ44On+XTdbHjY573bxZM3BMjNCq+5w+jfTOwL9QqNeqkzANxg/hEDMS7YRL6sHXeE
 TuntvSWbGIIPFYsvlYySykSGbYXmTrEzApEp8MxKVN9qtKlXNgxY6/RYTggAHMatFMourHmBOWw
 MRskBjHs8F61J9xDBcHw5KYe4sKzXZWwIEOlU3qv9CLscy9hwUofad4pniNd6jEIvq4UGzyFDsD
 MDt72tiVJyqT0sJqhXjn/g+zt8RB+BzNo4QS9Bac96HjEUtYQDJK8mNFgkRZMyC/+Gz8sQ219MF
 AuFERsNMpDpZ5M4Y1edNzQ5rEMNwtzU3P6Fe+v4j1zKmFxp64Ss3E8b3Oo2qQ758ctpbcRKia8u
 Z01+ZwRh0atVAXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

g_free() isn't the appropriate way to release those types.

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
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
2.55.0.543.g5ebe2ebe4ea8



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDBC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvs-0007Sl-Qi; Mon, 07 Sep 2026 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvm-0007Qx-6Q
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvk-0007yp-De
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Toh31Rw69egT0854wqDAVm+yhGtWA8fsAJaccWZ25cQ=;
 b=GKYNfJz7hFJ30cUABpGL6LjjxZ6Fq0N/CqAmfvLIsAVEes+tLrL9RiMRis6PfFOFfjKEEs
 JKZmMWkN/pa24jO5ISgLkiSqmGvBpQzDmlFs0lCVbZN1QhyiXUwQVGrjl4GAKGBWt9DxCD
 clbFgOMxrlcniTu4uoxqwUMbOKPL+HM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-ZbSaJ2kFOF6fVB-AFmJPQA-1; Mon,
 07 Sep 2026 06:50:26 -0400
X-MC-Unique: ZbSaJ2kFOF6fVB-AFmJPQA-1
X-Mimecast-MFC-AGG-ID: ZbSaJ2kFOF6fVB-AFmJPQA_1788778225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A29CC1828B0A; Mon,  7 Sep 2026 10:50:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D95621800765; Mon,  7 Sep 2026 10:50:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:03 +0400
Subject: [PATCH 05/17] qga/vss-win32: free bstrWriterName in outer writer loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-5-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qsyeB9WMifPywy5eAWsirxV4WtfDe5THehX8modYEYM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjuUEueVIE0FsNU91fgdXZBLlgx6Ue/4QvG
 1qyBlH4BZKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5fL/EACIQ414v5NXL8BZIqZxT1TOJA2YjjRRoNGEovtCnxjG8Roxz+Fw+g+7lc5No/Qxhs89E3K
 G19nECATKFOOtep3fztvpNL2KngoE+b6Uf1QKBGWl3XmKeiqAB+W5YAAnd94LCPQCuXIshjOgZZ
 lUHV3zs49ADpqY388KRbdkBrYSXyoPrYFE32iJIt357VOEyfE5s2otKvS3KyugOyioE998CtPrB
 v8q1WUCtNN4U6Vxb6ksVBhHGc8ZHnMeDvwsEBTvDlJGViGeVp7WCGBHQ+IWlUZBSpLXfQVNcYBI
 sWxSJin4u/qXP6aKyyjbkKct3PqHvjFEGlgmULbNhuSmTFy1TSQvOic9bkfTPu0t+Lafb11iMaz
 UYU7Wz59XBWbEHt3R9XfDJ6pOOXQq8MXs5p7ekVRS9/HDfALDuwpc7IViX0z6MuJMwTbJQd2+yN
 AxS4xD51tbE8M5S4kW/dnA9H7ziORCGV0JsbtPgO8BNjQ7OWb1s2PrXgeivtpsjOmB8oGocvNci
 Bhf1Ks5m+MY0TNJsxzIWdKLJPPrkfRtnlqJwL65sciGUUZT338Du3mlABJmdVNlud16sekyr6Ov
 lg+AYQ1e0+9DutkSZZXlnc2EMy6I9uxiBT1WAJmQ+hg9jLw8ghp4hD/IrzXjWO9CG86NeEe8rEx
 x5tyxR4+42TGuQA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

bstrWriterName is obtained from GetIdentity in the outer writer loop,
but freed inside the inner component loop. When a writer has multiple
components, the second and subsequent iterations operate with a NULL
bstrWriterName. If an error occurs in those iterations, the error
message passes NULL

Move SysFreeString(bstrWriterName) to the end of the outer loop where
it belongs.

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 52176d751274..b9269acb5b8e 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -230,11 +230,11 @@ static void AddComponents(ErrorSet *errset)
                     goto out;
                 }
             }
-            SysFreeString(bstrWriterName);
-            bstrWriterName = NULL;
             pComponent->FreeComponentInfo(info);
             info = NULL;
         }
+        SysFreeString(bstrWriterName);
+        bstrWriterName = NULL;
     }
 out:
     if (bstrWriterName) {

-- 
2.55.0.543.g5ebe2ebe4ea8



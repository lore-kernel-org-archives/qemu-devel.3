Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EC4EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3W-0004Jw-Ut; Fri, 06 Feb 2026 15:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3K-0004FV-EF
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008Ow-Lr
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408205; x=1771013005; i=lukasstraub2@web.de;
 bh=uuMv53cnY/NF58kfbB7HunUnASLW39jEamv0bqglux4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cqKs80QSPK34VgxPC51yf/G9iMX1CQDApvSgZcse4B8fwGsIrwHTlJwymw7AHP2K
 yeILq6/XFqyRUtIyJQ4GIAqeOwkSLiX7ozfTio0O9PSvMqqK78/aURnEpm2erH7Q1
 YiNIT0owj+As9VAGRm3rkN2EtfV3C1swO3iBZZFe+hbj0g5DmaDYjwXxCl9baJKP/
 tQgwX+t3wLJG5lk3jceuoJTBf+7tU2COw2p0qLtwqY8doJNJgFRjng7U1uvXtMPKB
 NPsEuq1enLLiV1j2yfw0DsRL0EQ3jUPBERqYACj3swxH5Ihscxc9Gkt9jKDe2ffv+
 /JsvE2Vhe5LUnL2hQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1vNP6O1XTZ-00kbzD; Fri, 06
 Feb 2026 21:03:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:05 +0100
Subject: [PATCH v6 07/18] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-7-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=NdyvakndV3dkeHSFzAflHfbOGlcPwAgindSd07Zzuv4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFOeiDDzbHn+wW6YwQk4IeUqxo87sPcDMsn
 cr8vQV2oJ2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WFWyEACLtymIFw4gl9iWJ/zy7K6Wr9Pk79RtmHPtdFAHkjqQFHzC5vf8b/Ff1mb4xNgJzX0+zpC
 BCB7FOnHHyB5vtnhdjsHcdHFhNvrKiJ5kFSqZCJfDf7O6Sql4iFQ8tpAc0pAfPEL91CltjWht1J
 5yKIyCSt9FM2SQoEKUirdOkLQm/CqUPlh3UD0WGXDM6Cay4XZVQOh3V0oHsdmS0yknDG1fKiuap
 u1QS1/r/hyZYNBVNulGX7ycHUw45e3LK15qptpyQyEylBMtzcnkZ0TUn+P9nnJCvAeCVeX7CytA
 GxiRxs+FvB13DHRg5E0tV7oEXokDdcGCcKRyy/3U5nZxQOliysTmQiEHGglvsNnnqO2DwAXoFwR
 Wth6XutwyFyIydxs+DDqtBS6hIZiudCFmnvV2Ai7IWtZmaKKd72xLpXn5YykqmAPbjiD9Q6VwF/
 rSEadHYL1h4BQVAMBl1eB1oXmeRaLgdWOODHAXRqi/DpOP8Ayn0NgM65EYhAZTnh09GY8JTQVoM
 IUwy958wGL3WcxnMHNXEKfwyxjAcq0NQfKTrEZukzAK3j5olC5JHahJCQ1aYHQUZTl9jpDTFbID
 TL/wRX4ZDbNYDKL9h9qNUCAcJn3VIkDV0HmoGM/Ane9ONw4SpkyiXVh5ylcq9HI8tpz5twl3Jc9
 Ray9YW67YZSWI7g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Fdz/bxgGuS9IHcvhDIuOuF9PRvU74h4xY+tJUj+lsfqPq4pXRK5
 cEQJNVlet90oOQ+nKn0kNs889XnowF2Z28IciObszf8esc1x0S0H6xm0TJ48h+ktaGXVZ++
 babzzvIXFyBXnbhFiXIx+TbIqTj6Zrcr0TKRPGVy96+F1Z8oFoJq+XQa99a+VY8/V0GfDi3
 01EduET7oJLzZ4pCd4ZFQ==
UI-OutboundReport: notjunk:1;M01:P0:i0jboTed7R8=;Ih2lC06n9auDclGtd4I69ihqu01
 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
 qdaew5CL4MWQZO7GU=
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5



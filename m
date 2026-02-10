Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ED1EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohY-00057Z-Hq; Tue, 10 Feb 2026 09:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohQ-00055F-Na
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohO-0005ij-9x
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733600; x=1771338400; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IhGjzl/TaK6nRFgaCDdhTcBt8BO+9OskpfYi7aagPR4WLUC4a2L9UJv+aYprT3Gt
 Ewn2YbI+ADtYqgzPUSt/azyeoIJB5ZTklIt/b8XTb+tg8xk0ylGMvCLDecBbAL1BE
 4/JuR81+BB0EvkIOX/HjM/UWctE7WRquY2pBSVizXKDIoQPVkazLxUBRkdBr7Jr8b
 N+eFQ8mXIbm1hTXDnVAkiWWv9Ppyv9d7pjMpCPmuG8P3WVizAXQtku9xTaOqPmpW4
 vVUN9qYgjRWGhzpSaID+6QeLnMLr8y7gDha5m+icm1PzMA+wSC3u8oVWfewFv3K1a
 Ejuejp4Vbts9n/XNHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1vYqNa2a18-012Ou8; Tue, 10
 Feb 2026 15:26:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:19 +0100
Subject: [PATCH v7 07/18] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-7-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Acbc8fvBOvkwh5/IzLmbAje6DPAVD1B8pzZ
 k5BS632WtuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WJ0VEACwydnVau78aFDWbhhmxS3Bo2w2GaRbBPkhZa5rf+UquN/Y5EKu6fWfptKEtLToV0J0euh
 dro0BlKOR7BSOBX1FmHqfNixZieR/buxVWcgQgOpI6mtNt3KAqwNvfwcavNSqAy6XXGW01PMilt
 Fn719uiKKTY+nzXn6woyemagyUtKsjIi8qEeKnU1ZctOz06rbPO7hXAdFQKcyaGTJKLH5gOKZwH
 wEm2fDOlKCDEkFSqjkqkRUZil67QN+tfYVVjxBIjONnXKUCSKwd0ZZoaVT0VXf8+O8O9V1TRnvh
 vjWEO7O6gUNXzZIyi/vKQo89BybOJ5RXmZLNglaCrH8rzpNNQScKA08yFykJFRcN3xWqfdqsYPS
 S8hqSKjZaJm8JBayLdpmnPFMyr/PDEtWMK2x417nG9YzREuO+8nKS5y6K1z2e02q1Flgjw2Wdfw
 dH7S6MORMx/HQgxlvzqrbdtIkLZudX4GGGSIBeCXjXn853WXdRacO+niijf4PEMMhvT64gnUAQo
 +5+1DWRF4Irp+tdjSveZHqokqJUYH15gIy5kfWBEmqKb0fbIL3g4qnaeY0S08fE7/oXJORx0kJJ
 4fz441QdthfMmCtZlINEzHRPGRbspBbge4bVdsdOza0LC9xXnI0mD7HPo94M/I3V7NKgPYrVFzF
 nuo9AACIK3Mho8Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:xdnckP23x+jM4fMesOZ/UhHLwCCZ3135YlqSU2PsujVws9QTTIS
 w/qxQi6cgnyGXKZKY954olnjSZCTJGU8X0RiUVlzv9ECs1AToohx6fVkq5JZj3GyKpUco5s
 p4jP7ntlAvkvAApmxgG3TaHLh39esSZvTYVr8h12g4ZOel+y6jTosiImJ5BNmlwQG1pDimN
 bMPa2UPZcXH0l+y3Ss8oA==
UI-OutboundReport: notjunk:1;M01:P0:LwZjE4Onw2s=;gZz79XWEhXRG/iFZClXuGeyMb2c
 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
 IyvaID2Q=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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



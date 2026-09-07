Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EBBC79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwL-0007zH-3E; Mon, 07 Sep 2026 06:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwJ-0007xR-I9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwG-00084s-Rc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=119JB0pzddz3lH7H96fc4hqRlml0NBoWi3OznF7v1yg=;
 b=AG287qbQOVlH/MXrFArsJWxKmh0teSMkBjc8ZBuB7/OjigOxpZxEQjw8ZuI4MafS1kvZhL
 WxIuV8EdNOUKLHVD3Nyz575+4UK63yBxNKe91sT2TxVpt2FGM1qM6f35eu+eYEuu38MCSR
 ULgjURg1jw/1gsFoVfM+GxKEQwZXw4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-r_HsIT_8PKuQrxUKgp8A3A-1; Mon,
 07 Sep 2026 06:50:58 -0400
X-MC-Unique: r_HsIT_8PKuQrxUKgp8A3A-1
X-Mimecast-MFC-AGG-ID: r_HsIT_8PKuQrxUKgp8A3A_1788778258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6F3B1944B3D; Mon,  7 Sep 2026 10:50:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE1B3180034F; Mon,  7 Sep 2026 10:50:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:12 +0400
Subject: [PATCH 14/17] qga/vss-win32: check GetLastError() after
 FindNextVolumeW failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-14-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hDm2EFFMYfEJHwEi8h2bx5hGHEjQtbbglyBl0/mRBAM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbj1f36UQjvGjixEqmdKSE6uCY477C5ei3Qe
 tBO15Z0ngaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5c9iD/9/UlfgB7TczIKS41ufsDzvWwf3Db9l1miNlBJ06S5uUt/e801udPVsNsr5U1cUZ16jpvL
 sJFUtuE7YfrHL75PY/dthwZdCyd8ubHLOx2FLwzvpgKr+MArW4rk0bItEKAhxwhvbF+g8i4CsWF
 vh1dgvUfxrezGb7xfsaXuUTYWNlR7RLWYOnTkKjO6GmlRyXHNKZxjemgIQ8I3eIomhOt5P4ncF4
 F7cCPImxHZZ2g1B9o3RH7WAfNdk36RZCzHt3v1xZljpFuYKoLBor7bXInYwdxUdBEdxTwoCFtdx
 GsIRvVBBBbXgg2wRZT5JlGrlZxf70aAOlXlbhUETv7rKz5AySeg1Kz1ZjRqwPHJ77+qpjSdWEO1
 2uiv31vPyn3rT3nR5hPaNbuTMOIHbbBbiUV9KyuG7APsipcROlInaAc/E4rU5mb44jfrUhf5s+z
 4y3sUrFySMMvKEQiTh/0BA9R+zuqRbRpY/OS48ko5j6kWTxflITH50uuhpX9xmt06R1D9zFOMwX
 V9YD6Fk+Ya8gQtvPZINoeZs1ZTFFf3g4RkeKqhEGTCbxK3YBCVK68C9jgACjtWaXxBnWQ/52Xdj
 n2ArnCZM1X6xYFollzrr4UgXQJgxOwp5UzX5Ju3IOGNdhpJhz0ZpnOfMEfF/yDyPNfO5Wj946K3
 TXc7KznRxLS2/+w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

FindNextVolumeW returning FALSE can mean either normal end of
enumeration (ERROR_NO_MORE_FILES) or an actual error. The code
treated both cases as end-of-list, silently skipping any remaining
volumes on a real failure.

Distinguish the two by checking GetLastError().

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index b3daa060ac01..f14c47f9f7a9 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -461,6 +461,13 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
             }
             if (!FindNextVolumeW(volume, short_volume_name,
                                  ARRAYSIZE(short_volume_name))) {
+                DWORD err = GetLastError();
+                if (err != ERROR_NO_MORE_FILES) {
+                    err_set(errset, err,
+                            "failed to find next volume");
+                    FindVolumeClose(volume);
+                    goto out;
+                }
                 FindVolumeClose(volume);
                 break;
             }

-- 
2.55.0.543.g5ebe2ebe4ea8



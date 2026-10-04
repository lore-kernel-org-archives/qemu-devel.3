Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693FCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQk-0003ca-VN; Sun, 04 Oct 2026 06:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQV-00031o-0b
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQT-0003Qu-MN
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF2kweut512LK6gnBr2tzPI+cn6alKJmj1zizH8w+o4=;
 b=TCyWHcK/NnzI3LBo94mXNN+Jzper5SxwcJznCuEWTdvO4bcILTn6vcVyUZ2vaerElAdt2N
 G9fUn7J6FmYWHYDEU1ELPy8dLhQchRwjlxPyuqFIZj2BUD7XgA6TuWeN1HNyRlIW4fTTav
 NAm5itZmBk4Cg/toB2QKzVo3PP4iZNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-G_mtRte5OOaokoUlsDO3Wg-1; Sun,
 04 Oct 2026 06:26:33 -0400
X-MC-Unique: G_mtRte5OOaokoUlsDO3Wg-1
X-Mimecast-MFC-AGG-ID: G_mtRte5OOaokoUlsDO3Wg_1791109592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52A1A1955E88; Sun,  4 Oct 2026 10:26:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A8471956089; Sun,  4 Oct 2026 10:26:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:03 +0400
Subject: [PATCH 49/63] hw/input/adb: validate devaddr on migration load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-49-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CrDTjwpZBwq8uy04/5CfYwPw7ty3/2wvDgdPwvSVwo8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikk4RXi4VywvpQFvkMWj5vXrNQBiK82KNG1J
 uzry8xuIcmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5Ux2D/9eEAMxXZ9x4I3sFri/yPFB7YrG3tXTQugOKvERrLaNpJyUQuwa1cuG/yBWqZ3jnRjPxsV
 uBifqJZoHUF1iVCBYsXa7SxL6+Q803lHU9iq0TloegLbqZMpFAnhu+DCe7XwucdyOdqqCa/GOv1
 fS2IokO1n0qnbUybReqjt6zkPYKU+gvpVDnjStE12hhz3xFYKmGV5SrutOog4XmQMipZFhhMXqI
 yPmLilvNru4RiQr6Ixr4gyITyiu1bOwU4Hy2IIHTH794JM/Kr6dvOyxiwQluF8ox+irjliQcpGF
 /R7vii2k+Z47y+WjXRbJqnhsLg4NCqX9BiR29dxZi+6LFaGz2lkwYiIkKFosQ2MUR3e7awlSPYI
 59dIWSPHY6v8izkXa0BAPVd9sTAuTXKcDN0XiPc3vXc9kedNq4BalB4lfP+/O3ZxYsagVqMNSDq
 fZUtwBGXm5MYaxJkOu1ekfHOpN9MhJtt/cLOvngoC8a20CQ85jtkZkyMYpJr8dg+zFWZYFg2hkG
 6Te547OsyTuiuCKz061qrKAJid94+yZovwSJwSk808SZHDvqud4RiKu0IQnld/KDVPYFseJanwo
 XapPysQ46RAgTmgCCMcI2Va2LnxBh1ZOb8kTxGED2LdiEbiDs9Rr2nMXpDkY7AMcmsWOfYtmNaD
 mwGOJEWILP1vJ5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

devaddr is used in 1 << d->devaddr bit shifts in do_adb_request()
and adb_poll(). A crafted migration stream could set it to a value
outside [0, MAX_ADB_DEVICES), causing undefined behavior.

Add a post_load validator to reject out-of-range values.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 0606b2883038 ("adb: introduce realize/unrealize and VMStateDescription for ADB bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 7c67d2baa663..b6319fa31535 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -280,10 +280,21 @@ static const TypeInfo adb_bus_type_info = {
     .class_init = adb_bus_class_init,
 };
 
+static int adb_device_post_load(void *opaque, int version_id)
+{
+    ADBDevice *d = opaque;
+
+    if (d->devaddr < 0 || d->devaddr >= MAX_ADB_DEVICES) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 const VMStateDescription vmstate_adb_device = {
     .name = "adb_device",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = adb_device_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(devaddr, ADBDevice),
         VMSTATE_INT32(handler, ADBDevice),

-- 
2.56.0.rc0.29.g47ce80527c56



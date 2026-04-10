Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BD3F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRh-0005hu-Ph; Fri, 10 Apr 2026 15:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRg-0005hi-FO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRf-00022w-3I
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8+aGOrlZvbLe8b3dP8NZl4yaXIo8XPnd+wSuT5ylyA=;
 b=aMlitUIJAhk6MbDrMBYFc3sQUHHXzM9qQL2o9immMGPPT9YBzKOb4KhoAkwsuV+Jsyg5p/
 HnT8FEYV+S/EaksTQvivid/At1P7BB4PlPON1GEkEiR5bQEWU5mUOZ7EMbaM6BgC1mqY1T
 jm8hmpaRLXE9DOAvnj7xbL64F3u964E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-3ul0VVN4MRmwyLf21reDkA-1; Fri,
 10 Apr 2026 15:23:08 -0400
X-MC-Unique: 3ul0VVN4MRmwyLf21reDkA-1
X-Mimecast-MFC-AGG-ID: 3ul0VVN4MRmwyLf21reDkA_1775848988
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C1551956067
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D980D1800B7F; Fri, 10 Apr 2026 19:23:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:04 +0400
Subject: [PATCH v2 42/67] ui/vnc: VncDisplay.id is not const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-42-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mSk65SLNJlDbzx9MsgD8lSsR+rYOCydI8294L/iqyCg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VCXgLnjmpdsJW0W/ZyAOFeHmRTAzdcEM50
 w8fYAdlEnyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5agJD/9QzXNOtAUPm2MNYRiTQR9Knb6h3YLd3fqh0Q5Wc9Pvw3UtkYaIrmhqpAItckxG/6g0Xu1
 9IOaPu0a/VNPr7rdYnnx6SMKkMa5WnTKU3YYUQ2HaztIHVci3X0pUiL2S5K3P2JXYwj4jIroWLF
 sC2nstF2v2ggjdLBmvRlklHWBtE96auSO2izrzX1S2xDRPE5Id7sVnrSrTsCbqPqBO+1Fee2cPa
 5jq7STeRvHX0W28LVgwIpY7EgNbk789RXN+OF9UCb3Q+DJuQFUiKYcWRJP+ZGVmVpTjzAChtcQB
 WKapJi9k0gk42Psw/gDmMKTbbWd43iqBVBmMrOf/p47WhgKntyes71thREvm03glMNpIH7OsRpe
 +gpEMTPiko2XnoDMBVrHeTDmC4hhWAIMROE0We0PKjM8d/X8/zrpk57zXiOWUI/URf5/SROasUQ
 xMlWUCLRbmB3wz4Xr5JRmLp1epJmmwY4N8MEZ3ZNDLF5QuJh3SutrmYW4ufksHk6ww9Mi0B4KCB
 8twzeFzKBck2XvcegS3kkZKNWK4cCtr6WrUvLeZyy011+vkk29pEHPQ9yk87aK2I8kJoZaD/85n
 4zxTahwbH8QpSHdbaTbiJ65WYP0ZaaV20KO0IxlLi/Vof4e3uMTOjljnA0shmLUGh7Msy6C8zyO
 CWTNz+SSJIDTN4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

s/strdup/g_strdup to highlight the issue and be consistent with other
allocations.

The next patch is going to introduce vnc_display_free() to take care of
deallocating it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 2 +-
 ui/vnc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b57..c5d678ac31e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -166,7 +166,7 @@ struct VncDisplay
     pixman_image_t *server;    /* vnc server surface */
     int true_width; /* server surface width before rounding up */
 
-    const char *id;
+    char *id;
     QTAILQ_ENTRY(VncDisplay) next;
     char *password;
     time_t expires;
diff --git a/ui/vnc.c b/ui/vnc.c
index 2df91642570..522d4d8fb88 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3431,7 +3431,7 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
-    vd->id = strdup(id);
+    vd->id = g_strdup(id);
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
 
     QTAILQ_INIT(&vd->clients);

-- 
2.53.0



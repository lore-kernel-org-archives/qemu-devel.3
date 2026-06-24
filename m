Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C199CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0C-0008Nu-UR; Wed, 24 Jun 2026 07:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM05-00080b-VI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM04-0007ja-Kj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvuDSPKPTbo9TCKH6Hayi9u+gKenhmH8yznODBJIIjI=;
 b=DkBfH9vFVZt7u01BzcDLMF7zFpuEoR3DLf5jbC5XnECKnmwMUsHeGrvLbWA9H96qE8fHoE
 qK3wONb1p1Jn875NUT8ZdExIa6eCruHUaUWt0xTkw0KNZYeOGvrLEhf7LkwWds2fV84yWt
 wgsolai3ZU7pMmfAr36vqnBtGJUDsEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-IIpfEAGwPE6JQrRpMs-O_w-1; Wed,
 24 Jun 2026 07:42:34 -0400
X-MC-Unique: IIpfEAGwPE6JQrRpMs-O_w-1
X-Mimecast-MFC-AGG-ID: IIpfEAGwPE6JQrRpMs-O_w_1782301353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F790195606D
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B552180056E; Wed, 24 Jun 2026 11:42:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:33 +0400
Subject: [GIT PULL 11/35] ui: stop ui timer when closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-11-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=913;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iUWuwyhFg8PvnBuE1m2vUvQRulennOUljpea2xquPQw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jn/PArWS2aq9biZeNTpxAyRBP1m4Xd4JNid
 R+5enKi/XCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5TtTEACE72u1wsboW8Y3Dg1KgTsoMDlPX8fsJA6L5+K9wTGyE4bKs8IQwn/4+Q74gME7BeA79Lu
 QejniKCsbVaJMndOEJmPJGRhOQOfoBFUYp0wfqPlDWnVh+vKtEx2fUHxWzHbZTF4gnWvHVwuvT8
 C05Z3g0DpK3CTMNFNXKOAjgwrMDG45c7Cf98VhQh409qNGKFDoueWdS7cGNdvhb7jUy6VQ+tjET
 mTzVDRxi3+19kbABknjn9VS/iNwA6mFv9a9WhO8sxmlfxlPqD1qM3OsXmdLmMrfmxyhfHu/a+uH
 9MzrSjSnSVcLCYYAh0Bvp7Dsa9+oIjLTmlhYRbmn1wSVH5H3eUeG+L8hq6l/6dc0MtF6w1d4A25
 wEPCurHRP0bNLCKhKd6wba7AxL129fv1ZrpjIZLwF+k/CzptsINgNaIGaTQvv3NYFUnJXPjxsFj
 U9mv7E9WoQNznSOC66ZU8+PbdlTj5ixDXQ5o96W6dTMqkqzzClKewsxDiLDNaO59FdfNVoLWHLh
 4x3/0KdrryJvrZf9WVtJef3n57gUNNXJl9Unx3yrJIqwqSZgE87Yu7fvfSfTMKXApZiKFhhnMO8
 /LrCw74MpxUeSkOxSXjAYyyzf5TaUKBlUJq7fzA+nrDOTGcTm69X7roE2PdSMihPq4QDOjv+h9A
 61fOvPr8otYSDNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

hwops is reset, so if the UI timer is pending it will crash.

Fixes: 9588d67e72 ("console: minimal hotplug suport")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-11-4656aec3398d@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index a7c977d0c44..436444723a5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1136,6 +1136,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     trace_console_gfx_close(con->index);
     object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     qemu_graphic_console_set_hwops(con, &unused_ops, NULL);
+    timer_del(con->ui_timer);
 
     if (con->gl) {
         qemu_console_gl_scanout_disable(con);

-- 
2.54.0



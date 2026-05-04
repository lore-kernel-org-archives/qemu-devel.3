Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D57ACD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraH-0007Vb-Sl; Mon, 04 May 2026 07:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraG-0007VF-6Y
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraE-0000mW-K7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iO87o/0YYcEWxdVsD3TnBacBB5QSuCWhHLZQkTvzHEc=;
 b=e62bol9j2kbUVOxGSNL30w5xgVHIQaB1gEzSlPh2vRy/w+oBiGaDB1GqKq8Mn0pzTA0bYm
 TbxZ0GlB+fO77SyJ8mI/hzd1iQmfC4enzr+Y37XF0rdkyeMCUvRmvkuqfyrGcN/UyS4IZb
 zeJzGUHjMpi9KtHOmxdlFV+V43CPoXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-LF_L3OPCMDi3m07flGrlDw-1; Mon,
 04 May 2026 07:35:27 -0400
X-MC-Unique: LF_L3OPCMDi3m07flGrlDw-1
X-Mimecast-MFC-AGG-ID: LF_L3OPCMDi3m07flGrlDw_1777894527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D18418004AD
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D76311955D84; Mon,  4 May 2026 11:35:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:50 +0400
Subject: [PATCH v2 02/46] chardev/char-socket: handle NULL addr in
 char_socket_get_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-2-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ec79R6dwgSUru8iZAGVoGIdElFOC+Hue6wBEH561cpo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRrp5dZG6laMv5/TNbO9JcdzAICs28J0fUZR
 I5MBj3QHtGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEawAKCRDa6OEJdZac
 5VrwEACLlYtxn40bBXyv/V2Z4ofbnVwaij0izQ2Y0cMi9QVZYaG1g80HttN/R5lsZ8igFpVevV9
 5r7fQrL67GGz7q3PobcbjTvAA1IacujG1+LTfUoH+w1kuXyB0uTXnft2z8+tc78PZwgc5Z+cEix
 DuVzqZ0z8GsrvrIfcmoKNwEaFBKa5nMeTw0FPlD0/6OaWIOvzlpYGdIoTHcQCtTqNTtrZe9I8o9
 h1Hc6zP/u+2x3GiwQaefcy85pETtwLzSsPjCJdrf2t1unZxadu83TYVu8P1WHgiwoOMDYccxjkk
 PbwiFJQwFHSJ+mBuIu93Z943Jm/L6B07nN0yaL6fT7LQDQUXj/6XUnnsx/A0NHLlWur5uO6DwVn
 yk3KfoVI9yw6Zo0GXmz9XyG1D8kYNcEQSfpESTKjFosO93dr+9fREEYCqw87P72IJmOONqJvNJP
 dzJWn7CYiA0kueS2RTaNnn0vRi/sZ6JnDrRzZzTHuYm+xt/XLIcwzRJSMM/98P0/FVhV6eRXp8m
 OtkyQPDlgaQnnrYOWGDB4CcM75v9OU1iFN6/l14SNxJJtgw52VgimzA3yZTFF/H34mmH8zE1cXE
 MojndqGq+mB7c30ZhQluRHllN3yjNhgi2lc3y8C7bkHcCAnp5xJPRs/F3ptA364JW2fIi6TkQwQ
 B8PZ5UPKVpN0ZOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When called on an unrealized chardev (e.g. from
qmp_qom_list_properties), s->addr is NULL. Return an error instead of
assert().

Fixes: 123676e9894f ("char-socket: add 'addr' property")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c50..b629575fcf8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1529,6 +1529,10 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
 {
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
+    if (!s->addr) {
+        error_setg(errp, "socket not connected");
+        return;
+    }
     visit_type_SocketAddress(v, name, &s->addr, errp);
 }
 

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FC8CD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOE-00029Z-Gf; Sat, 06 Jun 2026 01:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjO0-00023Q-Vr
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjNz-0008Bi-I2
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lytCdpvdiMPurS2UAPPEkSbXcRb49Mlw8+CgeQ0/TBc=;
 b=jHaDld4B3noJszH/36PGtwljOfuQm2GPOAGEn3GETjp85UuNBLqUCvw+i5g/RS/Lixn3ZM
 RmZWN+ADzmHIbnTGfNT2zn8bKsEzIBcFWpNasd6NAq8EmVu3BIMe+oe6+4zCfsyHgSYifb
 Tr7y0S9I5IvfXWcHpk+srw8PwoXKM+8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-4Hq2w9SOPcmxU8oNgJFmcw-1; Sat,
 06 Jun 2026 01:15:52 -0400
X-MC-Unique: 4Hq2w9SOPcmxU8oNgJFmcw-1
X-Mimecast-MFC-AGG-ID: 4Hq2w9SOPcmxU8oNgJFmcw_1780722951
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4BBF18004A9
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:15:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A41A11800367; Sat,  6 Jun 2026 05:15:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:34 +0400
Subject: [GIT PULL v2 02/23] chardev/char-socket: handle NULL addr in
 char_socket_get_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-2-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wplotIDRIQizQ4vLWFXXRZnYhLKWxLjUBChA2au34a0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z024yu1XzfrQixkFyYCQlKZNypOFhNkVYBc
 dg0GkzpdUuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5YTxD/9MPTZT2fhozjl4PqkOSNDCPKQsJW/tLZ7Jm37XW0PfZ2eclLvHXeF+f5kDKjFk9ydeCWJ
 OmK6to9uUmZMbDxq790AYSHFAEG6lDQhXuitGBVb8kyrrij5OgnBQy7a3yUsf4D/nSVkV39oezy
 JjV6NxfMz9SSVU8Qa0oDmlb4Nm+ZOMUIfzoB2FiXUcwT6lU7Pm0sSYz0GvR50NzJcnCmYsfqm8B
 A05/N2vZHo/lbTaW5QswTTpMEWykLI5BIU+a4be1Zwro/KY6NGHam9yfufOQ/5lzr5z3PSN28W0
 0welnkx2XZmIpLz1N/i1Z8/BXZoW8XdbCAQft+RBlH8wd73Jq1o0IBZe1Jh1Tf6FPm6Lq7zTn6m
 C0eaRBJgYm4+LRzD3wLY4ntUvYtXikycJBNPvuSHPHN1EWwnTTVpx4uEa9cdhexCnL2gLTg6a0t
 g46JewdgHXGT8uoIzXR7Bz2K7QX3uUBq/TfnoiGgI6LHjqVSyNF4hK5kEj8+x3nmLa/Y2KtOm26
 5gy4sy+1lJsf26hVk+p0j9QlEm313uGgj5gJcT9q7FLC3O67NNqOM+Hi9bzGG8zDS2CHPggxWAt
 mSWjOLMDDM5hzCdJpT2APIv0Ki6ZJh/PPmsGsspU0Fd7msUSXKvCQBxSaeWhSu2T+XmsZt2uj3+
 uVdYMKs0PtOQEGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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



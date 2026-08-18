Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B83C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHtp-00029r-Gt; Tue, 18 Aug 2026 07:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtn-000295-Rz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtm-00070i-CT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Emw5udw/hAqZHIGzxhMNpVnsgLj93r4j1DXVLXU5PSI=;
 b=dupi1NFTD+sNCr80spReZkTaw+2Ztu9H7jYGZlixfKbDcc3sKdMBABPRT5+8ywCmJ22zMd
 cyzS4bXrkxSDbRAiFHDyBBXzMoe5wliI1FpRkNU/OO57DidVNd9tlMi71OxTjV7WXS1KuG
 ZbCGcFxigNd6b/oAyfZfFW6VmlXz6Nk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-XBXP2tDpNyiR3Oe5am23PQ-1; Tue,
 18 Aug 2026 07:22:28 -0400
X-MC-Unique: XBXP2tDpNyiR3Oe5am23PQ-1
X-Mimecast-MFC-AGG-ID: XBXP2tDpNyiR3Oe5am23PQ_1787052147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3548E18004A9; Tue, 18 Aug 2026 11:22:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A58D81800346; Tue, 18 Aug 2026 11:22:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:10 +0400
Subject: [PATCH v3 43/74] net/colo-compare: fix max_queue_size setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-43-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowangio@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gH4V4GYmKlKV9gTVHip9VTPSlJHQiKGxkIO6FkOUkhE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26J7EnTwT2uQYpSXIHW+Ri85+PSSzm5nXD1
 PNg4qM5s2OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5Xd6EAC618iIyG7EaGYElR99ogtlQfb6yVfzHWp3YsOhP06nX4FZHXN5Z5KHC42j+K57WmpXwRm
 Wxyop92wbbQwM7Ebbhk8W4gXGuNIpYC6ceuC0QeYMM2KwK4ECUBy3Dru+mqQcYf1GE5zQJl2ECb
 E9y2oa4kvOZ4Fg1DFkgza0QJZZXhZtlyuPvG/n8TnlRKKt5gJweg3yH/0PZRqSt4vu0fAwiJPgR
 yWzt5jIYhKsZsokgMkyvrsFli/BhDjRyQBMkcJ/bBNQrDdJUuO9Q/6RNfm6xcBwtJ425yk5KFb6
 uFfbcxXJcVmiuaT/vwfOi8N1VKKDxNUanwxrv1dyCNDerXeysW0Zqz9exlS7Ge1jazSQNFtEZMD
 J6MvQlr4hJad6o1GbGG9YD+c2vZk40isppNHoVOqlzgPH0wCfa8cb0Xm7CTqysikFhvLoYwDCTz
 qth1EN0vASCfGwYMVC+4sVywGYLiILnfHwO/ircojvxWmdbwWXB/bpcnfqQrQY3J0i0pNCvZ6Vo
 ROHtwnO2Of5V5MdMWF8roxXQTDPPDY6Lo8U50jH+iBpWtjeo8kXHYFBQUNp2jQdAKhn7rJEnSBe
 uugrETiEwDhJ9lRuNuHQWNi3n/8mUIsa409xl/MxbbEURJgTCeAhP9MPDmmLFbPJf6WpZsOHDtC
 QMwIh5k1fRMyl+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The setter was using visit_type_uint64, accepting values wider than
the uint32_t field. Use visit_type_uint32 to match the getter, field,
and typename.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 948a2f7f9e4b..a6910de869ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1129,9 +1129,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
                                const char *name, void *opaque,
                                Error **errp)
 {
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_uint64(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.55.0.543.g5ebe2ebe4ea8



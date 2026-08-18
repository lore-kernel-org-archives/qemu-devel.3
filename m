Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671A3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHtj-000257-Eo; Tue, 18 Aug 2026 07:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHth-00021v-MN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtg-00070H-A7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToLJhQPMRz6Q1MKU2Z1nPk0uHGyHQ2rzehLqFuMaRso=;
 b=Xf4svSUgM5Q1MRyTVOImGIwqANae0xA1xebAzpSh+eK0++L19lYiD3MjcnEnF1nqM25fjv
 pI/J0OGNHK3CALw8j24gwrlid/EYPFn9KqzgQ2NIdn7D6uPnGHb4STgc/vJh442Dy31+2h
 VYclvH4wFiCFcQTnN38EpNzphCg//MQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-AeENLKZmNhOn3l0n3WJApg-1; Tue,
 18 Aug 2026 07:22:19 -0400
X-MC-Unique: AeENLKZmNhOn3l0n3WJApg-1
X-Mimecast-MFC-AGG-ID: AeENLKZmNhOn3l0n3WJApg_1787052138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F7E180034C; Tue, 18 Aug 2026 11:22:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE14D1800347; Tue, 18 Aug 2026 11:22:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:09 +0400
Subject: [PATCH v3 42/74] net/colo-compare: fix compare_timeout setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-42-24b8bbbe3d86@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rEFhsqDOs12Ay0m8ssGFoc+f7fZzJv5d/VfvFSaHnOw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26WBf/1aSTl/iuEMzJuQ5JH8nRzKnA6dSWZ
 CO0rSqkJPyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5W0WEACjKW6D+x344FCJ0p6h4npvogFXqIGegGaYkfBRT8S2hNlX5TD1si6Y+ywfDIl/yijhfo1
 7bKPIBFS/PLzL9iw/y2yKyqZ2tpuZnvM+BmUnzkIfWswU8f08KkIyqgcg1e4EWDg/RJi3xAAzwS
 nGSFmbEirP8PrVAAfH0cQutwveOjhlwqEj75epW+BckvDnGYi518XPhBuLMkzS91UCCx48mtB5R
 rO4rwuFhFa4aw8JFoKIZJjhuGykc58Fc/6nhartMsCGmjMm9FD50kRA1D0++VnbD98z6/FDGFQi
 Cd39ItDQrkKSbZdAQ/nTnWf3UsEbeW5OKbowJKijdU3UwF48ug+9yvnp9spTL1SbGwRvSDEuYsL
 ddEKxDHTgoecJS8E75a/FH48G3z8k4HJ1KLS5I1Qwe9HBe+MQX1j/8N1+mvP6t7aimlFxn9KL1m
 2DU30fJ1YHKe0kJ7fOr3BdzgYWEtuYW2Z8OY+fV8fWf5FLNya2l0/rFGHEjh2C31hAVQ3CvvTWm
 WPB+3Zj67rN8buPQKV2KI6NwXcobTJvqG7TFvs8tOmHUN5v+3vKLDLsGeTSpsp8rJ+govFPxs/q
 8jRKM+teJVWUvNW0ptQNmuIMTe9MzgwMDUTXoyn3YMhO79NFE8TbLyUJwKdSteZu23/yjQSnoNX
 VwI/Azvmax34MGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The setter was using visit_type_uint32, truncating the value, while the
getter and typename use uint64. Use visit_type_uint64 consistently.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e8800..948a2f7f9e4b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1075,9 +1075,9 @@ static void compare_set_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    uint32_t value;
+    uint64_t value;
 
-    if (!visit_type_uint32(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.55.0.543.g5ebe2ebe4ea8



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680B5C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5k-0005Cd-41; Fri, 04 Sep 2026 16:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5i-00057t-Ca
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5g-0008Lp-RF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToLJhQPMRz6Q1MKU2Z1nPk0uHGyHQ2rzehLqFuMaRso=;
 b=Br5YE4amf4P+8b2MHGRtWYlNIUB5K3Nc1MvLayvdMKFIoBllvpOGh/5tARIFZ15a35jhN5
 uOHtLVTPqtBcYQ+uMGCO9hFf3Wfxf9KJ+WMkaAN26F6EyShFrCpKtcDP/RRXi0KU4C5hlj
 EpPLssoTv0diMEWMWNvDHuWJU9DAehc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-DJWo_Y0uOWyVYDQmBCEMOw-1; Fri,
 04 Sep 2026 16:00:45 -0400
X-MC-Unique: DJWo_Y0uOWyVYDQmBCEMOw-1
X-Mimecast-MFC-AGG-ID: DJWo_Y0uOWyVYDQmBCEMOw_1788552044
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3909E1893ECB; Fri,  4 Sep 2026 20:00:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FE331800577; Fri,  4 Sep 2026 20:00:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:26 +0400
Subject: [PATCH v4 43/75] net/colo-compare: fix compare_timeout setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-43-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowangio@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rEFhsqDOs12Ay0m8ssGFoc+f7fZzJv5d/VfvFSaHnOw=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqbIsqi+uiupJzcaS60keoudMTzPiIOsCdCpNpAeOcWTyLJ0
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqmyLKAAoJENro4Ql1lpzlxKsP/A/J
 9HsKb0iEjHdnQTntRQes/kg1Kp/4DzJJhfgYvYnGKDWvv4/iSnDZd8NVesDcTFpKKNiQaeNe94X
 yye1TX6MEtyW1yCsALpTZZdNgdI+11QUKG8A4Rtif+u37SabH6b1EWCg8MCq0y/2UNrnzVgdCHE
 AN9uXcawKgKmQ7QYnaMUlp2IHEJJ88+H7EkxYwltDyC6W00cMdWKk5unecj6cH/44wOruQyeaeY
 fv8M+P6j0Tb23CzRQRSxFWAwR7SPOWJjAdnWyrjW5IZNVa/K8SozWEt/O5c1wjjMf3zAp0kF9LJ
 qadG0lo1fHL4qGrqZaecn7LH7B07SZKwJbWFreJxxR7+StZUw1tfcQvoG+o4u5B2Qlicpqy/YN6
 mdnozx0ZJuS0wXoZpcH6MlYV6sV/W68M2bxohPds8qHkn4ztSG+MgEJ4OgLc7o8Ue56kxqx4lJP
 yFvQLA+BVhinRfnQvgtSfBQD3MQN3aFD2/2GzCy9dYheBGYCOFCOGwLDS8Zo7ZJZMjzzYvoWkZH
 8q4Zvxw8vSh3XB2ut963nfr/34GvAGpf6Vv7InH+Zv9TEoWGCXkyvZOOGBv5OqA+sAMSarKGrw5
 tsiAZWZpnpimIO8VI0W4PshUEicl3Jk0wTKNGPN9TVX/LAVf20OAV5aS2QvqEE+O+JBuw6iLZ7x
 yUkCc
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



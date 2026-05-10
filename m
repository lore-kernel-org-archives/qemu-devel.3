Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E22CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4SO-00089s-P9; Sun, 10 May 2026 09:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4SK-00085c-9O
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4SI-0004R5-PQ
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFVw19IYcg8Vi68AQsWHVfWaq1NgmtwviDz8DJlU8Ec=;
 b=Jt1k9LF83aHmljx/6zyjoNjT1bzePPrHbijS6QsWfKGHQe1+cSo8YkZ9HcFkjrtBLO+UdW
 1dA8QoQdJ2eX5jOW1XcrHtUvtXwmjCTAHEpt22juqqwbmdguQ0Gqq80pNOCM6HY5i2DM5J
 A1vrlx2+K6Wsf+mOloLAQJzqaJNxy7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-oAnmq4nxO4qG68X8vxCIwQ-1; Sun,
 10 May 2026 09:44:22 -0400
X-MC-Unique: oAnmq4nxO4qG68X8vxCIwQ-1
X-Mimecast-MFC-AGG-ID: oAnmq4nxO4qG68X8vxCIwQ_1778420661
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81FF4180056E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:44:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 924431955D84; Sun, 10 May 2026 13:44:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:01 +0400
Subject: [PATCH 04/54] qapi/backend: wire up type-infos generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-4-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uvjz2W2mHnyexv8i2EcHpZHrtNOIG6lMcGZHXJTUUWQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuyfp17HI893poHEPlQLUuaZfSyPZ+SlXVH
 MisOmLIFWKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5fDOD/0cilySVlkaHT78MDjZGex+ViOei/tTYZCTbHF7kF5qrt082QSZXjeBa0qTzV/py32PXOM
 y9dQOAHBSk0sEa/PZ9q5E7ORv/79WOzkYSRPWvQYTE4AgtszHdtMsIjFOYMbZYMremWKDzq5GCi
 Dd0HoM61RRc2hXgUW2bzHyAyRB9hgpbG+mxIsdV4mnjBeTtdmx4U8O/kFq3OiB+FVD+87Q1e9g0
 d9LVde4aJ0yfeP38p1HF5ZKl2N1CpzLHjlzo/OkpRZpSjiVJxtxg52jieybl9pzMwjeegPuOmAq
 TTZ1NHdONq2Z8jFjZc9mm7wM/eELg+Uono9/XqxcNMJp7pJsFjXoGlARIWc/oU30BMHvc98y5hQ
 e8VuNIp631pHNivch1mqTvU/NVhJIwYYQMv3ZS9rgZftqbhDoByUYTDYn9NC4i2FdiaCQPb1NRK
 KTmjcexDLdE/g+9EsYNUFTOJGof7bq/9mZDui/Y4lYStm3Aq5pRiEQP2U2G0pX/Me23aXJj4VIu
 zuKF8wks6s6rpSjf1MbpU5zWLLYphgAmWkL1lT8bJb7lQQ8QIMMcijRxqJR20Ci4lj4woPo0Etn
 8ovumdL8wHTTOnoIFOkjL3kwyrQ46sqLSxeEm8HDpRyIlv+hyVyhfKD/onG2MGaut1MIw2Hrioq
 +eVR1wSRU1LA+yQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Call gen_type_infos() after gen_introspect(), passing the name map so
type-info constants get the correct masked names.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/backend.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd33..353f7801149 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,6 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
+from .type_infos import gen_type_infos
 from .types import gen_types
 from .visit import gen_visit
 
@@ -62,4 +63,5 @@ def generate(self,
         gen_visit(schema, output_dir, prefix, builtins)
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
-        gen_introspect(schema, output_dir, prefix, unmask)
+        name_map = gen_introspect(schema, output_dir, prefix, unmask)
+        gen_type_infos(schema, output_dir, prefix, builtins, name_map)

-- 
2.54.0



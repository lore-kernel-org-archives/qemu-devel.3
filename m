Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1B310F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVo-0004mW-TG; Wed, 08 Apr 2026 15:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAY5L-0006nm-5r
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKxv-0005W8-Np
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSCyW8BaYenG2sx9p4wqjnzbjbIAG1S2NlIZ7pUmPJI=;
 b=UXaKTC8t4EfmNrL+Rg1cS21pYzhr4h454+MKZ3cTlOaNTQ7eq57MUTNuENjRdhCWi001f9
 iUKLTKF0QdMcO8uycEhpB6WA+nwZqDKBaha4J3qhS3nLe8vw8O0FIlaxN5OBnH+Efv88tI
 VF8J551HPTv6c6rRvTetXPWc/gs2NQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-f0XiUKjIPjGIR8zJigv29g-1; Wed,
 08 Apr 2026 00:56:31 -0400
X-MC-Unique: f0XiUKjIPjGIR8zJigv29g-1
X-Mimecast-MFC-AGG-ID: f0XiUKjIPjGIR8zJigv29g_1775624189
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972991956094; Wed,  8 Apr 2026 04:56:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96FCE19560A6; Wed,  8 Apr 2026 04:56:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 05/10] qapi: add "Details:" markers where potentially needed
Date: Wed,  8 Apr 2026 00:55:26 -0400
Message-ID: <20260408045531.3006678-6-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

There are several locations within the QAPI source that are classified
as "Intro" text, even though semantically this is not true. Altering
these sections with an explicit Details: marker currently yields no
difference to rendered output. In the future, the inliner and/or the
addition of new stub sections *may* make these distinctions important.

These locations were identified using a heuristic patch to the QAPI doc
parser to emit a warning for Intro sections consisting of two or more
paragraphs without any other explicit section present in the source
code.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review note: this patch does not change the *.ir output at all; there
is no visible difference whatsoever. The point of this patch is solely
to prevent yelping by the heuristic checker. It may or may not become
relevant later once the inliner is merged, I did not audit that far -
neither did I spend time attempting to improve the heuristic yelper,
believing "KISS". --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2142f74e3c7..558b4f145ed 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1651,6 +1651,8 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
@@ -1724,6 +1726,8 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-pause" }
-- 
2.53.0



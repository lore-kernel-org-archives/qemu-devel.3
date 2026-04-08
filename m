Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D0A10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKG-0002tp-4G; Wed, 08 Apr 2026 15:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAYIy-0007JN-2A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKxm-0005Vj-QN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/9k75/MczGWsqLeIHbKFOkDgyIfJZC28SvYOfYhjqg=;
 b=AyFTYiSoXjdQS5r6ZATL6buW3UuGpelk4pJfodTqq65UBUEG2EQYfFnxObPk8Ao+c2Lguw
 bgEd2OYQ91Rfozv3pP65hHr6iOyUfsx1vYs58T5tmXiu22RI8RQAzFlG3CjWfKMjF6NrKa
 oiiDGegYXu+zeYK/rwGbN4MQM8HkN3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-4RGc_WEINyaZAk0gn6OHHw-1; Wed,
 08 Apr 2026 00:56:23 -0400
X-MC-Unique: 4RGc_WEINyaZAk0gn6OHHw-1
X-Mimecast-MFC-AGG-ID: 4RGc_WEINyaZAk0gn6OHHw_1775624180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 543E9180035D; Wed,  8 Apr 2026 04:56:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3146619560A6; Wed,  8 Apr 2026 04:56:11 +0000 (UTC)
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
Subject: [PATCH v2 04/10] qapi: add "Details:" markers where needed
Date: Wed,  8 Apr 2026 00:55:25 -0400
Message-ID: <20260408045531.3006678-5-jsnow@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add additional "Details:" markers in places where doing so *currently*
impacts the rendered output order of documentation sections.

There are two cases where this is done:

(1) Where we insert stub/autogenerated documentation for
    members/args/etc and return information is dependent on the
    intro-details split location. Adding a "Details:" marker facilitates
    inserting this information in the middle of the documentation block
    instead of at the end.

    These are locations where we likely SHOULD have been using the
    "TODO:" hack which was formalized in the previous commit, but had
    not been.

(2) Cases where "Since:" currently behaves as the Intro/Details
    separation point, but in the wrong location. Since this edit changes
    the output, these changes are included in this patch as well. These
    locations are for HV_BALLOON_STATUS_REPORT, query-gic-capabilities,
    and query-sev.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review note: this patch DOES change the output of the *.ir files, but
intentionally for these locations. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 3 +++
 qapi/machine.json    | 2 ++
 qapi/misc-arm.json   | 2 ++
 qapi/misc-i386.json  | 2 ++
 qapi/qom.json        | 4 ++++
 qga/qapi-schema.json | 2 ++
 6 files changed, 15 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 508b081ac16..abdcddb0a09 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5007,6 +5007,9 @@
 # @blockdev-reopen:
 #
 # Reopens one or more block devices using the given set of options.
+#
+# Details:
+#
 # Any option not specified will be reset to its default value
 # regardless of its previous status.  If an option cannot be changed
 # or a particular driver does not support reopening then the command
diff --git a/qapi/machine.json b/qapi/machine.json
index bc2279b2526..012f61e2a7e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1223,6 +1223,8 @@
 # Emitted when the hv-balloon driver receives a "STATUS" message from
 # the guest.
 #
+# Details:
+#
 # .. note:: This event is rate-limited.
 #
 # Since: 8.2
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 4dc66d00e5c..4e3f1a54055 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -33,6 +33,8 @@
 # It will return a list of `GICCapability` objects that describe its
 # capability bits.
 #
+# Details:
+#
 # On non-ARM targets this command will report an error as the GIC
 # technology is not applicable.
 #
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c416..c92853507f3 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -127,6 +127,8 @@
 #
 # Return information about SEV/SEV-ES/SEV-SNP.
 #
+# Details:
+#
 # If unavailable due to an incompatible configuration the returned
 # @enabled field is set to 'false' and the state of all other fields
 # is unspecified.
diff --git a/qapi/qom.json b/qapi/qom.json
index 1b47abd44e9..568b7d4b997 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -777,6 +777,8 @@
 #
 # Properties for memory-backend-shm objects.
 #
+# Details:
+#
 # This memory backend supports only shared memory, which is the
 # default.
 #
@@ -792,6 +794,8 @@
 #
 # Properties for memory-backend-epc objects.
 #
+# Details:
+#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f6..f2c17d08703 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -420,6 +420,8 @@
 #
 # Get guest fsfreeze state.
 #
+# Details:
+#
 # .. note:: This may fail to properly report the current state as a
 #    result of some other guest processes having issued an fs
 #    freeze/thaw.
-- 
2.53.0



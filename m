Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F10C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KX-0004kU-I5; Tue, 26 Mar 2024 03:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KU-0004jE-Tb
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KT-0005OZ-5m
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DX6+i2EUYC0nbfpAIoLt2b0ioI53ucLgBOhxWDFJqRo=;
 b=CVJyZYQ3JZ0WN716BbRTdgFwD39mKTGidUvm8jjjd/kIUgv9NSeRZUp40QPFMYMRIFvkuo
 oeLgiZbV1MsdKEVoVvjdd6UHlLahD6iHvdBGC2RRn0ZoMkZA8sSA0v6qDxrYbOAlGEX9n3
 ASxlSw2A+okSNKClnKO8fiGAB/F8Lew=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-1z-X9XiLM02_V4T-yn9RPg-1; Tue,
 26 Mar 2024 03:34:36 -0400
X-MC-Unique: 1z-X9XiLM02_V4T-yn9RPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 195C03C0E447;
 Tue, 26 Mar 2024 07:34:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B41451121312;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0A1E21E5D3A; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 20/20] qapi: document parameters of query-cpu-model-* QAPI
 commands
Date: Tue, 26 Mar 2024 08:34:20 +0100
Message-ID: <20240326073420.738016-21-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Hildenbrand <david@redhat.com>

Let's document the parameters of these commands, so we can remove them
from the "documentation-exceptions" list.

While at it, extend the "Returns:" documentation as well, fixing a wrong
use of CpuModelBaselineInfo vs. CpuModelCompareInfo for
query-cpu-model-comparison.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240325150141.342720-1-david@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Punctuation tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine-target.json | 46 +++++++++++++++++++++++++++-------------
 qapi/pragma.json         |  3 ---
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 03d7a185b9..29e695aa06 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -124,11 +124,12 @@
 ##
 # @query-cpu-model-comparison:
 #
-# Compares two CPU models, returning how they compare in a specific
-# configuration.  The results indicates how both models compare
-# regarding runnability.  This result can be used by tooling to make
-# decisions if a certain CPU model will run in a certain configuration
-# or if a compatible CPU model has to be created by baselining.
+# Compares two CPU models, @modela and @modelb, returning how they
+# compare in a specific configuration.  The results indicates how
+# both models compare regarding runnability.  This result can be
+# used by tooling to make decisions if a certain CPU model will
+# run in a certain configuration or if a compatible CPU model has
+# to be created by baselining.
 #
 # Usually, a CPU model is compared against the maximum possible CPU
 # model of a certain configuration (e.g. the "host" model for KVM).
@@ -154,7 +155,14 @@
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
-# Returns: a CpuModelBaselineInfo
+# @modela: description of the first CPU model to compare, referred to as
+#     "model A" in CpuModelCompareResult
+#
+# @modelb: description of the second CPU model to compare, referred to as
+#     "model B" in CpuModelCompareResult
+#
+# Returns: a CpuModelCompareInfo describing how both CPU models
+#     compare
 #
 # Errors:
 #     - if comparing CPU models is not supported
@@ -175,9 +183,9 @@
 ##
 # @query-cpu-model-baseline:
 #
-# Baseline two CPU models, creating a compatible third model.  The
-# created model will always be a static, migration-safe CPU model (see
-# "static" CPU model expansion for details).
+# Baseline two CPU models, @modela and @modelb, creating a compatible
+# third model.  The created model will always be a static,
+# migration-safe CPU model (see "static" CPU model expansion for details).
 #
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
@@ -204,7 +212,11 @@
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
 #
-# Returns: a CpuModelBaselineInfo
+# @modela: description of the first CPU model to baseline
+#
+# @modelb: description of the second CPU model to baseline
+#
+# Returns: a CpuModelBaselineInfo describing the baselined CPU model
 #
 # Errors:
 #     - if baselining CPU models is not supported
@@ -243,10 +255,10 @@
 ##
 # @query-cpu-model-expansion:
 #
-# Expands a given CPU model (or a combination of CPU model +
-# additional options) to different granularities, allowing tooling to
-# get an understanding what a specific CPU model looks like in QEMU
-# under a certain configuration.
+# Expands a given CPU model, @model, (or a combination of CPU model +
+# additional options) to different granularities, specified by
+# @type, allowing tooling to get an understanding what a specific
+# CPU model looks like in QEMU under a certain configuration.
 #
 # This interface can be used to query the "host" CPU model.
 #
@@ -269,7 +281,11 @@
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static". Arm only supports "full".
 #
-# Returns: a CpuModelExpansionInfo
+# @model: description of the CPU model to expand
+#
+# @type: expansion type, specifying how to expand the CPU model
+#
+# Returns: a CpuModelExpansionInfo describing the expanded CPU model
 #
 # Errors:
 #     - if expanding CPU models is not supported
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 9e28de1721..59fbe74b8c 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -84,9 +84,6 @@
         'XDbgBlockGraph',
         'YankInstanceType',
         'blockdev-reopen',
-        'query-cpu-model-baseline',
-        'query-cpu-model-comparison',
-        'query-cpu-model-expansion',
         'query-rocker',
         'query-rocker-ports' ],
     # Externally visible types whose member names may use uppercase
-- 
2.44.0



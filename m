Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55257C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMnc-000720-AP; Fri, 07 Feb 2025 06:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMnV-0006xU-Qw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:45:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMnS-0002np-R0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738928721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ENoGYkTNbqBLK2zaBqPU/eJreQoUDQV0ALFXe2C8cM=;
 b=QH3/Wi+Pt0ffdthzH9AD7JggXDjlTJNzzX97LSRe18HKG1EuczTVpBAnSD/bddN1E8PcNM
 bTOGsU4H1VmuLrFD+pYQBq0eFGh21YNxGevhu9bltruI872+9iFBJQMYS2r4Qfxul15lL6
 27HUdaahO50Rry+lqHgPGbQIs2P/BuY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-Tyb2n2KqPYCudO5RYl_3lA-1; Fri,
 07 Feb 2025 06:45:18 -0500
X-MC-Unique: Tyb2n2KqPYCudO5RYl_3lA-1
X-Mimecast-MFC-AGG-ID: Tyb2n2KqPYCudO5RYl_3lA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2B251956096; Fri,  7 Feb 2025 11:45:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88CA41800352; Fri,  7 Feb 2025 11:45:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFA8121E6A28; Fri, 07 Feb 2025 12:45:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 4/4] qapi: expose all schema features to code
In-Reply-To: <20250205123550.2754387-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 5 Feb 2025 12:35:50
 +0000")
References: <20250205123550.2754387-1-berrange@redhat.com>
 <20250205123550.2754387-5-berrange@redhat.com>
Date: Fri, 07 Feb 2025 12:45:13 +0100
Message-ID: <875xlmj7w6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This replaces use of the constants from the QapiSpecialFeatures
> enum, with constants from the auto-generate QapiFeatures enum
> in qapi-features.h
>
> The 'deprecated' and 'unstable' features still have a little bit of
> special handling, being force defined to be the 1st + 2nd features
> in the enum, regardless of whether they're used in the schema. This
> retains compatibility with common code that references the features
> via the QapiSpecialFeatures constants.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

John pointed out that isort wants the appended fixup.  Not thrilled
about the additional churn in the first hunk, but let's not fight our
tools.  Thanks, John!


diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
index be3e5d03ff..16ed26672b 100644
--- a/scripts/qapi/features.py
+++ b/scripts/qapi/features.py
@@ -11,10 +11,7 @@
=20
 from .common import c_enum_const, c_name
 from .gen import QAPISchemaMonolithicCVisitor
-from .schema import (
-    QAPISchema,
-    QAPISchemaFeature,
-)
+from .schema import QAPISchema, QAPISchemaFeature
=20
=20
 class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 2b9a2c0c02..324081b9fc 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -15,10 +15,10 @@
 from .common import must_match
 from .error import QAPIError
 from .events import gen_events
+from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
-from .features import gen_features
 from .visit import gen_visit
=20
=20



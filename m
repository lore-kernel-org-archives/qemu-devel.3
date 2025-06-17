Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A85C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 07:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRR4p-0004ef-Fl; Tue, 17 Jun 2025 03:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRR4k-0004e7-91
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRR4f-0003Id-Hp
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750146575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNDRYl9V+a4t5NQliCh4E39OKl/+9sxQi49k0cQATBY=;
 b=GHxAFp4E9wU7ukkidEOJQJE9ObletbrK+POiFVjUz5J4mOnVpwAkR7Caa1N8JhjzRGQspj
 OszPnllmNPbgVXKICAmRsji8OmTmeNXp/vKTBIDHCOJZpJnh4kiW3JchOmX95ZnUx8Et2r
 cFm3lby9Kp3RU0pLvpdnO+q+Jj1+xJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-sh23Fg8GP8q3BdyKXbI93Q-1; Tue,
 17 Jun 2025 03:49:31 -0400
X-MC-Unique: sh23Fg8GP8q3BdyKXbI93Q-1
X-Mimecast-MFC-AGG-ID: sh23Fg8GP8q3BdyKXbI93Q_1750146570
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7675F19560A5; Tue, 17 Jun 2025 07:49:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0144C1956094; Tue, 17 Jun 2025 07:49:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 323F521E6A27; Tue, 17 Jun 2025 09:49:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org,  mkletzan@redhat.com
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
In-Reply-To: <20250605101124.367270-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 5 Jun 2025 12:11:21 +0200")
References: <20250605101124.367270-1-pbonzini@redhat.com>
Date: Tue, 17 Jun 2025 09:49:27 +0200
Message-ID: <875xgu95a0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

pylint isn't happy with the new module:

************* Module qapi.rs_types
scripts/qapi/rs_types.py:286:4: W0237: Parameter 'branches' has been renamed to 'variants' in overriding 'QAPISchemaGenRsTypeVisitor.visit_object_type' method (arguments-renamed)
scripts/qapi/rs_types.py:307:4: W0237: Parameter 'alternatives' has been renamed to 'variants' in overriding 'QAPISchemaGenRsTypeVisitor.visit_alternate_type' method (arguments-renamed)
scripts/qapi/rs_types.py:316:67: W0613: Unused argument 'builtins' (unused-argument)
scripts/qapi/rs_types.py:9:0: W0611: Unused POINTER_SUFFIX imported from common (unused-import)
scripts/qapi/rs_types.py:10:0: W0611: Unused rs_ctype_parse imported from rs (unused-import)
scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaEnumType imported from schema (unused-import)
scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaType imported from schema (unused-import)


Might be too early to bother with the type hints, but here goes anyway:

$ mypy scripts/qapi-gen.py 
scripts/qapi/schema.py:70: error: Argument 1 to "rsgen_ifcond" has incompatible type "str | dict[str, object] | None"; expected "str | dict[str, Any]"  [arg-type]
scripts/qapi/rs.py:99: error: Incompatible types in assignment (expression has type "str | None", variable has type "dict[str, str]")  [assignment]
scripts/qapi/rs.py:103: error: Unsupported left operand type for + ("None")  [operator]
scripts/qapi/rs.py:103: note: Left operand is of type "str | None"
scripts/qapi/rs.py:103: error: Incompatible types in assignment (expression has type "str | Any", variable has type "dict[str, str]")  [assignment]
scripts/qapi/rs.py:106: error: Incompatible types in assignment (expression has type "str", variable has type "dict[str, str]")  [assignment]
scripts/qapi/rs.py:108: error: Incompatible types in assignment (expression has type "str", variable has type "dict[str, str]")  [assignment]
scripts/qapi/rs.py:110: error: Incompatible types in assignment (expression has type "str", variable has type "dict[str, str]")  [assignment]
scripts/qapi/rs.py:111: error: Incompatible return value type (got "dict[str, str]", expected "str")  [return-value]
scripts/qapi/rs_types.py:47: error: Item "None" of "QAPISchemaVariants | None" has no attribute "tag_member"  [union-attr]
scripts/qapi/rs_types.py:49: error: Item "None" of "QAPISchemaVariants | None" has no attribute "variants"  [union-attr]
scripts/qapi/rs_types.py:84: error: Item "None" of "QAPISchemaVariants | None" has no attribute "variants"  [union-attr]
scripts/qapi/rs_types.py:116: error: Incompatible default for argument "exclude" (default has type "None", argument has type "list[str]")  [assignment]
scripts/qapi/rs_types.py:116: note: PEP 484 prohibits implicit Optional. Accordingly, mypy has changed its default to no_implicit_optional=True
scripts/qapi/rs_types.py:116: note: Use https://github.com/hauntsaninja/no_implicit_optional to automatically upgrade your codebase
scripts/qapi/rs_types.py:118: error: Incompatible return value type (got "list[str]", expected "str")  [return-value]
scripts/qapi/rs_types.py:251: error: Item "None" of "QAPISchemaVariants | None" has no attribute "variants"  [union-attr]
scripts/qapi/rs_types.py:309: error: Argument 2 of "visit_alternate_type" is incompatible with supertype "QAPISchemaVisitor"; supertype defines the argument type as "QAPISourceInfo | None"  [override]
scripts/qapi/rs_types.py:309: note: This violates the Liskov substitution principle
scripts/qapi/rs_types.py:309: note: See https://mypy.readthedocs.io/en/stable/common_issues.html#incompatible-overrides
Found 15 errors in 3 files (checked 1 source file)



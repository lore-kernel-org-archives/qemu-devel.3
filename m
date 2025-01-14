Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AE7C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXcf6-0004bz-Co; Tue, 14 Jan 2025 03:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXcf5-0004bq-8W
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXcf3-00062A-M2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736844751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vrjnCQ0RGaqWeX/eiFLMoCRbUYhouV8haCbKeKpcXiA=;
 b=affRjcKfThwjSfIOKGNG6iqH75f9M5JOcapqGEjQBX5wtz6DjG/PvgR8mTH/iiHhCan/UX
 R4eVkSTVjLv9gPHsTf1zfeSBupJdpF8/OAy9gGb3IXB2Zcz8r0VOl56s9KTg30FhMZJysy
 n1ztdgVdOrYqSyQuyO6Qr2frvzOZyXQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-iv4cVBcPOLekmUZqILnXoQ-1; Tue,
 14 Jan 2025 03:52:28 -0500
X-MC-Unique: iv4cVBcPOLekmUZqILnXoQ-1
X-Mimecast-MFC-AGG-ID: iv4cVBcPOLekmUZqILnXoQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C54519560AF
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:52:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1166C19560AD
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:52:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE0C121E6924; Tue, 14 Jan 2025 09:52:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
In-Reply-To: <20250110104946.74960-2-victortoso@redhat.com> (Victor Toso's
 message of "Fri, 10 Jan 2025 11:49:39 +0100")
References: <20250110104946.74960-1-victortoso@redhat.com>
 <20250110104946.74960-2-victortoso@redhat.com>
Date: Tue, 14 Jan 2025 09:52:23 +0100
Message-ID: <878qrdkcag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
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

Victor Toso <victortoso@redhat.com> writes:

> This patch handles QAPI enum types and generates its equivalent in Go.
> We sort the output based on enum's type name.

Any particular reason for sorting?

The existing backends generate output it source order, on the (bold?)
assumption that developers care to pick an order that makes sense.

> Enums are being handled as strings in Golang.
>
> 1. For each QAPI enum, we will define a string type in Go to be the
>    assigned type of this specific enum.
>
> 2. Naming: CamelCase will be used in any identifier that we want to
>    export, which is everything.
>
> Example:
>
> qapi:
>   | ##
>   | # @DisplayProtocol:
>   | #
>   | # Display protocols which support changing password options.
>   | #
>   | # Since: 7.0
>   | ##
>   | { 'enum': 'DisplayProtocol',
>   |   'data': [ 'vnc', 'spice' ] }
>
> go:
>   | // Display protocols which support changing password options.
>   | //
>   | // Since: 7.0
>   | type DisplayProtocol string
>   |
>   | const (
>   | 	DisplayProtocolVnc   DisplayProtocol = "vnc"
>   | 	DisplayProtocolSpice DisplayProtocol = "spice"
>   | )
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 266 +++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py   |   3 +
>  2 files changed, 269 insertions(+)
>  create mode 100644 scripts/qapi/golang.py
>
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> new file mode 100644
> index 0000000000..1e04c99f1c
> --- /dev/null
> +++ b/scripts/qapi/golang.py

[...]

> +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):

[...]

> +    def write(self, output_dir: str) -> None:
> +        for module_name, content in self.target.items():
> +            go_module = module_name + "s.go"
> +            go_dir = "go"
> +            pathname = os.path.join(output_dir, go_dir, go_module)
> +            odir = os.path.dirname(pathname)
> +            os.makedirs(odir, exist_ok=True)
> +
> +            with open(pathname, "w", encoding="utf8") as outfile:
> +                outfile.write(content)

Your write() serves the same purpose as QAPIGen.write().  The latter
touches output files only when their contents actually changes.

Have you considered use of QAPIGen?

The backends generating C use QAPISchemaMonolithicCVisitor or
QAPISchemaModularCVisitor, which use QAPIGenC, QAPIGenH and
QAPIGenTrace, all specializations of QAPIGen.

> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..f1f813b466 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -15,6 +15,7 @@
>  from .common import must_match
>  from .error import QAPIError
>  from .events import gen_events
> +from .golang import gen_golang
>  from .introspect import gen_introspect
>  from .schema import QAPISchema
>  from .types import gen_types
> @@ -54,6 +55,8 @@ def generate(schema_file: str,
>      gen_events(schema, output_dir, prefix)
>      gen_introspect(schema, output_dir, prefix, unmask)
>  
> +    gen_golang(schema, output_dir, prefix)
> +
>  
>  def main() -> int:
>      """



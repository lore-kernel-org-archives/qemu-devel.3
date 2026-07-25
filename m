Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C37C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 06:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnVfN-0005qI-Uw; Sat, 25 Jul 2026 02:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnVfM-0005pR-1u
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 02:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnVfJ-0004nk-O1
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 02:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784960116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2I2zg7Ae0GUf/scpj+6ADfbcr/SEYXcN3uE3rIbpecQ=;
 b=Y+ug24B3mK4/xbiVHofDx8tOmyV8M2/VhSCsRvPxHc/xO3J0Hu1CKJPTmXMmMi3PESGu33
 vWaVYsagTog6YS9ssRqldALIkiuKxAo4Rdmyh0poOxrr8hm+xyX0pL1KD+U24rwzGuXJpc
 /6JR6GmJZPXuURaGJbc7bYh4dSkBYao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-IgV9ceqTMfaCGKIHveVlOQ-1; Sat,
 25 Jul 2026 02:15:14 -0400
X-MC-Unique: IgV9ceqTMfaCGKIHveVlOQ-1
X-Mimecast-MFC-AGG-ID: IgV9ceqTMfaCGKIHveVlOQ_1784960113
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A8AF1800260
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 06:15:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142A915B0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 06:15:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 899A521E6920; Sat, 25 Jul 2026 08:15:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
In-Reply-To: <20260724130044.1369843-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 24 Jul 2026 15:00:41 +0200")
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
Date: Sat, 25 Jul 2026 08:15:10 +0200
Message-ID: <87a4rf61e9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Prevent an all-zero struct from having different meanings with
> different configurations or builds of QEMU.

This is a bit terse.  What *exactly* is broken?  Spelling this out
matters, because it can expose holes in the argument, if any.  Let me
try.

The numeric encoding of enum values is irrelevant except for zero,
because we actually use numeric zero via zero initialization.  If the
enum's first value is conditional, the meaning of zero depends on build
configuration.  We don't want such a default at the external interface.
It could conceivably lead to purely internal bugs, too.

However, I'm not sure your solution fixes this problem completely.

Consider type Arg with a mandatory member @mand and an optional enum
member @opt, both of enum type ENUM_TYPE.

QMP input gets converted to native C like this:

    if (!visit_type_Arg(v, NULL, &arg, errp)) {
        return;
    }

For members present in the input, there is no zero initialization
problem.

@mand is always present, so arg.mand is whatever the user said.

If @opt is present, arg.has_opt is true and arg.opt is whatever the user
said.

If @opt is absent, then arg.has_opt and arg.opt are both zero.

Code providing an explicit default then is still fine:

    if (!arg.has_opt) {
        arg.opt = ENUM_TYPE_MUMBLE;
    }

But we often use arg.opt without checking arg.has_opt for brevity.  This
is an implicit default to zero, whatever zero may mean.

If the the optional enum's first member is conditional, this default
depends on build configuration.

Stupidest solution that could possibly work: an enum's first member
cannot be conditional.

Thoughts?

> This needs some changes to doc-good.json, which used unwittingly
> such an enum.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/schema.py                        |  8 ++++++++
>  tests/qapi-schema/doc-good.json               | 16 ++++++++--------
>  tests/qapi-schema/doc-good.out                | 12 ++++++------
>  tests/qapi-schema/doc-good.txt                |  8 ++++----
>  tests/qapi-schema/enum-if-first-required.err  |  2 ++
>  tests/qapi-schema/enum-if-first-required.json |  6 ++++++
>  tests/qapi-schema/enum-if-first-required.out  |  0
>  tests/qapi-schema/meson.build                 |  1 +
>  8 files changed, 35 insertions(+), 18 deletions(-)
>  create mode 100644 tests/qapi-schema/enum-if-first-required.err
>  create mode 100644 tests/qapi-schema/enum-if-first-required.json
>  create mode 100644 tests/qapi-schema/enum-if-first-required.out

Thanks for the negative test.

docs/devel/qapi-code-gen.rst section "Enumeration types" could perhaps
use an update.

It's less than clear even before the patch:

    The generated C enumeration constants have values 0, 1, ..., N-1 (in
    QAPI schema order), where N is the number of values.  There is an
    additional enumeration constant PREFIX__MAX with value N.

    Do not use string or an integer type when an enumeration type can do
    the job satisfactorily.

    The optional 'if' member specifies a conditional.  See `Configuring the
    schema`_ below for more on this.

The first paragraph can lead readers to assume we generate something
like

    typedef enum Example {
        EXAMPLE_FOO = 0,
    #if defined(COND)
        EXAMPLE_BAR = 1,
    #endif
        EXAMPLE__MAX = 2,
    } Example;

We don't, because we'd have to deal with a "hole" in the value range
when COND is not defined.

Instead, we do
        
    typedef enum Example {
        EXAMPLE_FOO,
    #if defined(COND)
        EXAMPLE_BAR,
    #endif
        EXAMPLE__MAX,
    } Example;



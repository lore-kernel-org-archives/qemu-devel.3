Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D37C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmbj-0003w4-MH; Tue, 16 Jul 2024 14:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTmbd-0003v4-EU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTmbb-0000qV-4d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0gY8URaC0Mwg1ffVjwFSWfNuCX7CpVNHVAGyVMnwk4=;
 b=IVtXsSh/FIgif8yR06hyAB3juVCXQ0ZH5VxKsAuVQ32QEKsPj8jEfhn0zZOf26rH1cUWcb
 2COY0fPeaX7YBRI23RR0+3a936tBBcOgYHP5Cb/yl+HRR8JwHEPTRjTAdPDUEcIIrvYd5p
 Qtyia0L8TkdvO6NHSL1TiN8Amu6KQqQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-rfDo3FzwPKCC5jEXn1YCKA-1; Tue,
 16 Jul 2024 14:08:47 -0400
X-MC-Unique: rfDo3FzwPKCC5jEXn1YCKA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54BDC1955D45; Tue, 16 Jul 2024 18:08:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BCC719560B2; Tue, 16 Jul 2024 18:08:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C214321E668B; Tue, 16 Jul 2024 20:08:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 04/14] qapi: add a 'command-features' pragma
In-Reply-To: <ZpD0k8taHT00jZpX@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Jul 2024 10:17:07 +0100")
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-5-berrange@redhat.com>
 <87r0bzuj7d.fsf@pond.sub.org> <ZpDlizzbaXk4pa0U@redhat.com>
 <87a5inuh75.fsf@pond.sub.org> <ZpD0k8taHT00jZpX@redhat.com>
Date: Tue, 16 Jul 2024 20:08:42 +0200
Message-ID: <87bk2xjjkl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sorry for the delay; too many distractions, and I needed a good think.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jul 12, 2024 at 10:50:54AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Jul 12, 2024 at 10:07:34AM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > The 'command-features' pragma allows for defining additional
>> >> > special features that are unique to a particular QAPI schema
>> >> > instance and its implementation.
>> >>=20
>> >> So far, we have special features (predefined, known to the generator =
and
>> >> treated specially), and normal features (user-defined, not known to t=
he
>> >> generator).  You create a new kind in between: user-defined, not known
>> >> to the generator, yet treated specially (I guess?).  Hmm.
>> >>=20
>> >> Could you at least hint at indented use here?  What special treatment=
 do
>> >> you have in mind?
>> >
>> > Essentially, these features are a way to attach metadata to commands t=
hat
>> > the server side impl can later query. This eliminates the need to hard=
code
>> > lists of commands, such as in QGA which hardcodes a list of commands w=
hich
>> > are safe to use when filesystems are frozen. This is illustrated later=
 in
>> > this series.
>>=20
>> Please update docs/devel/qapi-code-gen.rst section "Pragma directives",
>> and maybe section "Features".

Second thoughts; see below.

>> I'm not sure conflating the new kind of feature with existing special
>> features is a good idea.  I need to review more of the series before I
>> can make up my mind.
>
> I originally implemented a completely separate 'tags' concept in the
> QAPI parser, before deciding I was just re-inventing 'features' for
> no obvious benefit.
>
> The other nice thing about using features is that these are exposed
> in the schema and docs. With the 'fsfreeze' restriction in code,
> there's no formal docs of what commands are allowed when frozen, and
> this is also not exposed in QAPI schema to apps. Using 'features'
> we get all that as standard.

When you need to tack a mark to one or more things for whatever purpose
*and* expose it to QMP clients, then features make sense.  This is the
case here.

Initially, features were strictly an external interface annotation, and
were not meant to be used within QEMU.  All features were user-defined.

This changed when I created configurable policy for deprecated and
unstable management interfaces: the policy engine needs to check for
features 'deprecated' and 'unstable'.  Since the policy engine is partly
implemented in generated code, these two features need to be baked into
the generator.  This makes them special.

You need less than that: a predicate "does <command> have <feature>" for
certain features, ideally without baking them into the generator.

The command registry already tracks each command's special features for
use by the policy engine.  Obvious idea: also track the features you
want to pass to the predicate.

Your series adds tracking for exactly the features you need:

* Enumerate them in the schema with new pragma command-features

  Missing: documentation for the pragma.

* Generate an extension QapiSpecialFeatureCustom of existing enum
  QapiSpecialFeature, which is not generated.  The latter is in
  qapi/util.h, the former in ${prefix}qapi-init-commands.h.

* Mark these features special for commands only, so existing registry
  machinery tracks them.  Do *not* make them special elsewhere, because
  that would break things.

  Feels like a hack.  Minor trap: if you use the same feature in
  multiple schemas, multiple generated headers will define the same enum
  constant, possibly with different values.  If you manage to include
  the wrong header *and* the value differs there, you'll likely lose
  hair.

* Missing: tests.

I think we can avoid supplying most of the missing bits.  The main QAPI
schema uses five features: deprecated, unstable,
allow-write-only-overlay, dynamic-auto-read-only, fdset.  The QGA QAPI
schema uses four, namely the four you add in this series.  Why not track
all features, and dispense with the pragma?  Like this:

* Change type of feature bitsets to uint64_t (it's unsigned now).

* Error out if a schema has more than 64 features.

* Move enum QapiSpecialFeature into a new generated header.

* Generate a member for each feature, not just the two predefined ones.

* Pass all command features to the registry, not just the special ones.

* Recommended: do the same elsewhere, i.e. replace
  gen_special_features() by gen_features().

Thoughts?


PS: I think I spotted a number of additional minor issues in your
series, but I won't describe them here, as I hope the simplification
will make most of them go away.



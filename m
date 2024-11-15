Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718BD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 18:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC15q-0000ux-SB; Fri, 15 Nov 2024 13:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC15o-0000ud-Tn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC15m-0002zb-Pl
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731695449;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zN2HMhrUiwVnYYsbAyMXHer/+Vamz3bG96v2dvzBBk4=;
 b=OW1Ux1wgCTZPF2tyY4MMcyJERXdTLUhUFuzPLWKZC2HhDaGU0+lc06cElkuPuqoD9RQw9U
 GBNDSLE3UmyaXnqKhFydP5EZNyZl4uzmhKQ8NGSkZXK3QvlTXKokCniDVpXXbAmOSm4teU
 UERBLa+jY4eJPvU8D59jkjH9ku3cCkQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-YVKGBLZ1NFeo46WTloa5_g-1; Fri,
 15 Nov 2024 13:30:45 -0500
X-MC-Unique: YVKGBLZ1NFeo46WTloa5_g-1
X-Mimecast-MFC-AGG-ID: YVKGBLZ1NFeo46WTloa5_g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E1EB19560AE; Fri, 15 Nov 2024 18:30:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CE723003B71; Fri, 15 Nov 2024 18:30:40 +0000 (UTC)
Date: Fri, 15 Nov 2024 18:30:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 4/4] qapi: expose all schema features to code
Message-ID: <ZzeTTXDaZQWaOamC@redhat.com>
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-5-berrange@redhat.com>
 <87r07ec76r.fsf@pond.sub.org> <ZzX6MXYTh97lzWZh@redhat.com>
 <87o72h9bw7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o72h9bw7.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 15, 2024 at 08:47:20AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Nov 14, 2024 at 01:48:28PM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > This replaces use of the constants from the QapiSpecialFeatures
> >> > enum, with constants from the auto-generate QapiFeatures enum
> >> > in qapi-features.h
> >> >
> >> > The 'deprecated' and 'unstable' features still have a little bit of
> >> > special handling, being force defined to be the 1st + 2nd features
> >> > in the enum, regardless of whether they're used in the schema. This
> >> > retains compatibility with common code that references the features
> >> > via the QapiSpecialFeatures constants.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  meson.build              |  1 +
> >> >  scripts/qapi/commands.py |  1 +
> >> >  scripts/qapi/features.py | 62 ++++++++++++++++++++++++++++++++++++++++
> >> >  scripts/qapi/gen.py      |  4 +--
> >> >  scripts/qapi/main.py     |  2 ++
> >> >  scripts/qapi/schema.py   | 19 +++++++++++-
> >> >  scripts/qapi/types.py    |  6 ++--
> >> >  scripts/qapi/visit.py    |  3 +-
> >> >  8 files changed, 92 insertions(+), 6 deletions(-)
> >> >  create mode 100644 scripts/qapi/features.py

> >> I further guess you sort the non-special features just to make the
> >> generated code easier for humans to navigate.
> >> 
> >> Correct?
> >
> > The remaining sort was just to give a predictable stable output,
> > should QAPI usage of features be reordered.
> 
> We don't do that for enum QAPIEvent, and it hasn't inconvenienced us as
> far as I can tell.  No big deal, I just like consistency.

Sure, I'll removethe sorting

> >> pycodestyle gripes
> >> 
> >>     scripts/qapi/features.py:57:1: E302 expected 2 blank lines, found 1
> >> 
> >> This part generates a C enum.  It's similar to gen_enum() from types.py,
> >> except we work with a list of QAPISchemaFeature here, and a list of
> >> QAPISchemaEnumMember there.
> >> 
> >> To reuse gen_enum() here, we'd have to make up a member list, like we do
> >> in events.py for enum QAPIEvent.
> >
> > I'll have a look at that.
> 
> Reuse it only if it's easy for you.  We can always improve on top.

Using gen_enum will create the   enum <-> string conversion table,
and I'm not sure we need/want that for the special features ?


> >> We commonly use None as info value for built-in stuff, and that's why
> >> it's Optional[QAPISourceInfo], not just QAPISourceInfo.
> >
> > Yeah, not sure what I was thinking here, looking again I
> > should have passed "None"
> >
> >> But do we really need to make up some QAPISchemaFeature?  Hmm.  The
> >> appended patch dumbs down ._feature_dict to a set.
> 
> See below for a possible reason to keep .feature_dict.
> 
> > I was following the same pattern as self._entity_dict and
> > self._module_dict, rather than dumbing down to the bare
> > minimum needed by my current use case. I don't mind which
> > strategy we take.
> 
> .entity_dict maps the name to the one entity.  Likewise .module_dict.
> .feature_dict, however, maps it to the first of possibly many.  That's
> not wrong, just peculiar and possibly less than obvious to readers who
> aren't familiar with how we represent features internally.  Worth a
> comment?

I'll comment it.


> >> However, the reporting is less than nice:
> >> 
> >>     $ python scripts/qapi-gen.py -o $$ tests/qapi-schema/features-too-many.json 
> >>     Traceback (most recent call last):
> >>       File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
> >>         sys.exit(main.main())
> >>                  ^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/main.py", line 96, in main
> >>         generate(args.schema,
> >>       File "/work/armbru/qemu/scripts/qapi/main.py", line 51, in generate
> >>         schema = QAPISchema(schema_file)
> >>                  ^^^^^^^^^^^^^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1155, in __init__
> >>         self._def_exprs(exprs)
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1482, in _def_exprs
> >>         self._def_struct_type(expr)
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1377, in _def_struct_type
> >>         features = self._make_features(expr.get('features'), info)
> >>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1274, in _make_features
> >>         raise Exception("Maximum of 64 schema features is permitted")
> >>     Exception: Maximum of 64 schema features is permitted
> >
> > Is there any better way to approach this error reporting ?
> 
> Raise QAPISemError in .check().
> 
> Hmm, then you need a QAPISourceInfo to pass.  .feature_dict will give
> you one: the .info of the feature added last.

This also points out that I failed to add a test case for this
"too many features' scenario, which I'll fix too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



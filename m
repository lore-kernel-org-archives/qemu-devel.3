Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BA1CF5388
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 12:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3awc-0000Op-Pi; Wed, 23 Oct 2024 08:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3awZ-0000Oh-O6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 08:58:31 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3awX-0007Gl-6c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 08:58:31 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id ED0E1181536
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:56:10 +0200 (CEST)
Received: (qmail 6621 invoked by uid 990); 23 Oct 2024 12:56:10 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Wed, 23 Oct 2024 14:56:10 +0200
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 12:56:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Pierrick,

resent as I was too stupid to hit reply instead of reply-all.

October 22, 2024 at 11:15 PM, "Pierrick Bouvier" wrote:
>=20
>=20On 10/22/24 01:21, Julian Ganz wrote:
>=20
>=20>=20
>=20> Hi, Pierrick,
> >  October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
> >
> > >=20
>=20> >  Maybe we could have a single API like:
> > >=20
>=20> >  enum qemu_plugin_cf_event_type {
> > >  QEMU_PLUGIN_CF_INTERRUPT;
> > >  QEMU_PLUGIN_CF_TRAP;
> > >  QEMU_PLUGIN_CF_SEMIHOSTING;
> > >  };
> > >=20
>=20>  I have considered such an enum, as an input for the callback, as a
> >  parameter of the registration function, and both. Of course, if you =
were
> >  to add a selection parameter for the registration function, you like=
ly
> >  want OR-able flags.
> >  An additional input for the callback type would obviously require a =
new
> >  function type just for that callback. Since the callbacks are somewh=
at
> >  similar to the VCPU init, exit, resume, ... ones it felt appropriate
> >  to use the same function type for all of them.
> >=20
>=20I tend to disagree on that. IMHO, it's better to reduce number of API=
 entries instead of callback types.
> It's easy for a user to understand how to implement a given callback, w=
hile it's hard to understand which API you need for which thing.
>=20
>=20For the syscall cbs, we already have a specific callback. So why not =
here?

<snip>

> > As for the registration, it may make the registration a bit more
> >  convenient and maybe keep the API clutter a bit lower, but not by th=
at
> >  much.
> >=20
>=20It's ok for the user. But I think it's more complicated to extend, wh=
en we'll want to introduce control flow API in the future. Do we want 5 o=
r 6 different callbacks when people want to track fully control flow from=
 a plugin?

Ok, I'll introduce an enum and combine the three callbacks in the next
iteration then.

> > > typedef struct {
> > >  enum qemu_plugin_cf_event_type ev;
> > >  union {
> > >  data_for_interrupt interrupt;
> > >  data_for_trap trap;
> > >  data_for_semihosting semihosting;
> > >  } qemu_plugin_cf_event;
> > >  /* data_for_... could contain things like from/to addresses, inter=
rupt id, ... */
> > >=20
>=20>  I don't think this is a good idea.
> >  Traps are just too diverse, imo there is too little overlap between
> >  different architectures, with the sole exception maybe being the PC
> >  prior to the trap. "Interrupt id" sounds like a reasonably common
> >  concept, but then you would need to define a mapping for each and ev=
ery
> >  architecture. What integer type do you use? In RISC-V, for example,
> >  exceptions and interrupt "ids" are differentiated via the most
> >  significant bit. Dou keep that or do you zero it? And then there's
> >  ring/privilage mode, cause (sometimes for each mode), ...
> >=20
>=20I didn't want to open the per architecture pandora box :).
> I don't think the plugin API itself should deal with per architecture
> details like meaning of a given id. I was just thinking to push this "r=
aw" information to the plugin, that may/may not use architecture specific=
 knowledge to do its work. We already have plugins that have similar per =
architecture knowledge (contrib/plugins/howvec.c) and it's ok in some spe=
cific cases.

But how would such an interface look? The last PC aside, what would you
include, and how? A GArray with named items that are itself just opaque
blobs?

And what would be the benefit compared to just querying the respective
target specific registers through qemu_plugin_read_register? Which btw.
is what we were going to do for our use-case. Even the example you
brought up (howvec) uses querying functions and doesn't expect to get
all the info via parameters.

> But having something like from/to address seems useful to start. Even i=
f we don't provide it for all events yet, it's ok.

Yes, I certainly see the advantages of having either the last PC or the
would-be-next PC as they are sufficiently universal. You can usually
retrieve them from target-specific registers, but that may be more
complicated in practice. In the case of RISC-V for example, the value
of the EPC differs between interrupts and exceptions.

That PC value should also be easy enough to obtain at the hook call
sites. We only need to store the (old) PC before doing the setup. The
"to-address" is the current PC at the time the callback is invoked.
Anything else would be a bug. I was going to write that you can
already query that in a plugin through a dedicated helper function
but apparently I misremembered.

I'll include this in the next iteration.

> > It would also complicate call sites for hooks in target code. You'd
> >  either need awkwardly long function signitures or setup code for tha=
t
> >  struct. Both are things you don't want, as a hook call site should
> >  never distract from the actual logic surrounding them. You could
> >  probably have something reasonable in Rust, using a builder/command
> >  pattern. But in C this would require too much boiler plate code than
> >  I'd be comfortable with.
> >=20
>=20We can have one "builder" function per data type, with fixed paramete=
rs (no varargs), it's reasonable and would scale well with new entries/da=
ta information.

I'm still not on board on preparing a more complex data type. For the
next iteration I'd rather stick to a simple function receiving the
"type" of event and the PCs. That may not be extensible, but I don't see
any benefit in shoehorning inheritelntly target-specifc information into
a complex struct.

If this is a hard requirement, I'll of course still do so.

Regards,
Julian


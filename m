Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F3CD1CDB3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3A8x-0005sN-P7; Tue, 22 Oct 2024 04:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3A8v-0005sC-UH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:21:29 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3A8t-00087u-Rb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:21:29 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4563B18047B
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 10:21:23 +0200 (CEST)
Received: (qmail 31328 invoked by uid 990); 22 Oct 2024 08:21:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 22 Oct 2024 10:21:23 +0200
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 08:21:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
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

October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
> On 10/21/24 14:02, Julian Ganz wrote:
> >  The motivation for this API is a plugin that simulates a RISC-V trac=
ing
> >  unit (and produces a trace). For that we actually also needed to
> >  track the "regular" control flow, i.e. find out whether a branch was
> >  taken or where a jump went. That wasn't hard, especially considering
> >  that the TCG API already gives you (more or less) basic blocks. Stil=
l,
> >  we ended up tracing every instruction because that made some of the =
logic
> >  much simpler and easier to reason about.
> >  We realized that we need a trap API because they:
> >  * can occur at any time/point of execusion
> >  * usually come with additional effects such as mode changes.
> >=20
>=20Thanks for sharing your insights.
> I think there is definitely value in what you offer, and I'm trying to =
think how we could extend it in the future easily, without having another=
 callback when a new event appear. In my experience on plugins, the least=
 callbacks we have, and the simpler they are, the better it is.
>=20
>=20Maybe we could have a single API like:
>=20
>=20enum qemu_plugin_cf_event_type {
>  QEMU_PLUGIN_CF_INTERRUPT;
>  QEMU_PLUGIN_CF_TRAP;
>  QEMU_PLUGIN_CF_SEMIHOSTING;
> };

I have considered such an enum, as an input for the callback, as a
parameter of the registration function, and both. Of course, if you were
to add a selection parameter for the registration function, you likely
want OR-able flags.

An additional input for the callback type would obviously require a new
function type just for that callback. Since the callbacks are somewhat
similar to the VCPU init, exit, resume, ... ones it felt appropriate
to use the same function type for all of them.

As for the registration, it may make the registration a bit more
convenient and maybe keep the API clutter a bit lower, but not by that
much.


> /* Sum type, a.k.a. "Rust-like" enum */
> typedef struct {
>  enum qemu_plugin_cf_event_type ev;
>  union {
>  data_for_interrupt interrupt;
>  data_for_trap trap;
>  data_for_semihosting semihosting;
> } qemu_plugin_cf_event;
> /* data_for_... could contain things like from/to addresses, interrupt =
id, ... */

I don't think this is a good idea.

Traps are just too diverse, imo there is too little overlap between
different architectures, with the sole exception maybe being the PC
prior to the trap. "Interrupt id" sounds like a reasonably common
concept, but then you would need to define a mapping for each and every
architecture. What integer type do you use? In RISC-V, for example,
exceptions and interrupt "ids" are differentiated via the most
significant bit. Dou keep that or do you zero it? And then there's
ring/privilage mode, cause (sometimes for each mode), ...

It would also complicate call sites for hooks in target code. You'd
either need awkwardly long function signitures or setup code for that
struct. Both are things you don't want, as a hook call site should
never distract from the actual logic surrounding them. You could
probably have something reasonable in Rust, using a builder/command
pattern. But in C this would require too much boiler plate code than
I'd be comfortable with.

Regards,
Julian


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzAtG-0004Pi-Je; Tue, 23 Apr 2024 03:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzAtE-0004OV-CX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzAtB-00085G-RI
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713858508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcFnFRNCA2UoT6ioKE5kiWNgg0vpTc0lc2wAhN5RZ54=;
 b=YtqoaLWWVXptO/wzIUfUTrEBunSbtCyvGJuD1RMc40hgdrLX9fHE5LZvGOmt9JmsOPYGTN
 3OcQKbzFTzEfre1pgr6nkzSd386RviZAQAki5/G/bl/n4HB/fWvMcUdoug0Hvlg2SO5b3e
 ExCXvwbXTAUEE7uh3DQXqvJHiZpaW1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aqP5dhqNNVO2d6OpGmEeHg-1; Tue, 23 Apr 2024 03:48:24 -0400
X-MC-Unique: aqP5dhqNNVO2d6OpGmEeHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 879401005D7C;
 Tue, 23 Apr 2024 07:48:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FDE2112132A;
 Tue, 23 Apr 2024 07:48:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E74521E6811; Tue, 23 Apr 2024 09:48:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
In-Reply-To: <CAFn=p-YUceA2kx7OQJPxThRi5_w-V-N7YJY57T4paapcvBRUvw@mail.gmail.com>
 (John Snow's message of "Mon, 22 Apr 2024 21:56:13 -0400")
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 <87wmopg3ez.fsf@pond.sub.org>
 <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
 <CAFn=p-YUceA2kx7OQJPxThRi5_w-V-N7YJY57T4paapcvBRUvw@mail.gmail.com>
Date: Tue, 23 Apr 2024 09:48:23 +0200
Message-ID: <877cgoa5a0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Apr 22, 2024 at 12:38=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
>>
>> On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > John Snow <jsnow@redhat.com> writes:
>> >
>> > > On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> > >
>> > >> John Snow <jsnow@redhat.com> writes:
>> > >>
>> > >> > This series adds a new qapi-domain extension for Sphinx, which ad=
ds a
>> > >> > series of custom directives for documenting QAPI definitions.

[...]

>> > >> > Known issues / points of interest:

[...]

>> > >> > - Inlining all members means there is some ambiguity on what to d=
o with
>> > >> >   doc block sections on inlined entities; features and members ha=
ve an
>> > >> >   obvious home - body, since, and misc sections are not as obviou=
s on
>> > >> >   how to handle. This will feature more prominently in the genera=
tor
>> > >> >   series.
>> > >>
>> > >> Yes, this is a real problem.
>> > >>
>> > >> The member documentation gets written in the context of the type.  =
It
>> > >> may make sense only in that context.  Inlining copies it into a
>> > >> different context.
>> > >>
>> > >> Features may need to combine.  Say a command's arguments are a union
>> > >> type, and several branches of the union both contain deprecated mem=
bers.
>> > >> These branch types all document feature @deprecated.  Simply inlini=
ng
>> > >> their feature documentation results in feature @deprecated document=
ed
>> > >> several times.  Ugh.  Combining them would be better.  But how?  Do=
 we
>> > >> need to rethink how we document features?
>> > >
>> > > To be honest, I figured I'd plow ahead and then find the counter-exa=
mples
>> > > programmatically and decide what to do once I had my pile of edge ca=
ses.
>> > >
>> > > It might involve rewriting docs in some places, but I think the usab=
ility
>> > > win is completely worth the hassle.
>> > >
>> > > It's possible there might be some rework needed to maximize cogency =
of the
>> > > generated docs, but I think prioritizing a user-facing reference for=
 QMP is
>> > > the objectively correct end goal and I'm more than happy to work bac=
kwards
>> > > from that desired state.
>> >
>> > I'm not disputing the idea that documenting the arguments right with t=
he
>> > command is good.  I'm merely pointing out obstacles to pulling that of=
f.
>> >
>> > Adjusting existing documentation is only half the battle.  The other
>> > half is making sure documentation stays adjusted.  We may have to come
>> > up with new documentation rules, and ways to enforce them.
>>
>> For the sake of argument, let's say we forbid everything except
>> arg/features from definitions destined to be used as base/inherited
>> types. This would be very easy to enforce at the qapidoc level where
>> the doc inlining is performed by yelping when the base type contains
>> additional documentation sections.
>>
>> Now, in the real world, maybe sometimes those sections are useful and
>> we don't want to get rid of them, esp. because they may contain useful
>> documentation that we don't want to duplicate in the source files.
>>
>> My plan is to just forbid them at first and enumerate the cases where
>> they occur, then decide which ones are better off being moved
>> elsewhere or explicitly tolerated. The generator's tolerance can be
>> adjusted accordingly and we can formulate a rule for exactly how doc
>> blocks are combined and merged. I think it won't be a problem to
>> enforce it programmatically.
>>
>> I'll get back to you on how often and precisely where these cases
>> occur so you can take a look and see how you feel.
>>
>
> For a warmup, let's look at every unique instance of non-empty
> paragraph text on an object that is used as a base anywhere:
>
> Warning: AudiodevPerDirectionOptions - inlined paragraph
> Warning: BlockdevOptionsCurlBase - inlined paragraph
> Warning: BlockdevOptionsGenericCOWFormat - inlined paragraph
> Warning: BlockdevOptionsGenericFormat - inlined paragraph
> Warning: BlockExportOptionsNbdBase - inlined paragraph
> Warning: BlockNodeInfo - inlined paragraph
> Warning: ChardevCommon - inlined paragraph
> Warning: CpuInstanceProperties - inlined paragraph
> Warning: CryptodevBackendProperties - inlined paragraph
> Warning: EventLoopBaseProperties - inlined paragraph
> Warning: MemoryBackendProperties - inlined paragraph
> Warning: NetfilterProperties - inlined paragraph
> Warning: QCryptoBlockAmendOptionsLUKS - inlined paragraph
> Warning: QCryptoBlockCreateOptionsLUKS - inlined paragraph
> Warning: QCryptoBlockInfoBase - inlined paragraph
> Warning: QCryptoBlockOptionsBase - inlined paragraph
> Warning: QCryptoBlockOptionsLUKS - inlined paragraph
> Warning: RngProperties - inlined paragraph
> Warning: SecretCommonProperties - inlined paragraph
> Warning: SpiceBasicInfo - inlined paragraph
> Warning: TlsCredsProperties - inlined paragraph
> Warning: VncBasicInfo - inlined paragraph
>
> There's 22 instances.
>
> Let's look at what they say:
>
> AudiodevPerDirectionOptions: "General audio backend options that are
> used for both playback and recording."
> BlockdevOptionsCurlBase: "Driver specific block device options shared
> by all protocols supported by the curl backend."
> BlockdevOptionsGenericCOWFormat: "Driver specific block device options
> for image format that have no option besides their data source and an
> optional backing file."
> BlockdevOptionsGenericFormat: "Driver specific block device options
> for image format that have no option besides their data source."
> BlockExportOptionsNbdBase: "An NBD block export (common options shared
> between nbd-server-add and the NBD branch of block-export-add)."
> BlockNodeInfo: "Information about a QEMU image file"
> ChardevCommon: "Configuration shared across all chardev backends"
>
> CpuInstanceProperties:
> "List of properties to be used for hotplugging a CPU instance, it
> should be passed by management with device_add command when a CPU is
> being hotplugged.
>
> Which members are optional and which mandatory depends on the
> architecture and board.
>
> For s390x see :ref:`cpu-topology-s390x`.
>
> The ids other than the node-id specify the position of the CPU
> within the CPU topology (as defined by the machine property "smp",
> thus see also type @SMPConfiguration)"
>
> CryptodevBackendProperties: "Properties for cryptodev-backend and
> cryptodev-backend-builtin objects."
> EventLoopBaseProperties: "Common properties for event loops"
> MemoryBackendProperties: "Properties for objects of classes derived
> from memory-backend."
> NetfilterProperties: "Properties for objects of classes derived from netf=
ilter."
> QCryptoBlockAmendOptionsLUKS: "This struct defines the update
> parameters that activate/de-activate set of keyslots"
> QCryptoBlockCreateOptionsLUKS: "The options that apply to LUKS
> encryption format initialization"
> QCryptoBlockInfoBase: "The common information that applies to all full
> disk encryption formats"
> QCryptoBlockOptionsBase: "The common options that apply to all full
> disk encryption formats"
> QCryptoBlockOptionsLUKS: "The options that apply to LUKS encryption forma=
t"
> RngProperties: "Properties for objects of classes derived from rng."
> SecretCommonProperties: "Properties for objects of classes derived
> from secret-common."
> SpiceBasicInfo: "The basic information for SPICE network connection"
> TlsCredsProperties: "Properties for objects of classes derived from tls-c=
reds."
> VncBasicInfo: "The basic information for vnc network connection"
>
> ... Alright. So like 98% of the time, it's functionally useless
> information for the end-user. The only thing that looks mildly
> interesting is CpuInstanceProperties and *maybe*
> QCryptoBlockAmendOptionsLUKS.
>
> I propose we add a new section to QAPI doc blocks that gets ignored
> from rendered documentation, like "Comment:" -- to keep any info that
> might be mildly relevant to a developer that explains the *factoring*
> of the object, but won't be exposed in user-facing documents.

Two existing ways to add comments that don't go into generated
documentation:

1. Write a non-doc comment.

   ##
   # This is a doc comment.
   ##

   #
   # This isn't.
   #

2. TODO sections in a doc comment.

Not sure we need more ways, but if we do, we'll create them.

> On the occasion we DO want to inline documentation paragraphs, we can
> leave them in and have the doc generator inline them. There's probably
> very few cases where we actually want this.
>
> Let's take a look at any tagged sections now, excluding "Since":
>
> Warning: BackupCommon - inlined tag section Note
> Warning: CpuInstanceProperties - inlined, tag section Note
> Warning: MemoryBackendProperties - inlined tag section Note
>
> Not very many! Just three.
>
> BackupCommon:
>
> Note: @on-source-error and @on-target-error only affect background
>     I/O.  If an error occurs during a guest write request, the
>     device's rerror/werror actions will be used.
>
> BackupCommon is used as a base for DriveBackup and BlockdevBackup. In
> this case, this note probably does belong on both. It should be
> inlined and included.
>
> CpuInstanceProperties:
>
> Note: management should be prepared to pass through additional
>     properties with device_add.
>
> This is only used as a base with no other addon args for
> NumaCpuOptions, in turn only used for an argument. This is probably
> right to pass through, too. (Though I admit I don't really know what
> it means... we can discuss the doc *quality* another day.)

Oh boy, don't get me started!

> MemoryBackendProperties:
>
> Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same
>     time.  With reserve=3Dtrue, the behavior depends on the operating
>     system: for example, Linux will not reserve swap space for
>     shared file mappings -- "not applicable". In contrast,
>     reserve=3Dfalse will bail out if it cannot be configured
>     accordingly.
>
> This is used in MemoryBackendFileProperties,
> MemoryBackendMemfdProperties, and MemoryBackendEpcProperties. None are
> commands. I think the note here should also be inlined into each
> object.
>
> So, I think that:
>
> - Most naked paragraphs are usually useless to the end-user, and we
> should put them behind a Comment section to prevent them from being
> inlined.

We may want to delete them instead.

> - Any *other* paragraph or section should be included in the
> descendent. We'll just review with that eye going forward.

But where exactly does it go?

The question applies not just to tagged sections such as "Note:", but to
argument, member, and feature descriptions, too.

Our current answer for argument / member descriptions is "right after
the body section".  Works because we permit only the body section before
argument / member descriptions .  Pretty arbitrary restriction, though.

Fine print: can be a bit more complicated for unions, but let's ignore
that here.

I guess our current answer for feature descriptions is something like
"right after argument / member descriptions if they exist, else right
after the body section".

What could our answer be for other sections?

In my experience, the people writing the doc comments rarely check how
they come out in generated documentation.

The closer the doc comments are to the generated documentation, the
higher the chance it comes out as intended.

The more complex the inlining gets, the higher the chance of mishaps.

If cases of complex inlining are rare, we could sidestep complex
inlining by inlining manually.

If that's undesirable or impractical, we could require explicit
instructions where the inlined material should go.

I'm merely thinking aloud; these are certainly not requests, just ideas,
and possibly bad ones.

> - Since: ... we'll talk about later this week.

Yes.



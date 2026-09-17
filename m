Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B93C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x792U-0004Ru-G2; Thu, 17 Sep 2026 06:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x792G-0004Qd-1n; Thu, 17 Sep 2026 06:08:08 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x792C-0005gZ-CW; Thu, 17 Sep 2026 06:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hetzner.com
 ; s=lms2212;
 h=In-Reply-To:References:Subject:Cc:To:From:Message-Id:Date:
 Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
 Content-ID:Content-Description;
 bh=ZSH4tXJk0kNkja6Mkca/3O60Zq8yXzbOtEoYwWLk+j8=; b=eB8OeWMS1X6eLthGFt+cSCx8nU
 HiE42snU3Rp/u1anKP8ax7r8wuTBUGEH3NHSHozdscqePRCH/ACS0d6kc51qfe7Tzk6W+WhZJcT2L
 TdmeTtOWxkgyK5XrHaNAy3h1Vsvts3wFSVrXsybuAatvvnvmS2NMKCE3R/ye5nf0+7pIwpNqg6iFQ
 8i+FIC8edC14bkw67wHr7bYhNp4tRUseadWPW7tvURcSDZz+kkWrWinzwJD2LHWUkJusIzXwiFbXf
 LKlVR/O5Q7nGo0CVD34fKlRbdCc6048Gizti8Iq4PI/MzgXZWcIT3PUg8ma19rj5qU9D/BNPF/gdi
 Xg5eP4KA==;
Received: from [2a01:4f8:0:a105::1003] (helo=localhost)
 by mail.hetzner.company with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.94.2) (envelope-from <tim.foerster@hetzner.com>)
 id 1x7927-00ABFv-TA; Thu, 17 Sep 2026 12:07:59 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 12:07:59 +0200
Message-Id: <DLHIBIRKA3S9.28GZ5R5YTWZ8Y@hetzner.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Tim
 Foerster" <tim.foerster@hetzner.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 <qemu-devel@nongnu.org>, "Jason Wang" <jasowangio@gmail.com>, "Markus
 Armbruster" <armbru@redhat.com>,
 <qemu-devel-bounces+tim.foerster=hetzner.com@nongnu.org>
Subject: Re: QMP: exposing the host TAP interface name
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
 <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
 <aqukjSkXD5XycdN-@redhat.com> <DLHH5T6QJRIV.31TGLXHJZ22RY@hetzner.com>
 <aqu4CS7vmSt1pJSv@redhat.com>
In-Reply-To: <aqu4CS7vmSt1pJSv@redhat.com>
X-Authenticated-Sender: tim.foerster@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=tim.foerster@hetzner.com; helo=mail.hetzner.company
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Tim Foerster" <tim.foerster@hetzner.com>
From:  "Tim Foerster" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu Sep 17, 2026 at 11:51 AM CEST, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Sep 17, 2026 at 11:13:30AM +0200, Tim Foerster wrote:
>> On Thu Sep 17, 2026 at 10:27 AM CEST, Daniel P. Berrang=C3=A9 wrote:
>> > On Wed, Sep 16, 2026 at 05:18:05PM +0400, Marc-Andr=C3=A9 Lureau wrote=
:
>> >> Hi
>> >>=20
>> >> On Wed, Sep 16, 2026 at 10:22=E2=80=AFAM Tim Foerster via qemu develo=
pment
>> >> <qemu-devel@nongnu.org> wrote:
>> >> >
>> >> > Hi,
>> >> >
>> >> > I'd like to query the host TAP interface name of a network backend =
via QMP, especially when the TAP FD is passed to QEMU using SCM_RIGHTS
>> >> > and then assigned to a backend through fd=3D.
>> >> >
>> >> > In my current setup, retrieving this information externally require=
s CAP_SYS_PTRACE. This gives the management process far more access
>> >> > than needed and conflicts with the Landlock sandboxing I want to ap=
ply, due to Landlock's ptrace restrictions [1].
>> >> >
>> >> > QEMU already owns the FD, and tap_fd_get_ifname() can retrieve the =
name using TUNGETIFF on Linux. For a TAP passed through fd=3D, x-query-
>> >> > network currently reports the following (simplified):
>> >> >
>> >> > {
>> >> >   "name": "hostnet0",
>> >> >   "type": "tap",
>> >> >   "info-str": "fd=3D42"
>> >> > }
>> >> >
>> >> > I'd like to obtain the actual interface name in a structured field,=
 regardless of how the TAP was created or passed to QEMU. For example:
>> >> >
>> >> > {
>> >> >   "name": "hostnet0",
>> >> >   "type": "tap",
>> >> >   "info-str": "fd=3D42",
>> >> >   "data": {
>> >> >     "ifname": "vnet7"
>> >> >   }
>> >> > }
>> >> >
>> >> > Would extending x-query-network be the preferred approach? If so, w=
ould you prefer a dedicated ifname field or a type-specific data object
>> >> > selected by the existing type field?
>> >>=20
>> >> x- QMP commands are not meant for any other usage than debugging and
>> >> testing (in fact, we should probably exclude them in production
>> >> builds!). In particular, this command is currently only meant to be a
>> >> HMP "info network" substitute for test/debugging only atm.
>> >>=20
>> >> >
>> >> > Personally, I'd prefer an approach that is reasonably easy to backp=
ort downstream to older QEMU releases. Since x-query-network is
>> >> > relatively new, extending it would also require bringing that comma=
nd to releases which don't have it yet, potentially increasing the
>> >> > backporting effort.
>> >> >
>> >> > A type-specific data object could also accommodate additional TAP p=
roperties later, such as multiqueue mode or vnet_hdr. However, those
>> >> > are outside my current scope, I only need the interface name.
>> >>=20
>> >> I'd suggest a new query-network-tap(name: hostnet0) -> TAPInfo comman=
d
>> >> for your specific case. Eventually, later, NetworkClientInfo could
>> >> later embed that data.
>> >>=20
>> >> Let see what other people & maintainers think
>> >
>> > A minor nitpick about naming, on the command line and QMP command
>> > we use the term 'netdev' for the modern config approach, rather
>> > than "net" or "network" which is the original terminology prior
>> > to "netdev".
>> >
>> > On the general design though, IMHO, adding such narrow commands
>> > is not very desirable.
>> >
>> > On the input side we already have a data structure defined for
>> > the input arguments to 'netdev-add', namely "Netdev", which
>> > has fields for all the possible config options of all the
>> > backends via a discriminated union.
>> >
>> > In the case of TAP devices there are two scenarios - the low
>> > level backend represented in NetdevTapOptions, and the high
>> > level backend rerpesented in NetdevBridgeOptions.
>> >
>> > The NetdevTapOptions struct already includes a "ifname" field.v
>> > In the case of passing in an FD during 'netdev-add', 'fd' would
>> > be set, while 'ifname' would be left unset.
>> >
>> > It is reasonable to say, however, then upon querying the live
>> > NetdevTapOptions, *only* the "ifname" field ought to be present,
>> > either the orignal value from the user, or the derived value
>> > from calling tap_fd_get_ifname().=20
>> >
>> > IOW, what I'm saying is that if we want to query the live netdv
>> > backend config, we should have:
>> >
>> >    { 'command': 'query-netdevs', 'data': ['Netdev'] }
>> >
>> > as a formal QAPI model.
>> >
>> > Aside from the general plumbing work, two things to be aware of
>> >
>> >  * After creating the netdev initially, we throw away the
>> >    original "Netdev" struct data. We would need to preserve
>> >    that struct, so that we can later report it back with
>> >    query-netdevs. The TAP backend would also have to fill-in
>> >    the 'ifname' field when given an 'fd' initially.
>> >
>> >
>> >  * In theory someone could still be using '-net' instead
>> >    of '-netdev', where IIUC, we will have an "Netdev"
>> >    struct at any point.
>> >
>> >    The idealized thing todo is to fold "-net" onto "-netdev"
>> >    by making it synthesize a "Netdev" and then go through
>> >    the Netdev setup code path, but their semantics aren't a
>> >    perfect match which is why they're separate to begin
>> >    with. So ignore that idea.
>> >
>> >    The more practical thing to do is merely document that
>> >    'query-netdevs' only reports on backends created via
>> >    '-netdev' and thus declare '-net' compatibility entirely
>> >    out of scope.
>>=20
>> Hi Daniel,
>>=20
>> Thanks, the generic query-netdevs approach makes sense to me.
>>=20
>> One thing I'd like to clarify is the intended scope: should this expose
>> live backend details broadly for convenience, or focus on information
>> an external management process cannot obtain without additional privileg=
es?
>>
>> My original problem is the latter: reliably identifying the host TAP
>> interface associated with a qemu netdev currently requires
>> CAP_SYS_PTRACE in my setup. qemu already owns the FD and can obtain
>> the name directly.
>
> I see it as primarily reflecting the current configuration that
> QEMU runs with. That some of this information is dynamically
> updated "live" such that it solves your ifname use case, is an
> added benefit.
>
>
>> I'd be comfortable starting with the current TAP interface name for
>> both tap and bridge backends. I'd query it via TUNGETIFF even when
>> ifname was originally supplied, since the interface may have been
>> renamed on the host.
>
> Yes, refreshing the ifname name to cope wth renames sounds reasonable
>
>> Would that fit your intended scope? For bridge, would you prefer
>> extending NetdevBridgeOptions with ifname, or keeping such runtime
>> details in a separate query result type?
>
> I would extend NetdevBridgeOptions with ifname. Conceptually it
> would be reasonable for the user to set a desired ifname when
> requesting the bridge to begin with, but I'm not asking you to
> do that, unless you really want to go down the rabbit hole.
>

Alright, at least to me the scope seems quite clear. Not sure how the
process goes from here. Do we wait for feedback from the (other)
responsible maintainers, or is this low-hanging enough to move ahead?
My goal is to just submit this patch for now and ask for help later
(feel free to be harsh with your feedback, I think I can handle it),
if that's okay with you. :D

>
> With regards,
> Daniel




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A47C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 22:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woTg7-0000rh-L7; Mon, 27 Jul 2026 18:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woTg0-0000qj-9l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 18:20:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woTfx-0007F7-Df
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 18:20:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30A0A7C36D;
 Mon, 27 Jul 2026 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785190790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtSPMEA6xX8dmLSx+t37t1p+hWXwCUgxSNTCKZ5l4Oc=;
 b=euI6I9LdIhp4gok1O8X5SSM0Kwa5CeWnNMoladr0tbLWPOK3nQevMzFeZ32T9TstIrziuK
 HjLrGE5SkrK1MANGGU42vjJ6TSDoJZbL8WuAZqvqZo2uLRcuMWai6zpc2iuyg2saLWYmQf
 32aJL2NH5n62Qn+kFTI/5caOcJ2bZJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785190790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtSPMEA6xX8dmLSx+t37t1p+hWXwCUgxSNTCKZ5l4Oc=;
 b=U812iQFZ6w4AkAxPqgNqymEdzeXgmWsRlAQTY8CDJKMeC+pZeMuIpYs5uO/k9xuytxhn7Q
 N/c/LJfpd97aryCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785190786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtSPMEA6xX8dmLSx+t37t1p+hWXwCUgxSNTCKZ5l4Oc=;
 b=Ui4z6641+WYVQEMmV8bnsVB4nscbshNXRu2mAdi+jA9YUi90YcJVtxlEwynLe8GW16kBZj
 Y9RR58U8lTrUethISTQUWGC+34Kl2xbIPAzamsvGKoSUAf4ueX83uZuhNC52x6Gq8ob/48
 gCY/NfR76WkxejTUU/+kMCvnACKpFJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785190786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtSPMEA6xX8dmLSx+t37t1p+hWXwCUgxSNTCKZ5l4Oc=;
 b=5WWUAiJtUt+oIvsrbA9aKqbJaroMSBBTGrL3R1tokrGGdEJ2AqDZSSiy008/3xdqqawg2e
 YjAGWi1hNUc3meBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0394779B9;
 Mon, 27 Jul 2026 22:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MFgrJIHZZ2qofQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jul 2026 22:19:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
In-Reply-To: <20260727164036-mutt-send-email-mst@kernel.org>
References: <cover.1785101237.git.mst@redhat.com>
 <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
 <CADLectmKQT+hU_3TG2Popan8f5QphEEpwsR+Ps=+WTZo-Z_M_Q@mail.gmail.com>
 <20260727045220-mutt-send-email-mst@kernel.org>
 <amdT6P4esRDwyRX4@x1.local>
 <20260727150152-mutt-send-email-mst@kernel.org>
 <ame_w-nz7mPbKfOV@x1.local>
 <20260727164036-mutt-send-email-mst@kernel.org>
Date: Mon, 27 Jul 2026 19:19:43 -0300
Message-ID: <874ihkoz28.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Jul 27, 2026 at 04:29:55PM -0400, Peter Xu wrote:
>> On Mon, Jul 27, 2026 at 03:06:38PM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jul 27, 2026 at 08:49:44AM -0400, Peter Xu wrote:
>> > > On Mon, Jul 27, 2026 at 04:53:15AM -0400, Michael S. Tsirkin wrote:
>> > > > On Sun, Jul 26, 2026 at 08:31:57PM -0400, Peter Xu wrote:
>> > > > > This patch is migration only change and hasn't been reviewed.=C2=
=A0 Give us a few
>> > > > > days to review it?
>> > > > > Can't do it now because it is on cellphone and I just bathed my =
son.
>> > > > >=20
>> > > > > Please hold off merging.
>> > > > >=20
>> > > > > Thanks.
>> > > >=20
>> > > > OK.  I'll drop this and you will merge it through the migration tr=
ee
>> > > > as appropriate?
>> > >=20
>> > > Let's drop it first so it won't block this pull.  I can definitely p=
ick it
>> > > up when ready, but I want to discuss on how to fix first.  Which tre=
e to
>> > > pick it up isn't a huge matter to me, but the review.
>> > >=20
>> > > We found a bunch of randomly introduced VMSTATE flags in the past, I=
 used
>> > > to remove some, at least my plan is in the future each time we intro=
duce a
>> > > new one (by request from other modules) we better justify it before =
landing
>> > > too easily, in case it needs a revert again.
>> > >=20
>> > > This vhost regression started 11.0 so IIUC we don't need to rush in =
11.1.
>> > > I just noticed I read that patch and didn't notice this, my bad to n=
ot have
>> > > noticed..
>> > >=20
>> > > For this one specifically..
>> > >=20
>> > > >=20
>> > > > > On Sun, Jul 26, 2026, 5:29=E2=80=AFp.m. Michael S. Tsirkin <mst@=
redhat.com> wrote:
>> > > > >=20
>> > > > >     vhost user currently saves the inflight buffer to the migrat=
ion stream
>> > > > >     using VMSTATE_VBUFFER_UINT64. The size is controlled by the =
vhost-user
>> > > > >     backend.
>> > > > >=20
>> > > > >     But the implementation of that is broken if size is >2G: it =
stores the
>> > > > >     buffer size in a uint64_t field, but vmstate_size() always r=
eads the
>> > > > >     size field as int32_t regardless of the macro used. This, in=
 turn,
>> > > > >     causes negative or truncated lengths on load, leading to und=
ersized
>> > > > >     allocations and down the road out-of-bounds buffer access.
>> > > > >=20
>> > > > >     There's no practical reason to support such large sizes, so =
it's enough
>> > >=20
>> > > If there's no real demand to use 2G or more, I suggest we change siz=
e to
>> > > int32_t instead on the user, and revert f6fdd8b2 VMSTATE_VBUFFER_UIN=
T64().
>> >=20
>> > We can't just change it we'll need some tricks to avoid breaking exist=
ing
>> > migration format. I don't see how it will be much simpler if you take
>> > that into account.
>>=20
>> It's not part of the stream, right?
>
> I think it is?
>
> VMSTATE_UINT64(size, struct vhost_inflight) at hw/virtio/vhost.c
> eventually leads to qemu_put_be64s / qemu_get_be64s in migration/vmstate-=
types.c
>

The point is that this "size" is already included on the stream by
itself, changing the VMSTATE_VBUFFER_UINT64 to int32 doesn't affect
it.

There's a type_check that will complain during save that
type(inflight->size) !=3D INT32 (from the macro), but we can change that.

#define vmstate_offset_value(_state, _field, _type)                  \
    (offsetof(_state, _field) +                                      \
     type_check(_type, typeof_field(_state, _field)))


>> Here IIUC the VMSD field "size" only hard-coded the binary offset to fet=
ch
>> the int32_t from the object* pointer.  IIUC we can simply change it to
>> int32_t and IIUC it will be able to recv stream from src with uint64_t.
>> The stream shouldn't be affected when e.g. we migrate from an older QEMU.
>
>
> I don't really know what you mean. Yes vmsd macros tie migration stream
> and the storage format. it kinda makes it easy to add one but the
> cost is issues like this.
>
>
>
>
>> >=20
>> > > Fabiano and I were looking at rest 20+ possible security related bug=
s in
>> > > the past 1-2 weeks, I've some patches to be posted for 11.2 too when=
 we
>> > > went through all of them. One relevant patch I haven't sent but will=
 do
>> > > soon:
>> > >=20
>> > > https://gitlab.com/peterx/qemu/-/commit/afd2cb25defdf78a4ab5279cc166=
34884792c57a
>> > >=20
>> > > We encountered quite a few of possible over-allocation on destionati=
on side
>> > > by manipulating on-wire length field like this one, I believe Fabian=
o is
>> > > looking at how to further limit that from 2G if ever possible per-us=
er.
>> > >=20
>> > > I'm not sure if that idea will fly, but I think anything bigger than=
 2G
>> > > definitely is not suggested for now when it's only for a type match =
not
>> > > real demand..
>> >=20
>> > Frankly 2G is crazy too. I see little reason to focus specifically on =
>2G.
>>=20
>> Yeah..
>>=20
>> >=20
>> >=20
>> > > I believe VMSTATE_VBUFFER_UINT32 is problematic on its own too, I'll=
 see
>> > > how to fix that.  That one is slightly easier, worst case is we bail=
 out
>> > > for 2G (hence ignore bit 31, which shouldn't be used in reality for =
legit
>> > > users), but I'll think about it.
>> > >=20
>> > > Thanks,
>> >=20
>> > I just do not see (almost) any case where migration destination
>> > does not know the actual size needed, or at least
>> > an upper bound on such.
>>=20
>> In many cases we transfer the length first then the array following that
>> with the length.  That's a common trick we played like vhost here.
>
> we need to start specifying the cap for these.
>

I agree. Most things will have a sane cap once you think hard enough. Of
course, there's a risk of selecting a limit too low, but currently we
can't even do that.

I think the first step is defining new macros so that every len/size/etc
gets properly identified. The VMSTATE_VBUFFER_* are already a start, we
can add an aditional member that doesn't go on the stream and check
against it when loading.

> The upper bound is indeed a challenge, I confess I don't know an answer,
> and we will need to be careful on adding anything that might break a legit
> user.  I believe Fabiano might have some better clue there, so I'd leave =
it
> to him until I can read his patches.
>=20

I'm also trying to look ahead into how we'll apply whatever fix we come
up with here to the pile of unstructured qemu_put|get_byte we have all
over the place. I'm experimenting with how much code we can convert into
VMStateDescription/VMStateField. The QEMU_VM_* flags themselves seem to
be easy to do (then we version the vmstate, deprecate, etc).=20

>> Thanks,
>>=20
>> >=20
>> >=20
>> > > > >     to validate: read the field as uint64_t when VMS_VBUFFER_UIN=
T64 is set,
>> > > > >     reject negative or oversized values, and propagate errors to
>> > > > >     vmstate_load_vmsd().
>> > > > >=20
>> > > > >     Note: the large value is coming from the backend, not guest,=
 so this
>> > > > >     shouldn't be considered a security issue. The CVE was assign=
ed before
>> > > > >     the qemu security policy was updated to exclude this class o=
f bugs.
>> > > > >=20
>> > > > >     Fixes: CVE-2026-6426
>> > > > >     Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT6=
4")
>> > > > >     Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> > > > >     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/=
3675
>> > > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > > >     Message-ID: <
>> > > > >     801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@=
redhat.com>
>> > > > >     ---
>> > > > >     =C2=A0include/migration/vmstate.h |=C2=A0 5 ++++-
>> > > > >     =C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 31 ++++++++++++++++++++++++++++---
>> > > > >     =C2=A02 files changed, 32 insertions(+), 4 deletions(-)
>> > > > >=20
>> > > > >     diff --git a/include/migration/vmstate.h b/include/migration=
/vmstate.h
>> > > > >     index 1b7f295417..e7095cd977 100644
>> > > > >     --- a/include/migration/vmstate.h
>> > > > >     +++ b/include/migration/vmstate.h
>> > > > >     @@ -168,6 +168,9 @@ enum VMStateFlags {
>> > > > >     =C2=A0 =C2=A0 =C2=A0 */
>> > > > >     =C2=A0 =C2=A0 =C2=A0VMS_ARRAY_OF_POINTER_AUTO_ALLOC =3D 0x10=
000,
>> > > > >=20
>> > > > >     +=C2=A0 =C2=A0 /* Use a uint64_t size field for VMS_VBUFFER =
instead of int32_t. */
>> > > > >     +=C2=A0 =C2=A0 VMS_VBUFFER_UINT64=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x40000,
>> > > > >     +
>> > > > >     =C2=A0 =C2=A0 =C2=A0/* Marker for end of list */
>> > > > >     =C2=A0 =C2=A0 =C2=A0VMS_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x20000,
>> > > > >     =C2=A0};
>> > > > >     @@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_=
byte_array;
>> > > > >     =C2=A0 =C2=A0 =C2=A0.field_exists =3D (_test),=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> > > > >     =C2=A0 =C2=A0 =C2=A0.size_offset=C2=A0 =3D vmstate_offset_va=
lue(_state, _field_size, uint64_t),\
>> > > > >     =C2=A0 =C2=A0 =C2=A0.info=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &vmstate_info_buffer,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> > > > >     -=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D VMS_VBU=
FFER | VMS_POINTER,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> > > > >     +=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D VMS_VBU=
FFER | VMS_VBUFFER_UINT64 | VMS_POINTER,=C2=A0 \
>> > > > >     =C2=A0 =C2=A0 =C2=A0.offset=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D of=
fsetof(_state, _field),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> > > > >     =C2=A0}
>> > > > >=20
>> > > > >     diff --git a/migration/vmstate.c b/migration/vmstate.c
>> > > > >     index 50ebe37845..d7f03a9f5b 100644
>> > > > >     --- a/migration/vmstate.c
>> > > > >     +++ b/migration/vmstate.c
>> > > > >     @@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, =
const
>> > > > >     VMStateField *field)
>> > > > >     =C2=A0 =C2=A0 =C2=A0int size;
>> > > > >=20
>> > > > >     =C2=A0 =C2=A0 =C2=A0if (field->flags & VMS_VBUFFER) {
>> > > > >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D *(int32_t *)(opaque + =
field->size_offset);
>> > > > >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field->flags & VMS_MULTIPLY=
) {
>> > > > >     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size *=3D field->=
size;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t usize64;
>> > > > >     +
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field->flags & VMS_VBUFFER_=
UINT64) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 =3D *(uin=
t64_t *)(opaque + field->size_offset);
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t ssize32 =
=3D *(int32_t *)(opaque + field->size_offset);
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ssize32 < 0) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn -1;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 =3D ssize=
32;
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (field->flags & VMS_MULTIPLY=
) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usize64 *=3D fiel=
d->size;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usize64 > INT_MAX) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D usize64;
>> > > > >     =C2=A0 =C2=A0 =C2=A0} else if (field->flags & VMS_ARRAY_OF_P=
OINTER) {
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For an array of pointer=
, the each element is always size of a
>> > > > >     @@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, con=
st
>> > > > >     VMStateDescription *vmsd,
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *first_=
elem =3D opaque + field->offset;
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, n_ele=
ms =3D vmstate_n_elems(opaque, field);
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size =3D=
 vmstate_size(opaque, field);
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size < 0) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
or_setg(errp, "VMState field '%s': invalid size",
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field->name);
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn false;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >=20
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_hand=
le_alloc(first_elem, field, opaque);
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (field->f=
lags & VMS_POINTER) {
>> > > > >     @@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFil=
e *f, const
>> > > > >     VMStateDescription *vmsd,
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_dyn=
amic_array =3D
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
>> > > > >=20
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size < 0) {
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
or_setg(errp, "VMState field '%s': invalid size",
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field->name);
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =
=3D false;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 got=
o out;
>> > > > >     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstat=
e_save_state_loop(vmsd->name, field->name,
>> > > > >     n_elems);
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (field->f=
lags & VMS_POINTER) {
>> > > > >     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0first_elem =3D *(void **)first_elem;
>> > > > >     --
>> > > > >     MST
>> > > > >=20
>> > > > >=20
>> > > >=20
>> > >=20
>> > > --=20
>> > > Peter Xu
>> >=20
>>=20
>> --=20
>> Peter Xu


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B5BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Yj-00026r-8b; Tue, 07 Jul 2026 04:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh1Yi-00026e-2s
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh1Yg-0008Oq-45
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783414417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhNGQCm+o+d8ZWjqwWJYztnN576BWNu+O5IMRZSq/YM=;
 b=eka5E810wHwESDPTVDOlom4HU6XhOzAcqFnBLg5jih1Ildo3Ir4pD+0uOvE+1w6nGwxUmJ
 ME/fcbsiYruXXPKEmlg0M7CBAcgoSrtEY363tBWR8tc7M4gGG5tHs5Gp8xdRrYnwbN1EG9
 icXlbYJ3IOeNYRGclDuyYfM5KLYCFas=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-R8o8GEvEOzecx8WwED5HvQ-1; Tue,
 07 Jul 2026 04:53:33 -0400
X-MC-Unique: R8o8GEvEOzecx8WwED5HvQ-1
X-Mimecast-MFC-AGG-ID: R8o8GEvEOzecx8WwED5HvQ_1783414413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B37101954AEC; Tue,  7 Jul 2026 08:53:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEB1A1800678; Tue,  7 Jul 2026 08:53:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 597F821E6920; Tue, 07 Jul 2026 10:53:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Roland Clobus <rclobus@rclobus.nl>,  Markus Armbruster
 <armbru@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-gpu: Support the configurable EDID fields
In-Reply-To: <CAJ+F1C+9qTAO0ZLDypPhMdFdcxBc9a2sB87xRugCuuWP9qb4JA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 29 Jun 2026
 23:29:38 +0400")
References: <20260623163535.366104-2-rclobus@rclobus.nl>
 <CAJ+F1C+3RF9q3HMntDFeNj+WPv0whPi8-6Uj-_mwKEfDriBq+A@mail.gmail.com>
 <0ae2e095-9fa2-4322-962d-3e7ad20367e2@rclobus.nl>
 <CAJ+F1C+9qTAO0ZLDypPhMdFdcxBc9a2sB87xRugCuuWP9qb4JA@mail.gmail.com>
Date: Tue, 07 Jul 2026 10:53:29 +0200
Message-ID: <87echfgoza.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Jun 29, 2026 at 7:20=E2=80=AFPM Roland Clobus <rclobus@rclobus.nl=
> wrote:
>>
>> Hello Marc-Andr=C3=A9,
>>
>> Thank you for the review. I will prepare changes based on the suggestion=
s in your next answer.
>>
>> On 29/06/2026 13:14, Marc-Andr=C3=A9 Lureau wrote:
>> > On Tue, Jun 23, 2026 at 8:38=E2=80=AFPM Roland Clobus <rclobus@rclobus=
.nl> wrote:
>> >>
>> >> This patch adds support for the fields that are currently configurable
>> >> in the function qemu_edid_generate.
>> >>
>> >> Signed-off-by: Roland Clobus <rclobus@rclobus.nl>

[...]

>> >> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> >> index 1fc4e38a44..e1cd5864fe 100644
>> >> --- a/qapi/virtio.json
>> >> +++ b/qapi/virtio.json
>> >> @@ -952,24 +952,54 @@
>> >>   ##
>> >>   # @VirtIOGPUOutput:
>> >>   #
>> >> -# Describes configuration of a VirtIO GPU output.  If both @xres and
>> >> -# @yres are set, they take precedence over root virtio-gpu resolution
>> >> -# configuration and enable the corresponding output.  If none of @xr=
es
>> >> -# and @yres are set, root virtio-gpu resolution configuration takes
>> >> -# precedence and only the first output is enabled.  Only setting one
>> >> -# of @xres or @yres is an error.
>> >> +# Describes configuration of a VirtIO GPU output.  Matches the fields
>> >> +# of struct @qemu_edid_info.

Blank lines between paragraphs, so they get actually rendered as
separate paragraphs.

If VirtIOGPUOutput matches qemu_edid_info, could it *replace*
qemu_edid_info?

>> >> +# If both @xres and @yres are set, they take precedence over root
>> >> +# virtio-gpu resolution configuration and enable the corresponding
>> >> +# output.  If none of @xres and @yres are set, root
>> >> +# virtio-gpu resolution configuration takes precedence and only the
>> >> +# first output is enabled.  Only setting one of @xres or @yres is
>> >> +# an error.
>> >> +#
>> >> +# @vendor: a 3 letter code for the vendor (since xx.x TODO)
>> >>   #
>> >
>> > It should be uppercase. Validation is missing in qemu_edid_generate() =
too
>>
>> Agreed. The code does (ch - '@') & 0x1f), so even lowercase will work.
>>
>> I've focussed on adding the missing fields that are consumed by qemu_edi=
d_generate, irrespective whether they were validated or not.
>> I can widen the scope of this change request, to add the missing verific=
ation of these fields.
>
> thanks
>
>>
>> > We should also document the default values
>>
>> I can duplicate the default values from qemu_edid_generate. Should there=
 be a comment in both files which recommends to keep both in sync?
>
> a comment in the source code could help, but in general any documented
> default value as a counterpart in the code

QAPI schema doc comments become the "QEMU QMP Reference Manual",
documenting the external QMP interface.  Defaults should be documented,
since they are part of the interface.

Some types there aren't used only for QOM properties, which the QMP
schema doesn't cover.  They end up in the manual anyway, just not
properly connected to commands.  Defaults should be documented
regardless.

Some could be used only for other purposes, but that doesn't concern us
here.

>> >>   # @name: the name of the output
>>
>> Historically name was the first field in the struct VirtIOGPUOutput. Sin=
ce the scope of this change request is widening, can it now become an optio=
nal field, given that every other field can be changed independently?
>>
>
> I think this is backward compatible, so yes
>
>> >>   #
>> >> +# @serial: the serial number (since xx.x TODO)
>> >> +#          must be numerical
>> >
>> > Then why do we accept a string? We should also fix qemu_edid_info then
>>
>> I was also wondering about that (but I tried not to touch the existing c=
ode too much). By using uint32, it will never change its data type (and the=
re will be no need for atoi in the generator code).
>>
>
> ok

Using strings for numbers is heavily frowned upon in the QAPI schema.

>> >> +#
>> >> +# @widthmm: width of the display in mm (since xx.x TODO)
>> >> +#           If @widthmm is set, @heightmm must be set too
>> >> +#
>> >> +# @heightmm: height of the display in mm (since xx.x TODO)
>> >> +#           If @heightmm is set, @widthmm must be set too

Please separate words with dashes in member names: width-mm, height-mm.

We don't normally put the unit in the member name.  E.g.

    ##
    # @ChardevVC:
    #
    # Configuration info for virtual console chardevs.
    #
    # @width: console width, in pixels
    #
    # @height: console height, in pixels
    #
    # @cols: console width, in chars
    #
    # @rows: console height, in chars

Perhaps an argument could be made that it's helpful here, because
millimeters is unusual.

>> > Setting one without the other would be weird. Maybe we should have a
>> > struct with both fields mandatory?

This way, the constraint "set both or none" is expressed syntactically,
which is desirable.  However, we have quite a few coordinate pairs
elsewhere, so this introduces inconsistency, which is undesirable.  Hmm.

>> That would make the JSON to set the values slightly more complex, but do=
able. (I'm also working on a patch that does so, but that needs more work, =
and would be independent of this change request)
>> But xres/yres will be an (the only?) exception to having a mandatory pai=
r.
>
> we can keep xres/yres for compatibility, but mark them as deprecated?
>
>> >> +#
>> >>   # @xres: horizontal resolution of the output in pixels (since 11.0)
>> >>   #
>> >>   # @yres: vertical resolution of the output in pixels (since 11.0)
>> >
>> > Same, but pre-existing.
>>
>> But here the situation is slightly more complex. If at least one of the =
pair xres,yres is set to zero, the display is considered inactive. So it wo=
uld be legal to only set one of them to zero or non-zero to turn the displa=
y off or on (enabled_output_bitmask)
>
> we could still mandate both xres/yres to be set in the new struct
>
>>
>> I have a local patch in preparation to allow modifications, but that nee=
ds some more work. It is not a blocker for this change request.
>> If that patch is ready, one can modify all fields of this struct on-the-=
fly, simulating the (dis)connect of a new display to the VM.
>>
>> FYI that would eventually allow something similar to:
>> ```
>> qom-set -j /machine/peripheral/vga001 outputs [ { "yres": 768, "name": "=
AAA", "widthmm": 40, "serial": "42", "heightmm": 30, "vendor": "IVM", "xmax=
": 2048, "ymax": 1536, "refreshrate": 50000, "xres": 1024 }, { "yres": 768,=
 "name": "DDD", "widthmm": 1000, "serial": "43", "heightmm": 750, "vendor":=
 "RHT", "xmax": 1024, "ymax": 768, "refreshrate": 60000, "xres": 0 } ]
>> ```
>>
>> But that's not in scope for this change request, where setting the width=
mm/heightmm values will be able to trigger HiDPI scenarios.
>>
>
> I see, well you could make this part of the same series imho
>
>> >>   #
>> >> +# @xmax: maximum horizontal resolution of the output in pixels
>> >> +#        (since xx.x TODO)
>> >> +#
>> >> +# @ymax: maximum vertical resolution of the output in pixels
>> >> +#        (since xx.x TODO)
>> >
>> > Same
>>
>> If you prefer a struct of two elements, the names for the value-pair-str=
uct could become: `resolution`, `maxresolution`, `sizemm`. Please say your =
preference.
>
> wdyt Markus?

Pros and cons, hard to decide.

What are the existing coordinate pairs?

>> >> +#
>> >> +# @refreshrate: refreshrate in mHz (since xx.x TODO)
>> >> +#
>> >>   # Since: 10.1
>> >>   ##
>> >>
>> >>   { 'struct': 'VirtIOGPUOutput',
>> >> -  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>> >> +  'data': { '*vendor': 'str',
>> >> +            'name': 'str',
>> >> +            '*serial': 'str',
>> >> +            '*widthmm': 'uint16',
>> >> +            '*heightmm': 'uint16',
>> >> +            '*xres': 'uint32',
>> >> +            '*yres': 'uint32',
>> >> +            '*xmax': 'uint32',
>> >> +            '*ymax': 'uint32'
>> >
>> > It changes the existing xres/yres fields type.
>> > Is it necessary to accept uint32?
>>
>> g->req_state[0].width (and height) are uint32_t in virtio_gpu_requested_=
state, and passed along in the generator code as uint32_t, so I updated the=
 struct to match that.
>>
>> But in the end only 16 bits are used in qemu_displayid_generate (`stw_le=
_p(did + 12, 0xffff & (xres - 1));`)
>
> I think we should stay u16, if that's what EDID is limited to

The choice doesn't affect the external  interface.

Changing integer types in the QAPI schema is invisible externally as
long as the set of accepted values remains the same.

>> >> +            '*refreshrate': 'uint32' } }
>> >>
>> >>   ##
>> >>   # @DummyVirtioForceArrays:
>> >> --
>> >> 2.53.0
>>
>
> thanks



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4510BCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVPT-0002tF-U5; Tue, 16 Sep 2025 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyVPG-0002o4-CC
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyVPC-0005Qa-Cf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758028050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OFRJGRY2omarrlZ0FW+w2RUI60hO9WGSthtqLUJYU4=;
 b=c1XJEZrh2dvOt5QiUEKKYxCU+AX5qn9y7F5KraX+0HDkH42509J6TnTkpFqKVHBebEbpTf
 EQL2SjIdwrKTnrNq1mgQiPL/afw9eW+uufGo1YalzVdt6curq4D4yzPqxJV/JOSHlDMD4d
 GsCloIMnYd+uVgdT0lTFJjV+oCvysK8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-NBQZHE5OMkSP8lD4uTSKaA-1; Tue,
 16 Sep 2025 09:07:27 -0400
X-MC-Unique: NBQZHE5OMkSP8lD4uTSKaA-1
X-Mimecast-MFC-AGG-ID: NBQZHE5OMkSP8lD4uTSKaA_1758028045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E8841955F27; Tue, 16 Sep 2025 13:07:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54B161800447; Tue, 16 Sep 2025 13:07:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D6BA21E6A27; Tue, 16 Sep 2025 15:07:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini
 <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>,  Eric Blake
 <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Szymon Lukasz <noh4hss@gmail.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v4 07/10] qmp: add chardev-resize command
In-Reply-To: <ffa90309f0ce8c81836e5e7074d67ae76033b67f.camel@gmail.com> (Filip
 Hejsek's message of "Tue, 16 Sep 2025 00:22:43 +0200")
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
 <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
 <87cy7s1auw.fsf@pond.sub.org>
 <ffa90309f0ce8c81836e5e7074d67ae76033b67f.camel@gmail.com>
Date: Tue, 16 Sep 2025 15:07:21 +0200
Message-ID: <87bjnao8ae.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek <filip.hejsek@gmail.com> writes:

> On Mon, 2025-09-15 at 08:35 +0200, Markus Armbruster wrote:
>> Filip Hejsek <filip.hejsek@gmail.com> writes:
>>=20
>> > On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
>> > > Cc: libvirt
>> > >=20
>> > > Filip Hejsek <filip.hejsek@gmail.com> writes:
>> > >=20
>> > > > From: Szymon Lukasz <noh4hss@gmail.com>
>> > > >=20
>> > > > The managment software can use this command to notify QEMU about t=
he
>> > > > size of the terminal connected to a chardev, QEMU can then forward=
 this
>> > > > information to the guest if the chardev is connected to a virtio c=
onsole
>> > > > device.
>> > > >=20
>> > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
>> > > > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
>> > > > ---
>> > > >  chardev/char.c | 14 ++++++++++++++
>> > > >  qapi/char.json | 22 ++++++++++++++++++++++
>> > > >  2 files changed, 36 insertions(+)
>> > > >=20
>> > > > diff --git a/chardev/char.c b/chardev/char.c
>> > > > index b45d79cb9b57643827eb7479257fdda2cf6b0434..6e3ade98614c949be8=
041ec5905a490ff536dee9 100644
>> > > > --- a/chardev/char.c
>> > > > +++ b/chardev/char.c
>> > > > @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_s=
kipauth, bool skipauth,
>> > > >      return true;
>> > > >  }
>> > > >=20=20
>> > > > +void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t r=
ows,
>> > > > +                        Error **errp)
>> > > > +{
>> > > > +    Chardev *chr;
>> > > > +
>> > > > +    chr =3D qemu_chr_find(id);
>> > > > +    if (chr =3D=3D NULL) {
>> > > > +        error_setg(errp, "Chardev '%s' not found", id);
>> > > > +        return;
>> > > > +    }
>> > > > +
>> > > > +    qemu_chr_resize(chr, cols, rows);
>> > > > +}
>> > > > +
>> > > >  /*
>> > > >   * Add a timeout callback for the chardev (in milliseconds), retu=
rn
>> > > >   * the GSource object created. Please use this to add timeout hoo=
k for
>> > > > diff --git a/qapi/char.json b/qapi/char.json
>> > > > index f0a53f742c8bee24c377551803a864fd36ac78cf..0a26c5eee6b71bc5de=
127a91b253cc69a9fe8ce6 100644
>> > > > --- a/qapi/char.json
>> > > > +++ b/qapi/char.json
>> > > > @@ -874,6 +874,28 @@
>> > > >  { 'command': 'chardev-send-break',
>> > > >    'data': { 'id': 'str' } }
>> > > >=20=20
>> > > > +##
>> > > > +# @chardev-resize:
>> > >=20
>> > > This name doesn't tell me what is being resized.  PATCH 04 uses
>> > > "winsize", which is better.  The (losely) related SIGWINCH suggests
>> > > "window change" or "window size change".  Below, you use "terminal
>> > > size".
>> >=20
>> > How about chardev-console-resize? That would match the name of the
>> > virtio event (VIRTIO_CONSOLE_RESIZE).
>>=20
>> Not bad.  It could become slightly bad if we make devices other than
>> "consoles" make us of it.  Would that be possible?
>
> I don't think the size has any meaning for devices that are not
> connected to a console, although the code does not care whether it
> actually is a console and simply has a size for every chardev.

Double-checking: the command works for any ChardevBackendKind, doesn't
it?

> I guess I could also rename it to chardev-window-resize
> or chardev-set-window-size. Let me know if you prefer one of these.

I think I'd prefer "window" or "terminal".

"resize" and "set size" suggest that the command initiates a size
change.  Not true, it notifies of a size change.  Maybe
"chardev-window-size-changed", "chardev-terminal-size-changed",
"chardev-window-resized", or "chardev-terminal-resized".

>> > > > +#
>> > > > +# Notifies a chardev about the current size of the terminal conne=
cted
>> > > > +# to this chardev.
>> > >=20
>> > > Yes, but what is it good for?  Your commit message tells: "managment
>> > > software can use this command to notify QEMU about the size of the
>> > > terminal connected to a chardev, QEMU can then forward this informat=
ion
>> > > to the guest if the chardev is connected to a virtio console device."
>> >=20
>> > How about:
>> >=20
>> >    Notifies a chardev about the current size of the terminal connected
>> >    to this chardev. The information will be forwarded to the guest if
>> >    the chardev is connected to a virtio console device.
>>=20
>> Works for me.
>>=20
>> > > > +#
>> > > > +# @id: the chardev's ID, must exist
>> > > > +# @cols: the number of columns
>> > > > +# @rows: the number of rows
>> > >=20
>> > > Blank lines between the argument descriptions, bease.
>> > >=20
>> > > What's the initial size?
>> >=20
>> > 0x0

Another question...  'vc' chardevs accept optional @rows, @cols (see
ChardevVC).  Is this the same size or something else?

>> A clearly invalid size.  I guess it effectively means "unknown size".
>> Should we document that?
>
> Probably. 0x0 is I think also the default size in the Linux kernel, but
> I don't think the Linux kernel documents this.

How does 0 x 0 behave compared to a valid size like 80 x 24?

>                                                Another question is if
> the 0x0 size should be propagated to the guest over virtio. I think it
> should be, although the virtio spec says nothing about 0x0 size.
>
> I'm not sure what is the right place to document this.

I think the QAPI schema doc comment is as good a place as any.

>> > > Do we need a way to query the size?
>> >=20
>> > I don't think it is necessary. What would be the usecase for that?
>>=20
>> I don't know, but it's my standard question when I see an interface to
>> set something without an interface to get it.  Its purpose is to make us
>> think, not to make us at the get blindly.
>
> I guess it might be useful for debugging. If the size is not propagated
> correctly, one might query it to find out on which side the problem is.

We have query-chardev.  It doesn't return much.

>> > > > +#
>> > > > +# Since: 10.2
>> > > > +#
>> > > > +# .. qmp-example::
>> > > > +#
>> > > > +#     -> { "execute": "chardev-resize", "arguments": { "id": "foo=
", "cols": 80, "rows": 24 } }
>> > > > +#     <- { "return": {} }
>> > > > +##
>> > > > +{ 'command': 'chardev-resize',
>> > > > +  'data': { 'id': 'str',
>> > > > +            'cols': 'uint16',
>> > > > +            'rows': 'uint16' } }
>> > > > +
>> > > >  ##
>> > > >  # @VSERPORT_CHANGE:
>> > > >  #



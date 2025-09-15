Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B282BCA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 06:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy2sK-0006Xe-Hq; Mon, 15 Sep 2025 02:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uy2sG-0006Wn-Bb
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uy2sC-0004KK-GT
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757918367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=HSWqyYfOzKDU8p059dQRKF41gx+JZDiIS5lsnZInSIQ=;
 b=YBI0A65MJYyty4anuJZDKJyHNcrX7v59SCpPuPWAZORqLiw+2wUc7oMs1ELBKcK+xGFK9j
 65vOI2Ca75bR4X3reNMIkdkc4UZLJqK/FtC17GH1x5LXNutgTLnIMkvkEkLgrHtO++iYtT
 EPRQ4gf9ICuscIpdfVe58+sjX44psNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-amjVgC3FP1aeQw5o6_RG_Q-1; Mon,
 15 Sep 2025 02:39:23 -0400
X-MC-Unique: amjVgC3FP1aeQw5o6_RG_Q-1
X-Mimecast-MFC-AGG-ID: amjVgC3FP1aeQw5o6_RG_Q_1757918362
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C471800297; Mon, 15 Sep 2025 06:39:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F3CA300021A; Mon, 15 Sep 2025 06:39:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D77A621E6A27; Mon, 15 Sep 2025 08:39:17 +0200 (CEST)
Resent-To: filip.hejsek@gmail.com, marcel.apfelbaum@gmail.com,
 noh4hss@gmail.com, eduardo@habkost.net, wangyanan55@huawei.com,
 zhao1.liu@intel.com, amit@kernel.org, philmd@linaro.org,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 15 Sep 2025 08:39:17 +0200
Resent-Message-ID: <87wm60z0bu.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit Shah
 <amit@kernel.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Szymon Lukasz
 <noh4hss@gmail.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v4 07/10] qmp: add chardev-resize command
In-Reply-To: <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com> (Filip
 Hejsek's message of "Fri, 12 Sep 2025 20:10:32 +0200")
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
 <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
Date: Mon, 15 Sep 2025 08:35:51 +0200
Message-ID: <87cy7s1auw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
>> Cc: libvirt
>>=20
>> Filip Hejsek <filip.hejsek@gmail.com> writes:
>>=20
>> > From: Szymon Lukasz <noh4hss@gmail.com>
>> >=20
>> > The managment software can use this command to notify QEMU about the
>> > size of the terminal connected to a chardev, QEMU can then forward this
>> > information to the guest if the chardev is connected to a virtio conso=
le
>> > device.
>> >=20
>> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
>> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
>> > ---
>> >  chardev/char.c | 14 ++++++++++++++
>> >  qapi/char.json | 22 ++++++++++++++++++++++
>> >  2 files changed, 36 insertions(+)
>> >=20
>> > diff --git a/chardev/char.c b/chardev/char.c
>> > index b45d79cb9b57643827eb7479257fdda2cf6b0434..6e3ade98614c949be8041e=
c5905a490ff536dee9 100644
>> > --- a/chardev/char.c
>> > +++ b/chardev/char.c
>> > @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipa=
uth, bool skipauth,
>> >      return true;
>> >  }
>> >=20=20
>> > +void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t rows,
>> > +                        Error **errp)
>> > +{
>> > +    Chardev *chr;
>> > +
>> > +    chr =3D qemu_chr_find(id);
>> > +    if (chr =3D=3D NULL) {
>> > +        error_setg(errp, "Chardev '%s' not found", id);
>> > +        return;
>> > +    }
>> > +
>> > +    qemu_chr_resize(chr, cols, rows);
>> > +}
>> > +
>> >  /*
>> >   * Add a timeout callback for the chardev (in milliseconds), return
>> >   * the GSource object created. Please use this to add timeout hook for
>> > diff --git a/qapi/char.json b/qapi/char.json
>> > index f0a53f742c8bee24c377551803a864fd36ac78cf..0a26c5eee6b71bc5de127a=
91b253cc69a9fe8ce6 100644
>> > --- a/qapi/char.json
>> > +++ b/qapi/char.json
>> > @@ -874,6 +874,28 @@
>> >  { 'command': 'chardev-send-break',
>> >    'data': { 'id': 'str' } }
>> >=20=20
>> > +##
>> > +# @chardev-resize:
>>=20
>> This name doesn't tell me what is being resized.  PATCH 04 uses
>> "winsize", which is better.  The (losely) related SIGWINCH suggests
>> "window change" or "window size change".  Below, you use "terminal
>> size".
>
> How about chardev-console-resize? That would match the name of the
> virtio event (VIRTIO_CONSOLE_RESIZE).

Not bad.  It could become slightly bad if we make devices other than
"consoles" make us of it.  Would that be possible?

>> > +#
>> > +# Notifies a chardev about the current size of the terminal connected
>> > +# to this chardev.
>>=20
>> Yes, but what is it good for?  Your commit message tells: "managment
>> software can use this command to notify QEMU about the size of the
>> terminal connected to a chardev, QEMU can then forward this information
>> to the guest if the chardev is connected to a virtio console device."
>
> How about:
>
>    Notifies a chardev about the current size of the terminal connected
>    to this chardev. The information will be forwarded to the guest if
>    the chardev is connected to a virtio console device.

Works for me.

>> > +#
>> > +# @id: the chardev's ID, must exist
>> > +# @cols: the number of columns
>> > +# @rows: the number of rows
>>=20
>> Blank lines between the argument descriptions, bease.
>>=20
>> What's the initial size?
>
> 0x0

A clearly invalid size.  I guess it effectively means "unknown size".
Should we document that?

>> Do we need a way to query the size?
>
> I don't think it is necessary. What would be the usecase for that?

I don't know, but it's my standard question when I see an interface to
set something without an interface to get it.  Its purpose is to make us
think, not to make us at the get blindly.

>> > +#
>> > +# Since: 10.2
>> > +#
>> > +# .. qmp-example::
>> > +#
>> > +#     -> { "execute": "chardev-resize", "arguments": { "id": "foo", "=
cols": 80, "rows": 24 } }
>> > +#     <- { "return": {} }
>> > +##
>> > +{ 'command': 'chardev-resize',
>> > +  'data': { 'id': 'str',
>> > +            'cols': 'uint16',
>> > +            'rows': 'uint16' } }
>> > +
>> >  ##
>> >  # @VSERPORT_CHANGE:
>> >  #



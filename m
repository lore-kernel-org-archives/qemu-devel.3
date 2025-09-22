Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE380CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cIN-0008MQ-LC; Mon, 22 Sep 2025 04:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v0cIM-0008MA-2Q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:53:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v0cID-00088N-Lg
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:53:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee155e0c08so2517595f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758531182; x=1759135982; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6jamjeCcde3oYBMe4EowloMjfJiUu1aQEck6uAXrbBU=;
 b=Auhlvw18OYHor9Km1xOwH5Nfsht0+d44XcboPySkqjAUjua9TKb2f8fz8XKuS+i3HD
 UOWXyxfwcriv3tXySXjizyyMMkoLssgXgXqqdYl1DJa7j0FwnnLTwy2slG+ClSAs1Z8n
 qcdeK8xvj1EpkUlWN8eghiFa3R0kcSzwARP5iP2nb6BF0fRCHrIkwfSWOeULm+fdM6JJ
 JBlvyElbeY5lT43Bu8Y3nRpewUz2fbpcwKQw4ZwIMql2+G892CMvlolqUeizvvXJmuSl
 KIvsdSXmGP6VhY9BvbTxkfG80RYjjOWLTHjyOm4D8IjL2jiPB5czdcuCCuy0n0IwCAxG
 48Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758531182; x=1759135982;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6jamjeCcde3oYBMe4EowloMjfJiUu1aQEck6uAXrbBU=;
 b=vFDv60sGSzGXK6ZJK+Pt+VSOIvVIqKNHZjJwZRItVnFtWyBgLANSMdpI4jt6+09BDV
 VnU1/AyvMmZh/iaB7LJDkFty5fEysl7FtM7DRBAj6ZjXVOfNeHbIMsbrUfV+amnan0o6
 lMsfdr2TAX5HNdBy8xf34N7MYfs9K9Q1uXfPHjkdidERpzlcOvuW2w1A4RZiDZUgMlDY
 5XCAld69tloe9gxEqxH9A7Rr1t9SVKYpryckq4b1qE8rA+fKlrTAJkSEr+qODsGAeZrH
 km8jLBD/2iJafegb8sNkLbYKUa7I2LkXZ0Q1031fMos4usNf6zPCrRxhAKM31/mnLQt/
 TmYg==
X-Gm-Message-State: AOJu0Yzp2T5k8eSb+cgUo7jw8Ewg3hD2WWqX6F1q8f/17Hepnsndirrj
 Ta8077wgYFrVkaHrWu5++v28A+OoH29hSdOJ/7zBq9GJn7EHB2nYfoTd
X-Gm-Gg: ASbGnct5QUIfWjdRjlvsKNFojdXQav/R+lfnu5bK+t4IGp/A9DfASnDd1BMyCj+rV9Z
 YzFf2iZJEYZazhiOsOm453zC3tf9DYeSikCC28Z/M9wzvLRj/pLb4k5OhxZwKsb1nQPZc+dQDbJ
 72wi2sQCKX/lPjFvW5Cj1rOhhyjUAgwxeNVa8uZgKJaOl8n4MJkM4tJI9z5PY5HKGZbayXaTLPt
 mhHET2LP8HTsogJlYNPaCOVddhlon+O5BJq4mtEI6GeIqgVRKXfF2WgW2JfptqA32FFteY6YSak
 iNWfMu0xNkthDaE3pUh8EuQNTZjL35i6VusHHpmZPO2oL+e8+ID9yl6A9J43B7RIUTfcmnJ9Zyi
 LLcglu6Bn0jyvM6EIqsH5j1kKHUqvOAnCUZctZ4p3zrCUAoedfBq6/0foBA==
X-Google-Smtp-Source: AGHT+IE/Q6qScSVdZuoFOXlkf/g3g3TgM+3+YOAdQQIf7JpAupX5SV76OZmgmffnZtNSVtxUpWFvlw==
X-Received: by 2002:a05:6000:2c05:b0:3ea:2290:7cc6 with SMTP id
 ffacd0b85a97d-3ee8713efe7mr11609738f8f.56.1758531181851; 
 Mon, 22 Sep 2025 01:53:01 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2d075sm7469554f8f.35.2025.09.22.01.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 01:53:01 -0700 (PDT)
Message-ID: <7f17b0208990972745845627b834fcaca0332dba.camel@gmail.com>
Subject: Re: [PATCH RFC v5 07/12] qmp: add chardev-window-size-changed command
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Eric Blake	 <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?=	
 <berrange@redhat.com>, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Date: Mon, 22 Sep 2025 10:52:59 +0200
In-Reply-To: <878qi7nfxw.fsf@pond.sub.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
 <878qi7nfxw.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 2025-09-22 at 08:45 +0200, Markus Armbruster wrote:
> Filip Hejsek <filip.hejsek@gmail.com> writes:
>=20
> > From: Szymon Lukasz <noh4hss@gmail.com>
> >=20
> > The managment software can use this command to notify QEMU about the
> > size of the terminal connected to a chardev, QEMU can then forward this
> > information to the guest if the chardev is connected to a virtio consol=
e
> > device.
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > [Filip: rename command, change documentation]
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> >  chardev/char.c | 14 ++++++++++++++
> >  qapi/char.json | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> >=20
> > diff --git a/chardev/char.c b/chardev/char.c
> > index b45d79cb9b57643827eb7479257fdda2cf6b0434..f3aad545afe3d325aac3880=
15b3d5517c2e48f0d 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipau=
th, bool skipauth,
> >      return true;
> >  }
> > =20
> > +void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
> > +                                     uint16_t rows, Error **errp)
> > +{
> > +    Chardev *chr;
> > +
> > +    chr =3D qemu_chr_find(id);
> > +    if (chr =3D=3D NULL) {
> > +        error_setg(errp, "Chardev '%s' not found", id);
> > +        return;
> > +    }
> > +
> > +    qemu_chr_resize(chr, cols, rows);
> > +}
> > +
> >  /*
> >   * Add a timeout callback for the chardev (in milliseconds), return
> >   * the GSource object created. Please use this to add timeout hook for
> > diff --git a/qapi/char.json b/qapi/char.json
> > index f0a53f742c8bee24c377551803a864fd36ac78cf..93b0d239276077d808af2e5=
479d539728377a99f 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -874,6 +874,36 @@
> >  { 'command': 'chardev-send-break',
> >    'data': { 'id': 'str' } }
> > =20
> > +##
> > +# @chardev-window-size-changed:
> > +#
> > +# Notifies a chardev about the current size of the terminal connected
> > +# to this chardev. The information will be forwarded to the guest if
> > +# the chardev is connected to a virtio console device.
> > +#
> > +# The initial size is 0x0, which should be interpreted as an unknown s=
ize.
> > +#
> > +# Some backends detect the terminal size automatically, in which case
> > +# the size may unpredictably revert to the detected one at any time.
>=20
> Nicely done now!
>=20
> docs/devel/qapi-code-gen.rst:
>=20
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
>=20
>     Separate sentences with two spaces.
>=20
> > +#
> > +# @id: the chardev's ID, must exist
>=20
> Let's drop ", must exist" for consistency with ID descriptions
> elsewhere.

All chardev @id parameters in qapi/char.json have ", must exist"
(although you're right that nothing else has it).

> > +#
> > +# @cols: the number of columns
> > +#
> > +# @rows: the number of rows
> > +#
> > +# Since: 10.2
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "chardev-window-size-changed", "arguments": { "i=
d": "foo", "cols": 80, "rows": 24 } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'chardev-window-size-changed',
> > +  'data': { 'id': 'str',
> > +            'cols': 'uint16',
> > +            'rows': 'uint16' } }
> > +
> >  ##
> >  # @VSERPORT_CHANGE:
> >  #
>=20
> Acked-by: Markus Armbruster <armbru@redhat.com>


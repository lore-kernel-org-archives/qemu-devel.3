Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71EDCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAgT-0000f9-89; Thu, 18 Sep 2025 05:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAgR-0000eq-Dj
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:12:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAgP-00077C-6s
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:12:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45cb5e5e71eso4260995e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758186721; x=1758791521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hOHXdqakD7jqFwAJgbLNnhWNaA7ogceO0YCG/P74pJ4=;
 b=lUfumOkZEQdiqU4fd579z73ZEePwpqH1KOzXO/AIYkE3WCqX/LSmSESQ4PbPHDjxL+
 nXZRlwPoyF0fkuAmYnHgMEUw7kOSOhBr8ZH2Se9lsRriWiCLVdOgTwy+0dYX9vKR4Cb7
 Vnzulh+9+fVMb5wbfhe8RAiTf3ntgmKQ7X+Auh2lfCawJKq7N8jirFUoGeuQSzpz6D0L
 UNO33OW35DnPLGXFNokZri3WU3eAoZLmpYx8BzG/po49gVbjid/Zgm13wAqf4rmXqhGU
 aEvCMXx0EQCrsSE3j1xdYeZ9m6PAw3u2xdZsDtUu51m+nsGUwcQ99RvG/dosZycp9QRR
 bnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758186721; x=1758791521;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hOHXdqakD7jqFwAJgbLNnhWNaA7ogceO0YCG/P74pJ4=;
 b=lbLhVOmjDDYIf9EAmmc1INJzB3+zquklWKXFldedgHqGTWq55NwXgew4YYBKK5dLDv
 dxakHG9yg/l4Z2P0UFjDnN1fREn1XBxaDIXqUZUN6VSJSvV+kb0sMRUCGv/ohFSmgYPO
 t3Iv03Frqe7Q7eG2JYo3NF8hxaVwHWQXW4MB2MPDSWUWgzQVdV+7Iux4VQkDn6DvwqyK
 9n6b/TdFhcDguC9k1kdESDuF8EOr0ARAujP+IQwVVh7PEvUos8ofYrTNNjknjWHb2dRe
 QdX/0l2J+yy8wI/IEaU/4X6H19zVEPt26mmQOqrKmTojOA8e9y9pqCLawi5ZqMecKbLw
 mR+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWeLsnr+dpLOKnWpQG475EahVWbcfUlB28oM9rjQ/HHQOrtOtnJHNPq13wA0xeyfWRKKu9rDqA1xtY@nongnu.org
X-Gm-Message-State: AOJu0YxP/WpqETbHbjRxIUtXOnRPiYkYNfruORPxJmCZXMzvEigy5afE
 hJqEzY/1VPTL1G7mgePZdfXUqoXfUIpaFq+TAmSQ+vsN/V98X+dtHbYr
X-Gm-Gg: ASbGncu0VFQiGmQ8UbEMeKRaZBXIFAWnT99LhdOVwiQcHks73ZjkomeDDc2doKLlpO1
 tZNhFXqHYXDG20ZI+rKIDjy139jQ514+0bTBmk+7AOacYS53o0J8bQzuHieoBgBnbbf/AGRwRAo
 6D/uU/L/FS/ck+Z8ncHehV5kHdkRvft6F1amPFkrIi88bWwhbk65w+J2WKelYwKK9Z0ZsJPhLRe
 pzr4Q6YSb4gexCXnVPIaEuRlQAl+6fKmtrmRulk2RF7IjB6i7xITQF2hPYsEc9KKZi4ljC5CZey
 Gr5cfWkG5parf4hjyn+fGh0RAePUdRtKMSwbpG5M7Zc6TeoTD7wrw1w/jPrUYG7Ch9LmVMMmhLI
 CrlgI6X5p5cO1uC7/OOsJxuWZfYZrEFfKTgREk1FHm93ayRIgvOwdTAgFPLQJiaAiXWyb1xOPug
 7T8HRuD0StVpNGW+a4SQ==
X-Google-Smtp-Source: AGHT+IGYCSI/VYXMeG/wOOXDaki4rFwc2Simp5JYd+V2rWf8X4XGBmvtM+HWDQw9hDM29wYJjv2Ung==
X-Received: by 2002:a05:600c:474d:b0:45d:d3f4:a640 with SMTP id
 5b1f17b1804b1-4620348f474mr46525525e9.15.1758186720877; 
 Thu, 18 Sep 2025 02:12:00 -0700 (PDT)
Received: from ehlo.thunderbird.net (37-48-19-157.nat.epc.tmcz.cz.
 [37.48.19.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f3d68sm2829969f8f.10.2025.09.18.02.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 02:12:00 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:11:58 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v4 04/10] char-mux: add support for the terminal size
User-Agent: Thunderbird for Android
In-Reply-To: <418ee5f98e2ada1c51b5a38614a7d80d48d68bbf.camel@linux.ibm.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-4-7925e444afc4@gmail.com>
 <418ee5f98e2ada1c51b5a38614a7d80d48d68bbf.camel@linux.ibm.com>
Message-ID: <4B2F9F9E-F30F-46B6-AB00-8F2D9E04D262@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On September 18, 2025 10:32:57 AM GMT+02:00, Maximilian Immanuel Brandtner =
<maxbr@linux=2Eibm=2Ecom> wrote:
> On Fri, 2025-09-12 at 05:39 +0200, Filip Hejsek wrote:
> > From: Szymon Lukasz <noh4hss@gmail=2Ecom>
> >=20
> > The terminal size of a mux chardev should be the same as the real
> > chardev, so listen for CHR_EVENT_RESIZE to be up to date=2E
> >=20
> > We forward CHR_EVENT_RESIZE only to the focused frontend=2E This means
> > frontends should probably update their view of the terminal size on
> > receiving CHR_EVENT_MUX_IN=2E
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail=2Ecom>
> > Signed-off-by: Filip Hejsek <filip=2Ehejsek@gmail=2Ecom>
> > ---
> > =C2=A0chardev/char-mux=2Ec | 18 +++++++++++++++++-
> > =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/chardev/char-mux=2Ec b/chardev/char-mux=2Ec
> > index
> > 6b36290e2c49f579580d2abb5aa552806f019d4a=2E=2E4d3d05b82f13e002c766142f=
9d9
> > c24977b8b9bd2 100644
> > --- a/chardev/char-mux=2Ec
> > +++ b/chardev/char-mux=2Ec
> > @@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr,
> > QEMUChrEvent event)
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > +static void mux_update_winsize(Chardev *chr)
> > +{
> > +=C2=A0=C2=A0=C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);
> > +=C2=A0=C2=A0=C2=A0 uint16_t cols, rows;
> > +
> > +=C2=A0=C2=A0=C2=A0 qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
> > +=C2=A0=C2=A0=C2=A0 qemu_chr_resize(chr, cols, rows);
> > +}
> > +
> > =C2=A0static void mux_chr_event(void *opaque, QEMUChrEvent event)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 mux_chr_send_all_event(CHARDEV(opaque), event);
> > +=C2=A0=C2=A0=C2=A0 Chardev *chr =3D CHARDEV(opaque);
> > +
> > +=C2=A0=C2=A0=C2=A0 if (event =3D=3D CHR_EVENT_RESIZE) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_update_winsize(chr);
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_chr_send_all_event(chr=
, event);
> > +=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > =C2=A0static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
> > @@ -382,6 +397,7 @@ static void qemu_chr_open_mux(Chardev *chr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 *be_opened =3D muxes_opened;
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_init(&d->chr, drv, errp);
> > +=C2=A0=C2=A0=C2=A0 mux_update_winsize(chr);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend
> > *backend,
> >=20
>=20
> When changing the focussed chardev, the MuxChardev should send a resize
> event to the newly focussed chardev=2E Otherwise the size information of
> the focussed chardev might be outdated if it wasn't the focussed
> chardev at the time of the resize event=2E
>=20
> Theoretically, the resize event could also just be sent to all
> character devices focussed or not, however as this causes a lot of
> needless redrawing I prefer the approach of only resizing the focussed
> chardev=2E
>=20
> Kind regards,
> Max Brandtner
>=20

Right now, this is handled by frontends also updating the size
on CHR_EVENT_MUX_IN, as mentioned in the commit message=2E
I could make it so that CHR_EVENT_MUX_IN is always followed
by CHR_EVENT_RESIZE, if that is preferred=2E A more complicated
option is to remember for each frontend if it missed a resize event,
and only send it then, but that seems like needless complexity=2E

Kind regards,
Filip


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E15C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWsS-0007ml-W6; Thu, 27 Aug 2026 05:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzWsQ-0007lS-SW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:58:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzWsO-0007on-W0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:58:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1cbb64a1fso1552197a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787824707; cv=none;
 d=google.com; s=arc-20260327;
 b=IAtiHnyVg/epWvDhokAmA9XPVVHlVCyoop1a90z737+wI7Di5V76804UcatG4uesMl
 Bf/G7IHO6lpOirwz0bVd/NyeZwuNID0iEZjOpX/ug7l0I4fvz1Jv8pRGVH26BGCMejyU
 iARGkhgslAudGWrhTSx25UwQtHcYc4h2zFbSJc5B4ctvSAsyqeVGNyBTIjd6VYr3Tyxp
 6QlQumngvUyVP7glvtUfJzY8r2zapOGU/cjBWl+pf9+2LAI89oC9U1QX/HpEgV72pKzK
 Yo6jh2c4pHHQEnrX09ZAlKfDgDgj7Cjbp2810kDV/YFfvtXhwnUVS2TyXYNxqWK8x4MB
 EWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fXcaUfxwvo8yrsHq9dyA3ZcvA6AkZ/ogCZBUJAz2ru4=;
 fh=BvaKJMiH2T+cklnzFVwMvu7nTyBSZzzflKJvBCzExpE=;
 b=lkagcI5vVGvwCSOtqI4EILvSDO0YXmxnxkbClyQyJ8Vh2ChA2e/G2DUMWCNam0ZpfY
 1KKmMnIzNtnzc1cgEF4dviKm/8mdfs819L240we2paMWli2p+DJeiqM8ARN9ZCO3gKae
 ut+dfNaI/xMibnOy5chzywx83OMFRsV6/2IZNOmglQiG4kBAaepICkqQLoNn1X5WOrVr
 eOPtr9bFpbkJwCPpHlXYBmP+jTo9/y+DTYwhTwgLdC5oeWJxaB7JPPHZrExeUNvRJ/VP
 b76iZbrDaLh2vn/C1jvMonxcCTnt66+JOjLhVC7J+FGBzPX5dRe7qg7BbbN9OlBvTZrC
 Ozvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787824707; x=1788429507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fXcaUfxwvo8yrsHq9dyA3ZcvA6AkZ/ogCZBUJAz2ru4=;
 b=erYDe87wXBskO01GmBOrvSFbuFwWH9qMxcW0AQ2+itEDF7Ixe/mU5Lm5wkNAFKPkGN
 +jhwyeoG9LWgSgiy2LcYmlOviSnBI1KBxkdwnMu4hIQzL8kl619V3OnNtVXXWPsU4V+1
 RN16ylw6BsC6QydjpOCplu0K/UiDC5GfJvtT7kGIEeTjk9h844Zj8nh9zcZk8tJiKJIR
 I95bYdQSL99nRxIU8ex83ADpmXsboFOwusrhc3LXyBmPUg+WIb/AK9Yy7Dp+r/vCh6gL
 d/QFRXrScSG6/uAQn0xQsfzt70lzpvShcmxeZQCCvEj4D9SzvvBbSUS75UU63BfkwAOx
 F88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787824707; x=1788429507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fXcaUfxwvo8yrsHq9dyA3ZcvA6AkZ/ogCZBUJAz2ru4=;
 b=HFGs+UZGBBJmaYdtQXvwMo2a6+k6ZdW1wPQ2nvLotHpcNipfTZ6gmPt47VtZWRkkl+
 GbGTEcd1CRAmE+Zo3oKh3Vm2HsKu5hPN4qXMK/eA3psDMO3NmoVALSvgqzX2jI0XpxrX
 DSgDRp14HZXhBTregGStBYxGywf/fNSVSnDY7vog6+wrd9SUbIbgRFvZLP1AFcpO2WxH
 OcS+xvbSNRigAaG9BzrqBTDqnY9JCsZfboXTku+IDIaBMFETKWILWZEMvNXQXXFiTja1
 SuYGMansni01CwZ9g35NFRIviAvSTktNIAwdimehP4dp+Z0xjGchcd10LZl21QEjwqSZ
 AeLg==
X-Gm-Message-State: AFuF++lyktHRdj+Ep6/a1IXa7l2UJC/sZXcCVE5Ki6oSR7+NoDI2CJlh
 /zcKK5G868iM91zlnC6XZ3mMViuOFUd7AodbY0q9dwyDJmAYQmuL1nc5WTlsp/X6/qZlcNrd0XM
 cXRANVbS7wPV2QGp2KozN7f5wTjeZka4=
X-Gm-Gg: AR+sD13hhveQxVw12F9Lhm6bwdSwJXCUSVq8L7XlFMZWeCHXXKRmHrBGUyATgyTmStz
 N6GtR5ao+0l+VDIc1gACyeUlDi2Yc4oPGEpD3gmuurVZcohf+UTSwjjDNrQ3E0kNVyp5t+An4Bj
 za69PIrTKOquSo0r29clJqSSfDEUYlNrh1l4E4IAxpoOX6TWgw4GiarHaWc0jRPgSLxMbGJOqsw
 mMWWNe4SxAfRGC6EJtg9QRl9d1mzjZfVPUyPt1KJ6HU2AK+2rZace+DGBifh1g8StYGOdfkdI+q
 lgononGyVMRtduVM/Bk8kfGzH1n+1n//WyRu4YbEVGJxn1/TDtkM2gLaMmdoVcacZDpnXkkYybK
 j
X-Received: by 2002:a17:90b:1a90:b0:396:6344:3b62 with SMTP id
 98e67ed59e1d1-3966d71a0e4mr27102161a91.12.1787824706988; Thu, 27 Aug 2026
 02:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
 <ao_5WNBxRiZycEeb@redhat.com>
In-Reply-To: <ao_5WNBxRiZycEeb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Aug 2026 13:58:14 +0400
X-Gm-Features: AcwNN1Wp7dum7I90fp0I3XF3VpUI5vvzKQvRe-9D34WkO7Vd33Qm4_E1g-G2Dps
Message-ID: <CAJ+F1CL-4kx18mUC4Jk7-cARiVX0Cq3qSFt5Ct-qM2EBA9dyUw@mail.gmail.com>
Subject: Re: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Thu, Aug 27, 2026 at 12:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Aug 27, 2026 at 11:06:47AM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When the new cursor is the same object as the one already held by
> > the console and the refcount is 1, cursor_unref frees it before
> > cursor_ref can increment the count.
> >
> > Ref the incoming cursor before unreffing the old one so the
> > refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.
>
> I don't see where/how this can happen.  The caller of
> qemu_console_set_cursor should own its own reference
> on 'cursor'. So on entry to this method, 'cursor'
> should have a ref of 2 if it is the same as the
> current con->cursor.
>
> if anything the behaviour you describe sounds like a
> bug in a caller not holding its own reference.

You are right, I thought virtio-gpu kept a weak pointer, but it should
have a strong ref, so we should never reach 0. I can't explain the
crash I observed then.

>
> >
> > This is related to 385ac97f8fad ("ui: keep current cursor with
> > QemuConsole"), but could have happened earlier with VNC too.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/console.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/console.c b/ui/console.c
> > index a8a2a247d8f4..4db8f1cb431f 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -904,8 +904,9 @@ void qemu_console_set_cursor(QemuConsole *c, QEMUCu=
rsor *cursor)
> >      DisplayState *s =3D c->ds;
> >      DisplayChangeListener *dcl;
> >
> > +    cursor_ref(cursor);
> >      cursor_unref(con->cursor);
> > -    con->cursor =3D cursor_ref(cursor);
> > +    con->cursor =3D cursor;
> >      QLIST_FOREACH(dcl, &s->listeners, next) {
> >          if (c !=3D dcl->con) {
> >              continue;
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>


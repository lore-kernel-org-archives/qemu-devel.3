Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D359FAD41B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFnYQ-00058N-T0; Thu, 23 Apr 2026 02:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFnXt-00057H-Ab
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFnXr-0003N0-QK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776925694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZimMnG90xxxn7hT5xJhfeGfTBvNX2U6GixC/DPhQ8U=;
 b=PR59tfd/bedTX27XrFEgrHt7eA6zY+u+7qmAs9R9nQXvQ1sOD0u6Yh3j5GmQTYjvBEwKGk
 yBoss8U3i9+nBEK/nQ3WTlTGp5SsiWQq2Lhy6GPEfkSfpf7j5+TVM/jt11CDvNVIaJ5Ex8
 HUmCNiBOdjq/POVXEyhGJx1XYd780T4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-VHrvyhrIN8-gnf7W08e8Aw-1; Thu, 23 Apr 2026 02:28:13 -0400
X-MC-Unique: VHrvyhrIN8-gnf7W08e8Aw-1
X-Mimecast-MFC-AGG-ID: VHrvyhrIN8-gnf7W08e8Aw_1776925692
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3614272b00cso7733959a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 23:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776925692; cv=none;
 d=google.com; s=arc-20240605;
 b=HBdGNW3LeIxguyBy8pGyLEQB5zo50u/8jp+yqizRTt4t1cu2142fKADmu7WQmzP/j0
 qdSRHUvUEsy/EmcTC+zSFlAGQX8S+rPJseLUAP/STnvTEtgeqbHHIbW/wxmcLfZ+CJU6
 X2a7RzzMwiMOekm3iO/IZb5QRYFcU/h3fZdO2/Ga/d6PZUnohX2KDMFV2bJqr7bbUrNS
 0N8NHvGXK1CXYO4RRkiX5g3zdw/ddbwLj7yCoitakrIywF4bLVyJcYp2+6BnrgeZDGKx
 ACd410QrAVoRR7DHTBgeFYp4EEDEqBt6yy4ppqywVviHOVCqIBXjDfJkqGdlTRieJ0pa
 K43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HZimMnG90xxxn7hT5xJhfeGfTBvNX2U6GixC/DPhQ8U=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=AQYi7edrDL8z/DFW4kgRgSxb0vsWeD+vMlSCl+Oy9Xq4E9AB3fxFMnUflNy12zKpJA
 EInOrTxn8QXvTGjmR/NQM1kW06uGwez8q+Wec7EdbWRWUcmbiOA9L5igmqCx1+VOndOj
 SYm6zS6D50usKf6NhIAbfIDRNNdMhbRoB+3UuQcfZM2IC5+/7fXREjOSUQIo89X7LjRK
 9lL0MKLoZLuXkW4YG5D7VWJFY6pQznf07EPJ8FUBnFUSScTFOfifeIw1j00slEB4kt+2
 CPAW1rCdrohM/eOelKFm37X9riXcbDjwsD5LWXcuv/DJk0Fg7gfrRvELsil3vSofRHOM
 KdZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776925692; x=1777530492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZimMnG90xxxn7hT5xJhfeGfTBvNX2U6GixC/DPhQ8U=;
 b=Q0qS8Mk70oktw5HdybmiUXENzvT3PStrHcu6QTZqD4QzilS+vrB5344cOVoAHJKYz+
 q68zWRYCRj/W0kI/jy+WBAc0pAu10Rjd7WBPE/IuBIXljochM/AFw0msHgCF2fB99E+K
 iDfE0OJR2Mg7jPCxpwnBGTfM80C1oV+IDDmqo5ZAt7zPEqxwI3GrJNDW+zIcChpkxLlw
 SPv8peQn59W+QD1C2jEIOG8SFMFRy7xF4EoRTY3Jri5OP7uKT64q146Gp6jKpKXOI5Ix
 nBnlu4zRP/+B41rvPminOpVVG99TkoDUIhRASIThVi5eSYwGuurKoSQiF1c0z+isET3s
 r64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776925692; x=1777530492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZimMnG90xxxn7hT5xJhfeGfTBvNX2U6GixC/DPhQ8U=;
 b=MCtEYMwjtvio/6OxJwhbq5cILj2vDYH7CyZYiLwOn6j2l4cNvkqoJ/QKb2sVoUrYrg
 JCSfmeFDtuQHCDfE2lgD8owiyEMe6iZcwNYoWqtgdfVDF8zm1O7GvKgZ2lQGqKUXTJZg
 FOgVLue/i45cwNiCD1rpaRhdzR+8sJiTrHfpPyhq6BjnoTUrtdLXsgt1G0sFz6crbB0j
 si280OIOvVbTa+nEM1Oh5Yn6xsl1VpWO+FzB+5b5ADNkeg4QumRitoJPWfcXUAFxF2RG
 ra+1NZcRPcDt7kXvU4ksPNPHBslQNlnM1SGfwNtCuKQui6o/S6moy8PxN3tcadx+zebs
 kEQw==
X-Gm-Message-State: AOJu0YwpUHyWM7Qym601IRCt2TfqC1cv9RL3JsrkEI1BHZ7eMWT0k4h8
 GDNzGLtkaOPH3n0wVltkdxUkUcVkFhxBBE3yaRXI6W6QFjIcCXi6e7tW4vraylTEgnfm4D1YyIM
 U66scgBxfgtxlnIotMeDy7hkS/8u46iHJCu+Y8akHe4CF4CwTgmfVIasSD7y89VVw+2kWXNaUbl
 AFSiX0iY8upRtlSnkD/WIX3XukF/0ghZU=
X-Gm-Gg: AeBDieucAdrrq0Dq40RcC1bEmfWuxegjvRfTPXF8yyMs4rTU6xJODyAvFrs3+pvN1if
 Z0Y2ad75owg3kpXzEi/CcEpkBJPPBbcKXfu/yFb9yiMex4B4+Bjz5/dd97OPqbvGQPG7lcRBZUp
 OKUCUVjzKLHlSHwlji4V/N8nLyPrS+SG8xKsvwaNdxrJB2WKPPpMtHTrpOBIJeZ38Ysm/SEoo/w
 tF/UIAhdm4qYZ+ZmgcdwKtxb4drk3caj1Pc/YoDhBcqGenEvVrvz3s9iTn1QrbDExeK3YUmYf0h
 K3i2foCSlyoS7MqOg2O8qEl6Njjun9BDeSk=
X-Received: by 2002:a17:90b:2fc8:b0:35d:a542:2dc4 with SMTP id
 98e67ed59e1d1-3614047a7b8mr28157580a91.21.1776925691930; 
 Wed, 22 Apr 2026 23:28:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2fc8:b0:35d:a542:2dc4 with SMTP id
 98e67ed59e1d1-3614047a7b8mr28157564a91.21.1776925691467; Wed, 22 Apr 2026
 23:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87v7dis20c.fsf@pond.sub.org>
In-Reply-To: <87v7dis20c.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Apr 2026 10:28:00 +0400
X-Gm-Features: AQROBzDAKViMcQkg7g_gKb0W1kjaEWHAjpQGlgd-ivMhYMdNNttNjuLUxH5Mc8Y
Message-ID: <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Thu, Apr 23, 2026 at 9:02=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This commit removes the QemuConsole from the global "consoles" list whe=
n
> > it is finalized.
> >
> > Previously, there was a TODO comment indicating this path needed
> > checking. The assertions added ensure that `dcls`, `gl_block`, and the
> > `dump_queue` are empty before removal, confirming the console is in a
> > clean state.
> >
> > Fix potential use-after-free crashes when a display console is removed.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/console.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/console.c b/ui/console.c
> > index f445db11389..b64e2122f34 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -394,10 +394,13 @@ qemu_console_finalize(Object *obj)
> >  {
> >      QemuConsole *c =3D QEMU_CONSOLE(obj);
> >
> > -    /* TODO: check this code path, and unregister from consoles */
> > +    assert(c->dcls =3D=3D 0);
> > +    assert(c->gl_block =3D=3D 0);
> > +    assert(qemu_co_queue_empty(&c->dump_queue));
>
> Help me out: what ensures this?

- No display change listener left
- No GL lock left
- No pending screendump

>
> >      g_clear_pointer(&c->surface, qemu_free_displaysurface);
> >      g_clear_pointer(&c->gl_unblock_timer, timer_free);
> >      g_clear_pointer(&c->ui_timer, timer_free);
> > +    QTAILQ_REMOVE(&consoles, c, next);
>
> Is @consoles only accessed from the main thread?

Yes, the UI code is main thread only.



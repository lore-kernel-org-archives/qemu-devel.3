Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E353CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVfF-0006JK-KV; Thu, 30 Oct 2025 12:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEVfD-0006Ir-I7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEVes-0002ug-26
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761842270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5GWk18a/VA/4RMIoI7ifBwmIEmAQLQHusjUKulED2o=;
 b=NMDAJHqLYrAuoB47/+lOjo42w5Bc5hFKL9BjZAes89lMZj+5DqjbRpT99rN4paU0iXCzcO
 tfChbQtASvYTREVWMKuWHBKKK/N+Crt2aoy15vh0zjbOYWa0UMchWIH0quBDYJi3TJbkTB
 1mm1m6vVf01+nSr4pkfdWzFe4bWVUWk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Xgh4kXL_NNCQNGvK-K0Svw-1; Thu, 30 Oct 2025 12:37:38 -0400
X-MC-Unique: Xgh4kXL_NNCQNGvK-K0Svw-1
X-Mimecast-MFC-AGG-ID: Xgh4kXL_NNCQNGvK-K0Svw_1761842258
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87fe7c9134fso16704636d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842258; x=1762447058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5GWk18a/VA/4RMIoI7ifBwmIEmAQLQHusjUKulED2o=;
 b=Wz6g/xxOmu2vwqmnAoFDR9/1NIQVlVFn7BwtAJcoxp3faQY/xe7VikMsoQwFqbCa4n
 f5ZVi3bsPXRuJkFtj+Gaezc9slk2RYBu789X5TxLdg0mC++62X226f0utW+dq+sNdYTC
 j2o6b9uPTSQnZRgmSUdTI+be8SE6gdsJUBxxA0uc7DzlWdOsdo5yUqrNea0pd2fbCPUT
 HM8WYreXzsWTbxgGFVkIPSU7ywoNPynyS/+24vFHfta6/8gja4VpQeR0QQqVQNWgmURg
 1VOGwqP3VwiNKpPHaRKdwE4y5DrFwF1rxsHe9YfWGPyT70nOA7sng6233CVMahBOmN/a
 az0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHrZwnfF+YFhxRyeBLYAwmizxk5XMO9umWrGB1r8mGWWQ5o0UOGOhzhx6t1atm+gXQR/g9Q+WcYw5g@nongnu.org
X-Gm-Message-State: AOJu0YxVargXriyCCCa68LdNm9mA8DBHvCZEZZ7XZELEIQ2CWoOHhSMh
 O7HUrzaCigzRzByecpVQ5D3joOjVYXMrrlo3TIc/7UijBjtSKM4l+T+Am/LfAZXpKGf/f01CALw
 FsCd+ZdoajOF0o+AhoCZOqlS7Wis0pgx21+OL7w7lLDCSakozCUOLa33J
X-Gm-Gg: ASbGncsinfaT1YfJn6fkpuGlZUzcuKrWc74J+xwWIXKCZDxECpi66Ho+bSMY735C2GW
 djgDVU6PvIcDq7ayhT+l7aVzaoH5iv65clyCZOCIQLiFl+JRRiIYJPwrqKDaRrhwmONuJpDMwS+
 0VDzQ4Yzf4evNcUpPjDS1AZEtWJSqZfUE1T0lnLwft0djNTfbRc4cflS7e1CtDsYGXD1R+QQhy9
 5BBK9yXyKqKCXk1rs84OyoZN8UreQoLaMwZgkNIYnOeXfu/N1C7l52/9Wu3R4YK0avxMxB1pZ85
 y0waAMnnrKTmu94JGQxDcYGsz6Empa9mvphWO+cfuNs+RxLjwEEb9HQlY1De337NMXA=
X-Received: by 2002:ad4:5dc6:0:b0:880:2254:36a4 with SMTP id
 6a1803df08f44-8802f51a221mr2259276d6.63.1761842258047; 
 Thu, 30 Oct 2025 09:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJD9TgfT/YKeT2Wh3bDcLgKYB8ORBrpVG12HNnDI1GZXwYpMmBWbiaa3R362AT9zFypoT6g==
X-Received: by 2002:ad4:5dc6:0:b0:880:2254:36a4 with SMTP id
 6a1803df08f44-8802f51a221mr2258746d6.63.1761842257513; 
 Thu, 30 Oct 2025 09:37:37 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc4944d57sm122956836d6.35.2025.10.30.09.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:37:36 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:37:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alexandre Ratchov <alex@caoua.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <huth@tuxfamily.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 19/35] audio: register and unregister vmstate with
 AudioState
Message-ID: <aQOUTmDMzvKePrIW@x1.local>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-20-marcandre.lureau@redhat.com>
 <ffab95ce-9b5d-43ea-93a7-611de6044ad8@linaro.org>
 <CAJ+F1C+qnkm=F1q0YSHZ9WbAMcz+-NJo5mzj1b-DcU24dNpRLQ@mail.gmail.com>
 <adbf6cd9-72b0-4ce9-93a6-4f83338ca8a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adbf6cd9-72b0-4ce9-93a6-4f83338ca8a3@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Oct 29, 2025 at 10:42:00PM +0100, Philippe Mathieu-Daudé wrote:
> On 29/10/25 20:00, Marc-André Lureau wrote:
> > Hi
> > 
> > On Wed, Oct 29, 2025 at 5:51 PM Philippe Mathieu-Daudé
> > <philmd@linaro.org> wrote:
> > > 
> > > On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> > > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > 
> > > > Proper lifecycle management with QOM state.
> > > > 
> > > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >    audio/audio.c | 7 ++++++-
> > > >    1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/audio/audio.c b/audio/audio.c
> > > > index 4c3c3fd52f..853930bb48 100644
> > > > --- a/audio/audio.c
> > > > +++ b/audio/audio.c
> > > > @@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
> > > >        audio_reset_timer (s);
> > > >    }
> > > > 
> > > > +static const VMStateDescription vmstate_audio;
> > > > +
> > > >    static void audio_state_init(Object *obj)
> > > >    {
> > > >        AudioState *s = AUDIO_STATE(obj);
> > > > @@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
> > > > 
> > > >        s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
> > > >        assert(s->vmse != NULL);
> > > > +
> > > > +    vmstate_register_any(NULL, &vmstate_audio, s);
> > > 
> > > Please avoid legacy APIs:
> > > 
> > > /**
> > >    * vmstate_register_any() - legacy function to register state
> > >    * serialisation description and let the function choose the id
> > >    *
> > >    * New code shouldn't be using this function as QOM-ified devices have
> > >    * dc->vmsd to store the serialisation description.
> > >    *
> > >    * Returns: 0 on success, -1 on failure
> > >    */
> > > 
> > 
> > qdev/Device have vmsd, but not plain Object (or legacy code without object).
> 
> Hmm right. Cc'ing Peter & Fabiano.

Thanks, yeah this looks fine when it was already there.

When looking at it, what's interesting is vmstate_audio is actually empty..

Explanation in da77adbaf61, since 2021.  Maybe we could drop it completely
at some point as I know we start to deprecate machines over 6(?)  years.
But I don't know when is proper.

We also hit similar issue with TAP device where there was a demand to add
compat properties to TAP however it was not a qdev, hence it cannot use
compat properties mechanism..  I wonder if these devices will be (at some
point) be converted to be type device.

-- 
Peter Xu



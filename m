Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D624C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8sT-0003n5-PT; Thu, 08 Feb 2024 13:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rY8sR-0003mc-HF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rY8sQ-0006eX-08
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707415916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cAbIbxVJ3JwnYdiA+lgyBSQ/dDWEPy+BfVophRg2Ck=;
 b=X1DLxmnIzg/Qbp8uMPapXjn/bSlbgOWW3PLWJqs5xW5VRAkWxYi3ebJbbGe8dImkjL76bs
 93YM/2fV2vvh72D6FgUms/ton2kgO4mOY5qlKiQMJ4uvsOI3LAhcBNY5mDOH+UNqsmNULW
 jkvr5cJoCKm7kYv182oqd4nX01c4DJc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Ig7kB7TfMUOoHG6CVdrJOA-1; Thu, 08 Feb 2024 13:11:55 -0500
X-MC-Unique: Ig7kB7TfMUOoHG6CVdrJOA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5efe82b835fso4264897b3.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415915; x=1708020715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cAbIbxVJ3JwnYdiA+lgyBSQ/dDWEPy+BfVophRg2Ck=;
 b=cl2D1h64MjeF9s86jLlgRCyQ3hgCKFSKosZKu0mLzb4IhlMrdWDnqzxPetmUeKJgrA
 h+v1Y4g1QbeyKVg0Zw5YGr4lvoe598x7JWRGMf2+LRx/8eWB8Xwx/EkfvBSfBqKCHcUn
 +P08Hi8VOX/zFSw5JkyU2EoS512siPZRU6NaToR89P2AyTM/Nd+WuIUfVFzR5OInRq2t
 1s4T6IIGuDx4kYRUKRCmg1cZzDEMUwbkLUpndIHx0tlcawdu/BRUFdKlm2PmMs2eJHgG
 wTv9CmyMsAMdqaIOOl04UCTvxR2di3WYYSmOyBAqVXPmLqo8QW4uFFm9rYrdrbkhgK+8
 2HBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrC3iWGOmABSAKsN0+aFpCRzIvlG7EdqmFPg8AgvfWSd3gRMFjeEzmG/PzFi6dYmE6FhZAFJPp0siCIWeKnq4P3XJUQns=
X-Gm-Message-State: AOJu0YxmBoQVdCI3EbDCpGsP94AvgoMu/f1mtDpn+PLcHyWD8NSEPySa
 1OtnfG009E8RLwvKBVsJyYu4h1K70n7Rg4Xzm7LW4ll6q9BPhC/pG+mjMN8LqFv7TZe0Wg4Xeag
 +gPulFkRJA1ASOUc06Jk80wHC/26gbR6QDWXsiaputmQ8uOQvMcLChxlDbSkGueSFUy2niggOmD
 9r7vxLWTpx+nay6oaCa22YCR7ypto=
X-Received: by 2002:a81:6e89:0:b0:604:a47e:6e52 with SMTP id
 j131-20020a816e89000000b00604a47e6e52mr142692ywc.32.1707415914727; 
 Thu, 08 Feb 2024 10:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGELMlcvumPnyimqKGq/AlOt2CMDeMcKVM1Y3MWD0HJPAL9f+xxfckhi1XvnoZrYl/bRsqi7RWB5FcOenaNkvc=
X-Received: by 2002:a81:6e89:0:b0:604:a47e:6e52 with SMTP id
 j131-20020a816e89000000b00604a47e6e52mr142670ywc.32.1707415914436; Thu, 08
 Feb 2024 10:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
 <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
 <c9dfd1d3-c784-456f-ba6e-dc56388fd79e@ilande.co.uk>
 <CABgObfbWqHBq0udoqaPxe=H=oGQe4WwdsfU6+iJVJMF9LoGRow@mail.gmail.com>
 <f18b34b6-449f-4926-b353-bf3b830919d0@ilande.co.uk>
In-Reply-To: <f18b34b6-449f-4926-b353-bf3b830919d0@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 19:11:40 +0100
Message-ID: <CABgObfbF-R2O7Ly0jVRWF08Y-P3tbkQbUaF4N6oB5Dtcy_FswA@mail.gmail.com>
Subject: Re: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 8, 2024 at 10:46=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 01/02/2024 11:36, Paolo Bonzini wrote:
>
> > Il gio 1 feb 2024, 12:25 Mark Cave-Ayland <mark.cave-ayland@ilande.co.u=
k
> > <mailto:mark.cave-ayland@ilande.co.uk>> ha scritto:
> >
> >     On 01/02/2024 10:46, Paolo Bonzini wrote:
> >
> >      > On Fri, Jan 12, 2024 at 1:55=E2=80=AFPM Mark Cave-Ayland
> >      > <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.c=
o.uk>> wrote:
> >      >>
> >      >> Invert the logic so that the end of DMA transfer check becomes =
one that checks
> >      >> for TC =3D=3D 0 in the from device path in do_dma_pdma_cb().
> >      >>
> >      >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
> >     <mailto:mark.cave-ayland@ilande.co.uk>>
> >      >> ---
> >      >>   hw/scsi/esp.c | 24 +++++++++++-------------
> >      >>   1 file changed, 11 insertions(+), 13 deletions(-)
> >      >>
> >      >> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> >      >> index fecfef7c89..63c828c1b2 100644
> >      >> --- a/hw/scsi/esp.c
> >      >> +++ b/hw/scsi/esp.c
> >      >> @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
> >      >>               return;
> >      >>           }
> >      >>
> >      >> -        if (esp_get_tc(s) !=3D 0) {
> >      >> -            /* Copy device data to FIFO */
> >      >> -            len =3D MIN(s->async_len, esp_get_tc(s));
> >      >> -            len =3D MIN(len, fifo8_num_free(&s->fifo));
> >      >> -            fifo8_push_all(&s->fifo, s->async_buf, len);
> >      >> -            s->async_buf +=3D len;
> >      >> -            s->async_len -=3D len;
> >      >> -            s->ti_size -=3D len;
> >      >> -            esp_set_tc(s, esp_get_tc(s) - len);
> >      >> -            return;
> >      >> +        if (esp_get_tc(s) =3D=3D 0) {
> >      >> +            esp_lower_drq(s);
> >      >> +            esp_dma_done(s);
> >      >>           }
> >      >
> >      > I'm only doing a cursory review, but shouldn't there be a return=
 here?
> >      >
> >      > Paolo
> >
> >     (goes and looks)
> >
> >     Possibly there should, but my guess is that adding the return at th=
at particular
> >     point in time at the series broke one of my reference images. In pa=
rticular MacOS is
> >     notorious for requesting data transfers of X len, and setting the T=
C either too high
> >     or too low and let the in-built OS recovery logic handle these case=
s.
> >
> >
> > Absolutely, just noticing that there is a functional change but the com=
mit message
> > showed it as a refactoring only.
>
> Would you like me to come up with a reworded commit message here?

If you want to change it, it's okay because len is zero at this point
and the code after the "if" therefore does nothing. And the "if" will
become esp_dma_ti_check() so adding a return is kind of messy here.

> > The fact that this is bisectable is quite insane, and I am not asking f=
or any code
> > changes. TBH I wouldn't have blamed you if you just sent a patch to cre=
ate esp2.c and
> > a patch to delete esp.c...
>
> Heh... spending a chunk of time rewriting the emulation of a 30 year-old =
SCSI
> controller is probably an odd choice, but the result is something that is
> considerably more maintainable than the current implementation.

I absolutely agree, you went above and beyond and sorry if it wasn't
clear from the joke.

> Anything else that you'd like me to change before the series can be consi=
dered for merge?

No, go ahead!

Paolo



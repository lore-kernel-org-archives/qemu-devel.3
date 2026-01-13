Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B10BD29DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapH-0005WU-LV; Tue, 13 Jan 2026 04:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vfapE-0005WE-Cq
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vfapC-0003Dq-0M
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768296989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIlCi5Wns02VUYB8sRaXmo5RZqGB5lGXWR590JeS2pc=;
 b=HecYZxIQZJ733lpIqK3OwcpQ8ErWVf25EaOcg7WvJuMSvs6hhXLUOxIGoG6DLOONdSMJS/
 4qLzch36/2TZ91S7K6T/QNkC93mm1/DGW2OU2sOgy0qeLflSCWrRYXaEiu2/NriUrcNo6c
 M29ecW819QuoLPQSzM/cN6pskKgzoyM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-VhLPzRCVOomqASkrsBRauA-1; Tue, 13 Jan 2026 04:36:27 -0500
X-MC-Unique: VhLPzRCVOomqASkrsBRauA-1
X-Mimecast-MFC-AGG-ID: VhLPzRCVOomqASkrsBRauA_1768296987
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-644790187b7so10141585d50.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768296987; x=1768901787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIlCi5Wns02VUYB8sRaXmo5RZqGB5lGXWR590JeS2pc=;
 b=Dla2v0TpQ8Sw4NjRdPqcjBcD959elyC8y1gT08Nux0x79OMcBc1COwE/vQenDnrsEN
 oimLga9TUvnKz0Pi38HqFqOrGwuhirIj8+2Q6R0qnwXeZ4DABe/lQBn03cVDnaH9tRNe
 pMBzDbpHsyEH1rnFmZYhX/Dmu5qICk9DHTzp8vVbgZIL5aEKdnD+RRAs1p4joftVJtYr
 T/Ij0vdZfViA1Ul5+1koc/Lo8jsvgmmHx/WBTZbzU9AFk6VLNb9dAfG5aLSyCaBCEBxs
 qHtN6IAlXRmpwZqnI/pZ4bdO8TxFjagQOBC2eeTYstNizq0bON+vr1amafWKuEz0rSnp
 By9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296987; x=1768901787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIlCi5Wns02VUYB8sRaXmo5RZqGB5lGXWR590JeS2pc=;
 b=f1a9cs0T479SxBSGpjfp9lmOXJNlJEyB9rwbvfCTRWTcqLlqkKjqCS8/ff/5heCawh
 S6QJ0a3n87ge2Q5pUMa17aEJRQelIx4GaNDSG+8iQRYTCeSJAcx3zQnYk3KcwHDSfwQr
 PNwbD8zXICFHy8mNLMlMiS/fMBzAfgNqgyqVurlc01q/Qq0jbW+iqmPPTGR58r4xiDXN
 piUc+ffS6ENwKtDClam/r62GmHyJWb2DdZo5+1I0+On5cfTgkYOcURAf2K4Tx4E1fPiZ
 u+8nuQVd5MgQmV0K4VCVtXrY9WsSO+1dOPc9tRaioPZeXxYyZG0/IGU/y0ek4mvGd+Nw
 Khjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpp3zigc+LDXkPRh/1xyrQGPl6UtQjnCz1D1P1cBwd8i2Mhw1RRDLrxG10B4aaFxSepspUu5grJtNV@nongnu.org
X-Gm-Message-State: AOJu0YwW/Weu/PRWu4a8YY6R0L5D7uBBXAeqbLUOGrmuBbs9UbIv7+V8
 3BGtiyroVkOvOl0fcbPwM8Qut7JTAGhtCRhINP2E3AwSkV5sC8U+SAsYslBnyySuz+tRZCvDuWr
 4EInnU87yEhM6CeJB+PrzqsiEbbWc87L7KS7MPy1j66d/w7NpAVJXfmFmcopE9mD0rWJvPMOBB7
 vRR+LhEosvUzBjWl7NQmVA1HwIzA0Ggww=
X-Gm-Gg: AY/fxX6uQWNE2PgC8z43gLXRMR+F1gg8ptVcWXOxBsy7Qps6GifYKbuSV7m4Xnp9Z0z
 G/UlI0c8ipo3F280pnky1uea3LheorQL9MrSfo2h/L4glPz6oyJTl7/wlfPxXLrFvZu+BWau/ph
 j0p94oJxdEnIshq4W1STda4gCEeF+M+o3u3XxRG13LG2Vmx5rlDjNk+NHZzNbf66tt/Tuya5VE8
 9kXbzqq49TDBSTJ72UrNTqDSg==
X-Received: by 2002:a05:690e:188f:b0:646:7835:47cd with SMTP id
 956f58d0204a3-64716c904f8mr16820136d50.77.1768296987042; 
 Tue, 13 Jan 2026 01:36:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKjYTRIqA/phaKuVKUtZuPI7hGff6zqpsw0A6oZq+VqXpu+OcAcCus47MZj7rTghYHbuc8TNLwmZijL3ukze8=
X-Received: by 2002:a05:690e:188f:b0:646:7835:47cd with SMTP id
 956f58d0204a3-64716c904f8mr16820115d50.77.1768296986637; Tue, 13 Jan 2026
 01:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
 <CANo9s6muvcOrDH286o1zA06tRUvZBnOBqn03e0RiOEDC60W4sg@mail.gmail.com>
 <aWTBdSDO9KKpXLt4@sirius.home.kraxel.org> <aWTDQZT4L3mX3Rfd@leonardi-redhat>
 <aWTEO9LIPNbf9YMe@sirius.home.kraxel.org>
In-Reply-To: <aWTEO9LIPNbf9YMe@sirius.home.kraxel.org>
From: Oliver Steffen <osteffen@redhat.com>
Date: Tue, 13 Jan 2026 10:36:15 +0100
X-Gm-Features: AZwV_Qj3Fdd29A1amIgaXnbBfqyli1-2DYaAiVGZ95HNZgcsp_1ge8w8uG5-S9U
Message-ID: <CA+bRGFr=JPDW5KgcXVp4mdu19cC27R_CkpZDHKzZoJ1xM04XnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Jan 12, 2026 at 10:57=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>
>   Hi,
>
> > > > IMHO this should be sent a separate patch
> > >
> > > Huh?  It /is/ a separate patch ...
> >
> > Sorry, I meant outside of this series.
>
> Not needed, separate patch is good enough, even though sending a
> separate 'fixes' series might make sense in some cases (split an
> already long patch series, or during freeze where only fixes are
> allowed before the next release).

Since there are more identical cases of missing NULL checks here,
I'd take this patch out of this series and handle all instances together
in a new patch/series.

Thanks
- Olvier

>
> take care,
>   Gerd
>



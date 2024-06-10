Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AE7C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiY9-0002XI-K3; Mon, 10 Jun 2024 13:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sGiY7-0002UO-9B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sGiY5-0000ZB-7s
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxAUO5tpNPRjeG6cg/MEPIJBagzzxRrJso39aiI/LFA=;
 b=d2NyWUIe2SV39YI/nK+gkXWeP1KDCnME2NK+apwia4Lpz52IxtmPnlP+q4c2OxnKf3GtLQ
 gnq8hb3obddBd61UDeaMuXt3CkH6a/yJOZJ3viYSCVtyO0jDwtWAUu+jiXbX++WrmkSxVH
 1BsmPe6Ye36goijr4TI6ewuaoGGn/90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VSS0LTXnOcKMpvRolHKR2A-1; Mon, 10 Jun 2024 13:11:09 -0400
X-MC-Unique: VSS0LTXnOcKMpvRolHKR2A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f1f29ccefso1183434f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718039468; x=1718644268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxAUO5tpNPRjeG6cg/MEPIJBagzzxRrJso39aiI/LFA=;
 b=i6HrPSP5gux9LEXaMokhXpLwvj9YL7N0HpxxnQBXE3xzzn0Fqh5jiHLWGNqUJdLooT
 oPNaYvajLaXZc7sIGWN7ljDHog1+ojIWWThnkjW5+gXb84lj0YyvUesoGWxwzJKkZXTW
 bvtJzRERu/ZPutMslkn7OsBfLOfhBzsFwM/thq2vdXYuU4JVbvpEsMOaQprTJPUJeAIP
 9q4Fbzy9IErz5nieVk3cQUucV4K16RlWqhrWg2DF2k+OsnsT4vF18sfQfT3oiQZEAYX8
 oZz+3sEJVZXNGdoYmiTlkgGp21h8+nQ8VXQh/O097N7GNszIayzaKib8RKlCrR7cXpTo
 089Q==
X-Gm-Message-State: AOJu0Yys0BhfoH30jiW2rB6uGHKvj5A5/SXY5qFmfFP+Jea89YenGN55
 EX7TNB14nbN1n5w5CUhhawcGpZ+pbhWy90yW/UIg/HiC6Ima3LXiFrC6ObkDf3wFKFrddryiQo3
 3ajttbZBrtBBDGYZ10LD17v59m35wxF112kASLIOYGJSDr+us5Dxzc7ZnaB9yEjlF6IZU4Zhv/H
 kUA/D7u0DLG7Dzuaws+hcjQCumCS4=
X-Received: by 2002:adf:f788:0:b0:35f:1bc3:50b7 with SMTP id
 ffacd0b85a97d-35f1bc35276mr3001607f8f.26.1718039468721; 
 Mon, 10 Jun 2024 10:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/TmRFtO7SYi1IsWEOeiVCLUARtg3OUjp+hYO4Sm1mG0SxAmtjnpk+BTGzml0H4nLjtYh16Z+5v02Mkh6kbUY=
X-Received: by 2002:adf:f788:0:b0:35f:1bc3:50b7 with SMTP id
 ffacd0b85a97d-35f1bc35276mr3001596f8f.26.1718039468342; Mon, 10 Jun 2024
 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-25-pbonzini@redhat.com>
 <a77556c5-16c7-4676-8356-df1b2adf49ac@linaro.org>
In-Reply-To: <a77556c5-16c7-4676-8356-df1b2adf49ac@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jun 2024 19:10:56 +0200
Message-ID: <CABgObfZbLPJ6Pvz8XNxKrEGjasn5TDpZPC5C=G-p-CHcgxm-Ag@mail.gmail.com>
Subject: Re: [PATCH 24/25] target/i386: do not check PREFIX_LOCK in old-style
 decoder
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jun 8, 2024 at 10:16=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/8/24 01:41, Paolo Bonzini wrote:
> > It is already checked before getting there.
> >
> > Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/translate.c | 26 ++++++++------------------
> >   1 file changed, 8 insertions(+), 18 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

... except cmpxchg8b/cmpxchg16b do have to accept LOCK. Fortunately
it's trivial to convert them, with just an ugly temporary

    if (decode.e.gen =3D=3D gen_multi0F) {
        accept_lock =3D true;
    }

that only lasts one commit. I'll resend this part of the series later
(and BTx as well).

Paolo



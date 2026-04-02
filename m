Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A95AD39426
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8IKn-0006A1-US; Thu, 02 Apr 2026 09:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8IKl-0005fW-VE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8I3l-0001tI-5k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775136359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k++yLDh9zYequfMxBgesJhUG06VbD5owT4tNt8su5wI=;
 b=arXyWEQSkpXPba1dzCpRLxfN4XfUOArrnaLkAyY5nEWIL8NirpvsZpyt6RiPaDynk7MrZV
 bUBuRKFESLQDJDCLWZ+3Wf3wdbN5GXAyfzy0a8b3loO5UPwhRxWuJAUPDvHb6QZLAMKKAf
 Ezo5MG+v8HH4w56/uRs2v24kLKIbUbQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-jBB9vzn0O2qBerOnt9dY3A-1; Thu, 02 Apr 2026 09:25:58 -0400
X-MC-Unique: jBB9vzn0O2qBerOnt9dY3A-1
X-Mimecast-MFC-AGG-ID: jBB9vzn0O2qBerOnt9dY3A_1775136357
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76b6ccf298so601972a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 06:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775136357; cv=none;
 d=google.com; s=arc-20240605;
 b=ReloHz+KkaCW7f2oKWwnTncxGR+NCaEiUYwu7Mmn79UQwDMk/vWUP1bkcPM55MIfvt
 B85AN2G6aua6R4ftnpNjMjxDrb7LrYyUMK3Hz3uIzuirAkahdFX5OxiRNvfjWBmhfXVK
 PvgUSKoAkYxGLA3wNLkhS3YHA0xuVXeCCn/vJDcy/S5HHgPNwUOEmIWGhCTsRze9XX2y
 m/g8BGZdQCjLbKtepyUIxcVoLNyDfd0poT06VpEl4aEGF0VBk5xYj6330Rfi4UyvpJe8
 3fpDSZ9l6lyC2qfVtqWVHnHRzYPCybXDP6Q4aZ3UDVaWlVjeSaDtZIEg1cbiE3b3ZIpo
 52sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k++yLDh9zYequfMxBgesJhUG06VbD5owT4tNt8su5wI=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=EDREFpF3WW6K/cIYpIAfBSYRBT72/bBrAZC3S0ZU2CSyo/zEoIrs+IXOyypBYNfd8g
 Jwn9yXTeQItz/x/T3DAgIRt2/2WydhhGOSBU6fVwPI6sydQCPDW0+GeGsNNsP/JnU/u6
 ijzDbGUig1Q2TV5MPTdsb3gRWuN7zwi8RblDvLVDIcfinVLH61eIwSxTMWixsClY+VF/
 6f5FQ1FEVfwg4evg2Fp1l5+krWbi2ZDHrryzKhSWSJ9o5WMylg+aQbs+KbnekQxRQnfl
 KodKBEiSKm0CzX3ozZC6nIR60F/u3wvs4UCJnDL2TN2crqwNiDteEXOazJQEl+2Ig9iT
 IN4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775136357; x=1775741157; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k++yLDh9zYequfMxBgesJhUG06VbD5owT4tNt8su5wI=;
 b=fWXm4fZDU+pstCh9lPjO1rmVdapZA25/stQOe0ZvfjcKzj8xPNSkQ4rY6r78JLlijv
 icIMCmMgzPmejUnRIKZ8nGHQHACxYCxxW7nZF55tR7xtGidLx+ab+1kIXTSz5ce2tscG
 UyuyYfXBrKNETFbBf1c4blOsnOtayL6UJ/VrmzAEwUOXf0q4HJTtOluALeDnJsspoGMe
 BAdSbd96WLsEsncW3pRHg+ceuUFihj5X1lRRc4Lvt4q/euwlxAEqNfR77BjyyuqggjYu
 ex9ruJsDh869XVIiq/9/F8G+ASXg+Xpl4AOUH8Gvo8C9/xgfjg0UOQhPr4DtTrl0mtqX
 knEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775136357; x=1775741157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k++yLDh9zYequfMxBgesJhUG06VbD5owT4tNt8su5wI=;
 b=VGrLVpLbx3pfrN+wsGrl4+snxlNqvY7jiDX8WfikOgLnWgx8paObMkNFyhplUCkCzS
 qJta+DriFnaeNGiHoFc9NFqfICbEpaPHOiHvzxG2xsn3N6xNdIw9oBLjWIJmX2iOYu0J
 X2BJ9a97wwhLjBZl0obeY7NOBGlX6KH10sDwCkAyIXxPtYceJRX7ge11TfqOetLcDbVu
 k4x2umIqiy7KQEPabDxslKeP9O6ZyFnyhN/rkOy3tC68O2HY/bVUYMEmambFPeSJSI0C
 OH9cToIZND/FHK75d1k9yxzmSqyjxXqgpnKpOwh5b/h33+BeGMi52yMVcL9FnOuDFd5v
 wbmg==
X-Gm-Message-State: AOJu0Yywg0taKrcGe/K6E9J3mtfc25Q6cOEh87G0IJbLZeJw3+IhAn5t
 cWYfrSKYsXmJnxvLfVH5r3S7LNT6ABk2Id+kKFuyTyztHulVc9p/6s5erkh6JT2XqKzCz8/XEHl
 q7zNaFhjQOuxr9nK9Ahlp0CoQsQPoSET3cCT4pzqDxlf3avvGthHb4DKR6PKYltfygr7YmN3zjF
 0oIWWqOIiKUddUBmdphbdUgV8wThyjzLM=
X-Gm-Gg: ATEYQzxbQYoPOInIEWcj5WrE5E8XdPzPMl5s2/K7Gua4l+pnFQsNaxti6NKoaUJ9diy
 EmZL/GpCjFiS0mZFTPsqnj0YmFtSLOTgBKXL8noSbUmJ5KIYlkPJ2HsMwHp9BRC7DFjMPolHa9q
 NG62Rq4ZG1rzEQO03uiFZ6fgwK1+zmBcFgBj1iHgs427RmU7gAvzcHhM/JmlkOCOooYsJPb40xD
 vXcXQUttWnw/mcgnFtTGRDBrp4jDLEiGzACJrHT5JdJNiyDQN4POSymKXd1puBsaL44xDpb4LLz
 hAAqrhkyAXa0nJRLLnA87yk=
X-Received: by 2002:a05:6a20:7346:b0:39b:e0f4:322c with SMTP id
 adf61e73a8af0-39ef7539f41mr8421299637.27.1775136356886; 
 Thu, 02 Apr 2026 06:25:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:7346:b0:39b:e0f4:322c with SMTP id
 adf61e73a8af0-39ef7539f41mr8421278637.27.1775136356460; Thu, 02 Apr 2026
 06:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
 <9422301b-1f5d-4d60-bb33-8bace0bee1ae@linaro.org>
In-Reply-To: <9422301b-1f5d-4d60-bb33-8bace0bee1ae@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 2 Apr 2026 17:25:44 +0400
X-Gm-Features: AQROBzDGcgD9LML71bbcWwtQ1jPqjyyRZZOtDw7wBOEMQ3qQnKZNZxO4-ZpgrTQ
Message-ID: <CAMxuvaznsgWXZT4eJiW5nPb3MpXRkb+NVmuqEN_c0mT77nAgLQ@mail.gmail.com>
Subject: Re: [PATCH 26/60] ui/console-vc: unify the write path
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 1, 2026 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 17/3/26 09:50, Marc-Andr=C3=A9 Lureau wrote:
> > VT100 escape responses (DSR) used qemu_chr_be_write() to write directly
> > to the chardev backend, bypassing the output FIFO, while keyboard input
> > went through the FIFO and flush path. This inconsistency could lead to
> > out-of-order delivery when both paths are active.
> >
> > Introduce qemu_text_console_write() that pushes data into the output
> > FIFO and flushes it, and use it for both keyboard input and VT100
> > responses. Remove the now-unnecessary vc_respond_str() helper. Rename
> > kbd_send_chars() to qemu_text_console_flush() to better reflect its
> > purpose.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/console-vc.c | 29 ++++++++++++++---------------
> >   1 file changed, 14 insertions(+), 15 deletions(-)
>
>
> > +static void qemu_text_console_write(QemuTextConsole *s, const void *bu=
f, size_t len)
>
> Nitpicking, maybe take 'uint8_t *buf' (or char *?) argument for this
> console method, letting the FIFO8 API deals with void *?

The function is called with a variety of arguments: char*, const
char*, uint8_t[16].. So this would add some extra casts, I am not sure
it's worth it.

>
> > +{
> > +    uint32_t num_free;
> > +
> > +    num_free =3D fifo8_num_free(&s->out_fifo);
> > +    fifo8_push_all(&s->out_fifo, buf, MIN(num_free, len));
> > +    qemu_text_console_flush(s);
> > +}
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF7BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUqV-0003Zc-Sh; Tue, 04 Jun 2024 10:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEUqU-0003Z9-7R
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEUqQ-0002iT-SQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717510134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPzIY6M5iM5myLDZrR0eIAOdhTrU/jaJLHaKcZG6EJg=;
 b=F0JNLXetVKGaKCXyRkRPvqVIUcZW0RtpEb4m0QuN2QmdMycH+ng8faJDW3uKrk82KczhAn
 lC11I61X7lywJhMn7KGN5RNEZjMi7tPEvulTQHWvlXa2CMxzB6LQKHIokdLhHU5MMr9n9e
 oJPOO2vX/SDf4M3nu4aQmf19XOVOB+k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ZaD58tI0NKSrdBz2MkOBBQ-1; Tue, 04 Jun 2024 10:08:52 -0400
X-MC-Unique: ZaD58tI0NKSrdBz2MkOBBQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52b8c8a9a01so713457e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510130; x=1718114930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPzIY6M5iM5myLDZrR0eIAOdhTrU/jaJLHaKcZG6EJg=;
 b=It+57tSzYTxTNIAkv2v3673uIPdJJ0VD0qOOr8SPsCyO0dVAiXjZchK65QblvQ0tTg
 ZUMPWdhBt8ZsmU7Y9vCcHvaW7EnExAnD1ESvozlsiRTRWkbfus03FLq4U6PJ1weur1t4
 VDVaCatrBLoB7YTeyLoln4W3MXYABkrxPlH0tCs5If466jjnxpTUTtwz/Gso3gRA5nCv
 Q/OU+08Ld4x0RWRd5WYTb3PTltvLxN+0VTOQdxU4qeB+Jds225fth4/uLDSZO162VDNu
 qOudeQdQfmPX75RQ0xcq98g4GsOo4nH9KWUYsQ3hxeIqdcDEL+MUCvkIVmhFUc+lbTFl
 s4qQ==
X-Gm-Message-State: AOJu0YxVV/TTKpIb9jNEDd12z7F6sNks1SSOo0v7Vmh7IgctKVyHRv5c
 Ek+nQk17rJHqcfIiRwZ4UuTRRagipleZV9wNmjSEwWGPDv+El2cC6uTQR+lXcZ3CfgOKG6sHjmP
 zTH0+HA0C1THGncr202P1uDAf9BJ+4Esql6Az2B51XalJGZhszFYI/26RlKMtiXEi7HcgwKIK3W
 KxXQvW8PD4fnMTCjEEbjgSRYDKBmfEYnUoNoU=
X-Received: by 2002:a19:8c58:0:b0:51e:f7de:d8eb with SMTP id
 2adb3069b0e04-52b89569681mr8266852e87.10.1717510130330; 
 Tue, 04 Jun 2024 07:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxfBpPw93GGA/kb8nwlxLgy5Xnhmmz5oY1jQGEFcBS2DTVm3hCwfZGtF8bdS8K7/lEmyLLGBhHkW5uD8/sf6k=
X-Received: by 2002:a19:8c58:0:b0:51e:f7de:d8eb with SMTP id
 2adb3069b0e04-52b89569681mr8266835e87.10.1717510129959; Tue, 04 Jun 2024
 07:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-5-pbonzini@redhat.com>
 <0e63b24b-7010-4688-a266-808958cd055c@linaro.org>
In-Reply-To: <0e63b24b-7010-4688-a266-808958cd055c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Jun 2024 16:08:37 +0200
Message-ID: <CABgObfY052DojdW0cACW6RdXFAexFuYwAF14i6w0YXuTm_xmvw@mail.gmail.com>
Subject: Re: [PATCH 04/11] target/i386: cleanup PAUSE helpers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 4, 2024 at 12:59=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/4/24 02:18, Paolo Bonzini wrote:
> > Use decode.c's support for intercepts, doing the check in TCG-generated
> > code rather than the helper.  This is cleaner because it allows removin=
g
> > the eip_addend argument to helper_pause(), even though it adds a bit of
> > bloat for opcode 0x90's new decoding function.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/helper.h                 |  2 +-
> >   target/i386/tcg/helper-tcg.h         |  1 -
> >   target/i386/tcg/misc_helper.c        | 10 +---------
> >   target/i386/tcg/sysemu/misc_helper.c |  2 +-
> >   target/i386/tcg/decode-new.c.inc     | 15 ++++++++++++++-
> >   target/i386/tcg/emit.c.inc           | 20 ++++++++------------
> >   6 files changed, 25 insertions(+), 25 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *e=
ntry, uint8_t *b)
> > +{
> > +    static X86OpEntry pause =3D X86_OP_ENTRY0(PAUSE, svm(PAUSE));
> > +    static X86OpEntry nop =3D X86_OP_ENTRY0(NOP);
> > +    static X86OpEntry xchg_ax =3D X86_OP_ENTRY2(XCHG, 0,v, LoBits,v);
> > +
> > +    if (REX_B(s)) {
> > +        *entry =3D xchg_ax;
> > +    } else {
> > +        *entry =3D (s->prefix & PREFIX_REPZ) ? pause : nop;
> > +    }
> > +}
>
> Thanks.  I had wished for this
> from the beginning, but since it wasn't wrong, I didn't mention it.

Yeah, I was still making up my mind on the style. Using set_cc_op()
for BMI instructions was also silly, I'll fix it soon.

Basically I want to get to a point where the common code and the
helpers are all set for implementing APX, then we'll see.

Paolo



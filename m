Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A28ED4334A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTnHP-0003Uc-Gz; Thu, 11 Dec 2025 15:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTnHO-0003UJ-Jh
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTnHM-0006BG-2Y
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765484927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnWE+Kd+N6RumSLoFZuZ5rkBVuRjG2TWOzDVVit50pI=;
 b=aAPI0ksi7oX69ged7eM7N/kfgCQTpEeGKO0k0ZJ8rczqUeAGBGz7SBJekKM4HThYQwWPcA
 kCspYfhfrE+s9yMfy41soXfcIw4T/62adzM+3c29t5dkzSXCkeiyE7WrL1zcEvaXA25SKx
 1zQApHwjE0/2ivccXOx3pl37K6Vy7hM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-GuG_PHZlOtOmcbstch1QWw-1; Thu, 11 Dec 2025 15:28:45 -0500
X-MC-Unique: GuG_PHZlOtOmcbstch1QWw-1
X-Mimecast-MFC-AGG-ID: GuG_PHZlOtOmcbstch1QWw_1765484924
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so250133f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765484924; x=1766089724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnWE+Kd+N6RumSLoFZuZ5rkBVuRjG2TWOzDVVit50pI=;
 b=su1YNlo8T3HTL78jn9rbEurrTC8ye9jGT0rOI7Yj986zJ8csKDXBcgNbN7vcdwqHJD
 cFCyDfoNGs2oTPBbrSlLxVoF6yDOsmshWdutpj4SAjGGysKgSldg6vPv3Bk2AVRvTPtj
 6QLfQUkjxfJ+7wJSQQr2O4W+aVqLEBSDGZqAlWg+JLkz1HduKk+OvSblSbpE7B5GGWsj
 7Kfrj+CjTH6JcX0fNXt80cxxnr7+K7UI1X/Cq02FNuB6HKToqnR6IQ9qe3u/nx3M9Jxo
 kGdy1VNG/i65ANRauTHup/TcGxI+1TM59IR7Ui2NSobN3GSOhCr1ji9rMC6/dCzth5xl
 Sldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765484924; x=1766089724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CnWE+Kd+N6RumSLoFZuZ5rkBVuRjG2TWOzDVVit50pI=;
 b=mO2FMcegtOL9I2v8+hp24OsELfoiYE5SRVY7S91kMwIjQyeECVm5SlV8CVcOXXtVgB
 Jmj5TAjR3EYGtT4zOoYSA+6mbmimJi358MDpn0eUvnh9mFsVrhLjUuhdWfowzoUTCMpA
 k5rq//D7I8Y5JSLf7xkjJRpRlVsMAZDPAoPXQmZWwgHgMRwdwRpsfm49cq7O+oMfi8h9
 Xdwz8RHwOozf9ThtYAHzRnusWYSAqXVqnX6L10usdj6NpCzsJ0XS+cJj9AEgB8jeh1d1
 jGu5Cg7IBxHSywzu0SH0ygVPC9I1Yv+scYNO0ds5euDi4gAVwv8vZnFsgqc36RzSEyI/
 5M+w==
X-Gm-Message-State: AOJu0YwfphFwsVFq0SczXGNl0WJisYvJ/4PWRLoRx0wANkmEGXTJKkVB
 JWAF3iZjGgkp+Um+Qz8cO2pdk/6lSfLLZVGw51fThbpMYS7F2Uq6y6wdSO6RARKel2QonBuOe8K
 /MXXPgX53wCK2fQBZPVxL3/fut6Ow+gYLkgqMn+Y2TyLvf/JC1bhs399uBBdXNryFdudBYZMyEW
 m3VW8Ymbsjr5aj1FtT77+bO6LJXyAAexI=
X-Gm-Gg: AY/fxX6s2Wfw8K31Dok7gGcDIMkwJJ66PDw5O/CDMSBeaVErEzGg101vmwNj7ToXBxb
 Nzl0vJ+M04T4GdUHvh2E4LVTZXKS0aIqCN5PsCl6ncB/rytnPnNLlz6rs6W9o8SIZFDG4lVfBnw
 V3uVKP3vIYcpqjf6NJOnBZikjT6Mff3PHwiEfC3/GIfi9prdywI8BTchCtzvZzJNkm/DjmiP/yG
 qrjOacXNLPXuiUsC8JEa9ssK4sFJvQZCevWwxAwGXxBwoaSZE4eVGJA4iC8hpKs+gxNLfw=
X-Received: by 2002:a05:6000:40e1:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-42fa3b1f218mr9008745f8f.62.1765484924513; 
 Thu, 11 Dec 2025 12:28:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHisEHlnKtZjU/fvZIoFBV2Uh0vDMIUBr7nBdl1KaEt0sobHhJU8NgOgI6d1CF/1jR1WvioqusylZscMSIaYX0=
X-Received: by 2002:a05:6000:40e1:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-42fa3b1f218mr9008727f8f.62.1765484924119; Thu, 11 Dec 2025
 12:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-2-pbonzini@redhat.com>
 <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
In-Reply-To: <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Dec 2025 21:28:32 +0100
X-Gm-Features: AQt7F2o02SSRTGVZW2LaWK57pW9sN6PohfNHXw0ev29SN-JPI1pNyIp9kOFpk4k
Message-ID: <CABgObfb7xNov4tW1m1Yru+-p55zGW_3jsNXyzL68_NjY0XnMtA@mail.gmail.com>
Subject: Re: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB
 instruction
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 11, 2025 at 4:47=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/10/25 07:16, Paolo Bonzini wrote:
> > VSIB instructions (VEX class 12) must not have an address prefix.
> > Checking s->aflag =3D=3D MO_16 is not enough because in 64-bit mode
> > the address prefix changes aflag to MO_32.  Add a specific check
> > bit instead.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/decode-new.h     |  3 +++
> >   target/i386/tcg/decode-new.c.inc | 27 +++++++++++++--------------
> >   2 files changed, 16 insertions(+), 14 deletions(-)
>
> Where do you see this?  I think this is wrong.

Yes, I was confused by the comment and by QEMU's incorrect decoding logic:

        if (CODE32(s) && !VM86(s)) {

which should be changed to

       if (PE(s) && !VM86(s)) {

And by the way, this also means that we need either separate helpers
for 32- and 64-bit addresses, or a mask argument.

Paolo

> In particular,
>
> Table 2-27. Type 12 Class Exception Conditions
> - If address size attribute is 16 bit.
>
> and
>
> 2.3.12 Vector SIB (VSIB) Memory Addressing
> In 16-bit protected mode, VSIB memory addressing is permitted if address =
size attribute is
> overridden to 32 bits.
>
> Therefore, in 16-bit mode, one *must* use the address prefix.
>
>
>
> r~
>



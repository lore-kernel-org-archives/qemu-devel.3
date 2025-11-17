Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36415CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuvf-0007MY-Rb; Mon, 17 Nov 2025 03:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuv6-0006ee-L3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuv5-000761-4r
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tliqKSVVLfCrngXBrAabVIXWfdW/o3DdRFdN4dB6hGU=;
 b=Og5husV/ELNbe2ygweDXkWzmFLF+02G0sQsUy4oUy7JyLCuGPi7qN35g78cteS4kC//OkD
 hgWQjz+gkLhXV4eaZHqSkHCYc1+Gt9VYEb0jrw/vAVjdxQG0ErBbL8wKSOy4dBsv6GHLkx
 5DjrOuyJDPNYLZFZP1EaLqUGGuVMDlo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-BDJr8EFMN9Cr53UrbrxN4Q-1; Mon, 17 Nov 2025 03:49:04 -0500
X-MC-Unique: BDJr8EFMN9Cr53UrbrxN4Q-1
X-Mimecast-MFC-AGG-ID: BDJr8EFMN9Cr53UrbrxN4Q_1763369344
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso3142204f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763369343; x=1763974143; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tliqKSVVLfCrngXBrAabVIXWfdW/o3DdRFdN4dB6hGU=;
 b=maJx6KKwv1oiO/2/7VWBke+q4sYhAfnpOEfDdqEc/ie4B+dwN4wJrEg3IU8cE0lkBw
 N4mKMppJuo0wvAmgA6VCVBDkp7gGXxwOGqmIUK3+JaVs8/b7VTENs6Vyg87hM1qiKvyP
 TgVhjxt4//r1iulN47mJ/fWL4CjPb8d4nlGAUc14yvJrElJwBaMCG5dMQst3Zy8gntBS
 HkIWbqbcldiBCeg1n8HgPEP3Oq6Sm7dNckBckRLiZTz5iF3WSgeh12flgDvk9emLhSaT
 xQg60+8BxDWfs5I53YTEz2ayvpSgcjb2lPwhtneazs4nhUlw9HgYMcwOyxFmzOuJuJHa
 UbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369343; x=1763974143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tliqKSVVLfCrngXBrAabVIXWfdW/o3DdRFdN4dB6hGU=;
 b=v0AjmDCBQrK56e3vDLPh1Sey7MWP1/NLflqCaTlqIasRBtmcnW7BmTeslI6KmblRHS
 QtnA1S9m3TYoC3yT0xCsPAU5+coDRV3i8F/Hp0ttOM/gNbifdhYITAGQMHfmMe5nUKb5
 HBl9N1Ji9WPFV8/lhPKO0LyoHpII6c/qU038vtPgGu1Xtbwqe6cDE0cckTPjeow1Wm0P
 QmBxS7pgGaj69eEnmybeJ8gfdXPNkWsci/PoPw2AFH8nWe36ICPlAsck0Yp0xhRrcSs3
 yBlhZ/2MJhe7OBh/kThr1GlKbU5tGWdYDu8tM+ah+6lv5WIjX2iw2jeQHP67qxQgIuBq
 6WPw==
X-Gm-Message-State: AOJu0YxElMSCkUQc00yrM7Vspyj2ceMc0h4VBsTqgd2CR4EvB75g7Qyb
 pEYr3UupBoHiyjF8bkEWzT9fbgQZJjQHbkv3MiXMomalAf1ZbTBpqmxoNOhYotShu4GFSOGG9rh
 UbLwU7gFRa/CmOSZdQfqzVD00oGEpBX4nK6AK+S2I0no0zEoDhSFJT5iNYajNu71oiEGicxTftV
 FXNe6zXGlvGoRGGPP0NW//2q8vEFj0RPSGq90l3tU=
X-Gm-Gg: ASbGnctrvnhJZWyIotT+gWxc6Q1GrPvP0jH6CYYbWzfhqrisDwqCAha/H/1NUzjQqHN
 tOTzwN64RIdr8+eAHHXZc7W6mFCd3Lrd+0F6ZmKmD1wZ38xHBD3WBLM8O7cWu/Iit4KT9nNCstn
 /mONPbqVyX7vhSb3mjjJHzIm2xDFe08pZ7AKLo8UHXKaqrTQAgx/5B1j56lDgBRJOjeOENUkAO5
 uRM7uc2GA3NQ2btEC8nCNhP9Mw+mHIwF8nq0z6Nh5tpS5gcLe2enVHX08DT
X-Received: by 2002:a05:6000:2f83:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42b5935241dmr10724675f8f.26.1763369343301; 
 Mon, 17 Nov 2025 00:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElk61xBndh3pqZne8krYD+WD91i88AujeVdBzUVvyZrIX79umdhiqFZffC9mDpdQPbK3v0dBxH8xK6kqZw0gI=
X-Received: by 2002:a05:6000:2f83:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42b5935241dmr10724649f8f.26.1763369342870; Mon, 17 Nov 2025
 00:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20251115015410.185195-1-pbonzini@redhat.com>
 <b6d5aa11-eef1-4cda-b008-79ba8ee89e1f@linaro.org>
In-Reply-To: <b6d5aa11-eef1-4cda-b008-79ba8ee89e1f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Nov 2025 09:48:50 +0100
X-Gm-Features: AWmQ_bkpRyrm1mGVt0TvTVnguqs3Lwez42a74uU02JTeF3th4vbPjK8pWHx7Tu4
Message-ID: <CABgObfbg7R7NH4rb-cKsMY-K0zUSufCGO3HrWg6Y2NZiKq4GmA@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: fix stack size when delivering real mode
 interrupts
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Nov 15, 2025 at 1:25=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/25 02:54, Paolo Bonzini wrote:
> > The stack can be 32-bit even in real mode, and in this case
> > the stack pointer must be updated in its entirety rather than
> > just the bottom 16 bits.  The same is true of real mode IRET,
> > for which there was even a comment suggesting the right thing
> > to do.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1506
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/seg_helper.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as a=
ppropriate.

Cc: qemu-stable@nongnu.org



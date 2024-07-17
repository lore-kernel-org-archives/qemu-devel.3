Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E124C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4Rl-0000c5-HG; Wed, 17 Jul 2024 09:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU4Rj-0000bb-Jp
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:11:51 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU4Rh-0003jX-10
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:11:51 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e05e898f29bso982140276.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721221907; x=1721826707;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9fuLgzSiFqX6I/uO+t8D7fCBOMObKi3Ab4CVPYlTbqA=;
 b=QlT2d6BPW4ve6g4GKgwMjhgrMu8/0iJIIMAJ1X/2kb+mx7rdjT3fF11U3p3syWtY0o
 eutyTTP2bwPH4fyF0as/MA4dmZKs16+9mk2HPvdK4ie8JmTxxSGdwqwcQDz6MSUIgvuw
 z19pwbIYGhXCv2fIU5dPd4eF/RHm2wL2UIlCV4c0FdfJTWpszNMT0D+4vM9+ovUPpTdG
 wT6Dl6JT2xKNUHkBOh+2PJIfxApNtD1e1zmajxKkAsU0qwUYRIjtB2KtOjjWIhZs+LXm
 1Y4B7+7KIuYXas2BEWQqz6//+TlUF2k6Jh9skCpyfasCZyOBPO78u8QdHBwOjrJ/QdkL
 LSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721221907; x=1721826707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9fuLgzSiFqX6I/uO+t8D7fCBOMObKi3Ab4CVPYlTbqA=;
 b=qHll2ZDk8ipf36LLvLPP5bHMLCMEkPYEAv7hr2UqDfRPKLsEQphB6QUpVEN9mi/8fZ
 sAcaP1T87oZ0LheS/bP0opzSYz2Bxl7gpAOMBXncyGi5F8kdpc66NCHKtoxuPib1zM85
 3SNkdNLnisbKzB7zHUpo9zRn/S2uckxlNkrYnnfampdfS6AWOLn2mF5jkfBYV56ig4AH
 bx9WnADhNkWGO5mxeyL2lcvALp/EUBKQWjHGnVtKK3HmuIqRZeh/z3hw0oCbfsTsLIX1
 OHFaV+ye+zS54Y/FQ+7BD9v0jXAuNRt5vbCajQTSwsMWfcZB+q2ju/evIIbbOF3E/F7D
 c7Bg==
X-Gm-Message-State: AOJu0Yz1US1BEeaWcDYZYmMCuUsTUyx+Bl1m/Xf0HHgFucXzwPdc5Nw0
 VlKdnGAOj3sRuNdTzu3IvhWHTpMxhPycmvIhgNPr5QCoh5RBLXuzjN/qFE6aEgA+klKpMMxdRrJ
 eZuNimTCFpdsFFpb3LCKeMbyh9YDmbePm/AxI
X-Google-Smtp-Source: AGHT+IFnsYIzpCouEJpT1HMa0EBdmtgGSGdd+H2J6kVynAcH+smI2Bc+8ugBxFIB5+VPDALfvflkqqMadbSeKtrmdB4=
X-Received: by 2002:a05:6902:168b:b0:e05:9f9c:5516 with SMTP id
 3f1490d57ef6-e05ed6fa4bcmr1957807276.19.1721221907333; Wed, 17 Jul 2024
 06:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240624101040.82726-1-phil@philjordan.eu>
 <CAJ+F1CJMzyWr3y7kEGcj2hE8fogLqH_PBcHkXYK=N28+t96OsQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJMzyWr3y7kEGcj2hE8fogLqH_PBcHkXYK=N28+t96OsQ@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 15:11:36 +0200
Message-ID: <CAAibmn3s-+_21sUVf9w9HKVysTM9xgxYBq9Vg0+9iNMC1K7=QQ@mail.gmail.com>
Subject: Re: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="0000000000005de084061d7134c8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=phil@philjordan.eu; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000005de084061d7134c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
>> turning alpha values of 255 into 1 and everything else into 0. This
>> means that mostly-opaque pixels ended up completely invisible.
>>
>> This patch changes the behaviour so that only pixels with less than 50%
>> alpha (0-127) are treated as transparent when converted to 1-bit alpha.
>>
>> This greatly improves the subjective appearance of anti-aliased mouse
>> cursors, such as those used by macOS, when using a front-end UI without
>> support for alpha-blended cursors, such as some VNC clients.
>>
>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Thanks for the reviews folks! Is there anything I can do to move this
forward? Should I submit a v3 with the review tags included? The patch
continues to apply cleanly so it didn't seem necessary, but I admit I'm
still not 100% clear on whom I should badger (?) to get favourably received
patches actually pulled into staging/master.

https://patchew.org/QEMU/20240624101040.82726-1-phil@philjordan.eu/

Thanks!

Kind regards,
Phil

--0000000000005de084061d7134c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Mouse cursors with 8 bit alpha we=
re downsampled to 1-bit opacity maps by<br>
turning alpha values of 255 into 1 and everything else into 0. This<br>
means that mostly-opaque pixels ended up completely invisible.<br>
<br>
This patch changes the behaviour so that only pixels with less than 50%<br>
alpha (0-127) are treated as transparent when converted to 1-bit alpha.<br>
<br>
This greatly improves the subjective appearance of anti-aliased mouse<br>
cursors, such as those used by macOS, when using a front-end UI without<br>
support for alpha-blended cursors, such as some VNC clients.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br></blockquote><div><br></di=
v><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</d=
iv></div></div></blockquote><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.=
odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt;</blockquote><div><br></d=
iv><div>Thanks for the reviews folks! Is there anything I can do to move th=
is forward? Should I submit a v3 with the review tags included? The patch c=
ontinues to apply cleanly so it didn&#39;t seem necessary, but I admit I&#3=
9;m still not 100% clear on whom I should badger (?) to get favourably rece=
ived patches actually pulled into staging/master.<br></div><div><br></div><=
div><a href=3D"https://patchew.org/QEMU/20240624101040.82726-1-phil@philjor=
dan.eu/">https://patchew.org/QEMU/20240624101040.82726-1-phil@philjordan.eu=
/</a>=C2=A0</div><div><br></div><div>Thanks!</div><div><br></div><div>Kind =
regards,</div><div>Phil</div><div><br></div></div></div>

--0000000000005de084061d7134c8--


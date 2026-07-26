Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA04C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 17:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo2KX-0005Tv-HT; Sun, 26 Jul 2026 13:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wo2KW-0005Tg-D9
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wo2KU-0005pO-Fs
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785085676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
 b=fscehHQwXUeydLsaH85/SH3/KbGItu1jrZBCLo3KIgvxJ/5s1dEwp4dWacajdzfHBGzKCT
 Tfe89nW+uanW8xZ+EhOBKN19ZbaLrozenHK+n3knrjSNHgiYDwTwP4yrRdyIxptyCl+Q2P
 +W6ILdfCvQPu5n7V/Yi4pixH2eU5m/g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-JyEILz8EMTut5Ij5tXbaYw-1; Sun, 26 Jul 2026 13:07:53 -0400
X-MC-Unique: JyEILz8EMTut5Ij5tXbaYw-1
X-Mimecast-MFC-AGG-ID: JyEILz8EMTut5Ij5tXbaYw_1785085672
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484b9fb055so4594210b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 10:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785085672; cv=none;
 d=google.com; s=arc-20260327;
 b=FIegH4AFe0OiXxIkGhPp1NowN4Kj2ev6AWjRjPWybwBjAFTwAX0CjPPoBAhEx2X8Bb
 xBMyS2AdgATeDJPXeOP2kUaJ53tZ7E39Nfccp/kazJm04WwdK90Ao5U4NnslJTvO6u9G
 q25aa3XsM8yUY3JQKGllJbiGc4QPIxiItOIvu1YXu12QTJA76voSxb+fG37qiagtyi+v
 ns8zykQZjhvJ+Yi/s90joSafcWjPaXs3ani187xXm5eetrCCVVk7QKGk6zC8deGCm+fz
 lMU0TX6V6rjIJvh8xttPgFKHgW1ja4MCdZi+MCQey+nBLs/31bxUbXhHpGHH33E8RRLG
 cl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
 fh=H43sBeeAJt7YELhQKIaki7qmlCjYtNabp1Cv/0P75oA=;
 b=Ejm8lTNHW00HdHQEtQh3d9V9bvrlgOUHymYpirpgWV2lIWXbnpIs0SiSWr61sn+35j
 WB1NYS7+qYrpLjvPQJgmk0Z/EhCp6KFedw4Hp+Zz2DQAEFMoLixcMWY3Ldv2xeJFdstX
 Cy6953F+kR8AtdnmB5NogfPQu/Dxz79Ep3J+t583/jmC9RQfRDF/bVO5+GcFRPEvi//R
 xs48pCYuQSeaToUUkS3Wtvm9PP+Pl9whLws0GW3Yke+xjFds5YM3NKVF1RfD3bbI49Mp
 SGhqzzIqm1XN8HOZVzz60kUuod3vlBTQs6W2VefP6dhwsTW77Sel9RCJx7TeZynFo7h7
 UrcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785085672; x=1785690472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
 b=StMRzYm33rOgj01RLXEOmZD5cbHH+vQuVMXDnkm21sOEmW0SM2/0UU0W6QflsRM5vR
 lrzlorsUGCKvu9AsFdeWiYxpWsr9PTRfUexUbRHx+YMUd8q+7BLK1xjgDk6BQZGXwOGx
 64VQ5K0Nf93B97JX/Rtgj1sdhzdYCodGNnOknSq/XZw4quHwa+eZ2zVoSaKtz005SWqG
 c2CG4d6oDLEbmTHjPGUwKbLoQwdMCgwZw//vzFNnNEegDf0iuzTmX29+dhTga81gWq8w
 4vEUHzyDx/tmFaQWNbJuFQqKk3jMNFxz8rNLWSE3pmZhnfnDlrt/7moBPXBQJk3A91aM
 WwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785085672; x=1785690472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
 b=ESKi3pNwwJhUgCe1QmBu7QmMtrtK7CMIxo/4SAERnPjobMpL8JKN973Jvddm4IuK4X
 iesv36kp8XobAj+vgtRsLA7IydaQzTq0vcXoIT6PILGMaFffI2M7SYY10WAwrCfVeKGn
 gAwzUA4gJgsURZzJElIj8M5d2EIgLEmPPhgiOrc1I/wCkmfUeH9QF63d0w2NwFSq2kXz
 EhlXHWdS19EeMMuoGcRh2pXB/XYzo6jC2bQzzY+TTU8SeIyWvwvBIJ35HqEwBOuM4Xfi
 D7yOx1oGHhBCQmaIdv1qKIAdn4HphjV9RuVnyBzIYoKHbAOWaI7jCGP38frzvWYxqpxk
 x+BA==
X-Gm-Message-State: AOJu0Yyb3v1TszHdI4/yuQZTmcBbBb/ffkjFWdX140uHF0KED/8UTERy
 yORLAn+oN6LDOofhLZzbV0V8pJzRskgFb7NpiYVHGP5xYxZgjSaoHZoZEXyFnj7xAMFhkn0WWwv
 8j5gidhum5x3hLpup1RxNE5aQqF6q+0xCPiMVsFWsav1hCQ9JwGQmKo4ezidLrr5z/FPd1FgA9n
 zWgvpgew4NbyURAoMb65npe/8XydUZTfE=
X-Gm-Gg: AR+sD11uQuFQK5cQWfZd7B/LYrDi8IGIfZhH14t2oTDnmid5Ga2vAF0WoHuNOnd4BWv
 WhIhUseVmR83kHf5en7fWpMs1ZukQT/vGK5RoPW7ChwvjSuyS9ijrRukXtemk7pmF6qSgZnbXAx
 YQ/mWCyWOYsQMQ8iYKOy2EyY+hcmtvFcdJ9W2KaVnd4xke+Nx+8LmKG+bs1a1/Y2wq+v41k2S1o
 HZaJOELM/ea3AyAOmvbzQXnStC4Ahy7x1AS4g+sNM/cFZZeB3moAHLPoOv+vjpH8bYe+KuDJIw3
 wA==
X-Received: by 2002:a05:6a00:1941:b0:845:4d71:8d15 with SMTP id
 d2e1a72fcca58-84e59568c44mr4570118b3a.37.1785085672356; 
 Sun, 26 Jul 2026 10:07:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:1941:b0:845:4d71:8d15 with SMTP id
 d2e1a72fcca58-84e59568c44mr4570108b3a.37.1785085671969; Sun, 26 Jul 2026
 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
In-Reply-To: <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 21:07:40 +0400
X-Gm-Features: AUfX_mwazrnzMndJzCGb-2mtrqBKCeO5yvvmYB6OW837EQqmgIK99psDDoK7xAA
Message-ID: <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jul 26, 2026 at 8:54=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 7/6/26 15:53, Marc-Andr=C3=A9 Lureau wrote:
> > vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
> > as dirty when refreshing a lossy tile. When the display height is not
> > a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT =3D 2160), the bottom
> > tile is partial -- the last tile at y=3D2112 has only 48 valid rows.
> > The unclamped loop writes to vs->dirty[2160..2175], past the end of
> > the VNC_MAX_HEIGHT-sized array.
> >
> > Clamp the row count to the actual surface height so partial bottom
> > tiles only mark valid dirty bitmap entries.
> >
> > Fixes: CVE-2026-48002
> > Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
> > Reported-by: huntr bubble
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>
> This patch has already been merged to the qemu master branch
> (as commit 3543c2b855c), but it seems it's important to mention
> still.
>
> There already was a fix for CVE-2026-48002 earlier:
>
> commit 46ee49034d26d04d95ba8f3183d4fbfa9d2b89b4
> Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Date:   Thu May 21 11:33:52 2026 +0100
>
>      ui/vnc: fix OOB write in lossy rect worker code
>
> which touched the same code.  Now this one, with a
> very similar subject.
>
> Unfortunately this (additional) fix does not mention the
> previous fix, so there's some confusion about which commit
> actually fixed this issue.  It looks like the first fix was
> incomplete and this additional fix were needed.

That's correct, we reused the same CVE

Daniel P. Berrang=C3=A9 said on the issue:
We didn't release master yet. As long as we also didn't release any
stable branches that claimed to fix it, we could re-use it IMHO.



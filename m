Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A114BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fKH-0007u4-EY; Mon, 22 Sep 2025 08:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0fKE-0007ti-N4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0fKA-0000vk-Ry
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758542819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFR2zjC2c0PR4gSAluTLOIHYTF+4s84P2JFleKWOp3A=;
 b=XlGTA8MVw366W7tThWp4sKvAIXrt9zPjRIX+hiUCO8TXuWeFZpP9udh6uCpcVPaMrC6pBw
 tbDEnnIL214JII430NCSMu3MZEfTsMGx32BHX/WHWVYEZQIQujeLIheMPocl9D/GNwpIDj
 X3vqT8mNGklHoydHi/1iuD8TwCu/WsU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-AFZQsFeENk65uGwNpXl5Wg-1; Mon, 22 Sep 2025 08:06:57 -0400
X-MC-Unique: AFZQsFeENk65uGwNpXl5Wg-1
X-Mimecast-MFC-AGG-ID: AFZQsFeENk65uGwNpXl5Wg_1758542817
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so851016f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758542816; x=1759147616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFR2zjC2c0PR4gSAluTLOIHYTF+4s84P2JFleKWOp3A=;
 b=N1oMXYf6R+2KG/kvVJRkntEKwiULmAs4auWqr6yqWb5Hia7RL9NnRQk/WO4ppeoZw/
 QV6nonQMz1KmATQRjFJzeqhya+hoco7vr1wooYDxviuYQ34XJjuVG/SkIkAKXbJVWxFT
 QNE72DdeBYdjsF8n6jBOytEm1KafJH8F7FiETlMrparkK327LHTMh6Yt+9KEO18OD4Ul
 eIR9aR+NacH3TbKW+65EhJdn6LQbGMcMPdZiew+lgW8T77zd1DYtJmBoP3/KJEfs7twp
 W+9KfdqJ7XKV0tE/YEoYbOiRDnn0+FduFNmK/7XknqW+mcBe/medjmeXfK9daDOwfbNG
 FFVA==
X-Gm-Message-State: AOJu0YwAxGB5wlEtPEhH0gJdBhd0pMXppQyboSdSQbuCkpSb1arK/vlV
 6fDR4kfXDCNH13CyI172K/JoXshq0beiGOg+jbbGAL9LNK1fxCVvOYHdZrm3UQsO1tp8jlpyDH5
 ZsLRSv1y1u/MXsoPY4IxW17edWxlQ6sgkjazVtIjaEN5sRJK3vTw4CqxN0PphesP0LgUaoccoVY
 qLP+/4VibzUVtyQqyvaYXzSXAGQ+r+wP0=
X-Gm-Gg: ASbGncuJxJknXa7uUgzCzYC3cVHZ+Lsvt/Yw43csp/exvGEYGQCTEaTYFy6G2juUl+7
 tJ8y/bssyGAjb7o50XoNxXmTDIJXt4NB/3HpO+qHotNZlW99yxYW8mQtBm3bEsohwwLHYDgDNYl
 p5w1pngxks72IdN9rqfN3eNdQnOnZnEq3q/tT98EF3VHeuISHMg0WkjH74XuPDflHAh56diiZCQ
 vuazlxDfSCWJkJiBnNmK8Ec
X-Received: by 2002:a05:6000:290b:b0:3e4:f194:2886 with SMTP id
 ffacd0b85a97d-3ee7db4c570mr9478272f8f.19.1758542816417; 
 Mon, 22 Sep 2025 05:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4VT580jxb6yrRSap4XId6+KK4meu+Re4L6g/Dr6BrYpBgSIleAALYu1cj2l7+90SX1d8JpMzExxUtrCKrMBQ=
X-Received: by 2002:a05:6000:290b:b0:3e4:f194:2886 with SMTP id
 ffacd0b85a97d-3ee7db4c570mr9478249f8f.19.1758542815968; Mon, 22 Sep 2025
 05:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Sep 2025 14:06:43 +0200
X-Gm-Features: AS18NWDIZGe-WxxAj_jhgbjBpJ6-YvDQwoeB3VWKw35i1qvhnnNsXOePAI7VSIw
Message-ID: <CABgObfbVb5tuHoX=NgUN__ZOx0nFXwGacuNwb_V3YPk2TTSD-A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 1:47=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > On the other hand, AI tools can be used as a natural language refactori=
ng
> > engine for simple tasks such as modifying all callers of a given functi=
on
> > or even less simple ones such as adding Python type annotations.
> > These tasks have a very low risk of introducing training material in
> > the code base, and can provide noticeable time savings because they are
> > easily tested and reviewed; for the lack of a better term, I will call
> > these "tasks with limited or non-existing creative content".
>
> Does anybody know how to demonstrate "limited or non-existing
> creative content", which I assume is a standin here for
> "not copyrightable" ?

The way *I* would demonstrate it is "there is exactly (or pretty much)
one way to do this change". Any way to do that change (sed,
coccinelle, AI or by hand) would result in the same modification to
the code, with no real freedom to pick an algorithm, a data structure,
or even a way to organize the code.

I wouldn't say however that this is equivalent to non copyrightable.
It's more that the creativity lies in "deciding to do it" rather than
in "coming up with the code to do it". This is also why I mention
having prompts in the commit message; the prompt tells you whether the
AI is making design decisions or just executing a mechanical
transformation.

There's still a substantial amount of grey and I'm okay with treating
anything grey as a "no". If something like "convert this script from
bash to Python" comes up, I'd not try to claim it as "limited creative
content". It may be a boring task with limited variability in output;
but it's still creative and has substantially more copyright
infringement risk.

Paolo



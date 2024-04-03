Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B5CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs8C4-0005YC-CS; Wed, 03 Apr 2024 17:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1rs8C3-0005Xs-8y
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 17:30:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1rs8C1-0006wg-FT
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 17:30:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e28d7b03e9so53725ad.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712179847; x=1712784647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qFTeLxIge82N+xoJSbunvyaRud6WycQqB1tbiBpGhvA=;
 b=1Sk8jwyeokSHBL9s4BVxQb8KgdTLexktQqvaivuk8OXLhPz/TGzrVGFNnXF+XRDA3e
 LtI1YKHeh9f8doOpC43yrGrOwoICQJm3VKeYPH5qXy3ahoHMVZmjsHtZki6/gILHgIEW
 y1LpVIVhyp9+r8T8kDnT8XrATrMd9ItfhmYjyP6Z+YecLXnG+DbP/STCG5VnHUTXkN5N
 SeLNaRUyHcEPOuJvT91UMpfrRbyHDidGHwnNcVGv5fH1xOcUoL6SpRZ7zosfb0kVUpIW
 QrfjFwLYtxTPSsnDNmVn6YvKA2ZJS5YflDbUIuiAlsdHAFFlQMbWozoufvTMmg95yHOk
 FgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712179847; x=1712784647;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFTeLxIge82N+xoJSbunvyaRud6WycQqB1tbiBpGhvA=;
 b=IOYNdqYLFOqm0zAMaOSZy51tL/AuJU4pFSsNDQkTqYB2NccA0XLFCiNEhohelQvM53
 UMDM08b1bI0IXKkmxkUAVOJpEd9v6BYASAV1By2RzjEv0O/stNTV+0k6Hw/Aap2InNZ3
 S6dlR5XgRXyomCMSpnRTLVr9FLB7eysViy27STu/YAoyFulXQhnwAXcP/7rld0lWuCzW
 engRpxfnc+VfnJuG81HuvayaUdlTdlAthWm+CmT6jpEIxGjViQ9AexqyBtmrOOCBBuFm
 Xq/5lxpJKCyoyQz2tPN9n1XRvcfVQoZK9SozDbhf2Mzkj0wkR4HZyqNPuxEL33wCvxbX
 Zv9g==
X-Gm-Message-State: AOJu0Ywyv7aaLRhqB7mO3uZRJIbycL/1TJjSx/BWM0/2qwJ6YiVoWYV3
 jgL1aWlwKbuWDDSmdMtb5s1tU1WBsWljpKhvcBe4DRmGYFkvEKTZk7vIFpUKLtgo3IuiF7/Axi9
 wKLI1Sgm8EFbuLXWNt7qTUAPwd3nx0D3Sl3ij
X-Google-Smtp-Source: AGHT+IGlzGDhbYtEpKbcIB4GEY9N0fZMTQ1EkWx3vBUfpZwReZAxxvP0lbaC2t3nFzVIBEwcgMnK/RjLcvaQpDL9Kro=
X-Received: by 2002:a17:902:d4c4:b0:1e0:294f:17c0 with SMTP id
 o4-20020a170902d4c400b001e0294f17c0mr376944plg.4.1712179846849; Wed, 03 Apr
 2024 14:30:46 -0700 (PDT)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 3 Apr 2024 14:30:33 -0700
Message-ID: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
Subject: Hermetic virtio-vsock in QEMU
To: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Cc: QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Content-Type: multipart/alternative; boundary="0000000000009128a9061537efbc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=rkir@google.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000009128a9061537efbc
Content-Type: text/plain; charset="UTF-8"

Hi Peter, Alex and QEMU,

I work in Android Studio Emulator and we use virtio-vsock to emulate
devices (e.g. sensors) which live in the Emulator binary. We need to run on
Windows and in environments without CONFIG_VHOST_VSOCK, that is why we
cannot use vhost-vsock and invented our implementation. I tried to grep the
QEMU8 sources and I believe virtio-vsock is not available there.

Do you think it is a good idea to implement virtio-vsock in QEMU (e.g. to
run on Windows)? If the answer is yes, could you please point where I could
start to build an upstreamable solution (not Android Emulator specific)? It
is not clear to me how we should make the device available for clients
(sensors, modem, adb, etc) in a generic way.

Thank you.

Regards,
Roman.

--0000000000009128a9061537efbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter, Alex and QEMU,<div><br></div><div>I work in Andr=
oid Studio Emulator and we use virtio-vsock=C2=A0to emulate devices (e.g. s=
ensors) which live in the Emulator binary. We need to run on Windows and in=
 environments without=C2=A0CONFIG_VHOST_VSOCK, that is why we cannot use vh=
ost-vsock and invented=C2=A0our implementation. I tried to grep the QEMU8 s=
ources and I believe=C2=A0virtio-vsock=C2=A0is not available there.</div><d=
iv><br></div><div>Do you think it is a good idea to implement virtio-vsock =
in QEMU (e.g. to run on Windows)? If the answer is yes, could you please po=
int=C2=A0where I could start to build an upstreamable solution (not Android=
 Emulator specific)? It is not clear to me how we should make the device av=
ailable for clients (sensors, modem, adb, etc) in a generic way.</div><div>=
<br></div><div>Thank you.</div><div><br></div><div>Regards,</div><div>Roman=
.</div></div>

--0000000000009128a9061537efbc--


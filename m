Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D693EE0AE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 22:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voqN7-0008V0-HS; Sat, 07 Feb 2026 17:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqN6-0008Um-Ep
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:01:44 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqN4-00065x-DN
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:01:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a95bfdb31eso5318265ad.3
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 14:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501699; cv=none;
 d=google.com; s=arc-20240605;
 b=b6A+U/Lm1NlP8b074Agi4VYYWVIgUhTVbishNDQZ6H2xdHpvdRFTTYTARtreK5xsUV
 D4c/nZKmM2YLPWFetm6B8KHN94BfcQG4z/jQArsTnJmzIHwOD75vfmJWUFbsIzbiKQ9P
 tvOb03sjERgF398wBmu0dAJeDl0f9Ul6j8JMVhJ9aCvXNVOv4+o8PdjtX0I2PkserCGv
 b9LHvsqkx6XTBs551e7QjFtPlZQ1z1HTLnRVfuGiIbTCM9Br51Uh/lsVfTmFUiSkHDkC
 WdWMHPYqCNHjY+VT5ZIYU+gJ3wO1s6CXrRIjWp7YrzZy4myKH7SccbOPu7jC9jiFzWnp
 Gldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VRQOAda+7kynwyDZDOswaWprzpJIB9lHy65rLLhvWEA=;
 fh=MiUykc4xDWO2e/LYwoZUK61hIp05Jo/JXb0Ee+A7oFI=;
 b=LHPLCFoU1tBcn2ZRuCPnPv2dIEuDZpKgTwRct/3q3tps1TpcgfF9vNDSNHJG9cwfw4
 imFL62JHwUsWv4pTuw9gRRb5c2SRVriFPcStE6/S6iI9jxM5PAbbwqcunylNQq16KAWA
 qjEDJIWB/GPynU8O4zvrSZiMvFUI4LGJRKWYtYTr7QxYkLRfa8Qn6U90edw6ADscbMc8
 p8Na9/p8Z46jDEQA/zt6zDNkgXglf3vll8FKcyHBLj3IS+/qP7FAA+cikdOeWwjw/GnH
 LWIeb4aoAhOf/U/1AI58QJc6PfHWztqQ0Ld4WC7OEkFtspmpYl7dUPC/s4DQjevhibNr
 Gz7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770501699; x=1771106499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VRQOAda+7kynwyDZDOswaWprzpJIB9lHy65rLLhvWEA=;
 b=aD25i3dT3zsKVvurDcU+Ng4mCe8/JhEUFTmuJx9RLBvvIJFLJ/0HSo2Ik9/jVaCtMn
 W+TiBzuoprscAqxXaQlCtHUQdVaRq1G1usgsGlOJqKQn5xItypr8Om6nSwwack4RuEur
 bfROJ5qyy8j6CgHbtrmVAucCFo8iJtue8E9dW0Bp0RMTvjkB8Z773JxT8tvIRbt9B8eH
 k6GHWWujAnD96SGz8m37iQcPBvzvvCSEhWUX5KMSVA1LPHMF84x1GnzAJ9vE8wpJDfrW
 +/CFKqW5B7hFBsQ7uNZt1I010f5jDCpAy56fBJKd2yLabqeY5X9Y0oWVB4Cd2GvF0VZ+
 ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770501699; x=1771106499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRQOAda+7kynwyDZDOswaWprzpJIB9lHy65rLLhvWEA=;
 b=qkkigkrXOoFqgQsa3kYUx+2gYrxSlLel4MBZzJcOBwAf1S45FnKprLLE4XQOmq3wjN
 fkH03D+5q4O3PfXYyg5CWiSOL25Xyydh4FrSMfrKnmaSewfi9k/BpAmO4KxYO/A1FAZk
 t9qPCTC0C86Rhv5AAGs/Pa3GzM4HlbkrFymf6/YfbdXBfpmXOVLLwn4lb8l81nhpyn9c
 0fvHz+yEyEOm19ZvTpPn60TRVo8ar4QOqX4vnwtOg9Eg+a73Ex2gEgsJauovTi6nbjBN
 5ewOmikpoP0dUZDTQAHN0Xqoi606ooEWmNG9/LEWNI46GFghWJHJbNzJLhr8U3pH7iwr
 lF9A==
X-Gm-Message-State: AOJu0YzCeUyYqL8oGJVt8FWLDcJon2ww0s+xS5bH0dYDGwxHlLacs77D
 I19ZSCennFgP/qChC6XDNOjIU9XBN5Iy2HHC4NcmfSyRcmWB+JVwWKSTLPfdXlvmBJZ5Ita9WlY
 pz0yurUtgBteY4LNv3kLjORrLPAuwa6s=
X-Gm-Gg: AZuq6aJtqy4CX30ckzrtA6p0mmmpLBLYCEX3OYsbchegzOAJ/M83gqyrfzed69JTKMx
 ysMLCwMArdGkar16HT0+rJ0aqkAJ+jo1fV4mlfEXO+x8d4yMhZcRsoeffy8wwx5CKzVdNDv8W0h
 VkqoDc11yhCWQroOHE7Ai0XvNJ2HkYiALK9Jesp+jol4AW8CtRZxdrZMZQaWbOuiugZ9hBsMYz6
 sZbhdBuVeEMyhlnQDeAfKbLPdpUmjnZeDvcWZglH6c3FOtWc5Z44yeUWDtYlbdhIg0Bt4du1Kmx
 YU/AXisklsEokG2siHqLG3IGK4c=
X-Received: by 2002:a17:90b:38c5:b0:354:c6ac:6dc with SMTP id
 98e67ed59e1d1-354c6ac0894mr2823554a91.6.1770501699437; Sat, 07 Feb 2026
 14:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260207180632.1042754-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 7 Feb 2026 15:01:28 -0700
X-Gm-Features: AZwV_QiDFb9SDLhRMZEquAeqYBe_r8q4WyDC8UZRlCR3QEnZgaUh0ykhmhku_EY
Message-ID: <CAATN3NoEXxLefuf1Vu=Piy-Rb8LRvth6MoKc6FEsdWHKUuNxmQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com
Content-Type: multipart/alternative; boundary="000000000000de8906064a430cab"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000de8906064a430cab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Rewrite invalid-slots.c to catch and verify SIGILL using a sigaction
> handler that modifies the ucontext, matching the pattern used by
> invalid-encoding.c.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/invalid-slots.c | 76 ++++++++++++++++++++++++-------
>  tests/tcg/hexagon/Makefile.target |  6 ---
>  2 files changed, 59 insertions(+), 23 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000de8906064a430cab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 7, =
2026 at 11:06=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Rewrite invalid-slots.c to catch and=
 verify SIGILL using a sigaction<br>
handler that modifies the ucontext, matching the pattern used by<br>
invalid-encoding.c.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/invalid-slots.c | 76 ++++++++++++++++++++++++------=
-<br>
=C2=A0tests/tcg/hexagon/Makefile.target |=C2=A0 6 ---<br>
=C2=A02 files changed, 59 insertions(+), 23 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000de8906064a430cab--


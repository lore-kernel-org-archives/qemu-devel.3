Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86187ECD9B0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 01:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voAGc-0004AJ-2r; Thu, 05 Feb 2026 20:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voAGa-00049t-2l
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:04:12 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voAGY-0004Jn-Kc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:04:11 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso810835a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 17:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770339848; cv=none;
 d=google.com; s=arc-20240605;
 b=ku7snInvMxWFBNBa5qxgwZsM3EZ4GeVDLf+Hqm/wtCqzGErAnWCYqn+5URKtPdYwzV
 H6hxY3qpzi9xOmIHI2vBy5vg6RAx2ZXS8+jaAphJGkVs42c1THjeAwbQxAZz+O8kN0+8
 YZSunXqdKfhT/1q4K5cUfPVEFzEljK7Nm3Ai0IakPb/8pWVUiHiKU09lpoOmUpQgpjUu
 xhvNik2Z3gcI8CAvDUYGa4DQvgsldt3bhFUVlq6o/OD7DlNzbU+OuEgjq7wdp9knrtEt
 38SvSxxzRUswDHhtDI4fh0NlYSpBhSL8dPJk7v9Rf72I/kYEk04dGAqiO8gow0cMEMHZ
 XEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=EH16F70p/RgO0Atr7fd2qe3zWUKTbNq/+FhY3+TH7No=;
 fh=VqS+tPLsGlswY454e0dYtkegTr3u8RL39VDhCWIP5Lk=;
 b=T1UA+ZYSGy1/FSsiaMdWUAxkEkGzsrW0z8Asw3QngOaRhvt+R3a6gI+aejQxLSSgik
 xwpwoPCsRWdEzIDIFId6V7rB096on4h+cnoWO6YOXYmg/WKWdcpgRq9h3xoqt4ldTAQE
 wLHv6CaN9w0NuKXL+XMv7UGOT/mGnsif+egDNlD2J8KD8iLV2MHI6ctwWcEA0LuVxquQ
 3vaudAZ2k0OPIHR2hXVFQFEYxNlziKZNr1f6Gt8tRpeq/rYGl/PO7pINjFhml+pqvwJ0
 rDvt8Y97mh+MtFsksUK2hAEeX8FrLnAatx+i7cJoMz4GFbG8bBH+NX0RylySz/uUWjQM
 /uXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770339848; x=1770944648;
 darn=nongnu.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EH16F70p/RgO0Atr7fd2qe3zWUKTbNq/+FhY3+TH7No=;
 b=2IiB88unhOwd4JpcC5PZsT0rrpOssKHNd/NUmpbzbHvVc1kkA38orzzaC3odjquHzf
 odcf4xQjBW9a53vny2oKdEe83CKR14qXm7b2thYXzN7qCCQH/kJumEKof9BaNYZV/Wtu
 vgsZvp0eVggcbms1JDqWt6KUUdKH0jNETrIw5pLYPXFpMNVDthAwc7Fn6KeYJ5JTyRNf
 Zpki14XAOw6yDlJhLf7muSpflQLjXh+uMEQ5SPexTsmKgBwZ87Kg5T1AaPrugHODj5RI
 3iq5NzL2nT4X6T6S9eFCyKKdWddhMnA7/N+bBFEfDZnPyvKAejVnVqVWf0r1ZMlUYJu2
 AM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770339848; x=1770944648;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EH16F70p/RgO0Atr7fd2qe3zWUKTbNq/+FhY3+TH7No=;
 b=EhGuWip1LimXnI0nc+aJeIbsrlECwnZEwCeWk2LiCNIpHc63ELfUOGqbFEk5qAIRCw
 nA19SqVR/Ez3lq+luufZNdFt5rkFVtup94jOpqQ9u2I1fVaItkPxY4lCh7jX6gCn5ZXP
 4yAmAfM147woxwovcjv90TZl0RDzJIGQxFw/fANSLU7itcVDRooQfKcU80/6lDweSJsB
 Zw1YXCSu73YIyeDXR134jf6oe+YkmuFEQAYNx4pUo5L3qab3kCerWivY3R8l6uV/NleO
 V4ZBbJG2FIEnnZ9Rs7itdi8bdYVFln6ToYYP1CCbNhGUYjftFztRKFv+hC3ryI8dWJmb
 u5Fg==
X-Gm-Message-State: AOJu0YyUIOaCZipDXtkCPa+GGHK609NEqhW6omsGRbPZjmJMd6j98+ok
 X4nS7iUy11+tVt21dfxCTgI3EyuBACwtsj2rAoribrvxWuykzhpPzlL9E7e+N1fgfID/E66a4U/
 8bqSp3viJDN6C4yc90HZryR/TKpWGTAeKMtOa09BpENUwQCb6ZqgoTP4=
X-Gm-Gg: AZuq6aLYayaFT3ioRHdWPApUguZYIf3Uhxbi3yifD5GgxsfurUWOqo0DF27n8KIZrXi
 fduk6lZ2cHdkHHIQbSSPOD9IVOA1JSgnMF/OjCw3G/8rLnHmjNODZhNM3SbF5NZScwED28IxO9J
 EIST1jzWfr8SZlJPIw04q6ZGJf8Nj9VnLH3HGHf3AMsY/PzCd8EdcRd07LatrQMZ2EhF05RdwEO
 oRlbLWFNl/gGqimArzuclANridQ6FrnGp3o7KYqF0EsWTpaTU0R/W+qoEgmyi6D6ygG/Gw=
X-Received: by 2002:a17:90b:586b:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-354b3cad4acmr782244a91.16.1770339847678; Thu, 05 Feb 2026
 17:04:07 -0800 (PST)
MIME-Version: 1.0
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 18:03:56 -0700
X-Gm-Features: AZwV_QiZTe6Q_OaAt5i0JOQ0YGWYcx6Yrs2d0cqQ-E2z8JilEvlMRcEQGwgS0VM
Message-ID: <CANCZdfq74R8fLc9+NURynkKz+D1FOtxKRGno9EwjN--hPpdf6Q@mail.gmail.com>
Subject: bsd-user: Dropping the NetBSD and OpenBSD code
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c0bd71064a1d5de7"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000c0bd71064a1d5de7
Content-Type: text/plain; charset="UTF-8"

So, it's been years since this code compiled by default, and even more
years since they compiled at all.

Maybe 5 years ago, I contacted the OpenBSD folks, who said it had decayed
beyond uselessness. So I plan on just removing the bsd-user/openbsd code
shortly.

Maybe 4 years ago, someone from NetBSD popped up and said they had a fork
and they'd share it with me, but they never did, and we never reconnected
despite some email attempts since then. So, I'd like to remove the netbsd
directory as well.

Both of these are finally getting enough in the way that they are causing
me problems with upstreaming the bsd-user stuff. Now that I have a good
head of steam on doing that, I'd like to finish that process. Expect me to
flood your email in the coming months with way too many patches now that
I've found a way to streamline the process enough for me to sneak it into
what would otherwise be lost Friday afternoons...

Before I send the patch series to do this, I'd like to do a last and final
call for collaboration. I kept it around for this long in the hopes someone
would show up, but nobody ever did.

Warner

--000000000000c0bd71064a1d5de7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, it&#39;s been years since this code compiled by defaul=
t, and even more years since they compiled at all.<div><br></div><div>Maybe=
 5 years ago, I contacted the OpenBSD folks, who said it had decayed beyond=
 uselessness. So I plan on just removing the bsd-user/openbsd code shortly.=
</div><div><br></div><div>Maybe 4 years ago, someone from NetBSD popped up =
and said they had a fork and they&#39;d share it with me, but they never di=
d, and we never reconnected despite some email attempts since then. So, I&#=
39;d like to remove the netbsd directory as well.</div><div><br></div><div>=
Both of these are finally getting enough in the way that they are causing m=
e problems with upstreaming the bsd-user stuff. Now that I have a good head=
 of steam on doing that, I&#39;d like to finish that process. Expect me to =
flood your email in the coming months with way too many patches now that I&=
#39;ve found a way to streamline the process enough for me to sneak it into=
 what would otherwise be lost Friday afternoons...</div><div><br></div><div=
>Before I send the patch series to do this, I&#39;d like to do a last and f=
inal call for collaboration. I kept it around for this long in the hopes so=
meone would show up, but nobody ever did.</div><div><br></div><div>Warner</=
div><div><br></div><div><br></div></div>

--000000000000c0bd71064a1d5de7--


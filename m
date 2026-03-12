Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9571125853
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iPn-0001Dx-7v; Thu, 12 Mar 2026 11:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0iPl-0001DU-Af
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:57:33 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0iPj-0004Nk-PN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:57:33 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad46a44easo1232755d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331050; cv=none;
 d=google.com; s=arc-20240605;
 b=WXk9VFbpn14KdOWFFzGY4ULHeUnQ99zz7WGwwp2vhyI1rPe6tj9HWwKZGnR1unbt30
 NI8YL4/bU08qRpjSd3DL1W/FEKeVJLXRSxEbVHOJ/4o6pfxS/SF2lPQeolwy2mvOmMkx
 zqD/cipZmcO5CD3dP9r4BPyLoYPhaa9TrBFg2sRbmmmpt7zfSG00FyVlfIYjkrAeYmAn
 TEWh34Az/LDj+fo3MzS8LMO6zPd7mTy27r9+duo19TBMNzLZaZM8IJE/M3M09iQTpNOg
 X7RPnuMAnslQMN2ewCtWheYgCJixphyxsz31QIdDTT4BcP7hx6hZ39PQAGoeVKLJTSjm
 fjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CtNaMor/tKfbVXJAwDK5Fu7dHQWBxD/z9HupmauOyz8=;
 fh=/8o03PxB7iPcx8/FNhI5x9MJpXfbdZhcXfL/JOb+9Bw=;
 b=ElQCj72mou+v1WtiL6zfLqi8urm+Po26jeepgGrMVdRbioEyk1iMdCLUz3In7rK97X
 08zk5+pq1UevPQjKAVPOjrs7Giln+4RL83lqftncfdjUk4pMlA07roGBHdjBzcFjtbIn
 8m9z11F0XGvclwsC3w6wjYL9qdV0IBph9bNIKSq+k7LFLla80x8q1RxCsLF0MTM0cpbc
 lqYRr87F37pvbxhonT0Kc8iBSSBKeFZYXn+dqwvaHyTy4do69hkhLF1ripOZIkw4T+9i
 KzvWVeVxm6Xu55Sgnx9cauYf7r8M1oMDLhOkW0CCgUIAHuS/u4H3yNTZvMZaTkewI+iz
 s1Xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773331050; x=1773935850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CtNaMor/tKfbVXJAwDK5Fu7dHQWBxD/z9HupmauOyz8=;
 b=ZeCO+llZcJ8tHgteX1ebJjLRx0hhhVhoE5ofOPgAQSSndfO4BTTbr0zB4AXPRvkYWQ
 wsXxjiJpsF6SKPApJGvCpIjvgISgrz3wQHjQouTmbhrb4XrCa27n6zQmi5cHBNxHU8UD
 Xvs5yh30XDdlnMhWliKCOamLa4xNOtJBsD1HQDgEEvizVUN3UvcsuVkJqTtkqOeWawc5
 ogeJ7SacF70oaeSqMmYJHpdvnAR+e48v7ED7PmdK+DZWvwjy8sLJFxhlUUCcl5cjE6DL
 6ke+AYlJ5/hfISBPXJ9iE+EztXcdn/Vxcg5A75K1hZpCed9VYnNTkVOQ/xcYfjaZrPx0
 yOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331050; x=1773935850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtNaMor/tKfbVXJAwDK5Fu7dHQWBxD/z9HupmauOyz8=;
 b=quSD/cyFVGXtnlkGbDIo66lkZJJt/nlN7aG8r/ZAwsPgolSX7x3ifx/mUUVnMDVPYA
 YYN2/4gaFis3cSgjan0U2LjBaqb32GgDLw/TqFd2w8JWxxwMBiJCZL5EMNBULRnfpYKO
 O07xUd9dFjOFgK3F/T6/j3+dlX5FMFo1ERaddZ52ot47anX/qRQbCvHFoxcnB9/XvHVs
 UYcN+JxX3m1r/WajM35PrNcMRLF7kRiynKq300jyhwvfk1S8R8pbgG9jlyH6IIbusi/G
 6qUBT6IKbs13QiR59AjlH/g22TlvPJ4UeH7jPZUZkalPFvJICcUvgUMFhZarPZEUQiwa
 4RDQ==
X-Gm-Message-State: AOJu0YyTri63tmIs3aESqerp8KOa+Y2KX9NKo4FNL5PDvz+pqHq+qOyZ
 +wkw9lE/zvSlD26cfYBXKy0eMNxxrFZsVcYk0dpowahfpoRla7K8pJPOmb5Yev6VZlrHHUWEfin
 BdFBxUfGbRXrabkB2LPGXiDMM0xR7MpFsHmbyU1un4XUyabPh+6PG
X-Gm-Gg: ATEYQzw8seib2FFy5Jte22fzceS63MrWVkc+VqWMVBgGrQHTWPqklr60vfYevLKJSUU
 0HzJyhPRon23JH32rCt8ns3iRM/uI6XIVgMzzoL3b9bDrOkOTBw8jQhRLhupTG89KjscMKVFZrK
 W3dzvFpbiVl0Ohc8alqmOBMWj5yAIF/hBSHuZzLtrgALIuOuogWj/YeIbTt0FaT1ZFeHZM7gk/o
 7Wbfjr1wwJtYbbJPxQO0Rqn0zjHveeQ9qM7a7e3EVCMVQ06Jc9l4E+udb5320JY8MGV/xasP58E
 pmTeNFhxp3yMpXUm8OSmy9hmCDk0Oy3kyrnC5qAMQ1Ak40GCG5LKME7LWHF79g5h3Ss=
X-Received: by 2002:a05:690e:e20:b0:64a:e589:ecb2 with SMTP id
 956f58d0204a3-64e6307a3a5mr22606d50.62.1773331050279; Thu, 12 Mar 2026
 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260305140512.1330691-1-peter.maydell@linaro.org>
In-Reply-To: <20260305140512.1330691-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 15:57:18 +0000
X-Gm-Features: AaiRm51we03x3vycDWOaL1jeZnCTyHhdixGZKkjIUz4yVOEFBel0dv4oDJ0dqm0
Message-ID: <CAFEAcA_xHdvz+hxzSYOrmBUbHXUCZLPn0Tir1kZ+3-W1iuh6JA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
Content-Type: multipart/alternative; boundary="000000000000524b63064cd5cf92"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000524b63064cd5cf92
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 14:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> If you compile QEMU with GCC with -fsanitize=address and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):



Applied to target-arm.next, thanks.

-- PMM

--000000000000524b63064cd5cf92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, 5 Mar 2026 at 14:05, Peter Maydell &lt;<a =
href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; w=
rote:<br>&gt;<br>&gt; If you compile QEMU with GCC with -fsanitize=3Daddres=
s and<br>&gt; -Wstringop-overflow, this causes GCC to produce a false-posit=
ive<br>&gt; warning which it does not produce when the sanitizer is not ena=
bled<br>&gt; (and which makes compilation fail if you&#39;re using -Werror,=
 as we do<br><div>&gt; by default for builds from git):</div><div><br></div=
><div><br>
<br>
Applied to target-arm.next, thanks.<br>
<br>
-- PMM<br>
<br></div></div>

--000000000000524b63064cd5cf92--


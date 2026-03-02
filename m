Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B6EB362E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 19:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8lt-0006Oa-8E; Mon, 02 Mar 2026 14:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx8lp-0006O3-AE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:17:33 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx8ll-0008HI-8t
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:17:32 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so4146790d50.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:17:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772479044; cv=none;
 d=google.com; s=arc-20240605;
 b=e+Txf+QxyIY4yEMYkpRl/0SYhNsbsFcfZSeBetb/milv18s1YcJgFgbDicGar/yA+z
 0ThSi0IU8YA7qnbVaocEfwgFt1uJXUaSTr49LAzlgNTTb7g72obESKThQ1mIAfsYkk1p
 h3o55MAyhJZqkQV+XgxPDnS+8/yY4gma8/YR3JgzmLfO+nm7bt/wAGNaatKuBIzzRoJD
 ivKYJ8gaMw3GckApUOMa/bTsph9e2V7neAVrZ5hUuBKAVNmviSQFqb29vGVHS09H7aOU
 8p2YJou/rCxgLFDPCH3FHACMNlP+Zy9DYiKAR7faOJ1fuqTV0Qowcizwjt2nI2M/7nSL
 FDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xO9QsZK1xpSd4YejrResO12aWymG+FZti5jPLtHzkjo=;
 fh=6s9Q/m57qB6BA7plhNG7BprZb5obIl2XfXIDAoYiT9I=;
 b=JZAvRULYTGztZ7n3md5iKPY8rN3qGyZYsBKeb7vF8dcnPxRFco64gOOO6OD5Uv/C+3
 XcbTqoLlahwCOHLKIkXYgYsfkr1hgg22Yuvdb0mnLW1PQxqrY6X75DQ7LpTmWCm8awbJ
 IWqEDX4CaYfcd9R9s7/YqmPKUcsPXARHrY51q+veoTpuD7PJ9KF9zJaFc4By8rpUkVTo
 pIFuOrI1y5xYgzUvyJrKX3zhQp4vVa82iPdbXSLXbzKXB+adczIXRHCni9J+8EvzZyBF
 ClpuqPKd4h+nAzGv3kFPkjn8YK1gM+d/EjdBXx8sbENJIGlkAbTK69Xbdgb9OjlIiJJv
 yxdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772479044; x=1773083844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xO9QsZK1xpSd4YejrResO12aWymG+FZti5jPLtHzkjo=;
 b=ua110fvd9QC0ak4FrkDp9iSFGOQMzbNkx7XIH3bOVvc468MkRCweaXDM42LiAzNWGb
 kjt6dUL3gOPBSSHRRzvmgGwhnsgWbs12ChSPI4EkACtwRk758irp3x4E4QKVQ6oi0K71
 Kni69ZVE0ExNWxCbjFhsNqiQ6K0Djtu9OOW6FR53Gfl+JADEivw7JJmrGcHqnk+eAyic
 VpU0auWVgQoFoeRsOKKCR91S9YP+/JFfXQMUP+yrH6e+CtygAki/d5ZS3Nu+ysWX9dcI
 wxQHhartVdAJonJcrp2hiim3gECnzwRzkK7pzVCnan4UQmfPwUsGYCFyTDWiKLxe3GOt
 PDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772479044; x=1773083844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xO9QsZK1xpSd4YejrResO12aWymG+FZti5jPLtHzkjo=;
 b=U1noOYsBWZRfYfQtCAuOso/H3mM2jDDX3hVDEoBrF8T3Bu1RjYopZsauzC4KqVn3VK
 2BqL+bltp7QatEDUD9samtw4S609MgpkgBTfpanfP38PFVH2BRJ1g8Xs0kRuHlYCklvI
 6wCizCUBXrle/bYZIfGeQ9ncihh3UUmp38WwkONlnEEP60zCAmfy63FXnVh+aX9f75/n
 aql8KTF0nWaYEv/TG/a83OqsBhffoADlwQPuEsMpb6VvPVGNDgeFk+wEOe5Kk82tMSai
 0yGLXxE//cxkUYqNcjgg3VgcSpjA/gB/wdUf9oUvLpgwx1EayMrYQS2bpMPNiZUz1QLo
 UMlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY5Pm1TOpckl9QMF5vr293VM5DTQD1Jwo9RPh6vgwx1UjP2AOQeecahBflNZZhC4msv6I+ksvaqa92@nongnu.org
X-Gm-Message-State: AOJu0YywE35cAxay4egm4jppUY/sM0QIFkopPIV2or725pK+nQSN+5cF
 L10pmSK34nTrTfmjhYAw0P7ErVejoyZvGLMkEMQz+uihco2z+e56NvSGQdzEkrqvEN9J2HJH2Q6
 ju2/YvOFafrWvJiq4JJqGVK8pjpFa6bp9d9+Hrrwoog==
X-Gm-Gg: ATEYQzxmCmhWBEXOGq1bTWaxOGT1Xa5VA4i3wj6IEkdW6u2v8aQAf/NHpbIzxzLjsL9
 gWFSIedDzuTWygl91ZrKUFBxp7Sgm0RP7YhbLS1oDvcKPuWlyMpC+FFgSR/oEBKmUzDb20/W22m
 g2rcCw9jMGfSoxFLA69nJ9023c+OUCoocIvDimax1fLpS/6wzZ9AWSd/GdPXFpmgbeM1W75Clw7
 UfoQOIJW25VzK/03muKMv2fYEfnBpu8USOmXSUei5GYODF6CjMBs24G5RKUA+BzgWTCMN9mIKZV
 N5CyoP/D4Hz/iQLyX84i6HNbvE11KiaD605kWylARPXpe5pSgLj3616IloiAgMmOjVk=
X-Received: by 2002:a05:690e:208:b0:64a:eaa3:3bb1 with SMTP id
 956f58d0204a3-64cc20832f3mr9111000d50.6.1772479043844; Mon, 02 Mar 2026
 11:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20260301121347.797dc9f4@penguin>
 <127d0e97-ca25-4847-a06f-954443bbc886@yodel.dev>
 <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
In-Reply-To: <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2026 19:17:11 +0000
X-Gm-Features: AaiRm51Dz10Q6wnEBvdoVrU48ZnHZn9GYlpK15gMwyViIyCgOzAxX8J2LHeFUUI
Message-ID: <CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com>
Subject: Re: qemu master compile error in hw/net/rtl8139.c with --enable-asan
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: Lukas Straub <lukasstraub2@web.de>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 2 Mar 2026 at 10:32, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Sun, 1 Mar 2026 at 15:15, Yodel Eldar <yodel.eldar@yodel.dev> wrote:
> >
> > Hi, Lukas
> >
> > On 01/03/2026 05:13, Lukas Straub wrote:
>
> > > ../hw/net/rtl8139.c: In function =E2=80=98rtl8139_io_writeb=E2=80=99:
> > > ../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of =
size 0 [-Werror=3Dstringop-overflow=3D]
> > >   2264 |                 memcpy(data_to_checksum, saved_ip_header + 1=
2, 8);
> > >        |                 ^
> > > In file included from ../hw/net/rtl8139.c:62:
> > > /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] int=
o destination object =E2=80=98ip_ver_len=E2=80=99 of size 1
> > >     50 |     uint8_t  ip_ver_len;     /* version and header length */
> > >        |              ^~~~~~~~~~
>
> On the face of it, this looks like a compiler bug (warning false
> positive)

The gcc folks noted that their documentation says:

https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html

# Note that sanitizers tend to increase the rate of false positive
# warnings, most notably those around -Wmaybe-uninitialized. We
# recommend against combining -Werror and [the use of] sanitizers.

I think then that I would recommend one of:
 * use --disable-werror
 * use clang, not gcc, if you want the sanitizers

We could perhaps get configure to do one of:
 * force --disable-werror for gcc + sanitizers enabled
 * error out giving the above suggestions

thanks
-- PMM


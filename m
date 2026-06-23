Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41736CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5zR-0008De-BO; Tue, 23 Jun 2026 14:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1wc5zJ-0008DN-Gb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:36:47 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1wc5zH-0006RS-VI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:36:45 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-5177d1ff061so41391cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782239801; cv=none;
 d=google.com; s=arc-20260327;
 b=nOmVEU65vyAQcU5Q/48TNLSsBFPuNsK6nI+WgCzNPKaxFEHKj87wX2UX8NNq3uVFVo
 z3WfE8P2yQvIkfh/U9C5XPcu2PiqmFMGjVxCAgpST3+j641fxaAlM5tLbkXHmNMjHLn2
 +7MC4DhErw9JmE50llt6LofEOpl0tyN6mZiCoWOCsHGPUxiJoveINwsrp3qu6+FLxDuh
 Ijsdb0xyIPo9akT1D9TT6pLZUPGGhSIY0ads0AA/1YQ6TPKIxniHEZrcvGmAby9zEKFq
 45NAWXA1k43xK5s9W0ylRUeQ+eYMlC92HiZ/OfIuuir7biwFKuGxFnufdfr7fNEP92uP
 Cxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MQ5fol70xgfG6ebJGRkuL+8d0mZTx0n8RPRg/GXYlc0=;
 fh=QBcHwuQGX0LPfxAkokpN38512jETs0gw5tgJh66ES18=;
 b=AvAV3g16HxM9AhGkJM7A87PemYrz0atGhGuXe5Ib//g4f62pVgJ0lpeXZqG91cvlUH
 +GNahGjejSxHb99M/IMZ8vgyoh4WOFnNfOKbEp2HX1QKIKj9JE5xk1LJEFHWaX6hoEdH
 Nw1BWPLuyyav50DRnfv5aYuQqkGwrPYgDAQBXkRGzJVX2pLNbED6ju9f6SkyZCLcZHQr
 xOhOsBDKRtE0+VUw+l2ho4PVyUXXHEPCFX6Kws5y+Gy7IlSezQHzUhUau4YXxifaIVlP
 JJq1JMkJ6e0EbRsYPamaGqm5mbGlIdD4cLv4JCtcqnRu/b7ohYajRtQflJDm97uSanY9
 kfLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782239801; x=1782844601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQ5fol70xgfG6ebJGRkuL+8d0mZTx0n8RPRg/GXYlc0=;
 b=kCWHfACaCJNiVRhU0AmNLbF0EKWwC496ORSN2KcnDog31zR/ViFqlBfFPHvJpoi4mw
 Ktf75fpEKxwKgE1K5RMwJ9Tf593FNopN9F5mjYs4XWH76RN+k5gelc/oPCYGslzuv1f3
 wZInsIEivYLxX+1e5XhVUNp9USJD/qePutu1K2d6OFSS7FdxbvGteOvToa7utcKiIQAU
 oqJh2M9LFJ9VdiaUYy5EJ+KdzD4BYza4kjnKZa82mdePABAMZN0VPlBztPqknvYfcdCc
 97uBnESL1TOUzlLde5w9O1LjnJOZjYpeHbfX8MbTQkawGndnRSeh2NS6Lfsw3oB9FHCJ
 a3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782239801; x=1782844601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQ5fol70xgfG6ebJGRkuL+8d0mZTx0n8RPRg/GXYlc0=;
 b=QBWUz89V98xlvjV5HwGtFGFob5zlJ/W4WU1WWyTUiQhlrIjqssCN5I8aiP0P7c0VWw
 JljFCAXO2Z9OQKRfdoftf5PfYdej2jIAUg483l4aS29HKBLZkgOuePe5d7sGQFHNZX94
 e9HuCizKsPyGiLAn+5437arh+99DhMuhRQsUw+3a8CozGzPVoUfVDoojEKE3qbCAIFsI
 l/hOmr37SpV8Hwxvab84YK01xpiFy5k3///Tg80EGJpjhEwSovQwJzJZxbTMnQXHjvt8
 Jd8qfZIngvzvZ6f7Cr+YH1Wzf7ifxJOpa6NRWX0DhhLAVVQeWrrkxqkmsboIAqJuL1Uo
 paVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/c5empZAkgkmLwIa7rGOrNvqmWAfKXehSBT/xghUU24/omgzkP1I2F0y6ENOIYh4hKuOp1CFMTPSvr@nongnu.org
X-Gm-Message-State: AOJu0Yy8ZLQCTsb74XXoYZgZ4k7s1uGzCYz6SKoEHGsrOtOjcarlb8aF
 rWlBeLBQOn4MD3tPLWu+YyYCK4xfYoahi771yTkNrJhS0oVkYERaZLwSyDP8H2FXXt1UIZ37MR5
 yTIxYkrAPYZAt2b4TlOf/C/kC4OEOa4weqcJNp17/
X-Gm-Gg: AfdE7cnOrKsUMjsLkkwpTTIz/WbvI7Ow7Ft30E+l8ThL8Z7+Z7q+7VA3HQfGrPnIKPm
 9K1Ha7NVUIdNoLOq2kAO8Wd3Mqw7x4ManH8OnS4R1yZEDdhSp1ueT8BTAFEjAB7jYtDaJyxDPrZ
 oOh/ZuTgkVojxUku3CNHxSt797Ro9brwsRxptL2PS35IobzgyJ2StDmX0wNsDc3wLScMyHSs4Yt
 yMMK/Jlx6LqlclMEK7bowCE6eFw3YDIt+IHpv6plU3rL5aY3yk3ByYnL4QGShg9FPUcXJqmK5R6
 WMBeUAqR62DCiUfyJGa180VXlnDsahBW2EdgZpAcg0SPjcHv+qqqFNddJNgh0+dvJKYv9wVwB6J
 JFpq3B9Gtqkj0ESUktwN4Jleq
X-Received: by 2002:ac8:7c4f:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51a6177b34emr1030011cf.10.1782239800243; Tue, 23 Jun 2026
 11:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260623154659.3137518-1-nabihestefan@google.com>
 <a2891cc9-4591-4898-b0c6-b15170b815ee@linaro.org>
 <d4391442-1a59-47da-b68a-188fd4505bd3@linaro.org>
In-Reply-To: <d4391442-1a59-47da-b68a-188fd4505bd3@linaro.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Tue, 23 Jun 2026 11:36:28 -0700
X-Gm-Features: AVVi8CcO8qqawtz-BwwQtudv3qM7niUw7oprWbODMZrRe4DQY2F21yRpQSXTGx0
Message-ID: <CA+QoejUeNuttfy8QzNEXriTWG4V8YiwT6owP-pCiD-mkwUbZYQ@mail.gmail.com>
Subject: Re: [PATCH] build: Use meson b_sanitize option for sanitizers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, laurent@vivier.eu, 
 deller@gmx.de, pierrick.bouvier@oss.qualcomm.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, philmd@mailo.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Huh, I don't remember what the failure was and for all my testing I
can't seem to reproduce it anymore.I'll run a couple more tests to see
if I can reproduce, if not I'll just remove the override.

Thanks,
Nabih

Nabih Estefan (he/him) |  Software Engineer |   nabihestefan@google.com



On Tue, Jun 23, 2026 at 10:46=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/23/26 09:53, Richard Henderson wrote:
> > On 6/23/26 08:46, Nabih Estefan wrote:
> >> +# gen-vdso doesn't play well with sanitizers. It originally didn't ge=
t them due
> >> +# to the way we passed sanitizer flags. Now that they're being passed=
 through
> >> +# meson wen need to override it.
> >
> > Details?  It's not an especially complicated program...
>
> FWIW, I attempted to reproduce any problem by editing build.ninja; everyt=
hing built just
> fine with -fsanitize=3Dundefined,address.
>
> So I'm not sure why you'd need to force disable here.
>
> r~


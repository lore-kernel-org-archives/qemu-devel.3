Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A717CC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt27c-00006x-Fu; Fri, 14 Mar 2025 06:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tt27Z-00006I-Pm
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:18:30 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tt27X-0003cq-I2
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:18:29 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so290300266b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741947505; x=1742552305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOPbLmcxiIatQY7sHe7b02oenu+TvYv2qO+PIG5C0Gw=;
 b=f2PHZ2a+ClbJmxzhK+E23o7fWrMKffeIAxe+CWDGEttj4dTofDiy/wAW3m09UssdtM
 ceiUo8Cg6s/mI/EXV3Ve9cX07pTcbrSK8YRDsxaQS5QVNkNGEz26AM+jhP6DlToPRR47
 Gnt2JEmJr3/Uz0BB+W3N9XkHtEjbMt6dAiTArhNgiEDsvPqXdhcdMBqfOG0FId5dTbKi
 ftqBLT2yY/Q7v1zEEGypWdbMpL2nbPVbHXKZ5KSJ8i58RayokgqaiPXhhxvdvqUNq65D
 pNcO1acWRkUAWZtG+opQDlUDiI+h7l0ON+ffRYTEZvEurMMlftMPzhPtw/4RcHH4VwYM
 u1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947505; x=1742552305;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kOPbLmcxiIatQY7sHe7b02oenu+TvYv2qO+PIG5C0Gw=;
 b=m3x4+9gXuW+jyQzW3oOsylxIyTRO6iLuvvhmesrVbUEjpEz4DOOsBdZH+uEPUzC1tl
 t7CxO1mn11jE3jFx2JPFhQvHclqwG+CGbd6zouP0LobksontOkPNh2OovXg2xZzBVMmf
 Wxe9FLyKj//L4FEveXEyljOiroNCSFdtj0kkjVXHvcqNJZxwH8QkapFyXCDkHEoqitIh
 YQeXlhPirBdwefjY1d8ZhxraqD7mmxR/2fe+AA+rrvWEIhiZCiWSygqerbNv8J7J1g1j
 yoLNRcmvgj+MyslR/wF11GF9i744AJi7ScfLrsnWA2c7iwf8iCmf553ZUmrPsD9gcIs5
 XqSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWVKMUePANCYkMVQawJBufh/2d7EmknhXF+X313nTiBY4yVCi5gRf+kkYIiRQC2ObgBYdKO777ise@nongnu.org
X-Gm-Message-State: AOJu0YzR2uanOGHDFxGJipUrpIg8keU3o8smPD2RVSdbO6LrBXj/lU2C
 eKq10/wCVgiHSANMimsctPBEgeTS7jtDxmg3IDhx0GEPPDW6ux8t4b2R98XQnTFrfHXTWV0Ix9o
 2
X-Gm-Gg: ASbGncvcd4CuyAlKeS5tAT0J2axc7B9Qn4p+Y4kvTxkzf5sqLtJEAgEhvydBqJITEub
 9j0m5a2apLHsQxsyLUpEqzB7xfyNhim4sp7l4xtfaXUOSH3igqWe6pHzMmpLLsGYRP3s6i4yUae
 xSmruh9+EKn/xLSsrMtoAZPvkaHbrnQjjL04JrUY/5Zlnjut3ijfDfi6OSxOdffV9dAo9fz+K4r
 drjmRLw/TdVKrl2djP6Ac/dgAievPSnFUcJBvF+bC0TTuGHARUO/mqfTS1WQFL2edE6uMNqygae
 5Qt3axh10xg3YgAocz+zm8osfXV2HGns3itVkCq2XBATODA=
X-Google-Smtp-Source: AGHT+IG9fMSUJrx8RbpWyIvtvV6undzA/hz5NJKTBRjncNwQxTvLo8ICI7hIVTbrnfRFzwTCE/GYag==
X-Received: by 2002:a17:907:a089:b0:ac2:972c:f732 with SMTP id
 a640c23a62f3a-ac330324808mr232122966b.33.1741947504843; 
 Fri, 14 Mar 2025 03:18:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aea93sm204446766b.30.2025.03.14.03.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:18:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 495255F92C;
 Fri, 14 Mar 2025 10:18:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  QEMU
 <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: Cross-compilation artifact is broken
In-Reply-To: <CAPMcbCrsvWJu6NsE8P6OYCLtKYG89zSviCoW9_YF+BTUB45HeQ@mail.gmail.com>
 (Konstantin Kostiuk's message of "Fri, 14 Mar 2025 10:21:58 +0200")
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
 <871pv25iar.fsf@draig.linaro.org>
 <CAPMcbCrsvWJu6NsE8P6OYCLtKYG89zSviCoW9_YF+BTUB45HeQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 14 Mar 2025 10:18:23 +0000
Message-ID: <87tt7v3ogg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Konstantin Kostiuk <kkostiuk@redhat.com> writes:

> On Wed, Mar 12, 2025 at 6:24=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>  > On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
>  >> On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
>  >> > Hi All,
>  >> >=20
>  >> > I cross-compiled qemu-ga from current master branch
>  >> > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavi=
or.
>  >> >=20
<snip>
>  >> > My question is, is this expected behavior or is this a bug?
>  >>=20
>  >> Your configure args don't include "--enable-debug", so I would
>  >> not have expected -gsplit-dwarf to have been enabled, so I'm
>  >> surprised that commit casued a problem.
>  >
>  > Hmm it appears that the meson  "get_option('debug')" is entirely
>  > unconnected to QEMU's --enable-debug configure flag, which I did
>  > not realize.
>  >
>  > IOW, we've got -gsplit-dwarf enabled by default for everyone
>  > building QEMU, which feels dubious. IMHO only an explicit
>  > --enable-debug configure arg should have triggered it.
>
>  --enable-debug is more than debug info, --enable-debug-info is enabled
>  by default. If you build with --disable-debug-info then -gsplit-dwarf
>  won't be applied.
>
> But as this broke the Windows build, maybe we should disable this for Win=
dows
> until resolve this problem

Something like:

if host_os !=3D 'windows'
  if get_option('debug') and get_option('split_debug')
    qemu_cflags +=3D '-gsplit-dwarf'
  endif
endif

>=20=20
>  >
>  > In addition since its breaking Windows builds, it appears we
>  > need to block its usage on Windows.
>  >
>  >
>  > With regards,
>  > Daniel
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


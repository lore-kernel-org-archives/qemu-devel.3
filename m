Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4912C83F23
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfJW-0007yO-DS; Thu, 29 Aug 2024 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjfJV-0007ws-BP
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:35:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjfJQ-0005K7-HU
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:35:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so668495a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724938543; x=1725543343; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yeqwa/66xo358U8jOGHzHMjFv9R0TEjKGPwZB9UJaOc=;
 b=pCMSxraWk2dKuPzz5EVtkp/2NZKTcS6ymzB/PU/ojQWymxkVMDDO5b/gZ/qB6vmTbR
 EGczzRkxvGLDlKk/q2t0AVcCURtk65YGnog65EjFjDJ2s+XM4Lfc2xNWB1NheBaNtT9g
 tNGIHHCFgtO92oFTk8R/Pg6d89veN4/ANgiEos+zQbhGhaEsoxny0UGF9EtePHYlmkTr
 w5A70G6d1fPJ2LH+Na5hsM0ML+PpNUYkJi+lB3SiQKGtVQuKZCedYb4L4XZ08whqzes/
 SxYhE92pKUDRhCVeAAeyWRV8LL4BCjavihFyZ8WQE/Ke/Uti2C18Zsm0HOOSVuIbAeoN
 q1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724938543; x=1725543343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yeqwa/66xo358U8jOGHzHMjFv9R0TEjKGPwZB9UJaOc=;
 b=Bg2/scFabxsQjBb5cQmCGurLROqbY7mUgl5JjUoFnsCQjr+v4AxcKPiCTaofnyIPjA
 QHsk16WlDUrYcLcDCdGRgRTB/t9WVU+b+3JTncFWoQehzupg3KfNkctibh63gkKE22jU
 XYzsl/N++iuq1M6aDAEZH7hqv3BFdJI+T5EtUolUzcQvCG3YwKM0OkkUVxBbfKh9/3GR
 KlI03eCvNZekZv+uW5vSCsKjr3455Ghrm2JtFsmH7FLe/mVeo/yUJS9YW+LkzYQlM/jp
 zkvBFwDNTmNBhkPItV/jMe5LVB9xqLDes2cjsVLXi5odHmMMUrc3xhszdJyhnaJ04ycE
 lHhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ynKelQzA1Np6h0rk/2Wra8d43qFTQmQnT8c37mQaxufn9c0u4VD0kVzSJq0PB+O7xewwiS0gdxS9@nongnu.org
X-Gm-Message-State: AOJu0YzUycO7HP+Apnn1/FeT0HvllwZCrplwcwKNgAZBUXsPYCFVZVlG
 WHNSiOSJl4vL8B6iIFgrbMFd73vmd40FiHmaQMXkgnCBXOJ2pCGBkH1IcIiu3KhDKm1Ah6oy/Q3
 i+MRKQJftvGSIa3vSwIzJso5UAj8v3RAfiw0S3g==
X-Google-Smtp-Source: AGHT+IFD+1Fne1VlzbwcNDL2QpC4KlTzUXxg6EZeLpjW7gFUE5BQq0AImf1www1S3+DIL/txa9gdAQJ7p1nCfU01QIw=
X-Received: by 2002:a05:6402:34d5:b0:5c0:ac1d:b970 with SMTP id
 4fb4d7f45d1cf-5c21ed9febdmr2168394a12.32.1724938542443; Thu, 29 Aug 2024
 06:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
 <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
 <172493799281.162301.9447178356877601539@t14-nrb.local>
In-Reply-To: <172493799281.162301.9447178356877601539@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 14:35:30 +0100
Message-ID: <CAFEAcA8dk65ByV+x6A0hapL_D-52Rxwk35bgG2YMfL6bOAbcPw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 29 Aug 2024 at 14:26, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Peter Maydell (2024-08-29 15:09:44)
> > Thanks. I tried this repro, but mkosi falls over almost
> > immediately:

> In the meantime, looks like mkosi is trying to create an block image, but
> that's not what it's configured to do; are you sure mkosi.conf is in the
> same directory you're calling it from?

It is. I notice however that the manpage for mkosi
says that it looks for "mkosi.default", not "mkosi.conf".
Maybe it needs a newer mkosi than Ubuntu ships?
(mkosi --version says "mkosi 12".)

I'll use the images C=C3=A9dric has kindly generated.

-- PMM


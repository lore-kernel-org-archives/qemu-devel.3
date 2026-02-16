Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35983E7BD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwey-0004tz-6P; Mon, 16 Feb 2026 06:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwc2-0006Ka-1r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:01 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwbv-00087w-Ms
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:53 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-649e97f1e1eso2310702d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 03:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771240670; cv=none;
 d=google.com; s=arc-20240605;
 b=aNd8tY3zwDEaN6kYv4um6e1E7TQMU55s89K6mDtqey6i0aPZ1qePhYl1XwYcqVBnA+
 FdHubZduEw44pAfEPMk6hyzGty2/yyYbwq5CQx3p5y6UaRmW1Hb6Yk5RK9KPV9YMHR5s
 fb1JjdDY4A4BOoMHvXvlZBA46B7d5kAvk6wjPWLbAqrF19kXl9ywJa/0OMZqs4NtRMLx
 qmA8E2DSuVbxzzixZEHViDEBZRrG913Ksh9e5WAcSpfRdVi/IW8Ik9CKql6SKx5eSoDZ
 1vXdpHM3RrlGDEtUGzLQHqzBlw1Hn9zQ9b6sv00TpYGAIKN9iquglnE8TgpdiHoQLgCU
 E6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bGLvJI9rF6W969QEd/biDM/jDWTv2iAygutAU+gJjk8=;
 fh=I5tr3i9n2QC1pyQdwifP6VrsNtFDNDtCyXzMxIH0Wkw=;
 b=jdvRQEeBrNokiMZxg5fQY9XriE8nU+Pl5GUolCu94UHA93x0H+ahbDjZJ70KPzp3XO
 iC815KmAeJ5ej2yJZJBYm+N7NsN1/g3ChNml1l3ttoIRQk4z/nqQcjxSd/ZFBygtidze
 O9vw0aVwEKSVvjLKLtwRx7wZysWp8s8xE5supbmbB9/Z9oEClEVKiiyJkX+EAJaeA57y
 ko9782Uf0BycFmaFBduXct7F0PTsUng3g3GFZeeo2eQUm4qFqCyIMabBBhEdezsBuq0e
 PRwN3YAdxjpuw1HSFPxBeyBoMsxIuEEJNqIDVmxS2jjgYNY5CWt04WHz+fNvkgA+RYug
 eeiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771240670; x=1771845470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGLvJI9rF6W969QEd/biDM/jDWTv2iAygutAU+gJjk8=;
 b=czu8x2rrlw2on1YvtdebyAALw+frDjJVoWdh9iIJKZxMt5LC3Q3v+pLpzj9bb1Hw4l
 e1H88F823kvcFyt+FT/cxSprZ/G4u0WsoegGylVYeaB9ysjaZUHnvc66OF+EK9MhjSxl
 oGWr/bNkPFFtXpCnCPRTuTZ/CC7iKyc5TIaHLmq2UfRU0AD0MHRQNMnjfYnv6ONXjf3C
 B/l8FJ83pUnoHmvoHlTR764uwECXlu5r4MyxN7I1Myf89ddVhRi+PnCACiLBpcM2DJ+m
 jO3SP1vTo0x+MIQN9FsgSZL0l3XgcKZAgquhezfGAdF8BT5PBWeaRKPIdkH0BdDknesK
 WrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771240670; x=1771845470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bGLvJI9rF6W969QEd/biDM/jDWTv2iAygutAU+gJjk8=;
 b=BBtW40DicwDVJEE7PBvY5qofZo1HNlsUJw6fVHcHZJ+h/AJpG0nkGHDBTGXe4aFLoF
 BJDgdP8TGfNMBbDIAg+RLuTDpMakCgucq76uIHmZxrundKe9QWqAIP+TOhpEBNmVvvQg
 iEN1Klv0IzQKF++LJPirJi+enpkWS3a6wUenRn1veHXbIURhGngfEq089WY5NLkv9YY+
 X/dGWcEOZuszAAUNG+7gZal++rN1KGLcj0gWW1wxMXg5ys1ibDbChh6DZBrWRMmbpsuY
 ZEByomYZbzBcY5kuG8FvzFGZhXkyapYdlnPDtBkYe5y7fpoxkQKv360fy3jUYS0f2dqh
 gZVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYV5R33LbB/EBQSrMxP3EKt5JZy9ytt3LIF9ZzpKgOhYBZH+0sf+YOBcxtpZmswCeQIIufpXTG71Nj@nongnu.org
X-Gm-Message-State: AOJu0Yx2JeSsHX7+C/7lZjdFUTyxrDH4ODf7mNQyQUq03CDFDHEecAz2
 etWLv94819ixJxbUFiFsZ4S3+tj6+qTab+oaypTPhmPQljm441LzaEym+gIQtwOBtG8yf/UZFbh
 IbJM54GiTNgZpjtPe+7fAFcnMyoMoeadNQfWt2JC/Ew==
X-Gm-Gg: AZuq6aIvFjUU7aJer7GnBYeEPoR4UBnwNgouaaif7VvcicQqwzox7tTKk1Jl8eEE24n
 07CjRYRRP4PgMSL9uQy8IdJrm61HC/+0Xib8VJDjBxnAbaLYpzXJm6JZDPZvL3QdivQcYJJNl3G
 31gRuzVneSyo56GN//zsgnldhplr8+Nd+UGIKgATbOh0tpQVaXGTTzDHSE4JZD8l/qh9z5ciy+q
 73hqxJMxOhDjsvtwNIBfuvwpA4KJmNUQioxyv6nk4X/nYGwvkSXrtSPDMmUG+ADXZAwvQxqDaN/
 hOSQxy+dI1BM3SoGAUuxfGqWLPJhQ6s2ixlPneDdBc56LVdjqO9NZfx0pY/tXkTMiEg=
X-Received: by 2002:a05:690e:1503:b0:649:d40c:7ee5 with SMTP id
 956f58d0204a3-64c14dcbd22mr7383649d50.79.1771240670004; Mon, 16 Feb 2026
 03:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
In-Reply-To: <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 11:17:38 +0000
X-Gm-Features: AZwV_QjkAtd8o1L8R3U42l-5v26Hsucunwmnf6JzR1dCAhNkLGcCjZqRKGxtKYE
Message-ID: <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 16 Feb 2026 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 12 Feb 2026 at 21:42, C=C3=A9dric Le Goater <clg@redhat.com> wrot=
e:
> >
> > Add functional tests for AST2500 and AST2600 machines using the
> > OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement the
> > existing SDK tests and verify that QEMU correctly boots older kernel
> > versions on these platforms.
>
>
> > +    ASSET_SDK_V1100_AST2600_515 =3D Asset(
> > +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2600-default-515-obmc.tar.gz',
> > +        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c=
0f6')
>
> This asset file is over a gigabyte in size, it takes forever to
> download, and our functional test asset download framework has
> no mechanism for giving any kind of progress indication for
> downloads (or even for telling you the URL it is downloading
> until after the download is complete).
>
> Can we have a size limit for test assets please, at least until
> the framework can support large assets a bit better ?

Followup: we have six test assets that are over 500MB in size,
and they are all aspeed tests. Please can you have a look at
slimming these down?

thanks
-- PMM


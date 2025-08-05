Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8709DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujFJl-0003wC-Hz; Tue, 05 Aug 2025 06:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujFJi-0003mg-NE
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:54:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujFJg-00010y-V1
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:54:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so3071801f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754391286; x=1754996086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCkAnOYJWSybSa+pI3XogF0jakJddG398nCAPcL+Djc=;
 b=zXkHJwpfJ8BsoC3yoN/x+7assDozj+qOe9+5XzWfaceLyezsxvFwElx0PiLeOWAqpR
 MRdUSnwWstgznRh8F+qROPA/NiwjWeLdIrhewyIJxq2LBc3hwtP7h5uPjk5lZmbR3dkz
 vqfGR4P15cvMLJNY4+JyJJ1i5d3hQrJfnSO9B6BhBYao4PHrdvfpdBURUTgYOmVhnuB8
 pHI1Au6v+95PCe8pJPVqHRP2vMpUFWyfRjHGPNHkQF+NhcOKNSsyUdGP2FOWYJQt73ZS
 T/vB1p/iugwc9WSQ9FV+ej28IwkzOJNLvCrTa9Bd1M8xbSVFhSJgy6cVbP/oLv61EHAY
 jhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754391286; x=1754996086;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCkAnOYJWSybSa+pI3XogF0jakJddG398nCAPcL+Djc=;
 b=YvgZ6+qhEZer2z+3a/6Ye/M5MV/D3xcgpxUa5t6trQ3LU6ZPEVhSQ/g+KlJzwGqxwz
 PDOyvkj4wB48sq8sqdRRchn5doot1Cj41lzew18Ie+J6n8SwhCsRsCPkmXthRb+ON9DA
 ha49EQCKp0uVp2//rmAw9i1wPjmKx+VwI3AZ+l4+snSxaDjQMSoAYmsMRoPNh0GPGiZk
 /S7+i5O1tecR2TieEhQfGNjO5WITKa0TMK3NS5jUxUp3+QHyJBy1Nx6Kef8pncQR8+qp
 iy9A/XwuW6ptlqSuQtHBE+4Tl2JCKofCMEQPQiSedtwg9eVBY7q8m4cBUWh/+bATsEFM
 +dJw==
X-Gm-Message-State: AOJu0YyyZoGB9twjt0oamnkik6vuyKwL+l6aAgyeVDGPoCUksO8BAxmT
 pZDiweLFmhiqolPKPPjqUamx/J7LFTOAoflwOopv6sL11y113t/BUIyVG87WwD67Es/SfjRMgyF
 qVwfr
X-Gm-Gg: ASbGncvShj7CkPlkWDq/AS2AB+yG7M0DLK+SOF3LLGX1lOlB+nRL6KjxDv5CBEdzQ2y
 Cp54ZMLG20kDnzP53zIrV6LxepyKFv6tEkaNo0K/59+ZGH8LBhtfF/rLRs26UAcgUkr7yYb7mxJ
 LD88k4MBN4qrw26tNfpQ1zEBO5QjJXh+85/wB9GwQt3IrdNJlGhzMwhq/z9igNqQeNHn+VyywEP
 zRoeUuc6nCWTcV9IV+bvsZ5qKuY6S+m/Ei2ZY6f894JRy9sdEpEt2PaVhKskBR9GfYXIialys8e
 +nQq9hLtC6yrBMrnKpaNaY+T9v0ZWpjv+hGBEiO2DDqWGYsHcyV9OusT9G/YZlJUkHJxojd2UNM
 BzDbqOTab4r4tolTCyh8gWK4Bf+7HBPQfcw==
X-Google-Smtp-Source: AGHT+IGEEI3Q7u6ZuatslwKHRrBhua9lWFmukPxURsRrvbqeM+Mg2RL6jvkvVsVf/9P2gNDCtKhSaA==
X-Received: by 2002:a05:6000:2385:b0:3a4:d9fa:f1ed with SMTP id
 ffacd0b85a97d-3b8d94727e6mr9184917f8f.13.1754391285808; 
 Tue, 05 Aug 2025 03:54:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c4beasm18384386f8f.30.2025.08.05.03.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:54:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 356575F7E9;
 Tue, 05 Aug 2025 11:54:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] readthedocs: don't build extra formats
In-Reply-To: <aJHU0w0gWe8i2uZ3@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 5 Aug 2025 10:54:27 +0100")
References: <20250804162959.330060-1-alex.bennee@linaro.org>
 <aJGunKewK5aulbLr@redhat.com> <87cy9a5ec5.fsf@draig.linaro.org>
 <aJHU0w0gWe8i2uZ3@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 11:54:44 +0100
Message-ID: <87jz3i3uob.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Aug 05, 2025 at 10:04:42AM +0100, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Aug 04, 2025 at 05:29:59PM +0100, Alex Benn=C3=A9e wrote:
>> >> We don't build the PDFs ourselves for the hosted docs and it looks
>> >> like rtd can't manage building PDFs now they have gone over a certain
>> >> size. Disable the extra formats so we can at least have the online
>> >> stuff again.
>> >
>> > Regardless of build problems, IMHO, we should not have been building
>> > the PDFs as no effort is being made to validate that the content is
>> > formatting well under the layout constraints of PDFs
>>=20
>> True.
>>=20
>> I will say the one thing I have found PDFs good for is uploading the
>> docs into a LLM context like NotebookLM. Otherwise you end up having to
>> add individual links which a) is a pain and b) is a potential DDoS
>> source if the model keeps hitting the host which as I'm sure everyone is
>> aware is a problem for FLOSS archives at the moment.
>
> Is there a "single page HTML" option that would service that need ?

There is an htmlzip format but I think that is just a bundle of html
files in a zip container. I'll see if there is an all one page option in
the docs.

>
> In general PDFs are a pretty awful format for programatically
> consuming text, because they have no logical content structure
> like HTML docs, so I'd expect HTML is a better format to feed
> into any tool either LLM or not.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


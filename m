Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D8C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtuEB-0006hG-OJ; Tue, 11 Aug 2026 17:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wtuEA-0006gx-5U
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:41:42 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wtuE8-0006wE-O9
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:41:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so604101a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 14:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786484499; cv=none;
 d=google.com; s=arc-20260327;
 b=ROf89K7XpizJUu6+sE0uhdtdvisrqbLuurxh0gjm1PqiffcwEwzjdDqlL5DTcyndtr
 nuoeg5JG7fO10DFbkIzLQGg5B/c/rhPURmhfvGuRPr0LIIg2uLebJ0lufYsS+o2yS5P3
 39zNK4qKMyKgz5XWsaAf6ltyFpmcFsgJuXVDBFgmMthu+Wu/jfH2QQcmpmnb1JS+n/NH
 PAQkX9u/hrfipFxfn0E6MvgBHI5VaybGXOy0T6xcqYg/y6S2alnCp5a9u1i2OKZa6Bj2
 1RfUYF2ZaeKq5zD2ro2PeD3s2ZJRnUdFx3W8vaSxNJsNqXAc/C6OpumkCM14YoJJik2i
 NKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NQVmRXaz8/AYmlh+xs6v6GqWK1Gt0bNRn/BDbs7DMXQ=;
 fh=88dyGroI5/cS6O4e37x3nyzaWfok96Lmj8QAs59Yqew=;
 b=SI5H4bXA8OqkUCxGVDqhuSfWWAilg8k6V6hTQuj0dpQFsqQWcY7sWBH22HtWAkJbxf
 a5lnPwqDe35uWVHlkBRuNoDVoL9vX3BKbY+4E7vDLG/Q/bAEZarptLr+xcghR5PdKh8P
 mK8ADEoaZmvyCPI9gI+sj6s8yCtJj48qYsAnYtSvH+UL2itjcXfS8YnuejubKryQh/nI
 9xI876EO296Iwpbl0pJSor0qclkPMvmyB6/wFmp6VsNAH3hVDCtUBG+1vMhPGJLJGwfk
 rv2JWI72PS5fF9HVkpd+sO3O+PM8u+F7UEvekl04EeqYd1jVUQk9XUWHsOi+LUwqDFGn
 w50g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786484499; x=1787089299; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NQVmRXaz8/AYmlh+xs6v6GqWK1Gt0bNRn/BDbs7DMXQ=;
 b=drVgm5FbMGDV6GTQcwQlguCeE0D+6Wy6NGyUREFsqpfI7CNvkQIYainmG0z8SkXBS5
 K3JJhgjWdaUrLJbagoQ+S2Jly0rgyWtfrcW+KguSMeh0heSH6wvA9uh2z5VzYNaxu+S1
 KwQ9jQSE0Nno6sEH3vXwGw/NT3zXuMpmsXAMv2qqAqkbTLIX0Zu0lrkXzFKQyFIjbJp9
 3ltSivk/AqcGVUkStohTsVAwjiNj+x/ILUzM1trRsqsSaH7CKVKFxY3A5qMq7Xq+2jWY
 GwyW011DRjgAziD2cY1UKv/Rwmyg3VSTm8Yl5LTiV0x1U0QUzoXK3wn32lLjUwuPg7Gb
 bd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786484499; x=1787089299;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NQVmRXaz8/AYmlh+xs6v6GqWK1Gt0bNRn/BDbs7DMXQ=;
 b=saMs2N55vwlFXs1rUtUa3adDM93gJ0RzHhOhytvKFOqNbJMaZsm+IlZBzVTwAdDav2
 1HrDjnGOWPVhrN6paFX41VfQOVmH+szWaVtjMbD0HqL1Y7iSTrEfwa76E8KLAQx6PRMJ
 Tc8Z7iKFTl1taJQ06ZBp3MadfnyJ98QtReLz1jjIVCx9963XuW8xioLyBy5HBxMhrdBJ
 TzSrCAQ/zRwAxSsTgAbERff4/IlQopdWWmYmIpCdzXYV/0jPwMatofK7kTDs/A01BNiV
 zCXJ1GLMNxYdriE1OWAARtb+tGW/FrEsyvRcG3BqpMVlNSfeZj7u8vnVg5YHJaln6EET
 3vOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RreGPr3huHJqEMXMjLZXA1HAoUZeDMoJUn4tnf27txo1AaauL2LaAKnLuQFFCWKuAAdgqVe6W47r4kd@nongnu.org
X-Gm-Message-State: AOJu0YwVYB5+W4depc8A761cbSdY7X98q0alkUBkPnh3BZQjSTcPmLXt
 ELhmlHBeq5V7qSA04x19+/gpgr4yo9wAX1ric2NwPTC7BjvFRo+0iLM63fOx500QdNpTmvDfUTP
 qO42mzthooSzgk5zK89dYTVA2/y5G6RM=
X-Gm-Gg: AR+sD11noSN193pF0IG5U+lIbuJfhYXsalOwobc0IgyqZC9pZzbb0yMj0vR09p5CVbt
 nyMd71VcRnr0wW/lzTIxsBAz1W4fNhQz+DMGkQaRLcU+4wfMxUW6jRO8uZPLXgcZCnaBuw68zY1
 uT3lQmeZ2csc3bwnketw3UQKEwDKCsVOdsFmZMxrH0iu+iNDWC5QVWnYGkc2H5bxx01we4zb359
 sycEZazNaUmboz6ATCqxuxcvsyIuL/MUHU/uOuLj7JF67V3qRb7L4pJsuKO8tLEc87m2Y4bC01r
 YkY5H8fm1EAHetK2/WE9MBqRkFdtAsimOvvRt3K/YgJLoaneboGVpeZsZ+RRaFikNsEBWp34rZ0
 yOA==
X-Received: by 2002:a05:6402:a01c:b0:6a1:f8ad:6c0c with SMTP id
 4fb4d7f45d1cf-6a36c38b37fmr1520612a12.16.1786484498604; Tue, 11 Aug 2026
 14:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260807144136.2637416-1-pbonzini@redhat.com>
 <20260811213716.GA200944@fedora>
In-Reply-To: <20260811213716.GA200944@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Aug 2026 17:41:28 -0400
X-Gm-Features: AUfX_mwEvfjX6uYDczv2FYKFrb8sN9zbZmuK1V7ymwXNiBmfciTDWDJn1YkjFRQ
Message-ID: <CAJSP0QUBeZEpa7WAY1eFMBhe0AVJttX_+FvJsrvAWHOX8BxrVA@mail.gmail.com>
Subject: Re: [PULL 0/1] target/i386 change for QEMU 11.1-rc4
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000efa5210658cc5531"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

--000000000000efa5210658cc5531
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2026, 17:38 Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for
> any user-visible changes.
>

Oops, that should be 11.2 instead of 11.1.

Stefan

>

--000000000000efa5210658cc5531
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 11, 2026, 17:38 Stef=
an Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
pplied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/1=
1.1" rel=3D"noreferrer noreferrer" target=3D"_blank">https://wiki.qemu.org/=
ChangeLog/11.1</a> for any user-visible changes.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Oops, that should be 11.2 i=
nstead of 11.1.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000efa5210658cc5531--


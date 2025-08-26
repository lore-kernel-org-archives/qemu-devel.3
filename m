Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C7CCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrw9-0000xj-RC; Tue, 26 Aug 2025 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqrw8-0000vz-QU
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:34:00 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqrw0-00011X-RD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:34:00 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e952a2d1813so2649431276.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756208027; x=1756812827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIdYuyfCpfgkxeHatMec8+zonmpIcSVj3Cxz43Ri7i0=;
 b=lEWvQXsDKiP2MF+7bS8lGKGgfP9n/jVM+JD3a0gUN+QWdmyOolbSU1FGVTizfybmJb
 ZYFxNaouk2yT4ZrK+u+Y3/gtKZk+aLA1o2QkVnOFc+9hHAssgEcNzkyaAxf8aaUpWGnT
 yRmtZ7evHvxyYRjWtkTZGRCmdkSgLOXFgsjOBqrR2TRUh6UIrqI4lLDY6fIXlgE65JmA
 7TOJTzoFokth+o4M6uOL9pNspny7A7I1l5mP9HAYIqRDI+j1DiZEktzUdQlqk+eWgLAB
 gz8WOdp28NE6b30pnacYizVs6jVlLHn+sG3FRBHP3IyDRKlac7z57OmyE+lYpt9cJoVt
 dnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756208027; x=1756812827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIdYuyfCpfgkxeHatMec8+zonmpIcSVj3Cxz43Ri7i0=;
 b=fB4M5tap3cWsKWt9D0gXkHFO92oz/yFJHfHr6X/RcISHLVXg3762btrPymvijwulw9
 nik+3WbOE7pVlkCKzZvxxkZBgiqO9dOnhSkxobY4kYHngAh9WihCN9GtufcgcX6cEgJc
 um+ePXum0PDuB8wzOd4omc6/kw4IqI8X8L0GXlMe/q2Z4k29x70OrjnYxSF3GLKhG6yN
 s/kJ52upeQlJtv0qVQ8Bt7h2ZYgdUBp4JJfeT/OPSwj3p14Np0Btu8MrXlV5kMJ/pJsJ
 wEZ9TbJAYUEDK0qszp7FSEPo3JHSF7llcTs8dr5pAZRCiebVAfAgGhEqcyODVmtr7sK+
 U95Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8AH4yZ/daEZg9/wbh86fggl0vt3VLlX2Sd4q1UwPch3JfxMrWWkJy0vr0vOCdG1zGdh+GV2cUklbM@nongnu.org
X-Gm-Message-State: AOJu0YzFzXwMX7SexK33eu4DxVva+FazUv1BZlegmqsFlzm0HHYYapSH
 RfUGtYyhR7dFAZT5sCTC2yzal95k709WBkGkmqZRwBvRzKmdSXv8lvH1h/vBP9qfjQag+s7yiVf
 prejtFsx+XEuTXMoD9arQUS2t01yS7Axkz1Zgwl9pDg==
X-Gm-Gg: ASbGncvXgQp/93hJn/IT/KM4ujglK2NdbN8jNWSMtn/+JUicj1tzOzVQ65+hlECzHsq
 MztQ8oAgptbtElHlkjaCSgkWbKOsB8gimtPEKxmNxCrUhGTzqM4F2P/40RttL0PTRA2oyGdTyxk
 +AMncw3qCOjbm+9vTGHjAkjra7GVII4Dt2vHuf9ca5BM4C/fDY8DxLrA3pwWvbGwurFukwNcQ20
 PqNqMGY
X-Google-Smtp-Source: AGHT+IEWpoNIadkGJuhhyqWBYgWj3RetRZhTkbNwP8GEwoVtDEpeeytbOeDrbbIz+i+HU2L6L3raOv3mfsh7vpx1Pas=
X-Received: by 2002:a05:6902:f82:b0:e95:7f3:4c7d with SMTP id
 3f1490d57ef6-e951c37dcf7mr17716650276.47.1756208027404; Tue, 26 Aug 2025
 04:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-2-pbonzini@redhat.com>
 <aKwPkXzi67+UGAnP@intel.com> <aK2XRJgW01rkK9EF@redhat.com>
In-Reply-To: <aK2XRJgW01rkK9EF@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 12:33:36 +0100
X-Gm-Features: Ac12FXxahZ0Yw1dLxTMZQdN4E8TjRbWR9C4gA8etLuFoxEQzIKOknlooYXfkgr0
Message-ID: <CAFEAcA9Z3=wbixi3PSWGWx4gZ+7Z-WoDf--99KOEXkdCxA8oAw@mail.gmail.com>
Subject: Re: [PATCH 01/14] treewide: write "unsigned long int" instead of
 "long unsigned int"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 tanishdesai37@gmail.com, stefanha@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 26 Aug 2025 at 12:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Aug 25, 2025 at 03:24:01PM +0800, Zhao Liu wrote:
> > > -    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02lx\n",
> > > -            (int)addr, size, (long unsigned int)temp);
> >
> > tmep is "uint64_t", so there's no need to convert its type?
>
> We can't assume 'uint64_t' is a match for '%lx' - the
> format string can be changed to PRIx64 though which
> would let us drop the cast.

Yes, we have quite a few uses of casts in printfs which
are really only there because the standard way to print
a uint64_t is so awkward and ugly...

-- PMM


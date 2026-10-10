Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7483FCA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFSpX-0004vl-8O; Sat, 10 Oct 2026 04:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFSpV-0004v2-J2
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:53:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFSpS-0002GU-QL
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:53:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c31745ad205so409260566b.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 01:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791622397; cv=none;
 d=google.com; s=arc-20260327;
 b=px8375UmaVxiN1XlE5xll+h2XU6/l6sOWC4fekSy0r84cTUiDBqYZdaDbdOAyfgyda
 qhVJio11g8ryG+r4y64MovonC1V6iV2dJ4OfbS6YfsZZZWm1CxUJGFrGDBdCFWfQKmsE
 Eevp3xEl+4hueYBJoLPbjEFR/4rn2n0CH8jauEvDMTJK0pAX47LjOYZRNoF+4+Q/hgwV
 6MlltUR2LUBgAUTuz8Kg65VXeoFIVWCi63yf2VBVCIy58pr2kOczRTnGejzuBlw9WbBo
 +Tg342kfkmBVmXOyBjNsWuvBH7OKd46GxQ8cOoNmR8Y5wwAq0TzOEGbStdU//eKCwLyF
 murA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=WK1Rps2yQvRTxn53KhTV+hWiBoMWSl797Qgk/KbZt+A=;
 fh=mae07dlBlBJ/iV1BHFpwTp8kA0uUnHu7GOBSnMhRgTE=;
 b=I58CUQxJ8cRKQ/mkZgN0AKfQQX5RxQxi0nmhoD8JLm2jkt3byCyxUWN9Hu973CRgrm
 A9sZWwU/iDKVaALJK7w2H7s8I+h8mNbl7Pk7U5SwVSFgssDHXFD5T39e7BZc+WR/irp9
 RD5b9vFi5v7LhSo7f0PkbOsH0SvftpBTkXBvqSik5M4RGtoZMXsly3PAjlICy3TompJP
 U8GVWctBa2riYNz4lMp100GMKS7WOazpqfCZ9LIvGyhuq5H2e7LwbgWuOfUdGQXX6aIy
 QK4OGxuKuj8mY3Fd/ZxEsD5YhgXPih/zwlO2W1cyIkElEh982KmaOscWfEfJAIWdNS9f
 1/Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791622397; x=1792227197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WK1Rps2yQvRTxn53KhTV+hWiBoMWSl797Qgk/KbZt+A=;
 b=UOmGmVjBGeJgrfppulbogZjjkCeL1qeOxflZbsHozNbznzfgOf87kJ3NmrEjHEPb4B
 nbzC447V2HtQlYWfLoRbd1Ykd8k0zwAEqYj38+19ZG2KtBQ8jWIvMlJBDz3rQITCLjuq
 EmtZ3MvHpXf7lUZnwx1igNOa6lYsCZyKmhUmeZ0QLZrm89cg4LyIS0I9WE9GnTdFiyKA
 nIcFUXG+bxp8se19f+GxeNmlkQcNYXF7+6oaxOulKgvm037ssCqhj9Mdb706SHCLBQXr
 bphQEWBYpWPcPetxy+rAXB0Xyua77c4gt7Aru5xxIl+n6UkjMXIzjmyhp5IKa94WP9iI
 LpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791622397; x=1792227197;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WK1Rps2yQvRTxn53KhTV+hWiBoMWSl797Qgk/KbZt+A=;
 b=HXY4/bUBTfKrt9/WQooZ28kJeKMH6RGE+aEig2FQnGnTRoNRx1mHxpgKCQCSXE2upU
 2tOasiqaZrG2LfGpYI4XndFM7exmG1E+WC8w8ZglQKq6adgSPF+0AsfXaSOffh2JRmHy
 2IGviFhYqtupSnTG6lhkMygfHvZzxEzbAQoy8K7JHOQs0ZTtHD9CnRMh6bRBttjQE8m+
 TzjQPGIUr3nMnk6eQbedlM1PzXWEJVhl7znBu7tqtPO4cixwfPoe/3MCW03uq64xhN6d
 77S/ztyVWFi1AtDzJPUbJ7hws5V5OtwV+F0XBvLwJsPhlz4gSVWdWHheNFphzm73gGLj
 xrFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtAQ2aneIHUpISafyIK/C32Ew6jZtBL63/wGBFB00ajEer47pYiRNeuSV/A7+AsnCsbYRxFcCSI0Uc@nongnu.org
X-Gm-Message-State: AFq9FYKo35HO6zrlejECxGZXVeFRe4AHXR3Uiv47aaNYgC/+gOblPKMQ
 izn0n811469t21Xy7SnnCd6BNP4N0dl7PJODIYrrcrKOn3UhBl6JQfvFg02qASgNSkYWO7HV+UC
 SdjfkmZfXIZ3dAQSLDc9OBNz6waECeV4=
X-Gm-Gg: AYBFou2o3HU764alYVPRJOF62BGHi3SBygRxtubYzxUWCt71pHKLvkqj7RJ2GXA2mov
 kYWnIopDSJEPif+QEf5Q6g4ytaFxBAYrcjg5GsjMfbVzt0h+H2IQtSJhYPZVkYGocuo+7kabWyx
 06XIq2t1KwR186kkE+AXG9UZ/rr8YGSehez+wj6Y05GRsmAysK1pgY/N0dhAcMkECccTN3hQVE2
 mi1vsN7QUeaKg/gJqrA7kftB1XtA2pd5C8ROvTlfZdSbq4Zs0IVPQtiMxlVnLedYQ2oAlVgaA9I
 4bm291RgiMU8WeyTFxnhpbAfCs3G03QTT0gv7bQJPP4ixY7aWdlI84M=
X-Received: by 2002:a17:907:3f10:b0:c2e:204d:9490 with SMTP id
 a640c23a62f3a-c31a704c117mr486284466b.17.1791622396469; Sat, 10 Oct 2026
 01:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260930073935.712-1-luoyonggang@gmail.com>
 <20260930073935.712-5-luoyonggang@gmail.com>
 <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
 <f8ea6e43-2e6e-48b7-a61c-d9ec2200872c@linaro.org>
In-Reply-To: <f8ea6e43-2e6e-48b7-a61c-d9ec2200872c@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 10 Oct 2026 16:53:03 +0800
X-Gm-Features: AclHuK-mGE5Tz1NdZxyasvNIzxWLi83QMEQdr3i_f1dXs3mg-q_5HqkgS36z4O8
Message-ID: <CAE2XoE97kuRkF4i2+t=tH0d0dXWjCaNmUjUaVZDPekWimSN3gw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Song Gao <17746591750@163.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 10, 2026 at 3:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/1/26 18:51, Pierrick Bouvier wrote:
> > On 9/30/2026 12:39 AM, Yonggang Luo wrote:
> >> Use target-specific assembler names and helper metadata for TCG helper=
s
> >> when multiple targets share a binary. The generated prototype maps the
> >> generic C helper name to a target-specific linker symbol, for example:
> >>
> >>      helper_raise_exception
> >>          __asm__("helper_i386_raise_exception")
> >>
> >> This lets target helper definitions keep generic C names while avoidin=
g
> >> linker symbol collisions between targets.
> >>
> > Hi Richard, do you have an opinion on this patch?
> >
> > We are trying to see if we do renaming per helper, or if we introduce a
> > "generic" way to deal with it. I don't have a strong opinion, renaming
> > things or adding more macros and build system soup are both ok on my
> > side, so direction would depend on your culinary taste.
> I think the general direction is good.  Perhaps the specifics need
> adjustment.  In particular, using __asm__ to rename symbols is suspect
> and likely non-portable to non-ELF hosts like Darwin and Windows.

I have already tested on windows, only not sure about Darwin, let's me
create a test on Darwin,
because I do not have a CI for Darwin to test it.

>
>
> r~



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo


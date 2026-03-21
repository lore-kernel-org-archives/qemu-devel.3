Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAA6109447C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3wty-0003iV-5r; Sat, 21 Mar 2026 10:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3wtw-0003gg-B8
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:02:04 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3wtu-0001m8-Ox
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:02:04 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-89c40b33bddso34130136d6.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101721; cv=none;
 d=google.com; s=arc-20240605;
 b=cIeHAifJLJR5HG7JnHtx0BN5q8VufkYoFMNR83T+m23NVOm9FOVTsbBngRUtYVpG6K
 Q/ncjo27dKOnHCXy9dZQtgi3XvtJIPC3HL64YpeFXQhG44U+YQct7aGWF/gX4K7cdzec
 K9F7IVnSYsT4bA4KJW5sfA4uvy+yitQxy6AFOEmozihAWxG32lMitwVJpOaXy8jg6EdW
 GshL15YGBpVcasPH7mDsG/1rDGOviZHN4Hvjcdn9hXEao151IPjSaza09IvuguTBy8Gs
 HgHP3XbMnPffvGi6tb8dDgqYeaojQCPip9QE9a8K3Z/3b5IAkq+EIwvyPUwtV1YHPUEy
 LSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dXj0F1cw+8qkK06oQOzhjKKLiY+W5d/sdlMD75ClOYw=;
 fh=c0erNo+sJ29Z5IwzOrma4WhJmO9gKlXEZkjXKP7KWY8=;
 b=KP8ARWT65sQVMauF6mTsfQVmYKP1lYFc1i4/QtErqaYLEfkDqbDGaSbmfx2p/B9fU1
 KEJafmVZx0lJDRNnLD96JORCFV+UgK2F4AO9VbI9nMBHCpW6GZccsBEY5SEDMK7AhQ0y
 DyWdpfwUMbjtBAOQR1W9WWNQGWecl+4RJe2Df1G4sZGicItrVdYdLGHKlWE8Dyd6NyC4
 RXr4zeuxmBVb5d97TAVlo2OCUXYT6ONa2GlvnslTQh0dU6NsCqFzKBjX1A4RyHtjItyY
 jguxmULuVdI/cgLuLerHBqN4KLQ4hcowSibIyENAVSDsUyiA1Zx00Jf09NWtZHlMxYSy
 WJ3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101721; x=1774706521; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXj0F1cw+8qkK06oQOzhjKKLiY+W5d/sdlMD75ClOYw=;
 b=NhZxNknn9pKpwlei0fGQXdf1OaKD7eeWUl2c68xLTGe/Xx/hNSbz8VLIF+t509u/pL
 Z+D+Id/Nf+NbcYeLi1GyStdzw+OyLjPYibzI50FllbceyB61SVe3MNACFWuKKwuTCZD6
 0ax/YGEZw5j814+n+67GCXB9lRgqJ/7DNlUDMlaiZ5VHoVXBiXwAcLywjQbkvumQojdg
 aPQDkXqb8u5SOQhNCrDbx/o1UMYudGz0VmP7Z+LubCfbbaNsmhxUfVf0iEuc37Id5Fg3
 IjuL2hi8JoZa6FxYghXpBsEWgqkyBazdlH6fSvO1lcy/OOr++5sX9ycNT2jovsieCjos
 d3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101721; x=1774706521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dXj0F1cw+8qkK06oQOzhjKKLiY+W5d/sdlMD75ClOYw=;
 b=qX5FFhZABqZQ3IA3OV4zb5deO0ZT1yRV6Umhk+Rbq3OHBBfGj///zDmQOGHJJkHZMB
 4e1XzTxIOObSDwfHhbc5RDSn/g5wLYyO3qoF4jJ6sMWEfLE/sBePHRBYjCc3CV0Zye4G
 hrNTInS8A2lqzjc9j4TDkmg1Wsmfa2QtGVyHzD6da0lGWaNJtKWKErnnKMAtHgolFcff
 H1f7WKeciI3daX9XpHIpB9EF7+pMAYjeY/NVkElnttxSoa7L+MFp+9DkixSuflaWVKNZ
 7fUEWVin5a+oXZv2gyebiRm7NxJsi73DHbcGEcS8h6Xtaiz/gZF1LGY8qLAA1DSQ05hz
 pHLw==
X-Gm-Message-State: AOJu0Ywz3eF+0jqp2QNhtFn5dfw1+6gzv1vlZmyfshwb6YuI7AI0pMnu
 NfvQpZ1Q5x9GJucIHit1v5t1WEw4vVK0WZr10tPEihCVcHcTn0GhLjmnyDV1STtCOA7UL7gpS5q
 iVkpo//miWd9Uc2WrCg7UH6fIbWUZpAM=
X-Gm-Gg: ATEYQzw67rTaYYXu7+oIAikuDIfnA6NkIfOXBxlUFLXRyESJmFJgKt6k33gQl3CJqyv
 Ka3qF/52PHT340J99wRjZTKChc0zpvTlE0Tv9SdaRhP5F5JP0xEDl1nu0CuHZGQSANLKm6Q+XDy
 purZSnBa/bQqhPDtbJD7K1si/c9wWmFo18YhL05Z52Ng63tRuLa9mmeSiUkQuAlvVPxaayq60b7
 1mIp6aH1QKr87lHUWc91S9tdngAbjhPgzYARVHaKP25tFM6DciszMH6JQH1poPCR3yyXT/kiQRV
 Q1nnpRcsbKvB8tmWLGpqmACq2ZyFL4YeyahOwh95iZdflvKwBck5XzLMBMOmjC6C93M=
X-Received: by 2002:a05:6214:518a:b0:89c:3f06:537a with SMTP id
 6a1803df08f44-89c7744ce71mr153974726d6.21.1774101721252; Sat, 21 Mar 2026
 07:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260320165021.39521-1-philmd@linaro.org>
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 21 Mar 2026 07:01:49 -0700
X-Gm-Features: AaiRm53G-6ANZVHCd7-q4YYk9bMUHnPr71JIUhNT7aOC_Uj2tOZZ14tRQdf4naU
Message-ID: <CAMo8BfJKapiGNtpO4zPdGiEvM9xL=4gyFyQMupDn9M8T80Hinw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v2 0/7] monitor: Have 'info tlb' dump MMU
 information on monitor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 9:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Currently 'info tlb' dumps the MMU information on stdout, fix

That's not what I observe: I build QEMU from today's master
and run

qemu-system-xtensa -M kc705 -s -S -nographic \
        -chardev socket,id=3Dmon,host=3D0.0.0.0,port=3D7777,server=3Don,wai=
t=3Doff \
        -mon chardev=3Dmon

and `info tlb` in that monitor works as expected:

$ nc 127.0.0.1 7777
QEMU 10.2.90 monitor - type 'help' for more information
(qemu) info tlb
info tlb
ITLB:
Way 5 (128 MB)
       Vaddr       Paddr       ASID  Attr RWX Cache
       ----------  ----------  ----  ---- --- -------
       0xd0000000  0x00000000  0x01  0x07 RWX WB
       0xd8000000  0x00000000  0x01  0x03 RWX Bypass
Way 6 (256 MB)
       Vaddr       Paddr       ASID  Attr RWX Cache
       ----------  ----------  ----  ---- --- -------
       0xe0000000  0xf0000000  0x01  0x07 RWX WB
       0xf0000000  0xf0000000  0x01  0x03 RWX Bypass

DTLB:
Way 5 (128 MB)
       Vaddr       Paddr       ASID  Attr RWX Cache
       ----------  ----------  ----  ---- --- -------
       0xd0000000  0x00000000  0x01  0x07 RWX WB
       0xd8000000  0x00000000  0x01  0x03 RWX Bypass
Way 6 (256 MB)
       Vaddr       Paddr       ASID  Attr RWX Cache
       ----------  ----------  ----  ---- --- -------
       0xe0000000  0xf0000000  0x01  0x07 RWX WB
       0xf0000000  0xf0000000  0x01  0x03 RWX Bypass

> by using the monitor console instead. Rename the dump_mmu()
> functions to avoid name clash on single binary.

--=20
Thanks.
-- Max


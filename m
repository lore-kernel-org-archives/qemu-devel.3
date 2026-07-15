Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B52C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk27d-0005UV-Fb; Wed, 15 Jul 2026 12:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wk27a-0005TV-95
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:06:07 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wk27Y-0007A6-MX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:06:05 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-81e69a2db34so99198217b3.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131563; cv=none;
 d=google.com; s=arc-20260327;
 b=L55y1BEw2Rs6ly7rcxYnfwjyTTWDbvh/NluqIWOTr3EjLWmU2MpeFlkqARSUpWnv6f
 HmXUyfR0JS6QB2P/4I4EaAYMLg8oUc9lnWdOYBmGoIXf1SJWPw0qw39aRxOh97fbApcH
 wI5zm7ndlfnCuvySkRfeGp2foH+/3R2Zqh9U3ty94s3QntlaZwOap9W2r20YuoRCXtgi
 siQDxkShN3uA4/hDsN2TqT5gQ/D6iKSrqxLv/DUhlqqGmrQElsECVbk9i6xiQez2Wjvr
 UeYYisPAFn40NxLM+Lb5+tqATqw3yYQ10pA+tzOKAcHiBZ56PlPH3FXgdgR1ZqmMPIy6
 u4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nkPp9ijnzlD4t2O5YSt12zAqO2Ov7v9x04GiYityM4s=;
 fh=Km0gBqDosFtAChIZQuE8/t4hQeiDe8l9e9R6S9Q/us0=;
 b=I5pTaBoxKryg9H3De0vi1dy58Ayb+fIdyx+D8YDaMK8the1qQBo4K8J+oXK6Gidg5u
 1hUxdOSfj80yloCEOf8nOw+WU4MJuRWfJns/BntsYD+vgilV9z5Rigf4hygYdOL+ghE9
 j9H8ZZWeNcfGV+lrFxDWiuXU7sBq+7LxvQ5YooXdhROomMkyTC2NYj9nZ9/011Xm7RF3
 mZYelgGfFrMmjh2AziIYCKN6tBuiYLy6LHaOAZhNdbZpJCJeBmWoGcgJPQ1YDMqZlsOV
 7g8PlAB5oqLM8dKGICmSUGwOYPd32cpr2pBwdW2VyCslpHUO4hnNNEZ8qXIRKPaTs3BM
 YloA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784131563; x=1784736363; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nkPp9ijnzlD4t2O5YSt12zAqO2Ov7v9x04GiYityM4s=;
 b=GeAacn8o0RS4UVNwulKnAhY7iRxHPbH3dDoNPEI9sJmH3nj11KkWHbbLvGWApL2rho
 viII7QzT2bPH+F89uAlu0/uqsiaM8M9I4baV2KjjnxYeKLimpCSbmeScU3PtqRz9vUR7
 Xc+uMyFXNSSYQpipF5NQTgI4Biev+8rx2zHpSEAtzODSGhmJ0JrleelDjaQtNp0bp9Z3
 v7gMRevOLV0DTjzBJsDjlJBgYbJuAIZ1NxILU51wKd+CM/o1pcNsZyztaeDqWlhWnUbX
 AcK3EIEmwbxUc/BfuEBsxVyozZ6IeWbCtCgSNlDJ9nLtYpq+xijS2pAPtptwLaUPtuiT
 toJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131563; x=1784736363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nkPp9ijnzlD4t2O5YSt12zAqO2Ov7v9x04GiYityM4s=;
 b=aP6fnJRzs/RCr3H2Uu3H7o+Ssd2ZDGsEbQeyZaIstgfG0w+fHyIQdG/HPeS4T0JEGU
 rIpaAft2F7T46FNZ9iMhFR/qQ/yvxvJsoUJFun8feQEUI9LRQFOCbNxTF0OdvxSQ9utM
 uCN3hMr2AuMp2Hgsuns6x1TTqq6iFm1bl/Fiwg+FdYOEvMpefwTyfu5ULT/OL/pb/urR
 tJMgXTM1UhfC4R7zAJ2epTgsbrom6NgwqdaVnC/oG0AIZTrzMw/Osis1t9WZPzGTz+mw
 B1E3hmCy6HAbA4ORFvfLMsrV8K9px47NLdvH4p1cd2H38hivUudpngwMFw7BreIsMasJ
 BCpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5/SbGhl5h3NzUIk70yIfZjYJSnelrCWpX7z+iQRkw7Och68mkPZrDZh/jzGnuphHyTEOXbXRWCSy/@nongnu.org
X-Gm-Message-State: AOJu0YzySRfVZYBp42Cp2Vs6LcDdmf9EcEnlwb1L65HDfBYViIUg8pts
 Rhf+YlNfmrWKsuJc/UE6ZdSmFr/0NRWOg7n9oWcIp4lccM5hcWoI6r6/5tMy5cHnpzLNaulybW/
 1OvKQTW30kUI3TJ2M5NrfMJHrSUXH2cJnqZhlZA45Fg==
X-Gm-Gg: AfdE7ckdARElHUehwFjTpDvsJrQOOCYtj5ETCdwkwczMPr9Qs5KiQlUXzvLSTV/vQoe
 XVtc95SVCyWbh/vt4uvCHgu+9nZam2lDhsdZRP6G/Y+pWyHFKYLZmHCUjLEEm+ZZO4FM2fNtsht
 AX65mA+T8Ib/KVWynAITht/nIAuiazlTjPLX4aNwOToNB3U4BpjKlqPNgI79ela67SXVUgE4ENX
 MZ6ek+K0IYKO3w6B6FjnHWztNB7OSbJ95oURV0n+Oq0stUiu8/R+neNAAlxyST3K0oHKAI5/Ib/
 1qpulfFGDXk0EA3basrARUBq8fOfowQJx5VRbPyTq0XKPXGVD8AMCxgFV64mh7SVVjiKyVuL5yq
 4Wg==
X-Received: by 2002:a05:690c:a98:b0:80c:8624:8a68 with SMTP id
 00721157ae682-81ecfa136f1mr27480587b3.45.1784131562568; Wed, 15 Jul 2026
 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
 <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
 <CAFEAcA9Smft=r25PJEDiSg6sF-006xLvq56iFWKW+WHWwATUSg@mail.gmail.com>
 <100b70e6-9b5a-4dc7-967c-924a80c09cef@oss.qualcomm.com>
In-Reply-To: <100b70e6-9b5a-4dc7-967c-924a80c09cef@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2026 17:05:49 +0100
X-Gm-Features: AUfX_mzROh0A4UbQXBCszBMQJnhGTcbyFVfcv6WHp0nDgHg6_Paeq_8w3ZeFdUo
Message-ID: <CAFEAcA_zBP+Y-ocE39NYYtKBVTsRB_CL7OGC1OELQhcp1FRzwg@mail.gmail.com>
Subject: Re: [PATCH 3/7] bitops.h: Add find_first_bit32()
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 philmd@oss.qualcomm.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 15 Jul 2026 at 16:30, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/15/26 3:01 AM, Peter Maydell wrote:
> > On Wed, 15 Jul 2026 at 02:18, Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 7/14/2026 8:51 AM, Brian Cain wrote:
> >>> set_bit32()/test_bit32()/etc already let devices operate on
> >>> guest-visible uint32_t register arrays without depending on the
> >>> host's 'unsigned long' size. find_first_bit() has no such
> >>> equivalent, which pushes callers towards casting a uint32_t array
> >>> to 'unsigned long *'.
> >>>
> >>> Add find_first_bit32(), implemented the same way as find_first_bit().
> >>>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >
> >>> +/**
> >>> + * find_first_bit32 - find the first set bit in a memory region
> >>> + * @addr: The address to start the search at
> >>> + * @size: The maximum size to search
> >>> + *
> >>> + * Returns the bit number of the first set bit,
> >>> + * or @size if there is no set bit in the bitmap.
> >>> + */
> >>> +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)
> >>> +{
> >>> +    uint32_t result;
> >>> +
> >>> +    for (result = 0; result < size; result += 32) {
> >>> +        uint32_t tmp = *addr++;
> >>> +        if (tmp) {
> >>> +            result += ctz32(tmp);
> >>> +            return result < size ? result : size;
> >>> +        }
> >>> +    }
> >>> +    /* Not found */
> >>> +    return size;
> >>> +}
> >>
> >> Either we should express size in terms of number of elements, or add an
> >> explicit check if size is not a multiple of 32.
> >
> > I think we should follow the API of the existing find_first_bit()
> > function here, which defines the size in terms of number of bits.
> >
> > Sizes not a multiple of 32 should work fine -- the representation
> > is "bit 0 in LSB of first 32 bit word, working upwards". So e.g.
> > an bitmap of 16 bits has the representation "a single 32 bit word,
> > and the bits are in bits 0..15". The code correctly handles this
> > with the "return result < size ? result : size" logic: even if
> > bit 17 is set, we will return 16 to indicate "no set bit in bitmap".
> > (This also follows the existing find_first_bit() handling.)
> >
>
> What I had in mind with 'add an explicit check', was to make sure we
> don't read the last entry if size is not a multiple of 32.
> In case addr is a buffer, we might read past its last entry.
> But maybe it's not a concern.

I think if we didn't need to check it for the existing find_first_bit()
we aren't likely to need to check it here. If the caller has taken
something that's not actually an array of uint32_t and passed it
to this function then the code at the callsite probably looks suspicious
enough to be caught in code review.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC254C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfK3L-0002Yi-Lt; Tue, 04 Feb 2025 09:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfK3J-0002Y2-Lj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:37:25 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfK3H-0001p0-TO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:37:25 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f6ae4846c7so35155087b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738679843; x=1739284643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xStaCCUZvvadRvtt4KgqZgtZxDLVmqWt85RHs9AVyn0=;
 b=z01XCcQ11xhNfWLpefunV0JD2Z2B+Tunil1ag8XEOOd0n1yYbuYh10nCflT8E3xacm
 aMtCwbGAYEmD/jX5T6QQN1J9/0Zcl76gQ4xC6Xfj45RmD3OhdnIgxM70wO6knQQbh4TA
 cnKcDflKje/4RTilTn1WGSiRKqsOeTbQH7MX/UNxqQjFXgNCLGT3UIwEVtY5O8ndSYoo
 4VRpGmo1GAZ+k+9SC2WM30YqmHT+KE1wb7ZfJMDZYLBl+GLIypq6ec07Dmfgl3zkQI+C
 7OJRVnsRqZ9jgozrrUv5Ikq69eqT6/r1WUgi/VgxU82K2SpwReXppZsg2qkxbC0EvRqV
 qk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679843; x=1739284643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xStaCCUZvvadRvtt4KgqZgtZxDLVmqWt85RHs9AVyn0=;
 b=ajZm5LLsCvlvJC53dm2hTXsPr+pJ3vpvxu01BZxhIYqdfk33EfJQ13Nkx4JwRp6rav
 XEgdJxPtDNQMIy7ni46JNF0daznuMJUH9suJBH8YXN2vh6KIFpVceCaDli69ly60tqsw
 ZyiGGenr8XGPcTY3iAzVJHjuOtPmlKSJ/XAqSBE1qHzwNqKieast7bNwXkbb2qXM72XB
 Zmv/HDA10kd2LzLw2P94L2h+ehqPoD4Ky/XcQqppv0Gyz7ZA5CDP9grhH4/tVlq4zlej
 9AypeSOUR/2aX6ZQ92W2PkBt4eHerBETluvqbqxAJcvk6qUDJbaYL5nvLrJBGi+nWsyM
 eMcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGiAttOpawtPKv1PG5epRNREaH33tKL9J+Mme6MrTe+b9QzZpKzE93UFVOOOT5rnW3w6CpIjppGjga@nongnu.org
X-Gm-Message-State: AOJu0YyMsX47zr6wZXUEBfrbmq4jIewQGHrGcVBKaI/F0hA2hcXEvyEx
 aMn51kDps2LyIHRkexfMV1t5qRPppAuzdGbnGimmRE4R9Xr8XWzYjRw56L/2xQwG53OoYqAjwnK
 ZT6hG5eMZHDcJxyuM22gXzVm0RzdMpKCdLFLgnw==
X-Gm-Gg: ASbGncsz28s7bnMeWzgJkw50sNaNHFeXGzCGbGugrtrHAoP3WBP83qzhRz/qhQY6mvE
 vziZIi9NylebEZ8whwq1ZFe+n9wVSPL7uYSXbqLUtCMHYeXcOn0ox4ZkAouRg8DP2a1M7zYSD/g
 ==
X-Google-Smtp-Source: AGHT+IFIz3zp3/SeKr+qbl/436m3TWFmeaKAarcKbOwz1BZPve/D2lfcPbw+lRc4j4aoSiRpoAuvgE6S03TuhfLh974=
X-Received: by 2002:a05:690c:6d07:b0:6ef:7d1e:bffd with SMTP id
 00721157ae682-6f7a8424acbmr220356367b3.37.1738679842769; Tue, 04 Feb 2025
 06:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
 <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
 <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
In-Reply-To: <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 14:37:11 +0000
X-Gm-Features: AWEUYZmAzwjxcadMUURkTX997SIG-NIF8iCLXYs9UFr5Zjq8L2ymYEyJvDXIWxM
Message-ID: <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 30 Jan 2025 at 22:31, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> On Mon, Jan 27, 2025 at 8:40=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>> On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan <andrew.yuan@jaguarmicro.com> =
wrote:
>> > -            rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
>> > -            mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VAL=
UE);
>> > -            compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPA=
RE_VALUE);
>> > +            disable_mask =3D
>> > +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK)=
;
>> > +            if (disable_mask) {
>> > +                /*
>> > +                 * If disable_mask is set,
>> > +                 * mask_value is used as an additional 2 byte Compare=
 Value.
>> > +                 * To simple, set mask =3D 0xFFFFFFFF, if disable_mas=
k is set.
>> > +                 */
>> > +                rx_cmp =3D ldl_le_p(rxbuf_ptr + offset);
>> > +                mask =3D 0xFFFFFFFF;
>> > +                compare =3D cr0;
>> > +            } else {
>> > +                rx_cmp =3D lduw_le_p(rxbuf_ptr + offset);
>>
>> Is the change in behaviour in the !disable_mask codepath here
>> intentional? Previously we use one byte from rxbuf_ptr[offset],
>> duplicated into both halves of rx_cmp; now we will load two
>> different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].
>>
>> If this is intended, we should say so in the commit message.
>>
>
> I agree that it should be mentioned (looks like a correct bugfix).

Thanks. I've expanded the commit message:

    hw/net/cadence_gem:  Fix the mask/compare/disable-mask logic

    Our current handling of the mask/compare logic in the Cadence
    GEM ethernet device is wrong:
     (1) we load the same byte twice from rx_buf when
         creating the compare value
     (2) we ignore the DISABLE_MASK flag

    The "Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev:
    R1p12 - Doc Rev: 1.3 User Guide" states that if the DISABLE_MASK bit
    in type2_compare_x_word_1 is set, the mask_value field in
    type2_compare_x_word_0 is used as an additional 2 byte Compare Value.

    Correct these bugs:
     * in the !disable_mask codepath, use lduw_le_p() so we
       correctly load a 16-bit value for comparison
     * in the disable_mask codepath, we load a full 4-byte value
       from rx_buf for the comparison, set the compare value to
       the whole of the cr0 register (i.e. the concatenation of
       the mask and compare fields), and set mask to 0xffffffff
       to force a 32-bit comparison

and also tweaked the comment a bit:

+                /*
+                 * If disable_mask is set, mask_value is used as an
+                 * additional 2 byte Compare Value; that is equivalent
+                 * to using the whole cr0 register as the comparison value=
.
+                 * Load 32 bits of data from rx_buf, and set mask to
+                 * all-ones so we compare all 32 bits.
+                 */

and applied this to target-arm.next.

> Other than that this patch looks good to me!

Can I call that a Reviewed-by (with the above changes)?

thanks
-- PMM


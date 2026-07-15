Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B211EC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwQr-0006dx-Bi; Wed, 15 Jul 2026 06:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjwQk-0006dc-Dp
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:01:31 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjwQi-0004uD-T6
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:01:30 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ecf499af9so8665047b3.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 03:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784109687; cv=none;
 d=google.com; s=arc-20260327;
 b=G/Fg48HjjZ8RM+4R1xbBNlamn1uKBxOO9PuWG6b5k38xCO6azcDH0wJF6hFIqEnW8t
 oRrnCDwhewiucTB17bAKu9oIhcwKpvu4+Hh13qlL59XdeoHKF63GtQr/lRQh6ZBw6Qg5
 UJD4auHxFVZxXa4uV8bFBnXt3aQNPoMQYYfV7Rc5hOKsfo2stk4tqWCKBX18MHp2h8Hp
 ZRXf4PnpZIBPpj86Zz+Max5otv3l/FZjwsVfNVINz25vAhlUcxtyOa3L7Mhi6m8XXwXJ
 0TaseLSvpjTJYfBq/3Xb898FNWV0LvbjYT0sP+MbC9cmxBqfBd8qk2jc4GXHSTBbahcy
 1rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f0bGynfKw827dVUyNapCWNiAsW15+3NsHomT7UqeaH8=;
 fh=2CuaD9y8XJmA5tMV9AjWWMYHrnMSsUtSULxZHRCmiUs=;
 b=jYYaZnyHxvWX8TPC+i6DxeSyhY/p2hVzUcROIGFesEFqsjh32mM0Hoo19GE9GgLzt1
 AI0whWKtMDFs1x0eNgsPmAZFftQmYU8Fq6L14Dq20BQksDHV5u1j8q0ezyYw8dctQSC4
 AgZUztu5sdtWsTAed/Ue3OWo+IETyEW2/UoBcjPESgV2pWmTmh5I2P4p0dpIlg4Roo8L
 QdxTNBW/SvI+eY7SC2uSUXuXP6YcwShKDHfAyjtK8pQePGWHmKnn9JQ7Tf9QsZx+uApn
 NWzyumqgqElHK2sy24SqvagtEQBcFYhTSdCo5IrCKUW1dzPc5HXLZRYadueHwtNnuxob
 tKlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784109687; x=1784714487; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f0bGynfKw827dVUyNapCWNiAsW15+3NsHomT7UqeaH8=;
 b=ZnrvjoKNdnr2KT7m0XMaByaTVXpUBxKNqw6KPHxZt+2EZtCijayjhgtqKCAzaPoLR5
 9eSV0n02XWrAKnO+2K8PfVbBRV7/IDfgQutc1WLAO66KPwB6RIrGOw6g7gWJtZvj40K2
 zpIYVWgrHLC8E4jyS9uM31LeMHqyGiZa5sLbZpMq5OtsS1ZCrcz2VB72QhtICQvQlCFU
 Ftv6LJfMRiE1/qTIWJQpUhZ/FHSoLEQbFGK8RmPcFNwWaPcplCFcNzmra+h1w4m7zUIV
 /t3FW2UBKBuWMnbz7f2kmHXsy73X6F51LaFMNw2U+CMtw2Kdw7ZQQXbwdfSbRbyOShwa
 REwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784109687; x=1784714487;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f0bGynfKw827dVUyNapCWNiAsW15+3NsHomT7UqeaH8=;
 b=RELYmoY7mMiZEPYXWHHBomQ2novm3WlT+RFYBvp9xSEcohkqz+1l4pLOcR565Guraq
 knPFvpSAO9ZKnmodr3rvt2kYUcoEKNSMTu3l9q+OP6720jCqlh0l2g42tFiSe83pY5r2
 FekusIRiYsak3dvT2vr4fZXUmp68lqjTTolYUMXEE+dh9pIJC5X7eNkibpvcYTElsgzb
 f4Bv29mt422sFQNZiivEShXAlcm85XfKydqYZe8qfryAt4wJmMokYJV9qUX2JEiEsPIL
 tixiDP5OitdqMADnjT/y2/lsonZ2IP0uuCNnW6gNLzZ7b+hWIbZfrnATUrhGJmtmeK3O
 cUYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpvb9ffMtVLJYZU9MbP+Mw8cEI3ppTJpOpq2zLp1OmAYaq63tIcGQZkPELu23AqgOvDZxQl48+pN9Fd@nongnu.org
X-Gm-Message-State: AOJu0Yxamqe6+SZocKDBoZv8oDtODBhp4qWetEwsDxgbjt3uKYGK9War
 nNv0gzDgFcwt2TnWqAljuexLSSiVGLKxlj6K4Tk7X3vBvkhVPRr5D0NcqbqeLeNUBi8vYwpBaOl
 I80ccO/emioFbT8ZSug7a5T5iJPS61Z4eDYKL0+Zhug==
X-Gm-Gg: AfdE7cn4vyCXHZ55ORZr47u+Y2A87XRJqBj4jfWfe9ljA7LEcxfLJjQ+EfjLmmzuwVO
 xvlmtAn9/EQvI/cghCn52F5WCgF3CIK5f6f4vj9Q5EMxGQeRyKjzfIxmVmeFCrjqXr5sXnlnyyo
 gdOzXWD8L9b9P24SbkzKw16x+pE/QWiRalx3Iioi4OUbm3yoE6b3d40UIMCdKclu2H2KOriWcOu
 e8RmsZW8SC7KjlsVZ/gjN6nEeeoa9190MXrFBYyLl0impeSFCqOEajQEktK0Rj66lDjv7O8IR37
 wSVthxyveaI+gkXY4Odet6GEV7MCl9l1OIFdBNcar1m8+HYxkERidVNA+GZjrhOHWZE=
X-Received: by 2002:a05:690c:886:b0:81e:7d90:5673 with SMTP id
 00721157ae682-81ecf876688mr15761177b3.26.1784109687361; Wed, 15 Jul 2026
 03:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
 <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
In-Reply-To: <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2026 11:01:15 +0100
X-Gm-Features: AUfX_mwQ4o8X_MMmo9AzZE0wqshODpWjwyJbimbJzekfQaxRHJgu5HV599wqwTE
Message-ID: <CAFEAcA9Smft=r25PJEDiSg6sF-006xLvq56iFWKW+WHWwATUSg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 15 Jul 2026 at 02:18, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/14/2026 8:51 AM, Brian Cain wrote:
> > set_bit32()/test_bit32()/etc already let devices operate on
> > guest-visible uint32_t register arrays without depending on the
> > host's 'unsigned long' size. find_first_bit() has no such
> > equivalent, which pushes callers towards casting a uint32_t array
> > to 'unsigned long *'.
> >
> > Add find_first_bit32(), implemented the same way as find_first_bit().
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

> > +/**
> > + * find_first_bit32 - find the first set bit in a memory region
> > + * @addr: The address to start the search at
> > + * @size: The maximum size to search
> > + *
> > + * Returns the bit number of the first set bit,
> > + * or @size if there is no set bit in the bitmap.
> > + */
> > +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)
> > +{
> > +    uint32_t result;
> > +
> > +    for (result = 0; result < size; result += 32) {
> > +        uint32_t tmp = *addr++;
> > +        if (tmp) {
> > +            result += ctz32(tmp);
> > +            return result < size ? result : size;
> > +        }
> > +    }
> > +    /* Not found */
> > +    return size;
> > +}
>
> Either we should express size in terms of number of elements, or add an
> explicit check if size is not a multiple of 32.

I think we should follow the API of the existing find_first_bit()
function here, which defines the size in terms of number of bits.

Sizes not a multiple of 32 should work fine -- the representation
is "bit 0 in LSB of first 32 bit word, working upwards". So e.g.
an bitmap of 16 bits has the representation "a single 32 bit word,
and the bits are in bits 0..15". The code correctly handles this
with the "return result < size ? result : size" logic: even if
bit 17 is set, we will return 16 to indicate "no set bit in bitmap".
(This also follows the existing find_first_bit() handling.)

thanks
-- PMM


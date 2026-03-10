Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65171FD2D8C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxIy-0005OP-Jj; Tue, 10 Mar 2026 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxIu-0005Nx-JB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:39:20 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxIs-0002Of-TE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:39:20 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7985ce90542so123769997b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149956; cv=none;
 d=google.com; s=arc-20240605;
 b=ewiCWdLjBm/LO8pWHEjvRS8NdKel6SeodLVSVNoGdn4fUKBCUCMAOMPFMvy5tS90CH
 oa/y5dxYiz/U2u7BXqiBln8GLqDWklXS2zUYM8fSRFeUQohBDfpcwvNPBoSYc8OpVF58
 UCJukxtlgqM8dpxN2fXQrvGPamcPUnrfLkO3OZu3YmH4MeCWo2RbWy/nA9YqbwofOh+Q
 nrxrtPntr7tv00iGbP/BTpPKIFvFF8gtVCAuRIKeB9IAwFrUbuTjZKq+L9F30lBYY49d
 s7k8XwRVo1Hj3NIoyTvkF3rKXAbMtMEtEumj3GCKj6EXINVWkjx/aGVwFWOy1B6lT/m1
 4JPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p5lV6EuqjypXYs9Z9Ein2TjgH/1LXagOUOIKeet5nsI=;
 fh=xKwl9K2m1OAGKzgEopBlfGRiY615eS4aU4gx57cpZPE=;
 b=KMTY1/rKYhz8rIwnhDKp4nRlRp3ZjtqIR4qXpv3o1hyfsf2qyJ1VXjIyjEvingiG1v
 ozuh9lh8pgL2lFe1kE7I0SQlNYEhFU9fVGrB9sa2UBQWTgY/nKMS+4vL6IpVyth7najb
 AXqF5Nu3gbCeXwcQmKLuRmfpCuIgHJJmPyxGGZ8Gq6WZaWG5Sx6jLDfSvRpr+TNmDr7U
 q94P5lhUaNM2/NDNM/wiOV1B1mAkzVb5KU766mDirKjG0w8Rl5k8c23pjscN4gaALJop
 nPoGu98GgQYgzdd6uWWzHvHoQDAfoxx3e+AFG+vEHAyyjGgl5fgcNzTRrIMYtlDawAoX
 MvYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773149956; x=1773754756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5lV6EuqjypXYs9Z9Ein2TjgH/1LXagOUOIKeet5nsI=;
 b=lV9yxnCWivUbXzj8C7UReceQOYFXh/jKlh8D+W8K5gLcWhEYyx7shKb1y7kN9eSf+x
 Zz9CJ4a8ep/3RCk3Ge6+WnSMFY6/3OGsPBB/6ve7zPI34asANuZwl/UvixBq+gwdnL55
 l3xFBuk2udxUhnRhGjRhJ8t5k6wBIGPg1mB3o8j6zq5arIre7V5En/WNqqz0/sGKJGqn
 sy8x4C2kPOj8MNaNr1rgfcKym1vmJ8YDU0yiqsn76L5TllqDHx1VvYwAqx1JjQf4TG49
 PnhdpVAf1tyxpq63UsAVt/2x5XH3CLEm9DQnpiSu30XIfM51gfzZ6EdaghiehYNt4OT1
 D7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773149956; x=1773754756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5lV6EuqjypXYs9Z9Ein2TjgH/1LXagOUOIKeet5nsI=;
 b=q22pqIpjmlQl+KDKaBjWcnc2vdvNdEg2nVPTZ0p3gK4/NsQUaTCHbBrM4K+hb4uMzR
 mIGb7Ecvwim/7nB7UgXf00zLVHzjcthMB0vmQ/8SGqj0pk4mVGPxxG6cnhgp5DLMWD/E
 2vccMo9sr8xfH9NeGCwpAnl2gw9Qt/eoAgf/2gGmPEHU9ut59JtgUj3YYIFGDczm+tLb
 sLxNvwIA9m/f3Pl7nMx/B7L1HsC+UrfqhNb3WfOCA0L9+ssLN1/qTRMSyqa22QjszrBp
 d14wXCkQQTaA/7QU3IKBy3PCuq/XbAZpp6d51GfI4VIPtS5k8QfnA4EPLZTokXPRSI3R
 WkeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8zrNgkVxz5UIB2vCwxHULHBSpezNRddvbAc10D5bTH0R6Uee4Q0ytyjMJGVY9x3RUhxRvVFmNfwTE@nongnu.org
X-Gm-Message-State: AOJu0YxwpEUSneZBKhzP6/y3DqTVsgxNK1ZZPBZy/JIPEJIPUNrjSqsH
 bZ1kcXmK8IkEXW00xQJIzarzx/bVVj21UHdaxolaFCCeq8TW0x+v6+y4Nhy62qRgteBDphCzcWb
 ZBIq3QWInA48hhLumGf9c/BU3lJcTsFV9SpKFs9rvQw==
X-Gm-Gg: ATEYQzxnQPY5DJotsyv/DipCPDofi3+EpfrVsPNioySbZ2nAY3Pa8UK08ujS+cnL3SE
 ep2bg1yi1rc1rT19MI238etoJEosJNaUgl0SnFL81kSUx9xmGDi0GscW0ZdYeg+1MnqpqDiczmr
 KYqJK5e+L0olxLkidjjNkVO3WisZfKzjK109GwG8lxIM8MiZgG67bvs5GtpI/yg4VWYtWro7YYJ
 Hn8CVrCXJCb0Qn23VHUty6iCtEyzlFhnOJXFof2YKnA/S2lRlTr5+YIRYmnNyHc1PWOtle3mTpC
 GSI2gTHkqCYZZfzyltCmpn2IP8HrBnJrRPjpcyTd5bPhj5cbipdB2z6jDC75u8oiOI4=
X-Received: by 2002:a05:690e:16d5:b0:64a:d45b:a4c4 with SMTP id
 956f58d0204a3-64d140aa312mr10215796d50.3.1773149955840; Tue, 10 Mar 2026
 06:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de> <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
In-Reply-To: <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 13:39:04 +0000
X-Gm-Features: AaiRm53KQaQ6qVH_sZdmiYhiUwcTJEyBVjc_pbskfTPWG4GJqPXt1ELf0ypQCLk
Message-ID: <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 10 Mar 2026 at 13:28, Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
> Hi, this breaks migration for s390x and ppc64:
>
> qemu-system-s390x: Missing section footer for qemu-s390-flic
>
> Thanks for reply! It happens because "qemu-s390-flic" vmsd has "qemu-s390=
-flic-full" subsection. I'm not sure if we can change the names of the exis=
ting subsections. Peter, what do you think?
>
> It seems to be a bigger problem that the migration framework does not doc=
ument the names for subsections in any way. At the same time, the code impl=
ies that at least the names should be a substring with its parent. There is=
 even such a code comment `subsection name has to be "section_name/a"`, tha=
t seems to imply the presence of /.
>
> Also I tried to put together a list of devices whose separator in subsect=
ions is not /:

> or-irq

This one and probably some of the others are my mistake, I think.
I think this is because:
 * the migration code imposes a constraint on the subsection names
 * the migration documentation does not mention this constraint
 * the migration code does not effectively enforce this constraint
   (e.g. by asserting when the vmstate with a bad name is registered)

My assumption when writing that code was very likely that the
name of the subsection didn't have to have any relation to
the name of its parent subsection (after all, the migration
code knows it is a subsection, so if it needed to have the
name on the wire be "parentname/subsectionname" it could construct
that itself), and since it all just worked I never noticed the
mistake...

-- PMM


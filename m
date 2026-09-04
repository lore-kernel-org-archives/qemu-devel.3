Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC6BC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RAL-0005Rh-Qh; Fri, 04 Sep 2026 06:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2RAB-0005Q4-I2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:28:51 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2RAA-0001u3-4i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:28:51 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-855a66e5b5dso7791637b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788517729; cv=none;
 d=google.com; s=arc-20260327;
 b=aHDEU7Ca6N40esVQQUqw3n2bamwko1gqUY28YhhhNpTM1O1BVUWMKUc284zQJksZvS
 sFD5+uX5vxhwXhjGyWiO7NQgAmZPXwr3ZR96rs1685jwHQY99q5InGdE3FAcELlQe+wi
 QgrLcEWbQhM31398W5XPrZQo6RPPfvsUcxhIpYud6KQkcdApUX3Ryurx0AGV5QST+QFV
 qHr+V0ckxaeUqe8RhAYhRnvf07KcKtmBQpM8XKzQI5EFS8sxqMVH8srXAMWAEtMfy/cV
 DiuQBXOUR3nDtZCqn7zngwjwITwnLB+9yjIHKKSmeEYvZz78iwJ7j8VKsrnsZj/MZmow
 e4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NpbUMnUwHgVozA/7FwKC6hv4uFWsxS+jujSUd5/ud9g=;
 fh=aTqjkwj0CQ9050Igk69SAAf7i9joJ0+Rrt0D+w+wld0=;
 b=Er22ldve3neWtoRBIBN67kfxZbKDdsJ5RxTkqFSoI+lsiqTfRzx4H4f9C67JFF0s0g
 SCjq1Qs500XAFrMihgeNmkkrYFyaVnOIDgRdWReGAHbc2EzSubswLmjbpF3nHJoIFVoh
 RPeFHF97TTZZ+/v2Q8z9MdSaRMaOrH6dU6XGM1QPFgD2YS6TAWaQ1gwRBn5hkNPGpNQV
 rFvzrfmxrIHLCHHoCDYN7Lw4XyaojXXkZ/GP1XemAuNddUoPP+q5LuNPQg4hDzTp8bS1
 8opgRK3raq5YgU1I9YbFUiVLxfWtYFCAL6mgQcwd8yIZORBX7XFZ1ckLKP/JqX50KXs5
 hlnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788517729; x=1789122529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NpbUMnUwHgVozA/7FwKC6hv4uFWsxS+jujSUd5/ud9g=;
 b=dKdmXvFw3/YVOf8KQXPgkdEuuIssqjBZ2ESOU8S38xDcrVhtMbJVLK1bgksJUslpi9
 +JiW6pRnZO+7Fa9WtpsCRJrI5K+mdO1QXHwhs7TK+lFDz9dbzSxgyq17tRA3tL9EI6Y6
 s0gQbBrnezImeESkivBHJg60xtolkSpzZt4i3iAn9bpXELC/rounrj7SKe+GtX06pFLp
 mEjDu399NHoDMYJr9CVEAhYfesV3xZbWt87sdE+ZYbjV4oJWzHPJ+eS2BzNbDtKt5rDJ
 CiwJ58ZhjUQldrfkCD40Kvtgf1imcmK0mMOrj+ej8ndlgV+I4WOPb3b30MasqfaaF7Ou
 CUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517729; x=1789122529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NpbUMnUwHgVozA/7FwKC6hv4uFWsxS+jujSUd5/ud9g=;
 b=GQVZYIslLdix1xvUMVPEF147EzjeGzUUsloOwx2Afyyu2Q5scEikqykFijaujSqYYO
 aL0K2M+eK/Ss+AzPNnmICXoGs6tYI/UrydkMLWSeR0j0iREsykXpujiBulP7zhTSWpZp
 QsvAifwVoEjazxIF25di6gBIIjlDDz6tCvg1dkweyQlL/qbq1nf4iFpFn0sUbbYKdC81
 ZI0paFgpK6djk07n+XT/VqXLoDIhaXOUghxHJvhkTzYpKAvvA05M/nBbfw+Ad+FSPGTb
 8II33uWZ1iT2YT4vB3mYk94S5+AII3gq4ry9dAtC/NhWymI2CpcTJd3ZMxjltAplRbg/
 7KOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6Y7PYd8s2XtKFFcLYcv1hI6ye55YbsIl5E2v9BEKyRf0BahOrnltKBCgf2FnA7Bdq30CrBwcZcCER@nongnu.org
X-Gm-Message-State: AFuF++mAdnadWmvFptGuTKlj9TzJ0968FZgu7FGK5CcfvJbjr3NZt1U1
 7UU/7HSxfpxyhiOtw9ULzUWjPgHbp8/Cfvni5GKsVodYxb9r9wcefuog14Owt27HMxgqx0K2dMC
 hQ6Cnrevi041SHWrCit3fVy6kpDKEL00py2yorxdRtw==
X-Gm-Gg: AYBFou1JOv+5r0Nns00Rhi4Cdryjl9L/bM5Gf4sBsJpsGtpTUJi3NoV6LeBtCbKHkhR
 tcBNvk/n/c6CA50mwh2PyIYiwNB0Fih4MXrkSz/NUvH9jV0MgFjzr0jVcqITh94p8Nasa3JA+cR
 2HLPhYqk8aQ6G9UCwb2JO9mAttgwj/zz4l3cHJQXa89lU/TrVNTaz4fAngBJ3Oa0E7QePuJ77Fa
 bR+jdaTHe2upW6locdLcsUERvWuZLLvR2Y3Z0nb4zi5zOoqgmGqnZZ9rWE0EkPIZCLKX8QPcDWU
 YTonBkBWZYD7xPbBZ+TkgXOKQxilmO64L6tB/+9Q2RJjmjHjWsrQAvoNwT9Oa1G+o1ymfYEtoRO
 2q2h9k3PvLiOpu7k1bRTasJVSeivFFxa28QIHSlo=
X-Received: by 2002:a05:690c:a694:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-8712a70a30cmr20874697b3.26.1788517728626; Fri, 04 Sep 2026
 03:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
 <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
 <apqcmqpJEEyc7wGx@redhat.com>
In-Reply-To: <apqcmqpJEEyc7wGx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 11:28:35 +0100
X-Gm-Features: AcwNN1W9qk7UPSTgEUrQUtXxxxKm9hfqcwaYXW1xfcUSyLy6sGj0JEn2tqpuhm4
Message-ID: <CAFEAcA-s+zsChqxYa258GOXdjniusdYeOCzGd6OiHWBQZV1Syg@mail.gmail.com>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, 
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Yonggang Luo <luoyonggang@gmail.com>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 4 Sept 2026 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> We need to use QAPI MachineInfo / MachineClass to report to mgmt apps
> whether a machine is capable of using hardware acceleration or not in
> response to "query-machines".
>
> Currently if a target supports HW accel, then apps assume that all
> machines in that target can use acceleration. This was a convenient
> short cut assumption, but this new machine suggests we can no make
> do with that assumption, and need to explicitly report it per-machine.

That assumption has never been true for Arm; this new machine
type is no different to any of our existing boards in that regard.
Support for KVM etc is only present for the 'virt' machine type and
one or two others. Most of the rest don't work with KVM because they
create a specific CPU type (not 'host' or 'max') and that won't work
with KVM, or (as with sbsa-ref) because they want EL3 support and
KVM doesn't provide that.

I suspect it's probably not a valid assumption for non-x86
architectures more generally.

thanks
-- PMM


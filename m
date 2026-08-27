Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD99C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVhv-00037a-Cd; Thu, 27 Aug 2026 04:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzVhq-0002yI-JO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:30 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzVho-0006uP-55
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:30 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-85aeb506b78so10498537b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787820206; cv=none;
 d=google.com; s=arc-20260327;
 b=HtpYw8poigaQtfvG5/UjKlmAmdv/Yt+FwKVWzTX1A9y3tb91oM+7b3vhtUAiogmItC
 8/C/N1xmMWLCKfkj0LyeX9+xLPZuhUVlsKKEqmoYXUsZjIPdQB5Vv5qGpT40kUHyE9YV
 qojtzyNAKnCj7rnqNE71UtbojcJeBWcBvQwc++GpxoE1qVBALgjfevs5/BRcqxgBIJmi
 mi0V6VKiU2oU3zVMYpqh7aGhzUHimvsOqiHx5y5lUnSfj+LzhNCyH4i3titlRClcpxke
 r9P78+RWZYx3WLsoSt17zLd4Si2CkKw9wdP7pSZKEhQk5sHAttnmCAVaje+Zp5Z/GFIM
 Mo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fmTjhSvtnJsTs9f2WlIUngWxh9jpt5Q0EV8XjjrlYbE=;
 fh=x5uaiVwBynaxhnfRw+nP+0Z5PaOsOVZmSjCVjCPlgmQ=;
 b=Tubg+zl/vpdHZL5xt7sDBVFscAq515CEv97I8kgTNiseY+DNML0SZ8RiBwZpdmLVP6
 7iCqGtC7+IfRMaf/ZGEg010E028yu+2CorQYxTzzj0CAy+StEMa0e5YtLZrQUAkbQ2Of
 qbKd7emaOxgU6hKJXe2nlkJzvHy7oGqowhWzmebStynY1Ow+jodLxVJACVuff/kR0m26
 lV2rKTQ2R8H327/WEWkTMrxJi0ioykj17VQe9fk/j+ntpTIosP1cIdX89oyKp/SxzLTc
 sBF9jSaXpXOrsWp3yiK5p/zxrOnSKFgvPG9vEVJorm4YZG1kVfMHsZ82Gyb/zGh1Azti
 k/Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787820206; x=1788425006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fmTjhSvtnJsTs9f2WlIUngWxh9jpt5Q0EV8XjjrlYbE=;
 b=JDALbyH/7b2B8m5MU68vZwCKhPeGMG4iUwWeCwIrOjO2cO63UWvnXCDSORwd1S2y9s
 1HP7Rzf9Bbqwpkykiad6HtEhI015V36Ri0USQXsEW9vtnqdcNnxJWxWVPbuvqG4tzP45
 9mZVtAM6zZxBWDJ3TxZLcblwpCmEXrkWEmnukmopp2xR5OZAtNswavQUz4ufjl6uKsxN
 Qk8VF/ywU5hkVLRBNW2NrLZgGDkKf9R6blAaVe2Yq0LYkpOYRoJIF9KwKC9ua4Ucg+sf
 6cr1FtO8YJaAHykg70ItS5mwBvcRxWpQFIZfKYe07MKS/3LcxxDVsrcpcV3rHtoliEpN
 UxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820206; x=1788425006;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fmTjhSvtnJsTs9f2WlIUngWxh9jpt5Q0EV8XjjrlYbE=;
 b=L7n1Nbi9diWYVhGvlHcdeR2jSo+t3Hj5taJK55IH7mDT5htINrJ45dCc5UWgi+SOeC
 /b8zqyGGIrpv9Hnz+DEbTWrMxj+Dc5xAtx6F9dtlgkK0O/3i8muqZqHfLjvD2NGjSu/W
 dPM6iQhiJRCaqh0XrdMt8+Kv1w4VLnGnvLwty90KqxKy8iV2DMCRS7tm514+E6PCRvtG
 N4c5qwas//rLFKYfN/xQpmE0wuH16DTjatfTp69DJW7hG3Tjx6Jd94xSt5hSOXr8BXvn
 pTcy4M1ar75et5ZmBievER0I3ZkNLJC5DKOytO5IbbY81a5KN6PNKG9DZ0MQoVByjPOt
 4PBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RorKcdhswK2G3KBYK7gqU7hShalGqS0fuYBORCzKtP3Iu4e6PD7Ax2h5z1rPtjtSOVKIje2oa+e6f7c@nongnu.org
X-Gm-Message-State: AFuF++mk8CoEqoeYkqUpn0q3oIOK/HdwyMrP1YRAruFXjodpGSPuy2v8
 70DFUw3p29ReMXa1FBuKLIHudLPM0lUaWeamCE8yxQaxY9pH7Dj4PFPHUxHftrGCj00KLo3vtOY
 aINHM6uC9aRa2olaAj5oY6e/uYIcNHD5JGlr8dP+iZg==
X-Gm-Gg: AR+sD10e2RtbddXH2GeQaQ/AI5sihpP5UbzNbx8a8dZFGP+MUOCR2pOWstMol1cJd78
 ayoaiC6oyZfoflUhKf/wHs4xv9u0pBxkIHrxnueV5/eOz5vobbla2rW2bvZ8tgI8LIKWuv3gy9l
 kw3IfKT7sECKIfGLrzCP9wD1BcEw5dRCxY9PUuZdhvxN+DyzCOLwlcSAwptvdsKOjLF0h1lvnHl
 SBfIarFT5CQi1SJQZiknMd54zmIEjWYc+NuemLWAuhhGvK3iA48EzXoZKlroSKG3Zy6y7eBHls+
 Gx2eva7OFffRqyTTgSE05hH0NtTqC7Od8MR0BKRHWVvD1/SDVDQCaj6zTYH1DIAjrY7SoaO3SzN
 UtYXYjuMA5fKhHH1Xl7PgAvT134zD
X-Received: by 2002:a05:690c:e296:10b0:80c:d342:955c with SMTP id
 00721157ae682-8573c2fdcabmr48193347b3.3.1787820206006; Thu, 27 Aug 2026
 01:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <a665849f-3b20-4ad3-a35b-02259e882628@oss.qualcomm.com>
 <c15422ab-6a58-45b8-8df6-b2f54e0620cf@axiado.com>
In-Reply-To: <c15422ab-6a58-45b8-8df6-b2f54e0620cf@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 09:43:14 +0100
X-Gm-Features: AcwNN1V0V9pI_S7sEMSJ-Wr_3nHSLX4cvEHbr4NU9oGIMUrGy3_hZoalRiqLJS4
Message-ID: <CAFEAcA_2GiDUY36TAEk3OhJfJLLDkQja-A=x9UTFGeHAP86t7g@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Add Axiado SoC AX3005 and EVB
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 163wangjack@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 27 Aug 2026 at 07:39, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Hi
>
> Philippe Mathieu-Daud=C3=A9 =E6=96=BC 2026/8/26 =E4=B8=8B=E5=8D=88 04:18 =
=E5=AF=AB=E9=81=93:
> > Could you add a functional test? See:
> >
> > $ git grep -l obmc tests
> > tests/functional/arm/test_aspeed_anacapa.py
> > tests/functional/arm/test_aspeed_ast2500_sdk.py
> > tests/functional/arm/test_aspeed_ast2500_sdk_515.py
> > tests/functional/arm/test_aspeed_bletchley.py
> > tests/functional/arm/test_aspeed_catalina.py
> > tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> > tests/functional/arm/test_aspeed_palmetto.py
> > tests/functional/arm/test_aspeed_romulus.py
> > tests/functional/arm/test_aspeed_witherspoon.py
> > tests/functional/arm/test_quanta_gsj.py
> >
> Please allow me to add functional test cases in another patch set
> because we did not release firmware package on our Github for
> downloading yet.

Can we get a functional test for the machine model you've
already landed before we add more machines in this family, please?

-- PMM


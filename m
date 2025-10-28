Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F96DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDh3X-0004LY-6x; Tue, 28 Oct 2025 06:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDh3T-0004K9-2n
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:35:55 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDh3M-0004GD-Vi
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:35:53 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63e18577613so5665553d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761647739; x=1762252539; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gizrY68Z+Kofhqi9coAgNzzuoyGmBbdOql3rCG1koVw=;
 b=Ja40MGzATDOltsz91wRWc33Hxb5Qt4uvpnd9oRjQb1iRwmaYfGRkagan/ASaN4gCKf
 6CuHAQjh+GUkYL0dixCw6M5HevY8IWnCbpm8ZQbvnRtZO5czz/miRyTuzp/WTbx6KsgG
 zvFHuWrG73tmMASF5jveQa4a+aqsvvlEw7V1WHUVnmPs7PdAlDOCfZeZE9pemZjMeBm3
 6CHuRp7XeD+XAPO9Yn5CAcRXUaHnBN8MyUWrBWxTpgl9fPMlP4BQ0EpS3xGZTVWV0HxN
 b8PVHdbtaVElgqub2ZJGFSemd6Z+PqMIZejYNTOFBvXHv1l8eo115Ht6MkH9tm3wqdLz
 0UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761647739; x=1762252539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gizrY68Z+Kofhqi9coAgNzzuoyGmBbdOql3rCG1koVw=;
 b=OeFvGwjU7H1bZeANHpJj0pRubn2Yv7oul1ClDZgKNmCdu3xiYOop9gX0sTBPUfU9WY
 N8IFTRCMDPbUUDSmWsMCGrJtUGOyP1jDh9iItR3XH1w+zmiFEG5Vcxl/Xz9s+OTkdz4/
 Cef7DQrfZEXLmjDC3AVXAKIdvPyAdmAVczQ5M/EETFp9RTUy99XZodtA+sCc99cwKlmY
 6n1Kb58yiDBWD4lKj1b3m7Rp8G5I8zmGoKJ6PsTVPadlRS5TY+gWqDOrpcVqMJRp3bS0
 y2joaehAp/wypPpLNs2l+ys4p4D9CX/SQOZXXepLsLCUXV9jS0pUUakRL+i4Qc1ZDlES
 iDVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzN1sTormbZenw2c8So34LsIgm0uSiKBRdqNmPjhkHUBDq7zGwNI2VJS9ojBYsi/tFV6ypvC5oeDQ@nongnu.org
X-Gm-Message-State: AOJu0YzFXpfGbNhagIJUtWiiHAwZivjyaO4L/jj0y9nBSIMmafVD7ui0
 4NVaSLkJ+iBRbO/rKA8/rLk0pQD9gFrP3GT/iZr+of+iYAryW4y07z426toMNOA8Cy93/trnjIO
 Ie6nLr04D8d2GIjKfvDlxhXiqt0tyiBSBAlsqjEsdvw==
X-Gm-Gg: ASbGncscbdVvy8Iwp0qWn6+KAvDTl8HF4WTkZ8ijhgHEC/C8V/rcS93zKaYxbPGW7ec
 FH6ufnrEBlVQIrgXes/ViVUt9GJe7OxG+NZ04GYyiSDmLRfHzSqx/X0brzk4MQjd3Zg/Eu2gb8S
 39t3gXgg9inaA6kGp8yYAa8Zm0GKRB/334hVdKQvNy09fppFYGtuh6bF5H5EKU9UH0amduy2gUW
 3JrnnlCnFzaDqaQleIRYdcAEBvVr7UGybsPuQK7QqAhUI3Tc/+7L4LyLQAq5w==
X-Google-Smtp-Source: AGHT+IFsB+sYbX3RdwChzFpBKhHMxXoRsRSCy8sAPH5z5LLhp9X+iPpfnwjZl6Tgv2oqqa+3lEFzR6wUiswjKxHG/YM=
X-Received: by 2002:a05:690e:1590:10b0:63f:7384:f403 with SMTP id
 956f58d0204a3-63f7384f76dmr217473d50.32.1761647739197; Tue, 28 Oct 2025
 03:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-4-eric.auger@redhat.com>
In-Reply-To: <20251016140039.250111-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 10:35:27 +0000
X-Gm-Features: AWmQ_bnJXo3HvldXhYfEAwn9mGNwu61OD4I9_dyZAIRLm_fhLI_W7oOSzNBtY54
Message-ID: <CAFEAcA8=01a34UyL6NFiiYxFP-hd5Bdi7Y0ZQqKFnO8bUX+XqQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/7] target/arm/kvm: Introduce the concept of
 enforced/fake registers
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 16 Oct 2025 at 15:01, Eric Auger <eric.auger@redhat.com> wrote:
>
> Newer kernels may revoke exposure of KVM regs to userspace. This can
> happen when one notices that some registers were unconditionnally
> exposed whether they shall be conditionnally exposed for example.
>
> An example of such situation is: TCR2_EL1, PIRE0_EL1,  PIR_EL1.
> Associated kernel commits were:
> 0fcb4eea5345  KVM: arm64: Hide TCR2_EL1 from userspace when disabled for guests
> a68cddbe47ef  KVM: arm64: Hide S1PIE registers from userspace when disabled for guests
>
> Those commits were actual fixes but the cons is that is breaks forward
> migration on some HW. Indeed when migrating from an old kernel that
> does not feature those commits to a more recent one, destination
> qemu detects there are more KVM regs in the input migration stream than
> exposed by the destination host and the migration fails with:
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This patchs adds the capability to defined an array of enforced
> register indexes that teaches QEMU that some registers must exist.
> If they are not exposed by KVM qemu fakes their presence in the
> preload phase by adjusting the size of the cpreg_vmstate arrays.
> On postload we make sure to ignore them when analyzing potential
> mismatch between registers. The actual cpreg array is never altered
> meaning those registers are never accessed nor saved.

It's not really clear to me what we mean by "faking" these
registers. It's definitely not the case that we want QEMU
to think these registers must exist -- they really don't,
and for migration from a new kernel to a new kernel we
shouldn't include these registers. We just would like to be
able to ignore them in the input migration stream so we can
handle the inbound migration from an older kernel.

thanks
-- PMM


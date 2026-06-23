Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D3BCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwn2-0006FF-9m; Tue, 23 Jun 2026 04:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwmt-0006ET-T0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:47:20 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwms-0006Gu-Al
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:47:19 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6603d8697d2so5092354d50.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204437; cv=none;
 d=google.com; s=arc-20240605;
 b=ekG7vQpDUNZsI48sT+jOCS68C+m+RzJviCoRrkT1rIU4deUKdAnu1Yv8a7DAT/kMR1
 K+UulBw7QY39XTa2Tvefcp6sEoENNl/V+JwJSYLKROAq+tk7Ku13D+NthcmdFTIDfw3r
 vnib7HLG6DLrG5R8iRecEIdFr49DL9TAO8Rfh4QuGxPFEFXOPn+eNltAKM1QeIkt5/Wb
 5BNvw/f2uUuvjyfVhKCHJgOHpcsebKszwRCRwEmpoUePDRLkjM3F8/AGV6Qp0HcTH2AC
 bhnVMK/Mm0WYVR/L4DiKA5Xn0NwGepecvnYqWZ+1C3GVcK2NGI+Ilme6r4yCBjtzuJe0
 5B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M+XN21DYYf+g94DnAvgVrPf/2DuUlhKYi3LWWUgGH7Q=;
 fh=72T5APMgp9yZ6lVvPhVp404jdwueY5doJkmbsPyVecE=;
 b=JlCxIDeNPYmYffzz6Qoncj4sKIHQDZHJ2pmn7CAfBTRsFsksCzHbgFvXXzDsuwhEQ3
 3Afv1vBX1e5AAjGzRw8PKkJUt2VHkFtOMbIG1zRhnVMLec8waL+jIs3jxkz9Zec63Fvf
 qz1XZZO54a6K8iLlmvFoh6BuOhCig1KlvSp/bPdrhPHUupacfu5qKwv2BM1ohn9OSEFF
 EC7C7R3c3Ye4l/+vUUJERcz8o+bab6cR7MKzOjwjt5NBVEhW1N1EgDAUh7kBoUnQUAb8
 oICXeS/wBpFO1PN9nECyoMdg6u1eLJ75mubMt40vRA2aqHhkY4IwWKNQxo6qWHN+tmN8
 nwQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204437; x=1782809237; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+XN21DYYf+g94DnAvgVrPf/2DuUlhKYi3LWWUgGH7Q=;
 b=TH+FcYwKI9ltpY6WksYLny82W30q3Av9Y24s6aRcGy5OWdO9Pr8ngyL9rzNHID0qBQ
 wcy8hRMLgWB3hqdbruBX7osWqjm9Yi0p/sYdn9WeTlNCJTlQVYS/GW5seebGiFxCr0ux
 Ww9UCYbZLa33lxmKLdsuZv3BvNFfY9uJnDMvfquwwD3OfDsk9rjhEAonXtRDI7zwxyLr
 +UpIRDCoNeC7FdxeUDSUhiIKE0g1GflecXBZmJfQhSJvQjxP5r+ae8vTcxXgHCHSdKBQ
 4g5QmfJWGY4CpFoW5GRb+Ipi6oAzsHwOkUTwD4xSG6wXDWPswnVai8/Z+xkN8pGEX38p
 ZqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204437; x=1782809237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+XN21DYYf+g94DnAvgVrPf/2DuUlhKYi3LWWUgGH7Q=;
 b=InEuCgpM0aNo32uGR2w6guc9ZFT2neev5SVb4Hrm2y1BX9oF4RQJ7rOw20C8dwKvVE
 Es1rYS72f1RF8vAxARp6t1DTMUUAiK5gbogrqudj4BfrZ7ih0bFxlF/Eawq5N+IJXClA
 1d8BzUhB1FMpCVPOX8jCN27ByZ5BnjXK+u+S2kU7nJHdGOpEZW9d6Fz+Q7G3uwBZDKNa
 Y1VmWcZ7UI2DcUMslIF5OHiTfHN6Z/KlxCMedq2ncubVyyejCxMsERzcB+z/BlMq3VWC
 8KJokrAYv9rGoEvMiBc2b2yt7k6uuNL7KPRM1TttB1j46gftaN/xIBJblxeLDMVyFjbm
 ZWjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5JytRkBYo8EluwT52/Tle/1uPni7Q4yIryvisaW5ijDfCEc2X/Y9V2TOGTArfHeSbA6OIgpZ8zOIV@nongnu.org
X-Gm-Message-State: AOJu0YwYhStN2idQsoaXovUMMSoAlAQYyH6FAM9aYwppmb15O+bvOeOj
 ASwIbbD8PQAJX4tGNTKPQff9s5VAZ/b6FjHW54eSyRh3cd8aid7S3BOlaizhnBl7qgXa7bUxVDw
 oNVUcF6bQ162Y+wD+wF/TPDjmgmTEi4Ea+Iu/C6JEgw==
X-Gm-Gg: AfdE7cnPqqCQsggPIILfiJJZrhKy+iGA0fk7fn/1xh6dUQ2oTceT+0ERENTIdDs0xEj
 0FU/MH445s1Qof0PUMj6R5pIG9LBAaP+6RKx9Ago9pAcrYsaq+v6gKNY9he2p4suMXaxE6Ux3Hg
 zW5q47xNVmgmX1N618eO2rhyOEDDIVTn/Z0wakNRJTYBD2jCst5HmiGbZX5VQOaVLVP0VMA69hT
 JD2rPR7/8R2UfDBpT1yKAe6Ue5IiQN6+4CyzHapyByIx7s/57zKloKpDDesPbGXWLTTMuab/Evr
 JdvmG8qqdGLD54cs7L6jwlq88RlMGcnUhuaCQV/BoYGHNhsCpOgP3vMamszcs1mtw8k=
X-Received: by 2002:a05:690e:d4f:b0:65c:13be:3bb7 with SMTP id
 956f58d0204a3-66312f8841amr11960828d50.51.1782204436884; Tue, 23 Jun 2026
 01:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260623075101.17770-1-skolothumtho@nvidia.com>
 <1105dfee-f1bc-4ba0-b8b7-0382c95463c2@redhat.com>
In-Reply-To: <1105dfee-f1bc-4ba0-b8b7-0382c95463c2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 09:47:05 +0100
X-Gm-Features: AVVi8CfQihkXtkWJXyCoiAxgs6bIuUaINBUoOJDJIYOeQGZt2u1GMijH5lLBqeQ
Message-ID: <CAFEAcA8DcRGHDK_eA0zftVLX28Ufo4cPXWf36Nh4obOE0WDb+w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmuv3-accel: Fix veventq read returning true on
 EAGAIN/EINTR
To: eric.auger@redhat.com
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 23 Jun 2026 at 09:32, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Shameer,
>
> On 6/23/26 9:51 AM, Shameer Kolothum wrote:
> > smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
> > no data has been read into the buffer. Callers treat true as success and
> > proceed to use the uninitialized buffer. Return false instead and guard
> > warn_report_err_once() against NULL Error in both callers.
> >
> > Resolves: Coverity CID 1660057
> > Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/smmuv3-accel.c   | 6 ++++--
> >  hw/arm/tegra241-cmdqv.c | 4 +++-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index 80900c2521..6d402d2ba6 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -451,7 +451,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> >      bytes = read(veventq->veventq_fd, buf, size);
> >      if (bytes <= 0) {
> >          if (errno == EAGAIN || errno == EINTR) {
> > -            return true;
> > +            return false;
> >          }
> >          error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
> >          return false;
> > @@ -491,7 +491,9 @@ static void smmuv3_accel_event_read(void *opaque)
> >      if (!smmuv3_accel_event_read_validate(veventq,
> >                                            IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> >                                            sizeof(buf), &local_err)) {
> > -        warn_report_err_once(local_err);
> > +        if (local_err) {
> > +            warn_report_err_once(local_err);
> > +        }
> >          return;
> >      }
> >      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
> > diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> > index 29c488e0e4..bb0b417e90 100644
> > --- a/hw/arm/tegra241-cmdqv.c
> > +++ b/hw/arm/tegra241-cmdqv.c
> > @@ -845,7 +845,9 @@ static void tegra241_cmdqv_event_read(void *opaque)
> >      if (!smmuv3_accel_event_read_validate(veventq,
> >                                            IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> >                                            &buf, sizeof(buf), &local_err)) {
> > -        warn_report_err_once(local_err);
> > +        if (local_err) {
> This is not aligned with the general policy. If a function taking an
> error handle fails (and returns false), it should set errp.
> Don't you have a way to initialize buf in smmuv3_accel_event_read() and
> only call smmuv3_propagate_event() if the hdr of vevnt is checked valid?

I think fundamentally the function has three return states:
 - success
 - failure
 - try again later

Probably the simplest thing is to not use a 'bool' for the return
type but instead something that has 3 values. Then you can set errp
on the "failure" case, and the caller can tell which of the three
cases it is dealing with.

-- PMM


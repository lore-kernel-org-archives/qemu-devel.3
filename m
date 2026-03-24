Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A2CF54AB9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51qh-0006TK-C1; Tue, 24 Mar 2026 09:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51qa-0006Qb-1S
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:31:08 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51qY-0002RV-HL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:31:03 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79860421382so45077127b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359061; cv=none;
 d=google.com; s=arc-20240605;
 b=gislf5oaPu28VFRilHP2eBt6gacF5BT4RHcd7MtT+zeVMESpehrkURJEgwA6u9kYVO
 bzzbcpZiH3WM8KTpqu1WVyH9ZvJ/hif8kXZLxHC2EfbQJK2x0Bi5mcRpK1Ikl9puNXB5
 1t5Q47iVeAR2+koPzqNQFpBHLugn6b3K5RH9eiq9POCbYQSUAdvXliHsRr7w9nnnMAfR
 5heV+L42dKJJdUccF/WGYChNoR4gNljsKimckG1s/B50kflqhNkny1wQ5IuSQhkwbmdU
 HXw+00+RqsomttzWQXtHimYavpZhxxIF2riySrQAgkHbISgF2jWtY+5XD9nEAoCqTSjF
 c3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aqPQiONfmeI14EDLb1xzYRtNQJRb6bddVhHFm8fkElc=;
 fh=49QdW1aPfQ9gtNfLPEaBnlFQgB5lTwqPJd7R9q/qzns=;
 b=lN7SDjoqd0k3Nn7GXfgjw2lw0MaiW6znxafd4e4dYAyJjjovjN3rfdbVfPZUAspDzy
 kK0/Dy2+MkMiXOE7ouag3cu3pAUlQs0lH5sE2cDV/Sd1znUoXLInm84TOPdvIk9N4L2C
 sL/JVWmB8dZXNr17Wvth1vQp094sSkpef1RRjyOYnHcP44P/6KM2dywGyMquAJpniiHd
 UyD1G4/a/HhnJ4o4+YsXFiU1wjT9H/xSi7uiIgYUq7YqJddpWRUohkC/ay7KGbuBADWY
 OQBfY1GenrabSl9S+81KQMNYSgyGHiWiqLQoxoBZIA4p5mPHfv+IXF/cZyFVH8W7JF+p
 gWEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774359061; x=1774963861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aqPQiONfmeI14EDLb1xzYRtNQJRb6bddVhHFm8fkElc=;
 b=g3Wm3ZWBxmAwL82oywdM70ZeZzlm7eYUoitz0cikW0XLbNPANDjoO8IQj7knt5Ure5
 WiDjAGjJ13tMUYEn47EvGCLyMjoUJp3b/PyFES9nxvfIXhAmO9PQudp1xEknGp+LqGS7
 yxqAM8xIMcJHn8rTEM5fkmEEOqOQxfOlWCSLn0KLrFzGO8iYMtFbBkGqL3O1wuT64vqJ
 X/fp6xRilDPUFfRlRIkDhFHQuKf+7DJj93haPQPuVielKvUq20O4ajLSX7nHC7DzAy+j
 Zou3TEDH4uHfflvyx/XGU8HHtBPiSNJEAVItYwm8jKF2GJhXi6IeJlg4HFmORWYmRVt1
 skCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774359061; x=1774963861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqPQiONfmeI14EDLb1xzYRtNQJRb6bddVhHFm8fkElc=;
 b=s87kIjlsZApK3/2tQox6lyMKMXaIbtoo7wmXxNxU9XJiHOM8btVX3OQlHsiSLSKN0J
 Bh2qgV4MRAVB1wF0oOzU/tzcHQV5fZkNI0Toh8JuYiluXHexuyZX9pwyRQOof7nFdilG
 GDpBr/P+UgYNeUSPCo2teaFw5QRibtDrFX+ooE34ELhz+00H9e40qgKBPeAZSSmswJDx
 D0hd1hGhXk+wkobNPynKJiSgAccv9OLl9u81lgx0uu3jmo6gtYuPJBQcFqImt73fDUO0
 1Jj43h4x3838h2zlb2qPZVi0ov2AKNFwfSoY/dn5qMwaTsLo5U/483oV03HpVB3MHVz/
 e1HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RLQCsGX3oIT67R55IDgzYxIj13HS7QawNmIeFF78ws98fWKZKXfoAC2deE1I9vrqO9M1Eq/c/wLd@nongnu.org
X-Gm-Message-State: AOJu0YwIdyAIFIunqDQQP66tGJZ2WLHzLZ+YFqXfQvoeeeI+2lPmOdGl
 +1ph/0hbZb1tanJYBdL+n8IQyYwPuZ1f6MU1+Sok31FIn9M89T7WyZw7G4E2WaSaNWHZwU8EYwA
 ixMINqnl/ktHAKhRG7uMUxIt39QRUlePeSiQ+RuWzsQ==
X-Gm-Gg: ATEYQzwrHwaQfvYny+Q/sWif/ng29z+EGb6Kw+j5FTiBEcRpTT/cNz5MAioiR6MZmw6
 iFXtT7iNAnsDA9GR3uyidHNTQmTEPp59l1tdPxPUM425RON9goiQumNeHTtOKY2X6sUpVkGWqM8
 JwUjBKbgIgGNQ1Hw1jzE+IUZB4vgqoNJpQIdxyd07oMAF9c9T+GXyV8cBbfZ0s7VfCi1qEX64oe
 eWQ4zkCubKSJOYGhImEzk86MnjpHJcpUWwAIx8p3huI5Km0V3AMjZGHVM58KFtWsK4RfDg/reMe
 LoKC1GKvApy53tne16KOYnwNzFJaYGSxmu1UhvYH0hlZ4duOE8jjJBijfeMvRrFdqbw+vDwxM8P
 6mg==
X-Received: by 2002:a05:690c:a058:b0:79a:55f5:a3f6 with SMTP id
 00721157ae682-79a90aeb6b5mr131105977b3.26.1774359060873; Tue, 24 Mar 2026
 06:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260323182454.1416110-1-nathanc@nvidia.com>
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 13:30:48 +0000
X-Gm-Features: AaiRm51FmqfZYv-eQk927A0Kc0Tb7kxuT4N0ndkjz1MpqNbS8AVHaTO5_S_-354
Message-ID: <CAFEAcA-TC8zpKivJ-Um14qHEbcrdCtT9GabkM_+m=B08esyaWQ@mail.gmail.com>
Subject: Re: [PATCH for-11.0 v5 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 23 Mar 2026 at 18:25, Nathan Chen <nathanc@nvidia.com> wrote:
>
> Hi,
>
> This is a follow-up to the previous series [0] that introduces support
> for specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL,
> SSIDSIZE, and OAS feature properties.
>
> In QEMU 11.0 we introduced new options for vSMMU [1], but feedback received
> when starting the integration of layered products shows the need for
> auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want
> to fix the option types so that they can later support the auto mode. At
> the moment the auto mode is not supported though.
>
> A future series will introduce support for resolving the 'auto' values
> based on host SMMUv3 IDR values, as well as setting per-device ATS
> capability.

Hi; I'm picking this up for target-arm.next because it looks to
me like it's been reviewed, and it seems to me better to take it
for rc1 and if necessary make any last minor tweaks with a
separate patch in rc2, rather than let it sit on list for a bit
longer and take the whole thing in rc2.

Let me know if you'd rather it wait longer.

thanks
-- PMM


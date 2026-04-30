Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998E1CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOrA-0007MC-MP; Thu, 30 Apr 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIOr9-0007LI-0F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:42:55 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIOr7-0004z3-Cy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:42:54 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6501418152cso662001d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777545772; cv=none;
 d=google.com; s=arc-20240605;
 b=OHkhiJmKWP7l8F43id0DOXBWFKbGU0AkMaW3k/Qti6pW9iWGeP9Jkgd9qICp75ODCT
 RudxvhUAWmJeeZYnmQ4VdsmsqJ1SA5dNKx283co4dLsDk98XKQwhkcGYz6+TyVhD10uw
 GIRu4EZ2u6BCrbBptaRqVgwwxDMAScBBE2gDYJndTAR7XLNZQ9VisdiiqhuWJgHgwf4K
 nbjgvD6Bh/1EPxOOawjCV2DtEsmIqZP7hiFL5Eh1YG6HV6rJ8KGuyNffddMuCycUWF4+
 ibp2jxcgEcpxrUOM3y7Rmq3BF79p8E8uGgjLmoPNW++Lo4ejWt/mCNgEh36XoiGUsMs9
 lTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2g0y1nWNZc+AxGadVPMcazKrF3IG5aUDZC2BcCua7G8=;
 fh=YtKYAKb7movrsKSF8t3D2EtC6r4tz7cDma5VL9EGwyU=;
 b=EQl7yGRbvvweaZUuUgCzbC9RenR2dgCufCOFy8reKXOC8z9tqfNjAsYm0csCdi3y1G
 lR4Pg1qB9iqKrBPUd5Six8Ot0UDHAQfL0FXeQP8DM0gC9zn725N2IaLqW/Z/6w44PlQ3
 7o6pgBLWJ2FkFMWvttbEgSwSTCQs2pXzD6SfWGKg/ZDmXLHna6vrWtDvghZAFnVs4aId
 OQZUPs4SyPrjM9YpEg85oRvpzzKNZdjr7FDc9/+SXrxzivQjjyZoRpKlH1l4gMzJV5Bg
 SvVHe6m5j0ArlP8hdAwH0VWOzhOEyH8RtUsZCpPD+0cyHo8NlMmJkgrLL0Bw59TONYmL
 c/+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545772; x=1778150572; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2g0y1nWNZc+AxGadVPMcazKrF3IG5aUDZC2BcCua7G8=;
 b=u2CXR4cBppGDhrV2A68ihgDWzSPPtclXe/tzhEm/X9Cbw74n7Q2A5MLTB3GXN7eEZV
 kShllx9KuR5JPMGhAuq73WQsvacYgCY5JJRsVcl+LH75KMuMMkrsZ0ZvS6dSp9ZWURTJ
 H2Hdx/nViUZp3vFShu//T71zWpWjOp8cUhkH4maciR5+s1lOwKLSzq+ehR4La3PiwcrC
 vYpJXtiUI8LjvcRwcDVU5dMo1wwm1Bryf4faJXbLBjSdAdI15e4VFTdpD+kMYqXgPBQv
 vltiKxr1vbeBPAyZ9s+BWdiNQVBAK0Nwqj1mzJ8pjlMnGKPHS/SCzWaQ7xMmWC3bx38x
 5Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545772; x=1778150572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2g0y1nWNZc+AxGadVPMcazKrF3IG5aUDZC2BcCua7G8=;
 b=l0oTs2bqhmBGCXt63tsuZIbjXRb38wAfFxRXOVj4msR7sMbtd+kmSFFMW93z6zEyhy
 ndPyTAWFo9rxnTNOQHN+LejagBQMskhLP/BBl+si84aA2djTHyvXOa7FtX0zRTY03AoV
 Yb3fNC57Hpq6CUfH6kmR6rxNh7RS4QvPGXKPR63cS4puhxaNnlhibhSr61yGTNseUbGN
 fZl3b4ZzrbxjTNxVm14lG4DVy4LJ9o9W6F1ZAu/T++YqCF0HfhinuNM+xOCZrl4Jazdh
 aj4EiD0RdUYHaqlRivW3zKrv+Kg17SMSIh+BrOlxXtEl8o1fAROHQWGGAXKWYGEJZgZK
 Entg==
X-Gm-Message-State: AOJu0YxbIqKNPs7ige50QDZ202y6U/yZ3AnDRn6LxMwIJqYxCPaf3t2U
 y+tY3PwHs22i8EPN9RbCHT6PLmcj4NMIFgGJeFPWIagPXyEUznUyVY0WPmlcjBDoiDAEjmbvmTo
 s4iwLzR4bexue33plKgTAcXSNda0XvdIUxg1yIcSpew==
X-Gm-Gg: AeBDietva6+LIoQ/agZggl1lFYAxpWEVz+jIj2QuDtkDHOPyTMmfQWdPflksWs3JAmL
 wXH3mzc4S9ewv+Sa/z4+DAMaa4nQ3MSAzVSjwf1p9QojNl0rYi6HBayVcv5Le5ZWIJ/D8K1n33l
 JiSze2UZ1kIraWLQjL/jUXGTYA7i2+fnWsGjcs2sPGp0ShKOy4S3uWBooTuTrZOh2En2fnrjDZF
 Ir6fqJjYhlXXop/nPx9uDnVKu5P8hdiaIIk/u3Vtlv7V8D6hVhALU47AVsIM4L+irrIwONkasZC
 jjFU60fQipfVLdxK3aZJ6D6CkVnXu3zItr/E8WgpTaayG9ft17nXOzBg437w/lT9q8ChXscxq54
 3EI8Swaj5mn10
X-Received: by 2002:a53:d104:0:b0:64e:d610:71cf with SMTP id
 956f58d0204a3-65c18fce8afmr1242841d50.58.1777545771829; Thu, 30 Apr 2026
 03:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
In-Reply-To: <20260308203516.160103-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 11:42:40 +0100
X-Gm-Features: AVHnY4JM2dYns_HE7ObRADh3zyxX8nLpEzAfCcCKftBVuoCubM6J_aRvFr41S54
Message-ID: <CAFEAcA8DbrVdRQK4Cy8gqU__FXYsTa0nZERqrd4he0Y1WRW7uA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Trivial cleanup
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series contains some low-hanging fruit fixes I came up with when
> investigating Rust for QEMU, especially QOM object lifecycle vs. the Drop trait.
>
> I noticed that no finalize methods were called in Rust sysbus devices when QEMU
> quits, and neither are its C variants. What is probably missing in the first
> place is a
>
>   object_unref(object_get_root());
>
> at the end of qemu_cleanup() in runstate.c (see TODO there). Adding it before
> this series won't clean up machines since their refcount won't reach zero. With
> this series applied this additional line will cause various issues when quitting
> QEMU, allowing the problem to be investigated. Fixing it is beyond the scope of
> this series (and my time budget).
>
> Testing done:
> * `make check`
> * Run imx8mp-evk with a Buildroot image
>
> Bernhard Beschow (5):
>   hw/arm/fsl-imx8mp: Do not create redundant unimplemented devices
>   hw/arm/fsl-imx8mp: Fix parent of ocram memory region
>   hw/arm/imx8mp-evk: Fix reference count of SoC object
>   system/vl: Fix reference count of machine object
>   Revert "sysbus: add irq_routing_notifier"

Hi; I've applied patches 1, 2, 3 and 5 to target-arm.next, since
they're all either arm-specific or the obviously-OK patch that
deletes the unused connect_irq_notifier method.

Patch 4 (the system/vl one) I am not applying, because it hasn't been
reviewed and I don't know enough to know if it's correct or not.
(My guess is that it is correct.) You might want to repost
it as a standalone patch to try to get it a bit more attention.

thanks
-- PMM


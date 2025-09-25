Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733CACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iyX-00056j-UW; Thu, 25 Sep 2025 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1iyS-000542-58
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:13:18 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1iyF-0007ky-Kz
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:13:11 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-eb37d80cc16so733889276.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758795179; x=1759399979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=scxhs7La0+AUy9MQxBDmeXWs1KfS5UJfjG4hAf+A2oc=;
 b=jH0Gul9i//AtoJVr/vFjk9YG3JmG4LdBOlXaHtiC51BU+2LqJOovKxIfHuunsZ2ZYw
 Z4kwqHcMDlKfHa0Z9875VxyUqD9gJxTkHbIBW1Oqtd/E9uqgaScZn+Lf4mjn99hpNRc8
 tBEM4N8Ov3PW3y1RM8KHQwnd2dQQ/jKHCF7ybhmPylf14Mw2otmI8ENCBMsDyfIuRdzP
 ggBL68pRpMpfoVculfkjMC38PU+R4GlWj+34JJH8iO2d/ZP1cRERChJB5DYuzDrFTuGe
 XjbuWKu14l419N5ciVR1/pNBlRclRsLvxDrsDkCycULVN419AJ5L5IFvvBSQ3vLVDbqB
 7zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758795179; x=1759399979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=scxhs7La0+AUy9MQxBDmeXWs1KfS5UJfjG4hAf+A2oc=;
 b=djv01aWwL+SR5WN0ZIHSOFwyjiqIBi+M3bOMBwuwfJvfId88bIxDt9MJLp/xTKA/Lg
 qaGfBYPmhjDLvRHWZE49cdfjKJ2NJ9smBNkxjSxzN1R3SkZHhBUAHy0iXGTUnnWw6zUC
 ilG6bDAMRYOpoRMO/fREbqhTt7DkCeZJrR0ymb8mWFRiriV4kznG1/JLAW9mVdNBgI2W
 IhM+jY/CHrVE37ZE5vv7N2Kr+GnrlyIymh2Zqo4EEXvddcolWM5b9N0jam9KGnSHuCaG
 HtrPckvdAQiyXhydC2Js0PM890dyuAT/lD/rlGtScHCT4F7xf+ysg31fH6n6Fp8QRSd8
 +XWA==
X-Gm-Message-State: AOJu0YzQPCNch9s3N1xFo1b4D1lHrVnDQ+SEACajFLCzosvrhduvwYV3
 baaPeYfmS9IkY4SGimJadny1vAi6fNSc8aEC6HLai97N7m3AKnYb5WmFFpPAeHm6fdpBFSOGDjx
 qzKSzmo0M6V5DmMDpi4EPCjKUt2Qx45UUBFR1kcak0Q==
X-Gm-Gg: ASbGncteHJYiz0FH7h27G+ONf9NgGNBM59FWuT+9iAzpwYazS2s30NTqsodJnaMB11i
 8Ixz16nuwuRiwQRLr/8HRnL0zGjNTYsN1v35Iw4i99NOHd63BifqQP7iBVixO1AYq5QzC/RJW0M
 eBUX7imIVhSPPai8xYLvpHjPgpP0OiWIIYSO/3asSKOV9iZT44qxXM19yEivfWaZc/46q+s4cUp
 XPt4Aeh
X-Google-Smtp-Source: AGHT+IF7GlC4Oi5Chs9PhIKXUcNKQskR9eHl4psSj68xS7gTYogTlhG3CqqxjBNjtnixe2JsBjOHODFhzOqyzxAzq9E=
X-Received: by 2002:a53:a0ca:0:b0:635:4ecc:fc23 with SMTP id
 956f58d0204a3-6361a82e8fdmr1649572d50.43.1758795179120; Thu, 25 Sep 2025
 03:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250922132217.680404-1-peter.maydell@linaro.org>
 <5c952898-c129-426f-a68f-42b369ca7aa7@redhat.com>
In-Reply-To: <5c952898-c129-426f-a68f-42b369ca7aa7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 11:12:46 +0100
X-Gm-Features: AS18NWARSgn_3NHsEx-uEfB13pxAYc1aXd8a3G2VO5oucoApAeaRTNdDfJk9oBE
Message-ID: <CAFEAcA-DYsmigYTd4HVE26xVm3s=KVfqgRzDzzCbqzmPEajs6Q@mail.gmail.com>
Subject: Re: [PATCH] passt: Declare dependency on gio
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 Sept 2025 at 13:52, Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 22/09/2025 15:22, Peter Maydell wrote:
> > The passt network backend uses gio; declare this dependency in
> > meson.build, so we don't try to build it if configured with
> > --disable-gio or if gio is not present.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 854ee02b222 ("net: Add passt network backend")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/meson.build b/meson.build
> > index 6ade30f36ad..c5a56ba5deb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1279,6 +1279,7 @@ if not get_option('slirp').auto() or have_system
> >   endif
> >
> >   enable_passt = get_option('passt') \
> > +  .require(gio.found(), error_message: 'passt requires gio') \
> >     .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
> >     .allowed()
> >
>
> I sent the same patch two months ago:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04907.html

Sorry, I should have searched the list and saved myself some
time :-)  I'll pick your patch up via target-arm.next.

-- PMM


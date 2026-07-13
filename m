Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCjO-0003oA-Sp; Mon, 13 Jul 2026 05:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCjM-0003o1-9Z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:13:41 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCjJ-0007rS-Ui
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:13:40 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d78637f8so5205129d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783934015; cv=none;
 d=google.com; s=arc-20260327;
 b=dV81a2TF8sG4qXVbppr1lJPYFJlXbZWicJDt8uPwH06IrbkzsZDa8w8STOu3hKPhA2
 TbMSqUtq7jKX3VNVk6qthQDgVwbTMz1LGGxUSoCdgj7PytJfoBADskNjbZ09H7/Hb210
 +fgbcYkWzQIM1cHs2UUFFLIASIOAJlbByEarNC8c/p/3qi1Ls6tTboHdgO0w+UIWChex
 zcnZdDGNBMQgkqqkXrapXUIDXUs39tQG5k4x1a9RxSrJzC8AOBAv5giMqRbvxOYZWgyd
 ficLSHoQIhtUp/2u+0M9+clbENl8B0CDTzPsVlSvLjyYvpvl50/yNVG4nYcw6hwv1rL0
 ePow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gPtkeW5vH3sEM2hInBuwK3qacB4iKnDBmzk3NN8u+Po=;
 fh=T1/5tW/0AFabgXjVfN1oQcjrKFuFlu2yKSj7FNrdTus=;
 b=rgxkc9rjbS+is1gtuQiUwUPo+Cwx3N6vpCmnJ4ul00meAwlnq1lDb/BHZlZCpvPoS2
 8byCP4zxZ0ZN7fDWhAd4vEMkYd/xSnug0pRj8LmRfwN6RMfYDdjt81UuPcMLB+5mJpTm
 OjRiC3NC6LBG81WTwhDe0LvWq775Anro01jskzdte9YA2QxN8MtVasYuNY+/j6i90+pX
 UBrWfXsKI3weAAYdz0cSy1VqzEDV/7mnQx4iaS3wIgigSQQ6kp82PLvsmWmf1m1rW6Wk
 /A537fEEDdESC/97R1PkKvMPRsbPcsVq8QeRv+R5hc4ie/VVlevXyOtY113o2vsSSJXJ
 qdFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783934015; x=1784538815; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gPtkeW5vH3sEM2hInBuwK3qacB4iKnDBmzk3NN8u+Po=;
 b=KLEGhmzVPFEYLrqWQt2IAXJUF0/tk6qkJRDgjVQW3Krp14uqGW46MRh8fTGelAW9E/
 tPg4Yg+W34A/x/CuJuGZmeGqvpZ5XbsfdGtgHgrX7klyD9lUiJAJMb/17bSlPf7zamRZ
 /8qPBYjeYsFdm5XdKo/7oeEC2XkSGVPfPFM3eKfYIhlLJJQV7olxoGXTooQjyQQf+Ibj
 V/W+ZlEaGn2ev3yyVUfbaiRv7yIMwB7VNOyYqDM/+uj1Nw+AI13ICHfc7qirTh1LCXPc
 HKo/z1+TpK35vQVWNT8yoL9m9t784tBbzEguc97SX2kiPHltw51Ukc+wya4kGwyKaYD3
 8xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783934015; x=1784538815;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gPtkeW5vH3sEM2hInBuwK3qacB4iKnDBmzk3NN8u+Po=;
 b=Yunj/ft/n2pWFWIy7joiaKjJ/v8EmPpFcje4HcNPtaYG7KWO8EkgxvXDgtXdz5lpqd
 KMQs0PDrxsIbFohvMRKWlnDe9VEn1MdTIBvgE+mMpaFuFvnSFHdEhBk3kKaCcMbu3x7Z
 BRBOzM+Cz70eiyBU09YmFRym8ZYxkBxf/Zt6aLr2NRF8qqdBxZSPxVwIzXpueFS1TFRO
 D/Nx9qpsPwQnVXsthel8a+C2RKtGMeJf9srhe5xS4wpDckqSwvnXFqYuJOeA83hvxXyM
 ruvUjSmigX31lFVaVnjXmV+HllF/fMPGX7eU9g4y6DbtRf8Yzi4ely4c7PioZWTMBXJx
 MBYQ==
X-Gm-Message-State: AOJu0YyHVQ5t4UalU6BmtzbJX0HFFWxv5rF9zMwD4mmQmLThfxyKXvgA
 D6udi1OobezIExpzG2NX0RzdW2yH9h5vzta7ekxMX5Qt21yINizlSiZD/jBP769H5kkU1BzrZce
 7lIj3KYzuJ7ACxtEPSPMDobLGIVhYBH7YTdOwlOmtNQ==
X-Gm-Gg: AfdE7ckg82SZ+rNGorkASWhX2X/o3kbZ+Mr4whrwl3Xjb5c1NK/tZP2x/gR3EQBAVee
 ckbPf3RXgac9we7HrkStpZzgpw8u8usKy0L5W8aSj/mYI3vWtfda7GEUD/m6Vo7TuVzOy7gn2Kh
 QkyLlRH8tnD6VMACd7F9w1cZHuHG+m9gRuIGbOvmdRIXgaygSCUNnWbDIbc0KR51kTCaihAMDpt
 ycHsiry4vkPDJ01c1XL5oKNjGgRAXRCI0+MnYmNCfRcR/JH6dlXFApRyTa6ZDBXe5Sj3j4a8D67
 indHrtk9S/XqzJM/UbBRjKyFBHh+M2VZX9LS6aecQC0RzXFFllq69EBU
X-Received: by 2002:a53:db43:0:b0:667:aec2:a905 with SMTP id
 956f58d0204a3-667d7c46a21mr4547877d50.53.1783934014710; Mon, 13 Jul 2026
 02:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:13:23 +0100
X-Gm-Features: AVVi8CcnwcVSkGLUcvfhNiWsJnoti3TzV_Q3YizNrYwBQb5oXjquP7Hcemz2Tz8
Message-ID: <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 29 Jun 2026 at 09:18, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The distinction of instantiation and realization was vague in the old
> documentation so this change clarifies it.
>
> The old documentation said:
> > The former may not fail (and must not abort or exit, since it is
> > called during device introspection already), and the latter may return
> > error information to the caller and must be re-entrant.
> > Trivial field initializations should go into #TypeInfo.instance_init.
> > Operations depending on @props static properties should go into
> > @realize.
>
> The first problem with the old documentation is that it is unclear what
> "trivial field initializations" means and why triviality makes
> initialization appropriate for #TypeInfo.instance_init. Another problem
> is that the documentation is not comprehensive enough; for example, it
> mentions @props static properties, but it does not say anything about
> the other properties.
>
> The keys to distinguish instantiation and realization are property
> setting and device introspection. The fact that property setting happens
> after #TypeInfo.instance_init and before realization implies that
> operations depending on properties should go into @realize.
>
> The fact that instantiation happens during device introspection but
> realization does not implies:
> - Instance properties should be added in #TypeInfo.instance_init.
> - Instantiation must not have any side effect not contained in the
>   instance.
> - Any operations without special requirements should go into @realize so
>   that they can be skipped during device introspection.
>
> Note these two facts to guide appropriate instantiation and realization.

Thanks for sending this. I think we definitely need to try to be
clearer about what to do in instance_init and what to do in realize.

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

>   * Realization
>   * -----------
>   *
> - * Devices are constructed in two stages:
> - *
> - * 1) object instantiation via object_initialize() and
> - * 2) device realization via the #DeviceState.realized property
> - *
> - * The former may not fail (and must not abort or exit, since it is called
> - * during device introspection already), and the latter may return error
> - * information to the caller and must be re-entrant.
> - * Trivial field initializations should go into #TypeInfo.instance_init.
> - * Operations depending on @props static properties should go into @realize.
> + * Devices are constructed in the following order:
> + *
> + * 1) #TypeInfo.instance_init
> + * 2) pre-realize property value setting
> + * 3) device realization via the #DeviceState.realized property
> + *
> + * #TypeInfo.instance_init may not fail, and realization may return
> + * error information to the caller and must be re-entrant.

I know this is in the existing text, but what do we mean by
"must be re-entrant" here ? Does this mean "even if you return
a failure from your realize method you must be able to handle the
caller retrying the realize operation" ?  (I'm not sure why that's
a useful thing for the caller to be able to do...)

I assume we don't mean "even if you successfully realize you must
handle (and treat as a no-op) a second call to realize", because
none of our devices do that :-)

> + * #TypeInfo.instance_init should add instance properties but must not
> + * have any side effect not contained in the instance, since it happens
> + * during device introspection already. Any operations without special
> + * requirements should go @realize so that they can be skipped during
> + * device introspection.
>   * After successful realization, setting static properties will fail.
>   *
>   * As an interim step, the #DeviceState.realized property can also be
> @@ -40,9 +43,8 @@
>   * point in time will be deferred to machine creation, so that values
>   * set in @realize will not be introspectable beforehand. Therefore
>   * devices must not create children during @realize; they should
> - * initialize them via object_initialize() in their own
> - * #TypeInfo.instance_init and forward the realization events
> - * appropriately.
> + * initialize them via #TypeInfo.instance_init and forward the
> + * realization events appropriately.

This change doesn't seem to me to match the paragraph it's in.
The intent of the paragraph is clearly "initialize child objects in
your own instance_init method", so we want to say "in" the method.
"via" here is for "how you do it"; we could make that say
"initialize them (e.g. by calling object_initialize())" to be
a bit clearer, something like:

"Therefore
devices must not create children during @realize; they should
initialize them (e.g. by calling object_initialize_child()) in their
own #TypeInfo.instance_init method, and then realize them (e.g. by
calling qdev_realize()) in their own #DeviceClass.realize method."

This whole paragraph is one of those we sometimes like to put in,
which is sketching out a design idea or direction we have not
actually managed to achieve. So it's part aspiration and part
reality. In particular, the flat "must not create children during
realize" statement clashes with "operations depending on static
properties should go into realize", because occasionally we need
to create or not create children based on the value of a property...

thanks
-- PMM


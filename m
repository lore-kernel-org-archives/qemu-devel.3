Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D5106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kkx-0002rL-Rp; Thu, 12 Mar 2026 14:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kkt-0002r5-7V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:27:31 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kkp-0008Up-QM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:27:30 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-798374d0f44so37675187b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773340038; cv=none;
 d=google.com; s=arc-20240605;
 b=HxAkqmbfJ4uhqa6DGVl4szq8cUgi5MntSHarYHMUN4U4Cu9ZM9sgCgm7euxktKDGM7
 eEJQxj8XIv30+5AXvABlt39GxlMowmJI19mfUTRZ0NXy2L5aaNJ3GpCwCuz8DibVTw7v
 EJZ0SA1pHnTJyMd6VaxIwAKU7n/RBPgx8QEEAt7ZmPxfkjRJBInM+V9dlZwG9UJfHbS/
 eiY5WbCIQSm3h4C0QNN9t6tuhoPFSdRN3InBoxkU/vdjlqAMjEN++a8SX53SKVmj5RH6
 E494hEc8rksyTPBv43F3UqMss+peOCEMlOA1KGKlVxIdbIy3j37qiuVsc/Z/tazkPoEa
 4vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QhV0CR4U+2jV4p7QMnQgFHZV1iFWDiGMl00RIxoVllM=;
 fh=X/0rX4B8GQvRMr+EQ2SqfCaIVG4Y9RDFHdMOWi/3uWs=;
 b=WjmD8QxoLmUmcWi5+ybTZENqSnq+8a0cjzpSnf8pO+mRaVKk+IczrCvbTvjug5biFA
 4BMj+l8xSFPM7/oncFYurtdtQGh3yk8kOkDep9kh9/hJ7Sy2lClVd5gs5KkDYTL5POGJ
 jBE+Q4iYnog51g+rvisWRzOQHSczP6m4b5/A+7wLx/WOIYO11bO/ARttBajWa5G05N3f
 R24U1s2tsiCzulQ9542pZ25ZLX7jL0uI7t2Ix+OXRxo9wqsaaO+oYZvsaolss2AyUmGY
 Bviwaagii23ibGHoLBUMfZrGonWJ/cuUoaRJUoJShXHOe2JRoLM0XxQ+YCpb85FelDku
 xvLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773340038; x=1773944838; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhV0CR4U+2jV4p7QMnQgFHZV1iFWDiGMl00RIxoVllM=;
 b=erDVFHgzxZUledmJbUfZts2yEhutUchEvUCLQ33u/ZMn9a+D7oluktwhyxiO7gBG7Z
 2GwY7HyLx+BZZs3JZa9ZlEftzKS9C/3aMJzjpkBAIdyBxRfV4Tb2go4pLjXvutzpnbZC
 8soUHes9XOonpr+r4bZDp7GXzZ5nSTOrkrIUjrJupLhR0V9vhCQZtaep5hMUSDe9MZYU
 RwgZDPub71iOkoO01lBU9/T7tpgUki5m7hRP7TZRMizNOz+SOQKZ0l6ITENfYCPhk8CA
 f1Zd01O8l7aTuNk+EvOUdp+uQPWRE0rM/mh/bYEn3qM1OKJjKaISu1cuCCBsq7nyWKTt
 e1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773340038; x=1773944838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhV0CR4U+2jV4p7QMnQgFHZV1iFWDiGMl00RIxoVllM=;
 b=P0yN1ksvsogXL8jLizA5pnSTrAd7XkRJ4YmVi4DY9kq/xymzBX7Y3KirifA0Fj/ho9
 C0qi7e6osrCqCCpcVKDSDFSJvsix97GATJBAJHYBF/C2NnuQ/QFOa5HUDsuPbysTpCO6
 s3IK5Bi88RxzBIZxojnrQUg2ZQW9ai+rR0eiOXCYcy/ZMVoJLIRKq8H1M6PV5ESOx2Tt
 udhSV/GoOSMZAsScP14FnqqK86QJTEsLbLbmqym9Yboro4NAYH9yVp7L0Xvq3JgWZFYb
 eSlh4PyAOU65dyltjRPZfDTsmeOFe39z94l7SELg3PiUu6YEMPK7O+Doo9WKnCb6Hm2f
 ZXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcxaLAYNsOWWDETaPWcVnfu4mqxdol7z0yKxNknVpvstfI95XzfaWDo91iAz7XdvCv3i+JkSGD1mB5@nongnu.org
X-Gm-Message-State: AOJu0YwTO6jyhtJEcg7vTlUKCU8IOKwuMEF5iGAPsZC8M94slKcgj9do
 aAjyirRMTkKN7atnrJQSr8V5rEimkVtTfK8WU8pGZa3trXA0SyranI0EvNiFBFv6x0ePH7yu20t
 7KT+USx01CpmpsRNeJcUMQQa1QR4kvHZiLX8hmVtw9w==
X-Gm-Gg: ATEYQzw6SFAisQSS3tT61Qf0wHqu1jypKNY1neE5hlSw9gIdiNHnbqPn/z2gF3eg24d
 pY9WeAEyg3l4n0Utv8Ya+UFSE16YUIe73V9yK0bjnxQUGbRQuYDrBOiFCspnn/xaI3pS7cpQBrr
 uDiwNh1etz0JJlBZSMU9K3b8iqPQxtkLnXCbd5v4Tby8eINRe4aRo4lGzj4Nu5U0Hvo0OwANiSG
 J7cx+Y346IpR/K7E/em3qXsHPxcOnPVipYtPj5oHBicGvgyPIKKGf/eZtK8Ra3+8AQAT8VXQ4p6
 e/366xlp1pcqgArtHVJauFu6/QSVkWZq5UpTXCTIlrA8/pS9NdDj0KFimr151ILDecwmU8rPPxO
 CpA==
X-Received: by 2002:a05:690e:1306:b0:649:cff9:de4 with SMTP id
 956f58d0204a3-64e628a9569mr603244d50.41.1773340038390; Thu, 12 Mar 2026
 11:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
 <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
 <abLc_ppEEbKjNRUi@x1.local>
 <022c929e-ddda-4f74-8786-d01994107415@yandex-team.ru>
 <abMCMrRxdAWCc_hv@x1.local>
In-Reply-To: <abMCMrRxdAWCc_hv@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:27:05 +0000
X-Gm-Features: AaiRm51GCrTbG_nY8zcIYA_pVBNb0MxGI5MPFcxBF3ggPdE4Mq-qqOhs89pCgms
Message-ID: <CAFEAcA-LEuiqbqL=DBVrPV6FJVGfVRoDE+1VH090g-aTV46Uxg@mail.gmail.com>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 12 Mar 2026 at 18:13, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Mar 12, 2026 at 07:34:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > Hmm. Probably, that this is the subsection, that exist only in our downstream.
> > I don't know, was it mentioned clearly before, sorry if not.
>
> Ah.. Looks like it was not mentioned in the latest version posted:
>
> https://lore.kernel.org/all/20260312102626.891359-1-dtalexundeer@yandex-team.ru/
>
> Let's always mention this, because it's important piece of info, e.g. to
> know upstream has yet no reproducer.
>
> > This subsection just not exist in master, and we are not going to upstream it.
> > So, for upstream it's a "theoretical" bug in a protocol, which may be triggered in
> > some future moment. And that's why there is not specific case in commit message
> > but only assumption "Let's say there is a vmstate ...".
>
> In this case, for upstream we almost only lose but yet unknown gain with
> this fix then, because we stop throwing useful info for unknown new
> subsections, as PeterM pointed out:
>
> https://lore.kernel.org/all/CAFEAcA_mzXDdz_xjPnZ9Kc4K01Aoss_OH_qEoL3G33KdsnHrLw@mail.gmail.com/
>
> But I agree it is a potential issue, if we cannot justify QEMU can never
> hit it.
>
> Sending "how many subsections are there" is one viable option as you said,
> but it only solves this small problem, and knowing that number requires src
> QEMU looping over the subsections twice so a bit awkward (first time we
> need to kickoff ".needed()" hooks to do the counting; not all will be sent).
>
> The other way is to provide level information somehow in the stream.
>
> Say, we could attach START/END markers for each VMSD to be dumped.  That
> may be able to help in other cases too, e.g. when we accidentally grow some
> VMSD fields breaking migration, then IIUC dest QEMU can provide a more
> accurate error message when it knows the bound of current VMSD that is
> being loaded.

Could we perhaps do something like:
 * mark up the vmstate sections we have that don't follow the
   "/ is the separator" naming rule with some new struct field
   that says "legacy_bad_subsection_name = true" or whatever
   (or rename them if there are cases where we're OK with a
   migration break, like "iotkit-secctl")
 * have the migration code enforce the "subsection name follows the
   / separator rule" via an assert when the vmstate is registered,
   with a loosening for the ones marked as legacy names
 * have the inbound migration code use the strong check on the
   separator to distinguish "subsection" from "not subsection"
   unless the vmstate it's doing inbound migration for is marked
   as needing legacy name handling
?

I think that would keep migration compatibility, avoid the problem
of wrong subsection names creeping in in future, and in practice
mean we don't in future hit this issue upstream. (With more effort
it might be also possible to tie the legacy names to QEMU versioned
machines so that they can eventually be retired.)

thanks
-- PMM


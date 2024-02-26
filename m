Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CC9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recCG-0006I0-Lg; Mon, 26 Feb 2024 09:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1recCC-0006HV-7L
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:43:08 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1recCA-0008Lg-Ku
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:43:07 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so3686232a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708958584; x=1709563384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=17m99YhPe7F11ugCrwylGP3euN2U9NFj0/Or/zdftOw=;
 b=rLR2lA8EK73KB/8L9otIjwS0YNC5i48qzlzXyuOezbKM6IheE7WgqSOMEdSknSzMMn
 DavIb1ZQrmx6m8ekbyrxa2pkLh48HBGrg62vF2QplcJGfmLjBGJD13Vhuy6+11232uE5
 pcrBTfet2yRSSN7v+iTGrDEtRIpTb/UfZyZaWCnmyHGSb/lPRJb05C4Ri8h0qSR92CR1
 Nhz2fqYvwx5+FXUrD2jeruUb7chcSVK8nhoQevWHRHeaPq6+ZEpsZkEnoTSyzrfwZUIx
 Nkyo/icJcoUE97JgldhH5IOcQIm7/e5MPhqTMJbzigLVMhLYWPwBvZhabhEPKIPHwUqB
 VXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708958584; x=1709563384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17m99YhPe7F11ugCrwylGP3euN2U9NFj0/Or/zdftOw=;
 b=Tdndbab8GYfSoFilnZMlQKH6QoFpQ/iNwmTUHzvMAnscqXw2NMJn5B+wzC9AY8/IgT
 rwSYEsSAgF5JBWgbl52/j1W3rUkZ/aoEXl1UTeC0+s4+V1DTB1jP9g+bibObwd7wnFb+
 QZYZnxQX0SroA2DHwgpHWheEOeuVLIhNBtMSUgijSTTj+4/A3oGRMezE1luxJ9tuklDA
 rwhmNjb+BPV/pahBfOYQgOw7LNxzyxjEDtKlRNAUSoXUNvJoqamMzkhYQ6Kp+IyJvCl9
 D19vVl3UBvLCeuuI3P7lDijI/5Xp31kKPGcn+6SmVOx6m7Mzr5888BQExu8MpHfLX7JO
 OqTQ==
X-Gm-Message-State: AOJu0YxCASlR8wvMqA7+6VJGVyP9KUOFb7J2XLeOavzuWdM//D4kZpA5
 vg9pYQ5VC8QmKADq++0VJ0J1hceUWqf2u+2v+9+BPaWTIrlNY58pLOz0BQP1ErZvRjE8OLPLSlm
 hekHzEW0qGJcdghNHw89uJ3+12fJuGqdY4a5yLw==
X-Google-Smtp-Source: AGHT+IHpB6wjjyj1/MRsZqixqOXET1t8QOLaZLnw3DPMLIavT5NP1A7mX2d8fz+efm+pW1KMlZRqEq9Z/Y4T/1b2z9E=
X-Received: by 2002:aa7:de11:0:b0:566:1e8c:4faf with SMTP id
 h17-20020aa7de11000000b005661e8c4fafmr389493edv.33.1708958584664; Mon, 26 Feb
 2024 06:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
 <b428c48b-578c-46e2-a0b7-c648b012f3d3@linaro.org>
 <CAFEAcA8++iLJ+LMjN_GzoctdvA-+XraA1O1CSTGm3b62Do8JtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8++iLJ+LMjN_GzoctdvA-+XraA1O1CSTGm3b62Do8JtQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 14:42:53 +0000
Message-ID: <CAFEAcA_W6T5yi7BYWPkHBP+f2buBboomqdh-233GhM25DSaCfQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 21:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 20 Feb 2024 at 19:46, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 2/20/24 06:06, Peter Maydell wrote:
> > > +void resettable_container_add(ResettableContainer *rc, Object *obj)
> > > +{
> > > +    g_ptr_array_add(rc->children, obj);
> > > +}
> >
> > Did you want to assert here that obj does in fact implement Resettable?
>
> I guess that makes for a nicer detection of that class of bug,
> so sure.

I'm going to do this with

     INTERFACE_CHECK(void, obj, TYPE_RESETTABLE_INTERFACE);

If anybody thinks there's a better way of doing that let me know.

-- PMM


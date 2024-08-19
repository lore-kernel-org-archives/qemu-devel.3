Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A16C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 13:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg2j5-0000Hs-MY; Mon, 19 Aug 2024 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg2j2-0000Gd-BL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:47:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg2iz-0003tH-DD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:47:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a2b4so278654a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724075228; x=1724680028; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SW0H8Ghm2HVoUmXlM0Qwjh7ymocmgQj5WEzGHKt5/XE=;
 b=LrBPd7xkQbxM1V02WbXC2/nelrS5XH4bqLAZtF5bT5W3zPKyambZlL3ZbW++k6Wwvx
 BM4WFLTRWvuo1mO0swIaWW41khgUdYJ+MXvKxdLstciOVZAl2hoKmKtkMiroJw8LT9Wr
 P9d3Tkf4QUi3kHSKcgTA2XDAJZfuTXUPH4SZtXNe7LPJaHJ26ehWnh4kOwRL43i+t3yJ
 hqSoez+YQh49xpY/GVcLzcO0eZLeIMYejsPIEC/pCWhqec1VPQahhv7IknFfvADghLuM
 J7qc61HbGf6yhK17LjAjq1fIZt8v6kpqSRH+BVznJrUeuQ+vhxGWNetYiS8pvCZU41JY
 B9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724075228; x=1724680028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SW0H8Ghm2HVoUmXlM0Qwjh7ymocmgQj5WEzGHKt5/XE=;
 b=YqTvaz5AUONd9hc05qE7vxVuW9MBJGtzmkUSCZXrQDTrnZwVKacrIutHG1Uhb2olOz
 mxhHBhe7aJrFYUzc7KCDsrc89gsp4kZjD2iuBlkcGW82hI3o2yg3gFkgCISNt4DVaawz
 vSSLR8i9KVuFnb8WleHe2/6ynOpu9UXVljnjRKC5dUlKrvJ83SizywH3bcQUQ+nIPmIJ
 1v6Eqku4bKN8ComN+GKITtNQ/zA1Ry2nkx/yko8SlXMDCl/Bw0l19wLu+pwRiL0c9FTZ
 mOS2K+NChYl9efW+7yrlNk84oMo/wMhNmR/y/+S64lbDE0b6M4bBeNoikHAC4zdAVijl
 1fGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWh4gLFLHbY9DuvESgeu+l5YOpJH91ADF7L4mm1rH3AUDg+BV1GDNbmlnAraTEhJ2b7X4pG4k9A5spEm0lvhdvsVJfIUU=
X-Gm-Message-State: AOJu0YzBgVxobrSYZI0BQj+eb0+pL97W4uqIT9yh54kf2Wvv1kRzqoZ0
 X1TwxQG5+3AXV6qUyMmaQEC7EqckgXBWB80M9ZuleTZO7uU2ODgNkuRDeuce7mYwpUwDjQlfRJQ
 gUGMZOC2A3rc0yaSTBEOez7co2CDbJpww7Gjmng==
X-Google-Smtp-Source: AGHT+IFhqm8I3foBBgQZWECesTy1DIPDLieO0gg49gL507EiNCJfYWu+TqXqEJ7Dw+/xIjrO6J39EaWpN/42D5FX0gI=
X-Received: by 2002:a05:6402:1e89:b0:5a1:4ca9:c667 with SMTP id
 4fb4d7f45d1cf-5becb5edc13mr11402103a12.11.1724075227465; Mon, 19 Aug 2024
 06:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
 <0059c598676a4b9d8e34b9c0dc62b09e@huawei.com>
In-Reply-To: <0059c598676a4b9d8e34b9c0dc62b09e@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 14:46:56 +0100
Message-ID: <CAFEAcA9jm8RD0FF4fo7YPCHwaC9FwEG0q1EYce-OmrD1J--iWw@mail.gmail.com>
Subject: Re: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
To: Salil Mehta <salil.mehta@huawei.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, 
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, 
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, 
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, 
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 19 Aug 2024 at 13:58, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >
> >  We shouldn't need to explicitly call cpu_address_space_destroy() from a
> >  target-specific unrealize anyway: we can do it all from the base class (and I
> >  think this would fix some leaks in current code for targets that hot-unplug,
> >  though I should check that). Otherwise you need to duplicate all the logic for
> >  figuring out which address spaces we created in realize, which is fragile and
> >  not necessary when all we want to do is "delete every address space the
> >  CPU object has"
> >  and we want to do that for every target architecture always.
>
>
> Agreed but I would suggest to make it optional i.e. in case architecture want
> to release to from its code. It should be allowed.  This also ensures clarity of the
> flows,
>
> https://lore.kernel.org/qemu-devel/a308e1f4f06f4e3ab6ab51f353601f43@huawei.com/

Do you have any concrete examples where a target arch would want to
explicitly release an AS from its own code? Unless there's a
real use case for doing that, I think that "common code always
does the cleanup of the ASes, nothing else ever does" is a
simple design rule that avoids the need for target-specific code
and means we don't need complicated handling for "some of the
ASes in cpu->cpu_ases are live and some have been released":
either the CPU is realized and they're all valid, or else
we're in the process of unrealizing the CPU and we get rid of
them all at once.

thanks
-- PMM


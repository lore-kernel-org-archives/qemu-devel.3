Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 13:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg2g2-0003pF-6a; Mon, 19 Aug 2024 09:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg2fy-0003kY-HN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:44:02 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg2fu-0003QJ-MD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:44:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a83856c6f51so211561866b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724075035; x=1724679835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZSQvibo+wu7IP70i5D5poEBqcsjxx4FufbBQPXg2lI=;
 b=u5i0jahyXZqBn+UtsNnGCXFP8XmWQLuN8v80GKxXOhv1eiYteg/353utVSOKFEWvTC
 kyrC5Q+TjMxg5xnJgtJrP5kM2ep4KUnoYDJtEr4t5LU+VqwuwCXOqP7nxDiul1H45/ge
 vHNxiYW3uhw1fjsZkOdXQYgACDy6QEB5Y0Y6vN7y/+R+By+t7vycJuGdpNv1NZfzd0EA
 WtXbP8JziLH+wdIkLmm+TFeZUmt3B690W1Y5ADKuRd+UvOU5ekzIy/9YksFCrYLDqb8j
 u1RdX8G/FhK7deZr/Y3hXOglzvZkD8/mUK0b5+Knw1zmozPZIL1TZD3JDKbOVAyxEpiF
 GveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724075035; x=1724679835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZSQvibo+wu7IP70i5D5poEBqcsjxx4FufbBQPXg2lI=;
 b=MIAeNlh6eFsPsIWPXv+0avwkfGaIRPSCYHvWeKyOh/6+Xdf3qWP+ZEpZrGfru1hYwT
 yr6Ij8YMgiRhZr+C4d1PE1FxUEE5iTh54PJ5vlzUI4mYcHDiXNVCQnzFVWew+i56Mlrl
 BTmktesrH8XuLtZLLSD6IEXLWobsfxvf5MPP6or63qC69U5AO6AjCJhiwVHtqQmrOpV2
 nC2qAbBjUZ3S9LHhRl4edomxVBDDxZHsudq5CdoHrCF5t6H67K0WJx0dZGwMp+utGozj
 mfLAWGZ9XtrYUI4ylZvyix+Kc6pGlrKqt0kx0osAPHEa6oMUAtgKQfT6OyMzal1ZBXhW
 /Ukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY5dKg5gdksrkio1grM32fIZq8tWPEPKws6fVX6vfV+lX17jjngPY8caF5a82RirkH0NfwmVM/5/WAyMrA3VknC8T8ItU=
X-Gm-Message-State: AOJu0YyUnX3OFJvuIyGiVZZNaRGm5NvtSA98skCmIieZWZJxNc34xXCY
 fb3vWLogr6G4qTrKlPUVkMtsF7jYky4biJ8pHnawgYo2Jo6OlZKe2gmAOOqVXq50erGRd7IZ2oM
 FdMSIICp2VtOn3Jl2eg5A7NBzj9PhLv1LOh2Y0A==
X-Google-Smtp-Source: AGHT+IE+UM/rUhRkNaD447GoOLYwr6ZmGyRtTkZgMo4wJzir2YNTVhSAMrIzK0HyA7lZcTGfiNCg61kSuf943QzgdEQ=
X-Received: by 2002:a05:6402:84b:b0:5a3:619:949f with SMTP id
 4fb4d7f45d1cf-5beca8b7a70mr9704051a12.32.1724075034825; Mon, 19 Aug 2024
 06:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
 <CAFEAcA99RF2tY-9DfhdkCxrR=ayEjJYKEQ4xZSn3BBrXdOjU_Q@mail.gmail.com>
 <8cfd576d650c43128e9f1015827ab66a@huawei.com>
In-Reply-To: <8cfd576d650c43128e9f1015827ab66a@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 14:43:43 +0100
Message-ID: <CAFEAcA9ohibzUMwKsZz4Nps9Q-74jLM5340esS+E+TejGR+DNQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Aug 2024 at 13:59, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >  Sent: Friday, August 16, 2024 6:00 PM
> >  To: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >  On Fri, 16 Aug 2024 at 16:50, Peter Maydell <peter.maydell@linaro.org>
> >  wrote:
> >  > We shouldn't need to explicitly call cpu_address_space_destroy() fro=
m
> >  > a target-specific unrealize anyway: we can do it all from the base
> >  > class (and I think this would fix some leaks in current code for
> >  > targets that hot-unplug, though I should check that). Otherwise you
> >  > need to duplicate all the logic for figuring out which address space=
s
> >  > we created in realize, which is fragile and not necessary when all w=
e
> >  > want to do is "delete every address space the CPU object has"
> >  > and we want to do that for every target architecture always.
> >
> >  I have a patch to do this now, but I need to test it a bit more and co=
nfirm (or
> >  disprove) my hypothesis that we're currently leaking memory on existin=
g
> >  architectures with vCPU hot-unplug before I send it out.
>
> I think you are referring to this patch?
>
> https://lore.kernel.org/qemu-devel/20230918160257.30127-9-philmd@linaro.o=
rg/

I'd forgotten that Phil had sent that patch out. My patch
is a bit different because it refactors cpu_address_space_destroy()
into a single function that destroys all the ASes (and so we
don't for instance need cpu->cpu_ases_count any more).

-- PMM


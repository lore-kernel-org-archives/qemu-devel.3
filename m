Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA737CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaxY-0001hj-Jh; Tue, 19 Mar 2024 11:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaxV-0001gj-SD
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:00:57 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaxS-0005jg-Pt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:00:57 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56b9e5ed074so847855a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710860451; x=1711465251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fZqLyluTsGJJhdPNFECXibPDvD9MpYTWMqyUQCKVBpo=;
 b=Qf4tYklDOqM04m1PxYjn517Rl35oYkByskNd8oUXp8xTcwVtM26+AadW+rdCbx49X4
 Y/kDVieSRhMMrmzi4teuAbQXO4wzpAx1utEsbKmAmH1ZaCa7FAxdvSa4G2FS6RUgSj68
 ffd3SXbnhxCD8cWdoaRoYRdYr5CrI4dmU67rPrKh0SgQuyYMPZ5P3wHIEptCZT9ECOVn
 uTdhtKyOFEN//MpSq4I9+P3zbr6NY87LuGFHldfgS0mARHtSklI4fI9ZGdAZHhlNKZ2m
 fVXVZp4kJQyPmWLWXy2IipYAJByW/f6Njg2TW+gXwu4hNs0yERAy5WRBVE8pTFzBKGzL
 hgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860451; x=1711465251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZqLyluTsGJJhdPNFECXibPDvD9MpYTWMqyUQCKVBpo=;
 b=BjBV9uqJ1s6q/sU2s8u7vmn41kdMnJKlSyWlqQp/0fifAFHRaGAXbJsadOI+GVjod/
 CrmBLE8Q/Lk7uR16grNwzyNa163XX0/WsDmifFqVb639EZ4JKTqTHDtZlYuZRH4vJWI/
 ejIZk7JeDKOMASfe2gzypRpcvS5cuSj6EmOagjFU9XyAZ/yhyT0emdSX+sjuT/En3x0I
 ICu2AFTgOcKxzITAEfvBQEi1E+AxceVBhJDpVXNrPtc7LdNVusLT5i2gRDCaDF7lMEj3
 9cO15E/dRshTd52WgKhhZp4I/nFF5q+7AlUUTTTa7TjIKUDWexE9v+UtMY/SyiDGWam5
 TsFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD/HeBbYFGiRLk9tHXkkh1cfYi+vVKlTakowZyTVFj+XLVpEQOu7LRbT5lawDTXF89w/bQyO1fVqfAQswhU0EOt5QRyFQ=
X-Gm-Message-State: AOJu0YyusL0RvCc6U0ioPI/Mi+hMtdMjwhnhfpg9pgL9DzjDOsUSeqMq
 RYRXA7ZQQl5U9PyufrF6GwtL8cL+j9E5mWSNy6e5DbOVVIyIN01GmkK9oAznd53RhGq4IQ82ubc
 BDcW5NZ0KMiLZFhsrCNK/Evz/qy9sH+dB2WQ/uA==
X-Google-Smtp-Source: AGHT+IFiWNwH6XuqKeHGG4tD9CH7BW4gY38AfHIAyYdDprd0X0UL9RqvdyNtqbXp8sHG7ZtytHMVS93WuJgar7smzg4=
X-Received: by 2002:a50:ee04:0:b0:568:a4b6:9828 with SMTP id
 g4-20020a50ee04000000b00568a4b69828mr1779194eds.30.1710860451616; Tue, 19 Mar
 2024 08:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240221063431.76992-1-shahuang@redhat.com>
 <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
 <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
 <CAFEAcA-Yv05R7miBBRj4N1dkFUREHmTAi7ih8hffA3LXCmJkvQ@mail.gmail.com>
 <0f8380d9-bdca-47b2-93d9-ee8f6382e7f1@redhat.com>
In-Reply-To: <0f8380d9-bdca-47b2-93d9-ee8f6382e7f1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 15:00:40 +0000
Message-ID: <CAFEAcA_dQGfBDiFCm7PUmvDrQtp1UK9HqkkV0-5x8fb-svYDYA@mail.gmail.com>
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Eric Auger <eauger@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
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

On Tue, 19 Mar 2024 at 14:57, Eric Auger <eauger@redhat.com> wrote:
>
> Hi Peter,
>
> On 2/29/24 12:00, Peter Maydell wrote:
> > On Thu, 29 Feb 2024 at 02:32, Shaoqin Huang <shahuang@redhat.com> wrote:
> >> I was trying to add a test in tests/qtest/arm-cpu-features.c. But I
> >> found all other cpu-feature is bool property.
> >>
> >> When I use the 'query-cpu-model-expansion' to query the cpu-features,
> >> the kvm-pmu-filter will not shown in the returned results, just like below.
> >>
> >> {'execute': 'query-cpu-model-expansion', 'arguments': {'type': 'full',
> >> 'model': { 'name': 'host'}}}{"return": {}}
> >>
> >> {"return": {"model": {"name": "host", "props": {"sve768": false,
> >> "sve128": false, "sve1024": false, "sve1280": false, "sve896": false,
> >> "sve256": false, "sve1536": false, "sve1792": false, "sve384": false,
> >> "sve": false, "sve2048": false, "pauth": false, "kvm-no-adjvtime":
> >> false, "sve512": false, "aarch64": true, "pmu": true, "sve1920": false,
> >> "sve1152": false, "kvm-steal-time": true, "sve640": false, "sve1408":
> >> false, "sve1664": false}}}}
> >>
> >> I'm not sure if it's because the `query-cpu-model-expansion` only return
> >> the feature which is bool. Since the kvm-pmu-filter is a str, it won't
> >> be recognized as a feature.
> >>
> >> So I want to ask how can I add the kvm-pmu-filter which is str property
> >> into the cpu-feature.c test.
> >
> > It doesn't appear because the list of properties that we advertise
> > via query-cpu-model-expansion is set in the cpu_model_advertised_features[]
> > array in target/arm/arm-qmp-cmds.c, and this patch doesn't add
> > 'kvm-pmu-filter' to it. But you have a good point about all the
> > others being bool properties: I don't know enough about that
> > mechanism to know if simply adding this to the list is right.
> >
> > This does raise a more general question: do we need to advertise
> > the existence of this property to libvirt via QMP? Eric, Sebastian:
> > do you know ?
> sorry I missed this question. yes I think it is sensible to expose that
> option to libvirt. There is no good default value to be set at qemu
> level so to me it really depends on the upper stack to choose the
> correct value (depending on the sensitiveness of the data that justified
> the kernel uapi).

In that case we should definitely have a mechanism for libvirt
to be able to say "does this QEMU (and this CPU) implement
this property?". Unfortunately my QMP/libvirt expertise is
too low to be able to suggest what that mechanism should be...

thanks
-- PMM


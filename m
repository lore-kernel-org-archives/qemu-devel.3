Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA499CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOFm-0007CQ-5x; Tue, 19 May 2026 13:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPOFf-0007BL-3Q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:29:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPOFb-00033J-HK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:29:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso44285395e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211740; x=1779816540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdDxCKsR0fJl4EJ0tv2iInGhZZkRr8JafcQfuDNdDy8=;
 b=sDKInW+9jjiZU124QNlL+xkkfYvKVndPgr0MZf89Bhb0KtzZEaAQeDo/noi8ggQ13O
 lVQY5ND9XWhHVvxIwSHXbOPy1sqxeWyEJsiaEi6WdgXRB4sDpJkyC77sn8qTSRL2CCUm
 dQDL1PrrnHG6+Rzq45J9Lmb9bet3o/+NNp5kPxTvBotXPfeqmtTpUdkcemCwoxb709Vb
 y6Bez9pLBPQZnvDJCCwhV6Q33WbwZN9soWDKvYC0zDx8dLks6vkhDE/TydiF1qk5937L
 Rzp0U7fTyh9rmyZ19F4mfpo8Lzbu4anmhhndxr+CgLWYLFMSWHRsLZahTmHbsq37XAcC
 TlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211740; x=1779816540;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdDxCKsR0fJl4EJ0tv2iInGhZZkRr8JafcQfuDNdDy8=;
 b=TpDx53kkrRzrBgVXHRWFWRqzcE6FOcLMZ+R4YXmtYP6EVVoj5n2TWRaDK3OQBP7d32
 b9110clWPFFv9sLi/+CCMyYgHiMO4+O3xtfa+BiMRMXRg6KjllLqfMaB1pccooexiwA6
 3nSxQN+6E0KoG3yzxfPPq76dTXkV3piJJ9M5uqKTvWC3fSFNVA8mWml9IC6kF2Ig5sKr
 1kY5auTCitDPx/s1Y3h9FczaSZA1XQ98miHlmlilyz8KMEfU9MgE3Oi7SjMS6cpN182a
 rWKLGdZ+djFt0vUHLZtaagYrUadglpmAktpAZUN9hxLeBPdi8JRV6Q3NpCsLWalm0wYI
 UkUA==
X-Gm-Message-State: AOJu0Yw28Ev4FhWZRkosO46vK8M+RetCzROwGLQWuWXkQIsjXhQ1SZaU
 0UZPPFJeQEWy9y7bZb5M4eYqT0B8gMxouWl46ooSk1LnDUQ0hqZp57gRUOeMaBBvhmQ=
X-Gm-Gg: Acq92OFgEWQ3XZxOLX7a5D79J6d1wYUg0yFKcv044LoD3a4gsqP6ehCRY5uvWQ7BqqA
 nanNGt/fTNPK2zivruF7P4CsktaVeA6v8pRSemn/cOozF0g+tSmZ9bD72TwaNXZtglqS8v479In
 MZ8Ox2zfPETPFcDDBU5Ougheon1v8QA8uX/xJEazPqfFPqyAAtoJlHtFRNG63qzTRkcXLoQv6cz
 XQ1FohzJZzMZj5vuPWX+bNTNAsizXgsQwSjPXoP4c0K+sDh+AZ+TwBMdPwnvHVItvkCTWWZsmf3
 6GUmI/QBbd4zVcsp/eL1kw0T/HLo1+FqUMvI31Oktk/H5V2ED1VgEVQpRaaN3STM/6XhuQbBalZ
 iJ0xT7/p3PgcxsM2Uz27Kq405RNn1RspZotFN2vk6nyTxLAvdgzTsWnSFkGRNVMfsyu2N+TNgmA
 1cgvaMVDQInmlcdH96lazN8Rg=
X-Received: by 2002:a05:600c:4e87:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48fe60e142emr331701765e9.5.1779211740345; 
 Tue, 19 May 2026 10:29:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm372207145e9.7.2026.05.19.10.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:28:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 844B05F8C7;
 Tue, 19 May 2026 18:28:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com
Subject: Re: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL
 display
In-Reply-To: <20260519164818.22982-1-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Tue, 19 May 2026 13:48:18 -0300")
References: <20260519164818.22982-1-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 18:28:58 +0100
Message-ID: <87wlwz9ulh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> I don't see the r-b on the patch.
>
> It's on the v2 thread for the same patch (then 1/3, unchanged content
> in v5 patch 1/4):
>
>   https://patchew.org/QEMU/20260311022752.64192-1-lucaaamaral@gmail.com/2=
0260311022752.64192-2-lucaaamaral@gmail.com/
>
> I'm not familiar with the convention here -- should the Reviewed-by
> be re-stated in the cover letter of each respin, or carried only in
> the patch trailer of the next version? Will do whichever is standard
> in v6.

Generally you apply the tags to your commits so they are carried into
the next version:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#prope=
r-use-of-reviewed-by-tags-can-aid-review

There is tooling that can do this automatically for you, for example b4
will gather review tags and apply them when it pulls a series.

>
> Thanks,
> Lucas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


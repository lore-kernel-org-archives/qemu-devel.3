Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D81C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJqd-0005cx-AK; Mon, 13 Jul 2026 12:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjJqa-0005cT-TY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:49:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjJqZ-0003ua-8h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:49:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso367002b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783961373; x=1784566173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qToaBqr8yScdoonTFBAyN5vGO4aBuDawn57mvOUuIY=;
 b=IicPSQlJOmujDJlDOPN+9vU38eysLhZX3lvcBJltyzngyWAEsfvtYfhwXVASSH71o3
 UkE1uzdLpNzRNvGqSJqEDEsFz0/J3+E/n85fJOWnMe9AzFeRXh4UKDKWnKdjzLrbbdpG
 QPKewrot4QxqvTnITBMZE80Aiee94YndIsZPTAVTf6bFivRvA2qfZMJJvjGiA47GQ2Bq
 96E0II6EeVskSAFok7E7Jg2+6aJSdVpTvrU6TM2N+Et2OXWgkilTrqNZoiVtMeoy+UpX
 LRnRU0DMr7ZU5Ilw94XXjWvfMuq4CY2F1Os6jVnu8OP4In5g20RKLpr2noU8a7JBTG2m
 x12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961373; x=1784566173;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6qToaBqr8yScdoonTFBAyN5vGO4aBuDawn57mvOUuIY=;
 b=lCZQbX7SMZMSH99WZMMvSDcpJNczKu0E4b+BQNavpFl/HcTT0EVlrHtMmYtClvvJXt
 eabcxCm+se6jzS7wljt8q7QnaMsSGl7PYAVNpmo4Eoc76xeg1o4gs/Y5KNYeiSZiASnu
 AyCqUH8Yi+3JQI/JKsSvOckn5f7HjiVYK+KoQvWxmWivbhaxs+/00QlB7auM2y25a4ao
 9bETIDE9a+KXB1VZk6DXTQK+Oq1KxQ+zECpzNwSoxDqgsfojDDhbSS1+X0+K5Z7Av5jY
 9Ckl2ro5LTMvSAsOUIOPiDcD2BzTgx+vFaVRhBHRHPqjUI8C8KeoqZC94KZuFDqGuTel
 sTvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFgiGFOF6X8c2prVSEI31RbWjAA+57IWy5wTMt23tlkhuZUDTqxGG+IgXycc270ZZQ+VSItNQQ+SOt@nongnu.org
X-Gm-Message-State: AOJu0YzoZ2kIYqy/65b10BDKQ+PlIFq20n1LCvhelk2PQqsxZpJsNbqU
 XHGTdGSJ4nqVTpF1LLwcuF0b09DfFaoz/Q/kk6Rhd/9HvR3n7kO4UxVHI6hlW2GiYyo=
X-Gm-Gg: AfdE7ckgpgnMsnwVTvqIFWXQMESR4+fZX3xWxYXRFByfflnu7Mr0qZokH6O5s/g/pQu
 JjelHLNaBqtUvd8vk/BoRsCGcjtwd1rFmp0zHvIbsuvjeAgSCq4hD5H2Anb5Qlb5me+plAr7mnN
 y6so285YOGLHMKgeofgZ15JmSWKrTdWc0KE2i59sGv/fVf6/kGqXKTDWts4J6ZZmS0Dq8NrRt/C
 a1nNd+r5vPA68F0MZqxRg7/75scR90nHfZsmDN5iLtly50W3SK0O7UTYxaxqyolUs4DEfUJf7kJ
 ZPNsQISUjS05DgsaY2VuQ6GbqBiyJju3iDLm8jhWASxBsLaBvL7+sa3CCCgMWHDhM6BDY9reH2O
 2l2vLKtunfjsMpw/dz3cFWqwSO9xhSFOc0+LzZrhJKFxBPgHCLLiA6onh73LYiqukIoSB2EvvFm
 k4nruvSGcwlF+10op/meFafl/DH0UiigTIHD6l
X-Received: by 2002:a05:6a00:3e18:b0:848:2f84:f426 with SMTP id
 d2e1a72fcca58-8488976b6b6mr8904036b3a.63.1783961372764; 
 Mon, 13 Jul 2026 09:49:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f29ed3dsm131115b3a.27.2026.07.13.09.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 09:49:32 -0700 (PDT)
Message-ID: <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
Date: Mon, 13 Jul 2026 09:49:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260711223707.42139-2-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/11/26 15:34, Alexander Graf wrote:
> We already have two ways of creating a QOM object with a parent set
> from birth: object_initialize_child() for objects embedded in the
> parent struct, and object_new_with_props() for heap-allocated objects
> that also want a list of string properties applied.  What we do not
> have is the plain heap-allocated dual of object_initialize_child():
> create the object, add it as a child<> of a given parent under a given
> name, and hand the reference to the parent.
> 
> Board and composite-device code that heap-allocates children today
> therefore either open-codes object_new()+object_property_add_child()
> +object_unref(), or skips the parenting step entirely and lets
> device_set_realized() dump the object into /machine/unattached.
> 
> Add object_new_child(parent, id, typename) as that missing primitive.
> The reference created by object_new() is transferred to the parent's
> child<> property, so on return the sole reference is held by @parent
> and the caller does not need to unref.  Later patches build the qdev
> and per-bus creation helpers on top of this.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   include/qom/object.h | 25 +++++++++++++++++++++++++
>   qom/object.c         | 13 +++++++++++++
>   2 files changed, 38 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +Object *object_new_child(Object *parent, const char *id,
> +                          const char *typename)
> +{
> +    Object *obj;
> +
> +    g_assert(parent);
> +    g_assert(id);

Of course, typename can't be null either.

But it reminds me that gcc and llvm have attributes nonnull and returns_nonnull; we should 
be using those, both for their Werror and documentation values.


r~


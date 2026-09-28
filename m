Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBwp-0005bc-N7; Mon, 28 Sep 2026 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBwZ-0005MK-PB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:03:05 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBwY-0003Hn-5S
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:02:59 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-6729c4030f0so2704117d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790604177; cv=none;
 d=google.com; s=arc-20260327;
 b=gGwNTE/afL3CDr8UpvofEZ6m5bK9dTVzJvHzHriuxTkbi1Sc9w+6TyzprpnyqpsRzB
 w2uHkfAdsAkV3MkKrB59pd3s0KGCVoaMIYpeyKP275WT0mitC5F72VbwMoTtV9AV4U5K
 XN7FcQQPTMt5SV/GE5JDMcUEvlymWR7FAX53Xw6J5AY30JSyc1l8sVJuJALlNzuQ7w12
 0ngCbUwtCJKnS5gZ5stH3R7b5pLj8o81nXaG5oOCS1gBxNUpF9gqi5Y7a46nws1hHiGS
 n5xYRkaEWs8DbD3EkK9bPA9zvMjFBsgSruGT0PD97wAhQOaRAgKXViqLuf7k5i4ij2oz
 aEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5H8+aRjOJyHw9CwwFX3FDF5Rx4SDXt3f+5AC3pugOe8=;
 fh=ub/zH6y+WPJijJytJEhlCd5PKbYleOIQ1GJXfRlIPlM=;
 b=VWMoNW/94bBWI2fmOkIXxmYQmfx5zd9wcHrAmH/i6Ta+Y2K1oTIsn2o/PHS6yrqJX1
 Xt/n/KtMwy1a7QvFof9otq51PRf6BggFoXJ52HLXk9GwZTc5JGjyI10cRCLP5HPTeZIG
 6r1CM7UJ0sPpwCze02hYL3umBUFjIp/AV4Hpzwa4x8fOnL0MWGwQjRlH6H8Ui11zV8n6
 qyw/EvHvqBwKLpqtftx9aCSnZ8nhkR0YShLaM6u3HdFAxjOARyp5J12IZ5dWnJQNEgIZ
 /fnjKFFA9pfqsXIdf3d8uDv1zej8kBSojUk3V9YIEYi24j9MpSGhWy9SYenUaeOHoApu
 CQ0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790604177; x=1791208977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5H8+aRjOJyHw9CwwFX3FDF5Rx4SDXt3f+5AC3pugOe8=;
 b=iatUL8ARfVsb0I4SSKkCOholul/gSFXRFu/Rc4wHt8vOihLJGWr92o/TvvFYDPT1Rv
 Tc9iIE+/wjvUrpRNy1b4XUENbMi3MrSXm6TmhpUDQ4VkVTS4+M/K9ZoCgqEYvuWRVHRU
 BScKUOwtgvpYDR1rN3VvDvucLnV/ovV2QR8vCycUIVyZ6fdMAgSHlS1reyglDrryGJU5
 MI+rx2+0buoXOOg419i/cFXDUgYDW4T7voCgOMvh7RAFypEi++KAqyIL2KwoYLLw3RV9
 D3LmQd+uaDFSDAmvxPdrOQpbAfMyFA3mBCUx3cZ5ibrJthurRZoItomljuFV3I34i5Yr
 Rh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604177; x=1791208977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5H8+aRjOJyHw9CwwFX3FDF5Rx4SDXt3f+5AC3pugOe8=;
 b=tJ3CRW19tQ9BINz3cmp0TzZ2Ab5d91ZAkLe+1kie3NegLpCJjWh41kAACcStENwdWz
 6pf1Kj23oi6vB01W1pr5d5Ur4VVjG3InSwmau1IxdI0OgeMc76z9oIhg7HMcGyilHVNU
 W1lAlcaH7Q4kzLGM+MjPi7qNAJgFk/zLidmodVbNbfIe7p44MiPFazFSA1ekQLuimtjm
 HbXeN7YskkKFM7ZfoD//6DeHpVoumMNWty5tH7v7NPKcsIyestpgjNal+LQMqXXdY8oU
 fPF+4kpF5kWQtoGjC4EMvjC3cEoIeIvpCSoqH5Z4BBxKTIZE434W7AZF7e0wOueQf10b
 suvg==
X-Gm-Message-State: AFq9FYIVAHbVxS4BuboJbJKG1GNLLzpW6OpNRT8KTojZNkCLmT1U1mw7
 AewDlPAb9FyPRRpJp95iQ4HAZyeR5UI1oPl9ZmIyzYkB332/5EsmzgjvrvmeMtGyQu0uqQ50CKf
 YwYA5PUDk2T3FB1FSqbi1EgZYdk7qjPweZg5QUeshj/mVcIFmVC3u
X-Gm-Gg: AYBFou2J3Wj/KB9CR8lD/rdaESSOZyYyewaHKEjI5NNxzNHBSpzpCYezr8ijGXF4f2y
 YxxznY+4QBZmQrgCZ4oFvPhYDMIdGUba5DpeA2N/NV0C5fKo+cLU1OtFEYjkPGn8Ug7NbgdSOt0
 597ACb+jkwlJsXErZCBtX/hxvroaU1pNetAwXQIaZ0skxQyREG+Y2Yiw5qIR54jlF+q8r4+kSn0
 /0dHebbAbE6Gvm7GFOb6KYbEsiD062PFRv+hGksbNCyYnM93P7iWUSQiJpMYIx7ea9R04H1CkRt
 28q6XPr3M4LgZSJbS6qYCgllEy/4h5b9Oojlh5TKz506cVbOGJsrxjaZio7n2NoFg/JDQHioygi
 ecb3VMpyEdpTbSuLhhuO07LtvT0yj92lNcsNHX84=
X-Received: by 2002:a05:690e:130b:b0:675:4565:60fa with SMTP id
 956f58d0204a3-6754565667amr1100226d50.89.1790604175180; Mon, 28 Sep 2026
 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260921142910.1462880-1-alex.bennee@linaro.org>
In-Reply-To: <20260921142910.1462880-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 15:02:43 +0100
X-Gm-Features: AclHuK_zVto8wL9Rci8DBerZ9IVoHkWd3JkQuBpHRHOiZ6JyixXq2jaQ-ZyrRgg
Message-ID: <CAFEAcA8DLweguCk7-9prMKraPcYRC_Sf5WD_07Ke9cLi4R9-Zw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: fix user-mode emulation of
 ID_AA64MMFR0_EL1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 21 Sept 2026 at 15:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Since kernel commit b130a8f70cbbf9 (KVM: arm64: Check advertised
> Stage-2 page size capability) the relevant Stage 2 have been pegged at
> 1 f(4KB granule not supported at stage 2) by the kernel. As a result
> the behaviour of the test differs when run on real HW compared to
> under emulation:
>
>   id_aa64mmfr0_el1    : 0x00000111ff000000
>     !!extra bits!!    : 0x0000011100000000
>
> Update the test with a new helper to explicitly test for fixed bits
> and update v8_user_idregs to match real systems.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Why is this only an RFC? What would you like comments on? :-)

thanks
-- PMM


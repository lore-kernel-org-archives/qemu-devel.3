Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B573C54E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYvd-00087u-U5; Fri, 23 Feb 2024 12:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYei-0006EI-MD
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:44:13 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYeh-0001Qz-5y
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:44:12 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-512e75e013eso1003937e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706649; x=1709311449; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=huUmAK/bhJXRWo6E4DM+CeHMOoTn2QBzs+TkIBIcbD8=;
 b=Ysp3t9y2dAHXDiC9gSYAXHpeAATMVyNKmd0J7EwpdrTC5Cb8MYjW5Kn7Q2AahrkNqJ
 46sZrOADLnUqvzGHWB3GOS5mVkkWcPphQRyGaMX3MTLPB/AAE8s9aefPEst7xn2Cez6U
 7Qc40009HrPoeLeNU5IuV8WKRW+d4P04Da58CWYJJJL4BZoUDbB8JiLpTZSQD/mpMClj
 hPU2V6m49heSdL5MPloFlXp8YnI597Z05kn0nI6d5CKdZjMJMO6P1jzzclZnRFBTdiMf
 9aJbxVquXxFduoCuaUrsJvsCd39UYF7gALkpuCgJdP1EJAfwJ1yoGHHM+Ut3OPz2QW50
 StHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706649; x=1709311449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=huUmAK/bhJXRWo6E4DM+CeHMOoTn2QBzs+TkIBIcbD8=;
 b=PGEeCUwXHFFp24LzVyo9rNX2ttlAmC1Ap/a2APKzicOOniciKz9mXCWJ2bE+KoEujt
 lAZJ0nFIPEXD+1I9URXy8BAWqcADp4MxY4FddQyBKC+lfuvoJc96UsJUPcI5K8Og+rCs
 3/ui7YRn1VEm2ECa+eCln2IevwCWwvquqV6c90+OIMLQKLK+onbJBBY+kGEcyTsqbJ/I
 +PmGXbyTZRwx1NddnKQg6ugEspjkbiAdTuNayJvukaqIZQVbHZUCBzhy0SmeN3VENJ3U
 fuMrJebwPyzlk3L5bPwtv++iDxqOIJXXsbutWpA4R8OidadLDUZBv6ZOCTuqK8pkkqKG
 8hXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIwUX7DKcJG4zbwtqmKGd54dn1JIRmvftxoRrM9fI9OuUkBEv1V15l2huHJIeChaJ/MIGA4cyaPxSltsJrkIuFzz/Eu1c=
X-Gm-Message-State: AOJu0YxhCwMcVqgYTn7eCmsgeHdcX0v8dZMpscmml421ZPE4patZLQ1y
 2CM/BJAnR9Xel29Tnf2xaGcbqdPZOtHX5CAdqO6CwnaCUetlbFlXZs8XWAm7z6z/aCBu0qZBs0J
 U1/Axn0zeldS30EYoQlbRB87fr3D6ARE0QcgWrw==
X-Google-Smtp-Source: AGHT+IHs1yGY/4xezrQ+H5Hyz8b4kEINKXt91a20FzAWewgElw8jrH8lB+X0npY9+5oN5BQJXiwdFRo6e5cxVpQk1Ek=
X-Received: by 2002:a05:6512:4005:b0:512:b3f8:81d2 with SMTP id
 br5-20020a056512400500b00512b3f881d2mr312805lfb.12.1708706649416; Fri, 23 Feb
 2024 08:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-9-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-9-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:43:58 +0000
Message-ID: <CAFEAcA_6EL4268U5=Q9mXHwZBv2NVWc6vuLbYk7d+p8LHMMsWg@mail.gmail.com>
Subject: Re: [PATCH v5 08/41] Connect SD controller to BCM2838 GPIO
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Mon, 19 Feb 2024 at 01:18, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


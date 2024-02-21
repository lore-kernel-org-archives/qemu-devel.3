Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A27C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpV1-000487-9U; Wed, 21 Feb 2024 11:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpUx-000476-LJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:31:07 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpUt-0001yQ-2q
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:31:07 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512aafb3ca8so4078181e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708533061; x=1709137861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qy68062hi+qVwN+KHOV+JTriH7jlbuDQY53A4F9hY0=;
 b=T1cRvkOOUUoWUS2l36kgFtITMjiiZd99MwGOGjNLcpFQ9jjMlu5rvDpZUnhnidRyVK
 068X+mNCfzzZKmNPzM+qPAXc+91oauIaFeEzBMPbeAOmJo4sYEWVGnNK2fw+Nb+xivux
 qzeig8iZ6nM8mjetpJGb3P6kJ1XR3GjhMXIDxMGnWmfzYTbd3EepLJn/qohK8Tk23rbk
 qrwTBV7BuCiehrxaOa+7G013yv7vT4KKGDjfGXrDcvdJzpeSQis10zYDcPaLm7RdbhEg
 UmO8bA6yhyiT3BOMPsIeQGB9rxy5qMfgUOs48/4da+HVa+tf54aekO+7CzEUuWG4+zao
 WnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708533061; x=1709137861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Qy68062hi+qVwN+KHOV+JTriH7jlbuDQY53A4F9hY0=;
 b=GBLBQX66U5nl9VRuN+Yr/JvclXx9Ef7F2BL5TKJUmcbOTEOuXrjv7e/w1rlWfluNC4
 VqGV0qhL2jbzYAZa5a0azS0cueo0m1vS/jY3ZnR9sit6fwVy85IAt01Tyuim0QnX//ND
 lXcIbkEcn4SG3hDpoqoYVXUsEHImRodiSoGBT61x38FckyHYcdZWHirz06nXD3Dq++m1
 paXroYSoaIDJUkpjUG7LPuSGqZPbyHIT6jAEp2l1ECvhQCY4lYle7UCEJqVpy8PKfMwk
 hfM9ig4keivlGdk6IxtZGqL30iCh2DwwRlEvisSjxvVswntzD7SuMiUBrbCR3HdHIqhw
 xPGA==
X-Gm-Message-State: AOJu0YzKljiTuXRJ+IrIlalsuv3DRV+l310FjKAZ2WzwTRCOXPMo78go
 qiHifZreYXDCksEFU5NdP9pRqrvEZIxrD7ntvxgnt3OpuzAX34ZPt1bSrt4TYUYO0r/sSA+wHgs
 2D42WCUdFzOhquaQ8gm0hes2w3SdAWFmlqlKmng==
X-Google-Smtp-Source: AGHT+IGG1J9gb3h4spbShtFMF6luV1O+RI28a11hVzCkts9KfzIcgiVyL4Hf6yLganR+kDnUYzGLIfxYw/vMA9zTs7E=
X-Received: by 2002:a05:6512:31c2:b0:512:d5c7:60d9 with SMTP id
 j2-20020a05651231c200b00512d5c760d9mr1849597lfe.3.1708533060766; Wed, 21 Feb
 2024 08:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-3-thuth@redhat.com>
In-Reply-To: <20240221162636.173136-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2024 16:30:50 +0000
Message-ID: <CAFEAcA-ULfvgoOUo93ZhdUX9d2ggJSojUQdY7XDAxnh2HeoDBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/ppc/kvm: Replace variable length array in
 kvmppc_read_hptes()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Feb 2024 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> HPTES_PER_GROUP is 8 and HASH_PTE_SIZE_64 is 16, so we don't waste
> too many bytes by always allocating the maximum amount of bytes on
> the stack here to get rid of the variable length array.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/ppc/kvm.c | 4 ++--

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


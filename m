Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D8CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5mH-0008On-UG; Thu, 21 Aug 2025 09:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up5m9-0008LN-PG
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:56:23 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up5m6-0002Fw-4P
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:56:19 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e9343256981so1516406276.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755784572; x=1756389372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AqbrWKlyHwZo9tnRayIg/JGIFw10esaUog/82RQcPVc=;
 b=VpgQIwdqXFaPYzDrcgra+iTPiMmlEg7eBH/bEpiylVQQPbhBxOL9XlLkbapU9oCIf3
 iPlr62plq/dyUAIjsDhS+CZW41W8OGRNAnsslQk1je8UrHVgmMJOe3XYz2vlTAIY9I4S
 JMqcH8xZyYzC3ET3tptGNYoF1vxJvrnMDC0XMW+NhASQwDisQCR1oAq/j0zh/M+/ycJ5
 N34EB4XeRKqmYId+UXqvDiXxtHEN8Si70IhFbrca8Z6X7Bp5mvI0U3A4wUPSWY9/nSdm
 C7n1dYa02+qdfrbrty+P+LXg5Sl8bAFhHoVjH4OH2j2DP/+ouMWvnU0Q82zolUwaaZVI
 WbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755784572; x=1756389372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqbrWKlyHwZo9tnRayIg/JGIFw10esaUog/82RQcPVc=;
 b=bzZNvjk0Ra/Xf6783cBkM35jJVDc3I124ZUBGnRV6mNaD9LlQDYJqjR9n1nkn6DG3M
 cj21ujOUCWok/ZWuauLfpFu8Q4+6Ul4MW2v1qhcqfnFYtPG5wRAqx4p7lcVS9yw3ixIv
 /MUZVqBqvrzPCZUX4EVb43GZWaUnl+fqnKVppusUQiasBjmYigR4cDmGIJQGX3PzGz0E
 pvOH7fq0WCGGJY3iIXMyi7qGwbrVoF3Ecls3CTB57Q3IKXftnvbCj1hASBN3OatT3jRx
 zVZ0BmTtwhxOlNP263pNKq5l2f2iU9Mktk6fkOC9fH8hFoJdT7y6NGJ7Hy6xJYvFNUWl
 HxdA==
X-Gm-Message-State: AOJu0Yw1rWF7udPOzCvALRcrIM3wBYftjpPl/t9OgECMfPxpniZRMuDu
 rlor+qvfE/pJUWx2axpPgGtvpMsWi5tkqvmReetHRuAvjyXSOmj4hOVOtAdzo24QG6G5eFGb+8C
 8VSaoG50JJq2hU/lonTQysSMFkSxZyPLHKxQnhK+k2DTYLni6ducE
X-Gm-Gg: ASbGncsjRvGgCcIdHnWGEMNr0aJr3aBWSCrx1/4eEHfSas8WW/tQtGpmyhfBa98/OrO
 EHaM4byhy2vUPLLeXyTV+xZa1QWcNt04hsg20US2ukrl+MG8Ri6CgH5+m7VK47jfI0SuWxzj6VL
 oW7oQKjjRWLVT/OTaEyuKau0TgzXwA+8m92n9pz9C90lxBAHBo/6lUBDLj87q8UbD+pAw0Ca0R7
 4Pehd4pu4hoXlsmT/g=
X-Google-Smtp-Source: AGHT+IEtAOAtl1+0aztrHJbrJeZC1R5FrDgFHXyRBw1xIg4UOBulMf5H7G919UefF13v/X5P8fNyV0qrbhFx6fGczvc=
X-Received: by 2002:a05:6902:1081:b0:e95:188:2922 with SMTP id
 3f1490d57ef6-e950de22774mr2349441276.23.1755784572140; Thu, 21 Aug 2025
 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
 <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
 <aKV21WpfZ8u054zc@XFR-LUMICHEL-L2.amd.com>
In-Reply-To: <aKV21WpfZ8u054zc@XFR-LUMICHEL-L2.amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Aug 2025 14:55:59 +0100
X-Gm-Features: Ac12FXyls2zE9rht63-MvtBIbZZrohweZuamNqZ1UzqD5qGI7JAujRScTp5ifHw
Message-ID: <CAFEAcA-HoghnZLWZLX7zBD=-_mztTQoZLReQRgS5TRE91eRbxg@mail.gmail.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Aug 2025 at 08:19, Luc Michel <luc.michel@amd.com> wrote:
> > It would be helpful if you could run "make check" under
> > the clang leak sanitizer with your patches added, to see
> > if it complains about anything. (Unfortunately it will
> > definitely complain about at least some pre-existing
> > leaks, I suspect.)
> Yes I did that before sending my series and fixed all my leaks. As you
> say there are some existing ones, mainly in the register API (IIRC it
> does create an object that is not correctly parented).

Yeah, register_init_block() seems to be broken in two ways:
 (1) it calls object_initialize() rather than
     object_initialize_child(), so the objects won't
     be automatically unreffed; but it doesn't manually
     unref them in register_finalize_block() either
 (2) the TYPE_REGISTER objects are a subclass of TYPE_DEVICE,
     but the code never calls realize on them. This means that
     if you fix point (1) then you trip the assert in
     qdev_assert_realized_properly_cb() which checks that
     every TYPE_DEVICE in the QOM tree was realized...

-- PMM


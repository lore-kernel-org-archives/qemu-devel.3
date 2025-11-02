Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1EFCCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFWba-00016h-06; Sun, 02 Nov 2025 06:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFWbY-00016S-9n
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:50:40 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFWbU-0004K6-Rt
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:50:40 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63e16fbdd50so3125332d50.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762084235; x=1762689035; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tf7HPurPQUVO4XIcxODnx4U/EPAhlPYI81Dmo6GzdQM=;
 b=tNggC2jTE6DqZ2ky0SiWbicwRPwKULewQGXyFh5m8+3z/AZpBxmSUuphNkOkEaZ9Hz
 Xt3shM+klBfrZoLVfcs0aI3Tvklyr1TYcAOJeLkjmcmux/QdFPJM4f0beA/CLUjVuHTV
 2CYrJflu7v+n0yUsCfkEJds740NK+oQWufAxhaigMhBtLM6DUber4mnPOE3ii7xF0Ry+
 szu7t+rUpRN6T15Pw5tfiaHrKzJKRfhobVx78TyXzEtx5gi+g7fq12nJZll7DP3jvxIy
 Wn7Nj+UEVWTiNoLNqPsHdPbE+fpM4zfV5CpWkMIe3KhaXfUKAg2qF6AILhZCmMb8jNNV
 OTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762084235; x=1762689035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tf7HPurPQUVO4XIcxODnx4U/EPAhlPYI81Dmo6GzdQM=;
 b=ZVgTWfZ3o5GbPlFmqD36tpoNgv0CRIN+qFnlRNI1OKQSaQ7yPFnJioFBng5/ecuSZv
 xJoH53Ab9V1hkZ4RFRd2ymWdyFQCxitT7zX2x7OcTlF3tXmh0TxAYIIcrptVm9S6liYy
 kug5q7R22IjFzX6VMbu6IgWHaM8+vjj870UQLFf59Bmrosk4J+Gdtn/G9Qe4fQWXLxTX
 roCbdrUfqN6cHlA/LdJPlErebXOjuNvepoPY7q8mc9BQo9Z2POzRtzmnW30i4JJKG1/s
 1cZs5iu+PXc21WieSMMpH8slnst9dmZo5gdm8rBoWr6rMUSU15uT5s43sX9eF0SLdQve
 yxUA==
X-Gm-Message-State: AOJu0YyKLCbEJ2BdkgjOEOBrEAsULLqZPbTvRfww1OxngNkTva89IYiH
 GzRAJ4Gn6ntnBrUXYJGAbHKVg5I7etogKXaUgBIadj9FY1obz3PNP9bLTyz8afP3gqwiiCO0hIu
 ZIfp+GH5tR76OTA1ZJOJ60Mx8ZkKhKVpw0RmA5aD1hg==
X-Gm-Gg: ASbGncvcrNro5/ulujMEqytIe1pHSFNUnW3kyRi0PZ/Cynnh9p5u3JvRNyjRMXxuEui
 D/7qZ0d1e7qyM99TQ8cQOe0l2LFkWjLfRx4dJgM+AYHGJoaAeyqTAVKCrD4if/cz+8JkWrJ7JCH
 YCV/mqJhC/K8ElmRjcErCI+dM89JZfLrfZ89HJAT/t1WmFNZIlp2hn3vzeweFDWUmF2MdiLpf/C
 yNNO27mT/z8bGTh7hw4r+zMNpYai/5SeB+frxdVH+tBy0KJIc1K+Hqs6Jllz0qZZ6X9Dj+K
X-Google-Smtp-Source: AGHT+IGJ8WPs6YZdQP4X9msvUBwlvXwujfulCl9zwV7jzYVYyH8VDVTCT9mUlqPtKm0Zt0YjTUrAa4KqDnEhIGdpiDc=
X-Received: by 2002:a05:690e:1c20:b0:63f:aa5b:bce1 with SMTP id
 956f58d0204a3-63faa5bcd21mr2595362d50.39.1762084234720; Sun, 02 Nov 2025
 03:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20251030072956.1194-1-its@irrelevant.dk>
 <20251030072956.1194-7-its@irrelevant.dk>
In-Reply-To: <20251030072956.1194-7-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 2 Nov 2025 11:50:23 +0000
X-Gm-Features: AWmQ_bm9_atzqBSvIETOrogXEGOv3kSpJyfnjaACooDNieYPUV33tI9zXd2BZWY
Message-ID: <CAFEAcA__RHC6oG=3801eS6wi-NDh9b4hC41Z44kpaix+YsphjA@mail.gmail.com>
Subject: Re: [PULL 6/7] hw/nvme: enable ns atomic writes
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Alan Adamson <alan.adamson@oracle.com>, 
 Jesper Wendel Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 30 Oct 2025 at 07:30, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Alan Adamson <alan.adamson@oracle.com>
>
> Add support for the namespace atomic paramters: NAWUN and NAWUN. Namespace
> Atomic Compare and Write Unit (NACWU) is not currently supported.
>
> Writes that adhere to the NACWU and NAWUPF parameters are guaranteed to be
> atomic.
>
> New NVMe QEMU Paramters (See NVMe Specification for details):
>         atomic.nawun=UINT16 (default: 0)
>         atomic.nawupf=UINT16 (default: 0)
>         atomic.nsfeat (default off) - Set Namespace Supported Atomic Boundary &
>                 Power (NSABP) bit in Namespace Features (NSFEAT) in the Identify
>                 Namespace Data Structure
>
> See the NVMe Specification for more information.
>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>



> +    /* Set atomic write parameters */
> +    if (ns->params.atomic_nsfeat) {
> +        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABPNS;
> +        id_ns->nawun = cpu_to_le16(ns->params.atomic_nawun);
> +        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun))) {
> +            error_report("Invalid NAWUN: %x AWUN=%x", id_ns->nawun, id->awun);
> +        }

This error check is about NAWUN, but the condition looks at id->awpuf.
Is that intentional ? (Coverity wonders if this is a copy-paste error:
CID 1642811.)

We should return early if we've detected an error case in the properties.
By default we'll fall on through. Similarly below.

This is a realize method, so error handling should be by
setting the 'error' argument, not by error_report().

> +        id_ns->nawupf = cpu_to_le16(ns->params.atomic_nawupf);
> +        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf))) {
> +            error_report("Invalid NAWUPF: %x AWUPF=%x",
> +                id_ns->nawupf, id->awupf);
> +        }
> +        if (id_ns->nawupf > id_ns->nawun) {
> +            error_report("Invalid: NAWUN=%x NAWUPF=%x",
> +                id_ns->nawun, id_ns->nawupf);
> +        }

Personally I find this stack of checks a bit confusing -- we
are presumably catching various different invalid combinations
of the properties, but the error messages we produce are rather
unspecific. If it's the case that (for instance) the NAWUPF
cannot be larger than the NAWUN, we could tell the user that
specifically rather than just saying "Invalid" and making them
go look up what the requirements are in the spec or the code.

> +    }

thanks
-- PMM


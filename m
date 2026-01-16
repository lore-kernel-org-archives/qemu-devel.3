Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FF3D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgiGo-0007GI-8E; Fri, 16 Jan 2026 06:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgiGn-0007G8-0u
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:45:37 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgiGl-0002x2-8M
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:45:36 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7939e7b648aso19687347b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768563931; x=1769168731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mhz7rDewIG+9h4lDk0O6CJzEtkHyeXxEcY8aiXnyZdU=;
 b=QRGxYo+uIUXngM1Nq6sN8QKlUH/RNhmkfc77zJy1HyFrxx9nrUdfe6Qxj26kFJbuMa
 WbXBhGbAu7tdCbyq9fD7NHcXWFV3GmOVNIthG29brhkCXfWCZbiUpjJrepQHr790naU4
 S0RnCjGh7odlmYJ2ntYTNBpkohU7pRYSNKi2h++74bvuh/fWi+KVQRHEwBA+LLnhtcS7
 SwV95znz6xe350FeSPVhDT3ymOMvxAYZb8vLH81Nu4LxxH8lLDxuNapOtLHoH3lPtvwL
 ZDq5YCmpYi3UkwnkJtqPeILKMNwAq6R0f1Rv1M7qoCCLSJNRidfiO3YZUFxOO0pBnrZR
 vzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768563931; x=1769168731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mhz7rDewIG+9h4lDk0O6CJzEtkHyeXxEcY8aiXnyZdU=;
 b=EgkFWw/AfGjYtGknHWj7NA+jco0WRlS1W+oDBu0mOniZkTzSjT/6BUoVMV95zqRpOe
 m6AvHYArnQlWEwBGFshjzRJgtThwV0/jVxMbZg4k9Agxp3kj/Z3xgSVhZTW/8t4Amapl
 JyifiDW/N/Qm/G2lgLNEsfCh/Qob5lyDBWihZY91lk/cH+l8WssPAvxKUhtz6vNvhTn+
 Ck3Ogn2OxsZj07JAWEIi9uKzbm5zsmrqvhTjE9SVcRbfzd/mvGmu02L/zcljp0dOazZC
 Rxd6+upfYp0o5+tZthYk95D/IDXBGpiXdcPPJ+83goeSBUyCSCmBT/Q4n5ZllkDqw3dr
 5QGQ==
X-Gm-Message-State: AOJu0YyrrAqlxbQaurAVBUQ2l/7oUD1GfepTpMrv+oV4/s7NqiwznhOB
 YkEdu7fmAnhvgVaFRgTfWD6hUbU5Zb6xtGS4FMRzIMgyWQ0qts4QTynncDy1IixTpAk46YN70f2
 sMRIJg89X3VCYMuyvjEh//HjKcxQuRS0TKF94c4wyZg==
X-Gm-Gg: AY/fxX5u1J1hK1/mhOOAVNSBuFVseTtzB/ul0aImNEMTDppJR6SLJLNUqtJ9jtzR4PW
 FBHnBPAuHQMUyj4j+SXnF3VyPih3FDEys0aqv+jC+ZqrpuHh3Z4+hGYS0Z/hZMQwMOkHFYYAs4L
 i+/sOz/2rzY998G3VrNS4JIqSGQ23EWcyXhyZ9XxbRk47GQbJ4J28Mjx5e7bJsZp9ij6XLYaNUe
 YSWEWjnbGJsLgy6M8pJBFwbZQirvmubot/vEqlrr0M60NvuHlf5mY16xTMU1IX1akzIvUfvaVP/
 Qk4oplGbDLs37GnsyPKHXX655+o/C0yPqw==
X-Received: by 2002:a05:690c:dc2:b0:786:4860:21fd with SMTP id
 00721157ae682-793c536b2c4mr19360127b3.39.1768563931158; Fri, 16 Jan 2026
 03:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-23-pbonzini@redhat.com>
In-Reply-To: <20241031175214.214455-23-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jan 2026 11:45:19 +0000
X-Gm-Features: AZwV_Qg22OVyHeaZIi9ccC3QWKv8zncX74ombB7oillcY1oFBMvVLVEYvnP1hSg
Message-ID: <CAFEAcA-CZ-pL_nOSSinZdgmP8NbzuTN0xhRFhB-ny0NkgCfLOw@mail.gmail.com>
Subject: Re: [PULL 22/49] device/virtio-nsm: Support for Nitro Secure Module
 device
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 31 Oct 2024 at 17:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
> Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> for stripped down TPM functionality like cryptographic attestation.
> The requests to and responses from NSM device are CBOR[3] encoded.
>
> This commit adds support for NSM device in QEMU. Although related to
> AWS Nitro Enclaves, the virito-nsm device is independent and can be
> used in other machine types as well. The libcbor[4] library has been
> used for the CBOR encoding and decoding functionalities.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> [3] http://cbor.io/
> [4] https://libcbor.readthedocs.io/en/latest/

Hi; this commit includes a file hw/virtio/cbor-helpers.c which
does not include our standard qemu/osdep.h header:


> diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
> new file mode 100644
> index 00000000000..49f55df3994
> --- /dev/null
> +++ b/hw/virtio/cbor-helpers.c
> @@ -0,0 +1,321 @@
> +/*
> + * QEMU CBOR helpers
> + *
> + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "hw/virtio/cbor-helpers.h"

Is this intentional? Could we make this file include osdep.h
as our standard practice requires, or would that break something?

thanks
-- PMM


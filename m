Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B40F108B8EE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3X6j-0007D0-V8; Fri, 20 Mar 2026 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3X6g-0007B9-T8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:29:31 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3X6f-0008TR-GC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:29:30 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so484447d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 03:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774002568; cv=none;
 d=google.com; s=arc-20240605;
 b=HX9RzriyDaY01/rjp4u9n1Gmhm/WVUjcVA6ONVlaepA0n6TJycvcdFsH+4uabzHMaA
 zTXQbzyOlUcpAAEHnP40YqxDMdtUkraGHk4Ni7XRy1Pd544O3NgOLRv3Tw5+AJUIN6Zd
 Nj++StEVUO5yqlYWh0NlozT2BDMkxwirkb38ZDAp9E9rNw3hZ+qTrMB1XxnekORj95kc
 dxlXmyWTIXqoE3Ua4SrvucKV7TRTJ2E7IP/GPUSDXM4dyAhdXenbs7y9fLq/Grpe/lsM
 QdMC/qVrwJUpHzoFrtZg2wX4og3eTffz8oJSUqR5whf8ec3nupB5z/F14LX7BNDzaqNe
 ZwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9W5HfoALTZvI/z2dioIQcLeYU4oaAhQRPEE3+6K5zq8=;
 fh=WibSQDncNgWSyywKvPHAKYpHRJ63hQ7/by0Ly3U6FhU=;
 b=RJwz4LMI+iQ08MUj91dxP9lVsLuMhyT6Ht/rTs/Lemeqcro+gaeN86YickALPH8G7b
 elnRc8WOcHWuBUq15vDxjAsBCVWicpB2ZdTxJN903iSAWl5Mwr3NxSKeCtzzYo34AXHr
 3JmbyzzPpep/3AUGEEgtivfnsirw+81MC6EPGklJcFdg/Q+cg0hLJz7AWEZ20SA9l2tY
 2Dj8W6nWjvVtCfJKkP7X8MgG54T9anXKg6+6kgZaSaqHWb9KqlbqnoCBzomOarxcjAW1
 PhB1Dc+iPbMokdJJNazRRqos/hZ6UEPEvFtAo+KhIW8j61Bw+3gY7tX/dhLZkFE55sTD
 OKlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774002568; x=1774607368; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9W5HfoALTZvI/z2dioIQcLeYU4oaAhQRPEE3+6K5zq8=;
 b=MK2Cz/tMWT+o7VLVesijwKxHij1nvaBXjGlNeY4vkuc1BlhtwsvsLRLiqCcJvjroMV
 uDcBlQjAGCLK4Ez2DbElNQNxrkLmiwYIExbhXoUD0Er31SvNN7KqWk9Jo4bx4gX0eIEs
 yPl2eSK9K//vK+3bgdlZySPBOMjbwN1qHKTgxgG7wt3nZ5DgYW4aP/lGOXXZXmDGbXq7
 wSGzfmZlDp/y0naIiMfM0KRhPZrbD/IHgeaP4MOJeoegE3VQ24gMC8r+3PFDnDtIBo3a
 jtDzjCZKn+S58BCOtV2wio7Kuh40A82s3eifvYniSztHGXZnx9BdUfjLS/Lc8Hx4lG1O
 bJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774002568; x=1774607368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9W5HfoALTZvI/z2dioIQcLeYU4oaAhQRPEE3+6K5zq8=;
 b=fUblrGbQZmpp+/0jF7UEOOoeRC4d9btvKYKBZIISLVthWTZ95BNS96rm1wyZ+J8zhP
 Pqe84nYeqjwpJW4jwFzl9W1M4WSGaCWiLuyOTXhmo8cBFSp9+2mdM8oeKKb67KrXFAUQ
 EmVJ15dUZFuXuvDm6KA6I30txVZZpuIgEft8U1wQecaWliJdb0BnOZiK4BwSP5z7/Rmf
 ZOLtQ/7fAWKMS57V8ZA6l7jwikyx49POncqPARuSq0/KWaxAXwMWRsSVA8J440TAWhP6
 kCsNoI7U6BguTUzl3eAeGYo7D/rl+EbxrK2A/M/gUnkgz7mJQ/baV/arNE0uLQbox9hu
 Hgqw==
X-Gm-Message-State: AOJu0Ywj2apYKXmOSFfU7eIOnKykdPHUmVChpkAahqym8PVqKDD4+PZ7
 6za/ZGJ7bEyN9HmyqgVKvOkcbJ6RAls9gItO6oetXVcxuOTH0vC62a4lVy2m/nDFdBqTVtUtPMg
 RmlBWOpZB41bfNUQddx0QTHZzCzxBjXp8iPCEK8irxw==
X-Gm-Gg: ATEYQzxbKvIhJBTdExEDEpetD/I7Bab1oX6UujJ5tHKwa5GsmBCaIpiQGsuhYVqksZZ
 fzSvHA/7bq7TmSX7kanJxa19OhDgHbqzaLDZYF4W7qTjvtD070FRDWCs+sANMWd9WRCCbqGPDUS
 Qq8RKUGxXm+TefY/dqVy6GMXhuPUi/xEdD9hIcokFEd+/JRSUSHQ1y6DVqGXIZqavmeJsrfQr8w
 tRGlyh7Fhst2zAkjId23pfB+NwWbf2tqOPsqM4vInpnhqobqfBj+LYV0BLfz2z/OPJ+WsbFF57D
 6h5WbGIh20GaGlfshcQ9emjxT94BreoH1j9oMNpclyDBPnNro/8p0vVUs0dgYs9zRmw=
X-Received: by 2002:a53:c60f:0:b0:64d:bcbc:7c64 with SMTP id
 956f58d0204a3-64eaa6c2305mr2030429d50.25.1774002568178; Fri, 20 Mar 2026
 03:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 10:29:16 +0000
X-Gm-Features: AaiRm50dx1Dvn3v8UzNUVdG5yeIS1g18De0N4ljaxgde168BW5Q_eAU70eOF08w
Message-ID: <CAFEAcA9u7xueFKn8Q_qy34YJ7bjHBmkXKbtmo5_UcwvdiKOJMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] whpx: arm: set of small fixes for QEMU 11.0
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Localised fixes for QEMU 11.0:
>
> - fixes for -cpu host, including an ID_AA64MMFR2_EL1/ID_AA64MMFR3_EL1 mixup
> - add EC_DATAABORT assert for WHvRunVpExitReasonGpaIntercept/UnmappedGpa
>
> This one doesn't functionally change anything today, but is good to have and is a single-line change.
>
> - fix Hyper-V enlightenments
>
> AccessVpRegs turns out to be necessary too. Linux doesn't check for its presence and panics in an Hyper-V arm64
> configuration without it exposed.
>
> Fixing a mistake in not following the QEMU code style and having had AccessHypercallRegs included twice at the
> same time. Also add some more privileges because it looks like guests don't check for presence of each one
> systematically...
>
> - SME support shipped in Hyper-V now
>
> So remove a code comment. Another one-liner.


Applied to target-arm.next with commit message adjustments
as discussed, thanks.

-- PMM


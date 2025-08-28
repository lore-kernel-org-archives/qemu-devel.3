Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144D2C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIX-0007mb-Br; Thu, 28 Aug 2025 13:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSU-0000Mq-3d
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:35 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSP-0005is-Ux
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:31 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d603f13abso9279697b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390708; x=1756995508; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=11pw7bcvcWrcOoQreqilnew5eGpzSO6cvtDbubX43y8=;
 b=v56sjAoWXenXwnfR5FRKf5bNTPik35TJszb5HkSXLm3pnmiwXrSHA+eebf64TponWy
 AdJe99BYFJbkQHR/FwF/8GpF0UMLcjEEBUZQ1/0IZwJJSKqX/6u/WGZMIf95xXYTSowZ
 XdPuHNC37r0oXxrCRcfgu2d+8SAiYFTw6ELZnZitbN0F4STHLOgTJ3BgPmYlL52VNJHp
 bmIeEytPZwAoZewNc5gGU90hgRvQBhgJ3T9sLWHgaOHdbYSWUjWP4z7iSY/eNYQGDnPT
 rYVsKFdcOAzBbYyUBSDNg/FdwkUqqeSO+dCwW9mfDYxCNLt/SvS6HFM4OE06WhoDyVUH
 y8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390708; x=1756995508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11pw7bcvcWrcOoQreqilnew5eGpzSO6cvtDbubX43y8=;
 b=bnI9XUn3ChiOxDNVzVf6s1q6TmgGJv84osGVBH8w2jZb1N5rqmLz5L+NnoWxAcSIkZ
 cHEgiu2Z8bo+BSvxKCnHE0c+ygNJ9O4Ykgp9DZkScB/wVMc9xex3i7FE+oTWpaKs1zXh
 pzkgezwPXjdXGExtjuNc+OkO/oNDnG8YbJWtOxGYpUGE4kMEt7hUR8Fis4BrcSvrRN8c
 W2beNTqmE5gbgOOhSJCdN7Cab4/duE66xe7tMLm3L0Qo0rqTUD2ackWRT1ALzM3RpxJG
 75maII5DdMfFEZBMbfVXD0CDXyJcT++NGomiYiWTcg8QqDVKTPAQhFCsaG9qInoFyWhz
 ZAjg==
X-Gm-Message-State: AOJu0YyP26xC3kekvrC++9JnzafeeSZZIbLZ+7E1Qeu4qjjjQR/w/XgX
 xQaFZVtDuXReIztaI4ttnRGFdyIXn/wvP5R79MIbtJwGOGJljYGJrNbQ5mqzvIi8oxypaPAPgM7
 QtNlRn4PIV49FBHRJ09UwfTqETDJ/dXJhB70IFe/4fgIvF8+amuJG
X-Gm-Gg: ASbGncu9j1AckkINrEG61sMc7YiSFEUFyZklL0Zc+aKKLCOpve8iRHhgDDWbZQmKqwl
 QxRXhJb6tNfg+zgVdcYKC5ivch5tozbGCWVG1y3HTpH7p15qk3/+4OU4qSMXDVLBGW1OdwnMkBl
 6Alc1LhMGwptHgm0ASHlT3cDjd98IWHZL4NHvnj3cuwePErFPEZn73R6Xx38Ru52vpii0PEpFFl
 u6o8XH36tFmzHnvLoQ=
X-Google-Smtp-Source: AGHT+IHcFK2KoYMGQ02gaOapUPnOdK9dzhXEurtScM/XcWuky3n7rAvDZZ+uqbjMCdIIBQRNBztFoN9HCEsQLYp7UyE=
X-Received: by 2002:a05:690c:6909:b0:71f:f198:da8f with SMTP id
 00721157ae682-71ff198fc3emr239085717b3.2.1756390708318; Thu, 28 Aug 2025
 07:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-5-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:18:17 +0100
X-Gm-Features: Ac12FXz2IoImIh3C6M3coL7X7IpSkTyomvGHq-06xdDS0sj1MKzLBQ8REPe7CQA
Message-ID: <CAFEAcA_P_D7R+JHMiXRS0dN-OcVvADOwQUhC9AkO4Ae6cDC03w@mail.gmail.com>
Subject: Re: [PATCH v3 04/87] linux-user/aarch64: Convert target_elf_gregset_t
 to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 17 ++++++++---------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


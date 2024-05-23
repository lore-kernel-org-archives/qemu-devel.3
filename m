Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9859C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA983-0002jm-BN; Thu, 23 May 2024 10:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA981-0002im-5f
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:09:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA97z-0002KI-DO
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:09:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5784315b1bfso1683040a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473346; x=1717078146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zS0Mj1CB83bbYePTvsZqGHQkBJsrCu6+g/Koe38WKdM=;
 b=tn5Iofpn48pmER8Yl/PuO+enGvEKRi9d4b3nWVImahhMtTi2pbEdt/tQ1H4n6ggVCY
 mgF/hiVDCGKPAoHSbbLQVkE/lJ8ONbg9RhPXYJHeO7GQElj+1EjZTXDvq2WXdwyy9V7o
 HEkCD3fnyhFf6cd1DxKYzeDKi9bRE2vtvSqkUchhfl68eIpTmd1zjaakJ/tbE3qN8Ei+
 eHxyIYfDp6QJXfoF0tzuopQ3JWe//VEJxTC4qbotz7wYYyA+bxA/yM/Ih3TPnF5GUJdv
 vCxxqUkR7qZyYo+7OMO5tqbW4kXqEPMFUwsrq6o6aEfr90YugdzwqK2gRyftzUkvKkGD
 wQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473346; x=1717078146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS0Mj1CB83bbYePTvsZqGHQkBJsrCu6+g/Koe38WKdM=;
 b=hwZbdrZ+ZJUOjJg4Jk5IL/lf0MyEUhufEX6uAImkLktfCMktCAivPnvvyvZhGdsCTQ
 Vxh8l1EzpkqgHxKdw14p3l+TmfbG5RkD3SpVEltTmnKfK9X2OCt8IrEdq8/c1HK+q1lk
 CGGBl10J+I1oo8ilVyUTpX9xrpidLRVh6RVwLM37GbmJL18PqYrjHQP2zRZFP+rDFboU
 VfqwdvFp0pyfwaTSst6BU3Xz9f2TZGh3oYS+1CjMQelpCM7O4TsOg5k3n7Rq9W8Webpu
 4/TEZEbxvTBCcIOrCa4R5VJyKdo6pS5JzODOonBaHexj8kluJ+yG4xJ6Uj8dzSKdKeVw
 3UZQ==
X-Gm-Message-State: AOJu0YzeIQkFoLK2kVjdqfPB3MB1JPr0M/lSQ6uONB5GoNmsUXOebMXu
 dCeJSITS3pXc2ZynJYz3vUaHfr469cl3McZDFUjV/6r39jRg/pcR+0CCCgmE2lQdn7Ui20bOIpB
 r0z3MZdor/DHuAcEgqKOF+EvodsPeU5A5+EzaCYa1V0S4gIP2
X-Google-Smtp-Source: AGHT+IFfVL3OBmjrLU2B1T0amNfiVLLlrcSqXwOEWCZpdL/Yv3m0anvmu190/F1zQ5mBZujeFd7lCX8f/KOiGK3QRnk=
X-Received: by 2002:a50:9ecd:0:b0:574:ecf3:f7d1 with SMTP id
 4fb4d7f45d1cf-57843b17d60mr2032550a12.0.1716473345872; Thu, 23 May 2024
 07:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-30-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:08:55 +0100
Message-ID: <CAFEAcA-SVrg1jRb=sEdaDO0+jbKMPQfYe4+LXzYjWAzhEMckQA@mail.gmail.com>
Subject: Re: [PATCH 29/57] target/arm: Convert disas_simd_3same_logic to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes AND, ORR, EOR, BIC, ORN, BSF, BIT, BIF.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


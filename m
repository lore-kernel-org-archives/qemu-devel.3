Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CFE1125854
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N0S-0006jp-J6; Wed, 11 Mar 2026 13:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0N0I-0006PC-Cc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:05:51 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0N06-0001hP-Tu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:05:45 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso145742d50.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248736; cv=none;
 d=google.com; s=arc-20240605;
 b=fI8Okd+FA15IG8vtT3GsqMrThmR0yoNw1cLOtAEgAPhkQPVEYvlQVtI5/JS78OQQ9E
 HXb7R5ddE1Dy7cHkFHAALzxiVgWz+R/7GTnWMw7a3rC4uVk4cJ/RydWZnUmuImJHgGeq
 /QWDakhTtL3g+nkXrRh16t+t4rM3CGqbQZPxgKGMmoIEgtFnUetvWxvqUbZcJPG19lTP
 b+rp80iHOZB2qiknkHGuMHveDN4e+GEs7Z44BoPoa1JhUiWnsLZKgC/UxyblckB/H9DY
 ex2TgYBeqUykk2N2SDVJVKrLkYkQk2Ck89zz0Rg5BzMC2MK47UBRsuj3nGTitAEsDN1z
 q3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s8hhLwgIhU2/sosIgArVE4EJu0fvWf6z/Nekl4sBFGU=;
 fh=q6StGydl/SY888ZIkwkPLi1fS97Df6esIzpIoXWZ2us=;
 b=C+VqTbRo0d+ZID20g7/HR7TcVXrZGNUtZLs4BWDUPxHWoQMZYEuzbE/0zToVt6n9h+
 vVTN09wQK6aVmTkB8N7B60SyPm2CpQ3i/4avUmiY4gmgW1GBu3LeuCOeabECV0iuhTn4
 swWe/E8ZhMe6bge4y4Mo7qp3CPhNnXmT3Eace4kXzAET3NtBKsqXZzojjc07AEOQhMa8
 QVrw8uDPZpsuai/o0/zuQ12ntPqKC7ocW/rs+nsUnjwV5niX0zu0UBz8jUcG4K28TvIK
 zpMZlmDJxHpxD08jRE+QfcFhxbxcge2ctXLEQlgX4MdyiTS1hh3jDwXjB7Cq1g13adYC
 yy6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248736; x=1773853536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s8hhLwgIhU2/sosIgArVE4EJu0fvWf6z/Nekl4sBFGU=;
 b=ukJxvEFMty8wzC0vR8c5b5bBitLWch1ymK7GpYJkIKm+rv8Mnm6lPTKTTQbJlBish0
 ae5w6bNQZvFmMlkWCsuiMKe4NZQmTpsA+uWvAIBIcc1rxtpkT26kWF0fMqwxSSSCDAwb
 MhF3xlefFSIz7PMtjS+ryNq5ROi++ufgXpTXlFm5SSTVKON8yn/K4SmyvY6W0vW6eqoF
 tYSLO5iXv2Yh03BkC2GGGbl+6zWyNHVjqRBNdYGlX98a705RiVxhYPIUkAQ1+PuehaGM
 hRMxRdvrP5I7lYmk450XMpq8X3IlE7ghjHpg5kdc4VmtYiQ2ovmrGq8q7DjbuWmAZdjR
 MgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248736; x=1773853536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8hhLwgIhU2/sosIgArVE4EJu0fvWf6z/Nekl4sBFGU=;
 b=BkW4oDgUQ6Sh9Ve2bvrAVcU6+oVHsHtWeMy1j2XofKVnYzKJMCrmBh49Byqvl/S4U+
 WT7qLmbUq+gwnvcduqW7gK026/2H8jTeYH7Fcy9tHEtDu8+diq8tFwM8EV1ZxOY7ERa4
 LIJkzTA5BpxokcecGc1u5ifMRGd3jjAsubD4+xWxkhFJvbirkM8qd5AgkLwMSpoJrTTB
 8DoqvfQAjQAb0IZDeW+wknnRccqqugi+G6XPyUCkL9lNbywGZnXq+zwyR/QV1xMaGv43
 1pu4t3RCxA8oXyk525qXfGZbJC8Ovtk6//35iGQhwd+3P9YmCUCWmjsWaXVEdzl/Jhid
 JG9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBWvCakWWLQ9EsK/D6ljdnvTZCZGbgxJ0YpF7MZpKEIPs+/ls6mKonVMxv9uaJKeXPIWDNDV2U81IK@nongnu.org
X-Gm-Message-State: AOJu0Yz8OgIF2ozrc/pmaEvb2Sq+HjhuX1FZIbk+ueLnlltqT7uytcIs
 5eZdQy+LJNbofj7/NpWFgNS0/so58us3miz/8/qywI0fW1nefcC3emv/3c2f/v/sC3tTo42C8UF
 nYZp0xlg5pXyeGolM+mvPPnHtjIfjnLsiqd/CUJ6TQQ==
X-Gm-Gg: ATEYQzy/lRoaeb/CSJzc7cB9hzK/CT3mEIYNd+6sMLekyegU3rFKsl0NXlvtBYidOY9
 J072JWAAQxUswd6s3yMHxfJorWRw/AVfdFM4rj1XqsbuN3R546tQiSz0XNRPFfUXVT11tw5LMsp
 zSs6kdIJ4NMJ33q7eJZ0J+QJihobYBTE0x99cqlbt1cYXsFz6RpY3sJeMrF8kjeXy03g4ZelHGF
 0a86EoHzDWBLHwQbCWSGUfDmnkKe2qfOvzqcwwKYCDjGN9q4scl75TnMTWjCiHv6E39TE2lgoQD
 MmUg8CsoIOIPGMXv97UroUHx25VmZhfUQexYd3NGBtQEvRZKzK+/nFxJ47PFSNWoZNw=
X-Received: by 2002:a05:690e:1595:20b0:649:cc0d:a99b with SMTP id
 956f58d0204a3-64d656a9681mr2304942d50.11.1773248735633; Wed, 11 Mar 2026
 10:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_1BF621A658E043C088A2681178D57ED14A09@qq.com>
 <a8e75e56-a34b-4df0-866e-3ce5828dd472@phytium.com.cn>
In-Reply-To: <a8e75e56-a34b-4df0-866e-3ce5828dd472@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 17:05:24 +0000
X-Gm-Features: AaiRm51nohGj-1LpdtU9r14KeB2EsJn9ggPWTylVdOQVeHhkL01hqU7w0bB__ys
Message-ID: <CAFEAcA8kPQwFFdhYWr5WQisAgSs3s4YOuvZm2UoFT83LF5dgHg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fixed bugs in pl080
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: 1774596582@qq.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 11 Mar 2026 at 16:14, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Hi,
>
> It looks like three patches of this series were sent out-of-thread and
> are not attached to this cover letter.
>
> You may want to resend the full series, or resend those patches with
> In-Reply-To pointing to the Message-ID of this cover letter so they
> appear in the same thread:
>
> git
> send-email --in-reply-to="tencent_1BF621A658E043C088A2681178D57ED14A09@qq.com"
> xxxxx

It looks to me looking at the headers that the emails were sent with correct
message-id and in-reply-to headers, but something in the qq.com
mail infrastructure has re-written the message-IDs and broken the
threading.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96AF1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nju-0003J5-Gb; Wed, 11 Mar 2026 13:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Njq-0003Ie-Ex
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:52:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Njk-000608-8I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:52:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439f59dfda2so104806f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773251565; x=1773856365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rmJUvWWQXD3yihl/5inONC7s3eb3a6B0l9EiEnx8bis=;
 b=UbtUE4g4YoOtFCwS2yA4zzh/LSJfgEiSyRjYa87SbCTTASGXXkt7UIcAFms4yU0OMh
 56E1mPqmGewbMnX4GmkU1W9WvfIR4psWxklhyRLiyZ/twllaB8hiyc6bbZ+Gnucy4ofy
 QQaegCOnrm5SdEiftuNijmzQs44EbZuVrYr8RIlUVfJ4Y7KvEF8A31EgAbCrRwXf/4Tf
 AKSwJrBXSk8HrN/94qYyQBi8b50+e68Nv0ILn3lI0aNmQLjjp68BZA/Ooggt6s38fdBE
 a5ymiUtgmBsJMkxXj6BD/LhmhLkW5jxcMoEri3tcNr2evrCOph2Et+HCwGlBqkKTflhw
 eCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773251565; x=1773856365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmJUvWWQXD3yihl/5inONC7s3eb3a6B0l9EiEnx8bis=;
 b=DM39G39b8pxLRdpBrUDbEQ/CgxuDQ44zLAaujFZjk7ogYmpveIchV2PVJx6jh6tqzz
 zecn8kIb7uDt1gYK200WQBpeKb6W2Xr5GY8IibtwpFatjoAhV43YX98k99NDS5hnC4Xi
 9ZFDKsoDyI6pCQ7qMLmtGYZDVjFI+bX950FT807KjYCGHL8vaUoZEKm+rBriehjwsCLh
 wC1JFjKlnz7Jq+FZ0NqeiarrIpqwu1/aoltcpbaUF2hw9fL7vLu3DMn9rFx2bkODOTll
 RqaWjod8skQvUjAGCPSCN2XBVYaK9V1FYHHhPNubWVKN+tRNDpHtk8QgfrUFEuqi3JO3
 +ydg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHzVoYk1SlDvu4ETlRn/darnYQWJXs+pSaJWBeCp0uYA4QcoOrabWQdT7J9KcQgYMdX0sql66M9KZG@nongnu.org
X-Gm-Message-State: AOJu0YxaMAvNp/NQdY7M2ROVDYOadZrRSe1G96p2ij8tFDWr6VjjP/in
 UvQuAeRoAO/J18LSlyGFok3vK3Kbgrrhmn2tJjDiTGam3yRV65K9bAoAmb39SVrRWcs=
X-Gm-Gg: ATEYQzx161LIYJrP6FWhLOPUaLyAZinZzdxp8LYvBaL8NBQav3XUZ7YLOWuZXBy6UL2
 L6mVXvKg7YErvOoMik+y8fD9IgiwVr3ZooUth7gxJTihqhlTBx1c8IKLdiDkxfgLJxiPRoTvnC9
 /S5rtSKiZM3WmnkXm7nof9H1kjTgr7MT+yf9mYe2ny0Qq2NZIT4uoat6MAlHQ9XYjsLPAEeeYPB
 koPOQwJFxyvW8E7gZQoyqhpJ8ImEu7ZuUR32e6dngm44Pk4cFypP1JM1YOHWMJRGm4zu5glJMHl
 goG4CTi54WXsTvvV5nqp2wJkARGGPvHjYrEgfLE1dUBUUsm+8l2n/mt1g4H8OOHUKVHl2a894GH
 em9W3x2ccOD0oLOBflTNZUWle6HTiFuTdrrPyhcYm3XCh6up0DlrLk//rBAz/EehvnRMraHHD/w
 8zU2wlIqXUVomf8O2LJ6QzMiOAeBowEhG1djXFVU6HxnUY3TsAYTBcHHw29TgmEzA0mA==
X-Received: by 2002:a05:6000:2003:b0:439:8eef:11f8 with SMTP id
 ffacd0b85a97d-439f8430d42mr6615180f8f.36.1773251564700; 
 Wed, 11 Mar 2026 10:52:44 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fdf09abesm1035764f8f.0.2026.03.11.10.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:52:44 -0700 (PDT)
Message-ID: <cc510db9-0353-4876-b0dd-e3f6bce58199@linaro.org>
Date: Wed, 11 Mar 2026 18:52:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] hw/hexagon: Add global register tracing
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311042019.1085030-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/3/26 05:20, Brian Cain wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   meson.build                    |  1 +
>   hw/hexagon/hexagon_globalreg.c | 73 ++++++++++++++++++++++++++++++++++
>   hw/hexagon/trace-events        |  3 ++
>   3 files changed, 77 insertions(+)
>   create mode 100644 hw/hexagon/trace-events


> diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
> index 5187b91dcae..a30c16cd7ba 100644
> --- a/hw/hexagon/hexagon_globalreg.c
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -16,11 +16,82 @@
>   #include "target/hexagon/cpu.h"
>   #include "target/hexagon/hex_regs.h"
>   #include "qemu/log.h"
> +#include "trace/trace-hw_hexagon.h"

cat << 'EOF > hw/hexagon/trace.h
/* SPDX-License-Identifier: GPL-2.0-or-later */
#include "trace/trace-hw_hexagon.h"
EOF

Then #include "trace.h".

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   #include "qapi/error.h"
>   
>   #define IMMUTABLE (~0)
>   #define INVALID_REG_VAL 0xdeadbeef




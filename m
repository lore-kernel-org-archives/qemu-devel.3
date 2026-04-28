Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB05AFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbPW-0001zq-H0; Tue, 28 Apr 2026 01:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbOu-0001md-SL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:54:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbOo-0002Tc-Gh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:54:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso4949293f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355660; x=1777960460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKrDl6EwiypM/dOl0CHmtmF2zt8DEt9ZkYJcJ+XyIDo=;
 b=kqgTdGUc+m1XIFsFJ9v1BLTMhQOUwVxckUd8Iegfsf0HtJv3Rx1NEnIjpnWHiaI24p
 z3Z+GtOLNwEWBYB4loXI00NggUsvsdpoegb8JrESOrXV2aS6+Oa/7Z4La6akP4rGZSln
 bAeDz/T3XqOPCLzwKGMSJmzzM+fcYZM3hcuc2r7db/uVVu1zyWzNejTXbp0l9zGLFjvc
 1eaL5R4xqqg3Vj7PIwaDtsNmaYH/arI4wWd/r9zV/kXeqyro4HkNkHVfF7SiDYTBtS3A
 bEAwZkqauu3uzqbeKxn1PM6+pdN8Whpc3pQvwzOMd3Ed/EWCoZSVKmshcliJjS0Bp5ZL
 GR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355660; x=1777960460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKrDl6EwiypM/dOl0CHmtmF2zt8DEt9ZkYJcJ+XyIDo=;
 b=TvfUQkxm/o5SgTm7PQ3GDI3L42EKu7sp6HF7Ex4h8ykdOydcycngjNRd/qGI2eLzxY
 qHfy8oZojZhhCFG7lmllZtkyVB5wvtK0sI+83LDGgOtRu+IRdtJudQyWTeJIDqh13dBd
 0oiprBXBEjqv218biGbp+sFTXfwIVaXda30HEWnNeSc+r3sYo/3aaPPT7d2dobXzhzNx
 TtqfRsaANw8fplJR+vzsgtnuqpgy0wdC6sacFqF04uIzaiPS86PGFqvDBGxgtBzbOC56
 nsukP8fsIDDzI3lKzVgQTl3BTM5KR8l2d8uNxdRXTFLjbOcaYHiKxTlb5HdSdWG9Mlqn
 0r7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bUp2S15aeQZ1tkV+vAjqB/QLNdF0cu1JkdrwpZeZBr1sgQ9Wlb2hxw2AJjmZenfN21dK6oXLDpYn1@nongnu.org
X-Gm-Message-State: AOJu0YwxfjX61t7y55LiUGYcFPulsz5lDRBPCUS3xUQL2A8gYgNoCkgo
 4QACQpzOhN20zQ78/1LpQKHFfDPazBLBUkdrXY1Bxwoq+16eK8W+vHuHKquEnmT1ZCk=
X-Gm-Gg: AeBDiesFrQZmQBR4f+luFJHv1BXAdA5ququrXZ8Wp6d8ePXO7IMaKHDmF6YqM3bWIEI
 57kBpbEHQatlo2L7jSC5zlLIVRafEsvsZ9D5Ppq4fvf/soRpBmoQrtkjvn8t4ZhoAX7C/R05r5/
 s/lh33JfEKYLZZ4BT54YDthul5qDs9QOQyNity1URgaWjQYwpXTAsxK90a2DPaC096iLiw5l/DR
 DsSiXHwNGUtJwnOXuPx1g/GD/hEF+fRzL8e4XmC2B9el9oE52XvLBJmXoAO8r3OrbqaUN+J5S58
 bDDD+lSya7u/OQ1fIMUhh23+bGF9NfEjj9CxYg/3X+IDSqA/3VIAw9Fpck/AqKBb4M60Y3gYm2c
 jGVi3mt2hdCxlahRyBX5EHS2QODBb45ROK+LXqfRVh+0hga/ew6PKwMXs9AlGtbfLumaDwPYDQC
 TJngzIVvhiY3aS3crLFvnOLbyF+nr6ATmA6r/WjYBKoWkpKcTyYtLmflzkkPeqHtyNWPa+NPiZz
 3hUeDi3+gRIx8o=
X-Received: by 2002:a05:6000:1361:b0:43b:4461:7adc with SMTP id
 ffacd0b85a97d-44651c25b8fmr1911417f8f.20.1777355660334; 
 Mon, 27 Apr 2026 22:54:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f6a1sm3627306f8f.13.2026.04.27.22.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:54:19 -0700 (PDT)
Message-ID: <384d80a9-0121-4913-b8e4-79c3d386d74c@linaro.org>
Date: Tue, 28 Apr 2026 07:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/84] fpu: Drop parts_float_to_sint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_float_to_sint at each call site.
> Note that there was a duplicate macro redefinition.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 49 ++++++++++++++++++-------------------------------
>   1 file changed, 18 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


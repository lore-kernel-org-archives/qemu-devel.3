Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1483C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Buf-00035E-5E; Mon, 14 Sep 2026 15:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bud-00034z-Vv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:00:20 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bua-0007uf-Qo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:00:19 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc4bdf8acd6so1762804a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789412415; x=1790017215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uVDtdk5nDj8u+2Npi/o3eOrKEf+eFHXxTs7VNRbqkhI=;
 b=zcPnV0EBMYCfZ91IplzyPZz5AkfR94aYsti+onmz6w+kb/g+5hXTPXaJM6w9+NjYJQ
 AO+ahDR8EXNVha4GFoRAtg5uYHe+ffB5RzY5EgHAf/LQNs7igrZfvSZLkoLsQNUf0C7d
 NDeHBZftYIePeW6rTc83xiVYq8WpFmLj8lAPHGS4SozFXnHacEM339KCtOWjNOy4Kpt7
 j0Zx3BzsI5OFITX3AGzbQKsJuBoPZoI8ZRcsdHC3d7G1PgGemcHZvwstXhdC2dNQ7xEB
 uSTr3Z3LnSkk0GWEzrs6R6KWran5KxRfaaLu05JibKnW0tcZ6RWTLkRLU907hk4BSict
 dElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789412415; x=1790017215;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uVDtdk5nDj8u+2Npi/o3eOrKEf+eFHXxTs7VNRbqkhI=;
 b=Sze7VziZ/SN+eGhwggKV5p+ew74XXd3sX7QrvyoQeq1ts6ZpJ9xd+aw+XSiSyhm4RG
 Q4EKAdmcTE6IwdtkddaUyslegYkJMkCzNbPcXLU0GddWxoFCpGr9hqx/x1CJRQU6JY1k
 LrNb5gKeG/MAK6wrjKUrj0WKzSDZwUl9Swf6z/sSYNAm+o3YkS1NvkYGixZKQ3vL5XP/
 3+7mjCuFyImgC9T/zp971NBi6N29l9rF+DypZpCDSXar2VOYy+NARGV4tQv8euumw4Cl
 sJltQ5VotEJtEEvIX4TVhal+Uv9OIrR6VDFSQra2ruRFTWgnAE1qPJxyqFgrgjhpsCFi
 nwWg==
X-Gm-Message-State: AFuF++l/7/tb8/3qqUTU3l7H/CM9Eww78ujFhWU/giQQXoflgRXF28vh
 d6JmjnnWZGztntYwzAitUnm61mHvijKLJ0L/m9XWmgcYrpANLsQbWD10VOk/go4g573s2sttbs+
 uJrH0G+Q=
X-Gm-Gg: AYBFou1rXzzRclYhWfxrfCGZkmMGVgHA6oF7Kf3EwVxCR4IPlo7NJI9ThEUN6REgSOa
 4bZjk7au9wVEpUDflOUQuahbfT8c4p8U6FSQ06CPC7nWiZ3Fr/MymYoDDr1fjcR1W8cg1ZBu8B/
 NS5A4xUfty0h2/wXJO4ovGK73XOWx0trbK3a3eIwKAO/vQsTRrLdgGQ69lV+KHLbPoYyqaVfa61
 NHbR7S6WXON2LwQ13pyxbw9q65EItFI2SMy4rs/RJ40TZwCagC5mURscou6eV0xYJ2ok4hfGArJ
 acAKhPWuVmQwFbRGhUFGrdgYfxQiI6+7kKDahqk6TK+TXerG/Yd+5Lki7ep7xbpVSUG+i9/SRgn
 U5lZv0hW/9WNdKeNZx7fzkl9h05aKf9ZYkuz/wkpL5Cqi7RvkR70KOoGU/0FV/eM7Mz9dL0yR/f
 RYPMiav+E5vKqAQXFv82tI69M9oi2xEaTGB7d+j7ippG94jQ2Dw5aQjW5cD+Fv8fyhMgC5ECy1U
 Y05UMpM66iJ7hIhfYjy3Fk/XQEZJHQsxxEmd4SrmPF5zyRM53D5hf7PExIiTw==
X-Received: by 2002:a05:6a20:4323:b0:3d2:df:1854 with SMTP id
 adf61e73a8af0-3db4044754dmr7015002637.6.1789412414869; 
 Mon, 14 Sep 2026 12:00:14 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm26977939eec.12.2026.09.14.12.00.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:00:14 -0700 (PDT)
Message-ID: <5e7307da-b4f4-42fc-b9d4-d06dfbf61836@linaro.org>
Date: Mon, 14 Sep 2026 09:00:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] system: check security for accelerator types
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-5-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This wires up the accelerator creation code to apply the compat policy
> security check. When multiple -accel options are given, normal fallback
> logic applies. IOW, if one is rejected by the security check, it will
> carry on to try the next accelerator until one passes the security
> check.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/vl.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


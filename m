Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E57DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6thf-0007Su-4Z; Thu, 09 Oct 2025 12:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6thd-0007Pr-4s
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:41:17 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6thS-0003nc-N6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:41:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-339c9bf3492so1547428a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028062; x=1760632862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGuJDhwO4GiJYwBGBOzSDiAWYyy5ebGix62rF37JBzw=;
 b=pLlOMqw+C3LsXVlcvS1FAOpYRY5NHdYWBA5sA3zAsZ+SN9UMLYpTgHDLSwznaXLlxl
 20iiWzzTalIaHQ8Rxft7KDijQNm+z3OArjwOoK7GFrDylX6nf48ijDcIH1vxSUqWEA87
 C4sUy4Bf4Rhymd/H/x5cGg1ZhxRkCEJ2pSp1VVqbkhofp8Irj1yo+AgBzCPsj30xiFvZ
 7sVi5+uqbYrwen836nmI8WFfj0vOUtxoS34CwkKsb532awwu9i8uNGav2YKxkTUEFNTW
 jnlrI7hcK8gdT95VmosW8NsUZBGqqF4ubH6mQVrJkxY34NGyrUl10+3uyGnCxx3z1hXu
 4uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028062; x=1760632862;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGuJDhwO4GiJYwBGBOzSDiAWYyy5ebGix62rF37JBzw=;
 b=AAOOaNyfZ/6XBt2pWeNXGxnwxJmN5CFqQ735bntJybJEOZXkfBFX9ktalI+Znr9vqO
 S8A8+5IyAaeicHy0s3CPNWKNIPEZqDg9m7BqT0GsFtDvJbC5JZn2KwPbyKWVtjXSZxiX
 8+7mX5aQtg3odY+jK3YZ5yGaZHwZgkAl7oopIVJ9UwtNSYhwySKysW7Aw86d750WRqh5
 IZcDLoDc/Ib45BuIxoJX59HaaqqC4a+aI28IgNOA4Mnb/MLPErYxH96eL7mlK+qqc/ML
 4uRnNXMKsKfj9g0IrPKSNPjIvkLViKtQgi23Zz8R/kHDiwtqiiygtxD0p+DhOCAmnS9p
 5dSg==
X-Gm-Message-State: AOJu0YwE6t87mdHAA5XYnhvjiQtQIqZosYYgONm3fqzWd0129PdipDJ8
 7iTw0Q02TKzIp2g7sVlsamM7wsF8wutDhZtvLtUnbbrW33YqNt5R+5ajsyTKERj7cMM7dyAgdZG
 weQIwWKk=
X-Gm-Gg: ASbGnctqS2VhpEbb6Ep0vtI/M+OHWc+9LdBbhPNl3Lr5+LNvS+N6OtT5A3OEfNUhwSX
 osYEJEwB3pUSYEL6q0U0qDeKTDnU51OFyM4p3ldH3qzK9arAOXe18wQvPbO/oSub517TgZVpe3L
 eaKh+m0DUIYHG1Q9sMBwj/pQHOoXRcrDBkvHmctnTZvcyEbAe0GRmprtIZPU6VBkkya93ys4xCe
 8pqnCnddmVJlJu75qG7YUmjHfmvUm+FFumamCH483C2vG8InagiS3XszInegT9vgQ6BJJbx8cId
 VP6OO7PgnHCGhNcuthS9Z9b3yFVb8PlGDdxx1eV4d4miS7PF1ezqEAltFmb5DRYFfmtIpjihqaq
 RAsFbThD51Q4s0nl8TyKb9xqcscfc7FzL1yVEdeOx3effD9b4RKvfVFpl5olLQfbu
X-Google-Smtp-Source: AGHT+IH1oIAfXpdiPOvJg/9bXnlkvqDengLY5QiCP2J962sP/zpY07keKHENUWMPhp5AyL/gPzt/Ig==
X-Received: by 2002:a17:90b:4d0a:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-33b5127b26cmr9000033a91.22.1760028062268; 
 Thu, 09 Oct 2025 09:41:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61ac7cc0sm305162a91.19.2025.10.09.09.41.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:41:01 -0700 (PDT)
Message-ID: <4e4ec6e5-a177-4012-a780-ff4c9548bd5c@linaro.org>
Date: Thu, 9 Oct 2025 09:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> Both OpenRISCTLBEntry fields are of uint32_t type. Use the
> appropriate VMSTATE_UINT32() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the OpenRISC targets are only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/openrisc/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


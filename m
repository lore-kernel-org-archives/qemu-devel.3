Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1BFF364BA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAwJC-0006X1-Ng; Thu, 09 Apr 2026 16:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwJB-0006WX-Nn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:49:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwJ8-0000sS-5v
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:49:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso17339655e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775767735; x=1776372535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0gtvaM0FaVUMHPOm/R6epN79c9VTidGN3fISE62iSY=;
 b=tnpWO1UMgQZh1MtJUpBVp1BncvIHhA9ZNJed9PtGVIzmQGBfhAurBXpaIlFpVC0WOz
 KvBzSCuUDIBR9sQlEXlXIqRN4/wBiYpAbyPw94UPq/8wu+/kAy0el/a4f4bDV6Vfa4/0
 iLct1/VEuBuTE8gR97yoUPLtu/mqFPN0KqBR9rHiK6SC43QidjWp+qgDOwQZ3iG0XXZB
 25Os+Oud5H/y46RpOuEPiElk+tWN5ast7FfawNXvljsDGsNK1RwoYqfPDVlvhPAh2RHM
 m3NKZp8gjeqTBzeb9l29670n+sPU9auHuTwOpxUJOaU6WwYYI9zesLYYpBe1smx4u37x
 rqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775767735; x=1776372535;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0gtvaM0FaVUMHPOm/R6epN79c9VTidGN3fISE62iSY=;
 b=fs/wiQ2FDnuahf/Gwu67/IVdePaSH289fcBlELAEaULvocthrR+09D8uMeveUhZmug
 f6CNMmjRYJ8D+H2updvN9yNyWALcefcW/zAa1DkJDjbxVnHxx/JfJw+M3UuKd9mkDOs2
 CJaK2Na7KHctE6Y17/LdjogOE59+H284IOIyOl05otCKO24OdbO6y+EKtsdQf7wXhl4j
 M1jsUc9MdcsxMHUpfKx4k2uSsXOY6qf7AY4HiCRemYOVRlf5nkkK/YfSQ9TEG+dvadoS
 9IjWzLQ8pjPU6WlbnjCSs1XlZ7QrGg21iovF1DjF5/4F+uj3/VhSi91++MSgvE9WWRO6
 ZFZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc1qS5ij1uJoTsm7cjScTNYs4vfMu1c62JsPWw2qeLH5lyIqz/l5nGzOYAAfF4q+F4rfLmtU0ZIRjc@nongnu.org
X-Gm-Message-State: AOJu0YxMhOKGRbKSV2OoNyPM3ReAAdzQXopd6hAoD6zDjb1wJ3iHCJkO
 qdn5s+zvWAX/MnQpKqSaljzjUzsn3hySn1pZn/C6iLVrDuRwcWWAESbtdMQ2YXtPjU0=
X-Gm-Gg: AeBDietoJtUPmEA/aAud0OJ3VkUlnfBluHJcDO0BvsSGHCmHCJ+gKsWOJLCJaEqUJ85
 j+ArIBle59434KIoZ5GNNHnJv8EXByaczNvcNjmOAONbY2yiYnLW98Mz+QhboXDvbC8I+hBRUl1
 i91beDHNTYnkTr0ZnIU/WvEm2e/RiEyfjk22hTQYaAEW5sZWl/rqP/7vd8YcI2YE1J69VT0EUC8
 eS168KYzwhaMySeDrCxH4pfFtEKK3z7nD/BCvwn4QIkbg+IFwvFuxsveFLIksoJdZ3ltclYBf6f
 n04XQmPDl42O1fASQ7fWQV0VEH1lC0+yYJpBp8YmFG8VVvFCWnGFv+wNGZNUPhNfNsM590eK0vD
 Cow/QaqwLECWgQeywPu7kWgQTYlpbPDjzcIHGtqb1DtrP8xfUmXapoIpWjE6OZdZasrLho5HWSS
 LoBjtIsrPMqNAGvWA5EdDiRG/XY20tEYNpxQrG9O9KXsgOUA9Mu51HHBcQiq8YiXNBtw==
X-Received: by 2002:a05:600c:3b29:b0:488:d07a:b178 with SMTP id
 5b1f17b1804b1-488d67c7029mr3735295e9.6.1775767735091; 
 Thu, 09 Apr 2026 13:48:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b56d1asm15204865e9.15.2026.04.09.13.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 13:48:54 -0700 (PDT)
Message-ID: <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
Date: Thu, 9 Apr 2026 22:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
To: Yixin Wei <easonwei1998@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org,
 Yixin Wei <yixinwei@meta.com>
References: <20260409164938.6735-1-yixinwei@meta.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260409164938.6735-1-yixinwei@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 9/4/26 18:49, Yixin Wei wrote:
> host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
> as its loop condition. When the last rtattr in a netlink message has
> exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
> without byte-swapping its rta_len and rta_type. A big-endian guest
> then reads rta_len in the wrong byte order and fails validation.
> 
> The companion function target_to_host_for_each_rtattr() correctly
> uses ">=" (added in commit fa2229dbf8). The kernel's RTA_OK macro
> also uses ">=". Fix the host_to_target direction to match.
> 

10 years old bug, nice!

Fixes: 6c5b5645ae0 ("linux-user: add rtnetlink(7) support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2485
> Signed-off-by: Yixin Wei <yixinwei@meta.com>
> ---
>   linux-user/fd-trans.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


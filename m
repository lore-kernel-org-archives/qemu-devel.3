Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99D0E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1o9-0002ja-78; Sun, 28 Dec 2025 20:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1o7-0002jL-Ma
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:12:23 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1o6-0000YM-4K
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:12:23 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-641e9422473so7029487d50.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970741; x=1767575541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbGoWW3HdCA+wuiKsygBh37hLPQ2ghvMXoRiBiHZhzg=;
 b=fcxXDQMtS+zDAL6g12UcuIwrAehgzhsSl5LFCx/AtVTah2v7qDXiAp9KunTQTbuAnp
 xXPVi+iuL4f2mnBtB9NXV9dcR4Klnfa2qKf4jYFEI2zxhRFCPChbwQSdtorvOVRwUrx9
 nOXvUpQE48EVlAsqGXTYh1oce365ldXNZlt48r2JuedQyvlNdDqJzsr/zuNOqOWZNCds
 tO4UvvBOT8VBACGwymn0e0T2OBvnpcBdzyAnW8x46oagE/x754FzIhUbvXnUsfTjZ/kS
 klxiPZY/n7uppc+5OwJJ7XSYUrF3DPokcXQvIEA6JQ2hB7scNMXIDKfwz59DKOw6lniT
 79zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970741; x=1767575541;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MbGoWW3HdCA+wuiKsygBh37hLPQ2ghvMXoRiBiHZhzg=;
 b=pO5Qpv3EdgePfOh+rhkdhspthGrwMBefhHexoZ5aJWO8UYCGqWJCAvTJyRkPr1LYlG
 s99OuLGSFqhGz2VhzGhlkrpWc0ncam/ofaiP9ubHn6Jeq9qkQuqrvBSL6rnMGTCILVVB
 gjisnSmKAH/CiKkT7ofKTBu5mlgCZk5xuN4H7tYtvaqQo7yjb6ViWocM8f2cK1qM/8gR
 fwqRQbTUQd9nygOVN8PU/0vxibEq3RqT9DIRPPUHYJ2wrbaYYIiUL/P595nOp5dXvyck
 90wU2dKQrScQD44VD4GmKU54Djy5V83e/lRxGwva3G4VxpkAba+Y7fkM6IblPbW5UrUI
 zl8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl9ujy15RcoqjJs/MzkiAmBsNAafizK87e+U/bwStVQneJlNc+TT8goS/KOP5+WC6BxxY6mCUo65BC@nongnu.org
X-Gm-Message-State: AOJu0YxzRkQkJ/Br/i9RrthH0hn/sOqaZsnhfkXJX1Dlx2pwAjIdTnDH
 7TMvycu2XNk3svwUBrdAI8nf21YGNiWvqd/eZE3pLD4fzImqaq02iism0JNjRnXmrYnf4cTjz1V
 Zz5Gw8mE=
X-Gm-Gg: AY/fxX5Bu01xfqEcT8+eMkfIffrGt+cnJrAEr27Kfu4e1j7x5ONNqs6fKFCpJCcf7O7
 ZD1DigS140/YzkI1AhjZNOhTHUafTGyAKHRsRFUGuzglAeFt9P5HQJHCKG+67MUlvkxW5PFYWVM
 J1orNqqBhjbyTQz9XyStcXoMsCMXm1W4/UEg0k+6e9uifPFHQClJj6PzveYc4oytmUMq3MUG6PM
 VTJmW2KID8SPrAZU9QxESt2/6Bw2TTqYMplJw8IW9yEje87hAoCPaVefNM399O4WSLzwN33hGDL
 rKU+bEGo2qyK+a67RfepI5msDnyU1puJxzpsCzH1arCXGGDM+6rc+/kU9WMn/riAaB+hlGqBy0i
 1qHobA5b6QOAMuQv2r/8KX2LU31ahqU1YD24BgiDVYmfq33L5h5JYUN5WbIVo6+RbuFcmu4JuWy
 trG4mF/ix3Zp1/APpOVbKD9fF4AHDJFMnsQMuWFCrOQKDbUwKUTvo9viWtJVDDBq9adsrQdQ==
X-Google-Smtp-Source: AGHT+IG762sPIloVoEDSc68dKhchgq//YMh9G6qnEzh2xlOXxdaWTEgOQLVMIMl/GOB0+LhzMzuq9Q==
X-Received: by 2002:a05:690c:c452:b0:78c:27df:c56d with SMTP id
 00721157ae682-78fb40ae5demr555746077b3.61.1766970740607; 
 Sun, 28 Dec 2025 17:12:20 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb456c349sm110086617b3.57.2025.12.28.17.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:12:20 -0800 (PST)
Message-ID: <d4278ef6-c980-415f-8c81-2ac6ea52eaef@linaro.org>
Date: Mon, 29 Dec 2025 12:12:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/25] system: Allow restricting the legacy MO_TE*
 'native-endian' definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb133.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian definitions we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/memop.h | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87EBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6u77-0006gP-Ic; Thu, 09 Oct 2025 13:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u75-0006fW-2W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:07:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u6z-00005o-Ct
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:07:34 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3306d93e562so1301592a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029644; x=1760634444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rU6E/psOuoV/3sCvyan5iXIQ+4j5U20rIV1C40wxzxs=;
 b=lBEkZ1wzyUIGAmWtqByPAQV8hcQ3xnFZxu1k48Xw4RAlkLtTe1spZtcgvxmpmLSNm/
 Tq8Cm3YFublX++JboIiACBS9axsuWY29QDFfWDbCZGusRIyQNh4PFOoHp+LrQAUBu/vp
 Wa1N6B95eEHCo9GDR5rN5n9amjv45ym5yZEFStWw5KckmUrGCjX5ayzNfISbUoVc6EGw
 UfSZP4mdm2YaBkSoTfvn3R0WEA1BZ/lyXNpk9s8Qjl/tYBeywHx19hDYuhLxaHb6RWvQ
 LXpQmC/2Hv795EqrJKi+zFswphwU0Q5VwlELlDSxdHsnZYKV8cZTVnbrHPYIv63dI5O5
 3TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029644; x=1760634444;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rU6E/psOuoV/3sCvyan5iXIQ+4j5U20rIV1C40wxzxs=;
 b=aYNK7o5zE8nu2Mm/mCwYLP5boYvTzgD5hz75wsCbk0TRjgiee6HiQgIC8/RGrKhoiX
 mBojbea1eLbfnLXoy4cLDnD7T/dMNcplC1G14br633SwPoxwDgoGUm9paYE02v8sCPKT
 N8KQs+TwUPiyl1gxUwpKdl7OdKMlqvDOiRxzfqp0NO3ZDXpTApBWLmE984aM8/9MMiJ5
 2P6vnSLljmdAXJvdC6HApdn9JTenw3kVvNSHsBCoRseKwvXCv1VayXxGHoqKLyTufBVx
 yNKo9N1QcUev4qiuyCERt2MmlSJO2Zu+sEAojqtplLHFD56q8peL3DnTeiXgjLCF4VEN
 /N7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3a9cVutEfZ2c6bT3lxGQ/9min1BMgAS31dRdvo1WOpAN7EUYgo34aqp0yIarhr9dOVZJIB4nca8li@nongnu.org
X-Gm-Message-State: AOJu0Ywz8F4DF/+NucFgLHxcd3l42swuziaFwEfixUYs4BOEqSn2u71O
 wbK8vIt/fkG3wYqha+s31qTuBJvxZky2ov/zt6dMsXVG7/nyKW/H+u3csGaX8MKLWVw=
X-Gm-Gg: ASbGncumlXBYUQxHjli2ROf+mWUCqX9QNTUrnLP8zfxe4TephDZiCsYmWrYkEbiVf9B
 6GHkCA2G8/cST4kirhp+AyD6hC9rlGwdacc8f/0/+da0O9iq5UKMbXKHD6QzZX/HMLbPxqTomgo
 gJeN0QEOcLqY/KNvh97bJx5MJ+vIRtz9Vxrl89sP7Kga9HMxKfLbxOU3pRLIjWf/5bnkhO6wt+7
 1ZYhcNy304onz86xqvx7rQM+1mWJIBNDxOL88bNF/akqoTVa/TyWdGBsNfRL4TTXnUL64koBTF+
 X1GCm+Ws+meZSWmOsoAmyxsOVHS09/n1on3ovpXtlH9olccVv86bC7eoTfLkOaXyydke/KQEDD9
 qgxxKX3boyg9CD7XDnHc2Kg1zNYlSoDKkCIay8J+KAkFcbr1mWjokrJXibgJtFkun
X-Google-Smtp-Source: AGHT+IH5l8arhphU0fl2OzC8iZBWp5aZ7g2QW927IBc4Swbw6uXYvxrmGz6rzQo7RB8+7JhDuIY3lg==
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-33b51162572mr11970482a91.12.1760029644147; 
 Thu, 09 Oct 2025 10:07:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b5295ab65sm3865944a91.1.2025.10.09.10.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:07:23 -0700 (PDT)
Message-ID: <2ca6a84e-d546-4e57-84f1-b6abdd0e105e@linaro.org>
Date: Thu, 9 Oct 2025 10:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/hppa: Convert type_init() -> DEFINE_TYPES()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009143106.22724-1-philmd@linaro.org>
 <20251009143106.22724-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009143106.22724-3-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 07:31, Philippe Mathieu-Daudé wrote:
> Prefer DEFINE_TYPES() macro over type_init() to register
> multiple QOM types.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 42 ++++++++++++++++++------------------------
>   1 file changed, 18 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


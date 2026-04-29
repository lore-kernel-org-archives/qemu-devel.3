Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3296FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Bd-0005G8-CQ; Wed, 29 Apr 2026 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9BX-0005FY-Rf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:58:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9BV-000648-81
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:58:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso217745e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777485529; x=1778090329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZnJLNQYKnnhX+DYA1VNJSl9nHcjrqExn8oxalwU2Fc=;
 b=uW8IOOx/BEd0W4rbFnAWuirRELs0/PLUJ+D2jFjm4U1xiTGckPIaleDpc2lEuNHqzW
 /XPQ1HJlGYXRufdRZ8quDXyyLpO2pGLi27MLOgZkdzfPtYaCtw66uOmyXAq/1BIRB1dO
 MMIBZpiK1d3514xPtr2F+wS4tQFgLNQojJpNAad6nfXnRnBeq6soflDOAR3ihAXofl7h
 Rv9eUfsm+1u6DdTGfIweuSLHV+PC0/oX+Si+moB9wCDz6SfprvWU6OnRLsXpSO22QrzX
 3gySVA1GdE9Vk4YMeo+jmchjJNszcvcxYG625XcCXoYIkGnspKZJPQvsIPLKXkDfanLH
 h2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485529; x=1778090329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZnJLNQYKnnhX+DYA1VNJSl9nHcjrqExn8oxalwU2Fc=;
 b=UAKy98JBD145jxcoDmzS6NH43l3CpcqaCmUrba32QGB33YTfkjkx/dInK9o/h36R/2
 8DahUI5iodb8f6CY8kV5e0g2l0qBXTADIkmau0oAEueXPqCJ/PIYLJZsY1u4mnmcWCf6
 CF2mnA8BRiOFQlJ7b9IYjsM8YdUTqi6TessicemvB96aI3fjQlF9sk1o56P5PgBBlxJ/
 OxBMyZgDXdsD88ARMgGhzxxs87H4nj9Rz0BrkyvGRKwUYwQSG33zbb+kFHCrkpU/Xaog
 BvLV7aknYTXXEnsqIUc79+tqxdqXGipkiluuDQ/FSBm0P+d1YPc6Yxy3CyyF2zgp+3ie
 7NpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92QzNYI5Mp8uvPiRC7DYF/K5p/h0ZWLl1ihjQAIVKIe0M3RR/hsq9kQEZ/hiC8MJrIWwV2DSLpd2hd@nongnu.org
X-Gm-Message-State: AOJu0Yxmxhh9oruZwteoq+6ENKD8U0/+v+AN09C7pg2AapuKm5UGbtdJ
 qc1yKdBgJQi5gMWwMb6f8KAHzvcCl9Uv8zIm1eFFT1nOFZluDlUJxj2vxYJ9AOyEUFTOC1lLCkh
 39qq77fI=
X-Gm-Gg: AeBDiesiJ1YEm+onqsCHy5nwP5mbSzbpNMH+3fizSe5KnkiFggd7VPCy2NmZtQwVQlP
 gaumhhhlyE5Buz9HGvPBsdupQj7IU5H3mw2pMBqEB5BuqnkflamaSoj3xONQuIOl2Y9vz6D+kv8
 0TW2Yn8wC5JEF2ctXb7OU6NyClRjEdvQOBqXs+z0W7n796fD25HhoJzWmRn2VN4qjt+rMYA9IX+
 OlfQHn9DIUfKYhIfumyVORJ2NvjgqQ32mR8/lZKW9IyYAWIBSpOyq7bkPoSSmK7EvKwNKz76//l
 KBu11U13g5Ml+2TuWJvqrlc80ne0KHBlz/Eaz/g5qfsVTUEGMfvBXGP+71+TCAszW8SfyI7qzHh
 c7B/IeoMvK17GQtjwIh5Wi0rZFNPXA9Uv3Ee3A+vaFhyjGdNg3qw0B5PEpwO2+d55akEsD7l3qP
 XDA8DGh/ArmKPc07DOh9ESP0D78+YzNA7UU2UhkKYv07BLDJd16DOehgyPbWoPEErrVIJkv+t77
 5ef
X-Received: by 2002:a05:600c:3f16:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48a77b1da5emr152703805e9.14.1777485529598; 
 Wed, 29 Apr 2026 10:58:49 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5afesm6293512f8f.30.2026.04.29.10.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 10:58:48 -0700 (PDT)
Message-ID: <7a2dc6f7-e387-4540-8332-0ad0dab5335a@linaro.org>
Date: Wed, 29 Apr 2026 19:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/84] fpu: Drop FRAC_GENERIC_64_128{_256}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> This requires more complexity to handle const selectors, and
> an indirection macro for each function.  Easier to just use
> the preprocessor.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c                  |  69 +++++----------------
>   fpu/softfloat-parts-addsub.c.inc |  22 +++----
>   fpu/softfloat-parts.c.inc        | 102 +++++++++++++++----------------
>   3 files changed, 77 insertions(+), 116 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


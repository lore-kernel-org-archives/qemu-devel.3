Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28D0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85E8-0006HQ-RK; Thu, 24 Apr 2025 18:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85E7-0006En-57
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:39:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85E5-0002rI-I0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:39:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso18568345ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534364; x=1746139164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hz7ycsGXxoOG9GXlZlAA2I0pEHWOUsm3j/ck/i7X+L0=;
 b=bU0rXlHOy2jfLNXuaEOm1yNkxwC8X0sUVtmidWOKI61x9jy5t4/f+EwN4Or3d5MhDX
 QwHIzTcxpVN1Nej2SbDs8MtUVZpuqsCWMFKNtRO+dkLJY0ksl+tCfH5bmPBX7NrjZ+0+
 Si0eVd/YqNLvsXogMVcjTMmEr+/3JRhEHNFkZwaKRINJInwP3gXF/pM48VfBbFAh/krt
 Is9aldgRr9Ll1RhUTP/VVIMACU4d8xYSfmVms+WlejB99NGxV2DN3XPhEkz893BdCYIT
 s6iyYnAtz8a+vqaPLN+X9tcUz3uFsmCJ30oU575/TItTQm5tmMkMps+8zYTot87XAT9Q
 HXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534364; x=1746139164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hz7ycsGXxoOG9GXlZlAA2I0pEHWOUsm3j/ck/i7X+L0=;
 b=cr9wPnJwnKINx8kJAKTmJB80pVoNcM3ryvDjSy/+cziQlHJcnzAtZFwgx/SVExRmQr
 34ZIRE1sqdvmTjI/NEU/3rqyVZxQSzCBLr0qBypI0c5AJrk+G/XFrUQQ8zGJjk4t/jYl
 OLdWwLKuuSw2Q0qwEMaocJAXaFiAznxt2NBfgl15zu2xdEULzFrbpRpB5a+DpE7EKziA
 bpxHx1YZBSpET9l0djbR3PwDCgLHlT8m8Dj3mPd7soZuTNxA5f8mYyd7v+OCSL5soZtm
 AZwQkMXvwNtxQB5wCEdRCpe4YofZ9YLW4cHzbNC1uPnsPySdZ0XmqxhkQV8WFcca9UDQ
 H0+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCu5wIt/uW6DY7pmPtVU4xtabW/3X0za8xYgukEml5eQ7LvtZDgXmTXSu5J+HFFa4j85ajfnHvKCDL@nongnu.org
X-Gm-Message-State: AOJu0Yx50+RJGqE1Vo0mpQ6W2hpPaCoth7c0VYG7/D3sc6ESOTF0194k
 vdM9jR5N1vz3pbXbu8UvaJdwEdAueTxvcv557pOBa3rQQymIkY5UQEBLfL5cvHhy6AQu2wMU5jg
 AF+0=
X-Gm-Gg: ASbGncsbpWGn/T5b34UMo+qGklJ/i2FvfjVB6y5Rp9N4AOIkdrgmqUCbUQ5mFs1L1tn
 K3/sdGTta6RKKUIypADOolnnhZJIJzN9rr+F+d1oqkmV3XZ+oYytx8LrBYliHe2n4hL2Ay4FdoS
 s6PM7X3u5CMcX0UsSAlmSrAD6jAnIF7/egtuqJig2tmF2GxfRPcVPWUHqNC3R0XcCxSxiXCfcON
 GOAAF71Pl+oO4LzdN03UMC1LKMHbhk11mBVk3gW9sLp+p/q6SF22fqmXkYnRnFZxOX3wP1yF7j1
 pcr4h5ARdcZYkt7htulEYyVvzF5EPpSgN4RVd2MXEud4IsYQk7IW9A==
X-Google-Smtp-Source: AGHT+IG4cLrab+Xrl7grZjWEPR2PuBZ99Cs3mVvobZKhOeCKSAI0P1oYUUJO7/L/FiAT5swSkfP72g==
X-Received: by 2002:a17:903:1a0c:b0:224:2201:84da with SMTP id
 d9443c01a7336-22dbf5d9f49mr805995ad.6.1745534364279; 
 Thu, 24 Apr 2025 15:39:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe4desm19112025ad.70.2025.04.24.15.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:39:23 -0700 (PDT)
Message-ID: <4a2ddd7c-d49e-4892-922f-ea3857dd185e@linaro.org>
Date: Thu, 24 Apr 2025 15:39:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 16/21] hw/arm/virt: Check accelerator availability
 at runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-17-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/24/25 15:21, Philippe Mathieu-Daudé wrote:
> It is not possible to call accelerator runtime helpers
> when QOM types are registered, because they depend on
> the parsing of the '-accel FOO' command line option,
> which happens after main().
> 
> Now than get_valid_cpu_types() is called after
> accelerator initializations, it is safe to call the
> accelerator helpers:
> 
>    main
>     + configure_accelerators
>     + qmp_x_exit_preconfig
>       + qemu_init_board
>         + machine_run_board_init
>           + is_cpu_type_supported
> 
> Replace compile-time check on CONFIG_{ACCEL} by
> runtime check on {accel}_enabled() helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/virt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



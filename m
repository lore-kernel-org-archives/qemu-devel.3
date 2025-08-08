Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6462FC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTzX-0001qm-Vv; Fri, 08 Aug 2025 16:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTzV-0001q3-6h
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:47:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTzR-0003vZ-GM
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:47:04 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-31efefd2655so2114662a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754686020; x=1755290820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/74K7khizFR9OV/b7qDXkBSWiiOLUqA6zwAlsZronWg=;
 b=CsnV9vxo2dcRZ/eKkbO8xMm9NYrK3ALLxQBTDEQVHBm7w6m04mOsoul8iAeUVjWs2/
 1AcwEvVQs+3vYPhVva2yA4oPs3DvKEkqobLDmTQyB/gpdGRyVURRaYT4VswEX3pM2hUN
 1ya/6clyxhTTotlQ+R0Rg6GxVVhOgZdL5MfLc+yDBUGBBeUlHlNh4Ed0Ms5U61IAcbuv
 rXi9g4jN23sfC8GvdwfStanSAbCdWd9VWzQfajAQT45jXVcQcSM1oWnIqCuXgLoZVoJx
 x0P4jBDCI7qVf8Jaif178G0iGZaeefAI6SlEiAfcqjd0Y2d4MqIexbEGOWQ3GLOSxJFI
 KcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754686020; x=1755290820;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/74K7khizFR9OV/b7qDXkBSWiiOLUqA6zwAlsZronWg=;
 b=IlxHWPpTUXGibnKf8vvbYF7sZVYL/sXZU2CrP5G9UDsiwJoVnz0oAgueI7niq60e7q
 LkeUOHU8N6fa2woIlSbRT6ehcx7SpKSWbVWBnG9IHtSV5NXPYrY1oJYIq9GAy8wU+/U1
 a9zTreGS38HxoAtqYFzMGm8oLFZ7hUlCOdJ6JBw1whi1/7AuztHJKgPEouPCZ/Uy4Vuv
 0N1lZcIhP7B0MYDeJeUna65c/6o3+TQApAS6HLBBvOmk/gufbXr3qCRhYBBxxdl9IFmz
 9H/xpBFmI3lpFWX8t68radjrCVQo01rLaPlmTQ/4tMujXByxgOXNtkqayjMmKTmMe/w6
 vlLw==
X-Gm-Message-State: AOJu0Yy5eXHpfAEH+ffsgsB1ZbsclSIfqIxufC88v/fce4cN2z1Cdxzt
 hcnkutWN4R6r1NTS51JF0fieQcn93VRzll7VyEmc928WNxKdqVOymNQsTObq2GLiNOCYzl+gFWO
 HiOp2rXhPnw==
X-Gm-Gg: ASbGncu+aDEZzY2TKhC6QEgFiCAZE1Vh3D/Hlxia+uq8WEISPZTvrYzWJCNn1u3f51/
 gNYVRPIv6/KSz6CXbRz2xg7ixR+XXKl2VZRpIHxPmYsffKm6AqL3nvT1vYpXkK9q4YeANZJL1/v
 RyvNXr5YcY6mmSP+i69h/4qp3TIhxk7v8aCdz/5QJ3ODxxlXJv8hveFFSoFpTBf0rVTOBmbWlHe
 TrfY3TnyKaFFo8e4ww8jjVrf0ccWXOUACecoMXfUTdab8CLkTppIdt7jn0xtIyFGZpRoX7f8qCq
 TQENPUod+UDeuGcX9qdkOhtLs0IvZzBl/WMioGRzvQgHJ+LuxP0eULVi1T+Rps2AgcJLgsKntvd
 QAjQu/tBfhXRxtNGgCDZCjBkmkQxdpOgGEVQ=
X-Google-Smtp-Source: AGHT+IFaLshfsZa0ldnbaqNDMN4OMEYSs1CPtAZNyOf0pS8mhGFLeradTFVJpv87arZCpKqcocVj0Q==
X-Received: by 2002:a17:90b:4f47:b0:321:2b89:958b with SMTP id
 98e67ed59e1d1-3218425082fmr6741268a91.0.1754686019850; 
 Fri, 08 Aug 2025 13:46:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32102a95be9sm10019998a91.2.2025.08.08.13.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 13:46:59 -0700 (PDT)
Message-ID: <3ebeccb9-3cb4-469d-8163-f71cdec888f1@linaro.org>
Date: Fri, 8 Aug 2025 13:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/8/25 1:41 PM, Pierrick Bouvier wrote:
> 
> v6
> --
> 
> - fix types and spelling mistakes
> - use _MAX for privilege level enums
> - uftrace info file: use empty strings
> - trace flush: assert we wrote all data
> - doc: added style for keyboard keys
> - added URL to document uftrace entry format
> - updated comment in vcpu_tb_trans to explain why we always instrument the first
>    instruction in tb
> 

Patch 4 and 8 still miss review.

Thanks,
Pierrick


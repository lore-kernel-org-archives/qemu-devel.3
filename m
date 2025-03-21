Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EEBC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveGR-00039W-Nc; Fri, 21 Mar 2025 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveG2-00035W-6r
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:26:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveFy-0000zo-Oa
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:26:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2264aefc45dso15892685ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742570756; x=1743175556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJP4NB085N8UDeixh6pzBI1rRouhH6A5/2xdoAJCOeA=;
 b=AdZQEk1xXSVnAs9/5FwXz+QrqXVlj5w5FQ8OogiT8Pv9hQvF6Ql3+GCLjSFzwfTDpq
 D9dpWX1Ql+1sSnMQgXAjcSTs8ce/9ABaKXBNpEvsLvH3941aWlPSyPdxM5QAAJ/twaY4
 i89czMSLxZDo8CHf+TUgSt8OUah35M2ax5gIEFMS+ly4SG56fwcWvRZ59vSMabo2db1Q
 rHZLXrm+l9R2aVBNWbcVnCtV/wAMPrfxsUTi59JOGzw+1yTK4mrwH5bTJzkzlsQQHCYd
 CX9iOxj3rWos3leIqXPav8WwHVS6VwgrZqYKvZFzdz+0ry+DU7F7c2CTQCnmr6wHhKzR
 R9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742570756; x=1743175556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJP4NB085N8UDeixh6pzBI1rRouhH6A5/2xdoAJCOeA=;
 b=tsmscOOVjchdlRxXYA36LKNtVBS4UE2Wjt2CKJZ7NvaTQxAcP6pfTGqEgDr5eK/WTA
 h6B8VyXtMTY27v8CDfntDV154V87bH4sPiCIuA/INU2aj1PU8kagWHhUjzb3kGqQsPvH
 VwvIzJYpx0/A5g5yWy+vJUVqdcehGmkm5yVwWozh/IocoLGDJ+XrXn9mTx8tOKF9Y2W4
 /AWrCmTcRUpnYVDJfbyCf9Zyzyj6sL5kF/omayxBlav9rjsDsTx9iqgNj2aKzJ8c1poQ
 TKNZwVXfTEAv+XH33yyysmPTgDcaU4Qu1oQYFXqGfD/0RMH2tdp5bDuoG3Yp26p1Oj+S
 g/Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2bG3NPeZkldXW5U/zc7eIs6Ws8sjZKw7cjyqxr4+CenZDNAZ+ibtTc0yaYMuuTDbXU8gBKQ12MIeM@nongnu.org
X-Gm-Message-State: AOJu0YzVQEA2vEC0QImhJRGjq+bIHDnL1ZSQjM6swvpnVcAEcqKE0m2+
 l+nHDws0YxuNqnOga5VtgWOjIZrY4t9z35Bccc9Ent0FcCJTZY3z0eW9IIz3wG/q01+5MOQte0P
 8
X-Gm-Gg: ASbGncvf1FwJ6GwZpNdX1BxtRW1b7vOcCfC7/ra3Q1iDBArrkgvUB4hgtVpET9gE1yu
 y6wToat0jdvrhxbdIffYK5rzy3I7rFPGlaSeE4v6bmlKFneQhBp+oTJKac/N3iGcqNHoUgG0jCq
 R1LEOLtmCP3xpfhCx/W3M8MI8ZeFqR/tbT889907kczW5s6gm95TIJ+sF/yoL4bYrPZbT9ygZJO
 hCvu6sleCF0i16potzQt2LTtCkrsqKK2u76/841XDBszC+41T390yiOtkKjK1M8dAfGd0t63BXn
 NP+dp18/dYW7+cJDfp45byY7gvAC1YCNtAFH3rdKvoVn1OsA5xe8oC2Ur48T5Xj7MF0bEIam91z
 ibpMZ/JOP
X-Google-Smtp-Source: AGHT+IEQ9rW6eI4BAlbi8Ue70Iywz9Meox2Na2nka6+vb9onMFSq2M0IzjmLpXjbdDO/y7Wudh0I3A==
X-Received: by 2002:a17:903:178b:b0:21f:6bda:e492 with SMTP id
 d9443c01a7336-22780e09daamr69009385ad.35.1742570756255; 
 Fri, 21 Mar 2025 08:25:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a8e5sm17939505ad.259.2025.03.21.08.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:25:55 -0700 (PDT)
Message-ID: <b222f717-c0fe-4137-b0b6-60269f8c0189@linaro.org>
Date: Fri, 21 Mar 2025 08:25:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 4/4] tcg: Define guest_default_memory_order
 in TCGCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321125737.72839-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/21/25 05:57, Philippe Mathieu-Daudé wrote:
> Add theTCGCPUOps::guest_default_memory_order field and have
> each target initialize it.
> 
> Use it to setTCGContext::guest_mo in tb_gen_code(), removing
> the need for the TCG_GUEST_DEFAULT_MO definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


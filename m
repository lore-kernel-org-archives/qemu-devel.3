Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C098CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GqO-0000eR-34; Fri, 10 Oct 2025 13:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GqM-0000eC-1c
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:23:50 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GqF-0000iQ-9F
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:23:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so2134099a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760117014; x=1760721814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z0HpfsJ3BIS4VARFpm87koiRE+yetnxjmUfFnTT2v+4=;
 b=R/pl4eBSBCNV/WEdY0WgH3JOZqZCNne+C0TLuUbHIHKDQuBxK8VKS3dxSXLzeAPjSm
 K3QN5x5A1olnplEZ+RPUMvCJ9hVdEGKF9DpxyhqC0Fc0Bv7pcbzEK+8/ATnWnLCneyyS
 kttevMmriO0xvNPprzl2YU+JSQOXM35n/XJYuv0bxfWPu6Q/UXU1+OwZ4oOkpLTTq6zT
 Ao123OA2y7fVnHLyx0WHkFy3OHz0+bFdg2CsRXFNJEzLqLe3+KAc6L8GMOgLqlKR5Wqj
 4IFftXfLRPXTyACS729bTYovfE7Zrjz9Cnp1YFytqCxZ6RGS1NWLpr8BjhGR59ivFAzP
 UVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117014; x=1760721814;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0HpfsJ3BIS4VARFpm87koiRE+yetnxjmUfFnTT2v+4=;
 b=W3nsN8ppOy864WW/bsxJOJNifuL/UiPTq7QG9kmBpehSgeXWPNgXE64JAM+JQf7eW7
 KXmp0F6kuyZMyBxiA0DOY0USQ5Bypb2W8z/0In3FewuHr9WUnk1tEh8bctOUYB97w2XB
 cPgoAYyXMwymedzroIIthW1MPDS8JJcwn1J+4k6lEbSjCC5mFIEpCHi+w1bvee3zwvyj
 5vft/rB6oYQFDBdbzBhDgpjeC7ejJB+R4o4y/LrsfGT9QihNpg1QpURv9TKxpnrvKMix
 ydQTArIPk8uWE1uVFFdNJg/OvbPaj09z0QsDdr3kh/L49OpAtobWL3t4sTn5rqxf30Lq
 CkVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrhEPNr5PdXdiU6+d/p6fBMRdBoRTliQ311cS3GegXPEAzX94IoxQD+Xw7IWJtq5zJ9rgwXSd/KhNY@nongnu.org
X-Gm-Message-State: AOJu0YwrWCvHTpMshaoRF5b1pd3XYuaX4aTkBml84WZreVyq6Ct2uxhk
 jeiPUuyDxVi08akvz7sUG+ZKfPDHkygBj2FOb3hdkJ+Su0WMcL81Z/VTNrvGffaPjIE=
X-Gm-Gg: ASbGncvMlSvAqqqoJSXKLDD8ZFTmh0WFhed8dLwC8LueWZpQcmXXBgfaUGa+Nl+Z7SH
 wrzjtjYI1CBBTw+XxF40qY7TbZwS23iRllnS20nY+zoN2G2FN6hd1UGNBURWlmOmB2YVrlQxqp7
 ULlMW7YF0Nc2whkR0Ng0hJS0YmCusnb7/VHFLdcSGuZViZNQJOMZMtiQceqodQDJ0QidqoFCZEU
 NS2lEL8Q8pKPOoglwKBY1THhLkr7VN3nJgkYSWm0ep6q0eNt0J7Jc7VGlgLq5gA0/Y8l8EhmUA0
 OsMovNfhI04C6dRrCF2h9p6kk8rCCYcCGy10o4CTRuW9u6CZCAxhB3D9Xs9SKMMjM7aNjyCFHFV
 VptSnvPuAtcjuSsbE0BsdP2h8BUfBIru93+FCU5tzQXL3i2S2DTcydaJsQ8L5OA9kRar5yA==
X-Google-Smtp-Source: AGHT+IGOqEwZP9J5slomW/M+4fmEKOBvFM0ztxbzCPgcFZNOytjog7EWClY5BJc0SxK9muKOFAHGaA==
X-Received: by 2002:a17:90b:4a8e:b0:32b:dfdb:b27f with SMTP id
 98e67ed59e1d1-33b5138e27emr17894187a91.17.1760117013483; 
 Fri, 10 Oct 2025 10:23:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626403desm3549689a91.7.2025.10.10.10.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:23:33 -0700 (PDT)
Message-ID: <10c71f4b-932f-4efe-a828-8782399f5b53@linaro.org>
Date: Fri, 10 Oct 2025 10:23:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/hppa: Reduce variables scope in common_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
References: <20251010061836.45739-1-philmd@linaro.org>
 <20251010061836.45739-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010061836.45739-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 10/9/25 23:18, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


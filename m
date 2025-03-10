Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50227C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgx9-0005Lw-5L; Mon, 10 Mar 2025 13:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwy-0005Fs-PV
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:30:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwt-0003VC-4J
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:29:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224100e9a5cso84610275ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627793; x=1742232593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFhstR9NucYfEif358DVji7zUk+B6GH9S4mMFDlLSw4=;
 b=lNglTOrgGoZAtlHPWcKHoyGHttUiYsGO3fdpvzQPu7wiNRE5g4hB3I6Z+t4vJoWtH6
 0glpQ//wWAFqY8Z2ahYe+uW6aXuz2Ei3ya9QocFX/Shxn2/hQOfMwuBqIV1uWth2qB8R
 QjeStKr2/TPi/xtSeUO4BRQEsM/mkhHPI2Uz55nRDUo/N/3iX8lw9sgYQj1nhMe0FhSg
 1eDn9/SyqT4L17aqInVb9IbJNdWYTkX+DpCj+sm5+JN62CnYDHgmvx5dM8PRAQeabiK0
 Rl9nu697qA+t9gtrpKh4Pof13FqOOho/J8K5vx9QfEYG4sUD92nxmupH+C940WHlvqVX
 oClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627793; x=1742232593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFhstR9NucYfEif358DVji7zUk+B6GH9S4mMFDlLSw4=;
 b=f5iQ2V+CdC80PPxXaApg1SIAvDJy33Ip50Cu1dPUYQH8aIjJf1tGEICir8CHGL4JFi
 qFimqkWsq4DQqDDr/Pu1CEkNlwZ5zF6CuUKoyfTYjIvtCAtb4dDMiJTTFRVdJF+2SjrY
 srZPrnzahy6c+mmeEDpOq2zvA/a+OFgOUTjaOUE6mNqQAWFGFzqXQy+3F2LEtx3gOACB
 yocC7AxtH+D8F1pG1SJBno6c0EtivTbruANW+u2L5vCxgVLqufXE94W/CYgR4HO4RDY2
 c/GOQOUQQsMxn2MKo/jVbWeoMUQyYG6H/TE2xhZ+mCIE7zXb7ngzZMKIOOIicMTIUpN8
 NxsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3uAH5efLmj1p2zIuov85sLogRYg2r7bXb2PoPxl07VFr33jVnX2mgVabFugF4+QfMHqaq4oQxfF+1@nongnu.org
X-Gm-Message-State: AOJu0YzO5sB4C822ePA4nbAZCaoghRZ8eHEVvfGyse7LWCOSINoCz4Xj
 BNfRyEc5cWqHPsVZHCAJu6WtTZ19k+Eqz+UOGuoq9JgXzeieKqZwBZf8wTu8s+5qxIbWCqYn5yO
 p
X-Gm-Gg: ASbGncvOwWcEW3rUtsPPImchD3GNfuMCTq5EQIenSCDjanTsW+fUpvVXLxVch+DS+dX
 DttcMkZ4rmwurJwhLvDvm9ilgrs+k7jwzNxWJ86xFILR5vQjZ2hGlxRtldaRFtoiFuqrmnj5SXN
 +eG0q4flMPorXZKYlnieTG8Emb2tbqHztubv1dgLE+2KlY9Y4IZHdBWPcNyEwrWQDcBI3V2usNh
 HomZb2N8Y2Qex0LHygQeriU0gm4awryM59sQ76WnroFhdonwZGENWtVItw6cUEyr7TkpaP/OOe+
 jDRxcERsxUU5xCqaeM8d1P3CPhNm5HZ8TUQxLzAS/8Q+sUdIkUaNbdGz0OXYmKB6gljS5Z9q2ej
 HoYXvua9i
X-Google-Smtp-Source: AGHT+IGaEbv/vzq5ZtmhXSdpqL9IxYkDY+TIwX7D1LlhTMNyRfTp4VUR9w74HzUNm9idpnolQ9lR/g==
X-Received: by 2002:a17:903:230d:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-22428a9a060mr216857795ad.23.1741627793345; 
 Mon, 10 Mar 2025 10:29:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109fda8esm80964825ad.101.2025.03.10.10.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:29:52 -0700 (PDT)
Message-ID: <1b1ee598-8fc6-42a0-9e4a-5c6ae48a8541@linaro.org>
Date: Mon, 10 Mar 2025 10:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] exec/ram_addr: remove dependency on cpu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/ram_addr.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


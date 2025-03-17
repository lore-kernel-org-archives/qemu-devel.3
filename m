Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2545EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDnn-0000XN-A5; Mon, 17 Mar 2025 12:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuDnk-0000X1-Sf
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:58:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuDnf-0004BH-Ex
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:58:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22349bb8605so99898025ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742230727; x=1742835527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5SleGlTK81lU0lWd/8HHq+UOEHYoh6K69p8vIJ5M92s=;
 b=JyLPkc7qHc9cPk9MmZkCW9s097AzPsztD7EwoJQym3G1boLSwRsF+R3UMwKxd9hAnR
 enh8JsXFNKoCp8Za2yuBMiaXMA5hfj8UzbqudkUoW14OWmHbL9vBZrifDfjHCmgg7bnL
 RrHuhKdo+RmUT+TJc4RjInXLT2KQJXdJDiRmUFfV4bax1K1/d2uXMDMjKq14wAVyot4W
 15PqXFAr1Fc3yBVQYvLyKKUPnPWXohG7I0qkUhjDpGJh+Y+3/eWmRmc6eBnfd4Vv/2lE
 HGDb4Am1YrPOoziWSc1g57VG5el6/bY8XGXkaRobF5N3Tp3+siWB7+c6d2UAljnCPsxV
 6xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742230727; x=1742835527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5SleGlTK81lU0lWd/8HHq+UOEHYoh6K69p8vIJ5M92s=;
 b=e2TwHiz1DMvdQFezw4WUssYS+ya1bGQjWZn+jPBzlI+/MHqCo4QtXVKD/s9Vlle/8P
 oAvSnrE5NUNIGr7TKyIkRwiMX04C/nUfz+UsXidbLIyvORcZ2rMO8VAO8BNKCreNHRiQ
 55T1GER8yVQTx1vbIk1fFXL5gA6436Ln3wM5ixYKUso43I36rPdWwJKDObhdaqUQftCb
 WTGysGsms1C2BosHPxt6ft1ldtiBtpTVDNsxgjQ92hKO839BD1rY8WF2uXhuk+8vQQhW
 A8Qkc3QHwh97sEFl39om3Enrzi+KrkmDiSKCGzfd6Gh/Ap+xtHO+wQyY0TLZF7H3eQYZ
 s7ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEOTTHxcVCsE25JnaPYU8O9NPWw25KuB80YGVtPUIi6rc6IGyOsvo7p4rmKPFgBrq3+Zg1FNHJaqfG@nongnu.org
X-Gm-Message-State: AOJu0YxhX9FxG9L/VwzexjjhiNAk+62hB3o+tvu/MI0d6Lx9HejWb7Xz
 H97IoiBgFFW6/xZqk5XnhU9Uo0ki/uZLPOj8MJ2tQDIA8s+bzhDsDn9bNfxD4CQ=
X-Gm-Gg: ASbGncvv5F1vqZqf+0gX8Cqq/aMiDdC4QT6y+o5IaLf47vMIq3gAhIRVdIaOIhmXTXo
 hT1dXHLFMF1fN2IaARe85PLL1bd0zcjBzG12O4bgtDaK8A9wMw+ag86m92/y80JdJMofzIlQBB+
 SYQTxFqHuI5E5qJEE3oDIidtiBpVjCYRSarRZs+evzL2EQ9VOyBWIfpdU7FdQTErvVMXINOpYw6
 cMuCv7/jomrArtErqFSqZfZxDrZU3ZF5yftiTsSx+qdtMvTEDaQqiVNwMpbcZomsqaAagkcS/j3
 mtVL/ViKIEAVxNZnx76F/TElcO9Dq8jfQgAoCQe6sntudRarelh4DzUVtiXBbynyQkvfRD4jsJo
 vqOH0HiSYTTQB9XWXiE8=
X-Google-Smtp-Source: AGHT+IHMBjot/f2Mtc84ugT4qaG5ui9EHle46sZ8HWcWerS68YAsuoTQqqSlxjo1q3DuCuIBnnQPlA==
X-Received: by 2002:a17:902:f2d2:b0:224:10b9:357a with SMTP id
 d9443c01a7336-225e0af9ffemr129782745ad.32.1742230727258; 
 Mon, 17 Mar 2025 09:58:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a6df3sm78018865ad.76.2025.03.17.09.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:58:46 -0700 (PDT)
Message-ID: <687e53f1-1164-4bc1-bec4-3c937ed77868@linaro.org>
Date: Mon, 17 Mar 2025 09:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250317051605.1108128-1-npiggin@gmail.com>
 <20250317051605.1108128-3-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250317051605.1108128-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/16/25 22:16, Nicholas Piggin wrote:
> Debugger-driven invalid memory accesses are not guest errors, so should
> not cause these error logs.
> 
> Debuggers can access memory wildly, including access to addresses not
> specified by the user (e.g., gdb it might try to walk the stack or load
> target addresses to display disassembly). Failure is reported
> synchronously by the GDB protcol so the user can be notified via the
> debugger client.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   system/memory.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0a..960f66e8d7e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr,
>   {
>       if (mr->ops->valid.accepts
>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> -                      ", size %u, region '%s', reason: rejected\n",
> -                      is_write ? "write" : "read",
> -                      addr, size, memory_region_name(mr));
> +        if (attrs.debug) {

!attrs.debug.


r~


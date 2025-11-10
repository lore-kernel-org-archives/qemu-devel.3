Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35D3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8k-0005X8-SG; Mon, 10 Nov 2025 10:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIU8h-0005Pg-QI
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIU8f-0000pR-BX
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso33717865e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762789743; x=1763394543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BlasZw21SI2xiN2rk1XkWVHFcD+ky9wxuWGDPQ/wpU=;
 b=SZaXLHxJIuQa8EykJAc8/FbWXTprSvGJ/jqCUYrmJGv0s3O4i4x4v9ScUsMKvrFZnR
 1QRmRnXh65JMlX9PFmJO6bMOwB4TvdQzDvFwlj2sPzgwRBUobzdblcvnmEg+6PqBq0kO
 u3y38TzH7ieHtsjljaaawRFAdHC+k/mTeakuGYGL8tvOCjWF3ETengW7nyOLSqsa//G4
 GwG4TmW4JKAdkVw+4cNDziTu4cAIXNKwfWSZMDi+7/MoUpWtzA4j9ExaxyvEAHbLIBMI
 GfX3YR5DORYYkZymtd01XMgvpkxpHAkMQ/ZdQcN3WqfSe9E3gV5AlQj5bKFEmREkxNGZ
 SS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789743; x=1763394543;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1BlasZw21SI2xiN2rk1XkWVHFcD+ky9wxuWGDPQ/wpU=;
 b=ZNFy5vd+hoJcKoU33Lvm51OJKDfCXVGF6W1R/1trq9snwgVehEfujnJ1HtYjkBWJPh
 AB6Qp9ePnyMYgWXnNAn2HplfS7OB/3EyVfh2QsuF/j3mWNLFjQw7TChFr/XyLSwWqh8W
 dd5XA4JFfBsWOMVIRG9/OGSwHhNGte3cJX8+pJEueBBVe6NDdq2/KKfKvq8ucIXNRYW+
 fbCLjPrYOF/D8xDU+k1YUBKc2dvOL1uG+j1HZ17WKNuTS5JgyR6B914CCfp9OobZsR0E
 3RC1MPUWMrrgGyYCJYzXee4deN839idYlsJScOZRQ/h0d85O581UKXmT3GpwS4ECCWip
 1r7A==
X-Gm-Message-State: AOJu0YxVtaM454aulDIAaztU+sybPR6EyZjPLcJtNv+aesE1G6UXL5LB
 loIZY0X9s587UUfPJFW0iteYLepHs3oxrpXN6Y5aUF7yj0/vLB8nt0LGeNFLdJl0EIRkbHm6EiD
 SQdjU1K4=
X-Gm-Gg: ASbGncth4M1IczGluQ3543DPbouwg+xnMm2qVuocV6fOTy6npp4NLSjX5UjzUkn5eXu
 jjIYzI+rPJ10wk80H3eKPdHnzSUCv0MenExGjgc+PCLUXKvrBXP0KqcDzvfifcN5hbynDWAILVg
 cpbQfUJQelFua1A7A/ZBkPO2ppSuaqzbBPnLMctOH61JCGfGNGlueh7tQoA2NKsNJtHMkSxFpYH
 pLEURbssVUuivwl2GYwwZiJGQXRUn6cDOPH4ALhCMlZ8N/odtrTX2yo87H1S6DATKq4jBV60vTi
 Ke8fJXJi/Zi/d6vFnNVxmviE1Kcg5mvoLWXuyB/MRtHCn569bdUhwNZa2gbTwHFUe63IwzwtzAR
 bJg6Nj7pdfppViHpiVzTuepprDG16B66LZYJN1zwH3pWOYxlca8aXtouN9HfWXopJESEfc9TV4x
 WQMXOHUoFNKNAN3ZiGUQ==
X-Google-Smtp-Source: AGHT+IF1UrGrTc2LswIu0XRFKlA6GU1Zktv1z04cQiXnhiWwbA6RkjXdBC4jpet7M5pM23Bn5C+7Jg==
X-Received: by 2002:a05:600c:1d1c:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-47773230bb9mr82709125e9.12.1762789742735; 
 Mon, 10 Nov 2025 07:49:02 -0800 (PST)
Received: from [192.168.50.95] ([206.204.154.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce210a7sm334471305e9.12.2025.11.10.07.49.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:49:02 -0800 (PST)
Message-ID: <7ef67c3e-8f2c-4009-936d-c7c3d90e081f@linaro.org>
Date: Mon, 10 Nov 2025 16:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] PPC Patches for 10.2 Hard Freeze
To: qemu-devel@nongnu.org
References: <20251110080401.3652497-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251110080401.3652497-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/10/25 09:03, Harsh Prateek Bora wrote:
> The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d5-20251110
> 
> for you to fetch changes up to 3149969a9f4d74ea8e568c91efbe4b2c4d336ba8:
> 
>    pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs (2025-11-09 16:56:21 +0530)
> 
> ----------------------------------------------------------------
> PPC Patches for 10.2 Hard Freeze
> 
> * Pegasos fixes for mem leak and dtb blob updates

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


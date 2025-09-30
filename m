Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91697CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hax-0008P7-3b; Tue, 30 Sep 2025 17:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hav-0008Ok-55
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:09:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hao-0005oQ-0h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:09:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b5f2c1a7e5eso223002a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759266536; x=1759871336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dupJ9A4DuMF3aFxqi/gHC3Wglwb4IRL8r8frM7em9o0=;
 b=sEdMaemC8RfPN/HOGKK2/RGnTicu2F/e+1JfaPWES3LbRrGBABY102km9Dd6/HN547
 +6BUsJvp2Vnz8Oln4IFobK6kfToGe2UtJUljDDf/o1q5A19QlI79mzjxXTNtkQmtgh0/
 +PybxJiP//n5cstheAZMTJOS7U8vRU4Ofc8ysJIt3L7TdrxG+JkdvpKdkkqtHqtwmeWS
 qdDXMsqGPt7YNxJisJ4YubAu69umoA7kOe4L0IKjMzqw/MlV/Dq3rw/YB8+xdVailgYT
 5B9Fz7JOreOQ6Ijs9Q4vY7ZUCpwY/Ij/WC8CkuXS9qIcABstDd3Xy95aUe3vsjlVUr1I
 ZGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759266536; x=1759871336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dupJ9A4DuMF3aFxqi/gHC3Wglwb4IRL8r8frM7em9o0=;
 b=K4MajUe5iB9IbxQe5KQu6P5L59ezhbaTmPu6PZVeOvvVGmcXskrJKg6vALGSTG2KwR
 0qFbREBonMO7bc+01sbYKLeK3U6pDibPbLVvDCl6geGpalFtcspic5fEi4UTnCVmcGNM
 6FjS7KDUuiNtUplKAG7sDPaD+ZhL0T0RefrB/0+0eJXWkDusdsxJHrVfuUnIVLNzvQYS
 e+Klj0sG4Jsaf4vA8q4Zzt0cVRhs7H7+PIEsuOCJcdRD0B+IhN2F/c0WCzgMpS04ZK+S
 3PPaJ5rx50IxDgZNhp7Qp4XFK08IjUi02uX+CKxJAQqqT6lL0ZPYLNJ/HOcshjDdGKAv
 CsLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxD95uecp8rc0Ku9aRuLcQwDjlVhkJmO8gnXZUodvnkk4eB3kYRsyYPbAu3fbii6rkFNAyPEugGR6K@nongnu.org
X-Gm-Message-State: AOJu0YwKAkvUzb4VCJ5GpHXyn4cOZ8r9QIhr7iYD/8kjhGoSizOnGbsl
 QNKqPwv6peWlc1Blll+wAjddISCAV8UKIR5QtvBRFNbV2OIEY9A+TyTS5mFgm4f5eOW5Co6rm5r
 JKeRcU1RXLw==
X-Gm-Gg: ASbGncvD1UNMXPZXnCJa6QrOqWZR1nVO4bqKC0lmulCyG9Zg8VsQnB6d6svWaehXXBm
 f9Vm+KhFbvMovqJYH+fREarC6ngCDMXiyXeI5Pyr9UAWMFWMzB5A+wkSu+RnGH3f+8+Slq4C6d7
 ma0VatdAtABC4PjpGe8E8QGbCGK320a9B1aEuiaUjZpcTy9WldGJZyJTjjQgZJsrAC0bjnzapdn
 rBViy9E4q2JoammM+BRfOAyC//0ITwPJSzkno8inK2M8ge+ssUlhcmPl/DT8pntDNP2pq10zWAw
 gS2uDaRH9zGffxGhvpadO4yeAO7IwFSYVZaPFRtPic7uezN4Xi3HhyRtFPIJ80DZ6iC75VqQ13p
 4gUxVLhjHbQ85CTf9RXTqjusJ01mUpOZ3NMp5Gu8B7qQI/8wQJe942Vm4GFHR4OzzPAVFAAc=
X-Google-Smtp-Source: AGHT+IG51tHbuy44b9HQr/DL+91vIxhTlBYX+etjglRMONVRDeqVCtdNKn9onaEhLPboKjMaDlx5/Q==
X-Received: by 2002:a17:90b:3ece:b0:32e:3830:65e1 with SMTP id
 98e67ed59e1d1-339a6f846a2mr929678a91.33.1759266535886; 
 Tue, 30 Sep 2025 14:08:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ebd987sm495129a91.7.2025.09.30.14.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 14:08:55 -0700 (PDT)
Message-ID: <ed91dad4-c002-4162-95ec-6309428a5910@linaro.org>
Date: Tue, 30 Sep 2025 14:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Use VirtIODevice::dma_as address space to convert the legacy
> cpu_physical_memory_[un]map() calls to address_space_[un]map().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


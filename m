Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF02CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNQk-000845-JE; Wed, 27 Aug 2025 17:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNQh-00083E-OK
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:11:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNQg-0008MN-0i
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:11:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-771facea122so180396b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756329096; x=1756933896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TNPsCYpnhupNcfqnVv7/+NB9KH9afOEPXUQ5NXL7LAo=;
 b=i5d2u8LY+9f3W4fLDadGyTqQ2tXpZw4iY1UGiYzvgE9wY+8+LpizZdmAgoUGmBSI9l
 FJnXr1fFMqe36wWIitaUPLEAI/9H/tb0tj5SXVPebNejquV5vLZcH83LM+BG3sOi6m1K
 QAh10wA2ClR0Ek4DoWYQE36gmFNtSWrvb5PWe5lAMOiHcLwUXUA+e27ev/yWgMUKvOQZ
 HPTq1MHYyH2b5Rbkfc24v1Am+RFFccx1pugcOWEBMiroO5U1stMVof7gy25x8F5JdZNJ
 IWd05Pq1eLifd5LFr66EySs+1PpOqpBxwX9vh1bxWe9sPAJfo/O4zbSyIVUkYUb0J3pe
 i13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756329096; x=1756933896;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNPsCYpnhupNcfqnVv7/+NB9KH9afOEPXUQ5NXL7LAo=;
 b=UPhMD8y9B3+1fTYXcXoRwx7DRuUPcnb7KvSddqf342dm2zJgIBGoAaBuokHLjH0jyr
 oByyC1WZzgL7eiBvmviwhtKjKwXjTmeTUERj2Miy3YFjUR3PBfsk/GshVTddT2+uLY8U
 oXnZHu/PENuVOuwPXGN4QMce4fSsp9HNp0H5qsYOkhiWsyT0tXDppmIg/CsoueBWXGxv
 h15KNpjvsjSkLnJLksea97+gSJYeME31ZCeeHzAHUuNeW0RTN47NvWOpkQ7qHf+DBE3O
 yOK90NT/KIPJMEbCNFsLnlvfEs2gA7PcUqlHHSSoDG6HYFw3S3+6fPCLbojjNnBjgC9E
 zg1Q==
X-Gm-Message-State: AOJu0YyE0NqSARKW+Lea48OXvKT0NpSQ3/rbbUPT0n82MXI55mGH7rT9
 r/xB+3UrX+wFDOD/MCg/wlAfezcK7Wf8Mm+rLaVEXC4vxlskAsw5SRtCHJAk9YHwHD65caO4qXX
 AMuL6aN4=
X-Gm-Gg: ASbGnctpvHpcU0A5bVzW3MK24Rc8HVx4QbQkWlKACqa3pnFN2FpqP/9AG59CD7QlPt7
 TtO1FogH0linICWJmfqz/UjUecH1I3xiC+9yiFyxPT01SEDF0/835m0ubMDHcCgSHKv5YUvV0zt
 qWBgNjmQTazclpx3spCjEVThOHb3nV91ZGFHYNJJ7+7cp+FKDY/oyHMs5qKUt0CKZ/NVP1QTC5r
 OifKupvx5RMgc79d+YfrLM/dln8GSwSIEj7ksfhiy773cqvoJi6uY6+ZwT9FoIPl8EzsnPYJgF0
 lOyh3fJH5Tz+Xq2LH49/nsPdv9IKIM6CCS0FaaDuTrUXv1S1YSmWt7jd5O3ITz5RorLhsROzngT
 nH3v4MdFNmuEyADxIfHJGQXPy7bzPVIggvUDT
X-Google-Smtp-Source: AGHT+IGxDet9UFjKpMTJfZ0qF/wYCPFjn+GuxgEJCL24W4BIfq6WOQxHTBb9FywuvvEql92efM00Qg==
X-Received: by 2002:a17:902:cec2:b0:240:3db8:9adc with SMTP id
 d9443c01a7336-2462edd7472mr281632465ad.4.1756329095812; 
 Wed, 27 Aug 2025 14:11:35 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24896e1bb19sm27201115ad.124.2025.08.27.14.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 14:11:35 -0700 (PDT)
Message-ID: <d53079ce-dc44-421a-944a-e8be311e8cb5@linaro.org>
Date: Thu, 28 Aug 2025 07:11:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Adding termios2 support
To: Luca Bonissi <qemu@bonslack.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <e18add5b-c75a-4547-8ae0-01d9924883dd@bonslack.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e18add5b-c75a-4547-8ae0-01d9924883dd@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/8/25 22:16, Luca Bonissi wrote:
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 8 Aug 2025 13:30:19 +0200
> Subject: [PATCH] Adding termios2 support
> 
> glibc 2.42 switched on some architectures (mips*, sh4, or1k) to termios2 ioctl syscalls 
> (TCGETS2, TCSETS2, TCSETSW2, TCSETSF2).
> This patch add support to termios2 structure and releated ioctls.
> 
> Fixed also wrong TC*2 definition on mips (missing "target_" from "struct termios2").
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>

This looks plausible, but

(1) It does too much in one patch,
(2) It now needs updating for master,
(3) It came through email malformed.

You can do all of the generic #ifdef TARGET_TCGETS2 stuff first, then take care of each 
architecture one by one.


r~


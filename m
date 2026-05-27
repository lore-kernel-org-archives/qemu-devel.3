Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679B2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGU8-000574-2Q; Wed, 27 May 2026 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGU4-0004zW-D1
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:47:52 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGU2-0007cF-I7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:47:51 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36900945df5so5957889a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779896869; x=1780501669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Na/kMFm2ohYsd+uph7gppE+nyQi+cP6XsLV7hiL5aM=;
 b=zYvpytk3gRzT2pvNauvp0jfoQKh51s5FcVAjDoZQqBjWQ3WOrtOQZzKI9yQ85ubur9
 WLF3YHXEv22ZKjE5qtarUFvIAzPZk09la5l7/t4Qz/nxB0rWq8oSKrtEkPk7+xkb3VUD
 LJBfpqYsSVrQck/wMua26mEOhf1fix2nIte8/kIYRF15VjjpI2xDqX5gEp0vpqT0ryNB
 sA0RXyIHwK3aS22zMikwEsfOX4PwDZl1nyMdXYmChNflTIVuePQ0doBtOGPBeCP9B3NB
 RSUOdYT72gk6nVqVxf6PfIEl7ftyjOXuHF3hCJG6OQYr4H3NZVwcpGNMUL4laCnSqBtF
 pv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896869; x=1780501669;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Na/kMFm2ohYsd+uph7gppE+nyQi+cP6XsLV7hiL5aM=;
 b=SOF/FgFLxYE6UP2+2a7MMHgQmW/2rO9n/qACCH1zQPYVu+wy8mRQoye8x0sAAHGyp0
 CBmi5TZIXWrISlS4VoG7z2cAn4Rkyq+r7OpsDVZr6hGC0rLjqivP+73VPsvHnz+DX/jd
 Oyr/oQy4L5N1JF5gSZOFYyUoJFwgRVAlBFCWV+e/1rqxtFSCCFORv5S5AcAkYboYIeDQ
 RHEv7qO86LQlciXIswaENOAC5sLrlrtpjsSASYuRcYiyP5nCo2PIX922U7Uvg70zpgCh
 HLuOwOlTF38xvhTcObpJBfgFMnwoI0BTPL2Gh/PrvziggL82I7s7nJTDzGEUXpebstis
 VkYQ==
X-Gm-Message-State: AOJu0YyLaw/lCN6/LCGF1U39Se2eWC/LlHhZ9odbEmpB4aPUns5BUeZr
 R6TEepLN/qUQ7We03+q7n/VomgjJJSYoWHS98E6/YtgDDEbaQw0iIYgdWGxEBsgNeI4vxtPIAmS
 aQ1nkDr4=
X-Gm-Gg: Acq92OEy9Cf7x/10wSDx9+QiOJtaml4ADFNbsXnCCKy/GvuMe2fJdFiHWDxorSCqkvN
 IVGoy3F3c9rjvN87ytmqy7hu/voZEO4BVDWRy+EC5qGUHQr1KBUHV6Sl0TmJK9Ukke4hMCw3fag
 59G+4njQOa6t3gHHitFUFbtBnyc0t27vGnG4QE2Jw6cgig0dqZbJYxU25RnzQH4OtL8jIe/YTo4
 rFXnC+Ls7+VpHlft3EWrsiFP8aMbfp/vGhqnXHolzdQiN6i8W4uy1bCzH4wd/m2aG0Jlw571BRQ
 mvOGaVNpqVPA5Gn7LOpXQ1+v7t42aQ+IapzSVrXj+8OJgHEorDAvT7b/BoP6aGp/0DrdjHInEec
 0n6WMvD4pOvb9vXz5IoxkZJaZt2Wjmq8PNCdfh673kTtwmUjtb7bbM3BT+vxB+73Iac/ZSn1EUI
 x9KPEudo0fwD9uCwJ7Zo5iMOWZXLPOn3hQYYYZ
X-Received: by 2002:a05:6a20:244c:b0:3a2:fbf9:d819 with SMTP id
 adf61e73a8af0-3b328f3be03mr23166181637.52.1779896868847; 
 Wed, 27 May 2026 08:47:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852054c8absm13378984a12.16.2026.05.27.08.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:47:48 -0700 (PDT)
Message-ID: <5f94b5ed-1a9b-44aa-93b5-1af28a7ac21c@linaro.org>
Date: Wed, 27 May 2026 08:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user: Implement finer grained madivse() syscall
To: qemu-devel@nongnu.org
References: <20260526145049.7239-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526145049.7239-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 5/26/26 07:50, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Although most madvise() values are hints, some are important and are
> checked by userspace, especially by security-relevant applications like
> BoringSLL.  So, return -EINVAL for those functions which we don't emulate.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3489
> ---
>   linux-user/mmap.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


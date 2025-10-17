Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A87CCCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9m8X-0006AN-3C; Fri, 17 Oct 2025 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m8U-00068d-HT
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:12:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m8L-0006Cd-9w
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:12:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-290c2b6a6c2so16139845ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760713961; x=1761318761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koQsAFouNUd1W5J4wdrheLPAPSOaKLbycwvoS2z+Iws=;
 b=q5v1qlc/kKHQKRIdk83oV0x09pcrhpLONho5n6EypLBXMf/PcyYEw8cd+gH6Q6zvC6
 qhKtn6pYu8fowXibqMc4NPBYvmCw8CnddLWe6xKAFzDe3HXhn3OVqXpA16Tlplw+z4O6
 MjCHxku7+A4DJ28cTAjyurLJCOz/ysIPHXCD4sfSIhS04s5nigtwpMSg5vSqQdsGlK4S
 yIzYGvY5n6dPh16n1IOaCXwzJ4ivWOjWNoREEMuo/wt6Fyy01SJXbidHl4tfLnMzzaPE
 UM0YFA6Q+vP439Fmbr9F02JaZnrRMYD2nyvA8PYT+iJa1e+xFyTatKRd5Qvpz3oVTIqi
 NGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713961; x=1761318761;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=koQsAFouNUd1W5J4wdrheLPAPSOaKLbycwvoS2z+Iws=;
 b=BHwPRmc22MxH3tJNjd6f0kWOu4bW1aQPEZxYPe7boDU0T6jIYhlGKGlmZiJrVzr+dZ
 tE8ZV6pSS3G9R6pf1DAZwsQJmlIsaYTlHT+PXfN6rXupDQ9RBI4k3Kky5hdU0NeIQ8bK
 bR8FyQQuvR9aO0t7dC0XFHdiyMNOEx54RoLzj5OyE3+pl9BZR2rgHligEa1RcLYqku+a
 Eo2BrzRi3q0hd2VURm7pxZRpli8lG/Afqf/sKum+Krm/bXf9qjJf0p4iAfpFh+oyP7Cn
 Cfhh6PvrD+EqDSk5r9ya9qZENNUDP/X+mV9Sb5lTS43jGFjxo9CDHSGW9MBk5mydMQPw
 BzFg==
X-Gm-Message-State: AOJu0YyILuzJP9YNIDQZwoGnbIqg6EdhyItfT9F7wFd400WhRECspxSV
 OI5AtLntP7CPckxKpTxS0uqdmZl1dy4M2rEX9SKsdEX3q78PLLcHb2QTvMfpqfzoP0KMbBYe7Ff
 UlI2cLhA=
X-Gm-Gg: ASbGncudaTK2T8j5FxqahpmLFj1Qf6Uz7W8d4TYMNkR8okD9L2C/TNY/M5+aGjJbunh
 DGydw9kka/v8XY+lbqegNn6qQE/g5tZ6uNu4oV23YFXvhKwX+HlBFf6X67RJaEQDy9NuTpU322u
 GnL1xXnoAI3ccqugkk2jYOxCXLP6zIOlzphwVuWx+7nTzlvnVIprJs2OsQQUbBitYSA/jXkteOK
 MXRgrPfGnuqIQRrTega5GprJVg/cBWd6Ez3pfkvmyWJU2/RAJSg2Wdzb37y8RbZA0b48p3sMUM0
 xeozfIkXPUsDU53Y5CNWpFqzV0Sjk5lIyAdfeMO5Ds0Dkf6lDDcko6oBYvsw9XiXum1Z0H3GTUn
 qOmnuOgbeDcCQje6GOIGdGXU4pULEgaAuGXJbhhmi/TMlIiyHeu4lXRNFFxk+H6DTz5azyWr2CL
 Wcd5wf9dstLioT/WMLR63escJl
X-Google-Smtp-Source: AGHT+IGitKBv8nKclMo3hytN1NfGoHZ4dHPu/mBYSEb8q2cUanLsLBF7GD0YUb+xPmPRfE+IfBAssA==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id
 d9443c01a7336-290caf831cdmr52810205ad.39.1760713960421; 
 Fri, 17 Oct 2025 08:12:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909934fde5sm66987155ad.41.2025.10.17.08.12.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:12:40 -0700 (PDT)
Message-ID: <d2c32a8a-72d0-4409-9285-f35c8b5b6efa@linaro.org>
Date: Fri, 17 Oct 2025 08:12:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] Misc single binary patches for 2025-10-16
To: qemu-devel@nongnu.org
References: <20251016151108.18442-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016151108.18442-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/16/25 08:11, Philippe Mathieu-Daudé wrote:
> The following changes since commit 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8:
> 
>    Merge tag 'pull-loongarch-20251015' ofhttps://github.com/bibo-mao/qemu into staging (2025-10-15 14:49:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/single-binary-20251016
> 
> for you to fetch changes up to 8dd133fa85bb49e2e61c489a566ab8460478dc24:
> 
>    mailmap: Unify Clément Mathieu--Drif emails (2025-10-16 17:07:52 +0200)
> 
> v2: Remove legacy cpu_physical_memory_*() calls
> 
> ----------------------------------------------------------------
> Various patches related to single binary work:
> 
> - Remove some VMSTATE_UINTTL() uses
> - Replace target_ulong by vaddr / hwaddr / uint[32,64]_t
> - Expand TCGv to TCGv_i32 for 32-bit targets
> - Remove some unnecessary checks on TARGET_LONG_BITS
> - Replace few HOST_BIG_ENDIAN preprocessor #ifdef by compile-time if() check
> - Expand MO_TE to either MO_BE or MO_LE
> 
> Also:
> 
> - Remove legacy cpu_physical_memory_*() calls
> - Fix HPPA FMPYADD opcode
> - Unify Clément Mathieu--Drif email addresses
> ----------------------------------------------------------------


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


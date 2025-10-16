Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5591CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Vsp-0003Jz-8z; Thu, 16 Oct 2025 17:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9Vsc-0003JO-T3
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:51:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9Vsa-0005C8-Uc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:51:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2681660d604so15986435ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760651483; x=1761256283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Pz4YOpWB++fH/A19xGy1nVcnwERh1c2QZKXWin+XvQ=;
 b=Ae0JGOpfucAP2IlTFMvndEW1p7EiH05ZOWH7LoyXgrThXlgjkevKk/5PPXq7RuQHyz
 tmvHkkNw9g3FJIWEIu8nfk88XKb749tMRwaJYgmFcKjo8U1sDtUCieeh5d7G0xKE8kit
 W7RI6XolfxxBQBt39FtPznRZJ+pZHdSWXLuO9jXqAXpjQllp1pFtTgKIFEDVOsV9R76w
 UuJUWAX9jvpPCgLweUpdkdbRHXNxACTGzLCJPNMaXmHYVyk1GLyzdLuZU+gDPExeIjjt
 0v3rwmCOS83ICrb1hhSmA3UcgdFXXXB0FVsVb6FKoF20FZbgJ3C3euM9r4pkNih8Wpbl
 3fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760651483; x=1761256283;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Pz4YOpWB++fH/A19xGy1nVcnwERh1c2QZKXWin+XvQ=;
 b=SIvK5CoPs4Kgg+WHKPvr2S7Uxmm3BJr8yJN7+sURChNVYwiGwAjtZBpu7m7mihkvdD
 keajNkwnHOjinyy+SonVbaWiH2+qxF7r+7jm49GnPn2nbT+6ePD17a5zI1EtSd9zbNtl
 mSWE5ncncSJCun1qkytwA5gJO5d7wUiYGOgo53o2ryAe8+IVQZIDvoTVTYsgb/tIWo6M
 LkNELkTwR+yRWN7YOxDvhcB9ZcPh8PH5bAbvF5wHvonSEENNCafpXo2RilTd0VYQLgiW
 bi7Yu/LFQO4/DJYS5w41Z5XG1beqm63OP72c1L6RspC1ZLJlvn9Rn7PZIeBmOqtNBSHH
 UAjw==
X-Gm-Message-State: AOJu0YyZj6dAIIVibpOf3Jy3SxBavgpze6k298rtVKmmC7ikCMDYIsjX
 gVOIY3683MwjVNehtQ3VXX+G8V0nh0sxlsLAdKahWU9jebt3k5DoD2RrmBYNeiO4M5TmXGMo/bc
 sGxKvd/M=
X-Gm-Gg: ASbGnctuevzT5HOP5ffDUXZ1mnUN8JfGejyyTOScF9bvSU2dQEZ8Pn5k5UUZh3uBneW
 VSMUcYiJ24LiDC8Zul71LKfoHmQNX6iZ+sriqJbbl+/89GGvY2ADrv2LbDXWCGE+GkQVd99VqYm
 Wv0gNTz9Z3SbyIZk/YQOhH5J6bsQ9iPZWRKfIvIsKk+vioYUUceH/Pnz+LsmGIVP4ZrflCsb2YD
 bBHeCDtNXkh/XzXMPJo6f/ONfHdc4F4jcB0y6+qUwfEh/eKVNH1kgMuO12BN3n4dyBlXbzuwTmN
 tywcbbvn6qk/9FczcAF1koR37FSdYo9IyaSBw60i7j00mCjPc1QDBk+VdCUgsLF31WtMk5X05g5
 pSkbBnqAQI5YMmVHXSQwwzzPqKbu8jjKV97GvRUtsSWflneTgY/8aCzlsprNNI3iNy6ibHs7At9
 oIefVjhoFIB9P8xIc8e/Dms0PD
X-Google-Smtp-Source: AGHT+IHMsl5TmA/CWAwxNRJmy/fjkgkxDLRJvKQLV48HEjj/a3TmXmyngU2pL7UzIBiPRbF/3cdVhg==
X-Received: by 2002:a17:902:d2c9:b0:286:74e3:3889 with SMTP id
 d9443c01a7336-290cba42e4fmr20216105ad.55.1760651483082; 
 Thu, 16 Oct 2025 14:51:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bb6626309sm3089419a91.7.2025.10.16.14.51.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 14:51:22 -0700 (PDT)
Message-ID: <9971552b-9c7f-44e9-9263-3fd08526e4d0@linaro.org>
Date: Thu, 16 Oct 2025 14:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub/user-target: Map errno values from the host OS to
 GDB
To: qemu-devel@nongnu.org
References: <20251015162520.15736-1-yodel.eldar@yodel.dev>
 <87o6q6j3oe.fsf@draig.linaro.org>
 <8d00eb96-97b0-42af-9e3b-645efbe909e2@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8d00eb96-97b0-42af-9e3b-645efbe909e2@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 10/16/25 13:51, Yodel Eldar via wrote:
> Since your review, I've noticed that Richard Henderson already authored
> a host-to-GDB errno mapping function in commit 7327e6023:
> host_to_gdb_errno:target/m68k/m68k-semi.c; it's functionally identical
> to the mapping proposed in this patch (albeit missing two errno values
> that were undocumented in the GDB manual until recently), but written in
> the context of semihosting for the m68k.

Heh.  I had glanced at your patch and thought "don't we do that already"?

> 
> So as to avoid duplicating code, I'm considering exporting the existing
> host_to_gdb_errno in a minor refactor to use that instead; do you think
> that's a better route?

Yes.


r~


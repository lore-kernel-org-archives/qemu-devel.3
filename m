Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A551CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScWq-0004Pa-JE; Thu, 28 May 2026 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScWp-0004PR-6z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:20:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScWn-0008UN-Gt
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:20:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso70016195e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779981607; x=1780586407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQeCDJf9XkK1KUgI5u7jbJBN9aNoHMLiDWvvMVDJxq4=;
 b=Ee8XDiP8EYtdKejs14APgNODDW+Fc3m1FUXuZxwOvBmJylZh7GMT4TAOLhE5sZ2b9g
 oj5t1GE6RsPkCOm+oWZ9SbBn2wtWc4Rs5JRvCzJFYX/6B3S1Ink2kSYxucVb/OQQUUzn
 3y83KJ2ECVIhu9o8i7JdeIVZ34fH48Ncn6fzqOCooUbKSHYe0kxB+BhnpEX/Q3apxwuk
 +QccMGEtn5ytLzvxJLY2nGb5vpBsPk6eoKgxf4Q3zqJq2v7+3PW9aCipuDS6aEIi+2l0
 wxtXg9CLNMeOlO+e/Utq0DD4uDEsEbj+2pEduesrCPDGcr4FSx+sWE7ctwLsD11KbbXV
 bE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981607; x=1780586407;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQeCDJf9XkK1KUgI5u7jbJBN9aNoHMLiDWvvMVDJxq4=;
 b=sShoNeddfMJ2tvKvNcWV4i8rhLIP0XKErVxA8e/cVfoc6S7gstCCKjKfb0ZsXWA3bZ
 +ol/zI/cXfNiifjNbfiNB2ry0kZ48xOY36XnkEKevs5kQe0El0BhRTvfVWvpgpCjxUWP
 /3wy5CgRTB1+HFnnJBIWUF+oDFtD43o9nCFJtEUigo1ZeD2C0488/TjNTKA1KnZ7skYb
 NYZavCv8cz8/ok0wvyvwO+Skd/mNs+UXYQODXeFEinWJLepTj0DSG96WrdC0dcqSQmNh
 mRrqC4NrXcpo5HSrwT3HtNn4Ba/YHJC5lAMmEFVCnqslYoUHITmThpe3e+i37jwSGojP
 SYzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EI2QLBdDaE9+oH6/ZEBpdHMXpogsl8shWhVd0u3h1WwFraib/E0OVlQg4GP5BkYRvqQQQBq4bJxS6@nongnu.org
X-Gm-Message-State: AOJu0YwI74JJsfiYAFESspaJFkKjnEE3Ed7C0o3zvdJHaJYQHndVrK2W
 jQPY84BJfJRXeUeSQQIs8ypUc/XMm7Y3T1mNFdf2kVsuF3NZZEKieUOA3Wl3dedMRJ0=
X-Gm-Gg: Acq92OFwle8BRvyd1vZ5YYWGsTKhgkYJLqO+P2I/1rEmrgnBRnm2nv7Ns/w+opHQhbl
 SxM8d8bj2hXdA6KuXSf2vceaY+uEMKWxYMpQI9zzV4djHfjhpO/yflYzte2pwOwAgqWTKge2tBc
 bPYOVtoQOfRZHztcZRKuvSKRSdM1OyinDhYLFCCrZGx5fVcaEiBNoPe2PDvmIHCi9MXNYo5B/Jj
 DBM9xPVbwc95zomglxyAk/YEEkFWbPGPMSZM1yUrcWNYJlQCBqZrJarGSqX4sKq+CJY3/mhEROO
 f3sqjiwOqoluW6kjaS6ilMqYCvhOlIT5N4JEGIiQUOQvw8w4lvqFTizgPjOMD9CNep913Cn7QKG
 5BV58hs2SqBdFiT4j5+jiXU4nidR2dkOeUcK5bYl/Nv69eDGCN3fmB29xhJfY3JK2W8prLBCrDi
 va5B68GpWJXU4o1D/OAlkYF9hxm3x/wseqpTrgNLpCFF2xr2dipHkbWavgaHEFMAsM0mekvDVgX
 JQ6
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-4905cd8d33emr308092885e9.15.1779981607362; 
 Thu, 28 May 2026 08:20:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b314dsm13300969f8f.30.2026.05.28.08.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:20:06 -0700 (PDT)
Message-ID: <278d2270-ee96-44c0-a6f5-5019cfa51a85@linaro.org>
Date: Thu, 28 May 2026 17:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: apply mod to immediate count of an RCL/RCR
 operation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>, richard.henderson@linaro.org
References: <20260528151245.845539-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528151245.845539-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 28/5/26 17:12, Paolo Bonzini wrote:
> RCR and RCL instructions with a count of 9 are the same as if the
> count was 0, but they generated incorrect code because the can_be_zero
> flag is false.  This causes 0 to underflow into -1 at
> tcg_gen_subi_tl(count, count, 1).
> 
> Fix by absorbind the call to gen_shift_count() into gen_rotc_mod(),
> so that the new function handles both mask and mod.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452

S-o-b?

> ---
>   target/i386/tcg/emit.c.inc | 85 +++++++++++++++++++++++---------------
>   roms/opensbi               |  2 +-

(Unrelated)

>   2 files changed, 53 insertions(+), 34 deletions(-)



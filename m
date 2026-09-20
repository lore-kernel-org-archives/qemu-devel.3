Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B72CC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PpY-0008B9-AK; Sun, 20 Sep 2026 18:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PpW-0008B1-Ci
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:14 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PpU-0003Xx-JO
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db22383fe8so14518825ad.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789942571; x=1790547371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e6dMJQtUUfPgOec7tgRpu9jRGrUyCH+yjPwH0gRdORI=;
 b=Zt4F4wPH5thXOTlsyyu+L5KqOBdLqcF4c+SXTb1Dw9UZMNn++X6VgqLXquv4DVdZZG
 h1nrHUecptRaw2c1xt9d+nkiOrUtanoyyHuLR7LHAROQb4zHU9wPqMcwo5tpFGF4oR1V
 3aI6s281sR2Zf2pjWzpOfv5NFwstru6HGZnxLKOb1ijbRP0xERnj1qwCimgypBeI5RKJ
 M7gpiAv6wg5jaXeGUFvBURimoNB2zImE5HgPKI3cq0Sa5Nzj+1cvGvMUzpiznGD5/uPh
 GregfpARcsTS08C77Puf6CNv1zchqlvs/RUcBoedjg6mWqhjWKfvJD0/Tb6+ODQ7X14S
 Uerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789942571; x=1790547371;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e6dMJQtUUfPgOec7tgRpu9jRGrUyCH+yjPwH0gRdORI=;
 b=R2xy82LWkDYXHpdlrKqJHVAzfxCaZlqUnoLE6HIqnk7jLdB3jl+fQpvztd41jcYrwZ
 R8c5iSeHB/J/5NF9sWGrY+kMfx23OGOWtHe8gVVcqdTUNlXItGlB9QNSO9zebd7fwKM9
 TT9s08fTvuig1218oNl8xEibRbonEWNwcttOI8cKbHVybMKoRvfqwHmCF1rUXLU8u7R9
 PZHL+n39znMBlpkiBvDheOy8M47WXrYO93udGbwTQkbm7AHeGoolLNMgLGaMl1zi8uua
 GYkWPeY3E0NcS/Jaqx4I0d9Rwg7+vAs12gh8USqEStVkt74adDjZBZoyoh5arve+R0NG
 fnpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT0haB6Mg+N3pyO9ip+JHsU7BHG0Zlj2Q0xiF5MEkrDULMKhU6CGMXYD+jNtukj2XkjHWhZtwoOqyE@nongnu.org
X-Gm-Message-State: AFuF++l/S1AMJ2ey+sMevLKehKLVUoLfIduaKKz+tWhvG71r0WRzWUzx
 178SKm017ewOgxcRWJqVsMrTlLuzuOSZGGcEjoGDMc/5O1A2HwE1aqOz+IaTvl9lFPE=
X-Gm-Gg: AYBFou02X/3hcGNtgpkQ0yeArLym31b0fBwSHvL6UxvU99jT/UjCgFRvYR+m7J/+QTW
 HA43Rk70B8LZNzdYqKxURMI/Ezq7D4RRui+d2M7/rqYomv7tYEeEWj7R4fXQUCB91p8oF5cVXMg
 GVYSIXo0wjaLAtfjUcrxn1dWdjTLX+KKDYGlss3E/mm+wBf4DmWP/VeaSan3lDKcnHBYPziRA97
 YeH9mfZC15hqbyox8uDdFj29kXveUTqOOjvPuyvUjSE6wCHTgCPzo1Y/LfBIFxaDxpE7RwMBS1e
 QiHlC78K1MO82XhsCtizZfUDfsyDQFSRwRKqbkOnx+TzTzayWUedUtvB6RFL3oU6WPh+Jj06udo
 YxXpbU1C3kYRUe0NwVNgAQONn6FAkPdEA6N161tHR8bHaNymOAPZHTYPtuwPKCROLjm6Wbl8c6M
 h9ROVBwSY/3Uu3gS8C1Fa7w6hdFDofOu4td8T0EFJ8Mtk98PehIyYGaCr0RFlFNEtlM+zL0ce+H
 FkVXN6a9bdSPKmGSvNlIUbfZc2Gs4mPmZL3IxYOOJ6dNQP+WTg5+9cDpXPN
X-Received: by 2002:a17:903:2f84:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2ddb1af51a9mr132214125ad.13.1789942570912; 
 Sun, 20 Sep 2026 15:16:10 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3313d907sm13753038eec.11.2026.09.20.15.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:16:10 -0700 (PDT)
Message-ID: <cf3e280a-43bc-471a-9455-5603dd3686dc@linaro.org>
Date: Sun, 20 Sep 2026 12:11:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] bsd-user: Move tb_flush stuff to
 begin_parallel_context
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-7-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-7-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> Catch up with linux-user 430014bee7a6c26a70e9f3854428843d5918cdf5 and
> impelment begin_parallel_context. We'd already moved to using
> tb_flush__exclusive_or_serial, but need this in several places, like
> linux-user has.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-thread.c |  6 +-----
>   bsd-user/qemu.h              | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



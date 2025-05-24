Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078C3C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIssN-0003W7-22; Sat, 24 May 2025 13:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIssI-0003Ve-M6
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:41:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIssG-0001U8-SB
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:41:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so6544675e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748108491; x=1748713291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q//lWdOdbY8ZKKxI2U36hu4BGo32PvLxLkS1qzYUxJ0=;
 b=vYZzQCC9GgE+GmHgG19uT18n13Vf0YKK/3K7hmTEl5jg7fXC2sR8YntfoHuj8gD7QF
 AztpjdJktNt1ghp1WeUKIMutNYhb9CSYWKm3RCuw+A5rb4tbR5r/AR/NpfED1RcH7BQb
 JZlWavG2fT1+CeGza73UXt1ryEGW3ue6uTSwHbYy6ySUMYGIF2mzL/i4JolSPI5DkAKE
 QVjR3mi9Qvc8/Lwv+1MvL+z6lnvdTqWuEIdR2XFqE34EYtOk8SRH3J10lC7zlu/yvpiD
 rZnVutz9hnV4ttS6pQ0Rvh+A3TL8i0FsUqObln3x2Je9ear7L0nIu4Ndr1VOWs24+x9Z
 OMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748108491; x=1748713291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q//lWdOdbY8ZKKxI2U36hu4BGo32PvLxLkS1qzYUxJ0=;
 b=tA/7N7L/KeaZY60YSFtV05cCCgvFUkit32lQ4B3vUQXEwlkKTaL8xHRdbvzeIIf8bI
 78JHM0S3RG039VxSSGARXkngzJcbF+O2preNHHH3cIdzcx8/8vKiylGW6JbxCI5BQMVU
 8j9evJx+eHqn6zQLeDqlc5q//lRCTrC4WvbxtPX/4g6DXutMyFRRQx0xmivmIktNDMKY
 5BMh/Y6KnNi81RZO/wYpS9p8XfEAmy0Lsqnsecr/jB9T5xVGcVe7ZH4mK2SBvg+VELd0
 7Q7Kkn+tNSCW5Pv4K+cMY/rgpiuTq431/TJbh7dyMXuJueGYYuSJ4PGDygo8hKbzDo24
 BKdg==
X-Gm-Message-State: AOJu0YydgwRNnRUh0UJqc+z8UepaDbhBvU8fo/Rw2THNPW1ZmRpBwEZc
 KTvj781/TssDhp3IOZRQxk9tq6ujZSfXEYjBdVBrPzOa+zgOoE2dRWBFmu2BR7bXSNwbx9DWc8f
 itkykYQvRBA==
X-Gm-Gg: ASbGncv1szCpNyX2OOtvcDR/+jMyv1NiqLfxcbVSS+D+eXR7b+0gZcWtE/4J+WKgfG/
 rki92fbzh4Hb78ql0y0DMQ4xjPwarsuXYTHs3v+dy3zIiyTb/6XSHBMzG622h9SzUbzwuKF9PhT
 2Aaa5Ed8zJnvnphpATW2c84wiRLUmXhC3wnYK3uL06qn0Zo/7QdPmfulAG/3OyohVflWm6ZnR88
 ga6Go9gsXL+f24C9B8VnwlGXYQ4x9giN9frrxgaiRZ2u+/t5CE8qA+HmIRwwvAcdIVSOdAXzK7K
 XuqR7Ms5KwovL8dRx9GoZigu3rGPGJA5Ps2IQmi5cJKWwTt3jPXip7HKQOaZ5zTsJg==
X-Google-Smtp-Source: AGHT+IHlYRmtNHbvBlvCn+Jrn4L1z5AMGORVmlHEOFQlH7KH6+TrneK/+EFyPZmBb2cPoCr1EVaF7g==
X-Received: by 2002:a05:6000:4304:b0:3a4:d0fe:42b2 with SMTP id
 ffacd0b85a97d-3a4d0fe4e3emr1303977f8f.19.1748108490756; 
 Sat, 24 May 2025 10:41:30 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cf4c6b1fsm1968356f8f.19.2025.05.24.10.41.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:41:30 -0700 (PDT)
Message-ID: <e2d60dc7-10b2-4a1a-a7fa-3fbb89fb77d3@linaro.org>
Date: Sat, 24 May 2025 18:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/25] target/sparc: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <74a9841af043f785757ad9c6cb585b51752b15f8.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <74a9841af043f785757ad9c6cb585b51752b15f8.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/19/25 16:20, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for SPARC (32bit and 64bit) targets. We treat
> any interrupt other than EXTINT and IVEC as exceptions as they appear to
> be synchroneous events.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/sparc/int32_helper.c |  7 +++++++
>   target/sparc/int64_helper.c | 10 ++++++++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374F3C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Tf5-0005Ky-Vp; Fri, 18 Sep 2026 04:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Tex-0005KW-HN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:09:28 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Tev-00026N-Tf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:09:27 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so457072a91.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789718964; x=1790323764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NQZlfcgIg3DgBbK3PHxARnVQltXZhvK21nAAdnZKkks=;
 b=LrOT/XUxDpB2cC89Ef2Hz5YjQZHEMjUK9XItw2TrWuiuD1vLJdoERDgdkl3zEun1dL
 yz29hqgx9eSS2gKotgC0Pgtz5/72dCynYVsrs9vkbOzqjms5405UKgHQehk3ZU6lEXqe
 fpPfgqNFBWpNegn4i+NV6XGughdogvr8+jpf1c0LwAIZPilG+5istRRDF2AU1S3PwNPV
 ecuhjEO71jBgBR7p4TlPD6DbDcn56eh4FzCkhXJl8Pn+XEQ8yxHGGhFPA0a5Bolvgg7s
 xaOlaHbaM94i+fzOBAkQ7NS9Zb8t/PmEoB+zi0PvZoWjlfgiTt8N6x4YHkxe0/xwsWzs
 QXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789718964; x=1790323764;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NQZlfcgIg3DgBbK3PHxARnVQltXZhvK21nAAdnZKkks=;
 b=fnywgHp9EDBB9rkl8Al0ptbu+hCTPGkjHWITqf5tA+bRrn9B6/RW5PfRljZ5l+6MSB
 CHhw/j8hN5DUxfTee1gNyxBSJzz6hlVuSLwDYJi2QBlBKAJIYkZfAjM5b8G1DCBv6FZw
 Y1onUeZCsDPVTxDqj3pMo81kpFi5Dr6pcDpLm18DjqNVTkkrJoi5aw3zm/sPCtFDIlBp
 fVbWyqxtgQVFL7ckb9Cwot1/Xr+S/KjMHQ71jFVWm+ilCy60M21AtUhyTF4dMBebmBq1
 t02yPFaKTXWd2cXnexCTroYfY+gCKLoI17xngMNxb7eBESk+jUnDTVNVBl/qBKKbAN8k
 vGpA==
X-Gm-Message-State: AFuF++lggpD5AJZ5DdmnSpQHqJAe0fggUOM0OoKQKyB6vewzMtOeGYIn
 CgXGZ5Yfl18ZHm/ASCXCnE5wqHF/e5DV08A9KC+lIUcRwY3UiIUWdecFwlw6pDKvYsc=
X-Gm-Gg: AYBFou0+R/O0EO1HvWawOgfGd8X7QH4l+dSqifCdOdoeVicahhcUQdmPJUZFYchl/Qj
 u63M/rpq21ASOMQ+uSiitrPcvgKhPh+jXybx3fFtXz2e3TrRxXQ0ZtGObyev0op9wiLQHfCPaCY
 sdVrSPj+A4hG3MRJSaYT0tlQ51rza2sWZSzIwRRiGF3bxOZhxJqO3xg2fprEVqyAfvbqMlTD0EZ
 VGydTRKJU8qcwl3Q4hRfgEaD9F/2FGSLsEQ/ENM4EiQA2vkblF6lC57bXlTiGifZNgxHG5fKl6v
 Lk/5xVEh0y11ShSCJ+y+NRrmUwB3RTJZDXXQIj7HWC5cQagbe6X9hdJcLs59Kvf9hM9EpGWZJw4
 qEay/Aj/rRK0kEgcv8KOquJj7WQZpIYQJJbLaZ2mJxJI0Kv92Z7lXnWqAS9nsmLt6Hok9W3WaJr
 sCdg1m3u1FMT+OOd31p37CnuH0Ifs8ds5waP/C3ducWT/RwNeBtzy6b/BHz/urH9ea0mvL7dHXf
 oMzFofY2/LhYZS7N20yCo3fmjXoN35ejLGZhP6NI08sm5tfYSk5s6npHMJcGw==
X-Received: by 2002:a17:90b:314c:b0:398:bacb:1137 with SMTP id
 98e67ed59e1d1-39e54e78990mr3921785a91.19.1789718963605; 
 Fri, 18 Sep 2026 01:09:23 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:a77b:e7c1:e15f:5180?
 ([2603:800c:7900:ed00:a77b:e7c1:e15f:5180])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144ce065314sm2862368c88.14.2026.09.18.01.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 01:09:22 -0700 (PDT)
Message-ID: <975a89d3-3614-494e-bdc4-3d892658f095@linaro.org>
Date: Thu, 17 Sep 2026 22:09:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
 <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
 <CAE2XoE8X8cAS0CsQ52pgBXsrbND14bL03SehRnx64tCGSOxrWw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAE2XoE8X8cAS0CsQ52pgBXsrbND14bL03SehRnx64tCGSOxrWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
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

On 9/17/26 18:06, Yonggang Luo wrote:
>  > (1) Put the comment before the implementation, not the header.
>  > That avoids whatever you're concerned about vs patch 2.
> 
> Indeed I tried, and I found basically all tcg's gen_ function have no 
> comment(detect by the auto-tools),
> and it's parameter arg0 arg1 arg2 that can not understand at all; and 
> can not link to the impl
> helper_* that defined as HELPEP(X) that makes me reading the tcg code 
> very hard.

Ah, new-fangled tooling.  Something I don't use.

To me, the only thing that's interesting is the implementation.
That is, helper_foo.  The wrapper, gen_helper_foo is not interesting.

Since I don't use it, I'm not sure what to suggest.  Putting big block 
comments in what are essentially templates does not make much sense.
Is there something the tooling can use to cross-reference the "real" code?

>  > (2) Don't pass an extra argument that changes behavior like this.
>  > Better to have two separate functions, each doing one thing.
> 
> how about gen_helper_raise_excp and gen_helper_raise_excp_restore

Sure.

>  > (3) Maybe better to place the functions in cpu-exec-common.c, so that
>  > the compiler can see all the definitions at once.
> 
> Do you mean do not use  DEF_HELPER_FLAGS_3 at all?
Absolutely not.  I meant put helper_raise_excp* in cpu-exec-common.c 
instead of tcg-runtime.c.


r~


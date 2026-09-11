Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B28EC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59z8-0001eD-O8; Fri, 11 Sep 2026 18:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59z4-0001cG-PK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:44:38 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59z3-0006Vb-9v
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:44:38 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1541542a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789166675; x=1789771475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DLq4CuQQ+eKEUroQpPWbkppZr1RZq+cnKCOzln4hJvU=;
 b=qPIojbTGJixgi1vC+6JZVPQKno48gicBPRkw6wIxUku1p4YJkJ4uLPxitqwyYiSHJK
 GHea35D3dhlFuilsxo49AhQgKfTwwS6U/VQddbnTqNE7B8SxdhaUUhfKuUxWQ9Puu39q
 u2u93i5taVmpdTeV2+GmDCXOwbSHcWRUvDm2SsrVJJNCask25m+FX10PlKH6+iIaUvN8
 QyjmiFbu+Khl/jx9jh5RNuoOxfMJwECtvXa32SOMoAHbJCOOX3+og+hLMUmDKU0YS5zm
 9CG+19TIhsixrQa/UVYZi02ldAM/7guNkVsglbKVMxpOGS8YaAgp7YWP7p7GPCFhIQwh
 CqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789166675; x=1789771475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DLq4CuQQ+eKEUroQpPWbkppZr1RZq+cnKCOzln4hJvU=;
 b=Vw70RJXV/xxqAqhuOrOND0cVtk/3QwFRTov9Jxu04welPZWbJxALc1kQfqf69lVjCQ
 cgvTrzI6jUhb0qstUHn3EZq1CBhutWYM+SxerU0KYhQ8qJNlaP6PYKAXnmhGkFU6VVEe
 yaEM8NLPlVwlrMpfnH44fvuy85oDX6Nl0EeGtHZ32WfMkuhVtX7kaaPZxWB8GIsaqcNw
 1DaZZFLIwQEoVwHouj9D/ORFoGYhi3nkZin6cnxP3cujwlBn0NgnrS0UlGr2g+7JN2dU
 vdtYP8FMS5VZAh8R2s5pKL8UUkNqTeDwfMXD3Oh3Unxt17zMaDnrG3aCTvg5femgXwrY
 GO7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMn5DDU7Ik7LnQ/HyqtloshkANnlREx1FZa8JBTyu+wH3SBfU6ZkSu3uyDGIZF+PIUrfD90wKGLgYT@nongnu.org
X-Gm-Message-State: AFuF++mQY/DF7el5+pEclOMYp0usZfdZm0PDnPobRwuDI31mTIYV7GfL
 HRWc2PgdHwyvJQbRMOSzQH7fwfyPw26hGQ12bAW7hA+0yMXjOgFAdZXU7HDwnhqAwQaTrCzAgb4
 a1C74
X-Gm-Gg: AYBFou1YiSvDgIL15QmEgt+CB0rgiDCN34bI/sskYDzBjggw05Gy7j0NsT/0T3ZJDlb
 qBWIg4hLrzxqs7aXNliKe9gGVgzzsoTQAgKGDraoY899ctapQYSzlHaAHPHKP0hkTEJ5kXaRAUy
 O8MUVMW1OhJ0Py53PtxQPkJR7hLH4qTIqqgDJLvIqqlbvJOEy1gV0rP6b1xaMnPPNvdEo22oIO7
 tNUnXJ1YuaVlcGOzbeOmGoFjKmjef299Ti61ogr+FTtnNZ5UFBQYO1Z2M/ShKRBHNIQxpwzzc5k
 bDOIwwYBIMtTmHBY4WSQDwwJULiwD4pPdq30MJUc2OZLyQAGjka5kTzqoJuw1vTwSiWzdRRniOo
 EDY0HYNfDTH7/BOAdgs+LdY8hZ5A/BWxXuoQ5mgNVJvA9wDViwK9LIbUMlArUijRdjNxfVKE9Vw
 n71xxa644Xcw6jFXS4sm+t8P1h/e3YQaASIsAW4DlibbtBMFEs/kSJ0pkXcB/8GTWFUQNKRqkDx
 0m+9YuTtGIEtq4+zNY/jZAYzXNeopGVmODgn858pBTgVW1rGDGgcZzAqwkW
X-Received: by 2002:a17:90b:384f:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39d9c1c016bmr10522116a91.12.1789166675142; 
 Fri, 11 Sep 2026 15:44:35 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm8032919eec.30.2026.09.11.15.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:44:34 -0700 (PDT)
Message-ID: <10e98ed6-2cba-4554-adc6-80ae46f51ba9@linaro.org>
Date: Fri, 11 Sep 2026 12:44:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] tcg: split out _var forms of gvec logical, abs and
 min/max ops
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
 <20260911204334.1264922-2-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911204334.1264922-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 9/11/26 10:43, Brian Cain wrote:
> target/hexagon is about to address its HVX register file through a
> runtime base pointer rather than a constant offset from env, in order to
> share one register file between several vCPUs.  The gvec ops it needs
> have no base-parameterized form yet.
> 
> Split tcg_gen_gvec_{and,or,xor,andc,orc,not,abs,smin,umin,smax,umax}
> the same way tcg_gen_gvec_{add,sub,mov,dup_imm} already are: the work
> moves to a _var function taking a TCGv_ptr base per operand, and the
> existing entry point becomes a wrapper passing tcg_env.
> 
> The aofs == bofs shortcuts also have to compare the bases, since equal
> offsets into different objects are not the same operand.
> 
> Reviewed-by: Marco Liebel<marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> ---
>   include/tcg/tcg-op-gvec-common.h |  45 ++++++++
>   tcg/tcg-op-gvec.c                | 184 ++++++++++++++++++++++++-------
>   2 files changed, 189 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


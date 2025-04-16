Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46061C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Hk-0007Zd-Dh; Wed, 16 Apr 2025 15:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Hj-0007ZS-Kb
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:18:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Hh-0006Yh-Ct
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:18:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so416845ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831134; x=1745435934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NZxyKNKh+aezQ2wPxhV2DaekgH0vbRCS3FmFq9ceO6A=;
 b=SCsWTVRuNG6PNp3sQX66LY23Tf0uegBPxrUfJEBy71E3kqeWKnBvIKPN5h4EjnT8Gi
 sJDqFOSbPQn56MiVqI0KPPOJq/v7vb3XWCad50sAsyRtj1Mw0Ne2aecQg4vkaRwuTh9F
 HSwi8ccp3vNE1th/eJ5OMz3MuC8uzTuq/vUUF5aNIkPBsezCfzUmYsOWZ3idwbK3qr9o
 VWvF6fgWW5kuYolb4O7BhRx7wX5T96P40fWXZ4qogtRoZqGCFDFAZfznuRs58/2X9Nti
 Ra1UHudNzH/Jsr0hWYReHkUrRNnsqsV7Tgx32DDG3cLvtcp7hGP2LmNhh0Sm+dAthDUT
 OJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831134; x=1745435934;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZxyKNKh+aezQ2wPxhV2DaekgH0vbRCS3FmFq9ceO6A=;
 b=sUeA8bd0cRLm/F5SlXn9uU4/WfJ8ilJgt5CmEmcNtOY6lWusszv7Yw5WkQCheiXRPe
 6QZkWflvfnpKc+Ej7gOvBvMvGWNHUtJMLf/ju6wo7W3n78VV582yzdLOmlEzUqhAjpY+
 erYDQhYWxWOXjq98VchcxzGfl41jRpRwnpAVu6DNGIy90NvEdBFDQyvQiFiMr/gmEtgm
 exT6g3CAWCp5Ydv2XMGTO+sfEcqQZawcinh54os+X0c9V7JR5tok0lR2hiv194Ib7/W+
 2dKLelcsycMFlcnAeIJFmsimyCpa7QvRVIj4CukiHU9LzDfzo+Oj6Qomt6Qvy6g9Ypd9
 5wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQmxIj/4hwd8DpPco/bbmiH6+WoEyexp1fnSxP3mTgQVgaqj0TYNbtXbSby49+9XDYD+WF4pc53+H@nongnu.org
X-Gm-Message-State: AOJu0YzcrhxC2vlWv/dEu2nXQz8MjCQNoeyuHS7+/xbih+7m9G9s0Yjh
 GtjJeCxRBZYjp0Rty6umDz7Z50Ufd+EffBkkLpQfLhWD4UqFm5Uxsbn2Bze5DEw=
X-Gm-Gg: ASbGncsi81ceaAEEpoJOeNSrk88cIMT+Hq/c24+GuiwpflosIT3fI3krqlmKK37+Pa6
 IaLd35mzn9FH7tjQivgNgMMpUC7N0LOD50FgY5Hkpa93CMCTdloIE/kczd+QFT63fqwbR3xp4RL
 Cy8551kCM581Lh6cXIe4JQS+RitLzc1MZ2v4amTAFjeKa+fiGaZZvfZHVOjccYSBxmYyawhm9jv
 Y/FDIhzIBgF+/TlNY0MkudiSGaMyoQvORyPmVifOQ4/bDrm5Jh7O9Sf2ks9WmNPe7BqJpMfJYh2
 WXgkWEpPcATVh9oQVXqpa/l+EfMVV9qpyKCLVB1ge6KG4246wY3+/g==
X-Google-Smtp-Source: AGHT+IGkE9MwZnHcMq+UdjW95+L73/4Kc9WdbVE1S7wky3CwSwxA4wd5loO+E6w0w4wAKyCsbnP9/w==
X-Received: by 2002:a17:902:ea09:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-22c35974249mr50006165ad.40.1744831134326; 
 Wed, 16 Apr 2025 12:18:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6df9sm18111215ad.231.2025.04.16.12.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:18:53 -0700 (PDT)
Message-ID: <010c87d3-e1a8-4c57-9e24-cefa08a1591e@linaro.org>
Date: Wed, 16 Apr 2025 12:18:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 143/163] tcg/s390x: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-144-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-144-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> We have replaced this with support for add/sub carry.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h |  2 --
>   tcg/s390x/tcg-target-has.h     |  8 +++---
>   tcg/s390x/tcg-target.c.inc     | 50 ----------------------------------
>   3 files changed, 4 insertions(+), 56 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
> index 0a991f6d5d..f67fd7898e 100644
> --- a/tcg/s390x/tcg-target-con-set.h
> +++ b/tcg/s390x/tcg-target-con-set.h
> @@ -45,5 +45,3 @@ C_O2_I1(o, m, r)
>   C_O2_I2(o, m, 0, r)
>   C_O2_I2(o, m, r, r)
>   C_O2_I3(o, m, 0, 1, r)
> -C_N1_O1_I4(r, r, 0, 1, ri, r)
> -C_N1_O1_I4(r, r, 0, 1, rUV, r)
> diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
> index 4a2b71995d..17e61130cd 100644
> --- a/tcg/s390x/tcg-target-has.h
> +++ b/tcg/s390x/tcg-target-has.h
> @@ -29,13 +29,13 @@ extern uint64_t s390_facilities[3];
>       ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32       1
> -#define TCG_TARGET_HAS_sub2_i32       1
> +#define TCG_TARGET_HAS_add2_i32       0
> +#define TCG_TARGET_HAS_sub2_i32       0
>   #define TCG_TARGET_HAS_extr_i64_i32   0
>   #define TCG_TARGET_HAS_qemu_st8_i32   0
>   
> -#define TCG_TARGET_HAS_add2_i64       1
> -#define TCG_TARGET_HAS_sub2_i64       1
> +#define TCG_TARGET_HAS_add2_i64       0
> +#define TCG_TARGET_HAS_sub2_i64       0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128 1
>   
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 36293d0f42..09c7ca5b44 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -3064,23 +3064,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        if (const_args[4]) {
> -            tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
> -        } else {
> -            tcg_out_insn(s, RR, ALR, args[0], args[4]);
> -        }
> -        tcg_out_insn(s, RRE, ALCR, args[1], args[5]);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        if (const_args[4]) {
> -            tcg_out_insn(s, RIL, SLFI, args[0], args[4]);
> -        } else {
> -            tcg_out_insn(s, RR, SLR, args[0], args[4]);
> -        }
> -        tcg_out_insn(s, RRE, SLBR, args[1], args[5]);
> -        break;
> -
>       case INDEX_op_br:
>           tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
>           break;
> @@ -3124,31 +3107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_add2_i64:
> -        if (const_args[4]) {
> -            if ((int64_t)args[4] >= 0) {
> -                tcg_out_insn(s, RIL, ALGFI, args[0], args[4]);
> -            } else {
> -                tcg_out_insn(s, RIL, SLGFI, args[0], -args[4]);
> -            }
> -        } else {
> -            tcg_out_insn(s, RRE, ALGR, args[0], args[4]);
> -        }
> -        tcg_out_insn(s, RRE, ALCGR, args[1], args[5]);
> -        break;
> -    case INDEX_op_sub2_i64:
> -        if (const_args[4]) {
> -            if ((int64_t)args[4] >= 0) {
> -                tcg_out_insn(s, RIL, SLGFI, args[0], args[4]);
> -            } else {
> -                tcg_out_insn(s, RIL, ALGFI, args[0], -args[4]);
> -            }
> -        } else {
> -            tcg_out_insn(s, RRE, SLGR, args[0], args[4]);
> -        }
> -        tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
> -        break;
> -
>       case INDEX_op_mb:
>           /* The host memory model is quite strong, we simply need to
>              serialize the instruction stream.  */
> @@ -3643,14 +3601,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(o, m, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_sub2_i32:
> -        return C_N1_O1_I4(r, r, 0, 1, ri, r);
> -
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i64:
> -        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
> -
>       case INDEX_op_st_vec:
>           return C_O0_I2(v, r);
>       case INDEX_op_ld_vec:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



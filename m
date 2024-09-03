Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61AFCD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUse-00007q-JG; Tue, 03 Sep 2024 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUsd-0008TP-1D
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:51:39 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUsa-000641-Le
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:51:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cd9e634ea9so3618038a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375095; x=1725979895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qvHojdF4lJZLPbBC2hJD3b76MJjEtK91JsTBBV1dQYc=;
 b=ZoJzo3GNqaT9SjC/MrR4mLZZRA0XRCcmqAe/gADU5JsJWui+I/QSXCLu7bKDts6BRG
 hLtzZvqCkSZdr56WOBqMIoGAKhWKGomtXg0nTKqNnRf6OC8W9sHkzhETXAe4nUdWlyu1
 A+SZ8woteZoiSCeKS3jYI+F2tTwkwo9Lw8tjx7l++Ox+TfITUYEYnW7UjsqOqRGpfcvN
 a/EzVveeJ7M6+6rwKYEA9ElBgSXGDZ4/cNNz6efhCwczxXTHh2jv+XwSCrGmsozdGuFQ
 mSBmZAxKkE5c/f54YTi8xMKSo9TWQYKzT2FPQHa1b0t19ylRVoQ15c3svnJM5KUlnwfP
 9PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375095; x=1725979895;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvHojdF4lJZLPbBC2hJD3b76MJjEtK91JsTBBV1dQYc=;
 b=v2A3nMeCcXzE42tfsmNbkFjIttxGHmGjIWldY+viA/RpGgD9o0AB6sko/a0e2mSHJk
 8kAfDhXpvuzLGNBDqZnsd6l/OJ7yLcDBBNb/uQAAmjRejiPVm1IrVVWbLLvvpR2ZTkPf
 TSMpNivxFhkByUPnORyxtg6ooxklC6V3QpbSyFMwS54W4NtrMXn36GlLOa7QTr+26bcO
 940LaiHXwRY8Kinaa0CDT+QWnoHbkE0ovqk/bza5OIxduVUWaSuYNDxUWM+wWAyEmSck
 3tbZZdNZMJMmlJvAS1GC7dE5zwiLI70ZT/DaQhFuDySfAIwJVYH20+6+O1ww5sNncJwO
 zpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO+RAG0msEi6TGMuBT7ivDebkcarUnq5uw1H5fD+vozBCUMmOa8nwLW+5MHOZer7BEQQPV0Xx5s33j@nongnu.org
X-Gm-Message-State: AOJu0YxpV6lKlLdzST0wwyzDp1LQg8O4IM7cWgpmFLzGlaWCgQqESuqo
 WQonxu50g17xAoygeZcU2pjio1hwJJv+8GkV6mC/GEaEfxSHW7Q01beX6p2X/yQ=
X-Google-Smtp-Source: AGHT+IHFDc2JYZBnpNQtHOGBmhHIsqg30RiS2RhzNzTcpqMGzECWf948NXJtfnadLdZhYgrpH7joaQ==
X-Received: by 2002:a17:902:e804:b0:205:3e68:7359 with SMTP id
 d9443c01a7336-20547c0cdccmr100124325ad.53.1725375094770; 
 Tue, 03 Sep 2024 07:51:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20689095700sm19620765ad.19.2024.09.03.07.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:51:34 -0700 (PDT)
Message-ID: <181d95aa-9a2c-465b-b549-076572db601a@linaro.org>
Date: Tue, 3 Sep 2024 07:51:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] tcg/riscv: Implement vector cmp ops
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-9-zhiwei_liu@linux.alibaba.com>
 <629e9969-157e-4f58-b48f-52aea4c0c48f@linaro.org>
Content-Language: en-US
In-Reply-To: <629e9969-157e-4f58-b48f-52aea4c0c48f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/2/24 23:45, Richard Henderson wrote:
> I think the first implementation should be simpler:
> 
> CONST('C', TCG_CT_CONST_CMP_VI)
> 
> tcg_target_const_match()
> {
>      ...
>      if ((ct & TCG_CT_CONST_CMP_VI) &&
>          val >= tcg_cmpcond_to_rvv_vi[cond].min &&
>          val <= tcg_cmpcond_to_rvv_vi[cond].max) {
>          return true;
>      }
> }
> 
>      case INDEX_op_cmp_vec:
>          riscv_set_vec_config_vl_vece(s, type, vece);
>          cond = args[3];
>          if (c2) {
>              tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, a0, a1,
>                             a2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
>          } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
>              tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op, a0, a2, a1);
>          } else {
>              tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op, a0, a1, a2);
>          }
>          break;
> 
> This appears to not require any expansion in tcg_expand_vec_op at all.

I knew I should have slept on that answer.
Of course you need expansion, because riscv cmp_vv produces a mask.

However, I think we should simply model this as INDEX_op_cmpsel_vec:

     case INDEX_op_cmpsel_vec:
           riscv_set_vec_config_vl_vece(s, type, vece);
           a3 = args[3];
           a4 = args[4];
           cond = args[5];
           /* Use only vmerge_vim if possible, by inverting the test. */
           if (const_args[4] && !const_args[3]) {
               cond = tcg_cond_inv(cond);
               a3 = a4;
               a4 = args[3];
               const_args[3] = true;
               const_args[4] = false;
           }
           /* Perform the comparison into V0 mask. */
           if (const_args[2]) {
               tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op,
                              TCG_REG_V0, a1,
                              a2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
           } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
               tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
                              TCG_REG_V0, a2, a1);
           } else {
               tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
                              TCG_REG_V0, a1, a2);
           }
           if (const_args[3]) {
               if (const_args[4]) {
                   tcg_out_opc_vi(s, OPC_VMV_V_I, a0, TCG_REG_V0, a4, true);
                   a4 = a0;
               }
               tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, a0, a3, a4);
           } else {
               tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, a0, a3, a4);
           }
           break;

Then INDEX_op_cmp_vec should be expanded to

     INDEX_op_cmpsel_vec a0, a1, a2, -1, 0, a3


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F098C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oRc-00080v-FQ; Tue, 15 Apr 2025 18:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oRa-0007yb-Us
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:07:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oRX-0001wj-5P
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:07:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so5479189b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754865; x=1745359665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qqo+DSXUZJcvVYShZcrD0O3lK+GFp/4/gpJWoBuCaQk=;
 b=HMGe52iFJivE7lEoHt6pEf5BL0De5scE2AKQmjtR1AhKe7tKxIrueVjBsCTvXJ4Ncf
 Vl7HYmgteIigeNul6ICau15WH63Qeycxr4GMWNkAEeVU4f1Z+Qym7wpFqbMq9cTqjUQd
 JCv4VsJzcM2XiTTknGrxTsLxMOrHQX2k1urLkzM86C21TIs/zPh8eRKXfwoGS86EsSQS
 K5Ld9YMUQmo8AoYpZDevvUIMfiHgqC9SkfS8FtnySJ0Hu4CUpCNrY+oIuxBR4+IDQV32
 kNrIaSWKnjPMbtrLJ8UYNoxRg47+bTx662eWFQA1VjZrAUrDeUEdnKz0GzwXcDQiKvfK
 /MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754865; x=1745359665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qqo+DSXUZJcvVYShZcrD0O3lK+GFp/4/gpJWoBuCaQk=;
 b=D6OP3Z3iqr2blF1RTmdQWPNZTfmu7PmkwXrSvPjlZ7YABnqcktBrjuxn4gojWmm0Ys
 5mkfZj+pt7xmQ2L3Mt9NjBXIhBKyYRfCUDONF+KENmvx5Q8tsf3fxZ7MBr8UVrBysWiD
 khM1mwuvTOl8H0Zd8TUzIaAaxQgoLHIjRogsiYTLKywrZ538KoxLN3LRzUlBikRVA2SH
 Kc3NLQn7zlVhxOiZnFf7CinC4Mgq2JW/CEn+6uaFO3F079d4VYOhWX5prmBTNPYaGg2N
 7cGJUONTBvFJvvM+rqf3SzUpNZXwF2H6/GBsa/adUwF3Lztiy++QtcZeTgTfj3EPcj2s
 YeTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa+bLCxkwzFsNe6ugQnIfafSDM8PE5uZGrgp4Cfxjod6pQWVGHSbsS5ZqAGq7D3NGMNV7EzebD0FjL@nongnu.org
X-Gm-Message-State: AOJu0Yyb2KtO+pevZQnijxDn2s4CLN5FvQ7CjOyR92faO5wYF0rWiO/A
 67qnKvQFxT1+KoUp+xSsSPeWoxwLqRJQOKcXD/iktBX602yTwhGshS4JwE9qaFNkRqBROJ1rEqN
 5dic=
X-Gm-Gg: ASbGncsYH2caeqac20VzI6wcQPdvU44xnpJCNyAlSVFRtOyQPm+54kfQ0k6qxb+v59f
 hSEnvpizQ5xs1si79A4JxdSbe0QElW9dtLbXxqr/AOxeaPJdY7JfhVTcZyKe/NEjYkBnlHz6C7x
 PGyWM7Mp7Mh5hOWfnbM/S7tg6rJf6oebKHSq+gPL1t+uNYz4bRVnktI+r1w2utU1qs582IP/eYY
 lQI72w5h5TcMroUf+INw1lolhp2qXLV+rRAWo7V//iAxeSk9P1eF/MpveBUAUfOcDmjdvJctGA+
 IBmwaMEisQ/k82EL3v6QUMowWxcpqqOIAdDL2ZapiR9Rr7bym2sIVg==
X-Google-Smtp-Source: AGHT+IGqINBmU+HjfnO5w6FCTF/tqO5xWaGWBDeFlKfcbsh8+c/dsHfuEmTfKwLA+FbpLV9Uyk8mWA==
X-Received: by 2002:a05:6a00:e0e:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-73c1f8f5a36mr1612004b3a.7.1744754865586; 
 Tue, 15 Apr 2025 15:07:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220c45cdsm37435a12.19.2025.04.15.15.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:07:45 -0700 (PDT)
Message-ID: <f4d615f9-465d-4d18-8e96-e817f241a175@linaro.org>
Date: Tue, 15 Apr 2025 15:07:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 111/163] tcg: Move i into each for loop in
 liveness_pass_1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-112-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-112-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
> Use per-loop variables instead of one 'i' for the function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ed03840988..9da6c8bb4d 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3924,10 +3924,9 @@ liveness_pass_1(TCGContext *s)
>       int nb_temps = s->nb_temps;
>       TCGOp *op, *op_prev;
>       TCGRegSet *prefs;
> -    int i;
>   
>       prefs = tcg_malloc(sizeof(TCGRegSet) * nb_temps);
> -    for (i = 0; i < nb_temps; ++i) {
> +    for (int i = 0; i < nb_temps; ++i) {
>           s->temps[i].state_ptr = prefs + i;
>       }
>   
> @@ -3954,7 +3953,7 @@ liveness_pass_1(TCGContext *s)
>   
>                   /* pure functions can be removed if their result is unused */
>                   if (call_flags & TCG_CALL_NO_SIDE_EFFECTS) {
> -                    for (i = 0; i < nb_oargs; i++) {
> +                    for (int i = 0; i < nb_oargs; i++) {
>                           ts = arg_temp(op->args[i]);
>                           if (ts->state != TS_DEAD) {
>                               goto do_not_remove_call;
> @@ -3965,7 +3964,7 @@ liveness_pass_1(TCGContext *s)
>               do_not_remove_call:
>   
>                   /* Output args are dead.  */
> -                for (i = 0; i < nb_oargs; i++) {
> +                for (int i = 0; i < nb_oargs; i++) {
>                       ts = arg_temp(op->args[i]);
>                       if (ts->state & TS_DEAD) {
>                           arg_life |= DEAD_ARG << i;
> @@ -3988,7 +3987,7 @@ liveness_pass_1(TCGContext *s)
>                   }
>   
>                   /* Record arguments that die in this helper.  */
> -                for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> +                for (int i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
>                       ts = arg_temp(op->args[i]);
>                       if (ts->state & TS_DEAD) {
>                           arg_life |= DEAD_ARG << i;
> @@ -4008,7 +4007,7 @@ liveness_pass_1(TCGContext *s)
>                    * order so that if a temp is used more than once, the stack
>                    * reset to max happens before the register reset to 0.
>                    */
> -                for (i = nb_iargs - 1; i >= 0; i--) {
> +                for (int i = nb_iargs - 1; i >= 0; i--) {
>                       const TCGCallArgumentLoc *loc = &info->in[i];
>                       ts = arg_temp(op->args[nb_oargs + i]);
>   
> @@ -4036,7 +4035,7 @@ liveness_pass_1(TCGContext *s)
>                    * If a temp is used once, this produces a single set bit;
>                    * if a temp is used multiple times, this produces a set.
>                    */
> -                for (i = 0; i < nb_iargs; i++) {
> +                for (int i = 0; i < nb_iargs; i++) {
>                       const TCGCallArgumentLoc *loc = &info->in[i];
>                       ts = arg_temp(op->args[nb_oargs + i]);
>   
> @@ -4135,7 +4134,7 @@ liveness_pass_1(TCGContext *s)
>                  its outputs are dead. We assume that nb_oargs == 0
>                  implies side effects */
>               if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
> -                for (i = 0; i < nb_oargs; i++) {
> +                for (int i = 0; i < nb_oargs; i++) {
>                       if (arg_temp(op->args[i])->state != TS_DEAD) {
>                           goto do_not_remove;
>                       }
> @@ -4149,7 +4148,7 @@ liveness_pass_1(TCGContext *s)
>               break;
>   
>           do_not_remove:
> -            for (i = 0; i < nb_oargs; i++) {
> +            for (int i = 0; i < nb_oargs; i++) {
>                   ts = arg_temp(op->args[i]);
>   
>                   /* Remember the preference of the uses that followed.  */
> @@ -4183,7 +4182,7 @@ liveness_pass_1(TCGContext *s)
>               }
>   
>               /* Record arguments that die in this opcode.  */
> -            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> +            for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>                   ts = arg_temp(op->args[i]);
>                   if (ts->state & TS_DEAD) {
>                       arg_life |= DEAD_ARG << i;
> @@ -4191,7 +4190,7 @@ liveness_pass_1(TCGContext *s)
>               }
>   
>               /* Input arguments are live for preceding opcodes.  */
> -            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> +            for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>                   ts = arg_temp(op->args[i]);
>                   if (ts->state & TS_DEAD) {
>                       /* For operands that were dead, initially allow
> @@ -4215,7 +4214,7 @@ liveness_pass_1(TCGContext *s)
>   
>               default:
>                   args_ct = opcode_args_ct(op);
> -                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> +                for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>                       const TCGArgConstraint *ct = &args_ct[i];
>                       TCGRegSet set, *pset;
>   

Looks so modern! :)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



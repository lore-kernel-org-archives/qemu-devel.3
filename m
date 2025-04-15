Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE874C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oTa-0001RU-KX; Tue, 15 Apr 2025 18:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oTO-0001Mi-AL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:09:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oTI-0002JH-Vv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:09:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so104203b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754974; x=1745359774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Wn176Q5VKG1nb0WgRYhGBJpsMGpraETknReDvXmKmA=;
 b=kISoUrFnpoKzjYC6ebHeW14CPQ/iZkJfjd/7yX3DBphUpRYBxAqUZrRDbHzkxn0qPB
 xW/RzBKg98CO65yUfxWXBfgdazGeNYoOwyn12MVXnFV5VSa/8GHLRgd6SflVWfPVL7lV
 cmJD/lvzMUpidPC2BGj4r1U10CYbRI3s2uBfQd8J2SOmqox83Wn23k8YcjQ3hTOEzcBY
 ju4iLNYYna7AEIf7KaIVqlRp26T5VqJnEeYo2YYHOKVTkFsGkCm7Sp0LpkmQ7bFcvwpd
 lpKQwspj2XOlDVXTP2CvcIc5EApv5d7X6bex7aqZUSztZrAzW1TiCyhzQo15QilC3E0a
 VsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754974; x=1745359774;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Wn176Q5VKG1nb0WgRYhGBJpsMGpraETknReDvXmKmA=;
 b=Ff9xX0S1kDMG4Ew8KPxgxfk0Xs49ESFaQ/k4f4rpQSeJuuiZpDnZulpzfdEyMD3wzb
 MfPxqZrC9qnpuVVe3xZNpGd2qQiV3KBjwW/egBkMgIh1j9nl8CoNp8VQwy/RK5QBU4eI
 tDhJeLEaB1EvqB70LjCUxp3ag+dQ3mJszKsinh0R0Oc8KkB1QMkgNU7S8Wfrk1pAFetC
 cVQq5xAxWaJ+LtHpa7qx4iX9b7kp9ls590QO9a9Tf9japRHOC4RALR7S5xw0NuHhr2r2
 pa6ZVZAR0sPTUHIkv6OQ55c808bgCiYs9P6QECc1aJa5r7e53/pZt01IFz3iwzOEjjgq
 BRhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXqFEaTmOengWKN3wAuusVkwXP0/dgNLK+JprP0fqL1QKl60H82+T6dFn+5/LksSBTmB6hlh3/sZ3D@nongnu.org
X-Gm-Message-State: AOJu0Yws3HSDW+8NeIuU9GgjMVdjeiNua/Z1E/ayQDdo5XQmXl5tjm9I
 gRLQaSd+0mm3b7c/HHYDtt4jIcJAYF2wQPH7dgWqjoCytThq6rRAeOLN1vEJOLa+RytpwWsbI0+
 T
X-Gm-Gg: ASbGncs8Z5slIZZsqWAbo2QIhp9zZM4Vm71yAwWfwcZJe7lHafn14hUbFQoH7RiDl71
 2Ms3Nl0WpxODrRg6ys9JTm4uTy8HLvJaZF04hLD0J0gdkzLXahyC30QOUMdf8UUmPAaVFPMnExH
 FSuzcWEKPKtTtfBum3xvH1UgVDwET3tH2SsWUFDzMiJrfbPZ8GqqOv3vxsd+KY3t+fwfDcWwGhn
 KjnqAUGSs2nvdFBaSQrXBb7edXSOadH0kvRcMzs+bUWV7Im2qlnM1RwL9G4TAgeGWsaexSlabM4
 J5LA+6/FKJ5ljph+pA/AEX+OYOaDS4XbyIpkpV6eoLSlMwQf6Atqnw==
X-Google-Smtp-Source: AGHT+IHs0M43p8ELk0Ukcs2m3XA+k1o4G2/yhY6RIQVIPXcwVGcsiKNOrcY9F0UR5OxvEjn0b5tdUw==
X-Received: by 2002:a05:6a20:6f89:b0:1fe:90c5:7cf4 with SMTP id
 adf61e73a8af0-203acb11ae7mr1562832637.19.1744754974177; 
 Tue, 15 Apr 2025 15:09:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230d667sm8992200b3a.121.2025.04.15.15.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:09:33 -0700 (PDT)
Message-ID: <982f481f-3935-453a-917e-ca5be1371c34@linaro.org>
Date: Tue, 15 Apr 2025 15:09:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 112/163] tcg: Sink def, nb_iargs, nb_oargs loads in
 liveness_pass_1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-113-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-113-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
> Sink the sets of the def, nb_iargs, nb_oargs variables to
> the default and do_not_remove labels.  They're not really
> needed beforehand, and it avoids preceding code from having
> to keep them up-to-date.  Note that def was *not* kept
> up-to-date; thankfully only def->flags had been used and
> those bits were constant between opcode changes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 9da6c8bb4d..381e76cfc8 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4071,8 +4071,6 @@ liveness_pass_1(TCGContext *s)
>           case INDEX_op_sub2_i64:
>               opc_new = INDEX_op_sub;
>           do_addsub2:
> -            nb_iargs = 4;
> -            nb_oargs = 2;
>               /* Test if the high part of the operation is dead, but not
>                  the low part.  The result can be optimized to a simple
>                  add or sub.  This happens often for x86_64 guest when the
> @@ -4087,8 +4085,6 @@ liveness_pass_1(TCGContext *s)
>                   op->args[1] = op->args[2];
>                   op->args[2] = op->args[4];
>                   /* Fall through and mark the single-word operation live.  */
> -                nb_iargs = 2;
> -                nb_oargs = 1;
>               }
>               goto do_not_remove;
>   
> @@ -4100,8 +4096,6 @@ liveness_pass_1(TCGContext *s)
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_muluh;
>           do_mul2:
> -            nb_iargs = 2;
> -            nb_oargs = 2;
>               if (arg_temp(op->args[1])->state == TS_DEAD) {
>                   if (arg_temp(op->args[0])->state == TS_DEAD) {
>                       /* Both parts of the operation are dead.  */
> @@ -4122,19 +4116,15 @@ liveness_pass_1(TCGContext *s)
>                   goto do_not_remove;
>               }
>               /* Mark the single-word operation live.  */
> -            nb_oargs = 1;
>               goto do_not_remove;
>   
>           default:
> -            /* XXX: optimize by hardcoding common cases (e.g. triadic ops) */
> -            nb_iargs = def->nb_iargs;
> -            nb_oargs = def->nb_oargs;
> -
>               /* Test if the operation can be removed because all
>                  its outputs are dead. We assume that nb_oargs == 0
>                  implies side effects */
> -            if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
> -                for (int i = 0; i < nb_oargs; i++) {
> +            def = &tcg_op_defs[opc];
> +            if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && def->nb_oargs != 0) {
> +                for (int i = def->nb_oargs - 1; i >= 0; i--) {
>                       if (arg_temp(op->args[i])->state != TS_DEAD) {
>                           goto do_not_remove;
>                       }
> @@ -4148,6 +4138,10 @@ liveness_pass_1(TCGContext *s)
>               break;
>   
>           do_not_remove:
> +            def = &tcg_op_defs[opc];
> +            nb_iargs = def->nb_iargs;
> +            nb_oargs = def->nb_oargs;
> +
>               for (int i = 0; i < nb_oargs; i++) {
>                   ts = arg_temp(op->args[i]);
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F96C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hp5-0001GF-CW; Tue, 22 Apr 2025 13:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hp3-0001FX-4g
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:54:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hp1-0001xD-B6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:54:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so142243b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344454; x=1745949254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vdoe+v6SW2vlwqWo3bEmcuhvBHi5NAIbCDPimqGFi6g=;
 b=j2P8qY+wxlthTXpdS+69nIxQfpnL2njs+jia/Tk01QyqvUB6fOO7+axYGpCrcaXmpK
 2hb044QZAzOODsUxDkfEHSy4Cvu76tDX8859qjt9nXxdY5DM59uRGaIo3GN9YQa2062p
 K96Gu54fV4enm6SaQEdvJrGZKryKoLsF1Pw9sC2rlN5rDpjCyoULfawad7CKm4skkggO
 lwCDC3EDBvxcTvGyjIylulYqiPo1O4TuNqBQTBu7Us4Vf2M6mgX+3KtnKgTfg7zMVHrx
 qm9bchx72NMCFD7I/b4Esbl/4a/q/I5lFoUmBxtKogNW98UcwGkwSvYXlW3jJA0M0/IS
 Kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344454; x=1745949254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdoe+v6SW2vlwqWo3bEmcuhvBHi5NAIbCDPimqGFi6g=;
 b=kkTwwVNpLzDR6CvQxEvANO1LQ3PhgfLf56T/BLg61MXFKGBKVQlhxe4sIXcMEfB5lX
 kS6hgKdP+pCdkhr03BwgKiMjhQi1saunPLhZU8tMiCMUNrO7fWIQn460P4XkyG5nk+hn
 H4T2K6sweHmQspEcnGb+ulgPNhNt/3ASPi0HCynOLigKZ5PpYqNJh1/0x7hcGk3+XwsF
 DJH/ptkIQ1fAsMVUpUKm9zvkGWcalSU/7N/UhE4A7EU495hu54iCWIRXa3Q48OWksqDt
 xVzdxeRp88cXQrPEvy9Nd9pTWJ0jcYMX9jejdPV86ltx0cVQ+kEPKjxrztfMoFNpWkh1
 0SGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLGRH2N7qGhFTNdz+Y5Q5FLrvOwYfZciN+icG2gL9bPWDSrPjdgyJ5vjk0uSg8lEquO3rzaZ2YGfS0@nongnu.org
X-Gm-Message-State: AOJu0Yxb6xQOX0pAk9b4fOfv0EtRgoU1G6Jsrh2A3waFlEir1/xsQoh9
 BLb0BOzHPNeYanLcX3NiOzJeh6XVJbyhUrxjKSmnnH8TJUqT78rNcyZhKJlv76k=
X-Gm-Gg: ASbGncuzgwLzQJoCaqvkr9SRhzmDTonniH2aJXSeg5l4WjW7vxb/LiMOFZEwVevcyh5
 dzrDHjLdHyEio55kGDkcRPpmoJf77qmgxRb4TuqkJZC1uQzezGjP2/NlPu0UxsJ3Jr22C67auW2
 nultKIiSbB6Lx/2ACNXD+eQdghZ63dDj8BNAvY5knVm5Ek4TOZXdFOE7+hnA1UwKQpbFI7T3C6v
 CkFCOva0IirzQqMiO9aa8DR4VVFRria80naRA8Bmu/brYWLcpr4UTxg5o22T2MjrcOBah3mLxIe
 VV+nrt71uaeZC+eHVKyqIjKhF7Djwl3CU3nx9beHlXmGb+p47XSkLzE72uiem2O0zOCUJvgeqdp
 vTdj0M7E=
X-Google-Smtp-Source: AGHT+IG29pzfivhHsu8VtHjo84dS5sd+aZCWImL6wD6PktU6vbm4FNaRtNk6MYLCRlOgHogj5l7KtA==
X-Received: by 2002:a05:6a21:1505:b0:1f3:3864:bbe0 with SMTP id
 adf61e73a8af0-203cc5ce996mr23398064637.8.1745344453684; 
 Tue, 22 Apr 2025 10:54:13 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db14488casm7675654a12.56.2025.04.22.10.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:54:13 -0700 (PDT)
Message-ID: <0ca405b8-77f8-452e-ba09-0ba820f64d6f@linaro.org>
Date: Tue, 22 Apr 2025 10:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 11/19] hw/core/machine: Allow dynamic registration
 of valid CPU types
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> index f52a4f2273b..8b40735ef98 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1581,6 +1581,33 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>               return false;
>           }
>       }
> +    if (mc->get_valid_cpu_types) {
> +        GSList *vct = mc->get_valid_cpu_types(machine);
> +        bool valid = false;
> +        unsigned count = 0;
> +        GSList *l;
> +
> +        for (l = vct; !valid && l != NULL; l = l->next) {
> +            valid |= !!object_class_dynamic_cast(oc, l->data);
> +            count++;
> +        }
> +
> +        if (!valid) {
> +            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
> +            vct = g_slist_reverse(vct);
> +            error_setg(errp, "Invalid CPU model: %s", requested);
> +            error_append_hint(errp, "The valid models are: ");
> +            for (l = vct; l != NULL; l = l->next) {
> +                g_autofree char *model = cpu_model_from_type(l->data);
> +                error_append_hint(errp, "%s%s", model, --count ? ", " : "");
> +            }
> +            error_append_hint(errp, "\n");
> +        }
> +        g_slist_free_full(vct, g_free);
> +        if (!valid) {
> +            return false;
> +        }
> +    }

Why use GSList instead of GPtrArray?
That would provide you the count without manually computing it,
and it would avoid the need for any sort of reverse.
I think it would also allow you to auto-free the set.


r~


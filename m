Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A337CC7EE39
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 22:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW0po-0004HP-K1; Sun, 29 Jun 2025 18:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uW0pn-0004HF-8X
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 18:49:15 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uW0ph-0007B6-3z
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 18:49:15 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2353a2bc210so10113865ad.2
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751237346; x=1751842146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=h4776ZRPh8s1TSb9wlB2pGqAS1FZErQkBzJZnqKxiPo=;
 b=X48l2dsCEJboVxgfbmlK6YWriKCnMn7nB+xu3qMe8IvEro8m6CH1Gqu+HwFMV+fu8s
 B7RmOOJ2r71Z46G3mElAZf47RhEI7qi7ukZxSPGExwRUpJXdC1VdqVwaI2GymoNfcg69
 Q0ak6wn5714GO5AQcp2UwVqVXzu2yhxhDkkjg6Lakm7eDf42zR0B3GpUakX8SA6BUsl7
 87nWSqFew1K76Lh2v7F85SvF+37eauokaNseLfP7aPNei2WVYGrNISrxHJyg+TaZjaaa
 ZGQ2Zm6b8c/60wevlHIQ1tzdLV/nSAbp4AkV2n781mAna34Gerk1qpC52RSARYM+SWWa
 POCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751237346; x=1751842146;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4776ZRPh8s1TSb9wlB2pGqAS1FZErQkBzJZnqKxiPo=;
 b=CmTpAvGmfd25Ln8k29Tgz7MTPvNhZfQAuVRVGFn77YrK9DJKRJ1RIaFRQXOncynuIT
 01W80XmREEpBG49kGDyfztNRET3q5SwuE+vLsd0+leaSB2HkpO/wDKF+adF6xWaralXu
 EqzMcTT+owiSzS2lo6cdmdocCDLxVzODm0oQYu9pmxCY7uEquPgrr8L80rQt0j872hiB
 bb+RMlXOlLNNDwjlVvCrMvj6oFjtjlKoEy8D2m7qen4eqpjMw0PB9Sn6sZtUapw3XKu1
 DvO71y+sodBn2sG23rwUoA1L8rN9uwIqHa5aMPK69ffQyOqASv1ixQRpI2NBQD3cmDsh
 Xk0A==
X-Gm-Message-State: AOJu0YwGTMMt41CDr3z6z6rltf+Ok7aaCeAry8hj85G670XYGlzKOIN5
 Wvku/sUrLJbmSBy10oioYwtIfS3+ybpHp3K1e5a3n1STrrSTvqs/rIcN
X-Gm-Gg: ASbGncuKpfkZK0WalXGezT9vZqbG9JvXjRo8W7JHH/r3r5RWJZnsOGsMNoPzmD4dZW4
 G44uWthDEIE+RkP1Y0YyeDxpm3UeU40EAwtCQTywhKK6Yh4X1OR0dUnQ/DvOW/h+uNfzZLqR2KP
 aBxxUd2jbLMm0skc1zP+flnW4ISgyJZgBe5yvbYQLPk/IM0BzD8tVhHsRS1dXnChTbPEbnfynDX
 E9aH2+crWllRuSGMiM4K0OOzi/VUoTl+r3m0Xsn+69d3kFU4YfQBJaOi7EDmQjT1ayM+3/5aMow
 qj3YKVeFFvtTqUdek0U3qVDugUBLjWMY36RL2e834SPwHJjbDFpDZ8U3xTuhvIo=
X-Google-Smtp-Source: AGHT+IF437pg+3f1tHocVLxEGr/0jP1flbrRtpSwazW1aS+vdRtO5y1rJ9hFHg97gQjIoN//RmiADw==
X-Received: by 2002:a17:902:ebc7:b0:234:a139:120d with SMTP id
 d9443c01a7336-23ac3817845mr160235285ad.7.1751237345571; 
 Sun, 29 Jun 2025 15:49:05 -0700 (PDT)
Received: from [10.2.0.2] ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b928sm65897245ad.111.2025.06.29.15.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jun 2025 15:49:05 -0700 (PDT)
Message-ID: <4932277d-ae7c-469a-93bb-db44913c1a1b@gmail.com>
Date: Sun, 29 Jun 2025 17:49:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] contrib/plugins/execlog: Add tab to the separator
 search of insn_disas
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
 <20250627204817.47595-2-yodel.eldar@gmail.com>
 <87wm8uwfe4.fsf@draig.linaro.org>
Content-Language: en-US
From: Yodel Eldar <yodel.eldar@gmail.com>
Autocrypt: addr=yodel.eldar@gmail.com; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 N1lvZGVsIEVsZGFyIChZb2RlbCBPcGVuUEdQIGtleSkgPHlvZGVsLmVsZGFyQGdtYWlsLmNv
 bT7ClgQTFggAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBNPNGM1AbbuKZqn435Xu
 T7c2ZU2sBQJnI9xJBQkB6nhTAAoJEJXuT7c2ZU2sSQABANuu74MJKexa8V8kVNLhw68loN4x
 2ZbojcfUOWd8Pf5HAQDn1XxmQFPMIUYahlXMMrwRyQE1m6HjtrolOELICzwxDM44BGcal3YS
 CisGAQQBl1UBBQEBB0Ao8jLdb8MoWybV77fXOiqY5jSmrPy+MgzzjrAzqURjZAMBCAfCfgQY
 FggAJgIbDBYhBNPNGM1AbbuKZqn435XuT7c2ZU2sBQJnI9wMBQkB6ngWAAoJEJXuT7c2ZU2s
 BlUA/0ZfDDmzKdC1khPMaRIv/gWedFd5Z8jWqh0rswF2LyeNAQD6PjBgliBhL1xTto+juM1b
 jctqRusjtyMyzG8/ps2iDQ==
In-Reply-To: <87wm8uwfe4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 6/29/25 1:50 PM, Alex Bennée wrote:
> Yodel Eldar <yodel.eldar@gmail.com> writes:
>
>> Currently, execlog searches for a space separator between the
>> instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
>> use a tab separator instead; this results in a null pointer being passed
>> as the haystack in g_strstr during a subsequent register search, i.e.
>> undefined behavior, because of a missing null check.
>>
>> This patch adds tab to the separator search and a null check on the
>> result.
>>
>> Also, existing, affected pointers are changed to const.
>>
>> Lastly, a break statement was added to immediately terminate the
>> register search when a user-requested register is found in the current
>> instruction as a trivial optimization, because searching for the
>> remaining requested registers is unnecessary once one is found.
>>
>> Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
>> ---
>>   contrib/plugins/execlog.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>> index d67d010761..08fc1f12d4 100644
>> --- a/contrib/plugins/execlog.c
>> +++ b/contrib/plugins/execlog.c
>> @@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>            */
>>           if (disas_assist && rmatches) {
>>               check_regs_next = false;
>> -            gchar *args = g_strstr_len(insn_disas, -1, " ");
>> -            for (int n = 0; n < all_reg_names->len; n++) {
>> -                gchar *reg = g_ptr_array_index(all_reg_names, n);
>> -                if (g_strrstr(args, reg)) {
>> -                    check_regs_next = true;
>> -                    skip = false;
>> +            const gchar *args = strpbrk(insn_disas, " \t");
> We have a general preference for glib here, could we use g_strsplit_set?
>
> Something like:
>
> modified   contrib/plugins/execlog.c
> @@ -232,12 +232,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>            */
>           if (disas_assist && rmatches) {
>               check_regs_next = false;
> -            gchar *args = g_strstr_len(insn_disas, -1, " ");
> -            for (int n = 0; n < all_reg_names->len; n++) {
> -                gchar *reg = g_ptr_array_index(all_reg_names, n);
> -                if (g_strrstr(args, reg)) {
> -                    check_regs_next = true;
> -                    skip = false;
> +            g_auto(GStrv) args = g_strsplit_set(insn_disas, " \t", 2);
> +            if (args && args[1]) {
> +                for (int n = 0; n < all_reg_names->len; n++) {
> +                    gchar *reg = g_ptr_array_index(all_reg_names, n);
> +                    if (g_strrstr(args[1], reg)) {
> +                        check_regs_next = true;
> +                        skip = false;
> +                    }
>

Certainly, and thanks for the suggestion! May I credit you with a
"Suggested-by" or "Co-authored-by" tag in v2 of the patch?


>> +            if (args) {
>> +                for (int n = 0; n < all_reg_names->len; n++) {
>> +                    const gchar *reg = g_ptr_array_index(all_reg_names, n);
>> +                    if (g_strrstr(args, reg)) {
>> +                        check_regs_next = true;
>> +                        skip = false;
>> +                        break;
>> +                    }
>>                   }
>>               }
>>           }


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F147C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWA6N-0003RV-AE; Mon, 30 Jun 2025 04:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWA6L-0003RL-Vm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:42:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWA6J-0004Se-NY
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:42:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so3039636f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751272971; x=1751877771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aroVZW12FZ2KkDTRvQz8BiDmmCV6VWYLT730F40rFc=;
 b=oBjSAJIhnX1LOerU5MMzFRPUngUYBk1k/FZCutC2XcdI2aBShMBHqd0KreMKoNtWd2
 QCjkH7GDqr8xep3/Oh/6x/kDodC6dct3u5Mf9NoLz4UQpWTD9QBQSvrPtDkcw/ubx9dj
 qMTJeflpdXPSMGfBLFDOuW0KGSakKsemhi4CbMe/dhw1LUWNh1vx1iFscLO5YV0Uok47
 xdDd5eF2gjOjRO/+NvpELDOO6F8QJGoXr0l+YOY0jCPtKHHuV+MU8lsZtDfuc7/+1GE0
 ruYiSUSIjll5oZh9ZWPbeLW1L2ez/Jw/mA532uXHnyNEpQfffg9WVBsgZoGHtR8M5vow
 LBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751272971; x=1751877771;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0aroVZW12FZ2KkDTRvQz8BiDmmCV6VWYLT730F40rFc=;
 b=kDOnH+6LDjKYwWscbduSF2EgsTyUzWRGadwtzlyZDcoLgvTKXwXVgTZe8wFgB3RIJ9
 CKIfNLA7bjK6nr37fzdAsPAlpUHsiz64cAhGZe3CE5KaY/ogvZQnJYq9na5Vm/91In0Y
 OTGKXyjgYsOAKtGRfI3fd52zAZa3V2OMgRdNfjoOZrzLPPeJjhuUswEAeP0eNYwIOHBc
 aYqq8Exn8Qp0Zzo86CIIeCGUU0HD5bAp3drs2Q26ogfAvXWXB5/Q5WX6VqdA3WQPnbvY
 YwzdWylXM+HYrINF0++zwxshtEbQxm3RGMZ7fDQnwxzz5MSe4z1NpZvnBrprwK9zN6iP
 BRxg==
X-Gm-Message-State: AOJu0YzPsICb62tj0P9qK88NwDPf7dWOutTNUMOQEzjK39cSDavq3nOx
 ai0gIszg7lwjxaYjRY2oMOIH+X6FOH0pY6Z4fqBtjkzanqF3fqujGFB7ULmCkyfnInc=
X-Gm-Gg: ASbGncvURFrIxPTkGZCLNGvUDsOYIFZnuHxSbkpKGaE6xltNbBzbXmZlTtVZgyODkFA
 820T2lItPFdQrdqJRd2Wytralm+FNSol2mwgvjhRUYzLFerxg0Y+QFwdg3O2p4FeMrajcBm6K+K
 GF+i8llm49tsp0iJdsHltrJHbYDozVViZhlyd7ebIyrnhr62q/tMDXfCUWc2cTYLwViAnCETdbV
 jBdIqi24oMm1laU6Gb/LFxmXKWhg6QpLbFEdGuE6XTE7b2VkNDwW47yFlOJagaSNRyw+ScvEC9Q
 Ohr5zd81TsfGsO7ULBVSFSsWPFqoQEtWUZFk6HyA3SwzSSLOb0tR0aiSuhHkPmpfKXUZaAvqng=
 =
X-Google-Smtp-Source: AGHT+IEv3xzGgzUQFbdAXxkDLnqJcZrrZRJysL7gpoYZUTNUTyK+Mn9JDHB1nXn6vyUJlAeyo2c/Ng==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3a90d4b3739mr10602693f8f.13.1751272971196; 
 Mon, 30 Jun 2025 01:42:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a4213f0sm128118765e9.36.2025.06.30.01.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 01:42:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 847635F830;
 Mon, 30 Jun 2025 09:42:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  laurent@vivier.eu
Subject: Re: [PATCH 1/2] contrib/plugins/execlog: Add tab to the separator
 search of insn_disas
In-Reply-To: <4932277d-ae7c-469a-93bb-db44913c1a1b@gmail.com> (Yodel Eldar's
 message of "Sun, 29 Jun 2025 17:49:02 -0500")
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
 <20250627204817.47595-2-yodel.eldar@gmail.com>
 <87wm8uwfe4.fsf@draig.linaro.org>
 <4932277d-ae7c-469a-93bb-db44913c1a1b@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 30 Jun 2025 09:42:49 +0100
Message-ID: <87zfdpfwmu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Yodel Eldar <yodel.eldar@gmail.com> writes:

> On 6/29/25 1:50 PM, Alex Benn=C3=A9e wrote:
>> Yodel Eldar <yodel.eldar@gmail.com> writes:
>>
>>> Currently, execlog searches for a space separator between the
>>> instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
>>> use a tab separator instead; this results in a null pointer being passed
>>> as the haystack in g_strstr during a subsequent register search, i.e.
>>> undefined behavior, because of a missing null check.
>>>
>>> This patch adds tab to the separator search and a null check on the
>>> result.
>>>
>>> Also, existing, affected pointers are changed to const.
>>>
>>> Lastly, a break statement was added to immediately terminate the
>>> register search when a user-requested register is found in the current
>>> instruction as a trivial optimization, because searching for the
>>> remaining requested registers is unnecessary once one is found.
>>>
>>> Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
>>> ---
>>>   contrib/plugins/execlog.c | 15 +++++++++------
>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>>> index d67d010761..08fc1f12d4 100644
>>> --- a/contrib/plugins/execlog.c
>>> +++ b/contrib/plugins/execlog.c
>>> @@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, st=
ruct qemu_plugin_tb *tb)
>>>            */
>>>           if (disas_assist && rmatches) {
>>>               check_regs_next =3D false;
>>> -            gchar *args =3D g_strstr_len(insn_disas, -1, " ");
>>> -            for (int n =3D 0; n < all_reg_names->len; n++) {
>>> -                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
>>> -                if (g_strrstr(args, reg)) {
>>> -                    check_regs_next =3D true;
>>> -                    skip =3D false;
>>> +            const gchar *args =3D strpbrk(insn_disas, " \t");
>> We have a general preference for glib here, could we use g_strsplit_set?
>>
>> Something like:
>>
>> modified   contrib/plugins/execlog.c
>> @@ -232,12 +232,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, str=
uct qemu_plugin_tb *tb)
>>            */
>>           if (disas_assist && rmatches) {
>>               check_regs_next =3D false;
>> -            gchar *args =3D g_strstr_len(insn_disas, -1, " ");
>> -            for (int n =3D 0; n < all_reg_names->len; n++) {
>> -                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
>> -                if (g_strrstr(args, reg)) {
>> -                    check_regs_next =3D true;
>> -                    skip =3D false;
>> +            g_auto(GStrv) args =3D g_strsplit_set(insn_disas, " \t", 2);
>> +            if (args && args[1]) {
>> +                for (int n =3D 0; n < all_reg_names->len; n++) {
>> +                    gchar *reg =3D g_ptr_array_index(all_reg_names, n);
>> +                    if (g_strrstr(args[1], reg)) {
>> +                        check_regs_next =3D true;
>> +                        skip =3D false;
>> +                    }
>>
>
> Certainly, and thanks for the suggestion! May I credit you with a
> "Suggested-by" or "Co-authored-by" tag in v2 of the patch?

Suggested-by is fine ;-)

>
>
>>> +            if (args) {
>>> +                for (int n =3D 0; n < all_reg_names->len; n++) {
>>> +                    const gchar *reg =3D g_ptr_array_index(all_reg_nam=
es, n);
>>> +                    if (g_strrstr(args, reg)) {
>>> +                        check_regs_next =3D true;
>>> +                        skip =3D false;
>>> +                        break;
>>> +                    }
>>>                   }
>>>               }
>>>           }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF9DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKM13-0004aj-Bm; Wed, 28 May 2025 15:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKM0x-0004Zg-Fq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:00:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKM0v-0002mM-E5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:00:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso67475b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748458831; x=1749063631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ghmkgg1qvP2fBBLlXUopDEX/npj9gEy+PBhEBtk+WaM=;
 b=bg2C8c9Vj9t/x2Ngc5+MRSrqeT564uRzBFxOcU6knnrX17iAwmnlkY+8CBsm+SJ+bU
 ihB1Ue32S8sxPRSTJdbpxW/yq7zoYXmrYDk7kJbToDJN88/etpx0gp4gsNoNwECPo8Wt
 4yDgky7XUOsrPAFdXUpVB8u3zyFmRaxuHanWweJ2lRMVZAnhj2leMb6/+OZ8y7/H6o90
 dUsKt09cRoYKVY4RDXHIZ6hP9VEFxSmBu0+hwk5AJiXxo99axO6a6j2sfFEeMEA2H49h
 E0Pu81ErXc1TVIUN3z6DNK9q14G26yRfStnLO/SixoNh6Hu0nEGSr+hNmpdEdH6ZnBr1
 SY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748458831; x=1749063631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghmkgg1qvP2fBBLlXUopDEX/npj9gEy+PBhEBtk+WaM=;
 b=BpC8L/F8A89ykTaNDt1rEnpWTNAp7KihcD8EwAT4f26mBx+XuEz3BuqPwT4tY8tXPb
 bb7HWDFWLVKhlQA5KBESzrCpsFDNROb4Ug2gVCrhi8GdaLkdE/URQuxcAtuiNYgTGpuz
 dxvDsOQM9eBGUvbXj8e2m0kJjZTc6qV0wXuoWHd/GV8GRrJptMOpxhAgtC6rI+sK5ykT
 8+opUQdaVpKIO2BMsy4iA1DhOnymF/NG4dsN0QgRsCzmU/84lkutTdaJGeqnpL7FPKyZ
 uRNGgY8A3a3QwY2IOgcS1IFHEL5J/aGuu1ph+uQst954ad0zMWksj4RCw2QiZSo3M8mw
 g9Ww==
X-Gm-Message-State: AOJu0YxjsErZKewcZ6GZcX5yTeeqKRbVysVoffS3hyVwlynyNVhpaiNm
 apUlEimiyPY5/da9wP0BT09w0BlzcavnctO+JcCO0aLBaFq8Mo8jhyqoQgzQQx1G5Yo=
X-Gm-Gg: ASbGncvu+J0vukF7wrWhj4ANPOCKhXGSnT/3vEG9ACiywv0k9J4vB4VJhRDIIhEbqYj
 AlXXpSMfkNDXsTQlK1/QfEZDegEYC7tvSnsZDVec+mhGT14pG0c+RFoke9RQpho5t8y8rBgoRiQ
 a1WNysLXUZC1Enqz3Yl10UGEfSfyVxgoJcudesiEQ1aPNVa/dcbW3iWvsS6zSBWGTVq5hYgpsbZ
 q2WTsMMqbcroch0HSdhw+5DmjJwtVkQiWV0uWlW5ilA/3paXkPYbpHYzMhpdwuB4syXwdsEP0Zu
 AYL7Sv3Lk6nhkGCS5ux1p9tYqI9nneNvqj7s4QxsQb3tK9FQXYS90OAtGk4DFiWpJPQF7VepgOQ
 =
X-Google-Smtp-Source: AGHT+IGqmS2M6jN921MF8HAgBn41duul/Rwt9DKHQcHBX4OIqUkxgLmHhD4Z9c1KHeyqATK9UQuleg==
X-Received: by 2002:a05:6a20:12d6:b0:1f3:33c2:29c5 with SMTP id
 adf61e73a8af0-2188c1e7dccmr32478936637.7.1748458830698; 
 Wed, 28 May 2025 12:00:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746d6048447sm1618347b3a.62.2025.05.28.12.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 12:00:30 -0700 (PDT)
Message-ID: <dfce4489-118b-405c-a104-3f9b74cf6023@linaro.org>
Date: Wed, 28 May 2025 12:00:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] qapi/misc-i386: move errors to their own
 documentation section
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-16-pierrick.bouvier@linaro.org>
 <87msayqoz1.fsf@pond.sub.org>
 <5e069cf6-0494-4ddb-98b1-be895b1b464e@linaro.org>
 <87r009jpoj.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87r009jpoj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/27/25 9:59 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 5/27/25 4:20 AM, Markus Armbruster wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> My comment on the previous patch applies.
>>>
>>
>> I'm not sure to which comment exactly you refer to.
> 
> Should've been explicit :)
> 
> I'd squash this into PATCH 02.  I figure you didn't because PATCH 02 is
> Daniel's.  Here's how I would record provenance when squashing:
> 
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>      [Error documentation tidied up]
>      Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> If you want to record why, you could add "at Markus's request".
> 

I see better.
Feel free to squash it, I keep this splitted to avoid rebase self 
conflicts, and to facilitate review.


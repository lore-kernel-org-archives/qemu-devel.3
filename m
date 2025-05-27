Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E0BC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxdl-0003zV-IT; Tue, 27 May 2025 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxdk-0003zH-8Z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:59:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxdf-000618-Ec
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:59:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso2844611b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748365132; x=1748969932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/rKPl9LWifiTL6pGI69wn+0j1kiKwupMKerKcEWDrw8=;
 b=qBhTYwSLW4McnniDXAXr0kNlGjOJW/p+d4eSGiU/zPoVyTMNPNjKrBdfV76C3iMh9f
 Cw1qVOdVdvHeVQmO4CvDj5qShOvBO+6ygguAshkyiGPC6SjKiu3CXzQ9GFRBxi0jEnin
 8qL6X197Zu8VG9PgP/c88ZlQIVb9AlnvOO1p7sIqiOSzPq+ho0XUnN+Y1//g5o8TQURV
 TndEN+jkr++oy5A4BUM2XZrU8spEaPViguB90mrTQsBPfy/J9/LnhKYzKyu/ih74fe7Q
 y2KQyG8zeDOY+7MtFdEMh9JeLwy2OCTNlWPWpAFDV/CbtxtBV6NQcFyE2s2qqfsS0vAT
 R7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365132; x=1748969932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/rKPl9LWifiTL6pGI69wn+0j1kiKwupMKerKcEWDrw8=;
 b=MLcJKs2KCTfDQ04ECGlH28flefbA3Pg0rC7HHItkM7yvCmwB3F7FJtm3bF6q+LKc56
 l0LMxzi80naYk8CsuuLWIdDC8LKf7cAgrOGaX1n5B+jMbuY8RZE7tEnqHojhGwGUhfmj
 6r5vmpAgVH2CaQabYdA697efJbTEewahwdliEUW7QmflcxQ6OEyYkOCOaAFYMPW1GNvy
 E/e+ehwauKkUsfnXJfa+bukT8OJaP3T16M7fmHuBRKRWiF5teBHmVLDCvsXSCGutRv2I
 LtrCSSFQoZc4xw4wr4Dll6q7xRzoa1LbUYZ/oCoryO5u9vZGhIhZoQvRahtZcytG3hCW
 MhBg==
X-Gm-Message-State: AOJu0Yxm6+dn2b4q0xfqQTXRyWlaKTqhFOvUGFq7AeAIg5aAHk0calrb
 /YtTg28qznzu13bh3TAPpElLc+nt1O23A7kNlJHBja5OOEpvomcBtVcAGFh6m18r190=
X-Gm-Gg: ASbGncvNzJSbDm+ra4mR+4eO9ecOnfVVn9VfsVON3Lu8ROb65D1/UsDACid5xFqjIql
 26WH99Nyn2FrEiLzDKVwFw4Mv40Uh2QHvjl6iy7hqKMBoqYMR7u1c6l3tD6hzN/ArICYCun1+vN
 F1YbiK5E6ycP4Dx9j4wtlEJuT/W1aBtSgDfytclNsOMRl9ZUcje2wozW1asSkmG1/DNMPCEV5+d
 uhKyaQHIY4OtK4CXq8kll1JL3Ar8XyeChmKgofbgSooC/CCA7Lfm3ZUMv5fhHoMFQn0je++MjiO
 hLqln0PBhYzXEVkrVznnnngEOd2ibYVKftizTKs0Jc97/EAIzAenUjftprEc4G1Ns2Q2SzCmbrM
 =
X-Google-Smtp-Source: AGHT+IFtIq5IPRBUrd/zcpMiygya0/OFtrum6isUOaCwEQ6vBBD50ohcJtU1wcU/I02fiRZGB1ErIg==
X-Received: by 2002:a05:6a00:2443:b0:73e:23be:11fc with SMTP id
 d2e1a72fcca58-745fe05accamr17030891b3a.22.1748365132655; 
 Tue, 27 May 2025 09:58:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7462c99ebf2sm938953b3a.25.2025.05.27.09.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:58:52 -0700 (PDT)
Message-ID: <5e069cf6-0494-4ddb-98b1-be895b1b464e@linaro.org>
Date: Tue, 27 May 2025 09:58:51 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msayqoz1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/27/25 4:20 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> My comment on the previous patch applies.
> 

I'm not sure to which comment exactly you refer to.


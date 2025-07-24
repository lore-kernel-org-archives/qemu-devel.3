Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1196C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 16:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueytO-0001wE-Gz; Thu, 24 Jul 2025 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueytM-0001oU-I0
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:34:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueytK-0004XX-Kc
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:34:00 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so1303860a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753374836; x=1753979636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+YIFa0JQZblYYo6z08SdWvtMeAHwI4go0flw2jU5A+E=;
 b=qwiG1fPOHXSHZigudwcGNrccZxSN0P1yMeMlXhrpws5rrv1OHSpCd0nDZxfDrEOLT+
 OlMYYpnvi00SsWiHZZTVwsM/Z1955rsIgLQj/R4897ui8mga2BYVHouNv4g58TZ9RP1j
 MCHbH7qa4fL3cUJSq25pH8ekfxFjlVJyPt71qO/XP8uF0vyDP/HNPjNzG1piqoV+AZFL
 EJgVJ54+qAXuBIAZwfTYiPHFIUkebKdqCKc1cXYEkbPyltfBab+5LAOBStSefDZt0FvZ
 ccAqDT5frMHRwCxsyMYvhoTrrHBAPim5WJINKyY1FZ3QiA1J47Kjn/gzC34d1su2cQgg
 7NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753374836; x=1753979636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+YIFa0JQZblYYo6z08SdWvtMeAHwI4go0flw2jU5A+E=;
 b=Hm4pcyDqDfCe9KFS0nOtKEPsfcK+Suh4Fw7qLiDsVr2QxYdhUAehbUPqRQE+g+E0s7
 uRDZUuh7z5L2R1WD9n+ZZ2ajt5lmHjZ+BJdRez7R/nHGa2v8HsiJ1PFdKdagGNQz5lVG
 q4W3H/PUdOdg2iv4Jks6Y4eOH5o+egszyLTBGtkhGxisma3M6Li3GUZG33mWbugBNJOY
 KL9b3a8nDlyhKqADf44kxOyn0XM3s1QbVyfYktp8Jkg3T1LPUtRoxhRuQ+etlR+TvDxg
 ve/AVeE9vTO6pMRzEd6ugmN/KlA74P6OJUoiX/q5GpW0Tjg3mmi1bJ0hR7acQA7sEUK/
 O+yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG6Uel9EbM2zLuDyrHOddYda1O/ub67Qd3fepFU9O8cEUthyOch2GDbTLiVEvOSyUPsS7TiGX+q4Nb@nongnu.org
X-Gm-Message-State: AOJu0Ywi3f4yMLml7dmmIRAWtFwJM3f/AVpqr51aAIepwdEPDYaqzTSo
 zQE3/Takm+LE+XrnHFq2ojgXNE7ZSLz4DZ1QLaI1mzdnsU8KH33UITTXG0Q/6cbs6P4=
X-Gm-Gg: ASbGnctYcR1rUgnCxth3Uf5JPLtOnzieElhvGmIPvP1fwTKstpHFL39a6fF3JeOKsmN
 03Kpbcm7oEkEr7HQnUztSBmHoRkXUTVP6LnonPmLdisTDBRno6t9Z/Kh/8kUpd0+y3oZMkhLNCS
 dwhzPXIw6qGxV1gIUCxKy1bkcXqSTbfaMFVypYPIcN/WOAVLv3PgAzhYPbiEPRxAnuL03ItmY7Q
 GBW9SZkrU/eY6UdjsZBojNRgOVEFMSWIKPEi/2czjqZgHOvMF0GD/oGmzFJvtLPru1Wk98zBsvn
 7tbkmVTVHcsysWwS+XjEgz79njs3W9bPfsd6TO9yYx3VyCdl+ezLuw007ExAzqRhMMy1TfXbHh2
 8c9jzTSDUuTP89KN06m8APu2AcDu/ZAygoTWWq1mGMtexO2GpkYR9CVdrRAEraTWuA2M50txuV8
 pt/BB69SVRA9J+UwdG9Q==
X-Google-Smtp-Source: AGHT+IHWJeFMMrSf4d7u8k3kEvDnIu0adEDZ1tZeagSPLyXmDUnCanZSBZBV3DvOyWzx0/dxxipcFw==
X-Received: by 2002:a17:903:198d:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-23f9813e7fdmr108791225ad.13.1753374836326; 
 Thu, 24 Jul 2025 09:33:56 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ee6:5be8:2af4:40ea:5991:dc59?
 ([2607:fb91:1ee6:5be8:2af4:40ea:5991:dc59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa475fc12sm19378545ad.5.2025.07.24.09.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 09:33:55 -0700 (PDT)
Message-ID: <b76024ad-abd6-4606-862a-41cc1d39eab1@linaro.org>
Date: Thu, 24 Jul 2025 09:33:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: fix use-after-free with dispatch
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Peter Xu
 <peterx@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 7/24/25 09:11, Pierrick Bouvier wrote:
> This patch takes a simple approach: remove the cached value creating the
> issue, and make sure we always get the current mapping for address
> space, using address_space_to_dispatch(cpu->cpu_ases[asidx].as).
> It's equivalent to qatomic_rcu_read(&as->current_map)->dispatch;
> This is not really costly, we just need two dereferences,
> including one atomic (rcu) read, which is negligible considering we are
> already on mmu slow path anyway.

We're not just on the slow path, we're on the tlb fill path, which is even rarer.  Once 
upon a time, memory_dispatch was used along the mmio path, but even then I think it must 
have been premature optimization.

This looks like an excellent solution.
Thanks for all the detective work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


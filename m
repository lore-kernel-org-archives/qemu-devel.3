Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F5CC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2VQ-000440-81; Sat, 08 Mar 2025 17:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr2VM-00043J-Ta
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:18:49 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr2VL-0001CY-8o
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:18:48 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so744883f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741472324; x=1742077124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bE4s+uQUTKjE20/T063tTlmuA6cGR6ve4tSjZtezl4I=;
 b=J6IT2oBBpx3W3d1xCRYDRdBVpYCNvPTTG9VXwwJVCydm7Hd1xGFaPvUUJpYsfHT9U9
 WZG7V7mj7S40J56SFdeScfJCADGh1f6Uo3X3OCcLvlw93pB7N6p6eDYBXuo7g/T4dUUa
 H7AoOin6fko0faJs1vtpbQ6RcKg/AnVNGaLvfNdU14BimNw2/9Mrcl9HO9dwE5lhxQ2U
 lABRzKJffKZGu9P7TNbJvED9jS1ooP8dkq7DZ6ddgocaO7IDDBIzl2jlA3afV9C1t4Py
 nUmKqAHI6kkfwXPqW9s9faVd93nIH7j2OrR+C8OCIdQ6tCqVlkjL5JGdIP6a0ErppiNj
 E8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741472324; x=1742077124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bE4s+uQUTKjE20/T063tTlmuA6cGR6ve4tSjZtezl4I=;
 b=m7LOCyNmdhsnq17qdE5ElDkV3QrqMePryLwWkWTqhn79S8rWMtXL+sd4U2WjGgYsNm
 aUcnbf0wfEF/9v43z8mCEe8EmTgl16yX2GZd6PgQRXrunlL25qY4acL2dd8/ssL2KXKW
 paXtdZ3bVXV7yb8kd1ZrPxzGjYhxdmCM1UDGcVb2YcgDdDa5XyYq9l5lGHGEJfgSGheY
 LfTWOTR9hW2eEdAREdUFXwrTds134bklsDhPhp0/LfcpedQuFSiFPPjDjMcKc65pdMhI
 c3WmkJJMkptBYgThIiPGPtIOyme5D8J4GWOUCeyNsCirZuswSALH22VH76FuC1KcAZhS
 E+Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw8wseX6ceOCF3/Az/Ls/lGmnsjk4oYMUjWbYanlWRmdOymzy1HvTLuxVt8gUFeXSUHJgqyxuQfkMV@nongnu.org
X-Gm-Message-State: AOJu0YxU04Ih0wP9DLGK9/skG+sFr9Uu563hqyL94Mm2jxvs0OVZui5J
 TRqJVEt48EpvH7tYcfNhGiXJfZ3V7p5VyuqqlusiRszv3lODnUIGWLLyfvwJcoTgqwexVrOPepF
 fUrs=
X-Gm-Gg: ASbGncuYuT317gXAchTfVxTaTNxTTV4dfJEM3sXKahq3P0ciLYJzcENKUVq7HuMvMYc
 UpuwVs661yCUjXJkJ1+DjzCJOTjnO1r/Six+lBAC+EDS+b8R4Fv/93nq90NOQ/1LQkqj8aWKVtE
 0wWPFLrcb60NCMLP5yI19adAQljgr+afouIeQWRRmTK4Pf14F9gyTa90bDFUU2A6XAYcZwesWI4
 nginvQ5y8/MZq5GKlrmNwPtOprrk6st4PO+RgHkxdwUKhQLPYynP4vROA4Fn4eUTgVn8j0aENw4
 kklqOpHXaddvSAVH8aoModG26tHGc5TEOR83F8RGwshREeBz6Ko6NxKE7aGC+CEMvcD+RRzxa1J
 UjxbGbErcyekm
X-Google-Smtp-Source: AGHT+IFuKyYSuHlnbKuqHJ0k8vv3APfu0NHZD92t52JUQiHtnmY2CnhpQ1I6VJ06CZt7Hyur3vcGSw==
X-Received: by 2002:a05:6000:1842:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-39132d095d6mr6311156f8f.8.1741472324157; 
 Sat, 08 Mar 2025 14:18:44 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8de4ffsm96862715e9.24.2025.03.08.14.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 14:18:43 -0800 (PST)
Message-ID: <aaed2277-8d4c-42f1-8325-db68162b8b82@linaro.org>
Date: Sat, 8 Mar 2025 23:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] system/kvm: Expose
 kvm_irqchip_[add,remove]_change_notifier()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-9-philmd@linaro.org>
 <6ac48abe-8caf-4897-899e-68af29b2750d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6ac48abe-8caf-4897-899e-68af29b2750d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 7/3/25 21:09, Richard Henderson wrote:
> On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
>> Currently kvm_irqchip_add_irqfd_notifier() and
>> kvm_irqchip_remove_irqfd_notifier() are only declared on
>> target specific code. There is not particular reason to,
>> as their prototypes don't use anything target related.
>>
>> Move their declaration with common prototypes, and
>> implement their stub.
> 
> The description is not accurate, because the new stubs are
> *not* for the functions whose declaration you move.
> 
> This feels like two different changes.

Oops. I don't remember why I added the stubs, they are used
in vfio-ap but I can't reproduce a build failure. I'll just
remove them.



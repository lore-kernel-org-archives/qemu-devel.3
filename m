Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA28EDF175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvDf-0005am-F0; Fri, 13 Feb 2026 10:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDd-0005S1-4x
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:33 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDb-00059c-P0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48372efa020so6189305e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770996989; x=1771601789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsnJe72gNGnBKTQKKyes7c5jXfJjbBMx+bkFBw4FXWk=;
 b=AyebDkZr5PV6amKlWO4f/Fdg4ONmVT2KfCMTJnzJXhDVUZlqJLjn5YQoWNOcfmTrGC
 jebMxpWS1pdjVWRK8Nh0TI5LoYO42iqjcrFAgGZky9pQRZA6NbUZymqOi50OhCZAYx6k
 E1vqF/v8WeM1EPpZsEpZdyxfG7fjrHjZxZnmFIYmbWv6VdAGvXsaNyYDYfVNEftJvALs
 ul3LtIlV0A2U9GzPRgWr77AvLu2NkJi1YzWEVm0G9EnrIKbfxdlIiwLR0Hvjzwgqa6Kp
 9bMAROlo0T++5qM/as7/zixh87f8wGxcFkvFyTiwkY87iLzvNpLDAce5f9lvdI5Xw2+h
 ydwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770996989; x=1771601789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsnJe72gNGnBKTQKKyes7c5jXfJjbBMx+bkFBw4FXWk=;
 b=otiRQTlWDkTpKiWQmXmiAdnMymjBwiT5TBSnQGjtDR73G08vAbbqQ2hbiMy/1e1qQA
 8buinGHRZLAYmNb3dD9o93jWP0ZDjadBMj9hnYoEKAvbAKJwcFxMFLyzGg8WfTTCN6Q4
 1hGpml2oVIY8oVkYwJWD1Vnf4MU8L6oFXJ6ztbdKIevOwDfWDns+/NQbR2V9jfxLk9sK
 0Zu4Van8TkqVBMOEG6ADwXmq1x97LP0KGZvxqZDd3mPr9hujE0oVgcOzpcrEnHPQ2HMi
 nWlOx9A1bjPYupNDix6oB45kxbK6+TyIY7NaUtS+o2CJMbZmI6VrCgj48uY5+bRZbBzV
 qRmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvWZP43bfD7mlvD34gmmkETHoeryjAEHKyf6Fi5il2ebFyk5epUsP9+B632zUPmgFBn5ObPVpC0Eg4@nongnu.org
X-Gm-Message-State: AOJu0Yz94P9GDUtgReOkftIrGs6hS8IdH/kDYqg8Z6RpCjlu3kKqISlL
 qvE4SIHbpC64zbwM5aQpERq2VlFSAwKPTuHma6qT+/T+OVNeONnVXbJzrHIO7cQToow=
X-Gm-Gg: AZuq6aJrNoiUT3fYb8Jl1ePHzRtwKHKQXplOu/rgdL+7d8ImUZErkY3kVbUrT/ub4mW
 jpFUY5SUn0mrXLWRB0MG7FigvZz4PqVoikYCrb1BH+X0me8f+0KpsuuiTbYTfEf7Brcls+IBU9e
 MhtQPyItsnzKhjxcxcVHFUHOvyQ0aymyubp7XIzBiR5fGGsrF10OOmX9qYq7iF7zqJ4x7pZybbP
 tvJcb1txL8DLF9i4dwgLSalJ9s5lS1X1wO0VKhQJ97wouSS5dXOe7ckpsf5ih7te2xx5V/TLWJj
 Q21U68sPJ0Q5C5I1XlK+oKmhy+QLh9xFY71UF4uPxIya+f+6IA4NeijUQ3Nvk9earKY/T9COQG9
 CR4bGQanMsMls1H9qsEfeSUCI30uMDbSlARXvIlDtLHY7uPVZTUaIths1GUBbBAs5G66N3tYt9M
 swsfc78ADOks1EqcLchGN04cohNIyrzuwdWHI4gCO7zRofLi/SbkIFBmex/BAwGkpzyw==
X-Received: by 2002:a05:600c:c170:b0:483:7907:ea02 with SMTP id
 5b1f17b1804b1-4837907ebf4mr5356275e9.16.1770996988615; 
 Fri, 13 Feb 2026 07:36:28 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dfb4bd4sm204665615e9.7.2026.02.13.07.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:36:28 -0800 (PST)
Message-ID: <165d2966-7e35-4a5f-9819-1b179751a8f3@linaro.org>
Date: Fri, 13 Feb 2026 16:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] whpx: x86: remove messages
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-9-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260213034556.13471-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/2/26 04:45, Mohamed Mediouni wrote:
> Remove some messages printed by the WHPX backend that don't
> have an equivalent elsewhere and don't convey an error.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/whpx/whpx-all.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


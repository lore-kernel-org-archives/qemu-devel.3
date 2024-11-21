Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5270D75BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3KL-0006Nx-Bz; Thu, 21 Nov 2024 04:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3KJ-0006Nl-Jg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:18:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3KI-0006K4-2h
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:18:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso4959445e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180692; x=1732785492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nt66NhA3OMEdTR5PV7nTYmEH0k8yZqtGIO+3/Ch3Pio=;
 b=o75NBPvNWoNlvN/3n6t4LToGLnDgshbyp53FG/J0CAr0m9qbRNRUHpmF5mZ8BC8Htd
 1Jh6KYMTDyrom1P3xrwCvOiAzTtQuGO2rDOWo0hVj34fpYUU/wZZmilLKUe2HWb5bs4+
 KFbbhuhUAKYan8tI/x6Ii7quXlL/IttJ65BeK6DL10i3kP/5R/9YebreKjL/woJLThgt
 /m4tZaspaTFs8hBmb8j/o3/ZywXupbaTB1edM2wv7NxmOLZ2yVZhEGcFzG23xyGCuuuf
 5IHxFMsLbKNHpxtIG9tynd1vG3Danv5JpYtRvCZe4jQsddWp3TrvEc+fldmG81kjixiI
 LQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180692; x=1732785492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nt66NhA3OMEdTR5PV7nTYmEH0k8yZqtGIO+3/Ch3Pio=;
 b=r1JxvZrmE8YMcV0rmdtnhAsklV3lRzppGoLUqcPu0nyY3ym9FSAo/w9Kz1B3J6AKU3
 Od/2q6djC9Ye60rHRqbAoasr/Y2TFq1BF2MxW71uCQLZZQvH1hZFBERLNoS2Fyoh8Bpx
 nUmm7uataJZRAH+NDZPBYf6I+JU/m/YL/VX/McpKAjsaakT5ROoJLwqK+39GPAOm/HOS
 mRLN3IhZh8tvenvCn88wvo/WYWwxorVz2ULurIvhca22ZtRPc4TF8txVvQu8PJrbjdbf
 YSFdrg96A/Y/FvwhnLcmqkPFIN60jkd0/efbhoztApLu4SMDUrNwCO94m9XxfVTu8Gqg
 Yv4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXldoKqUPYR5qegJk8ihdwP9vZo11rDajuSzK/F5Ox1QZTcx2REaimUY4cNZv+Z9c8KcMgquP03bpgD@nongnu.org
X-Gm-Message-State: AOJu0Yxj2nCypv69mwmaXAW332vDA57SVOyRkaQWuNYjhpIAcPBWhrLZ
 uk0tLRnI6OFSTr+q2SEUQx/rYoURLPZuMcyx65tM9zfm7KvArZhv8N9MbtS+QZw=
X-Gm-Gg: ASbGncvFpcQmWRzM3WVVh8oIzfD/wzlKoJZricoVa1PdVYmU299u2lbK+FTD2E8fMk0
 /BL74Hbh2Wih8K1I2W+/sMRcwEXO9giQmGQCTiKPYKPyao6tsXP8OugOyyER+ZUFWABP4Mwwl1a
 aj4++iV8IhtYFyFUGfKEe1rdP+dhZWqX6jChZQfl0iShFqpJBY9rB51zCB8ARgRkkiZFGv17giX
 So4YvwTGod9BslSF1zvyzu6G23RULOTUxb2x/JGoPOxR+35ohY5e6QcF8BV+kmMjyyhew==
X-Google-Smtp-Source: AGHT+IHmcU8qYRf53zoNdHjyHKDWLtTAlurgc18rAwywSeTtGP7DxHbgl/Cw9DvPo6Qn+BHv0/TCug==
X-Received: by 2002:a05:600c:1d9e:b0:431:60d0:9088 with SMTP id
 5b1f17b1804b1-433489b4401mr49771065e9.13.1732180692422; 
 Thu, 21 Nov 2024 01:18:12 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm47242575e9.43.2024.11.21.01.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:18:11 -0800 (PST)
Message-ID: <53e20008-4d62-40a5-be0a-cf2d02009d96@linaro.org>
Date: Thu, 21 Nov 2024 10:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] QOM: container_get() removal
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/11/24 22:56, Peter Xu wrote:

> Peter Xu (12):
>    qom: Add TYPE_CONTAINER macro
>    qom: New container_create()
>    tests: Fix test-qdev-global-props on anonymous qdev realize()
>    tests: Explicitly create containers in test_qom_partial_path()
>    ui/console: Explicitly create "/backend" container
>    hw/ppc: Explicitly create the drc container
>    ppc/e500: Avoid abuse of container_get()
>    qdev: Make qdev_get_machine() not use container_get()
>    qdev: Add machine_get_container()
>    qom: Create system containers explicitly
>    qom: Add object_get_container()
>    qom: Drop container_get()

Maybe split the last patch in 3, reordering as:

- qom: Create system containers explicitly
- qdev: Make qdev_get_machine() not use container_get()
- qdev: Add machine_get_container()
- qdev: Use machine_get_container()
   (part 1 of 'qom: Drop container_get()')
- qom: Add object_get_container()
- qom: Use object_get_container()
   (part 2 of 'qom: Drop container_get()')
- qom: Drop container_get()
   (part 3 of 'qom: Drop container_get()')


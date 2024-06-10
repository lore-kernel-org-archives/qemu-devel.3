Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FED4C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjJ1-0005bf-8I; Mon, 10 Jun 2024 13:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIy-0005T3-Gi
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIw-0001dp-T6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f1c567ae4so1633747f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718042377; x=1718647177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdDGydQq1CQ8vsBVnQtBDkDduOApygZZD0FcJOAyTpY=;
 b=DRzgZyoihmNmm5Q9fGa4tq8ba/2OAci8VLej9azV3n8wtl8/KnkoXB8ySFpt3ehMQp
 BgBMR3hFLupjs7mMTu83g26k+/ZoHebFenHWUjmgU2mChW/rdz8nV+GUZm68eUhjfxXf
 XNwBNZ8hiWcFgS0Yb2rswbL2jSCp4Oct+k6RIhQnVOm7KJd0raFCDaKu7NVkCb7e98OD
 yGwTWFTPhdAu4ilysDWICPURVcdjWc33E9/kPIfkL+aa3rQGIyMdc9GrOUVyuWE1zC+Z
 STcGHVZZOYXOFsUIBecRUvhNbZHghg6UwVdGK7quOICJlhajvw3a+tb55jA+ihUGFiE4
 mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718042377; x=1718647177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdDGydQq1CQ8vsBVnQtBDkDduOApygZZD0FcJOAyTpY=;
 b=ITCO6u+M9wBbtsUvumRtcREdr5gyReWpCyP7EkY+ijM5D6w9mS32zTnw5tFXyGiUs3
 BANdegn4xn+ePoCruC3idDvE9p3kH8G3Kegxi/Z6haaqqu3PxBX8DRR20sHifKoFj4kh
 QJmodJOMyE2Y4geguM47vGxUO5rv+Wi1ugKxIXD27o495Eua/x8RLop8RaiFb0msaHTA
 xYlJP5osaMXO1CBTGBar+JPYSWJWMNMOZq76fmgEdk/hGf219A9Z0MAvoojEWxJ0joEl
 nO+ShAEsZIh2ZiX0RBEBWMqFM60YBdrqQbcLC0fkA/UMdO15F53ZZE5YC1XLhh0cxHi8
 E6yw==
X-Gm-Message-State: AOJu0YzdGOpKFVPlLYRjVWyCgVcl7FAkNOApxLOPXXc/+DSPnLrOnE08
 so0LfWjo1SDGMqD3uEp0xvOCEXP867XJ1iJd4TcARueAhXdhswAivn3fW0byikY=
X-Google-Smtp-Source: AGHT+IHjIVOX2JzmM5Lr8SO6eX/2ec8BuhedEb+iM37qGlBQ+Ld0SPorR4Us1RzIG6GxL121eGC98Q==
X-Received: by 2002:adf:f0c6:0:b0:35e:8364:f4d4 with SMTP id
 ffacd0b85a97d-35efedf7e01mr6311694f8f.58.1718042377215; 
 Mon, 10 Jun 2024 10:59:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f212aed2esm4278439f8f.26.2024.06.10.10.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 10:59:36 -0700 (PDT)
Message-ID: <56233ae3-866d-4d32-9e85-f0b67a6ea0d7@linaro.org>
Date: Mon, 10 Jun 2024 19:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] trace: Remove and forbid newline characters in event
 format
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20240606103943.79116-1-philmd@linaro.org>
 <20240610170533.GA343470@fedora.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610170533.GA343470@fedora.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10/6/24 19:05, Stefan Hajnoczi wrote:
> On Thu, Jun 06, 2024 at 12:39:38PM +0200, Philippe Mathieu-Daudé wrote:
>> Trace events aren't designed to be multi-lines.
>> Few format use the newline character: remove it
>> and forbid further uses.
>>
>> Philippe Mathieu-Daudé (5):
>>    backends/tpm: Remove newline character in trace event
>>    hw/sh4: Remove newline character in trace events
>>    hw/usb: Remove newline character in trace events
>>    hw/vfio: Remove newline character in trace events
>>    tracetool: Forbid newline character in event format


> Thanks, applied to my tracing tree:
> https://gitlab.com/stefanha/qemu/commits/tracing

Thanks!



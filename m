Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F93E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKLE-0001Ms-86; Thu, 19 Dec 2024 12:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKLD-0001ME-1g
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:29:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKLB-0000UM-EJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:29:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso7751115e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734629375; x=1735234175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbxRKPkn7Dyf4gGzJt/lRLZ4erUfARA0n7n0OMomHhI=;
 b=knBR3fbS8ZHVhf1NBXqWVK37ZSJy1v8pJ0ZTGnH9Ag4KF2R8DJrb39Kaz5pYlG8r7u
 p44j82F6RgQhuTRYP4J52HqJnZd0PXF3Jpcs0NxiE6a++Iir52htURmTZt4/M/PwGcKa
 w/kLz7r+dUcioY0Yk7FR26Cjy7MuT7bx8j0o7FLnPZ1nYmmCEU6BwwTo2YPYZBSFTJ0U
 2KWOddoSEfiGR16PGJsfQFEZIOtt2Wp5l3QKBSuJRcmNwbg9b4HCsb7HnWarS9CLPhzH
 x9HCiQKWnGDamGJqFL/CQKAWunjb8Y+cCOvdBTfRltL1WKZe+WLkp3/1bAGsNKr2clP5
 yk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734629375; x=1735234175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbxRKPkn7Dyf4gGzJt/lRLZ4erUfARA0n7n0OMomHhI=;
 b=tiSWRgNElea6iZ5PIL8NIGVwzDa+a7xrUd1/dseKRIlzzQXWT2k+BCPY4OYDnJuYdR
 UpN0dx3uSPSsppzBLMksr56AHp3CzZa1XQfeHTSs2L4RuMcIY5KQHAwUnGlfZ3RN7ecE
 fJkI5m2phZcZuDxHvYPJJYK5oFQmAiue5Z+pWmu8DGFGdIEXnSsY12LmGH7r7yC3PTPZ
 fze1YA00cdAdGdZWZcZ3clGuVljL1ndTVHwDrZsLNRGDm+AwJ8iyfrNW0up5oTymdPVZ
 yqdM5bsC04CatzaZJU9wovBMvgRR/pFTt7PIWBLz+7Njwuz5lO8xho0ZmMV1HnLeRPNp
 rL4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN+Ml7cvAYZdeDWq5u/uuDjojv7JrPsFifm4BA9qow3tKvSaWyU2ZkneLhb8uzg+rLXoU/JufXHqL8@nongnu.org
X-Gm-Message-State: AOJu0YwTM5GOwjiyH+d8ec/KA9bQWXQ73F8F+31o4UEtHad32muc7iIX
 C50NqTtbZdlj/6qTM7lxAPFIyuIE+h1OTwFVr2bg3yXYM1vvnkYAyGepD0wlAt4HXshevyTDL03
 x
X-Gm-Gg: ASbGncvpQLMHyvbTrGL8Wx68rL0GqhB3xPksAr4DhHrvW0fysqUUeRp1BbwNR9nKO1b
 L0WfRkkq2Gum/wEB8fU5KcoC1H2AO6i4tGOMj8V4pnZ1ovkmnrFJN+Mm3zf23qm4Y/hQth7KDeW
 mjgRX4pBzOVhewNF81u6eb6PcyXVkef9rHww8/UQr1jq44B+jYKfoK6fTI44fjGcZ0X2NsJQQVT
 QklPL8G5Nqcm2YI4YW5rVac8AAM0skbDxBoEnVDzK1OQ+Z33eXQTCuEcUMZX0SIMiQ1MaA=
X-Google-Smtp-Source: AGHT+IFgTGn8JykHIy+/AjBQuWePRStN+EduE9PcmT6iLizT/FJkh0ICkThf0gBlsi8YgfMSgX/yhw==
X-Received: by 2002:a05:600c:4fd3:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4365c7c83d7mr32443695e9.26.1734629375325; 
 Thu, 19 Dec 2024 09:29:35 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84722dsm2024795f8f.53.2024.12.19.09.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:29:34 -0800 (PST)
Message-ID: <499660d4-2536-45c9-8979-e743dac8465f@linaro.org>
Date: Thu, 19 Dec 2024 18:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] QOM: container_get() removal
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 21/11/24 20:21, Peter Xu wrote:

> Peter Xu (13):
>    qom: Add TYPE_CONTAINER macro
>    qom: New object_property_add_new_container()
>    tests: Fix test-qdev-global-props on anonymous qdev realize()
>    tests: Explicitly create containers in test_qom_partial_path()
>    ppc/e500: Avoid abuse of container_get()
>    hw/ppc: Explicitly create the drc container
>    qom: Create system containers explicitly
>    qdev: Make qdev_get_machine() not use container_get()
>    qdev: Add machine_get_container()
>    qom: Use machine_get_container()
>    qom: Add object_get_container()
>    qom: Use object_get_container()
>    qom: Remove container_get()

Series queued, thanks.


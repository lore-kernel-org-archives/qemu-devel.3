Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C7FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFOA-0007Ws-Es; Wed, 14 May 2025 12:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFO7-0007WI-QS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:55:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFO5-0006Lg-9A
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:55:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so439985e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241719; x=1747846519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5YmH83DL5qCu2KgAqq3e5Mot8qF1ZcGRJ0pxxN+rW0Y=;
 b=Cf8j+fxpdgPDcSLD48/qoR8ntiGmF+8zRbsmtbBmTjhAVeAuK7/6cunGJVpmW0JvL/
 oxsFkbikRTE7eJyBaYsBPNxGrsLvtXUwrzGDl2+TXDqiPkvMbS7g7L4j1j5fy+nD/0JL
 WOx55VLtKAHqsfIiIR7ibTjTHmW9frL/WcCjp4dOjX4PlpCc4c4sbmvJqKZTXx2eS/y1
 mw7eLkCcBJVk7lx/f46m6Y7DViwBUvuOkxRj8k72dL6dIavSOaDJCoTO35QpTMSsXNtu
 Sy3ZtupYnqXbPMgy9WDWBg/6d5x7wdDCcsmIeo6RIlaKD3kOmCzXJB+LFTBg5UTws3WI
 Q5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241719; x=1747846519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YmH83DL5qCu2KgAqq3e5Mot8qF1ZcGRJ0pxxN+rW0Y=;
 b=E7TB7iIN05Pe2U1CoP4fDG4REcLM91LXXN735x9F4yk3XsdWYtDncH1RRSgWhQKfcW
 7UAwvkVBjQIJn2eReOVUxLlEkvObtgG3rB4EJ/u6h4ytFqhUrEFRfMhKFOmg297ACHEB
 vKmKe3bsGg7hXoDnbe0qWuvPxIHvxooSn39WTLHktIz+pNOeRRpYX3ys6ERcEiUCboF8
 Q/J/hIkBQHHVDHs0BdVoCwfrYKvdY2iwow2w2t+4yJegkKRcvsbt4/Wk/MEXv0IpuA4u
 gyRQWB/JBMd7Dej/+PHIiAXR5lbVIQVh+aLFY11ezJWbjk05XqbtoKUvT55XbCeQUtxM
 QTgQ==
X-Gm-Message-State: AOJu0YzsY+CkxmkDLUWfE2cjOxfue/GRGEwx2vtTVRxKtVqzY2S9LZla
 vCsiqEBSaeGxJJYkDA1sbaelZ+YPoh+zMhFyYl1WAAQx1LXRXKvhDP4E+Dm5nUo=
X-Gm-Gg: ASbGncthMdlnN+0kXlXgR4YcfYRs25WLGvntAeMt013T9cS1x2Addh+B+8XBDIYmoJg
 +3m42pwsyGgDIV2HiwN/E//qJbckN4iNkDgJ5SnGQWWyD91LTKSpMJROkt1X6LX5+ZPwGPMA4jv
 cn1/J7QwwmiBA01SZhSj2/yvz4UzDYI+HrqtaGDJQYimDfk+MPekhDUocMqQLQQnt4DK2FG7bM0
 1hQ792xQ0dZglOjc09auc0KGV7CiVGCDytRXbSa5AtWku8jhl+tW9QNAWzNKwbLVkCN1UfY6Asa
 DLnH1wTjlizzFf4jIDV9owxdHIu4LibRk5S+wlyNJnrCyZMArSp5+TTR1m93Gg92HaYEhGY9ADe
 Brvw3l5959kb4vWxfDSmZE/qYsHW0
X-Google-Smtp-Source: AGHT+IFGTmOgrNZAMcWEtFGHGlA0YOqV/sL0anwCJgY5gjRcMmrErrxpuCAIcvrXcG2hbHEWuycqVA==
X-Received: by 2002:a05:600c:a42:b0:442:cd13:f15d with SMTP id
 5b1f17b1804b1-442f217a65fmr35862965e9.29.1747241719502; 
 Wed, 14 May 2025 09:55:19 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm40081985e9.8.2025.05.14.09.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:55:19 -0700 (PDT)
Message-ID: <bb021456-83d4-4a7b-96fe-0ddc1c0fac7a@linaro.org>
Date: Wed, 14 May 2025 17:55:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] ui/console-vc: Consolidate OBJECT_DEFINE_SIMPLE_TYPE
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-10-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514084957.2221975-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14/5/25 10:49, Zhao Liu wrote:
> The QOM types of QemuTextConsole and QemuFixedTextConsole are declared
> by OBJECT_DECLARE_SIMPLE_TYPE, which means they don't need the class!
> 
> Therefore, use OBJECT_DEFINE_SIMPLE_TYPE to implement the type, then
> there's no need for class definition.
> 
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   ui/console-vc.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



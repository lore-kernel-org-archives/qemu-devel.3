Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC65C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWI5f-0007TL-3Q; Tue, 23 Jul 2024 12:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWI5e-0007Sh-2Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:10:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWI5b-0004P5-Tt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:10:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so2295963f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721751010; x=1722355810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/qGxzWVKwBzyns7uKu0Csr6qKZITAaEc42aAQP0aWs=;
 b=X0DY09cRrxkUULc3zNy4UmstTkUM4kOxXdDYuPyu/aQwd5eUpwrJg4GrlvNVqtx9ZX
 urc3ptZvm3v9mnnzywbxD2bvEuRQsQpKi36OeewPJh+5cuiT4kMdhHvB8wmsc6RzAXKp
 Gq5yujBqy4jMI+AM4h87lFkVZbXVn7J9rbauyRZObZMK1k4tnA7LAS85M6XCqhTEtFuk
 mjOtUC0LOWNW61kwozaa9XEu3udnZqoWffYvNSCK9no+z7b5YYP1Li0w1GOS6GJb9sb+
 grnyVEnRqCwS22MykXcb0C4oWehYMAFPnxWYPEQ8PBSC5JmONNrmzcPNGEyXlKWYGGe2
 kegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721751010; x=1722355810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/qGxzWVKwBzyns7uKu0Csr6qKZITAaEc42aAQP0aWs=;
 b=hwm4VQb8b74nM6zpG9LDJJbWLNKBq5mkzMrZb3zWcJmcaUtNxrybI2eJtcJg2oeKNo
 HOv1z9oJFIjLH6N3Nn9WdZJoWGqURgVl4fVTak3B9n24J1LOzOYXti/uAEfuwWykUUW5
 c4utFGr1frSUuIyB3FdoycQP1gIV+4ouML3b0N/dsWHvHAhZoa6AUK7Kkv7MyPRZpbpU
 TTAuX2M4KxB3ZoLOGVNiQndkykTVC3PEVT2p839nvr0S9wUJgdzXXtH7NIIP1Li9jiZ5
 IgYeUhmyjTWL09eBC8Ik/luObSIeznvrlm5h6zDycEdqOZggCWbSOZ4neEUzJQiRgTaL
 rRaA==
X-Gm-Message-State: AOJu0Yxgr5q7lHmnL5teNAFysXqwBMC9yA968pWY41kMQGczV7nsdPTd
 IrXQ5hOWlIEFVOjfc4JtF8/BXQrGzMqF/NwQj43VmVFg0O+hdLCL1OMnvNJdZpE=
X-Google-Smtp-Source: AGHT+IGRWRMRpWe3TtlASdkMT8qfu3aV65Qt6vH5KJECQNLcVk8r7HUnHJaXgrSrviGOhET+8y/QRg==
X-Received: by 2002:a05:6000:4021:b0:367:8f89:f7c9 with SMTP id
 ffacd0b85a97d-369e3f2f62bmr2036633f8f.33.1721751009980; 
 Tue, 23 Jul 2024 09:10:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ecec0sm11895692f8f.105.2024.07.23.09.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 09:10:09 -0700 (PDT)
Message-ID: <de954795-ecec-435e-8166-989296c56bfd@linaro.org>
Date: Tue, 23 Jul 2024 18:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD()
 in nubus_virtio_mmio_realize()
To: Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240723161802.1377985-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723161802.1377985-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 23/7/24 18:18, Zhao Liu wrote:
> According to the comment in qapi/error.h, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> In nubus_virtio_mmio_realize(), @errp is dereferenced without
> ERRP_GUARD().
> 
> Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
> method - is never passed a null @errp argument, it should follow the
> rules on @errp usage.  Add the ERRP_GUARD() there.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v2: Used Markus' words in commit message and added his r/b tag.
> ---
>   hw/nubus/nubus-virtio-mmio.c | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks!


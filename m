Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9263FC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWKDI-0004tr-Gy; Tue, 23 Jul 2024 14:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWKDG-0004oE-U0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:26:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWKDF-0004vH-4S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:26:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so51131545e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721759171; x=1722363971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wTe0tRatMOKSj/e9qM1gwluwhZ4Ul7UXApUU9qBO4AY=;
 b=rspqBeGr9hsIEoI8TEbvX0lFqMONd0MfEJlswiJeSpl/9qeI8eNkBJTJV+VVkvloYi
 JrtPbClh/xUNxjqQeiHIURFpXNjz3ZbAZhKLoOH+PsEWjBa9AlHWdlSk4GkYn/LQz/va
 9pbGjFA2+jQ7YkrDiwkoQbIjbNHfT0AhDuZnt5c6omq5DB3nhNBxb6Zu/qYJdCtVSdlY
 dnxeY8v4TG8r1XtP0KgptghbOwM06BBc0WklfGljl5T59aBZHNr9FOQjkt8UNfxyE0IU
 QOeOb3Z15AYXHcBwfEemWHyFEoijXYZBSnQOtvUCmbiqIizOLYZYVUKjOqosoIfIDE8R
 kwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721759171; x=1722363971;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTe0tRatMOKSj/e9qM1gwluwhZ4Ul7UXApUU9qBO4AY=;
 b=eIgc7Mokz20CqrgEmAG4ugTD3dwPLngLQdxMC0VydqCazoNwebDpZFPallQ7qAjO4z
 jFYpYYJ8aq2FPbNAKYwYYq0swOHEOYq0DeIba0mkfaGQQHXjHgdIIS7Qk9EmBKXBK6bH
 hOO3FMjMNx2FlnKSBPrq4TVTwI8+4x26B6MKO66EI1jwXQc4MPAe/pnhEdmFHxgVT4XX
 Tf8mgNMNn68/61r4b7AFxb9PCHSNxWo6Gl/Cv/z7zdBbEnMUDRN68Kl+TJAIDCVX1RTF
 rafaEYREiKCCi3k/1CQF4x70ilBNyWJSV10l2EigTWAgfy5b4x/KiTIi1sdgka0AEukC
 yyVg==
X-Gm-Message-State: AOJu0YwZiDl8/Yz4bqesXhV+Bvm3nJoRGp5f52/zWj4ZG28sOHlqtbdN
 4gysv/4tTLlsbdxrdSaitBE38PSlv9UAOYLetk6Qgm728YR4mpM9A4O6n+cjM2M=
X-Google-Smtp-Source: AGHT+IH3nOPDWEXwuyaqgdBzi2M4vJLy8+TL1hDDZ9NouR/FSBqmGMMIAwlK2JxKajGQcaB8gkXMlw==
X-Received: by 2002:a05:600c:511d:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-427f7ac24fdmr2763695e9.19.1721759170988; 
 Tue, 23 Jul 2024 11:26:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69070desm185376015e9.24.2024.07.23.11.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 11:26:10 -0700 (PDT)
Message-ID: <bc14cdd1-35ca-4fc8-b67b-57856c49b7d4@linaro.org>
Date: Tue, 23 Jul 2024 20:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD()
 in nubus_virtio_mmio_realize()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240723161802.1377985-1-zhao1.liu@intel.com>
 <de954795-ecec-435e-8166-989296c56bfd@linaro.org>
Content-Language: en-US
In-Reply-To: <de954795-ecec-435e-8166-989296c56bfd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/7/24 18:10, Philippe Mathieu-Daudé wrote:
> On 23/7/24 18:18, Zhao Liu wrote:
>> According to the comment in qapi/error.h, dereferencing @errp requires
>> ERRP_GUARD():
>>
>> * = Why, when and how to use ERRP_GUARD() =
>> *
>> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>> * - It must not be dereferenced, because it may be null.
>> ...
>> * ERRP_GUARD() lifts these restrictions.
>> *
>> * To use ERRP_GUARD(), add it right at the beginning of the function.
>> * @errp can then be used without worrying about the argument being
>> * NULL or &error_fatal.
>> *
>> * Using it when it's not needed is safe, but please avoid cluttering
>> * the source with useless code.
>>
>> In nubus_virtio_mmio_realize(), @errp is dereferenced without
>> ERRP_GUARD().
>>
>> Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
>> method - is never passed a null @errp argument, it should follow the
>> rules on @errp usage.  Add the ERRP_GUARD() there.
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>> v2: Used Markus' words in commit message and added his r/b tag.
>> ---
>>   hw/nubus/nubus-virtio-mmio.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Patch queued, thanks!

Squashing:

-- >8 --
diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
index a5558d3ec28..7a98731c451 100644
--- a/hw/nubus/nubus-virtio-mmio.c
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -7,6 +7,7 @@
   */

  #include "qemu/osdep.h"
+#include "qapi/error.h"
  #include "hw/nubus/nubus-virtio-mmio.h"

---

to avoid:

../hw/nubus/nubus-virtio-mmio.c:26:5: error: call to undeclared function 
'ERRP_GUARD'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
     ERRP_GUARD();
     ^
1 error generated.

Better to test your patches ;)

Regards,

Phil.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A41BC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQQb-0001ck-Rx; Tue, 04 Feb 2025 16:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQQZ-0001c8-VV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:25:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQQY-0000WI-Av
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:25:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso42132435e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738704348; x=1739309148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0yZ3rGNBWFbwR7tcrMEb20ea+rfzWXUZz9frnWzuoa8=;
 b=nhlZXk+7w32LOJEonxhiZSoYEKx25j9/aXwnHbBWUXbM/rYWH8yefsf/tyBpAWUrO+
 7gUP4FAVw70r2ibCaIi46Q/eTscFIlPlWO9oIC79fdb+08FhAh2vk8Z5TcFjas2FoeLg
 FDjjTaRT3fR4/6A8ZRLiThemjcyyCZLeXZKrR1pmgFfB0n8DO+jvHgSSRMUnTVBMqCwZ
 5xVo2H12WKq0a9JSLUIJcQMJUwPpfA3oq2KerZwCsO4vnbO0JWPUSJ8EuM10s6AJyPQb
 8VglJusFRp8Ad6Rqy23Fx1H64w2Qhm39+ImiSttt+ZswjKfFUEhtBcLrLDeaDMKHMIw/
 yEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738704348; x=1739309148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0yZ3rGNBWFbwR7tcrMEb20ea+rfzWXUZz9frnWzuoa8=;
 b=idUTSmDDYjn55Pd0YiQg4HwacPBqND2Scivp77HRpHWevHD/Yqj1g4gyXN8zjeJLZr
 xNfXSyM4p/4Igwb0cyPTXs7Kd1S3PxP6iFOitqrB3cAMbiWfWQ/b5Uij5RZl7AapaGvg
 4TkBTlCqZ5RpXASvi5jxkEelY0SBh711fcatjnqMnigiB0PKQiF+7esdPmz/mu1isuq1
 V8PwPMfQMZ/FMXGPpqcrE8KCkuOsVGLLSnLnlMgoJcNRoWg0QmggDOuzEa7CGYgbNNoD
 gNeGXnjbV17x3JPlkuLxDTdiMrrTnIq8efP6yeI622kwLiKGjrnEHdYZitmSmolz/tYI
 JhfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLSUUETYxEwpD68p49467UUgVA+qMTKc0+GD5B14QlctBxRIyIjBCFG2tPb3ITokf1K70qwoSBISFB@nongnu.org
X-Gm-Message-State: AOJu0YzoKZxXUpf64/iFHAscoZil40dE2h/4zoENBxuLnJqrBGMysQFH
 tB2WeUyYsmfEYZqBl4XlFppMucyec2i8mCzrcRLTSSz+uk81vIiCcR82pV3jT7M=
X-Gm-Gg: ASbGncsGlEhFDchqE2UpiVwhOZTOmELffcg4zXKbrdwb7HfmSiD2WNQ7WEfz4ZK0+dR
 0YkBRz+xBWPEquKEat2GEUarGX24dwRXUSyvqhrfhFK6gpH8tb9+Ik7/eBIfiKn+K6TNl7z7jgw
 2kUA9XCjIxZlZA4UOj6U2cFukz5kgaErpSILfBYU7KMRR3mkvfrIhEXjAevKbd1Swa81tVlwZuA
 XWrDSG0D9OAVHyvAln13tJ/8BHvuwfjlyOicAL+T4VCujXd8/iiYyJurowLIeTsvN9zoZIDy211
 2WXR5lRQDQNMm195q5gXjVhfXA/HKL4oS6CcnhQf3D5DjRhB0EVWZT7nITI=
X-Google-Smtp-Source: AGHT+IEKxmr8p6Gdjx/D0eeb7pj0vKXisGW1fMr/aKDXpj9R2377FaYU+L0nppkxwZjSdcCGKmolEQ==
X-Received: by 2002:a05:600c:3c8f:b0:438:e231:d35e with SMTP id
 5b1f17b1804b1-4390d34d20cmr1876685e9.0.1738704348532; 
 Tue, 04 Feb 2025 13:25:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d966faasm227375e9.23.2025.02.04.13.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:25:48 -0800 (PST)
Message-ID: <02ea4b41-3594-4ead-90d3-0ab06f2be7fa@linaro.org>
Date: Tue, 4 Feb 2025 22:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] hw/xen: Have legacy Xen backend inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-10-philmd@linaro.org>
 <9A2B297A-6270-4482-B1B6-81F518C07C1E@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9A2B297A-6270-4482-B1B6-81F518C07C1E@gmail.com>
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

Hi Bernhard,

On 27/1/25 10:46, Bernhard Beschow wrote:
> Am 25. Januar 2025 18:13:43 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Because the legacy Xen backend devices can optionally be plugged on the
>> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
>> Remove the implicit TYPE_XENSYSDEV instance_size.
>>
>> Untested, but I'm surprised the legacy devices work because they
>> had a broken instance size (QDev instead of Sysbus...), so accesses
>> of XenLegacyDevice fields were overwritting sysbus ones.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/xen/xen_pvdev.h  | 3 ++-
>> hw/xen/xen-legacy-backend.c | 7 ++-----
>> 2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
>> index 0c984440476..48950dc2b57 100644
>> --- a/include/hw/xen/xen_pvdev.h
>> +++ b/include/hw/xen/xen_pvdev.h
>> @@ -32,7 +32,8 @@ struct XenDevOps {
>> };
>>
>> struct XenLegacyDevice {
>> -    DeviceState        qdev;
>> +    SysBusDevice parent_obj;
> 
> This then needs sysbus.h rather than qdev-core.h include.
> 
> Moreover, the patch in the reply needs to be inserted into the series before this patch.
> 
> Both are needed for the patch to compile.

Per your reply on patch #7, might I include your

Tested-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Bernhard Beschow <shentey@gmail.com>
(or R-b)

squashing:

-- >8 --
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 48950dc2b57..629bec90d09 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -1,7 +1,7 @@
  #ifndef QEMU_HW_XEN_PVDEV_H
  #define QEMU_HW_XEN_PVDEV_H

-#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
  #include "hw/xen/xen_backend_ops.h"

  /* ------------------------------------------------------------- */
---

?


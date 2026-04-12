Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92764E937E7
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 21:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC2AP-0006WB-59; Sun, 12 Apr 2026 17:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC2AM-0006VH-Vm
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 17:16:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC2AL-00056F-7y
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 17:16:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ad135063so35534355e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776028583; x=1776633383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOWlh7RaZ22fHonlFjirI4+/eY9EUZxtnzJOB/0+/dY=;
 b=G/zeJWXczqsZMI9YpCsklLkLeolZDlCBD/sdC/my1mnfPcOUBBM9JZz/7yk0+tTEr3
 l1RelHRt/8djWw4gXkm+6bDWubfS8RjNWnqgMSv43L0ifbc4Eq8miTP53cFfyLXSzYKP
 zfJCsJs3AOqFoFdvw3O7ECKncoC5xufm3e1/PqZtp0ErrYZRacppqqVAyWOQpZdGb+pV
 B81Y+33qcvRhhesLAkTS3yYm/BHfc3mxxelTxpIPQr6pl1BF0GOZJV2JsVvG6quEwcVC
 gyem2QH6bZ3lUpD05vN9WMKp5YCvSZCv7bGqnxRQKsmm5qroV27PHvUHfdZ1CA8a2Emk
 9Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776028583; x=1776633383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oOWlh7RaZ22fHonlFjirI4+/eY9EUZxtnzJOB/0+/dY=;
 b=IxIvm8KDCVbBbd3+m9dJ5OKqmntnAQ1G/8aEV+Sexfb7dQ5wdQJXO4Gr5IbJyLegab
 86gkPIf28MauGpuQBYf3YxdC1OKdQV4m9/y99rghnvGeHSbrCPoNqR88ur6Qa77q8OgR
 Q0atSI/LP6kFDaHBqMi2h4s+YqkfGPMarN3KpRlA4AzGZPGfvRMSZGcLqn7gd3/x4/ah
 lRz0zUE0x7pEdUCvGl3GXMl+akOlpCwEtHzfj/zSEHR3scdNunRj3Msmb9KjAsbqfZWz
 xSrv271ExMwYtJtdQrWwLGzJXUmbcah/FP4NUCmtSusnq5mDb0J/aDemmvSps4GckqIr
 zZzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKLARzzdGI7peoY99qEKTaxT/RC8EgjWQJ0WnhTmyyu8wa0g6C5z+bSP/+W+oYjNBJ+be2eg61VbsO@nongnu.org
X-Gm-Message-State: AOJu0Yx4Sx2q9C2aroUa9B9ujp5E+JMj9di4yCDD/B0MPRdkV7dJoDjb
 bPXMZohREvGfpDlQ5CvFU1CkogafaHVHZeWnLcBVDYFe9W6euQ7Jl4IxvaGLac9RceY=
X-Gm-Gg: AeBDiesnHJpg3upPbM6liAqXQVIdDnZF2sHem4KRIuHvH1V1qb03ZXZTKEg+jX0/CwI
 ZIM/KkaUlN61e3NYK3F3PE0IwLw1S+9t7T35aQbQk9yIIqSVDUf7B3xnOHsYwqsiscrqUpR8Jqy
 c/883mYYekUFLjbAPv1FkrvfJ3ga3yBBfv1yQOd9xhYd/miZ4kdCHlXx6en5fJ4kP+BcPVJpFSV
 a3co4d2qzPnPL8pjALBdIZRa/il3dxXLY3pRXwPZueRdQabV7gsmRk/DsmkQddCMgsFgyabZTan
 +HX9TNh8uv6CYVLdHPEEJT/It4v5euDJg81ebFAmKJ0vaQO+mCRj5NqZkgfDeHlN+ij/IoHznPc
 GnyY62fh2IIaty26WQzFA/VWj+EoaLOmcvOilpsPxg6U9Bp70Ugi27Y+PSneQ4t1iWyxWIBX4OZ
 KcriL5ttgsuSCU9j6T88fsahSmoym0teB1hCXB07pr/S3trXBSR5EFQa5cGUpFXMPmjQ==
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id
 5b1f17b1804b1-488d682628dmr134126495e9.13.1776028583184; 
 Sun, 12 Apr 2026 14:16:23 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ce8b7sm116612465e9.8.2026.04.12.14.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 14:16:22 -0700 (PDT)
Message-ID: <9a15c454-c904-4c16-8ba1-14352bd9b86d@linaro.org>
Date: Sun, 12 Apr 2026 23:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-4-jamin_lin@aspeedtech.com>
 <4253d673-02a9-45cd-9781-0f03866b9703@linaro.org>
 <6ae68fe4-6b54-433e-a9df-ae703a9c5f38@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6ae68fe4-6b54-433e-a9df-ae703a9c5f38@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/4/26 23:03, Cédric Le Goater wrote:
> On 4/12/26 22:34, Philippe Mathieu-Daudé wrote:
>> Hi Jamin,
>>
>> On 11/3/26 08:26, Jamin Lin wrote:
>>> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
>>>
>>> The following fields are updated:
>>> - EHCIPacket::qtdaddr
>>> - EHCIQueue::{qhaddr, qtdaddr}
>>> - EHCIState::{a_fetch_addr, p_fetch_addr}
>>>
>>> Update get_dwords() and put_dwords() to take 64-bit addresses and
>>> propagate the type change through the descriptor traversal paths.
>>>
>>> Adjust NLPTR_GET() to operate on 64-bit values:
>>>
>>>      #define NLPTR_GET(x) ((x) & ~(uint64_t)0x1f)
>>>
>>> so that link pointer masking works correctly when descriptor
>>> addresses exceed 32-bit space. The previous mask (0xffffffe0)
>>> implicitly truncated addresses to 32 bits.
>>>
>>> This patch does not change the on-wire descriptor layout yet.
>>> It only removes the internal 32-bit address limit and prepares
>>> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
>>>
>>> Since the type of fetch_addr changes from 32-bit to 64-bit,
>>> bump the VMState version.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>   hw/usb/hcd-ehci.h | 10 +++----
>>>   hw/usb/hcd-ehci.c | 67 +++++++++++++++++++++++++----------------------
>>>   2 files changed, 41 insertions(+), 36 deletions(-)
>>
>>
>>> @@ -2484,8 +2489,8 @@ static void usb_ehci_vm_state_change(void 
>>> *opaque, bool running, RunState state)
>>>   const VMStateDescription vmstate_ehci = {
>>>       .name        = "ehci-core",
>>> -    .version_id  = 2,
>>> -    .minimum_version_id  = 1,
>>> +    .version_id  = 3,
>>> +    .minimum_version_id  = 2,
>>
>> Since this device is used in cloud virtualized instances, we can not
>> ignore previous migration streams and really need to implement the v2
>> to v3 hook.
> 
> We will need :
> 
> +    uint32_t a_fetch_addr_hi;
> +    uint32_t p_fetch_addr_hi;
> 
> to be set by pre_save, and used by post_load to reconstruct
> 64-bit addresses. This is going to be tedious ...

Would something in those lines work?

-- >8 --
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 57f930b0998..c228d4a8c6d 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2439,6 +2439,10 @@ static int usb_ehci_post_load(void *opaque, int 
version_id)
              companion->dev = NULL;
          }
      }
+    if (version_id < 3) {
+        s->a_fetch_addr = s->a_fetch_addr_pre_v3;
+        s->p_fetch_addr = s->p_fetch_addr_pre_v3;
+    }

      return 0;
  }
@@ -2471,7 +2475,7 @@ static void usb_ehci_vm_state_change(void *opaque, 
bool running, RunState state)

  const VMStateDescription vmstate_ehci = {
      .name        = "ehci-core",
-    .version_id  = 2,
+    .version_id  = 3,
      .minimum_version_id  = 1,
      .pre_save    = usb_ehci_pre_save,
      .post_load   = usb_ehci_post_load,
@@ -2500,8 +2504,10 @@ const VMStateDescription vmstate_ehci = {
          /* schedule state */
          VMSTATE_UINT32(astate, EHCIState),
          VMSTATE_UINT32(pstate, EHCIState),
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),
+        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState, 2),
+        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState, 2),
+        VMSTATE_UINT64(a_fetch_addr, EHCIState),
+        VMSTATE_UINT64(p_fetch_addr, EHCIState),
          VMSTATE_END_OF_LIST()
      }
  };
---


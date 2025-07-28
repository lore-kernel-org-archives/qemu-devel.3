Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738ADC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7V-0000vT-Az; Mon, 28 Jul 2025 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugO7O-0008Hp-66
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:42:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugO7J-0004RK-L2
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:42:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso45212305e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753710131; x=1754314931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qAr6A66B9NH/9pV4SaEsrVvi6dNZp+eTeUeWyJpPMtw=;
 b=eC4TMvmqAug71kPJtxp8bvWi3Gc13oBglMovr+tyVKPVU7ENAraNDSN7oqYILGuFTw
 MvTu9LXqPq2Exk3c9oKRg1wPeIxENGvththElv8z9URxsTCsya7daWmULcoKlXFWMXpC
 SUCeO6ALHnQKGctlG7onuWbqXOsVHsvgIxzdgxS+O96V15SqF5aDlIQg3KINn3WW94h7
 I0EK4FEGw7wY6fYMobqlX15SnlBs7YWXVShccrCs5u66mUUimQZqwLyNONOtid7lpt5L
 NeYZ6GVMaqW6CDL1Rv1VsvuWaz1CIw+7TLTG8dW3O8lCcXALR1kXw8Dyzw2yQ9U9PY2/
 YgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753710131; x=1754314931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qAr6A66B9NH/9pV4SaEsrVvi6dNZp+eTeUeWyJpPMtw=;
 b=kuMwuaVfsg/lpGaS+aJx9Udd9HDLKJ+nM3kRv4ourwWk+LZAyqDRZd6s9ThbYx+5UG
 Py3Kkjgke5mjAUuuuS2st8yDtqY68ljZMXEVmLmZrJ4BbFl5gucx/j2rdchh8BBLVwlj
 ihjuqHqvKlZ0H+dx61Yi2+lSas5siro4VgZX5KxA/wyIZOJ0LmtXg3qmKN59vu5wr4R/
 DlPCBW+qO0idufjcxpowirb2g/X4e1K5bvqPQomAs3JDO4/0wH2Z6sdiaWk0rBVkVpuk
 q1PDZNfyALOR+wnrwc7D83fe4j+qpuZ8rFFRhpOGC+KMUpqaqgnteCwNjjjITW82EmjU
 cZmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/rsgQo9q9zIR7P04k8CAd4CimiC5mIr09WmdO30ktbwbeFNMYRhLwDfQoBpY36KuW1yqozSNpzI0@nongnu.org
X-Gm-Message-State: AOJu0Yx2Sn+c1zD9bJlo0MTxv1UgkDKmjUL51Gg6HIGt2cuk9t0p5Yae
 7u5V+K4AhFpZq+4CiiYe562k8i0KCSef9dFdlpJWCSpyKTfjHvJpXamc07yJLNnQYNrf917ofmU
 HIPei
X-Gm-Gg: ASbGncukKfDGcgp15UNoVZwJAm6SEImlh/dA4vUIsLUVLeC60DPdortenvidCG0nJ4i
 xJOXxNfh6V+UFQHAR0pJ4OwirvrbbMTlsYKJ1l0XIvb6Lm/hw/9FTopRsoprhQ8G5KO1F5bF+1n
 dwBhCPJE4mjaUGDrjqUh+MBeh39ovmGOMu9TFjK1ho9R9OycG/4W47uXj2QZAQWc3f8NIPMBmre
 f9RdcO+SFwTHfAS2eUqpIBdmq7LbbbRjJjPsciQJpqoYyLhTsUI4pGeufJ3yrt28wJ4Q2TOtirI
 Z+P8zhkad7mXeENTXzDsm3r0zaLszROe8rt/mSDEnTW5TGyYW2ZR3CT2bso0VKnJT9E5k5UtWr6
 W6c4cwnX2GmO/ogyd9UssDhEJX1pwous1h7uNNdG4Q4FpdmYY2vHYrRobKiDG+SGWUg==
X-Google-Smtp-Source: AGHT+IHADTbJ26+/+qg7MQVR+QhWHt4IQmB96gPZcZTPDGVVx+0Bf5Q0QkM7Y6fnsPea4Ehh4hSW6w==
X-Received: by 2002:a05:600c:3ace:b0:456:1611:ce85 with SMTP id
 5b1f17b1804b1-45876549d0dmr90787115e9.21.1753710131078; 
 Mon, 28 Jul 2025 06:42:11 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586e7cccdfsm127607365e9.0.2025.07.28.06.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 06:42:10 -0700 (PDT)
Message-ID: <60ac6175-5bd8-4c41-8d78-2a54f838bd40@linaro.org>
Date: Mon, 28 Jul 2025 15:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? v2] pcie_sriov: Fix configuration and state
 synchronization
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Corentin BAYET <corentin.bayet@reversetactics.com>
References: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
 <0e122e2a-898f-46ca-b484-291b0091d928@linaro.org>
 <20250728061838-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728061838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 28/7/25 12:19, Michael S. Tsirkin wrote:
> On Mon, Jul 28, 2025 at 12:09:34PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Akihiko, Michael,
>>
>> On 27/7/25 08:50, Akihiko Odaki wrote:
>>> Fix issues in PCIe SR-IOV configuration register handling that caused
>>> inconsistent internal state due to improper write mask handling and
>>> incorrect migration behavior.
>>>
>>> Two main problems were identified:
>>>
>>> 1. VF Enable bit write mask handling:
>>>      pcie_sriov_config_write() incorrectly assumed that its val parameter
>>>      was already masked, causing it to ignore the actual write mask.
>>>      This led to the VF Enable bit being processed even when masked,
>>>      resulting in incorrect VF registration/unregistration. It is
>>>      identified as CVE-2025-54567.
>>>
>>> 2. Migration state inconsistency:
>>>      pcie_sriov_pf_post_load() unconditionally called register_vfs()
>>>      regardless of the VF Enable bit state, creating inconsistent
>>>      internal state when VFs should not be enabled. Additionally,
>>>      it failed to properly update the NumVFs write mask based on
>>>      the current configuration. It is identified as CVE-2025-54566.
>>>
>>> Root cause analysis revealed that both functions relied on incorrect
>>> special-case assumptions instead of properly reading and consuming
>>> the actual configuration values. This change introduces a unified
>>> consume_config() function that reads actual configuration values and
>>> synchronize the internal state without special-case assumptions.
>>>
>>> The solution only adds register read overhead in non-hot-path code
>>> while ensuring correct SR-IOV state management across configuration
>>> writes and migration scenarios.
>>>
>>> Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
>>> Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
>>> Fixes: CVE-2025-54566
>>> Fixes: CVE-2025-54567
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>> Changes in v2:
>>> - Changed to perform the VFEnable write mask update only when the bit is
>>>     cleared. It clarifies the intention is to prevent setting the bit
>>>     (i.e., the bit is currently cleared) when the NumVF holds an invalid
>>>     value. The code execution when the bit is set will be also a bit
>>>     shorter.
>>> - Added references to the relevant CVEs.
>>> - Link to v1: https://lore.kernel.org/qemu-devel/20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp
>>> ---
>>>    hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
>>>    1 file changed, 23 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>> index 3ad18744f4a8ed2b35144fafcdc8e7e00fec3672..8a4bf0d6f7c0c6e9ec30df2e9bc55967e48cf6c3 100644
>>> --- a/hw/pci/pcie_sriov.c
>>> +++ b/hw/pci/pcie_sriov.c
>>> @@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
>>>        pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
>>>    }
>>> +static void consume_config(PCIDevice *dev)
>>> +{
>>> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>>> +
>>> +    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
>>> +        register_vfs(dev);
>>> +    } else {
>>> +        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
>>> +        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
>>> +        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
>>> +
>>> +        unregister_vfs(dev);
>>> +
>>> +        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
>>> +            wmask_val |= PCI_SRIOV_CTRL_VFE;
>>> +        }
>>> +
>>> +        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
>>> +    }
>>> +}
>>> +
>>>    static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
>>>                                          uint16_t vf_dev_id, uint16_t init_vfs,
>>>                                          uint16_t total_vfs, uint16_t vf_offset,
>>> @@ -416,30 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>>        trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
>>>                                 PCI_FUNC(dev->devfn), off, val, len);
>>> -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>>> -        if (val & PCI_SRIOV_CTRL_VFE) {
>>> -            register_vfs(dev);
>>> -        } else {
>>> -            unregister_vfs(dev);
>>> -        }
>>> -    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
>>> -        uint8_t *cfg = dev->config + sriov_cap;
>>> -        uint8_t *wmask = dev->wmask + sriov_cap;
>>> -        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
>>> -        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
>>> -
>>> -        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
>>> -            wmask_val |= PCI_SRIOV_CTRL_VFE;
>>> -        }
>>> -
>>> -        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
>>> -    }
>>> +    consume_config(dev);
>>
>> As usual, this would be simpler to review extracting consume_config() in
>> a preliminary patch, then the real fix.

Splitting in 2 would be smth like:

-- >8 --
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3ad18744f4a..f9a646bc08d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -64,6 +64,30 @@ static void unregister_vfs(PCIDevice *dev)
      pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 
0xffff);
  }

+static void consume_config(PCIDevice *dev, uint32_t off,
+                           uint32_t val, int len)
+{
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
+        if (val & PCI_SRIOV_CTRL_VFE) {
+            register_vfs(dev);
+        } else {
+            unregister_vfs(dev);
+        }
+    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
+        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+            wmask_val |= PCI_SRIOV_CTRL_VFE;
+        }
+
+        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
+    }
+}
+
  static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
                                        uint16_t vf_dev_id, uint16_t 
init_vfs,
                                        uint16_t total_vfs, uint16_t 
vf_offset,
@@ -416,24 +440,7 @@ void pcie_sriov_config_write(PCIDevice *dev, 
uint32_t address,
      trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
                               PCI_FUNC(dev->devfn), off, val, len);

-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            register_vfs(dev);
-        } else {
-            unregister_vfs(dev);
-        }
-    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
-        uint8_t *cfg = dev->config + sriov_cap;
-        uint8_t *wmask = dev->wmask + sriov_cap;
-        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
-        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
-
-        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
-            wmask_val |= PCI_SRIOV_CTRL_VFE;
-        }
-
-        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
-    }
+    consume_config(dev, off, val, len);
  }

  void pcie_sriov_pf_post_load(PCIDevice *dev)
---

and:

-- >8 --
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f9a646bc08d..8a4bf0d6f7c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -64,22 +64,19 @@ static void unregister_vfs(PCIDevice *dev)
      pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 
0xffff);
  }

-static void consume_config(PCIDevice *dev, uint32_t off,
-                           uint32_t val, int len)
+static void consume_config(PCIDevice *dev)
  {
      uint8_t *cfg = dev->config + dev->exp.sriov_cap;

-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            register_vfs(dev);
-        } else {
-            unregister_vfs(dev);
-        }
-    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
+        register_vfs(dev);
+    } else {
          uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
          uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
          uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;

+        unregister_vfs(dev);
+
          if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
              wmask_val |= PCI_SRIOV_CTRL_VFE;
          }
@@ -440,13 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, 
uint32_t address,
      trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
                               PCI_FUNC(dev->devfn), off, val, len);

-    consume_config(dev, off, val, len);
+    consume_config(dev);
  }

  void pcie_sriov_pf_post_load(PCIDevice *dev)
  {
      if (dev->exp.sriov_cap) {
-        register_vfs(dev);
+        consume_config(dev);
      }
  }

---

Altough the change in pcie_sriov_pf_post_load() could
even be a third patch IMO.

>>
>>>    }
>>>    void pcie_sriov_pf_post_load(PCIDevice *dev)
>>>    {
>>>        if (dev->exp.sriov_cap) {
>>> -        register_vfs(dev);
>>> +        consume_config(dev);
>>>        }
>>>    }
>>
>> Michael, do we want this for the 10.1 release?
>>
>> Regards,
>>
>> Phil.
> 
> Think so, I'm testing a pull with this included.
> 



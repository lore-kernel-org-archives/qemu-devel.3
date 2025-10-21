Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EDFCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEtY-0002Er-Dp; Tue, 21 Oct 2025 12:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBEtL-0002Dp-D4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:07:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBEtF-0000lx-K2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:07:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710683a644so411105e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062831; x=1761667631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S3XDryUWMlktinWjMVeX9cwrrbFOe+BNaPX4vRirTnI=;
 b=R6MPA52R4Wa8BRoOSRw/ZMxhflT9oZ+/Hz0aodFyirjs8z2W/xc/PAACzqJTFRkfXn
 xpKalz+nHZcbgh+mQROSpnjgyEEivJ8GGZpYhGsT/7Z0Ko7GwYcm9LV16cSw3DepmfU/
 wUo5VPcy+qnxzJWfEYlBmwZZGp+dDoCJJzo37NXDh0fce+5kgYHHl1u658P4aY+3CGb2
 q1O2yZwWqO1A6xqR6k8Z3q3EVGedA/FkwYY6T/xPVK59xA8WZpY85WSMiRvLwTC32U6D
 4Yso/4m7x7Avb8LYQ8hp8q8NlRSJ7huqagvdtomIDKf1bBo74EzU9FvTmAJJDaaZ7WCj
 fV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062831; x=1761667631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3XDryUWMlktinWjMVeX9cwrrbFOe+BNaPX4vRirTnI=;
 b=jkMYlyzDZ+CQGHKYXNK0k8O1QGUYW0SSlQYkzHSc17mnBY/Dn8q+LAhKScg5WhWiqO
 braR2lAYlbXmcMCUNQP++2bXJjlmCd/qO7NPwZVmrvDxg9LEkbevrSgr45gPkpENS1ON
 QHgEReFYE1IqoUNomKmjEg5e+SXJvplaOTS9G0gzrU8yao9l4PdQBir2+lPa+WteHir2
 VEOuLE/4tzrPFHPY9MpFe0gSE8AcSCBYWkgAn+juJHoZcVBLYCP/eU4UXjxmphKoZczO
 LbYM7eTDBZZZUDQdkYRWDhQSOnnAzyqDhG1uXItCSyZEnxkViFUN9ucquOf3MW8SG5C+
 p5XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNqpdXlO3hh4D+7QL5JFEQVq2I0+dPTM0gEKrpof1mVMfNKZtPPVGT19e4vIwMmrvZrqO9uvpbTYT1@nongnu.org
X-Gm-Message-State: AOJu0YwNjX9QhgG9/TKMgXkCW4vnc0UL6lQS204TExKQvHl5U7JSDguY
 iB1+fI8RjxYBHQhGSXIwLVxPdbeLf6Q69AdCCV5SPjOJ+Kd7zTCpaXZAfRZuf45JZT0=
X-Gm-Gg: ASbGncsDt5vZ7WWc6js8tqUOGrSh+ePtqLvnOErrSIAHzQmSxh9RtgkTC41nNT/6+FW
 tyOM9pYEx1Y7gv7QYRhHOXdp8wRyAhA69WExeUTgeOSZOgr2WSN31EOgjNR/5R6Gma7omcmVa/2
 JoKJVD4Hml927pll/PYtd5PIlYkwleBRW/40zt6a0/CNQ81OC7J3uzGJr6+DgVz1rntiljlQlHQ
 vImISHMh2cZAykR8OhLbzUkqaVqhd2qEdC3YaLPEAH79om3xBVCf/NS3CfECq+P0Ugo78/FUFgD
 TW5yPyxGo43gy6x85cPf20Wqpnsn1ILGhjQEInY5+cva/oPfy0GIAxEtdiEM0JCP6fFKuS2fCJX
 +q1YMxV9msFojIkv+jzIVyZBve64kc4imxO3f4lfNs2TR5/QNbBSAV0qEINmLrwzgBkwJQULmRj
 2n+NYUFCHXBE2cCJEf5hjb4clVzaVxvJ3nMl3kssqXrx10GClTzklCTg==
X-Google-Smtp-Source: AGHT+IFTSxHOXBG2kQtyhLaqbkDJvdPVxrFwI3mIms/IDe5YKtq/OkNzeBFJx+Xy+94fCe8ah5JL/w==
X-Received: by 2002:a05:600c:4593:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-475c3f96e87mr1589135e9.1.1761062830808; 
 Tue, 21 Oct 2025 09:07:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b22536sm20411435e9.5.2025.10.21.09.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:07:10 -0700 (PDT)
Message-ID: <0e7af78a-6156-437a-b76d-8453898a5b57@linaro.org>
Date: Tue, 21 Oct 2025 18:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Cleanup patches, mostly PC-related
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/10/25 23:02, Bernhard Beschow wrote:

> Bernhard Beschow (10):
>    hw/timer/i8254: Add I/O trace events
>    hw/audio/pcspk: Add I/O trace events
>    hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into trace events
>    hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
>    hw/rtc/mc146818rtc: Assert correct usage of
>      mc146818rtc_set_cmos_data()
>    hw/ide/ide-internal: Move dma_buf_commit() into ide "namespace"
>    hw/i386/apic: Prefer APICCommonState over DeviceState
>    hw/i386/apic: Ensure own APIC use in apic_msr_{read,write}
>    hw/intc/apic: Pass APICCommonState to apic_register_{read,write}
>    tests/qtest/ds1338-test: Reuse from_bcd()

Thanks, except if Paolo/MST/Igor object, series queued squashing:

-- >8 --
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67ff52a8b40..d981ca05977 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -29,2 +29,3 @@
  #include "exec/memop.h"
+#include "hw/i386/apic.h"
  #include "hw/i386/topology.h"
@@ -2352,3 +2352,3 @@ struct ArchCPU {
         user */
-    struct APICCommonState *apic_state;
+    APICCommonState *apic_state;
      struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
diff --git a/target/i386/whpx/whpx-internal.h 
b/target/i386/whpx/whpx-internal.h
index 066e16bd8e2..2dcad1f5650 100644
--- a/target/i386/whpx/whpx-internal.h
+++ b/target/i386/whpx/whpx-internal.h
@@ -7,2 +7,4 @@

+#include "hw/i386/apic.h"
+
  typedef enum WhpxBreakpointState {
@@ -46,3 +48,3 @@ struct whpx_state {
  extern struct whpx_state whpx_global;
-void whpx_apic_get(struct APICCommonState *s);
+void whpx_apic_get(APICCommonState *s);

---


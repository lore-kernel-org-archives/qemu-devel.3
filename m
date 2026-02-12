Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7590EEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvI-0005m6-24; Thu, 12 Feb 2026 09:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuv-0005NZ-Qi
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuK-0005vT-Jd
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LElDCxwRu1qNcefbJG6vySFgKgBL5nkXOno2oLRLUTc=;
 b=iP0v5Q/GcUPaTUt59w+6WYOiqPnMTtsGNxLI5bnM/wNX+pxG8JPMukwZbmzlTsabVoKXUG
 +rm6FnD8RNBhY00x0K2MtXaq7/uPIbVhD6neU6+OxfnQ3oWT7dUD0T9vH1kxCMkjUHAR4K
 Sbdw4ReDdc+77e9NfU1nom9sVVayjUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-9UzUnUHFNO6Tq6698MNMAQ-1; Thu, 12 Feb 2026 09:43:02 -0500
X-MC-Unique: 9UzUnUHFNO6Tq6698MNMAQ-1
X-Mimecast-MFC-AGG-ID: 9UzUnUHFNO6Tq6698MNMAQ_1770907381
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806fa4a180so60039125e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907380; x=1771512180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LElDCxwRu1qNcefbJG6vySFgKgBL5nkXOno2oLRLUTc=;
 b=gzZK8+NOhsSvQ05WzZGcYOXL/dXCii0DlLDRVXZFEco1YfclNaxJlSnV0v2Ujb7NBm
 UPl/0laV3T109cXxjXe7G5O2fv4DaDsUxTgAKcgA8MzhWB8l9Ap81VW/DeUoxj5zZYq0
 bhG+1/nGeWPJ4hjAahgnMemQkhb8bukvcG3KUjfPKZUres9kFOF1Xl7htDfQYj0qAPTl
 PDdUzXG85o9EYlQ6NyrAYyCnLP/LSmvkdfWqi/tZfIU/yHEwiIUNq89RDNTmLx9BrqQJ
 9TF+PB12VKVf9/g+RJ0Mw+aD9Z/5o0eOLEToSc0ek8uiEGUnt29UGL8OAu/5+ceTBWVZ
 xrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907380; x=1771512180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LElDCxwRu1qNcefbJG6vySFgKgBL5nkXOno2oLRLUTc=;
 b=Oqqf6VNXUlZ6YO20zAe9zgvjmdSMAGLlGf96Laba6ewP3nrq/sJp4QgzMZLN1LxXUl
 gR2YB9X24o9vzhShDJUwv1ui06Bdkphf2Op8fT2LHtbxTkbZEDaOJ94kqTX3l2e8+pQ3
 V/tLWSSXJt7WWyb+Q0/z+expZWjWMEwxOQ140MxdVV25CgQisi/0xvlk+W1SW5ARezHB
 FSYCXEhNSMinaejBzIWUTPBYjDZVNlobmZs1sqD2DO/HSaDNcmqrwszxUjS3UNEYCgnR
 FCLg3/ZksUdm8Hd+MPcha2gITCQiOE+Konth4WAf2IoWRV7nqpXKbOoEf5pE0nnaUx8j
 r0SQ==
X-Gm-Message-State: AOJu0YzOD5j0it/Gole+hKMsssIABV2uDNd7jCx17yJBYmPa/D5Dc5uh
 VYfKl/qzkiQ7ukewcMmWYHxpGDjLQC+Y3ZOJ43Y9QV6EROzmKxu14jI/TISBZq9IH+av9j5+UON
 WkFvrDh3ilYnwcJIoMGG5c6H0npPHCxHZZ+7aN3q1Cq1PHXE2sBrRMBbUzonMVC61doP3cCQhBa
 m0rfPKGerKhaky9ATKlSbF8dPEuLul5FliP2etFvZO
X-Gm-Gg: AZuq6aJVqdrxdg4fmFvZNWc8AD9JudaFcT/hHb5/M10gwk6OoVQ86uc+hh0noTZ3ZMa
 fJrUh48ssK4JFVwAj067ZOtMeFigc6K3saFHcYnLAlqd/MtQWsCGupIrTGJkvB6fXwiltXzbHHG
 +1JHLoiTT7pydcY10NhmTMCj+nD5EeCt1YOIQ6zL9sC4/BBtLh/kwD9dWoz7fRlV68ARdqcQFyo
 KrjcaFltkjPXfifvuaah2eeFDwX2petirsW4n1TbLJ6Xuc2cLot/QuUl0EI86rca4ptYszyDWgV
 y9wMZt1tFBjJk9lDMYhfJqnL9UXBAvS9dql6KiE9rYdxLT24yeEVxRmlm76IPOYgzTRHPYRt/X6
 /4yvdAbIBoLLRUBw5xyf12vSxcpzqz9kg3d4S+KqU24qIqfN9Fh/CMw6AmVN1Ic+kjf/LrrYYLc
 LjvaTZNdViu0EWSP0QM7vrE+DiKyDedGzTkxOWgYd0rqw0dqlJsNE=
X-Received: by 2002:a05:600c:848d:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-483657166aemr44927685e9.25.1770907379903; 
 Thu, 12 Feb 2026 06:42:59 -0800 (PST)
X-Received: by 2002:a05:600c:848d:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-483657166aemr44927195e9.25.1770907379248; 
 Thu, 12 Feb 2026 06:42:59 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a6137d3sm74497685e9.1.2026.02.12.06.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 07/41] docs/specs/acpi_cpu_hotplug: Remove legacy cpu hotplug
 descriptions
Date: Thu, 12 Feb 2026 15:42:09 +0100
Message-ID: <20260212144244.22579-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Legacy cpu hotplug has been removed totally and machines start with
modern cpu hotplug interface directly.

Therefore, update the documentation to describe current QEMU cpu hotplug
logic.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.rst | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.rst b/docs/specs/acpi_cpu_hotplug.rst
index 351057c9676..f4967810004 100644
--- a/docs/specs/acpi_cpu_hotplug.rst
+++ b/docs/specs/acpi_cpu_hotplug.rst
@@ -8,22 +8,6 @@ ACPI BIOS GPE.2 handler is dedicated for notifying OS about CPU hot-add
 and hot-remove events.
 
 
-Legacy ACPI CPU hotplug interface registers
--------------------------------------------
-
-CPU present bitmap for:
-
-- ICH9-LPC (IO port 0x0cd8-0xcf7, 1-byte access)
-- PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
-- One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
-- The first DWORD in bitmap is used in write mode to switch from legacy
-  to modern CPU hotplug interface, write 0 into it to do switch.
-
-QEMU sets corresponding CPU bit on hot-add event and issues SCI
-with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
-to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
-
-
 Modern ACPI CPU hotplug interface registers
 -------------------------------------------
 
@@ -189,20 +173,14 @@ Typical usecases
 (x86) Detecting and enabling modern CPU hotplug interface
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-QEMU starts with legacy CPU hotplug interface enabled. Detecting and
-switching to modern interface is based on the 2 legacy CPU hotplug features:
+QEMU starts with modern CPU hotplug interface enabled. Use following steps to
+detect modern CPU hotplug interface:
 
-#. Writes into CPU bitmap are ignored.
-#. CPU bitmap always has bit #0 set, corresponding to boot CPU.
-
-Use following steps to detect and enable modern CPU hotplug interface:
-
-#. Store 0x0 to the 'CPU selector' register, attempting to switch to modern mode
 #. Store 0x0 to the 'CPU selector' register, to ensure valid selector value
 #. Store 0x0 to the 'Command field' register
 #. Read the 'Command data 2' register.
    If read value is 0x0, the modern interface is enabled.
-   Otherwise legacy or no CPU hotplug interface available
+   Otherwise no CPU hotplug interface available
 
 Get a cpu with pending event
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.52.0



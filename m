Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE8DC54E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 01:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIGz7-0003ge-L2; Thu, 22 May 2025 21:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uIGz6-0003gP-L2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 21:14:04 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uIGz4-0001tt-Q5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 21:14:04 -0400
Received: by mail-ua1-x944.google.com with SMTP id
 a1e0cc1a2514c-87c0633a093so1444001241.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747962841; x=1748567641; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCEPHijVWh21bdlDld6lQdhgKqvpabRR/RC4fMVNV6I=;
 b=ZHzWRR4IqOA2IycDwAaUDmF+zuFCjsyHEGrvmBgYpzT0TOEnsuzEbJLoOqN2R/tf/3
 l/er/lSlCUWHaSEky7AqSj9eNmMNJf8z4rw1Gl+LaK2y/dhblqFiT5nxkGr4YuvznrM9
 ZuwngEQJemc8b6mV4ajwp2cSWkKVRhP6CHcKfb+kb9LU0TCyTNAO3gOthDQC/bVGd2e7
 lOXtHBeMoi9Rm0DBHujZffhbuJfYKQBYu8BaXaIrERb0MeXI1GBL2J2q0uncXRLdPCeW
 /W3NrxWJFhAiaAERaBwKZCUCwlHQdcAAEgDy/2xWel6qxLP64OkqTFEAqbdv0SgzD2uq
 F8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747962841; x=1748567641;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gCEPHijVWh21bdlDld6lQdhgKqvpabRR/RC4fMVNV6I=;
 b=FC+OSpTke/SLF2fsfYdN9Ni7zTFoPWmDMfLdSkWbSQFmXYgLP7IpCmk75CySRGSPzg
 udRtsnkp0M9kKQxCRI3/jwtX3EbbKdEIlv62EsrlbdOJZNlRTbQLOPafvde2Fz6wpjgH
 qwuDTuMNFWvwXs+Ts8nsA9v/jA1Dee60PD2CJNpln5hcVdlpt5AH21Gr9ev/zDsbN8QW
 N5VZnQO1/HZ3aQk/PznIQBVvWTliIlQ2Nq0O/HkxcERbikRMUS2veHGJ1u/ol7RkmTyA
 HxcXmuvNNeSd55fEpQD0ILpLzRqq5SVtwNHIkiFOWRTiL6OFWVTDBjpj3/9ifgZh/gXr
 w65Q==
X-Gm-Message-State: AOJu0YxRD6P6Xeabn8Pb5N9UBr0W2AQlv7uGlx3alcaZlMrIrufJkcg5
 7y1EGfeKScsWGy65O98iSNOxqaRBNHGIQIcW1p7rcZ0agG5ZN/sKI2rP3+dSRnHD5a0=
X-Gm-Gg: ASbGncvBTIPox/BmOwfAcO0deZ0exTAzf5GDL9par/WDwMMr+9FMS5vrwDjtkEIkV3q
 V4RDZhXLEwK7SnrGEgBbt/NMSIW8LPufdRwIxgXW6o0g8np0AXMit9lG9WYh69DZAiULuf+5EQP
 24M+q7yFBAov8PtCEKr0fbEd24Zp0/dMdkMGMvPbOU55TlSt3azDYIU7a23QHiDlNs4vX0U7I+m
 bakzUYmytYSdoMqiumO3PVpExTlndkLKRF92L3xanTaBFuJRggR0PYBLNoYQynR1A9Hu0OEJ/qC
 HDin425darm9eGR/an4KGxRD0o15BM2piiwxt6ezrjjOE/KZRzM4x8BRU7m7GY+uaOwvD/UeJtd
 2xlZ8yfQYqyQ/J/9ZcfLq/jXmrinZDW9Q4OcMZxQV
X-Google-Smtp-Source: AGHT+IGGijAvz7VnHBOKNCAhoV3jzSOqNpyQahifYB0fNaOmOLyCEsjvs19+dsIoiPfvscpmbJZ2DA==
X-Received: by 2002:a05:6102:370a:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-4dfa6bbb263mr25240750137.13.1747962840802; 
 Thu, 22 May 2025 18:14:00 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:59c4:f305:3d77:f678?
 ([2804:7f0:b402:6ba2:59c4:f305:3d77:f678])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4dfa66bcf1bsm11842587137.10.2025.05.22.18.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 18:14:00 -0700 (PDT)
Message-ID: <e376b3f5-81e9-4b67-ba8c-048ca713d894@linaro.org>
Date: Thu, 22 May 2025 22:13:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: New test in bios-tables-test.c for the ACPI PCI hotplug on ARM series
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::944;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x944.google.com
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

Hi Eric,

While we go through the ACPI PCI Hotplug series [0] and review it, I'm
starting to take a look at tests/qtest/bios-tables-test.c.

You mentioned testing the combinations of "acpi-root-pci-hotplug"
and "acpi-pci-hotplug-with-bridge-support" flags [1], but taking a
look now I see that "acpi-root-pci-hotplug" is only used in a PCI
context (not in PCIE, so not meaningful in GPEX), hence
"acpi-pci-hotplug-with-bridge-support" would be the interesting
flag for testing the ACPI PCI HP series for ARM. Since this maps to
'use_acpi_hotplug_bridge' variable in i386 (e.g., in ICH9 controller)
and this variable is being controlled by machine flag "acpi_pcihp"
in the series, I understand it's only a matter of testing the ACPI for
acpi_pcihp=off and acpi_pcihp=on. What do you think?


Cheers,
Gustavo

[0] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg03487.html
[1] https://lists.nongnu.org/archive/html/qemu-trivial/2025-05/msg00020.html


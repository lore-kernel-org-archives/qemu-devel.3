Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890C6C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaW0-0002WJ-Hz; Mon, 10 Feb 2025 15:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaVy-0002Va-0Z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:36:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaVw-0002g4-FS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:36:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so1119375f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739219779; x=1739824579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGChCU3t2Mkh0Jqvlmq9bmLybhyJ/cFPxzjuCEBJ6pQ=;
 b=PkAD9sQL+ztpl3FQkbBi0AGz2sVmpAiU9G0D6RGnb9PZjgvvZR7zfhkL2GgEie3a7Q
 6ftB5cTg/4B0BvzKtHiNfDnNDIo8FYoe+//0XTexuCSutzUdZMLPm9d9HMdwsA3o4Fyw
 pN9MF2QSQyYsVKoyjouHBLy8YQMByMPOh9TP8CxaNsQ2Jn1EhIu1CX4GYSDBDax3YOkl
 iJmn+CL1qiwhhK+LlBwj/25I4y5vycN4vz71rzQSTIxPYW0hW0OJLJx3SxWDChVZOrLv
 M5Twxk10E7B8nYCfON3eZd4/A2RBn7qBR+JCOye5i4FKosxPO4VBox5ni4eFZPhlse3r
 4dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219779; x=1739824579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGChCU3t2Mkh0Jqvlmq9bmLybhyJ/cFPxzjuCEBJ6pQ=;
 b=GSF9CeZe1atanRsheH4nMLTdrr3GMhmLQrBDCaVfgPoxBckoieQivXmhM55E7Veo2o
 Wg1Ulw7pBBpWrwPN4k18jsNZ/iufGikmcJbUYSBBWd7hzCIgLme3oTEeXd48E7REJbjh
 9lA4l8i6/00bdPTv7/BRrMLZC5Zkojverw23q4KKc1IQJHbgenvevyTV1zgX9xIQN7Lo
 4h1zWdPE1PZhTMvRgFks+TdnJOUD2gRpbvbYuw0vZNAaTZNkiz5g9ENaX+8xP18b0NKx
 3qtS3U6wX+BnvaZILyzd429Ea5nW0lsEqlETEF0xtps5zbRmQm1n1EOf2q7OZLJWKh0V
 mFRA==
X-Gm-Message-State: AOJu0YxDUhSNFjve6jAMg6mtCTH+SX5m/fLudIIr5LrNsckXL981/CHU
 RGADv7B4Z8NvBWBtxgnOL1e8Wu05zj5XUkhkX2tAF0M/WrMdX1BVEyV+eddQQOhbHY0hj/fzn3H
 y7Wc=
X-Gm-Gg: ASbGncvX2Ru+feemuj8GQZ5JU6n9H9FRsANIZs+pi+BPivXr82KYlrnG792t28ML/Xf
 7zt6FytxnXC2kz9rYeY5sod3E9Whr/QFqpgk9EYQppkA1b+xcy8JHdVILalJe+GSWa7aaNGhwHk
 VgWxf0nCuyRzogl5IHHz2z2LlzmX+ZdZf13AXxQzDHautJuUTe2P0qZ5gX5HquFKT1wI+xgurKV
 m3SNEznOIeS4vd77cJBYYZEmoI3CXNn5IeN5KCxzO4X6cPS5JcO3NBswOpHVO4cxtGFghSbpacT
 2T67XDwKeFL0CkjBjFxPp2y+QkZvq1bMzMExT9EH/L4BPuPwC746mCInZus=
X-Google-Smtp-Source: AGHT+IH8Y7/jwTb9oyHjCS6NcjTgnOdfVMqyXGy2F/qEHOBj6nrFDVsufEMDTAXnMFHwuRcC9Kr3Xg==
X-Received: by 2002:a05:6000:1041:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38dc8dec2f6mr9585731f8f.33.1739219778547; 
 Mon, 10 Feb 2025 12:36:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf81f3aesm9417190f8f.51.2025.02.10.12.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 12:36:18 -0800 (PST)
Message-ID: <029f55b9-9ffc-46a1-bb4f-370119ee980d@linaro.org>
Date: Mon, 10 Feb 2025 21:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250125181343.59151-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 25/1/25 19:13, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (9):
>    hw/sysbus: Use sizeof(BusState) in main_system_bus_create()
>    hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
>    hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
>    hw/vfio: Have VFIO_PLATFORM devices inherit from
>      DYNAMIC_SYS_BUS_DEVICE
>    hw/display: Have RAMFB device inherit from DYNAMIC_SYS_BUS_DEVICE
>    hw/i386: Have X86_IOMMU devices inherit from DYNAMIC_SYS_BUS_DEVICE
>    hw/net: Have eTSEC device inherit from DYNAMIC_SYS_BUS_DEVICE
>    hw/tpm: Have TPM TIS sysbus device inherit from DYNAMIC_SYS_BUS_DEVICE
>    hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE

Series queued (including Bernhard's patch), thanks.


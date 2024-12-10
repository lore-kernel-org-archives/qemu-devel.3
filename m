Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4676AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5fz-0004X9-KM; Tue, 10 Dec 2024 14:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tL5fy-0004X0-En
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:13:42 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tL5fw-000192-HP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:13:42 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d896be3992so30803496d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1733858016; x=1734462816; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=97qOTYSoAyV6vd8Z2GN8GpBHNVjhg0i4wTdV+vq41wg=;
 b=WmVacD4MUJUYvYMSklSt4jrkd2PoKlgbxuubBY0nT0C3L/3infTBdTaFyemP/pCBPk
 xCJ64VlgtTamxh5JB9G9Ohfa61oj0oFwVPveoI+cStSUCDuXNvN0silzeT+lVkKll8/j
 IL6vAWCq1S4oMQVIP1OxD7XY/Yig8+aRrjaHSLmrPkhjHmZY+gzaGlTY0oxWJKnDCAGY
 kGnbiCjc4VFZwhpKPc+BniDVvadwAVpiWEQqRVvgJgItXFxD/kY5CveGxiRGYBCs/OVy
 tMG+rRxefsp1QHUed8my2OX0O85gyDaFm8BJRhdhm1aDYLv843mff9ZEo4QncJPkUCeR
 jWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733858016; x=1734462816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97qOTYSoAyV6vd8Z2GN8GpBHNVjhg0i4wTdV+vq41wg=;
 b=IwRTq2xCh2WbOu6Zrcr+lp0oUAxVrgm5MUFCJHw6JBafHJd8y/Z691HhOFHPORxwk9
 omgIp+lRuCm2kIfRkj6AFzlurZBWooC9sQjomx59DfYBYjVttM4n14fg9jVN9a1kAO0T
 na0e7b3Lspp+DcKKdeTXRU+y1Ukom/CF+GqDmh3F1S8dVU5SNfbCCgwn3BjDdhvtPkEz
 YayPq0bGjCT3MgdMzNuBlZjrJO0UK44fJQh+t3nOmDz+uUFKSj6Iyl9nHSshJyFXyQr2
 RGjWRgtZxrDbRAmRsH/Kz8KwdHeleyRiB1nhcQ8MOm4QgNtDFznfNL7s6EH5w4vopiIG
 xdEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj93rvS8zZ/9czZqGsaS+B3cW5GDGFuUzYwamspFAJCmrAFNGRIMWxRyxNDwLaTTtsO5C07A8UkJLL@nongnu.org
X-Gm-Message-State: AOJu0YyPBgCKUr46e7Q3sIMnoqvqCaBh0TfqQX9YffvhY2ODcOD7QD/0
 15jmtgkBMNBtpehZOWgzAVcAmL3nbVtoYHhF23sCvabCc4NxINeNOXUyzsGcNV4=
X-Gm-Gg: ASbGncsU3PIxKSNvHuc1tVNHeEWTNUbYshoxjpaP+Kfx2119mBbSFDQxkctAYqxQaUJ
 +YQlqgcHrXlBcI3PVwLDgjYtgHa4iJ2QjNZcmTe3/ybLGUpE3X2k4HRgOAQtRnqAhJ17m49TVYs
 /J9wDdCFUx/+nyiQCc4HDjKHgBaziJ34pu3HSXXzLCQTn5CF/LiZxEblm3WMzg2HvvH6W6gHhPo
 P8Hddt9Twbjh1ywmoGiO0R9csNI41FN30d4dgUsN25yQ2SkfHoR8zocdMpQe/S4xcPwgEr5GW4O
 M0sHmTBYxDaErmvKcHYa13lKhxnLuX3/OQky2yo=
X-Google-Smtp-Source: AGHT+IHRrfRfIZnKItsDYPM0ONQeei8VT2blcHwcAuFVhWCu+WYuv/fhCeiX5KBqdP0FaQ+PR8gyhg==
X-Received: by 2002:a05:6214:f09:b0:6d8:9124:878e with SMTP id
 6a1803df08f44-6d9348c984cmr2901076d6.4.1733858015734; 
 Tue, 10 Dec 2024 11:13:35 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8eb619443sm50877846d6.26.2024.12.10.11.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 11:13:35 -0800 (PST)
Date: Tue, 10 Dec 2024 14:13:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf32.google.com
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

On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> Hi Jonathan,
> 
> I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.

This should not be how this is done.

The ACPI tables should report the maximum possible size, and the DCD
infrastructure should enable physical regions that have been added to the host.

Changing ACPI tables to report 0 memory size will basically result
in the host memory map not reserving physical memory regions for that
device.

See this emulation example of an MHSLD - which can be used for DCD.

https://lore.kernel.org/linux-cxl/20241018161252.8896-1-gourry@gourry.net/

> Recently we got some interest on trying our fabric manager software without having the real hardware. Supporting zero memory size in QEMU will be needed in this scenario.
> Some detail about our memory appliance could be found from our OCP presentation: https://drive.google.com/file/d/1i8kBsBfRGjNqnTQqJ9upC-Xm9o56Y2Y5/view?usp=drive_link
> 
> Thanks,
> Hongjian Fan
> 
> 
> Seagate Internal


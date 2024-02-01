Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CEC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVc5s-0005BE-By; Thu, 01 Feb 2024 13:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rVc5q-0005AY-Ak; Thu, 01 Feb 2024 13:47:22 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rVc5m-0008Or-HD; Thu, 01 Feb 2024 13:47:22 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so1194546a12.1; 
 Thu, 01 Feb 2024 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706813235; x=1707418035; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=CCND+F7ftpzcNLSrPIRE4wlUV26l2UtFG7OTB1xxpUk=;
 b=cPG+FXLlbEChWqd8cX4z3bJNUA0Jzu9dYQJtWhPiteN/gQsIN1Nc5U223H8FvYc5Ck
 6lyL6Fu/zDSebnGCKZOFyjJkjuV0JBtsBwqXCMpucuWJRDAi8Od8/NY4W9pqjOa++PxR
 ryLg75Z69Sb1ltTdBxKDYSzWKibx5m20rQ6gI9xnNvPU620V4OHs6qoO5QKQmFMMFpA7
 URdoAbu3ghUepyee8ItXd5OxMhffac65VyaFRcXcoN9WOHtof+lHMfIPNVB+IMDXCmVH
 qwKtDJEdsH6oA4BysmIata8at8Ftov/MOgmAJzalSQr+rmkEXrkzSbrxhP1JSbfMPkD/
 WRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706813235; x=1707418035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCND+F7ftpzcNLSrPIRE4wlUV26l2UtFG7OTB1xxpUk=;
 b=SZM2VXOB2duAkxadBE5Xuaw85ddQjt3OzshoA/6JJAk6eo1YQTc1ZMfqTn3TX2rcs/
 S9HeFU4B8rpbL8FUZLLEetwiJ12IKukqbkswZ9wl9q7iAYA3MXf+1yux5fcymlGOKph1
 TUStAa5uWNSNKSxOmwENtwD3eCavX9LZp6Nim3qQfubRCt1nhPixk1pUg9DL1delIkK3
 1UTG8QExio4KZi6WQqJhX5DIiMWs1jpWRpJvLU+RiJQwxcj2SVD7xZbG+fW/Uuzr/P7u
 7+Nylz0uk5OEPngr20AmiThYtCrwpFXrV0DlzjUtUOePreWA7NrbGxV4u5nCcELUDIXi
 wGww==
X-Gm-Message-State: AOJu0Yy2c0qtr+XA8V7PvMxGKYN981O7wSA4Rny9Jr3aHwHFGuysQ2XF
 ZGwDs+4+oKatj2SjSUc1T2USrhXdRHLumNq43XxoLdabM/5wMnJrKbwmHVCJ
X-Google-Smtp-Source: AGHT+IFNS9IHVs1ddyoBDN/BH7hBIL1+BGrBHwmWvaZlxCc9WCgx2VRRx11PxGgZcISDAxB8fz/9BA==
X-Received: by 2002:a05:6a20:2d0d:b0:19e:3654:7d15 with SMTP id
 g13-20020a056a202d0d00b0019e36547d15mr7909021pzl.15.1706813235304; 
 Thu, 01 Feb 2024 10:47:15 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUJT0p2IbFBT13PoeUR2jZkKr0pD8eNdPjEkEcyhXQWiUWgExzcoMMkPlDVxb5OlEEkkYC/AJSkv5O9Bw7YmEqZ8AMKpYTSgFMtYLDflp84WtQ89eWB3gKFOzlzLVxfvHqS8bPZgSbz0cu8ZTa5unG3Aw==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a631b16000000b005cd835182c5sm146675pgb.79.2024.02.01.10.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 10:47:14 -0800 (PST)
Date: Thu, 1 Feb 2024 10:47:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: Re: [PATCH] pci-host: designware: Limit value range of iATU viewport
 register
Message-ID: <b8e4afce-bcc7-49d8-bc80-876bffdcc3c4@roeck-us.net>
References: <20240129060055.2616989-1-linux@roeck-us.net>
 <CAFEAcA-pOdoSdRPDc-cpKyoRq0s309zR_0osDaLJqcdy9iy+6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pOdoSdRPDc-cpKyoRq0s309zR_0osDaLJqcdy9iy+6w@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 01, 2024 at 02:58:40PM +0000, Peter Maydell wrote:
> On Mon, 29 Jan 2024 at 06:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > The latest version of qemu (v8.2.0-869-g7a1dc45af5) crashes when booting
> > the mcimx7d-sabre emulation with Linux v5.11 and later.
> >
> > qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.
> >
> > Problem is that the Designware PCIe emulation accepts the full value range
> > for the iATU Viewport Register. However, both hardware and emulation only
> > support four inbound and four outbound viewports.
> >
> > The Linux kernel determines the number of supported viewports by writing
> > 0xff into the viewport register and reading the value back. The expected
> > value when reading the register is the highest supported viewport index.
> 
> This behaviour by the kernel seems to me to be out of spec.
> Looking at the "i.MX6 6Dual/6Quad Applications Processor Referenc
> Manual IMXDQRM" it says about the PCIE_PL_iATUVR register field
> Region_Index: "Must not be set to a value greater than 3"
> (there being 4 regions in this case).
> Plus it says elsewhere that software "should" write all-0s to
> reserved fields, and bits [7:4] are reserved in this register.
> 

Yes, I have seen that, but apparently it works with real hardware.

> > Match that code by masking the supported viewport value range when the
> > register is written. With this change, the Linux kernel reports
> >
> > imx6q-pcie 33800000.pcie: iATU: unroll F, 4 ob, 4 ib, align 0K, limit 4G
> >
> > as expected and supported.
> 
> However given this is presumably what the hardware does in this
> case where the guest does something out of spec, and we definitely
> need to do something to avoid asserting, we should take this patch.
> 

Another option might be to define some flag to enable the behavior,
in case other designware based implementations handle it differently.

At the very least the code will have to be changed to handle
situations where the register is set to a value outside the valid
range. I have no idea, though, how that should or could be handled
differently, given that we don't really know how the underlying
designware IP handles it (such as: maybe it is a mask in the IP
configuration file, and the mask for i.MX is really 0x03, not 0x0f).

On a side note, I have not been able to actually instantiate
a PCIe device behind the root bridge. If anyone knows how to do that,
please let me know.

Thanks,
Guenter


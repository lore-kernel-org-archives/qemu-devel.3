Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22382C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 05:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUKL6-0008Oy-26; Mon, 29 Jan 2024 00:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rUKKt-0008OY-Ms; Mon, 29 Jan 2024 00:37:37 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rUKKr-0005YT-Gd; Mon, 29 Jan 2024 00:37:35 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ddb807e23bso908973b3a.0; 
 Sun, 28 Jan 2024 21:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706506651; x=1707111451; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=VermG5Cfc8w9LGkz5KR8XRJjuHmOTA/Dq8nZBQyLotA=;
 b=JJ7Af56+17bazm/Nb8gjScdSbdzwJKDxf4CVF2zkIOfN+cMjeewxkXSKmNK8wMMvx3
 2ZcFPv+mZEXlewtn8zRKlhKIH1ky0dMmNO1V3f++Bu0waD6XlZhYiG+aLJUWyP5x2CvZ
 jtKPVUrpalu1RmguPXKfk5V1Lm3l7gdURs2xHoPR95Z+8KvB2ZEYL2bHGBL1pnk5bfuY
 nhJCmt93NFcRWmHC2mZWZ0OwdYpjqGgEJGt8UGLzFkYm8OwfSZr69o3YXPyPDSITwvPN
 ifSR74Dz+oMx+YPZ/o2bysESAKwtNl/uXGD+2yZG10e8TuRQGJ55AwhY5deJYY3hfSEy
 Br5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706506651; x=1707111451;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VermG5Cfc8w9LGkz5KR8XRJjuHmOTA/Dq8nZBQyLotA=;
 b=jeOvQWBORZ8d5R4QPpXUaNWjKX6QhspZJX5QiW6ymFSysG/Wv0ZBeF8Mm/kvp5v566
 64oCYSx+GpuL/T9Zp4ez9eDRzH999FBizg6TesibuiZ8T8GFb0uaWFxoYwisCkzbG+8p
 /Tf0TCKBoOlERkVDDLkN78rlQQouit8YAJDDbYpQQ5ErlvnoETljxYa7JfE7IM947NV3
 vE70tsirDYg09o7gVGNZHiphMyAAB3LTf7Oou9y93hMgGSzMwdiXtOzQusgADtieW/A+
 zl/wJaS7ej4rJTMbakXgSD7/ZahCBZZ0dprlkulS5zLobqKc9uDubzdfTXVQpZsw5oxI
 PrVA==
X-Gm-Message-State: AOJu0YyCll4F8LbY4z7hdT7H5Oztk2EYhuhGlJe9AgugrqiHTgDgYWDG
 +Xp66R3H6KL8BDuiaqwDzvOGmdOUyq3p4XxOvXaX2yH83accLsS5VvwtBfGQ
X-Google-Smtp-Source: AGHT+IFb2zF6hFoKr5yFAEWVAaeSl+F5tivpIWlQyLSnpmzDNz17QcP83W7ZWwUspNTXADpaDQZz9g==
X-Received: by 2002:a05:6a00:9390:b0:6db:de9f:5f10 with SMTP id
 ka16-20020a056a00939000b006dbde9f5f10mr1708397pfb.15.1706506651048; 
 Sun, 28 Jan 2024 21:37:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b006d9a9727a8esm5133541pfb.178.2024.01.28.21.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 21:37:29 -0800 (PST)
Date: Sun, 28 Jan 2024 21:37:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2] hw/arm: add PCIe to Freescale i.MX6
Message-ID: <22f96da3-7fa6-4806-989b-400e12dfb1d7@roeck-us.net>
References: <20240108140325.1291-1-n.ostrenkov@gmail.com>
 <9ee6eee8-2135-48f3-99a3-d572699fa4f7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee6eee8-2135-48f3-99a3-d572699fa4f7@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Sat, Jan 27, 2024 at 11:11:58AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jan 08, 2024 at 02:03:25PM +0000, Nikita Ostrenkov wrote:
> > Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> > ---
> 
> This patch, with the "sabrelite" emulation and the Linux upstream kernel
> (v6.8-rc1, using imx_v6_v7_defconfig), results in:
> 
> qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.
> 
> with the backtrace below. Any idea what might be wrong ?
> 
Never mind. I found the problem. I'll send a patch.

Guenter


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCEEC79FBB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqBj-0006cD-5k; Mon, 05 Jan 2026 14:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vcqBi-0006by-0i
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:24:22 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vcqBg-0000WY-94
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:24:21 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so234648a34.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1767641058; x=1768245858; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjN3Gc2g7d7ovaaYp8rpxP8F2paLPZmhuEp8Nk8TBkY=;
 b=kXy1kikrGckpJ893QmffPpc2m+cVhWF0wsG+sga0WnmzhQB9Ifj5KNUpI8LUTYN0zX
 KigvImggUMNaV51DjJMmOi1B338YAjXsYOx7NTJuAm84p8BAs0dBSsv7wN2qIP7XseBo
 H6MGaca4+owVsyzQ1lzy34owq8c5CAbyrI1rQDqlWKWa2w2pFkhsP+oN50ortXniNsl6
 JDmURnduLGw+TfiAZJ1BEJ4I3u1VrlP41i2mZLChjNFC0uvSbr9pIgb02pXUdHHKQhfp
 JDrIB+flK++HRHs8Yq5vqpHPXmsWKD8B2svGjVvv6wYOMVx+vFaiuqRBI+rJuEOHQFS4
 3Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767641058; x=1768245858;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjN3Gc2g7d7ovaaYp8rpxP8F2paLPZmhuEp8Nk8TBkY=;
 b=iRPsjcwccgMGwCz57aEy3C5pG1tGj5Gdex0TQWi3ghy1QvQd17qP/792sZhdWsSa6m
 rBT9K8poBo/LeX2lLEkRO8eLDYiwWt1s+cCgcfTcQ+HdLuENJ47iYv6OzwUeq2N3SMSC
 1/5ohey86xkXPKOWQdse0Q5WZ5Nwn2BZqw2ZCNICSRVmru0/dlXmanCjRC0IPe7H03V+
 nF9xnupw60gUGwcFV7HbBSdqfOJrXlxaxInfxuDypvjYKc1yPHhPwHSuW+qgCN8Cj5pc
 xUerXnvzX5yNTqf0qStljGnG43T8h+i5XzE1AyxgeSd1XhV8GNHF2uVF6U+P4Fy9+d1E
 5SCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIIeMbjJ3rvtRKhWXplBxvWwx2LmXlzpt+xGKcvfYMgGi28N9M2jUVL6WLJJGsl5mhyLZLiIC6fAKC@nongnu.org
X-Gm-Message-State: AOJu0YwyoizwITc8KAQXBKSU92cWdYcDGEpaCMfwmIpBP05FCZtfGYRJ
 wAZduxOgZrcKgRNcEoYE23BbZM69uplMhm6T6+p+2HK9R8Ffq45nzypFdgr5y5Cmi6Q=
X-Gm-Gg: AY/fxX4OVzrXhiZ8R/7qC8U5in2tweMTlfST7vD/nMbcasnDj2laqFAA3VTXsrX/Bex
 R65HbW6NgKp03NBsogApxjrjWK24ZcuFBuIFAv4wG3HiJefMpQG80tIrAqfyBSAOj+InW2Xw0K9
 VaKrt97zxh6n877rsrV/anq0mfyRl8KvuJ3W8x9XGeka9JcL/46Rus9sy2ibbx851M/zR3P1d7Q
 hx0mwI+uqqrJlh17c8ZO/cQjfVrizpNq1xSAc7O99oTp3xslo+9rYGCdM1fHKINdqAfSes52SRv
 Xrvu39EoJHjWvCEXVHsaSq3b4srpJv3VSg6pV2YtWtnMFXHjoLZdcZsU6R0KiRnhkmTSO6+qMdi
 LKTTuObbl2g6y4ZycFVPYaPuUg2SYDVRju2qfqMxy0AvXlk28FRXxk5/6CmCU9my5bvZnJIvFGK
 3fv4B8YAGe4Sza8WiJQ7takDbU
X-Google-Smtp-Source: AGHT+IEalp7Jlu1MyO2rkIkewH5AqeUOfey4U6/cEnxYPHzpt290Xx/DvfRQuMbNLhOC6NozynyF+w==
X-Received: by 2002:a05:6830:441e:b0:7c5:2dbf:4a83 with SMTP id
 46e09a7af769-7ce4669d63bmr229750a34.2.1767641058359; 
 Mon, 05 Jan 2026 11:24:18 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5606:872d:d03c:aa7f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce45ffbfaesm448889a34.24.2026.01.05.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:24:17 -0800 (PST)
Date: Mon, 5 Jan 2026 13:24:12 -0600
From: Corey Minyard <corey@minyard.net>
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: "philmd@linaro.org" <philmd@linaro.org>,
 "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Message-ID: <aVwP3MZtoHoEa3p1@mail.minyard.net>
References: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=corey@minyard.net; helo=mail-ot1-x329.google.com
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 05, 2026 at 03:56:49PM +0000, Yunpeng Yang wrote:
> Hi Philippe,
> 
> Thank you for your comments.
> I've modified my patches according to your advice.
> 
> Kind regards,
> Yunpeng
> 
> 
> v1...v2:
> ---
> 1. `is_valid_netmask` is renamed to `is_ipv4_netmask_valid`, and is now
>    implemented using `ldl_be_p`, `clo32`, and `ctz32`. It still ensures
>    the netmask is not `0.0.0.0`.
>    I didn't find any related helper functions in `include/`.

I couldn't find anything, either.

> 2. Now the `IPMILan` structure has its own `VMStateDescription`. It's
>    linked to the parent `VMStateDescription` using `VMSTATE_STRUCT`.
> ---
> 

This looks good to me, I'll pull this in to my tree and pass it on.

-corey

> 
> Links:
> * version 1 patches:
>   https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg07505.html
> * comments from Philippe Mathieu-Daudé <philmd@linaro.org>:
>   https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg00117.html
> 
> 
> Yunpeng Yang (2):
>   hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config
> 
>  hw/ipmi/ipmi_bmc_sim.c      | 412 +++++++++++++++++++++++++++++++++++-
>  include/hw/ipmi/ipmi.h      |   1 +
>  qemu-options.hx             |  26 +++
>  tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++
>  4 files changed, 572 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.7
> 


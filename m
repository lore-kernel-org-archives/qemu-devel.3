Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733EED44D70
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gbl-0000J5-Lx; Wed, 06 Nov 2024 09:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gbb-0000H7-4g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:01:55 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gbW-0001mw-Ph
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:01:54 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72088a79f57so926191b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730901709; x=1731506509; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DfylZ2u7CLTrzYQk3nxIxDwvn7QFmpP3h99Mk7jB3l4=;
 b=hJYczFCbB3pmP/lg0fdwHHdYjBdM35e2clrYhNDMgLLGen4c2hBYcK3w1MQCpitJcc
 llDo0Uvh+gl8VWzFtwAYQrlyPk+YLhsKYJlciH7hKYFsybWiKjoIh8XvfZcN4tmq6uih
 HIzGLViTUSU+Qw7it3gZFg9U5zCvlyuKqDH1ZO6djXoeUG/XTtX7kgP093eX47FcIRRR
 i96pCU6IzQhm/0EihlD7w0WPjN76UWSr5vGd62u3IoFJRXBMytMs8p6RC7Qk8WRvQgs9
 am+WwOjGr6vMtci6zsxdF+CMqJ4df3yt3KEykbRr6MJYg5HTxdmd1cDr6tg9z3x1y+p+
 UKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901709; x=1731506509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfylZ2u7CLTrzYQk3nxIxDwvn7QFmpP3h99Mk7jB3l4=;
 b=ulOkFh2/laUIj6QOTM1mBfgpkoko/u9aVEW88BSHh+SQlielVjuzlfI2LK5K7mwBJE
 caetRrygBkVzG4amskiLkO2iTY3c+pxQmwH1hCEziinIdYB8Tng2RI44ALP4+NXXiViJ
 7g54PWliUWEd5lQrWQ+5HkWr8TYxIgmXlC6QMdLs54Pbe3QDpMY4E6HY46aQ/LJra99j
 KtR0VtYtcXqy5Bdg/6ivWZPycwmj22flynQd0m9CjpeW8ig96z6AbYp4zCu0ROmbutym
 xSMCn0Vr8/ruB4GtYukhUeCQVYb07Y4bxpiI6ZABrPfSEDRGxF8kZJHUA6bLVNYco6ih
 bFGQ==
X-Gm-Message-State: AOJu0Yxa9XVoKm7G0xdlY/eG+SPa7ym1z/EPEAxbSB66qKrEFXKR4ylO
 3MwbOxp5IX/SnsM/SZasgsb5tzksmRLnbWG0aSkfR566rt2ANcz5ABz8imgTN+/1E3qi/mTBdLV
 w
X-Google-Smtp-Source: AGHT+IHDALv+f9lS4DHgYh4599fYyLDrOdLjGriCzyJJSS5s/SjOPTgWWbCNl/iNAvPS85qizRiojA==
X-Received: by 2002:a05:6a21:33a4:b0:1cf:4bd8:3a02 with SMTP id
 adf61e73a8af0-1d9a83a63d1mr27338445637.3.1730901708479; 
 Wed, 06 Nov 2024 06:01:48 -0800 (PST)
Received: from localhost ([2405:9800:b660:1d69:184b:7485:e878:79c4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1ba033sm11621749b3a.34.2024.11.06.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:01:47 -0800 (PST)
Date: Wed, 6 Nov 2024 21:01:45 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 2/5] i386/hvf: Fix for UB in handling CPUID function 0xD
Message-ID: <Zyt2yWzbJirnxPOb@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
 <20241105155800.5461-3-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155800.5461-3-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=roman@roolebo.dev; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 04:57:57PM +0100, Phil Dennis-Jordan wrote:
> The handling for CPUID function 0xD (supported XSAVE features) was
> improved in a recent patch. Unfortunately, this appears to have
> introduced undefined behaviour for cases where ecx > 30, as the result
> of (1 << idx) is undefined if idx > 30.
> 
> Per Intel SDM section 13.2, the behaviour for ecx values up to and
> including 62 are specified. This change therefore specifically sets
> all registers returned by the CPUID instruction to 0 for 63 and higher.
> Furthermore, the bit shift uses uint64_t, where behaviour for the entire
> range of 2..62 is safe and correct.
> 

Thanks for correcting the regression.

Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>


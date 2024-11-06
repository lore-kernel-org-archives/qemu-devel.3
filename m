Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F1D44D46
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dWX-00060C-2t; Wed, 06 Nov 2024 05:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8dWU-0005yM-LM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:44:27 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8dWT-0005cD-Bu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:44:26 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e5f526645so491734b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730889863; x=1731494663; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jbAvDdLea5AHowiXZ5ynB5yPfioc4MAkOBmPUPzOqE0=;
 b=Zz0lPy5jXT+t7zsfE9EBsrsfXI8AVztFfhdJMsdJgEG17t2pUFRBaXh11Is2QCJLoi
 4cH67/vMgOnaAWYTSm2SxOKyHfCTP5Js8b/zqDh2GYJSZ8U0Qk3HiUK8aU6eronn76kH
 BEXmen1lNBZ1+QIGZF5CEASJsmjJpeX99t3069qK0Y3tOfux6drp6reR1bWmn4fVfM3O
 7icekUGUWapfJLQ8F46CLWMkJDa6xupF7Y9DbCei2HLuM5V6HD3d538sD+suEdWXFln9
 7jAoHaTtU2bwfmynmPftYOmchmY/GRI2T41IPUL181KI2KTL5bkALHlqfdYz7FInajUX
 kglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889863; x=1731494663;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbAvDdLea5AHowiXZ5ynB5yPfioc4MAkOBmPUPzOqE0=;
 b=BSt8sFqHxWmBY1mC2ULqVn4fiGD1cyeUL/85mdPxigzcJdi0QgYqNUg5IDYtPqpEQQ
 TtcySKm8Q/GSLtn0AkIRHrzxVwUl4KN5CvpX7i4DiI9pDyZd35cdEvr7vEi0CSwg4YeB
 O4xa0P3whqltAPwQK26xZJHgsM9DRNFGxqGJjdEd0ZEby2H1KVnae9SjlrD3WNfF+1xN
 izDJwu/ByL/to9ZCsGL1B25Fm85l6fcW1OrpXOMGwwuQ8TI8TDeXHrsY59/dQDFfSSbn
 VNfxNC3DkkmiytS/mZKu7YZwc7jZz5Vt9Jz4oB/YfhH/EjnziA8CRXPxnlquWbqda6MJ
 zlxQ==
X-Gm-Message-State: AOJu0YwE154ZP2Du16RpFKiILpvV3hBcv5aOxo/bIkDAEZwLtXms2Flu
 PvC6FwmLhMvO+JjcIHHqWiZNOa7VpSiStFpGQt3Z1YjC6f7i1AO81ccgq3ZzHbY=
X-Google-Smtp-Source: AGHT+IH1qJTSA+mk1/xHCNjvRAdlnsWWTHjYvOvGH+pqksKR+MG62aJqzbb+zune5E3foFwFSLnjFg==
X-Received: by 2002:a05:6a21:339f:b0:1cf:37d4:c4f6 with SMTP id
 adf61e73a8af0-1d9a83d622bmr29254046637.4.1730889863244; 
 Wed, 06 Nov 2024 02:44:23 -0800 (PST)
Received: from localhost ([2405:9800:b660:984e:d18d:11c1:a6ae:4c4c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb699sm11418444b3a.167.2024.11.06.02.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:44:22 -0800 (PST)
Date: Wed, 6 Nov 2024 17:44:20 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 1/5] i386/hvf: Integrates x2APIC support with hvf accel
Message-ID: <ZytIhJDBtsAhPSKE@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
 <20241105155800.5461-2-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105155800.5461-2-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=roman@roolebo.dev; helo=mail-pf1-x436.google.com
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

On Tue, Nov 05, 2024 at 04:57:56PM +0100, Phil Dennis-Jordan wrote:
> Support for x2APIC mode was recently introduced in the software emulated
> APIC implementation for TCG. Enabling it when using macOS´s hvf
> accelerator is useful and significantly helps performance, as Qemu
> currently uses the emulated APIC when running on hvf as well.
> 
> This change wires up the read & write operations for the MSR VM exits
> and allow-lists the CPUID flag in the x86 hvf runtime.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>

Hi Phil,

I don't observe any change in x2apic KVM unit tests with the patch.
I tried the single patch and the series, not looked into the test
failure yet.

Do you happen to know why?

Also what guest do you run? Desktop Ubuntu 24.04 doesn't seem to work
with x86 HVF.

Thanks,
Roman


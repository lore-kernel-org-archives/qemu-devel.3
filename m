Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB980C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5q1-0003AT-KV; Wed, 02 Jul 2025 18:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uX5pz-0003AF-QE; Wed, 02 Jul 2025 18:21:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uX5px-0001J6-3M; Wed, 02 Jul 2025 18:21:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so7403275b3a.3; 
 Wed, 02 Jul 2025 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751494908; x=1752099708; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=aEE9+OAxIAZ0pOpFCy9jzdVce8b02o+8bp9bJt6Mz18=;
 b=GtQI1cE7g9Dbw5uqamgTLHyPiM47bSvsluT/q8IFEXuOBdgazgGU1D/07hE5dmBRpq
 AzsBsueYB01a5HKHCYlctEdquSDLPSiandTr/WbXpfcjjaZrKjYf7PL+hZDZ1Gl0pwWX
 erDGQLlXoqMrn9lOJoxgpNTq9DyHLl0R8aEO3g9a4/Y7/MyeRRPgve2s5EQvSVJk9VNo
 Lr3FMSNOHV6gsL+1hanGddecW1FJYfd0npdK7fLt6jQmsjqZNjBod8aLrR1qqANZs5Hx
 rlqCraLO3yQv7ezcfncE8vEaOz1zoBaq7Yjovnrhjrl4yM5yaraxeEFjPSgMqzrgEofO
 5i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751494908; x=1752099708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEE9+OAxIAZ0pOpFCy9jzdVce8b02o+8bp9bJt6Mz18=;
 b=VPCOPDdtjyOfiwDxQIvag1Wl+XV4D9hwJxpPsCeUej6NSQ/+6yOqO4S9tTejmEQUNL
 mHUICQIfWvjl9jF15W8ZDRcgQ13F0SiVBDE/yVEh+iHUN/mQ8iLTmFOrupQBZ8jND2Mi
 DpngG/YXNEOevzbW5E5ZGN6jzXYP9c5uY1hOGM+xCyfUDD97r9guKXUvdQH0klyT8Unp
 GfGKd9wh1J1TGDl+9loIo9vfRKl0+uGw/3Q/QCE++Q41VdIQQbX+mwpHhVBPTuLH5NtX
 RvKs/XCWfQ+e4xb2H9aHRUmDT1oQiTlXkKQ8WXDop90zQF3Y0kaKU4jNXx6CfprEBE49
 BiDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpYn5Iin5fvrB5yK5ifwE6/IMSEf1qVmgCVAyeGEB2mC5J/bOWqSJo5QsUDThDe0vY/4gmJvKW+w==@nongnu.org,
 AJvYcCWLoC/3yPNUT0M9ll6xD9Ecsyr5vfbamKUSimbOttqaC+HPAJaLolwY5rbZtd0VnOCwtqXT/LTXdZKi/A==@nongnu.org
X-Gm-Message-State: AOJu0YxJpZWaF8tbcYropTaBJddV/hYpAVKflaBLKbbEqTYxuORSVt42
 srBhkU28UJnoPOpqOpqEFkD4XUUloPzEiD9Cj1KmhIUffEbgPsVYwr8l
X-Gm-Gg: ASbGncuuY45Jr6cvqBUUK1Njqqn2+F8bFzMIzF70CEYY83DRdI4Fc6NLWDMmtAVQpJf
 YqDlHLWfUx2GBBCsYNdKi3HYJYEdgi1r85NH3om9rG2/gHuriKdeYxYMXyUScNJ0pr/qBh9vT+V
 eJ//WdjXQVdyM3oMGrL6MTVW5WMDwC5rYbWJgsnMnKhkKNAG/bgxzPcoCF1LxLdE0NxFrtH4/5R
 HWL0lFtQb8MX+PgIUi9mPnBuYT4uTxsbEzMORR56d+h5xK/oYgCpPj5AwRE8Ln1CFhc5D4fLDWC
 OmUw8ba7FmuSKm0x0VkLC2fNiEh1+Psv80l09BOY/Bd3/5K/q+Wt+JEWLUMVplFiM2gCumlBu70
 =
X-Google-Smtp-Source: AGHT+IERiijSNgTtxrfUIcDDqvD2uv3bt1XXVWxVzUetM3uu3sY5hvwTLnpcX8PNw80LHcTtitSaUA==
X-Received: by 2002:a05:6a00:238c:b0:748:f1ba:9af8 with SMTP id
 d2e1a72fcca58-74cd17629e7mr936060b3a.21.1751494908574; 
 Wed, 02 Jul 2025 15:21:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e31da5f2sm13649489a12.58.2025.07.02.15.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 15:21:48 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:21:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/highbank: Mark the "highbank" and the "midway"
 machine as deprecated
Message-ID: <ed4c31c2-0210-435e-bfd7-80d20bf6f4b1@roeck-us.net>
References: <20250702113051.46483-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702113051.46483-1-thuth@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 02, 2025 at 01:30:51PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We don't have any automatic regression tests for these machines and
> when asking the usual suspects on the mailing list we came to the
> conclusion that nobody tests these machines manually, too, so it seems
> like this is currently just completely unused code. Mark them as depre-
> cated to see whether anybody still speaks up during the deprecation
> period, otherwise we can likely remove these two machines in a couple
> of releases.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>


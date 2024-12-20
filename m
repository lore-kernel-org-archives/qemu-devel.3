Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B743E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOQyC-0003YI-Tq; Thu, 19 Dec 2024 19:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tOQy7-0003Xp-64
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 19:34:15 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tOQy3-00069K-Fo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 19:34:14 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2165448243fso14825025ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734654850; x=1735259650; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ca67b9v/fbnTzVf2qL36WFf3JL7LFtadx1XacdGNUDs=;
 b=LWrG7grtEZqJstSp3PID1zlgXol3ABsfrjXRQrVl+pzT39XaxXuool5Vzuk/v7us2N
 hxOE8y75k++bnt3jpt3jbnnboQe66b2JsWPm+N9begulQ5lcY4H0m0RfVCfta+//UPTD
 LHXB2mrMuyjXkmITfRxV6AELWO/dORLMIughXJwGJZ70TcvPMugcP5pTHwzESPUZr0Ux
 FfVKIb9IPHm8eN8bJISqfteJASx/bDAw8FlJucxA1zkehDVXrnHoRla67PrG4eYpQukT
 81Bwp4u9WFP7+7C3EgLiVbFDMz9GJYHHOfkWeHSHshcd+8ADX6zLOrqmkMa/ky87oEzX
 dqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654850; x=1735259650;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca67b9v/fbnTzVf2qL36WFf3JL7LFtadx1XacdGNUDs=;
 b=eJ9LoExMq9b1jLNVkNndm/4ftEnD7stDCxxxmgWOwEz8ymJGheIzY0kP4vujSI4XiV
 irfRqiqvznyRGXe5QVjk9u+RWjos8HCHd9M89MGzubaEdHf8i+2Lfb3LHc4m23q/R2uS
 BpCS065Eww21LmpEk2XrMJYudzuvw0NOO/dc7ePxL85trD8u1utrcC4FQSWfNU2oTu9L
 Zy7Y4uVngml8+KKzk2pKW4qpSYHDnqrZWi1vtz8Ho+UyQpEJ3KGQ3KHMwEZuaKZ4W0el
 0LXy7Ft76UFPv1MfBAdmPNQdjDN6GPlpvpFmPirJ5Ceb7voyuadPzNlghhyTN/AtBcFU
 rwzw==
X-Gm-Message-State: AOJu0YxCCTToVVO32+ktT8z0rPm/7eajtM+uE5sT+vAVGloKja9Hb8jG
 B1OF/vzImGFX8qDaqPbR45r5jFdPFjbxBmQZvPelXzBkaTOW8G5q
X-Gm-Gg: ASbGnctyrMWJ8tfGxmWvdbujerCzPGp5KrzFptEGhMn17L0QxrTZEriocW6CWXsc11h
 mk+8ENOfJbSkpv39JMzFsNXCedYvDKhcQUTQcX84l+0vyJ1lWxdsUONQXi/xvzeWqeaBacpfYCu
 cmNGU3Lh3k+OCYFsj25GeKHB3ydPRkpTzbppfl9UskCxrOIJ4Egza1H8ZzMVV1SqArqEovvqdDA
 YK4u58NLleNrdKCUfQsiFYCFrizLAWcyhPFjWWawLQ4o2vrQEKXLsUwLs8CdRVbhtZwFnB3D5V2
 SEkATRyT2opKJw==
X-Google-Smtp-Source: AGHT+IE63soaceRGaIxn8boT7Sz1UlLuqx8bKSkQzHVi2HU5LigG7WvuqtoWV8k2cS2YnkzexFUGcw==
X-Received: by 2002:a17:903:32c6:b0:216:25a2:2ebe with SMTP id
 d9443c01a7336-219e6e9fb3amr11728375ad.19.1734654849748; 
 Thu, 19 Dec 2024 16:34:09 -0800 (PST)
Received: from darkstar (189-71-161-74.user3p.vtal.net.br. [189.71.161.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc962cddsm18313905ad.48.2024.12.19.16.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:34:09 -0800 (PST)
Date: Thu, 19 Dec 2024 21:34:26 -0300
From: Davidson Francis <davidsondfgl@gmail.com>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: Ideas to Improve GDB Stub in Qemu for i8086
Message-ID: <20241220003426.GA2475@darkstar>
References: <20241219013535.GB4298@darkstar>
 <CANCZdfodkH0Mf8jkxs3Gybh8-nOAm79X+QXrbAvo0RHR9tBfXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfodkH0Mf8jkxs3Gybh8-nOAm79X+QXrbAvo0RHR9tBfXg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=davidsondfgl@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Thu, Dec 19, 2024 at 09:51:13AM -0700, Warner Losh wrote:
> I might be interested in debugging some i8086 stuff for my Venix/86
> emulation
> project.
> 
> I'm curious, though. I see special cases just for EIP being returned as (CS
> << 4):EIP
> and similar for ESP being just (SS << 4):SP. What does the debugger do,
> though,
> for other cases where you need segment:offset addresses? Does it translate
> properly
> behind the scenes in ways it doesn't do for ESP/EIP or do you have to
> examine those
> addresses by hand as well? If I'm chasing a linked list with 16-bit
> addresses that assume
> a particular DS, how does that work?
>

You've brought up a very interesting point. Indeed, in the case of 
linked lists and similar structures, there’s no way for GDB or QEMU to 
reliably determine which segment an address might belong to—perhaps 
only guesses, which are far from ideal.  

That said, the approach I'm proposing doesn’t solve all problems and 
still requires users to handle these conversions manually or through GDB 
scripts.  

The main goal of my idea is simply to reduce the initial effort required 
to debug i8086 code, avoiding workarounds with architecture XML files, 
and proper instruction disassembly and stack dumps out-of-the-box.

Kind regards,
Davidson Francis.



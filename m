Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5781CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaZy-0005vQ-2d; Wed, 22 Oct 2025 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaZv-0005uw-LO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:16:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaZt-00027d-4W
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:16:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so34315335e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761146198; x=1761750998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGhQj3qeF7DjAi3dEJ9yvYLAGI6ZoSW4Gh34WzcOOj0=;
 b=Dohj7gaPzl8VJe0okL+TAUkcAvCqVySqF8wnTK2esavvjUL+icMnSIKyfDPtPaqg2q
 OlG4kkT20rw3ZyDd0UA5tlYAPKtA70EGcOSvs1urfgNjWIL/lMj4WmjAZWRRsCjqAq5e
 dwj0kMAKYf80saE70/ekDICVrLgr8CcT+WtTlMdIpuCvb6jaqTXlsUw+QQA7cRCaDn3u
 qiy1yEM/OP0i4Ytok8m9sDor1LwBf36SbtEFBumI75MiCguSo5AUp248jRI5n4Ptb3K+
 WMuu3/NCUVM5QlNCQtBZ9J2e9YgwgOejGihGVj79EwIoMovAxI3d3Si/chp9NEs0prLZ
 q4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761146198; x=1761750998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGhQj3qeF7DjAi3dEJ9yvYLAGI6ZoSW4Gh34WzcOOj0=;
 b=AFmxI6tBveFLG3Bz8Yx5lyd3/Gzr02E5EE3S3+tpSL89drzhRwnLcy+5zBwnLBTmc4
 xD0DmtCXV6uj9frRGGL8Ym8jCTScpJwXtrTdFBFc9R5wRJVdrNQPkiOdirwRE8y8daOP
 PtZg3LJqawUnj1/IawmvrC7Tn1D5shQR7XZe51JnIAnM3rMlzOqyCuAw3YlIlKgjdFkY
 0J6COCM8+R28+DDX//NHadlK357cMM7uyDKnQ2Uvm7q8vas2bL/XeC1hTekZTtdJSokV
 ub3P7CTreztFPZlv14HQBe1book4WcEnxrZr1NKgIq60xbdVwpulfyuR+FCDLw0a8dDi
 taAg==
X-Gm-Message-State: AOJu0YyVcNuxKSiBornlJL1GhUkq9zJuOOgyDHgXv6oRjRAYMIC8WKYh
 7KND72F54Tw12H6J09zIwdpED7oj3Jjk1KD/OmG/uTGCfzn+rmsqQpSMznW2UdodcJGFr2VtTSE
 Q69ji82Y=
X-Gm-Gg: ASbGncui4EPY62fVVsE2QJEq7dhI8miP6RC+BpvhngTtKkbC84pkYlQdZqMcCgryhq3
 HA/vvVHpr0Z7Sgcuxrvttpm5kWjtouTwBud7kXfI3aPxyuqxUGVf2jtq93yHkMvth2JvQcrA+1c
 BQ0hyLNTcRiz7zHfiu9DYe/CMu6UHYqEF4CY9ng68o0RyiY3Xlc/Df4FwnZpCdXHcP/GinPAlFL
 LzqEjuY1KNvCZ5EW71xyBjPasVQD3p3BG/9aXOPrdIpadf5LXMOE1SczUmTi4KD+kYmh9bjaVZU
 G0MMRuJObHXnUqCR4AuS4vyCDeYRAYJi+zTYZmS3WziS3uPXE1BYc6O+Lq93fWeVztmXt5Ps61q
 F7nj0OdCVRSMcFCrHWlUGrFx4R5lece7VW607t5uWEHhd/4brrIVDLEW5H66l57mn2zs9UqPhHO
 RX0uDzrBnoNttbgyGwc21exxHRUgK9B4gaGyO8vQlDZbw=
X-Google-Smtp-Source: AGHT+IHmisrky+JBSjViV+1fWgbUMFI/q40HG/v2HIzPSFo1MTuCd/tm8pm/7LrG1JMH6W5BmEa+zQ==
X-Received: by 2002:a05:6000:1884:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-42704dccd35mr13636355f8f.48.1761146198430; 
 Wed, 22 Oct 2025 08:16:38 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm25186600f8f.4.2025.10.22.08.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 08:16:37 -0700 (PDT)
Message-ID: <83fe1094-0d74-41aa-9e43-f783cbbf3325@linaro.org>
Date: Wed, 22 Oct 2025 17:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251022150743.78183-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 22/10/25 17:07, Philippe Mathieu-Daudé wrote:
> v2:
> - Document ChardevClass::chr_write() and qemu_chr_write[_all]()
> 
> Few chardev fixes:
> - preserve %errno
> - allow partial writes in qemu_chr_write()
> 
> Improve chardev methods documentation.

Sigh, this is still missing the qemu_chr_fe_write() @docstring
update requested by Peter:
https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/


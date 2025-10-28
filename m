Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2423ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiYj-0004fB-0A; Tue, 28 Oct 2025 08:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYg-0004eh-Is
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYb-0001yR-FR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-427015003eeso5238267f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653525; x=1762258325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jgiZq+yt5DoSqqEyPQWGk7DYumEKCR42t50hbFkH0VE=;
 b=EqjeABMbk2Cu2OI5xhA7kOh19uAKNIISdNcoW7FmSRjMyr5gH7eShLpF/5XojdA/Fy
 /oTmIotSxQgeXZ/CeRMnYMVvwDq1U3f2yBmQMOU9WlLrYhWrzUInkJU9+60UixC1UCvd
 QgfY8Cr+fW9fXisOhxCot355Qp2d1dYx8zlVJYLOhZEOF5yTCTwo4TmzjT9EI22yHwfE
 U3azH6wRd9eFxXi1lhGocMYjaON6z+Dt2BBVmwoUvqTMsYZSPe+bPgLcNFcAVbCn5EE6
 2JVWigEWo5I4NfgMo6kMmLjBTJG7NPzm8S7jbKKbx1ye6CWVDA7FYRqNvASJl7DIthbI
 72hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653525; x=1762258325;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jgiZq+yt5DoSqqEyPQWGk7DYumEKCR42t50hbFkH0VE=;
 b=E4C0uk8ivnCMVL0SuopChr1oCrz3qSektQUT/e91WQzUMka5nyR7chNB+g2glUDJg0
 ZwzlZjl9r2elF7xYz+xIHlf680ba3NtRF6ZNrIPFwinaiwir86geM46Jcv/iQuayTMf9
 nRAnzxle8t/+6O88qGxS2bX2HE3ZdpsBlrF40LCkRlYelbGuPN/w92EV6wpGsiq68rye
 +Sofe/fNCT4AtJ9nsewTrd58nCSWUm+bh3ATgvnQYXBR7kZP5nkA8dDYl2ApizuLaMKp
 HwD9EGI86/qO23VHf4s5kt8/G52/vuSKzvMkrd40CXJz7nppn1IRWqDDsiSiaOeI5DR2
 2RFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnnAcR6i4Wk+1kOlE2JgThKDlCJSAot7Gt79z7E7qNnVI+bO/CpLUjgnoz57ZstfxCY2DRrzTOQTdm@nongnu.org
X-Gm-Message-State: AOJu0YwKixr6LKMh44C0IlHg2PdEGDT7MPWw/ofrM2ojEjf2lWXqUbJN
 IZGjuRmFUd/8gddBbdXSkotizOxzy7mHWZdcArfrakxXu4mPqPgQQW3OCCbcorC5p7M=
X-Gm-Gg: ASbGncu5Gb7sawBZPLSFEMpcAx7bzsFrda8vBtKahSlenpO2fJE15x0dbzdzdHcoSQQ
 QxVfw96JAy2jgfmZC0KY6LV+Xn0+Yrxh7BffWg5ge7QU+YfTwJS4FNU6fydY3ufHY+h4udRAuHt
 1fgB4JE1i1F6FhjsEF9J+k+UFVaESUFSRB6/RPSxWLiIml+WSym1PKjYpg50byJAi5jlZy1LwjH
 5Tw+xcs8xpxbQHTmr/ebYb4zNeu7Rub0olgQ3uKmxFbvTm/hGLOiChadjg/Y8UVSx587Fsee7vK
 51hEFy0eWRigY0Dv0oqW+l3iWBvxZz5siglnfFlknHGjTMYTiJZEcsPiDXuzzGJ39F1j2RiOdU3
 u/PGDGMsz9CMmnSj/lg7vTXF2MC12J5xiPcXSpBUZbbTgqC9wQ8xTI4vJCEgSI+B+wmA5F5zZCr
 FyWlr4t6CvmtDzfK/N
X-Google-Smtp-Source: AGHT+IEY8u70W5xjT1WFglgOtAEgJTxu+ufCAc0+Wjb9lyIzZUpw5sH6oCEFDiP6Lufy6zD+vUFC9A==
X-Received: by 2002:a05:6000:40c9:b0:428:3f70:4b3 with SMTP id
 ffacd0b85a97d-429a7e9ca36mr2876173f8f.59.1761653524756; 
 Tue, 28 Oct 2025 05:12:04 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b6fsm20102268f8f.1.2025.10.28.05.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:12:04 -0700 (PDT)
Message-ID: <c29c844d-0ac2-444f-b5af-a2de52899d00@linaro.org>
Date: Tue, 28 Oct 2025 13:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Devel scsi ncr710 patches
To: deller@kernel.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
References: <20251027211603.7141-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 10/27/25 22:15, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 3bf5c57a11827d9fa706524d57ee3e5af68a429e:
> 
>    Merge tag 'pull-tcg-20251014' ofhttps://gitlab.com/rth7680/qemu into staging (2025-10-14 10:25:05 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/devel-scsi-ncr710-pull-request
> 
> for you to fetch changes up to 95a3f921811ba3f817538580ee7b85336dd16e39:
> 
>    hw/hppa: Add 715 machine type including NCR710 SCSI (2025-10-27 22:13:22 +0100)
> 
> ----------------------------------------------------------------
> HP-PARISC 715 machine with NCR710 SCSI chip
> 
> This series adds a new emulation for a HP PA-RISC 715/64 model,
> as descrived here:https://www.openpa.net/systems/hp-9000_715.html.
> 
> That machine has no PCI bus and instead uses a "LASI" chip which has built-in
> NCR 53c710 SCSI and i82596 network chips. Compared to the other already
> emulated machines B160L and C3700, this machine should be able to support older
> operating systems like HP-UX 9 as well.
> 
> The QEMU project participated in the Google Summer of Code 2025 program by
> "Implementing LASI Network Card and NCR 710 SCSI Controller Device Models", and
> Soumyajyotii Ssarkar stepped up to develop those drivers.
> 
> This patch series includes the code for the NCR710 SCSI controller,
> the network code will follow in later patch series.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


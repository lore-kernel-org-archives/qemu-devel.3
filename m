Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3759DCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvrH-0002Qc-Ol; Mon, 03 Nov 2025 09:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFvrB-0002KD-7i
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFvr3-00060C-V3
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:28 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so4209894b3a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762181297; x=1762786097; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=SKw61mVpAFp6lKuqOcxAB8I2qG+J/81gjnniy9U7+Qw=;
 b=L8krzmUNwZ8V1LjtBd/k8/qYRPuW/iKNTDaRG+4T5N0z/nyA1M9zqJuHfAnZ1tX1g4
 gb/DBhrqBQxU5+IsLDqml8Xnm2eyApJ841Qr4wuJ3Tjv0qDIC3WOPkL42vxg7zYY38JA
 OnX0YmIOZw1ruoZrHuc1Ydshy/C03V6wS/WfEVpPo2EJWlcIQjvNNKDEMjienhonvngf
 weAanHq1IQN0QrE3Z4XnSQ+vhAkMOTLM9VjFgiZr5vbWw+rZQnPX5h101mDZ1rci39+g
 SqfhmbNMwrl8qI1IRMBB/u5+o/C3AdB49+BKoas9gqlPI8YUJnjcqNHBjzit/6u8eDo4
 sGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762181297; x=1762786097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKw61mVpAFp6lKuqOcxAB8I2qG+J/81gjnniy9U7+Qw=;
 b=EWs1NteTdKElYnSqsapf8GMrCm1RaGA3K0yH8WuELpxvoou+E6m/x5cvp0g2cXdPmi
 ckIEzubCNL1aLkma6eWq7xUb63Wax6Hrg7XWWaIYDwsIfcSkcSkXys26wurgseRheuJy
 l7CvkAkHpyEOx5N7u2SY3EJsDzqXNquWAP+Z1w5swbXZy0SHv1MyydLzrRwCLalWvCUy
 uXGg/ZaWXuFMOQI3Iur0c4VA4QtTYrGp9IX3ty8IiiEvfWwTcx/F9Wc3G+o2Y3weU3BH
 M3LacNL+IG7IFAtQctS4lGoYcqixcz0++sLVk+8ZZtVNeTKvxjEKtiszGci8V8vg/22K
 jj1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW/igWtSalcDhJ8ZXU6EDCoj61IjbStzYp5ioNSEM6r1bTUnCatwF1YpxVbfthgmO7Syaihi0TsPQK@nongnu.org
X-Gm-Message-State: AOJu0YwnhbeWYQD9dxYFb1B8aT0SQTcB3RUDMiX/iqlXtSMeo4rh/4QC
 M23I0sb2HI2pdr979wbW22oTkYHhQiBrZ9z5I6VQxRlw7G1oBjHf5G/s
X-Gm-Gg: ASbGncsucXkO/bdGFm404V0KZTBNP/jhGaxpjv21AuX/6AMIRJ3pN0H9J3WIbjBcwMQ
 snwHdmbUSg4ntIsKiDBxXualuDRgNC2NbZQG2rZofD4AvmGj+dxHtm5GqjpgoLZDoo2Bum78v/f
 IO48BN9O558/qQoTEAInjx3qbkwxqc1iGFA94/xiNUSl9fA+sRjxmaP1KW5ol9MG8L1D8PRkjF2
 NjlBn3HLxd+yp0sI30bj5ChYhJz6V3iwz3JElkzdEIuHHVwGD5AWCtLEa5O5MquGq3mpQWGkKSN
 RCI+ScoTu9yy2YeI06em4WTDMfyLxmw944j4peXoS6wPJhAvnXDmRcDJBedA6R0g2boXGp30atA
 0Kgks/lq1al+aBi7L1f5PR6ZXB+f+yX9F2Mf0rHjJUVNuballZxQURFPNdQu5O08niA+2XJ+3+A
 MX5dm4DSoIWc68
X-Google-Smtp-Source: AGHT+IGu1ZfltuT54fQyY4xeGF5efLlBK1zJhVriHWY6Kgg+81ydIxXlzVNnZovpVmT/9l+zznVJJg==
X-Received: by 2002:a05:6a00:2192:b0:7ab:242b:95d0 with SMTP id
 d2e1a72fcca58-7ab242b9885mr4293182b3a.18.1762181296704; 
 Mon, 03 Nov 2025 06:48:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db197340sm11605200b3a.44.2025.11.03.06.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 06:48:16 -0800 (PST)
Date: Mon, 3 Nov 2025 06:48:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, deller@gmx.de,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/3] i82596: Added core infrastructure and helper
 functions
Message-ID: <68c84dea-99ab-41b7-9721-4d6b0272a1b9@roeck-us.net>
References: <20251103112723.12256-1-soumyajyotisarkar23@gmail.com>
 <20251103112723.12256-3-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103112723.12256-3-soumyajyotisarkar23@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42c.google.com
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

On Mon, Nov 03, 2025 at 04:57:22PM +0530, Soumyajyotii Ssarkar wrote:
> As a part of GSOC 2025 I have done a massive rewrite of what was the
> 82596 NIC. This has been done to add the missing functionality according
> to the 82596 Manual and making the code production
> ready.
> 
> In this patch I have added the following:
> - Added comprehensive 82596 constants and configuration macros
> - Implemented address translation for segmented/linear memory modes
> - Added error recording and statistics tracking infrastructure
> - Implemented CRC-16/32 calculation and appending functions
> - Added CSMA/CD collision detection and backoff logic
> - Implemented bus throttle timer framework
> - Added enhanced reset with full state initialization
> - Added receive_iov and polling support functions
> - Updated VMState for migration of all new fields
> 
> Note:
> This patch primarily includes placeholder code.
> To achieve full 82596 emulation, the complete 82596 patch series is required.
> Nevertheless, QEMU is able to load and boot successfully with this patch.
> 
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Tested-by: Helge Deller <deller@gmx.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>


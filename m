Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B81CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 20:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vICTZ-0003ro-Fl; Sun, 09 Nov 2025 15:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vICTW-0003rQ-KW
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 15:57:26 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vICTV-0005RX-7f
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 15:57:26 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6407e617ad4so4039792a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762721843; x=1763326643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grl+RiUG7eW1UQXL729RuxCIWRUQQNndg33/cs3eK+4=;
 b=GYeF2Rh+59/EV0t0yRlvegZ8DG4XcCfrOGvs/m7XUzdeMNyjlT0XOH0A2AWmlHxpVi
 7nAQ/ic6L1QLfU+o9RlpKcpKDHv7NgQXoC30Q0e2aqxZI5Sn/vfk9tAJdEyLoyxgx3G7
 QS0Ey7ocx7qgcqBtweDpfstNc5Ev1PBFF9bOCh/Upikl8Rx2XztdmB8DuLsq+XYNh+VG
 nnUQoCwmV+8CvPvz9ziDo3eatqaBcQK14GMjAzYBFH1QTxptRfFMuhhxMpNpYE9Ap9t/
 gBgUBreZzrWDd1gruyvtlK4eVrLsm7DQGG/805CT40eYZ7oEKrq9ab0qxYSCAztXX233
 5+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762721843; x=1763326643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=grl+RiUG7eW1UQXL729RuxCIWRUQQNndg33/cs3eK+4=;
 b=TecPmiGoznw/nJN72vzx/+E32G/ZhtxSx2HN7go6AFdxX/T/xEEoH/dGS+uU2BBbWv
 5OVJlAe5XedpCQfG6/bidqviiMK7k9zHM2h612W60oszeGjWwJ3nFwa7qkC/v2nJ51Lt
 SRnde6oU+IQLgTTBj79qUoRsBtaPJyryYYBYQqPxy/tmxry7ZYqtzc1CWuOYIP15/e5Z
 CXR1D8uC16cmhB1dPMPOAk8Fz/59k6iSYPeCrVpVlw3X836FC5rzJd+A6P8ynUtQHMfI
 oxnty+Ih17dAJ7qoQnhc8aXeNRGeZX4ucQxbkos1iVO8PzmhboXGqk6d04UvzUzSZ2gA
 vHYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcVV7b+WHLKtIrg1yxsAfNU3lb1FbJn0uKi14wDPPqxGThkPqMqPouyZDYcdzqe6F0MI24bYNuIG07@nongnu.org
X-Gm-Message-State: AOJu0YxF7QFMEvyYPQNdbtASY7Fz5u/B4xdFKw7IGiNBg4o8+D97+Md7
 xdFT0TNoZi0yGFRP3slAG5o51qhKCwRF60E/rLl/RH5wIdvUiDQ3efIuswDxvnXg/+Q/YABFrh1
 HUdjmlXA9gf/cDmfZN4LtBubX1teRwQ8=
X-Gm-Gg: ASbGncsVEqfXHBDNXEfq/hlZXgd2wySZtP+qcc3jO2ZvDRMoJIRHHNofoUSMvYdcL13
 GIf1z2853oFJERVBgtJpTwziw7AAtdt6iqR/g6aLhdk4tjYipHJtdVQgOF9JitcCoEQUSlXYne6
 ExALAP1ME3JKPQsG3pNrhkZ5ROcrwanMB+zi97fTqv4fnI0Y2YdNR6jJvr3Qc9JIqeD2VjUHcKB
 0h+EIRCgHhGcJTpgAXeaESJCTkeZku3+NgEg2Gwi7BWZNy5lvhOcgHD0OueLzkf49jk2g==
X-Google-Smtp-Source: AGHT+IEVH1sz1yzxJk69LPL40ZvT7wHBHI5sCT+E7+UhaIahDVSKq0mhh8qWaEygtmYSFhdcjnVoU39wtQ16HR0Nozk=
X-Received: by 2002:a05:6402:46dc:b0:640:37df:e798 with SMTP id
 4fb4d7f45d1cf-64146c0cbe0mr7500567a12.1.1762721842548; Sun, 09 Nov 2025
 12:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
In-Reply-To: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 9 Nov 2025 15:57:10 -0500
X-Gm-Features: AWmQ_bkxiXrxqHQwtGWaMs_hDm2A2mV-kpG08Wgoqo9lNi8PhAuDvEX13ikQdcI
Message-ID: <CAJSP0QW4Egf2iJMjUVBi9iNPvGtEUMN=ULwM4+ntsFLDC3otHA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] HP-PARISC: LASI's NCR710 SCSI Controller
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, 
 sarkarsoumyajyoti23@gmail.com, peter.maydell@linaro.org, 
 zhaoguohan@kylinos.cn, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Nov 3, 2025 at 1:40=E2=80=AFPM Soumyajyotii Ssarkar
<soumyajyotisarkar23@gmail.com> wrote:
>
> Fixing Defects reported by Coverity Scan for NCR710 SCSI Controller in QE=
MU.
> QEMU runs the Coverity static analyzer to identify potential bugs in
> code that has recently been merged.
>
> In view of the above these issues came to light.
> I would request you to please review the fixes for the same.
>
> Reported by: Stefan Hajnoczi <stefanha@gmail.com>
> and GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> Soumyajyotii Ssarkar (2):
>   hw/scsi/ncr53c710.c: Fixing null pointer dereference issue.
>   hw/scsi/ncr53c710.c: Fixing Incorrect expression  (IDENTICAL_BRANCHES)
>
>  hw/scsi/ncr53c710.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

I am not familiar with the device being emulated, so I have only
reviewed this for C issues:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


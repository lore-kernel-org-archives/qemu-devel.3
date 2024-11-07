Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4ADD5D688
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t99NX-0005fY-PV; Thu, 07 Nov 2024 15:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t99NQ-0005ef-DY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 15:45:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t99NO-0001My-P4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 15:45:12 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so2465652a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731012309; x=1731617109; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I8vlh4q9tNEgYb8TbmTj3pjSSGsAzW8x6Ca114qSpg8=;
 b=pG/Jf/Q20YCh+93fGMVqm6tCUGytew5nEo7A1Wlp5UHpM7wC0Uv7LQVaJ9fsoECNt7
 rOwB5O0PzXkZ8b5+s9cslry+axXfFQq0mlMLhgFAcdYgMX/kzkQGwRslW4usbxviV+iL
 mxK06hwnqMZUSFKwtNWA4BxUedblDI6JIYBbavJQLwlBJn/SZNp9O5d0WAtZD6psOdne
 IQ0pG1o14vX9FV3xIL4WYVTLvyNTLs0gqZarF4qOpQK9/+K6eiLlkvZUMF0tdsbn/Wp4
 zHsSuRo2JW6ZV34YdxXVY/cwXwZzEYFePrZgG0/Tw6IxCmgjjpgHabgAn8r5RdsYL1an
 Amqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731012309; x=1731617109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8vlh4q9tNEgYb8TbmTj3pjSSGsAzW8x6Ca114qSpg8=;
 b=SVYHeVnilgt5csWV5RjvCa1I1iZW0whfuh4O6wTBIUXajiK48R4gi+mJq1lwROBDc0
 OGImBOIcitDFWjWsa9gxwDO65wbraUw/WiDTycskLuoAa2gKklUaNoIELRsE5kC4oEY7
 Q6IxB7jveNb+rMXQe+cCrVr0n58Xucyvou44R57BRe5elxsJnoNKBT9tos0aojvu2oJ3
 gdRmZmVz5ZW1PzKmXP6vwa0TbH2uR2i79w0ydsLkaKngBvw82v00sRUzdWLBEijsrrmr
 OuSSiDLLVGl4aP+/JDN0Oc8UyE+xrMI9Q0HrtgR4ducFIglobHRxvJ6J42AGRR+uIf5N
 1uaA==
X-Gm-Message-State: AOJu0YyL4QVhymxmf6F5GphocYzYdl5wgSnyBqJodXASVg6VPzCqDeIA
 8OBw7fPEGRbApZ77uN+zuA+pMJsVCP7J+xSx5JLE3HSgUbIxU4VV5L0Kw+NBvtP0TyglgXW3+XS
 jAbHyIxdrFHYVcas0CuGQ2olV+iRG0hB2OfiNSA==
X-Google-Smtp-Source: AGHT+IFSpFdH2DTB80m1B94jK+N4nI1lBzn6GQcafhVc/uDIUBNrnO3K+OuFeABDUu2CxT/UHCvoxBPPFx3MAeM5Tco=
X-Received: by 2002:a05:6402:40cb:b0:5cf:265:cda5 with SMTP id
 4fb4d7f45d1cf-5cf096f591emr1027521a12.5.1731012308976; Thu, 07 Nov 2024
 12:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20241107041016.40800-1-alistair.francis@wdc.com>
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 20:44:58 +0000
Message-ID: <CAFEAcA8h530-M8f0GOOJ3=TQPB7Ae0O65P=k2sZZXUx562D4MQ@mail.gmail.com>
Subject: Re: [PULL 00/12] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 7 Nov 2024 at 04:11, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 63dc36944383f70f1c7a20f6104966d8560300fa:
>
>   Merge tag 'hw-misc-20241105' of https://github.com/philmd/qemu into staging (2024-11-06 17:28:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241107
>
> for you to fetch changes up to 27652f9ca9d831c67dd447346c6ee953669255f0:
>
>   tests/functional: Convert the RV32-on-RV64 riscv test (2024-11-07 13:12:58 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.2
>
> * Fix broken SiFive UART on big endian hosts
> * Fix IOMMU Coverity issues
> * Improve the performance of vector unit-stride/whole register ld/st instructions
> * Update kvm exts to Linux v6.11
> * Convert the RV32-on-RV64 riscv test
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


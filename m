Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF0DC83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmGH-0006zs-AC; Thu, 10 Jul 2025 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmGF-0006yO-Qx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:04:07 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmGC-0003Vc-Fs
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:04:07 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so640626276.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752134642; x=1752739442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZWLa+M9k2L3rjQyK/F3xb2YnUQvbGBC+Wse0j3Lt8A=;
 b=b7tqUMCgtEWI8PGdLPlOrnrj7AmrhpvvjZFlV6rONzfMd+U9U6rcEznjq/Eh9ODmSR
 3A7Bqm+J05kR29mP3e5lNmrU29Z2QkDPXxb1SyOjArM9xEWY06d0R8+BtpO5DacNv+sV
 wUsZd3wH7BNeBL7t3k+CT6FL/AZYFIDpU95Aw0FbKXbeCisSBIlNNx0OWjTgWy3PNG6D
 fS8JRyTkSoYYj8btSfBrj5RefQjRa/2qfUzRfXpJrOnFwoc0tqwNo/xH1nM1JM/IeIzX
 CcTHanYbkxKYZ6AzV2ThFiiquRRPNure3daR1Ld6r5cSsXvSjaTbgM2m2l/2lUx1Tp3X
 rZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752134642; x=1752739442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZWLa+M9k2L3rjQyK/F3xb2YnUQvbGBC+Wse0j3Lt8A=;
 b=GMEejKb4NgmoDv1oIYw4kYZtAVOq4W4lMzqCprSCrV0D13T7d/nGhGigNfvc/Sfr0o
 x4XuWw8T/irZVS3oNjL4PKRQX+8tAbnHjW+DUvY5xgLmndyQplMDvIbKEk+ijNGgIuFN
 GygLbwejSvb+IN+NWxghb9os81S5sm753f0f2K76bOfFitFM0L9azZUlkkyv+L3lncxj
 qlJcEAvGRTXmmIHLOnGFCFKUH2q+Zi+NQqv0FsXBhbZG6QGrdrHqTArAWV4UD3sofQCp
 4OPCeynHmot9iDVIhhBOYehAgzfl18oW7XYweJSwPz5z++3oH6a+EHG6KxgKWkpyEWPc
 lfCg==
X-Gm-Message-State: AOJu0YzDcomYjYqqNkEJEIxkbbJR5QQ7Zapu5PFeHQS+4P/q3BWi1UsT
 206hUvQ9cJJXikdOUJifkFdPq9UPUDlM05z3xDL3mfUD6C8swKWQFpvUEke9Od3r9BHZNw0apUj
 NpwnXa8KqVdUipQr+CmVWtCa3HdGexZURAOEAdOPOPw==
X-Gm-Gg: ASbGnctoUtX8lmuzUhn/WeTB8rETZhN4DZSTsUzwumss7lib56B5a0BRbYe9lnCEX5L
 7FoXOyVTiSP6LaeQ+z15NC7A3XiyLAv2TE06lAWQezllFsXdu094Vqi1elJyXldr1tqxevWFwhl
 lPfwI8nND6Xx7qnsIPXrG/STPX83j7zxR1+XQUX2Kss4ZZ/iLjiwwFToY=
X-Google-Smtp-Source: AGHT+IGXqRdTqRVTyqb0Dro0ggW8hGI/4iIFKWvO3BcVZnyG4Hp773VoGa2m4edea+rZWv4ENWPVIwZmPa9XzqukT0s=
X-Received: by 2002:a05:690c:4a13:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-717b19e2986mr81171117b3.32.1752134641866; Thu, 10 Jul 2025
 01:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250704223239.248781-1-jcksn@duck.com>
 <CAFEAcA8ONjmXYsfSfVLQEL7DiPpS-N69BfJDNTa8fuosui_vUQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8ONjmXYsfSfVLQEL7DiPpS-N69BfJDNTa8fuosui_vUQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 09:03:49 +0100
X-Gm-Features: Ac12FXz7DFEDyufTe_OKvejOzln5Oy2lcfpuSFuYqaqUAOYz1Pr1nfyqGRIFKuM
Message-ID: <CAFEAcA_b2BHe6WtpZks9TsY0ij0uTDe=rcE0Rsbj=bC5wdXP2w@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] MAX78000FTHR Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Tue, 8 Jul 2025 at 20:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 4 Jul 2025 at 23:32, Jackson Donaldson <jackson88044@gmail.com> wrote:
> >
> > v4:
> >
> > Spacing and style standard changes in GCR SOC, TRNG SOC, and AES SOC
> >
>
> I've applied this version to target-arm.next; I expect to get this
> into the 10.1 release. Thanks!

Something else: for new board models, we would also like:
 * documentation
 * a 'functional test' test case

Documentation is in rST format as a file in docs/system/arm that
briefly states what the new board model is a model of, lists
what devices we do and don't implement, and typically gives
a summary of how to run it. You can check out the other board
docs (e.g. stm32.rst) to get an idea of the format.

A functional test is a python script in tests/functional/
which typically speaking downloads some publicly available
guest image, runs it in QEMU and checks for expected console
output. tests/functional/test_arm_stellaris.py is an
example.

Would you mind having a look at docs and a test?

thanks
-- PMM


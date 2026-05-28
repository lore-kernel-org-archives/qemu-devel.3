Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612CDCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaai-0006of-U4; Thu, 28 May 2026 09:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaac-0006nw-Lk
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:16:00 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaaa-0007GL-Nt
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:15:58 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7bdec52f48dso119670767b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779974155; cv=none;
 d=google.com; s=arc-20240605;
 b=O7D5cDQFA8TsKt5nWvDW53k4sF2ZJSjYthpUB4yNA/HTzjJfFdSXnh+aEQnq7gvgtZ
 rcvcq50GJuYfMe7NwbtZwZkNSKNS+cjbhAPJWNI2lLRvAvjshiodvGtUgppD8gPSM9/n
 wgeZuRhpyFTXqrAbBUQj29AMcXCAV/fkWH5SfWrC8WbPNZ5UFCkrm5PeeSPfYBHifFKy
 godXWdiHpFwVETY8v0G7TjQw5U/rZKVzSZCk/U4fMhkVXlny65ggqB5KqY5WOAieHOz3
 mp9DjKJZlhFx/ihZUUvnHfQN6BTAHifuTJ3evGZKhePy2dUl/u1WBIq81ov8tPjzepc9
 b1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W5qVQX4g2kDEDhNj5puu5qMfqNjikLlns370pOVzk+w=;
 fh=s5iZz2r1vCh3RPx0AIYKMXS9olnVxjb4i7Imp4EdrKI=;
 b=Tjk/cu0/Hs0nX6iJ7HENVBWBoc7U7WIFxauBuAYhBmfO2mb4ICjaIkOpzB1dx2whPh
 KdUh8ATn6S0SV5yLMR7Vz5QMYjMxfKeRbTF7pK2yo+LyRT9+ngb1Ob3sSgiAP46ljhZY
 x2pF4S6LgnALnDqZ2B6Yh4HB5yxYcIIirYJkGz76/xLw4dJseQOtOHsL8NJTl/ORhY1O
 fP/0sug+eNuOFiRHKBBIo0RQT8F9HYMDh9FzrLnwXfzTAoBfdpzIM7/43tem6k0Ks0ep
 w1Py37+UQGJjklyk7XQM7oIwiCsahCALtQzQZAv4ptXjr3CL4IdoIqjVOpz06OTKoRHZ
 T2xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779974155; x=1780578955; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W5qVQX4g2kDEDhNj5puu5qMfqNjikLlns370pOVzk+w=;
 b=KkF9wdQab8Z7BTOqR0qkUXFpwYwid16VhxZDoVQIkYeQpIbw9notBAcjyOy3fL2EJM
 n8LzSZQaFIfOZc+XmRTHUPsVJXywVwiWL+HYptXpjm+BAHCclJ2r+5PFj7UjbfGZz9Sl
 oZVGy3ai9cZyUxtPkP4GwuMNd0Nz5BLd32C8xOn+ObCVc/HEf9seTajYHmLID4/VLx3W
 QzGIizDhd4dtTk435kcHlqB3gdHLY0G67/wA7fprgLVzeBo3sSGU2wd1yUTfm+SlwLQo
 50Nj517NtsafKDoMop1CwEm6xChbjtqVD/zsc6ncBBe+yiDfwYxfBDKmrMZ23hdtya/K
 Qt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974155; x=1780578955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5qVQX4g2kDEDhNj5puu5qMfqNjikLlns370pOVzk+w=;
 b=ceSfpXXgI6MQ/Ey3/jlRIpFjQXY1TFOqRFrTLEdZv+3E3Lhi6QuMzE+1gQj1ixrhot
 fCnEZEWp9KhR/f6HeB1dlrX9EAuWM3NkiF44AqGfjSWXWUggoehUhjH3zG9c8ukyBI0e
 KHvKn0oboMdWGvvorLFYjoD3HYDwjOYP3MXid3ccT/6qY+zneme0UavgSgTCQWGmnyVu
 +HuuY0UuvwIyIt5GMKLzOkgZiGnJi6cAEHwwtyXYcylm4bsjH5NCoUQTInYs69HTtrGz
 WFVMq+XQFyBEZG9xcY+lwkN2wpYQHKbIHEqL0oedmaGILaSwAfSLHiuFOkcEE6IWrMPi
 N5tQ==
X-Gm-Message-State: AOJu0YyXmdA+DOeua8R88RMhU/1yUTtF883sp827oQ3S+iRB/CJdt5mH
 kpoWrglthpwZ2L+ApsZ7ybmSsmzUYSO7Ui86Tep5wRpIq9yEPw+2I3Sz0Mjq+kAMByPn8QnS0p/
 mHCjFG5p4VSy7Y6yne3QeeHK6F2jYdA/h6x0yHlC9ng==
X-Gm-Gg: Acq92OG/+PBuah0JpDsycFnYVMwXHoDyrp9I4PYXFoQswK57rWj1gkKZ8x6YkAkEvLP
 rdh1rYJBWIAXHc+pf3ZOkH6RYfHebK1f2jZfkJRgOYrix5CIY+0m2VWCiFJuv9/JNwqIY8oYVSz
 xtE+APDgALH2Y+jAw6EkFaIawbq724EMOLQ01YftpggHGdz7euKDLOuX2toDSABHhvy2ceRFteH
 BrvuJWeQVYja+cqLgkIAffki6eq1dEjEeDbpHgbUbVynu/edV19Ft6ut+7qAUT3yZhUUPcd2qsT
 OiHh+B4TgTJ8EIplSQLPFSDgSwIegEd+z5xs1vaA19lahN/ZQogzx7e7lBoAAYqIb995DWa7Bew
 1sw==
X-Received: by 2002:a05:690c:c4fa:b0:7dc:3d2b:2e94 with SMTP id
 00721157ae682-7dce9f6ef0emr10257057b3.13.1779974155309; Thu, 28 May 2026
 06:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260528092028.173634-1-wangxiang@iscas.ac.cn>
In-Reply-To: <20260528092028.173634-1-wangxiang@iscas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:15:43 +0100
X-Gm-Features: AVHnY4KcODz9bzWHjYd4chOw11yx2bPkqX4c_UZ_wZTOdrsJDVjKgKqyA4IynD8
Message-ID: <CAFEAcA8BQ2uvfJQDG2W6bN2niTXsompGDmorQy_DUHpfy06oUw@mail.gmail.com>
Subject: Re: [PATCH] hw/acpi: Fix Terminal Type and Language field order in
 SPCR table
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 28 May 2026 at 14:09, Xiang W <wangxiang@iscas.ac.cn> wrote:
>
> According to the ACPI Serial Port Console Redirection Table (SPCR)
> specification, the field order after Flow Control is:
>
>  - Terminal Type (offset 62, 1 byte)
>  - Language (offset 63, 1 byte)
>
> Previously they were swapped in both:
>  - The table generation code (aml-build.c)
>  - The golden reference blobs
>
> This fixes:
>   - hw/acpi/aml-build.c
>   - tests/data/acpi/riscv64/virt/SPCR
>   - tests/data/acpi/loongarch64/virt/SPCR
>
> Reference:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
>
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  hw/acpi/aml-build.c                   |   4 ++--
>  tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
>  tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)

The comment at the top of tests/qtest/bios-tables-test.c
describes how to structure changes that affect the ACPI tables.
You should have a multi-patch series that first disables the
affected tests, then makes the changes, and finally updates
the golden reference blobs, not a single patch that changes
code and test blobs at once.

thanks
-- PMM


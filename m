Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC33FED2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cED-00006X-KP; Thu, 12 Mar 2026 05:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cE9-0008S1-UK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:21:10 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cE8-0002qt-8l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:21:09 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so886677d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773307266; cv=none;
 d=google.com; s=arc-20240605;
 b=iOHltJU8UQXBISAcArYQmTrv9Wkol/+Y2Om8orT2NEVRBoj7nv/6uWej5RVZdsG4+q
 izp/0fRPgyAyLKFIWaM8XFRiEYMBPE+9uf0X+GnwigOPC/hC9/EHqiFa+s6LS1pvJiF3
 36gxzKHG5MibogS2IUpuC/SmTfSNMFZazk5cbNGasPARLeiSoAQADVu1drRWI66DEFwI
 AXeXbrPfIOibLqXZhBfvSERQsheTvXJchf+HrmC3dcgD2N0OTR0XqWQ9F6vxjN5YpCxu
 ZPNPuGNEUWVkHCcieDnUM/yqvwPrXRwOdafYAXTGnFVYtrQyCihjOolfTBTsjxZGHTR6
 ZZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wlv8q1Wp8nYT2bBl5ajAoOja5+hnms55MUI6MkC1OCM=;
 fh=k3ChZzPxUfJJcY6qRYCKUe7e8UpIbjQ6JU1zCmZzITs=;
 b=UQT+Qi7GLjS4gnzxZoDrmbAxou5Cvcmhk8UhQkKIaSLW5BVBQ/E5gTF1KMdfMbZDyE
 jExki7kDH9ZKJIndsXuGtfIL8LKSvLyUXTw0Xw1PnoH7ZPzxPF+7PLmkBNUVRZ/Ya2yj
 4sSUO0jiGPyxGsdQVptL7Vmy4PdhLfod+BX6ZF3+VJOy8AOOHON3za9WY8BCYy43GWD3
 FJAgPM/E6qo5IC4PYc/r96f7u4DNBERoIZpn/wdmbr4qrxrL1LN8s+XuJHGYE6H1e5U3
 Ln2Y2U96C9YyGYuqT+UDDqNgTirrIPur4Vf2/44qV2vwNHP7BJw8OSOIXXHHSfRq9cx1
 Iiyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773307266; x=1773912066; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wlv8q1Wp8nYT2bBl5ajAoOja5+hnms55MUI6MkC1OCM=;
 b=zud30CGHln3fwEVdN+0R1db9CWmvxOPA8B9pvTGaqdHo1D510JIUILrGoD3nPZVCEE
 21CziTxZ41OxUXB2zYnYwsetTckRyQKUU17ZGhJSz6RvIoVvxy2oHQayuCqXPxGE5ohy
 fu34fIPfWlIPge8JxzspsW0we6Rwu+nFxwdDoTAgkjtowwOoGdp4M5kGkecGEdcZJsRa
 K4fhPrOr/x1ivO1FKFkBW2yll2hQLJP5Jbps0yU+25qlJbYa0jKBqZaTmleMdkcX5Fpb
 nLVYfMJKXeMER+woneAPvJDsih809eH0AVFPwigJu2DZ+4BjTW3GlvFUcBB1NquzS07i
 DQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773307266; x=1773912066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlv8q1Wp8nYT2bBl5ajAoOja5+hnms55MUI6MkC1OCM=;
 b=IjWRMzNigwSXq8VaYg4Ce9f+EvunylRAiueGLAptzAHQpSJydS+0akDfM5IeM6l6Hw
 wv+62FaVuDTUGZ97X+ldRmhCH5rQQcXf2K2+/A9dFlgZBkOgwsxOooZL7p5lbD5KtJY5
 /y2QuVRrVDhekuaNB/kVUNd39zQChoR11Nj8Y+dG7vaJCoBLgrg6N6FUu5V4kmJ4lF14
 r4faSgx687avu6Irhe/G78pwES5viZnA7uLEie8CKNXUJXXg4yZpDwjB78hXR+KbF4DQ
 VNWzrGAO5H9Q5MqHL2ool0l5mGVFklKYxLnXUFpb+8+zGOoVZyS+VpXa7l6tmgpT+icd
 4iNA==
X-Gm-Message-State: AOJu0YwFM0q16TDj97lofYLURqv5rgQaODbqKEvfXTl8dTMh0lOdkn6M
 wCZJ06d1hTUjEl7NkNt50xiKXozaLy1v2viAoUFaxvm/82o1M46uj5wWVrg0YVESo4RYoxUtvnN
 ALnNuML0I7OcSZK9M3zVnftCteP7btH8ounFvyt1pxw==
X-Gm-Gg: ATEYQzxd46qUjpeVPkLzwVAWfXK2ycFVx4QXJ/hjVfGN6ew+vzzh/3UJ6n+4/dYznVz
 7DzIM79+3/m7HFCz+qNPKSRl5kz7Iu0hBdPLwoGbSI/zXJkrmDPgNSegBRD9CRw5Lj012o/ysUs
 I1HwsftQ/bf5Ai6WcnQKIoffKwKRbZSYm2PQqSxN3uaY1QhEkJD6yPW3REr3ZML+zZn+eM3zD6D
 7MopD891AnZY1Sw9jGy0/AXSFP9e+Ldk3evwFLfF2ISK7O3WePoavaQ/YMRIWOjT62cvjgVSSI6
 OYJw4cHhcwNXZ6ZiAepWybdq4lOF5gQgIwNwrZ7klgEy8OlglAEpGDUPNrYcwgsLEp4=
X-Received: by 2002:a05:690e:1507:b0:64d:695d:6ae3 with SMTP id
 956f58d0204a3-64d695d6f55mr3862861d50.67.1773307266414; Thu, 12 Mar 2026
 02:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
 <20260312043158.4191378-2-alistair.francis@wdc.com>
In-Reply-To: <20260312043158.4191378-2-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:20:54 +0000
X-Gm-Features: AaiRm50LCHPjoWMOzHXaCd7hz8Ys-zcjUqDYaPkH9_0G7_UQoYWfS5c0_AmJHYw
Message-ID: <CAFEAcA--3xKj44aWzckmbHagZCMTED36Sz6fpHpO6kVxg+uBYw@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/riscv: sifive_e: Don't call qdev_get_machine in
 soc init
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 12 Mar 2026 at 04:33, <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Calling qdev_get_machine() in the soc_init function would result in
> the following assert
>
>     ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>
> when trying to run
>
>     ./qemu-system-riscv64 -S -display none -M virt -device riscv.sifive.e.soc,help
>
> as the machine wasn't created yet. We call qdev_get_machine() to obtain
> the number of CPUs in the machine. So instead of setting the CPU
> num-harts in the init function let's set it in realise where the machine
> will exist.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I think our general intended pattern is:
 * init the child in init
 * configure and realize the child in realize

So unless there's a specific reason to be setting properties on
the child in init, moving them to realize is the right thing.

thanks
-- PMM


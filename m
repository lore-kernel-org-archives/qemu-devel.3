Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhsa-0002nR-1T; Tue, 28 Oct 2025 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhsY-0002n1-9g
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:28:42 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhsV-0003jE-R1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:28:42 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-785f96ae837so25789007b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650917; x=1762255717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4Y6BPUUWXY1yr4C38AXN+bPiuFEZis9xOpoiz73cic=;
 b=Yawd3pTF/P0KWkpSJpDbrSDtOqn3K4to3gaQckULvz9dbkUNk34arXieiu3vlgvLul
 i20KjbO0ThBdVbhk+lKdfwddq69h9a9TMzhNMU0j8d+/Rsr83SXtZkEUfXutMaWKC5CL
 s2Jp9pfihe/wmOk1uKGD6UjBiLFiWe4Lp8iJJ6mXfH2RB7d8vRiGFMo3noW1+YAG7/UJ
 47HgN+mCDE7KtSR6P9W+OLS7clS6vTtJM/UBdpKthkVHqs6eTaPoQ/ba+P+WoRK4vmqQ
 pgktXwQB7A1brDZ2uwklAqIYFlfJmkTzUPRbqts0WgmeYe+pMFDcemQ2td94V095PkAe
 VbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650917; x=1762255717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4Y6BPUUWXY1yr4C38AXN+bPiuFEZis9xOpoiz73cic=;
 b=cP5HUtXDLlSPOkExEFAeEEpdKwVdANB9xLJpPt6uNkSHR16kHdRuVruhNWea202RNX
 w0RSPclKyyW2Z6IQv4MpeHz0gHAQVmmw1uWd1/CYCPMQHlfzlaKVVqKLTexTnJjDSkGz
 TFeathXz0M+62fw34MwxIHdP/sFSpo9Qzs+x7jiPHq8OeDJgSZiMjkz9RyB8frWMvtUD
 NXzBCJ5cNukH7Bra4wy9QbiA73sDU7dpgHMTSVhxCk5geUdTVD3d8Mi4uofzBQpq8yXU
 VT3lRmWaXxDX2vr8xwFN7eYzk0bvqyg7cCwdnPORF2KXlUi8xQHvABrE1U8Bx40YEvci
 CEHA==
X-Gm-Message-State: AOJu0Yw1hRBYUaHzT5ZGNEYkGJWIJJSO8akgzKNLYA1DqdExQm2QceTD
 VLYjUo5fZvMUlxpVpTmbg+LJjVHH9uZpzvSrrBtxL/wBIst6IFKJVHIXND3BDZjGdZOZAD9RfHJ
 npbxoYLDFCcnY1sATkPDLxWR9ERVjy7gstBToJek5xQ==
X-Gm-Gg: ASbGncuFsPRzls1vGFbmqo2NyWkcfZO+KKqCB8xnTf3Wd1vD8WiGpLmiaGRzXDbmjfR
 1HT0RD3JP2F406cB/LrxuynLjAB7MoGsKEoU9l+ggeCf2woBzDxdgGzM69gGrBdElX1EGJpHCqU
 BWGkEJRigUWBKcksoWiQjZOyF8aEmIfFLwRzj+I4ejcofYCOG3PbABDkJg7SsT/J97yun7kn/wS
 ot61tTdUN889F2GNIhMu5FZy1NamgiBhgoUK8JAb5jqAs7xcgQ3J6iVivfqB6n5uzJizppc
X-Google-Smtp-Source: AGHT+IF4avcIOT/G3mdZdJMqzMSaXF8+6Kvhwat2rzJvsX7sPcTvifECG8JPo4lM0RTFvWRwfpzuam4xR62VCD3+f2E=
X-Received: by 2002:a05:690c:2c11:b0:76b:dd1:15f with SMTP id
 00721157ae682-78617e54542mr29444627b3.23.1761650916736; Tue, 28 Oct 2025
 04:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-34-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-34-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:28:24 +0000
X-Gm-Features: AWmQ_blaqYebQzcX4i_PlHCcSOSlDF3xL7lkNlhwp9KD5JG0uFwgQC_SFmsNDxo
Message-ID: <CAFEAcA9bTmusgWLvzgPW1Fh1Pzvo2rD6+2Qbw1TahrRybyT7Hw@mail.gmail.com>
Subject: Re: [PATCH v3 33/59] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 28 Oct 2025 at 06:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/hvf/hvf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 16febbac48f..c0b2352b988 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -76,7 +76,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/accel.h"
>  #include "target/i386/cpu.h"
> -#include "exec/target_page.h"
> +#include "exec/cpu-common.h"
>
>  static Error *invtsc_mig_blocker;
>
> @@ -137,9 +137,9 @@ static bool ept_emulation_fault(hvf_slot *slot, uint6=
4_t gpa, uint64_t ept_qual)
>
>      if (write && slot) {
>          if (slot->flags & HVF_SLOT_LOG) {
> -            uint64_t dirty_page_start =3D gpa & ~(TARGET_PAGE_SIZE - 1u)=
;
> +            uint64_t dirty_page_start =3D gpa & qemu_real_host_page_mask=
();
>              memory_region_set_dirty(slot->region, gpa - slot->start, 1);
> -            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
> +            hv_vm_protect(dirty_page_start, qemu_real_host_page_size(),
>                            HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_E=
XEC);
>          }
>      }

I guess we're guaranteed that the host page and TARGET_PAGE_SIZE
are the same thing here (so it doesn't matter that we put
the assert in first and then fix this) ?

On that assumption
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


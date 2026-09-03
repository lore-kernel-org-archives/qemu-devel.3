Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE03C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29aX-00057Z-2B; Thu, 03 Sep 2026 11:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x29aV-00057E-I4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:42:51 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x29aU-0003TO-1z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:42:51 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-85a50f6a7f7so31287537b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450168; cv=none;
 d=google.com; s=arc-20260327;
 b=rL/UQhNYygjTotr9xsOCVb3LKPPPBc9kREax+KbriObbxYdzrLmoYFUm5r9F3XXKui
 qxjpUQdbttZlTMrDV3PA3279VJkAbiCECIZaWys9iKxDt+JmKhAUusvGNCj4c6CxoOdT
 zuDbVKffsp409j4N7wG1cI9CqnQ7Ap1qUYm5A4d8vd/hgi5z4/iUcUpbXnrahrfI01Qa
 febLzULF5qBTltiTFQL3sZjbvVPFO3kb5cSXotsmExspZ+6rsLkStVnVuX1OKfVaPHzs
 QRDHqlvwxMws56h7Br4LWxAGSoC1VL//kRIwnUDYM8CXswf1odnQ8aUq4iWD35GEhs/+
 qshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1jB3PxcX2tHCmHDECQT4wbz0J9iq/+0Rmnm7KAuKqNw=;
 fh=9fzg52J/htQ59zCSi2e3VF4o/AixYBOvNnnygR4Bf1U=;
 b=kP/0oWsHNQT79ztyy4P1HFKmBDudWXHUH5yHyPRWpkaeJLPBkFDeCn5lrtmYj3tDfn
 y34QH7Zhg8wMVIZ6CZIuzVGQRKz3iNUdJr7bGcw8gQmfYwB1d8xA7VXBM5nS0mz8fFxL
 ZpIXj483djzBiKK1ceYOsZ4hDR+VTbq7KfAT6bf1wJ+NCi5RS1nC8WP/KX2Ii2Xiydbb
 0EE4lhCYz/wysZ2KupMSb8pWBI0Cqt9qG7IqnZh8foYMk2CiJXdH3rtD3/n73vdJ1vwU
 YwCoaxr4ksAv5QrdpdGnGqGLiEM7eDmDfVXnwI9CbTGDYQBIXZ/kMytBhDDzVZOmBuUJ
 B8nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788450168; x=1789054968; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1jB3PxcX2tHCmHDECQT4wbz0J9iq/+0Rmnm7KAuKqNw=;
 b=GhCsuubJWZQczJ4xTkrHQOn+mvB2Lg++uCWk7EkWJIIizZzTaITFlGeT8oWe0J0nMd
 3VBJwsyxjKP82CpFwhvTChFrTA0G3tZdGt3/+qAVUg7S23k9TCM5Tzk2uTOciLa9FpKc
 F9YECQWnxR+dhNYwQbZxg6xClKZLz0tGaJaqxC/npJXvVF6aI3ycc3zzy/6NiienTWL1
 en0KU/JA0q1UNLo0/9iLhnxMz7yEoE7PC4gpyjawkEzkeEWGV49KrYSNdqBFI8iUp6wL
 UEz4qw0MKsQzQWn6oa1cmEOMRwg/RR+mgTX0m0C+uCBkoLUziQpeXJO6m2sscjyxwOeM
 rUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450168; x=1789054968;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1jB3PxcX2tHCmHDECQT4wbz0J9iq/+0Rmnm7KAuKqNw=;
 b=RzKBa8hK1xsWp+Fxxi0mwyxDrj8sZyaeRqgmAsFDlVwoIIVDv/VvIzNspoRVh92JlL
 X0WAg9GUkzPLW5Ggbu3jC4aV5IDre/Ko2+htAjbozRIflFCE3iwEyyy7uWhxbDSQ25nH
 wDX9jV2eEeE2YLLws+oCMsufMZgy0a3Us3VbKVQbHmWlfuSbxqe/XMrkQUxdNiTdmLpy
 xVGBbm+Fa705v7QA+6fapIV49hf8JCSBklGMTG44DXn88tpuTMrA2Wrf264prDuF6amR
 zEhsJRGiWUxirDPUx0fqEhMBG7BbTzSW0Kvo8p929ddFbMErS5iBXr1gytbfkcCzaUEo
 W+9Q==
X-Gm-Message-State: AFuF++m0LB9PN3nQDNGrKbepDA6PfP+txuVLQ9a5HIumry8f15QnKolQ
 5sikoGDs89mmLAi90/4yVU1ojgkOi0BPEjn6G/+oBRGG6UYoeQNnMcT+anFc4EKpZLLDaNJPPei
 EXy3BR6nuk8vHi/8gvkaJE2fhrQk3NTT5k+JA85jIfA==
X-Gm-Gg: AYBFou2It3opgEzc45lleClUKxtopXKIujFHzoaZi3tlMrgwkqjgjVcCPA8VNrshlTi
 v9/JrCosaHiHczD9ckiKMSS8Okw3RPwPEBja3At1V1gey8Vg/RF4j63ImktWLl2YEx9E7E8Phcj
 9pJl8ORKrgg3tjPvAU6cIaI0Z+nhXiuFT9t9gq45QYDHGUhDJrgwDiGcfbEpzrHqkYyYJNUfmqc
 kgZ6DfUQm1o+h40cXy7W83yHg2Kpjx2X0SmSdrf98j7cQvWtBdkXiJRV6z748+dUUymVdOJAySm
 FuG7tn7qSbmOE6rEMKt71EKsGUnKDKk0iACafrxOV/jyLsgKmhDnvEAiBbKYp5PCRI4vrX37WMr
 XTQ8knS4wMv7OfteLR7a+JQPgevtT
X-Received: by 2002:a05:690c:385:b0:84f:cd89:30f1 with SMTP id
 00721157ae682-86c5221a9b2mr64338957b3.18.1788450168129; Thu, 03 Sep 2026
 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 16:42:36 +0100
X-Gm-Features: AcwNN1V688dIVPb1MRDAXsgGa2oWE5pMwDwoCMhiT6oHwFbOJyoWPkc6RiQxnBU
Message-ID: <CAFEAcA9v8L0LzW5BFCXVGGNCiao+dTugyTc1qJMiQ42rcEXt6A@mail.gmail.com>
Subject: Re: [PULL 0/8] block: nbd patches
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@openvz.org
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

On Wed, 2 Sept 2026 at 09:49, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The following changes since commit eb710c255642cd7dc947f25c9a06c9fc8191e98d:
>
>   Merge tag 'firmware-20260901-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-09-01 10:38:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/vsementsov/qemu.git tags/pull-nbd-2026-09-02
>
> for you to fetch changes up to 29ed9606ba15aa346eaec349d169f90eff56fd01:
>
>   iotests/nbd-commands: cover the command flags and sparse replies (2026-09-02 11:39:46 +0300)
>
> ----------------------------------------------------------------
> block: nbd patches
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM


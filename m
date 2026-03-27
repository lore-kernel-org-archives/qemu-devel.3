Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C65A10ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6802-0004I1-E8; Fri, 27 Mar 2026 10:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67zl-000423-9R
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:17:11 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67zi-00071S-Nq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:17:05 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ea73e7b60so2284634d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621020; cv=none;
 d=google.com; s=arc-20240605;
 b=UtgLwuIwhEySsJzRPIOn9QEms9+tnDzu93cYt2N9fY1uAk7+rl1IBmXgAUyeH6W2Xr
 GpotclzZLUIxMjwxpw91Awr8BFqHeCFWZioLvtZ5GFiZkLmsC9wXq6gA3inh8AkxfxCD
 eFstYEFq6aprg9+t1hFaDEY8Hbfyhp37GAFVVVD+ueb3be7fplIgMkX1NAI755YtpUyR
 Xud91wctZlnRnp+eNuNsNbgPXH+yctM1N+N8pqWiEjZg7zobBtKZUfztgBROYJd7yfBC
 mYfGCjX+YWyFP4rSDi+TuBhE5T1LSEVtiyRQaNef1JyY62oOK0J/FB4mbqS1NgeDp63u
 AAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 fh=x7XN6cv95u+8ZA961sYH7WNfgh/ehXlGGYvNbvVxSj4=;
 b=XdSVrV3zh0s7XvtAOMJOfSfZ9My4Xj42PhlwYwOCz8Yh5p6/E09XZ4D3kNb3uU1zPS
 YoimfaXim5gO+4g6sPt51zDrPlkTNBibHefHkkGBk8Zr27WlAWweigG/ZQjlNGrUnTe0
 35OXavBTUDbx4o/VBrfSTex0oeKydftYWyD74PmdGKtXf+F+SdHu8w5VokyPAgRxEWpJ
 Exre2czzwIj8GHFq0q/hjzopOC8FBAKvD3bhJQd9aUgCIOkBUkCiGfToTFKHDHo2qWDZ
 Ygc82eJZ1wagiVMhaNUIO4vuNJ3PKPmEakg3CBZLWpWsFQVoQM2/P7G//aaX1SyRfLiI
 FMEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621020; x=1775225820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=QWxbEsIKfgQWdXsfp4PfkcB44g/WYBIJMkaePaGl5nCbn8iDhpjAomKxB/aayHSIzQ
 Nnz1+8Xp8+0rkct59q0VOeR1mybTrZTNCOSgtnmSIVbVSW8H8fz3kndFo1zbgDH2R7No
 SxJ1e0JST2mCf0hhs2Vb8hVxiexqtMo47LX9FNm4r1rC7FZo8DA0n5nFQv64iDQdIHl6
 xCsX5zYUdsmc7adwgr2qgONJRWByOCYIO5J8l0X2/y4XMCVhKAEksgcovga7ksNDQEUE
 ROpoAD70m9WIqB/2RDYN0Jsz4Jy0a1R6EvN1TMMJasLCRhJlJ0jg9VB+mIFNgcpKNScY
 M92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621020; x=1775225820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=esve+reIugJX1VwJ3tAvLXWi7zQD1pjmTRWQaFQW+sZuWX4gc0r+a6Zg456rFl1G6b
 uTdAUmyhZlX5yJeWKkar7ENQPdbb1cTyCT7x/sdbB5L2V+u2yGkaE/Z2LhK3uRAdOj8s
 tzAAbMqNFffIzS/UPbq/6PpprounUQpl9JPqPaFg6+xfNiZHFOqZnw9/03Hc4Q01J1fW
 B2JhaFhLLssYBG9dL86Ai/ee7goJMBga8QpBfXTPeewTiBszqVJ2PKkapLOCbqXasU7t
 KY3iUDoJjB3uhAHERXByEU86utRf3VoOOi99mTvmBDhKd06baK2pVa3HIoYULyEvxeax
 fMHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgsQ8+WwaBgLmj8mLO7LGvqsHD8UzBRwAiR0Yl4/KLNyvmuS+vAq+HAgzc/jQCXkTgH/znBBxV3DJ0@nongnu.org
X-Gm-Message-State: AOJu0YxmehzCGNZQkDVPthkgXrkUK8P81NSE7JQaWxbrnHCbDty6Flu8
 aLgVPU5v1bEa4n5zHFUGl8b9GoArLgGN5PZzcBzWAZLzKnydYwiVXd+ln63PEKc/J/IwI6OR/e6
 DCf5tU4admgXoGVvhCd70H4dS/ZU6sgahQ/C2QaTY4ICAU7OOysK5F3U=
X-Gm-Gg: ATEYQzzOyomxm/g3zN2zDgGQ30fTwnmGBp7VFkCUjp0sQSS8/j+hut40eIJghgwSiy5
 ORrUEcDD6kI8erPboiH6W9yxgB4k0fGJ1quIa5Dz2/ZjAsvjOlq5E/bqLGBEa856NrSBtWyEvFb
 1V8wIrxU4vonpyGGpJU2stKI9gQHXDU7o9/6jocS7pIkjUAm3wUc5uQF3agdfWhHQcNJUYRpbwJ
 uQqRujITTTQ6SL2UoygazHkno+ev9ZC5G/rWFmJIr2s+kkgu4KZhHMBDsemF+YtJ2kEDOu5fBZb
 64jVHvRvTTERNCKT48Le+3o0yrJbJtR+KPgJ5r50XwJJ697zsfo/wN3yzuKH6P4OlZ8=
X-Received: by 2002:a53:d044:0:10b0:64f:eef6:d0d8 with SMTP id
 956f58d0204a3-64ff73cb7fbmr2189544d50.50.1774621020394; Fri, 27 Mar 2026
 07:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-9-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-9-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:16:48 +0000
X-Gm-Features: AQROBzCx_TpmN_iQdg9I4DMWr0nbkXMk-IwFbnaKbQfcHiWDnsRxVjwQg32y-do
Message-ID: <CAFEAcA8PU+TR3zKCWSD5UbD02Z4rK_cEpKSttKFOeXzrau-b8g@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] target/ppc: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


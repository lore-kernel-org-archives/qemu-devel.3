Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FAFC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD58r-0006QA-MI; Fri, 31 May 2024 12:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD58p-0006Pk-Ik
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:30:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD58n-0003FM-Gc
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:30:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5789733769dso4098636a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717173004; x=1717777804; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1OSuPae9fNg2ZqT0Eyj1EM6P2eViE0mPDzODIgCGik=;
 b=MGaqVjTbbvJio3F+IvXxPme0UK80svk4S4v+fOwoUtA4RREK+Wj7qN4PhBbvvtP9ha
 wOYogEQ7SW27geXPAU5B8krMp4VWd2ohArX/wm7M+g0/d8EyVIV7eHNAg/A9X5unS/C1
 OQikixwmlRB36etZ7YofbjK63a+Q6RXk4mgnE94MXCLF9kF5p0bknoC+On4PEaZBWaog
 sg43+rSd8ZELHx3mzOrLs57/E0cEQ0YDXNdN0kUwavNBvYB446DJX3FTOpHmnx28AfP4
 HOh3nzzp+yudajF8Dsg+dda31QBEKQPgR7q3/XojBLDPCJdeY2psYrsF1QOOv2VWurVd
 QCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717173004; x=1717777804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1OSuPae9fNg2ZqT0Eyj1EM6P2eViE0mPDzODIgCGik=;
 b=gF+EqFj5uLn8EqSk/eAk3qPISxIBiFc0PVmt5S0X5xFpWC1fC01qJHmrp/YTWZtv3M
 VNHY6adTzWNKW/nhWq8mJYubIM+fB0TBPgf+c5Lro0DV3xGTxSb9bGsj40IVmIV1YlXT
 EFb1EDaNZco2MdcYG4V0NIrrj9UY7pj3RpAIlxti4LDAGQxuEOm/V0cBct5Z7dn5UDVR
 KYMC/ETOTyP7QhPumt3HyQxF7L30rrC+PGG1HCL3zdRm+kLDk5ulpuBa24OTx7bJyrn2
 G0yvxoECUZXtEYwKP+30zUSzQkaeZBG2bGBEpY0tZbgNTCl7/gcEgY966LmXQYSVzNmU
 4kgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ddpw5nNfkl+AiNEpO8pBpnT0tOGW/MgD5Xzx1cH6dK7iI7GCJ4GdpWtZxe5Rm0Tj8YERV3PV0x7TS/1HnPmP9JY3E4o=
X-Gm-Message-State: AOJu0YyV1wGFyd48AKi9oyL4Fg8nnhTPIM4GRjzROajTzBtCYFBy5i5L
 rY6wkv3095JK5/pWoJ3mN9SwmmNl0lP3gFuqLByq3e5tSe7AqlV0RvVLwFKFcP4ZyYgP5e3M9+f
 Jd7nP3B5zimCfvbx9+rAo9UgRe8VoUykTNwxDbQ==
X-Google-Smtp-Source: AGHT+IEBRpg/D5ttta1NUDjGeKgBX2146HbsQh2nWshGrj6Rt77OKTyL3zMIBuYtS5XZjs+HKPNq6pfKlitnzOQnFws=
X-Received: by 2002:a50:d541:0:b0:578:69be:6e7a with SMTP id
 4fb4d7f45d1cf-57a3635ef9fmr2242518a12.1.1717173003975; Fri, 31 May 2024
 09:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
In-Reply-To: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 17:29:52 +0100
Message-ID: <CAFEAcA99pA+jU8kd04UMs1-OWPn+PNjNR9djFGFEqn_4RWxaog@mail.gmail.com>
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
To: Ira Weiny <ira.weiny@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
 Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 31 May 2024 at 17:22, Ira Weiny <ira.weiny@intel.com> wrote:
>
> Peter and coverity report:
>
>         We've passed '&data' to address_space_write(), which means "read
>         from the address on the stack where the function argument 'data'
>         lives", so instead of writing 64 bytes of data to the guest ,
>         we'll write 64 bytes which start with a host pointer value and
>         then continue with whatever happens to be on the host stack
>         after that.
>
> Indeed the intention was to write 64 bytes of data at the address given.
>
> Fix the parameter to address_space_write().
>

Coverity CID: 1544772

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
> Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Compile tested only.  Jonathan please double check me.
> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e42490b6ce8..582412d9925f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1025,7 +1025,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>          as = &ct3d->hostpmem_as;
>      }
>
> -    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
>                          CXL_CACHE_LINE_SIZE);
>      return true;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


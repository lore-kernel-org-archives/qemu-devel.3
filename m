Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7386CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWVzp-0004EI-5p; Mon, 08 Jun 2026 05:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWVzn-0004DS-Lp
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:10:11 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWVzm-0008Kr-4L
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:10:11 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6603246b66dso3985795d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909808; cv=none;
 d=google.com; s=arc-20240605;
 b=HyeYQRS8QNc+WW1D0EF6YIUaI/ukCHITakdawYIMdr7vv2xPgIHa8LOfmIFbLVIDUZ
 hjl99ROzlyCWc8i5pFQdOhFoCFQkZiTbfhzs9s1whiEdCbC8HzPPG/5vnPpyODm/Knf1
 HmXuQrMz2fMExiwSIR/6nj2u+gnyyiFgJXQfKvZu7YCJ++EaJ+68yrceIV4ylsvuHYGV
 YMEecgrVg0S3q0wI8AHupH+vEBsL8j03ZHrhSLx6QUejdKEQ3Q8vszT69W1tvLcWjPa+
 6YoVgdr4s9oK+GL4Pa1uuLj/C4LYeoGEP6r29b/TvfZewu+LgZwzWfAxyEBA7qt8umUn
 7xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GrDzp6SfLNsbZGWBPbTmnNytK4Ab2Q9bBY/o2qmsChg=;
 fh=7wNcu9Iy9yglQAbHXXe+bD33hnedq44ERobr0xTOARI=;
 b=eeMlKYWNs5rdqhR6AsiuoA0Gg6GYrMoLY8d1r7+UZQDBL6oSzexyMiHxXwk22Emo5L
 DJt9OH3XSQs86MQklj/N3L1lzULgxl9s7vBSucfVdfSoNrU0620uENfuaC+gi1LPvUIM
 oylfpv1XXodyglBklG/W/6yyUfjGa1rCNGiQoHz7RHoNwM3hMh0+ZjcgtRZspm42pJNg
 zNDdzdjWsbX64ykVi4lj/iXFxB/wqGKWSCmGLnD3TtKezgm95PY/KAUlcIASlu7l+bQL
 kqFzIrJlzi8LtdgNkeAqYW+zlIJctwd3WBLN73hKR0tXrPnyPfm5AkoZKhQXicxpZJlV
 8EMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780909808; x=1781514608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GrDzp6SfLNsbZGWBPbTmnNytK4Ab2Q9bBY/o2qmsChg=;
 b=QZRhanS9HQijEDHU6vGn11hB/D3OHzK7AoJDa1V9a/By/lg9rxaDAFftAnPJHYAyqN
 BSv5ZTZtJKzCw23ptZwwsKBGnVsyOwJG8aMwk8knNi2Bh/72KCIa1+OxgBBg0Lt2u2w+
 admGri28Qil0G1kJX4wdKLqjnC4rba9SagVUlLNjUPNU7j+ioL5TWNKzsJEymRC2n7TT
 86L7iV/MrcLmObbZ5cwrbrsF2cje4Tu85lyvmWQ6hgyLF0UuirIuZVCP8mt2sTG1yKmw
 LLNSHpVxKwxGVN26/99cX4ODSnlFe+soiJOkz3LG6qjP6X2XN8m8vpvzSB5ptptdrA/i
 fzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909808; x=1781514608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrDzp6SfLNsbZGWBPbTmnNytK4Ab2Q9bBY/o2qmsChg=;
 b=i4qb8UzF+hks50VOTf8Hi3w1OQ7btqIlnngPHYKWfb6ui2nvlx6R4py1Dbsqu2ZPcB
 cdk5XgHSiiKx6rvYxdo0hYxTrIShZ7XX5OoaVRUkIvsklw0EzmjAjNn653IgSK9S+9UJ
 eCc1Ffwn8gYsuD0JQpJ3DPjLsR8sJdhdBxNXUwZ7xDBliCebWx3HMnghi51rwwwd6yqc
 RkFC1eADQ5pP6TLvRqGDC5O0DmGOtAGPPbYaUsfPn/KhE/2Kbegpkgm3pDtRoJHIHwTh
 ZbtzY/1o7W4OsETZ7h3Snyw5qkjgfxR7xD9iVyPSFHVxcZ8YczjDfDsuMwbbptuqM4i5
 moRw==
X-Gm-Message-State: AOJu0YxjuDnbixDNNoODT8Ye23HuBZSZ9V3RV1AzpSkmEqNYG9p0x3CW
 F98hoMYbFadEV1s6zj3qHJxGKe7jOt5A8OYApiqaa+XmPivrzKA6dJrIhsCLPqUznH3NBan57Ul
 V9+xf8n6wiJJLyl9E7gUgE1yImYuKbhNjeslqGBflSA==
X-Gm-Gg: Acq92OGSYVHcw93sGiS3eibNnV9JYQCcOq32S9n6DngKXu7o7NKQuniB3cBPDMtL75C
 FdfoTG3DjUeRkFiDjv0Z2TbQt4/cMaGB5emwk0d3tCp2nxw9PLqlDE6XuxU9I7Bb7un/fgiiuly
 U+Q4qsCTuFiFRM+jxJ2NH+6QevRg1VBbkrKwPJGxQ4rTMqcpVMigdo5Fo2bQes974CRf29BzzLR
 4KPt5Nsg9VPxEgUAYeYtPHdXfDX5B3ru0JDIc6johkzxvIyd1izq+Su7PgRlY75t2vn2ssUyJ63
 GBNh8YAqdk/gjhCYY9smbfRAVlmYWKGbanrIvjPqaanqCbzkT1wQCRG2sHmYrAJWuImMQ1rIu3f
 Hfw==
X-Received: by 2002:a53:c84d:0:b0:651:bb21:e7fd with SMTP id
 956f58d0204a3-66106f39d59mr9362363d50.42.1780909808421; Mon, 08 Jun 2026
 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:09:56 +0100
X-Gm-Features: AVVi8CfqFCisp7q2GlTiBFvRzSlC9cXj9twjmXqjDembsHvVYNM5bqlJg5hI41k
Message-ID: <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 2 Jun 2026 at 20:09, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hello,
>
> I decided to propose this change after working in a RISC-V gitlab bug
> [1].  In my proposed fix [2] I had to make assumptions about
> address_space_ld* error return, which is always MEMTX_DECODE_ERROR, to
> identify that in that particular scenario this is a permission error.
> In RISC-V (and from what I can see other archs like x86) an ACCESS_ERROR
> due to mem page permission issues will fire a different fault than other
> errors like page not found.
>
> The core logic is on memory_region_access_valid(), which already makes a
> distinction between error reasons when we look at the qemu_log_mask()
> errors, e.g. this is being characterized as a 'rejected':
>
> if (mr->ops->valid.accepts
>         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
>         qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
>                       ", size %u, region '%s', reason: rejected\n",
>                       is_write ? "write" : "read",
>                       addr, size, memory_region_name(mr));

valid.accepts returning false isn't a  permissions error, though.
It's for cases like "you tried to do a byte access to this device
that requires 32-bit accesses only". Permissions errors are entirely
in the MMU, and don't appear in the MemTx APIs, which are about
transactions in the fabric outside the MMU. The CPU emulation
catches permissions errors early before it even does the
address_space_ld* call.

What is the equivalent of this in the underlying hardware?
The current error codes are intended to roughly match the AXI
bus SLVERR and DECERR error responses (which are "we were
able to pass this memory transaction to a device, but it
rejected it" and "we weren't able to find the device for
this memory transaction at all").

The valid.accepts callback failing is always "we know the memory
region but it doesn't like this", which is true for all
memory_region_access_valid() failures, so maybe the problem
here is that we return DECODE_ERROR for that case when
we should be returning ACCESS_ERROR ?

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E571ECD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzE1-0003NG-O3; Tue, 09 Jun 2026 12:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzE0-0003L3-8I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:22:48 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzDx-0004G3-TP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:22:47 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so859307766b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022164; cv=none;
 d=google.com; s=arc-20240605;
 b=gZZu0fgzyKfrsxruBcSaldTRp91khGsxFzFlh8aQPEdAez91zRZdoAH435HI70Ycm8
 8qVM1BqgFbRFSG2+OXNq2KZJnEXy46OU5a/7h/twjLSFz5NM/GMOo4tCFhBSzcozmUHV
 AACoaSmFdl+gswRdjyRv6OZCMX6ZAwhcG9M0MwPPW80kQf4Jxo6VtoNW7SLJ1Ek9w6TE
 WKRvuW4cxmW/s/eq+m50nYdGhlbDqtAVbDJnpOmV5x5YHFp0vEOTTht/W7uBFT7AahzG
 ZZPIVp539jnDOt8xF1DCnmzqQM/f9W1tk+xpHBgIzfgBDv3HTNpDD9F48NGvjKP3PdYL
 XC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b55qrZn3PPWJBOfP5dZ1VSqwYMF3HjMRYZZ7Ug70UEo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=SPUDdAqCXlyDS+vk7srKvN84k8JbgqNipiiQj49zmlgIxMr8CDX8y6mUM3pC2BibSe
 2V8XXI98iVx1/F1G/NfpA9aKKbBeirh2fwP61TWn3jWJkR1wvJBnei90pQ5CCQs9nJdS
 I2WD8qCDDNgotjc+tLRFjZNzah5RtJHYNo8ZWm9yjdaWxA3NR2XX2xLrQU9xiLVHpbbq
 yXsZd71+7R1Ijr9yQFFesUsjkk9XTE/hc09pvE3dRuRlpslHVn5ZRhjNzD+QlN/elqKz
 6u4lzVsneWxze7yRSGNUAC19DXzaqjtRbXFyd2YYqQ8BrYO+7AGIFxdVvFYZBlTVVcPB
 7+4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022164; x=1781626964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b55qrZn3PPWJBOfP5dZ1VSqwYMF3HjMRYZZ7Ug70UEo=;
 b=bCCJV/48g1sthwBdNwth5roG6AvqU+hhQjOmAEWJijiZWVnD2c74PeCnNqE0DOkQzk
 +30X36FECChZVjaARFPo2KAzIq6NAUGOPSCzo+n+N1z5auUUKphJ3+H1TYMBv9MkTKIO
 1ogO+uL4wUOeUcNkOEKijJoBpTMjyeqj20cw22SsMqQhblU20O9xEY99FZhsbvKc+EOE
 bfYZJDlYQ6aCRWJCIEvWfwEbPOUYCa+C5M8dH/M792AFljdXzYvIuMdRNF4hjgrUQ3SC
 VYf+xNjuioB2JJN8nAzmUapaxHBV/pwX0sZLtFCfWwfwwGXvmZ2oxfuQNN1wIGVVx1xD
 WPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022164; x=1781626964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b55qrZn3PPWJBOfP5dZ1VSqwYMF3HjMRYZZ7Ug70UEo=;
 b=ArwMNP+dN9aHKYTaUZYgRF0T5nuyO/hliQrKsj8E7p3XbtuU0EbupiFnMijJ+tni9I
 kVMQDDt8IEluLtvCNj/ZuHG6F8jv8NZZ09TM8JpHwlDRPuFqsoitQ1zdXucIi5wsuVOU
 mlONQp8q/DvoWeNpruZL4Vp6xjnslBz4POxXVhanCcsVBbtHpckzyC4Od0gUmBuYcvKO
 ATRy5FBe2KG06u2XOGF8CH16VbkU061DgJGVggNw7hDRgoEA7HL9tDHtVXgvmTF5ZSGy
 kK5MP/wXWtbOk6dFF2vt5oUZmd5jWCoB3w4GlTGUeFEHxF/LNMb+YDTjvtnI5QOqyppy
 xdsg==
X-Gm-Message-State: AOJu0YzpteHTdFvQlrDz/fw5AW/cBWPxM1mupLrquHYj8/6Pcz/FUT2v
 o2OtVrzINtau00wja8082USDCpnhkVCPBO9IFq0N4R1AX4/nE6DPA+M6gnQcQQCoVjZUrWnhyna
 BKH3oy8ZDxE7Mm2wECtd1kHXdr37gjPhToiRI7U7FHA==
X-Gm-Gg: Acq92OEjrH/OpLQDe4TpxMqmHHjYEHHe8uNUNS1AdUsU5VYscaVoCpHnNvYJwHPojP0
 aq6s3+FCGUj2ITF4iGAMUNtqLPaTSO4rfV4BPIMXYy8QWojooAba31POdgh8LZynz+MFbNY1dUe
 uUqkirvPDQ6ws2zt5MVK+vN7Zbe30eXHWFbXuuieXQ9NAJ94yRipbJwC+np4UxB4UXP8JPlRN1e
 dJnq43YgQ92ePKE4nkPxvSLZqIZRmNYdzV9WNPzeB+CbIMG33jYNdZqZ5ZdmiLs6WKpRtSmG82B
 +9Y8SCiYtV4Vgx+QMyS1qede53dr0JDWSp3WY7/tvOfYMMUmNTg5Sf+RT6D3vFWcorwt9iZDRzU
 odA==
X-Received: by 2002:a17:907:60cb:b0:bee:4562:32fa with SMTP id
 a640c23a62f3a-bf3708686cdmr1035838266b.14.1781022163934; Tue, 09 Jun 2026
 09:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-42-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:22:30 +0100
X-Gm-Features: AVVi8CfqO5sEvTluJCrkod0JYDEyp1Yap0_ZT4d6-EiDDUngLnr-n7GCceoq_qE
Message-ID: <CAFEAcA98hf5CZkZpaVZz2fnCq0yxt9RbrpDxGswxn8_RM7qUNA@mail.gmail.com>
Subject: Re: [PATCH v9 41/45] target/arm: Implement FMMLA (FP8 to FP32) for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


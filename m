Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB95F54ABA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52DK-0008N2-CB; Tue, 24 Mar 2026 09:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w52DA-0008LN-7H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:54:25 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w52D7-0007LQ-GS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:54:23 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79ac5de41d8so6521077b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774360456; cv=none;
 d=google.com; s=arc-20240605;
 b=Ni8HT0hiLa/bkzIADthbK5fSMOQjk/1OspfWVEA4A+veKedfOMH/wnzqeEyrMUk3yX
 b9aBpoBtUNJkC+WOkNnY8Qewo0annib3luxTcfBNJSF+B9RnL8sSre6cGGxigGsieEWs
 UjctR99TTS6UKc2C+YLJoQIkEvOunL2HhLXX17qhIrsV0XiuUDQBxL4GPI3gpTpwQAC3
 MOUBFaGgcNuJsOSSsrEfCOTTisVrKX5z3rznnAui1EAtNkL4IHoJC4XqYD8C0K+9luVB
 8Crejzcq0dx4mNBjDSV2TurBN11pK3lRDwbDUXUq3LCrrKXB5OHSlduUJINZHaR0ea57
 oCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YUGNwSQdAVhXLvGXKesSDlNmZVu9KXTOjexyuPzmt/4=;
 fh=tz3tCtkSjLPshsF0qmCdaD4Sit4q9rcrvcYWO8Pjotg=;
 b=H9VktgC19iCpTw/CEiX/yI4NNSbQMeCvW7NDp+JSldQSbbdhyB46TY/nSKri0eOuvK
 MiSMP3hEz5VbpS4yELOdeVojHkIMXN1d06jsn2LDHh27LsgM3Dlp/kP1iBILRr3IKjMv
 PZpiLoovSmKmXRoKGjUBnO0GEvoE+hp+8D9S5nqytD4LCiwXQPIt3JP89mZhcl669TMi
 5KWerHsF7UA75u9tlo22RHxGRn4YJUCaOrk1A/ujW1WIqjEIqHy+FV1II7VzqZDkFM5X
 sDl4BIg6sTaJnEf9SegzzYvLlenwvJSTopJokp3fIvUCazSfpWXaA3Nsm54WHVoCw6AH
 7VRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774360456; x=1774965256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YUGNwSQdAVhXLvGXKesSDlNmZVu9KXTOjexyuPzmt/4=;
 b=MtG1MP3P0PabHsel7bUjxiZPOnx1tRCJDbA09QXdGuxW06/c2M1Vzcw7jwZpY8T8EW
 Ia5W10GGaQvjACBdmjaCKKO1os6fzo8N1UChVTTIFpTTPOBT0WY2V8q+m8GYWJc2GERx
 W/zuxtvMrT6+H5oDIuYUSbX0kpKYWKt8W5SGY3aXBgtRcbM1W64T60R0N15cWg7HFJ5L
 Kvi1ni3Od7lprsnnSqsWaLr31xtmEATfS57/a4JFfCRWATu0NtntHlXEXCXz5a1rnzJJ
 sBP1Z8Mp5JFnztJLS1GhYYiIolqI45S49KpJW53i+TOeNNqfs4zpi5/o+zqgXHYFkLyO
 SlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774360456; x=1774965256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUGNwSQdAVhXLvGXKesSDlNmZVu9KXTOjexyuPzmt/4=;
 b=mnL6IQwHabEEEeKYHtZQcNv3IiQqfEyC97WJFWNURMMQeDBysZmSRkBJj7jQpjF8AU
 tTaqHU8+g76ZQWlLwZbu40xX/lR5qCbCZkjZr0ZARVA6nlA5TKX+MVLKWbpOsyCqM3Kc
 Dr09xzC2LXHKo8Agp3CH0+wGtsNSgoBh3JRZF0l6pizGHPsKH/oLmif8Kk8f7wlr0qwu
 zl9KCdJX9rPNCxGvMRBjSlcQauy2JEfidrY1KHBP5LfVYzUocaUzGCC+Ahz9oS0C77gw
 Ollc1pAm8m3KCUlBVSnOAtvoZnBYEWjFtrckcWRuFdBOElzh3gw1fOgKSX+BQdZhArV2
 b79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHqrp9NsybBK6DoknIL5iTKWU9rdJ7D+iyL7t86hMvuNBnYQKRGv4LZ6iYJfJfRLZccxv7WhSHQoP@nongnu.org
X-Gm-Message-State: AOJu0Yz/MSq6CTQlJ7a8GPBmk7QHD/0WWvEGXm8a5id8N9Uo/qh1/Plu
 0hpwzyObVLakWRW0ze+MdjbVNJOad8kcI77BQeAFrr0SdRqgWUUVItq0sp68xvyL9Ui6gCGLEo8
 9FahiR94YqsPLFCPWW3nAoRpylKDNIRhKH0WDO8VNYs7FloSqP8kiyi4=
X-Gm-Gg: ATEYQzypHvCS4GtgBZpxQPAj1fhl6cqC1K7hzXwT8ocYD4PMfWzMYPxZXrVf5SByRm9
 f0r2AEakVqtYWgNim9/36KKAOb6VtdyNBEt4QXR8T/UyyYOLekTRccAvHQj9/kxMEuT1Zl9as+X
 7EB/A4iyANi6fuqhB2CELUlu1EqW1AV2CJQv1pLEpmm1kiYKi7N0yA4m0nRIELXOz1JQ2qg2U3r
 xceRp1IZSLO87z/IrPrDXxg3dPF8nPZrxJruyK3iqj1V1FcGOWxi5+nOiqt5bTLSjJtdJuF9dv4
 4U6YPt7nSc4htB+2sb+HUY5X8Lomdo0m2LY6B7aZtZUO6dCwfPT5SJfPDYLNcxKoRzo=
X-Received: by 2002:a05:690c:82:b0:79a:8895:9b30 with SMTP id
 00721157ae682-79a90b7ed13mr159770207b3.30.1774360456326; Tue, 24 Mar 2026
 06:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260324135026.247418-1-shivangu@linux.ibm.com>
In-Reply-To: <20260324135026.247418-1-shivangu@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 13:54:04 +0000
X-Gm-Features: AaiRm53iSpfFdhHdyGEzV49A1SHtOSZo8GapFBskve1gYJMBD04U9QFS_w-R9i8
Message-ID: <CAFEAcA_fvj_LZu+BMqW-LNtK1k-agsumTUu6wR0ZKOJJ6R0EOQ@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: generate dtb after machine initialization is
 complete
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 24 Mar 2026 at 13:51, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>
> Currently, the machine dtb is generated in pnv_init(), before all devices
> are fully initialized. This can result in an incomplete dtb for the system,
> as seen in bug [1].
>
> Fix this by deferring dtb generation until machine initialization is complete,
> using the machine_init_done_notifier hook.
>
> [1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


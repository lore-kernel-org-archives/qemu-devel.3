Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F7CCAC59A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyT5p-0008Im-7o; Tue, 16 Sep 2025 06:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyT5n-0008IU-LG
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:39:23 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyT5j-0002uz-Tb
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:39:23 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d603b60cbso47322087b3.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758019158; x=1758623958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cLaIzXe1bxZ8S6CtmmJe0xzTfXrvlB/1Nfr+TRHNyb4=;
 b=i0Zs//F1zDXNemtqCZEVlLP+Ug9L8os2PdFOBMskpYWDeTZc3JN7EEGC3s/MUldGB3
 b2VJia5P+Tvs8AVD3aVlIKgKSgv3hQJmSVm/uP5Q2RmAz1sa/utzNgCFR2cjx85wZSIz
 vmK8mcIB5NFkSDIV25l792XHsSOS5ZDieylYgjWdlPXaDfuNBgI5WehD1bGaLODyMexF
 IozFf+xxmNRO+Pw3XZK+UB6IIsJ9pBfqLaxQK3J4RcgLdjKyhMtF0Fz9EnIq5EWyiufA
 Xy/WKNdixcqpfBweB2WeT4Vf1E6MgyGnhQK4uG8a/za8y2+9W7RXZEHM2gc2cG8Kv0FR
 HSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758019158; x=1758623958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLaIzXe1bxZ8S6CtmmJe0xzTfXrvlB/1Nfr+TRHNyb4=;
 b=o2ewa12p2EdqXwmBw/b2c0cZaCxRD6tOFUAUkRUfw7pe2tJpgJCPyyJHFG20qVb3YT
 0AEzcczWTsAXC4Pbvsjm6wd5vupDQo02YcS7OAEBXSW2CrShUAu/SzXmUC/QwodCzUi6
 VDX9aaR9BujzvDQMzpRKnqgt5tb++S358C0e0WC9HXBHrABA4OMXHMJeMTF6FntqI5lL
 EmrOBzxGCGRvxh7qvZm4tSzh6wRG0+oW7F8HnY9npqdv8zZFklAHoKZuL1+lwqbGnotl
 qodEeQQzyW1zZbvMz/q3Dp2NLzUGQBGTAY+9RcJtQJOo7lw1h9AlpqX0N5D3apkhOCZK
 ln0Q==
X-Gm-Message-State: AOJu0YwS/Cj/bB6ZcbsZE6nY3NSqm8uYTpe7ltOHTFEPdDw6kqLJeGwP
 E0rdU9ETEXtgrkTHVOMmPqYO1kU1zCrgABf4zecap6aR469N2Pmf4h6VwsCfHL9ylWCUUEa4PZu
 AGova9M3/76YL0zy2kXEBsQSqPkMjVlzAscVHKFJc1Q==
X-Gm-Gg: ASbGnctYxPvPzj9XKb2y7/UPiy+XMw/8RdZhId+zo/zEV20wk9ykPZ/scn2IOeYyuXo
 rqJu0fSKH5L1v13UKYrjwK5Gb1BB1Ey1FJyR5A5ay0XUDst3KgPVXfETGZ6nertkX2TTfG97KCU
 77ZTCDU0Uo3xFN0jtSc7EFdQfmqQ6zTHTtUBaSykjMy+V6eMOxFj1RDDUKrUk4pIMPu4SXnN8W1
 /aJTlpc
X-Google-Smtp-Source: AGHT+IGkcIQTSI+IQr68/7DGnAiq4V9+g+UTCOWklrnnYNUed256xmme1A1t2wt90nmLp+Gzcqeg+OO3pSoOhgKgtI0=
X-Received: by 2002:a05:690e:4312:b0:633:a95e:ef08 with SMTP id
 956f58d0204a3-633a95ef4admr253040d50.5.1758019157457; Tue, 16 Sep 2025
 03:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 11:39:06 +0100
X-Gm-Features: Ac12FXzwq8fmDplrKX6_I2f5FjL4smUTsAUoUvWKQA57Q4jZFcqun4qUFOV3HC0
Message-ID: <CAFEAcA-xdREOLGyQkeeE1SxAH+27G9aepjD8jGoEJTbcLrm4+g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] target/arm: Added support for SME register
 exposure to GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 9 Sept 2025 at 17:10, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> The QEMU GDB stub does not expose the ZA storage SME register to GDB via
> the remote serial protocol, which can be a useful functionality to debug SME
> code. To provide this functionality in Aarch64 target, this patch registers the
> SME register set with the GDB stub. To do so, this patch implements the
> aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> specify how to get and set the SME registers, and the
> arm_gen_dynamic_smereg_feature() function to generate the target
> description in XML format to indicate the target architecture supports SME.
> Finally, this patch includes a dyn_smereg_feature structure to hold this
> GDB XML description of the SME registers for each CPU.
>
> Additionally, this patch series increases the value of MAX_PACKET_LENGTH
> to allow for remote GDB debugging of the ZA register when the vector
> length is maximal.
>
> We have chosen to drop the patch related to changing GDBState's line_buf
> to a dynamically re-sizeable GString for the time being.
>
> This patch also includes a test case for testing SME register exposure
> to GDB, based off of the existing SVE test case for the gdbstub.
>
> Vacha Bhavsar (3):
>   target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
>   target/arm: Added support for SME register exposure to GDB
>   target/arm: Added test case for SME register exposure to GDB

Thanks, I have applied this version to target-arm.next.

I had to fix up quite a few style nits reported by scripts/checkpatch.pl:
for future contributions I would suggest running your patches through
it. The script is not infallible so you have to use some judgement
in deciding whether to make changes, but it catches simple issues
like trailing whitespace or mixing tabs and spaces in indentation.

-- PMM


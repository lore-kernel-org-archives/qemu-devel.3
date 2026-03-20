Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263201093163
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3OST-00006W-GM; Thu, 19 Mar 2026 21:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3OSR-00006B-Ir
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:15:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3OSP-0001yJ-MH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:15:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso48221b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773969318; x=1774574118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WsbA75bJldRDPjks0YuI21LqFnkQcYJZaYCRxsKRaj0=;
 b=VttaKhpv3pURayMpQ7Ico/07kE4FYu1DKz4UBaDXFfXlHZ029wfW8kJaVL7GMS27n4
 pHQtsL00Fw+J6d5ImA0XnVKcw3G+fV5OFJr9yQv/kVa4PTikfGQtzPnpN41gM5eUOF6X
 f5+S0YRKZCsVT/TAV7syuGjQvapmtKhI7+xehf3XKLfbmmY2g1kN+sb3M92p4b/B4hn6
 Zm4+ZHw6jMfEVzVat1vEZa1w9Xdra3a7e1ue2fIa9oTn51sRhombMn9hFnB8pz+we+Br
 alyNIdN2surr1v6E7FuHpWF0sSUY4JdOLodzwjwILDp3Vn6wKSXRtKXJ2mgp51WAPeFW
 kWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969318; x=1774574118;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsbA75bJldRDPjks0YuI21LqFnkQcYJZaYCRxsKRaj0=;
 b=Vq8+xkY8eOvDv7ddJcq1anWp7uW/CQc9FWM0ivvMGnvjW2nF/EfF5gt28HHne3qq1b
 yuoDYVw3xT+2RB6NidPXy3BDU7+PJ6Tf4QtENyPmHSY4i6sRw0RWfrFXEHCDDk7EzVNI
 ieVm1cGv1NmGYH9LL1/3gUedc6cFJUkYiMC4syRgaHiuFywYc3V+rcBBvuh0pYHU31Fk
 7VVAP0y3Sk3MqfkrLurs0AIUYgJCWd0TSrN+4EaUJj5oUTjmxwcZoXZ/3ncU53ZhvVzU
 /nYqaTTG3Eng+9so/YrHbF/CiUFs2XZWEnkf7QRmRSODPun4Ytm6y1JiVJo2THl4te/V
 SGNg==
X-Gm-Message-State: AOJu0YxrmZZQWUgl5fWzqWIkp0mRSFeiLE8lx3CFz5mYL3aGzN0Rbfj/
 WTmF6/xPAZijmtk1OWwf/IbX7kM0QlS5hL5+wf2TOm55w7eaK0v31r9Q7ec5HHwV4FgE/hLAFwR
 7evyM7Fw=
X-Gm-Gg: ATEYQzz1wb9vVTx6YVVggkdOUuFuOOV7oCwiv7tBaCsiHXSGXF2uPHHILGX2kMdE5Ua
 3YB48IYoX22sLymSzmhkE8X0aEv/ZYyNrdnv15VEtN1AAnuawCd3pcaGbwUD15JDLbyl7bPPo8B
 ygP3WKWXxIHUznKmFLuLZ115PUSconLT1h4gaeFF6RkR4KCabmHdeaUvRQw5A2cjsoQJC/yp367
 Ro0lHxjWYet/siMIm22bFgPdPx24mWtpsFXDXtMBAwET025Q2OWIYaAHbX/4KD0OlN+rR/mGFdQ
 qV4pSqijCDXPt+7bw9O48zf8b8d5Vl0wU1dh6ThQKUMOcNoYRrM7Rjbq1e+phxOHodh5J6crqwi
 XUsDZK8AgWz2nacp+FkrpGidvUhlcvSZB9vH20z9D4YpfCGiFp0UxpE4LDLlF1MKls2E9nxAHwl
 toFutPq3t1vfjhv8QpVn4pNlvNjecA4J8ol4I=
X-Received: by 2002:a05:6a20:72a0:b0:398:dde7:2dd4 with SMTP id
 adf61e73a8af0-39bcea26260mr1106633637.22.1773969317559; 
 Thu, 19 Mar 2026 18:15:17 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c74443cc2a8sm451516a12.27.2026.03.19.18.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 18:15:16 -0700 (PDT)
Message-ID: <a38b768a-3a80-47de-8a03-11faf2b85526@linaro.org>
Date: Fri, 20 Mar 2026 14:15:10 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
 <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
 <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/19/26 22:27, Peter Maydell wrote:
> The 64-bit x86 signal frame and the 32-bit signal frame alignment
> requirements are slightly different, I think (and this problem and
> this patch are dealing only with 32-bit x86). In the kernel's
> arch/x86/kernel/signal.c:get_sigframe() they calculate the frame
> address like this:
> 
>          if (ia32_frame)
>                  /*
>                   * Align the stack pointer according to the i386 ABI,
>                   * i.e. so that on function entry ((sp + 4) & 15) == 0.
>                   */
>                  sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
>          else
>                  sp = round_down(sp, FRAME_ALIGNMENT) - 8;
> 
> So x % 16 == 16 - sizeof(void*) is true for 64-bit, but 32-bit is
> slightly different.

No, these produce the same alignment, modulo 4 vs 8, i.e. sizeof(void *).

The x86_64 expression is less efficient in the case SP already contains the required 
alignment -- it will waste FRAME_ALIGNMENT bytes of unused stack.

> I also note that for the data structure I am fixing, we never do
> an xsave/xrestore on it -- it is purely junk unused padding.
> The real xsave/xrestore info is elsewhere, in the dynamic part
> of the signal frame.

That is an excellent point.  The structure you're fixing is never really used.

It's only use at present is to be included in the ia32 sigframe structure, and is only 
used for padding.  As an unintended side effect, the alignment of X86LegacyXSaveArea is 
inherited by sigframe.

Perhaps we should simply have

-    struct target_fpstate_32 fpstate_unused;
+    char fpstate_unused[sizeof(struct target_fregs_state) +
+                        sizeof(X86LegacyXSaveArea)];


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76564CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYt1-0002RS-AL; Fri, 19 Jun 2026 09:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYsy-0002Qx-AX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:03:53 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYsw-0002t4-Tb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:03:52 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7dbcb505578so23790027b3.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874230; cv=none;
 d=google.com; s=arc-20240605;
 b=ZEH8wvzwZzhNilTVid3q65fmFACdTUbVX0FLTQzprefocf/EUmeVoOkDYIi3mxwGq2
 WN8DewLuCROuY92L6n4uHqozHs+0VDA4ejm7bvSRHQg7b9FAV7rAts/3Vo6AddGCmSMo
 92PjPdd7XO70wYJYXQERzGquxVkw+P3xfz+veZ+PivpG4wtjY8/6r7bvJfUcYBpJD/AA
 zMNgNHuGq7RwGeEcrtBnuyKtpsrz9heVqi8H+G6dF8SCE/eTuGj5vDN5ZO7z1uT/UV5G
 usaAOrsn3MmkhRQYk5Hys7IIMmS97GffdcrHZUaXoEzPpLLjiuZElNvyqoUVhBry6yXI
 cmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JW26VVPqkAMOxRNjl247CGXg7GoH25izs4nXDUUhnzI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=S0GOMTFay+htUujtJQZQUBUekQe2os66yNiBd7RAHgMD7fj0fnNsg9BxoxJm2e3iPK
 /sy5PC+VwYVDeDGTRgABmQD9s32q8ddEO7alfHIxS1f6Bx3ljMBgxkbwaJDxr6uO5GbF
 QVffOWmpf7KZwME446SoCk/MOoDwxsZVsyQzmPz8k2cHYcuCl7cw2mRY0rkX+BVWqsLU
 jjiTNHzFX3+SMjZMCV3tsNRIK0Aa2xNFHMS5vQAbOVEF0CAIDUcTaA/PKP35GBlqFeXv
 tbuC8yQFFP0+vqxcZU/ZSqT3eZrn96mUYtTubZDB85LXE47oSl6aouM+6pp3wYk17Q7Y
 QE0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874230; x=1782479030; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JW26VVPqkAMOxRNjl247CGXg7GoH25izs4nXDUUhnzI=;
 b=F+6LSoli9v9yxDHKaGZMtyfGB7ODxrREtOIR4RIyVnk6S/2099U+v5QdToJ1r8Geru
 Us6KpD54sQDDfxrA+ztpi1Z6i0lOE0Mjnsd2MfyJZl1eg+sThLXNvuYnjvtp15Wg+Gm6
 toL8bSlvwFPTwMU3W0pQpaHNuwQsoZk6LwmBtLTxhhV/cLKbw+j5/6hEgGDsYEPESIHI
 Ue6r8Rhj0xXINqJymtJ3shvsPfZxif88s0HteJ2fVwnIf3wSHm8ElVN8eVVV9zBb3BIz
 /53Zw+g5moSQf6B5oZSd8FMDcqD4aVJSLf12BzQonmJ4Z/i3KptAVwrb9K7PuFwfeEtd
 6OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874230; x=1782479030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JW26VVPqkAMOxRNjl247CGXg7GoH25izs4nXDUUhnzI=;
 b=Gzbgu4wW3BVrccwPaSvQf1DLZv0vhTFECCz3JuXXt4lYUIjeLQU0Ot7wRHLhV8g/3E
 vuIVD/NAkJMhB45oCmDP6bwfjLbpbOFSRbBLpqRPtY5Cr1VLqYK4vKxuCUsazwltM5iX
 w1NGsmNT9vAT6WsyStHHLmujbiqKhuqFrwPUoAXo5nf7AmV/3LUERkndQmkiSrhM2Pch
 JathS+bFtV4T1CSUlVqlBnXG6Qe06gEExBZ/XdEzQa0k7h6LGSsZ9n75zRizrVbffXwj
 Dmo75hr1bRTmKxRLNDpxdKXkpqSFqKu5Sf5YhjDc3jdoF/AuT3Ii2oNc0/vhE7RTnmAZ
 9vBQ==
X-Gm-Message-State: AOJu0Yw6CvGTwSoSfv9lForVSJaqswaR6PUN03oa8d7xfbNDDzuYWrOq
 6dNrD7+UXJTxvVvuL43/+wTUubmhDTXVPkqkSt3mjLzfBj/Bvpm0cIbSTdlAq4+IbGt3CVZFuAo
 b2fVPX6c4+iC6cm65HGozqVsNVR/q2MkdHK3E56jNhg==
X-Gm-Gg: AfdE7cm6MxpFQrcK/EKpLlhoSBQe48pcljOBxDhuNS+E4fH6WEiAHVp6Woz/qzd58oG
 DuxVJDtpJh81TKgtRghusgZgITtYTIZafKBjhLwDYSUQbkJcpeXU9raVaZUeC6NAeM+uh9hN+pu
 LMK5DjzXTsbkJ3cPufqwKKj4UGFayMn4xnGS2nA/SMFHiHXTAjnA1I2NPSeIWCnfDyGeiN6L0qb
 Ujvn9Cj6D6ImIZcZnDUgMpSPeI0YSW7m/Fvvlf8q6YZe+StFxBu8D4QWurSu29D252oGU0vA8NA
 DW2bnTO/vXWeivY26D5cNpMSRjsFyQ89UnVvOM+PTF1ocotsa8NOZpuR
X-Received: by 2002:a05:690e:168a:b0:660:9c4e:a453 with SMTP id
 956f58d0204a3-662ffcdaf3dmr2792700d50.16.1781874229499; Fri, 19 Jun 2026
 06:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260618040718.572950-1-richard.henderson@linaro.org>
 <20260618040718.572950-4-richard.henderson@linaro.org>
In-Reply-To: <20260618040718.572950-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:03:37 +0100
X-Gm-Features: AVVi8CdQdde7Rbq-Ytrj5i21d13XmK8187wbZzzVqHBJHV8FVSh2JEaUuFSrPEM
Message-ID: <CAFEAcA9_M-eRirgZVhdDci9_hE8iEBGm1nB4FNVFdikpX8FcSQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] target/arm: Generalize sve_compact_[sd]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 18 Jun 2026 at 05:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement with a DO_COMPACT macro and general purpose
> predicate handling.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


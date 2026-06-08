Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B27CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe7y-0000HF-Sy; Mon, 08 Jun 2026 13:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWe7j-0008FE-Lx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:50:59 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWe7g-0007mm-VK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:50:54 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6605c3453f2so4732361d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941051; cv=none;
 d=google.com; s=arc-20240605;
 b=U1QekE5K81IJXmGqQUX7GxWgyG1I+TReb2X4WZoyZFwThmu/fgJOXRVzEfc3SA3fI2
 e+NXUi2Mrh51reUeofhWR9tb110Rm4idds9CcxNn520SebIFxstK1EnZ07NQ7VTcrlBi
 iEi9nHJYqPPWPy8IPADbyWBBhBkv4SOLATUvu62tgtoGtZ8vVrVJHjHju47K9oL4zTlI
 orIpt/7uOodBgy76v34zaSm0lb/CIwt5nQe3jfuDBLdZZR0gK1PVoFoeZ9hPJQbqO1cy
 YNfV+11b1F8RrhQBBTUqAPexWcQn7EPR96yLIZI0p5/dNZ6NihWCNfXYLrBo2xxh1+HY
 oraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hQXgsogZvw12zVo08wQiXOJseRxS1FOiv1zo8+HMsNs=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=i9Lq95MxTsMajNpcsFEuPGioWSk8DFbpmWsnI0lFIw4TO62hk3jWL2AJk6bm812GFa
 JmaWFuLEIftHdANwmVqddMUgkJ9Jl1NUlniH6t3cKxrEeZsmWGiAIczuuxy+pl5gkpJJ
 zP8pMEqzvwR8GILVhdQU9+kNg5xCXjReYfCobMoDQtqsrZDgraNjUqmBq7YbbWOU9k91
 SxZuwv8Clk7CqCP6GsXL8d75aAsW5Q4f47AnBrLcPSpHkc0l5VYvMqeF7hl/xvv/E/k7
 UfMBLO/00GalQuvAVrZuAOYbNnLrDjKF4qGqzyal1d6uPrYiVUrbJUgy99tWW/qrC7oy
 9xKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780941051; x=1781545851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hQXgsogZvw12zVo08wQiXOJseRxS1FOiv1zo8+HMsNs=;
 b=U3FRqImxJYVxqgBdyqugtKugFncfV5ptBM2jTHbc2nARuAxHAYLyYz+AUX6oX5MmKY
 mbT9fBf3ptZF/psVo8LI/lPLOv4SAjp2/IgNhlHltWcApKh3zP0adhCQGz9mFc2Q7mRY
 hX8mTKr2yfn5BJXdx0aeQQYljH2OGhK1/3USSlMVrMbLejtnTRz73teBTUdt3ZiyAWBn
 ZMkYVro/0ozoQweXco4sh3TwrjS6aJf4/1DMS0mgL9EwT+xLAIUeHAuvukuIQ6QQeJbY
 Mu/Q/9j+dvlN0rCK5haT6TC7RhVNx6w+K1E1aSeeca/NiixkebGLEm3i78CAmn2/Qpq7
 SNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780941051; x=1781545851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQXgsogZvw12zVo08wQiXOJseRxS1FOiv1zo8+HMsNs=;
 b=aeLLT0VQQIm7YDapqu0lCjj59AzUl9DwF7MDgS3lebrTj+xOJzyfGUvgh3sxVSTU2e
 UxWEeQDhlUDEEOBZoYy79Ia4qYw/dLw3G48D2dkt5CK2X4TIXGU3d3riZgzdA8WdGjGb
 FXDKVaNH0jIMchnxHhM7ZmdQ96X2KEO0l6atC8VEb51D4CQaVkKrecdTXS8z5MASLjzP
 9fpGTi/FkQCYZ0+TzWL1ph7w2OIZ7E0D6rogbWRDJw88DrKeSDS/3Eyv0//N0G9jB3/c
 iRz8ApaHaPNV8Kjavp9OpL2IYpF+Y/DcvT9QWK8tgW6DN73NrYWHxCxlyz2X0cPkKS2N
 AVAw==
X-Gm-Message-State: AOJu0YzrqG3/W7H55taLpc1teLjZzkmmFgoLCblRYi2j1/FANCz9jx97
 uLf8qcSl3LzffPReiSdcGQ6LsKEQxsvVTelCnXET7wOmakoAwXkp4ducszuCPtMGkKdcpEIrdEX
 4DrcsmFZjZ5o7sFylKtDdCsplTKBlnW29WTOp5hR24w==
X-Gm-Gg: Acq92OHEwEJc08MRUenGP5ogjDXzQZ7WPWTfy6NGqAAzk67+f2G6C19GMel4x61rQ+p
 2VRPMR762kH3pKKEKH19Z1zOJ2BRah6TXDQdBSJ0lWFcsyDpbg4FvsDFnc7V4LlYQpgRZIa2jge
 y8EyFUf8/omRgbVxmir2kc3zbOe8l+Ueea/6Fz46SQ32e1cUuMZuY7um15slxpicxJSFYi+z+rK
 fDzLAUHZDdzMuVsY/P4YbMzVWyisj5vcfBkhS8xYlKie1MeGdm0Bz3JUb6Bcm5sQv2gXK9bcwn2
 kj64bi0bAUDTGKsu0iNCgD5geTt+fXVmR1l+HI/AfdSrLxyOEVlGVWsWKq8an3HuOZqQe8mmMna
 yLw==
X-Received: by 2002:a05:690e:4191:b0:660:4886:9230 with SMTP id
 956f58d0204a3-66106e42b96mr13751274d50.23.1780941051391; Mon, 08 Jun 2026
 10:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-11-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 18:50:39 +0100
X-Gm-Features: AVVi8CeV-NNbO_bFeuWlNi6LD8oUaT9YjM-RZxQuelRQKZhDFo-N_F72Z3FFzSY
Message-ID: <CAFEAcA-C50aE3=Y9YVxfgDd0kkx72xVjU2aAhND+uB=rQD6s7w@mail.gmail.com>
Subject: Re: [PATCH v9 10/45] target/arm: Implement BF1CVT, BF1CVTL, BF2CVT,
 BF2CVTL for SME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 3 Jun 2026 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   | 19 +++++++++++++
>  target/arm/tcg/sme.decode        |  5 ++++
>  4 files changed, 73 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


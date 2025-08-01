Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C1C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv8Q-0006Hp-2Z; Fri, 01 Aug 2025 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtau-0005LR-HY
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:31:00 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtas-0004AR-RZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:31:00 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-710e344bbf9so12303807b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069457; x=1754674257; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5om2p/MKvqU0ir0VeD/2Lx9e4o19Er7yULgHcvl/kXo=;
 b=y+m7FFxBdlSFfYmYA2NWcGhgZADuNvsPoQPPEjp0QUqudnqhsWNGHGYITQ/d2dODDm
 /N5glmM6pR10yy0wIpIdTTOQcexniM/Ns28vXzJLFheZwAgzjunQS24EskA5/hLpcH18
 +7fyNFkhn6A5b9yT8O+awg/5G+/uy3ijQQ1rld1vB5PBFkn8cCHIgid4GacYppunjTB4
 BAckb7f0iqx9GRSSLSkSvUdvYqsx2dC/p627KAKhWplkpwD20mOq2bDWWaNaqQNHoxEM
 E5hV9mBc8MnbbmAgghoqYjZVLSHV1Hdw/Rp7+E9fhk5dsdPcNHnwB3cHsuGvqOfviPq6
 hakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069457; x=1754674257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5om2p/MKvqU0ir0VeD/2Lx9e4o19Er7yULgHcvl/kXo=;
 b=JrWOkle+oDQKLnce/E1t5qX5T5bADbmM9C5q69owu017c1GTLV8yPF9GzVVJVU3xD9
 zYgH+1nkIJchk54nMRWU91//2aZUXhqVOMchBPp41xGvZ4L9iaJKKnASgrKIRe91resQ
 z6N+nZThSVRL9MTwtPLnH9mNMgl1AusWJtId7xkvOrdTiEjWG379zi2EnTqCJcXwA9eG
 QexDROHHziqjycPhjn/Yq5pBqrpoHwdC6TcJEVi7wa4h6cpRN10YhnvXkGfD6KWib33Z
 Flmz4JcOon4I5b3TOWQKLqXm52yBLZnA6NDFZtQfkwRBa1WeJJJo/RNM4m4OzCFk+dc8
 rOVQ==
X-Gm-Message-State: AOJu0YyKacJz9h1aprb0vZvmnBjexxj1mO054IIm4U4dTRvwnoduG1V5
 CBwWSLrGY3ylPGEQDxxwK4WuYG9kZmEFoX9qVEvalxpXBln9eAO/fkD7wkDJ57eAnbhVK4IA9Pf
 9pXcliJJDy1vewRvLTFK2VaqZQGAEITN+xoEOIZUDFg==
X-Gm-Gg: ASbGncvVJ3Hjpj6aNWinjgLTOnnJlWHciYu/s3v/PXW2A0tH55C0L3/yi9+Zdel6FZ9
 UPXnGD0QWbjZZy+CtSab5YVqoH0OCfP+krLSjPPYOUri3ZlAV+wBfM8I0GpvzZxP/VibY7oUxTP
 8GLxSFfoIr2/Jz0S1sVne6XAcWTWOOAaJuScCnNVO7YShSCv6y18JrSP2/CuSeAFGGNP2b3dgNs
 shBkohU
X-Google-Smtp-Source: AGHT+IFJ3rIdancOCOMP+a1kQWblLV6WawBS+RcjrXhjIbr/E3bLOXv3JGLj2fiEoUsUzIBx96/1nj3jl+lE60gQJdU=
X-Received: by 2002:a05:690c:660a:b0:719:61b8:ffd2 with SMTP id
 00721157ae682-71b7ed2ea3emr7551577b3.1.1754069457647; Fri, 01 Aug 2025
 10:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-34-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:30:46 +0100
X-Gm-Features: Ac12FXxW781KmBcCPLd7d1sJqA3mtJL6q2ft2fNs4FVyFFx_y5z-MGvg8v0mD6A
Message-ID: <CAFEAcA8Ov1wVYA36C80kzv-hu3O-=LeTrOr6vdT05a+Z8gW9MQ@mail.gmail.com>
Subject: Re: [PATCH 33/89] linux-user/m68k: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


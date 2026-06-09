Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F22CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWt59-0004nO-Vm; Tue, 09 Jun 2026 05:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWt57-0004ld-N8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:49:14 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWt52-00044E-BE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:49:09 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6605469c263so427700d50.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780998547; cv=none;
 d=google.com; s=arc-20240605;
 b=f6Txqio7wOYFXq+VX3Y0t8oquHc7FKZ9bF2nJWyv0+nEL+hWPDfTCQxG1VSwGJySyF
 LnevZCvOVX0zy9WymRllb+odYkfGli7VAOwSJk6/H3Z/pMDjnAlpy7kn+zYM3kWzCzpY
 TMDgQxA9WTxh4MRN3Md+twWrhOciLXsskSH3zKv0k0q8aw45b1mQ/D71903hubqXcxy1
 yNXIvXUBIqzg7CZi6bDDmDGU6Dqff4lxFmzZ9KQKc7QsJAh3PooAEndigXYFqvoPzEPZ
 BG0Dsw1MMmDlRVQtqhv3VUOJUQ5UqdYGmS+QueTilp6V0SmXjuN4atPVY+KXb+dbJWly
 s+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Dr4czM+e7iN0ziXcAj4sYb++YPg5ZjBTWwKT83Jyt5hU9E0lId3XwNuQEd8T/Npr5s
 6igEy6e1bGe1hd23/6K/3IusdlvgHznWZAAudahuFzZELlXqqf8eT8xAbakjUgt2cgCx
 22nKimR8sSMSDZ5SEHypdRoJdW1BVbjQvG2EvE3budswxFPIoilUx+F55xBNOdZRgNMb
 9lwrXvjGnI+W/ezVdvH5669LZ56jD4eTzsEKGajL9/d8Ff8WpEp8Zt3/t0a+q1tsRiP/
 QVXCM7tK7Ecl1eheGnCujDXaEPDVZQ8fWI7fvVhW0FAHZ2GYf2AoLrsS7+tSnutUs/3L
 QAhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780998547; x=1781603347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=FkQGq+19Wc9qoD95uLjQYzyJ1+zHYR5JDrg+GJLXf2MltRyurSTs+S9wb/RtLB//LJ
 5sOfYegcDH3/F/ncWTG+MDf5q+VGyM4LNQRzqoX3sRPTvzLNeXY+PpURvIr2yTNtZjat
 lijhISC4dZRARmdJMTM6iydwsBazDaAxFP7R4QKjSRDgHADSx5qG6EBGB68RO9Td6ZAC
 y8TinvSlrR4aLEte4EoSaFx9yKmgKoubxy4T4oH/FAmGKpuhmop0v9MVpN2jUFJfBFQi
 GuIq4OD+09Apcx5hbhM07ztkWgazTCry9oq9ukGALJ00o9a+hlyklZau/VHJ+gNJbgO6
 +Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998547; x=1781603347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=KqeRwG7o3EqRjN4L3hswmiHv0UwdDVTr+S8FptRhPwNEd067wZ08lwVUBfOvju/CfW
 PHYmCX0tjIBE/SqE4eZrfvCkRqZo6VgrJQVZ2Z6yz08G8R2SDtRWogGhI7NYcwB2fPMh
 7HKHzTxT8Fjm1S586efu8Lvv+/SSSCu0jzMgyFwTccn+fHgLfZmssMUSNXgvK9XIKy++
 pEqZf4e0gfyOYvO2kKStY3MYq7Lv/yohi2HBEqoU4t5IRpEv04B8GX2zHkZNP8oJXHMg
 sRsaKzbfd+mSGJkeT1u2evAIyapWpmKDMRGAz5+F/LPeynZyItG4SVKG5xrYiw4lPjTA
 3MjA==
X-Gm-Message-State: AOJu0YwUMtnS9wDzm8BQtua9gx5pbs2QTk4kdZF2Emnoi8pr7aKhugKB
 BRINOsKDAjfBF2qE3s2PROABNwAJuDs0Gn8VSlf9BWwLJtO4dNbwYgX6KjR1xqd/8ZeamsD94bX
 /0vsI7B2vQKJx1bialc6VTMG3e0LWcWNrNbf1U620sQ==
X-Gm-Gg: Acq92OFRllsg4Czo43Zg1tSnfq15z7bsZzpIkVx59DFnr+AQLpwPS+oiWNTVKkqFakj
 e//uG8ldnH4HNKpsgUlihRbaRk5sREPTujWH73ZtyhNME8G32KXldTmRunZzQsqIMLlGaVCUjMC
 N05Sv9QNZdnWMGeC5d2xYUSCOR70kVMo565XYy7f7Gzz9hbm3EHGq3Gg6Z/xaYa0IVAmlw2zalK
 UxfKkDZpBTjCfqIliEfbViYMH0zEe8Mp/QODuGb2MD5yyPtAsM/c3dMBT/oL6N5gCsk6FXloTlY
 /bUTMuRaGWsdeBRd8EJ9YRfAh1BFUzvmeQuZC5ITQYRF/5r/vu56KhgPa0/7sIYL2fQ8WDkK7Tp
 TAg==
X-Received: by 2002:a05:690e:144b:b0:65e:39d1:d9f4 with SMTP id
 956f58d0204a3-661073da66emr15528379d50.9.1780998547122; Tue, 09 Jun 2026
 02:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-29-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:48:55 +0100
X-Gm-Features: AVVi8CdEcFVCjn8epcsPxry4PH7gTgmDMTbHXKlO2O8UV0_tWRrO27YClIzS3gA
Message-ID: <CAFEAcA-PVFUVuZVyWQ_NEOh6byZfNef9nihRXq=NnH6XvbO_Ag@mail.gmail.com>
Subject: Re: [PATCH v9 28/45] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


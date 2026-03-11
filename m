Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303A1125839
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L0J-0001Rz-8S; Wed, 11 Mar 2026 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0L0F-0001Pe-2m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:57:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0L0C-0002qE-Gv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:57:38 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso12043058d50.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 07:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773241055; cv=none;
 d=google.com; s=arc-20240605;
 b=S7A3ecsqJ6/aci+118kOuAhBlFcTX9dYQy0L0845RlWUrtK7lMsnWsg4tFDRDWRY3z
 xc/kOC0O/wBAE41I97s+2X9GF+w2ej7K5jXbcxCHBojCHlH5fNllQSslLHJGwQ9wUYMp
 JVX3mhg4mg0Yiw3MaWCQkMjRLg9kn9dejAHJq3lBaVtvTWd+58vck9hVifD2Pm0mMAXa
 G5boVa/KC3maaidPZ4x9JBL5OQZzlXdwhqwK0o7xFZeLQwGRfEbaOkpsyVNxJQPGjVgt
 6Kt60NfQKnpB1pZwPyvs0qrfdu6BzPuKQ84XfCPTrSZb7eVWmVfue8Ar4pst/KBbmzP/
 SYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bh9m71vS1r2zO92bncjCpyAPe2SZe0FccD4Tht2t33I=;
 fh=0KMuFbQh6/015PlQGbmhuo/mPfRDSg2dtTQRkZinmsM=;
 b=cHTC5/R4DmySjS+olyXHbM54WFka9nzVTQ3jnjH79Z+KM2YwRlHSM/Su+r61ndG+Lc
 hUKvsrJLpk+aD8V0RIDBiyOFDgtsGDDbuYul3UKkCHM2iG52GxiJJHBKmQ4aswgKlm4q
 bv98di5F7qG68bv2pURO4d48e/cnPhSDCVkcfHc/fUmyUgE/x9+F+3YmZHD0i3snso7d
 u+NTRkmlAcuafwOS8uwToOF7rEYPQ4FmM12WDmICkPujWXu5tRWGa9KOMFyKD2AL64Ys
 p4K+TE14GytVSMpLOmQTCk+ZLNKx9GZBfxaLuQ6s3gZYO9Z3cQkWvoDlgIK0OERC/xce
 agWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773241055; x=1773845855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bh9m71vS1r2zO92bncjCpyAPe2SZe0FccD4Tht2t33I=;
 b=eKqBjdDvyMNmOkfOlrBDJfFvjaTIxIRZZpTIXAjXPWbJgHbsoSlZIYgiC3xTlwToBF
 cIkfmvteRRe1hdTZRuDMNRP2NAxLu7/1Rvl67TCBwZ+xU/tt+jQoovyyxQ69M6MDj3tm
 6Zp60yDTe17VOaM573eMC6ytOTRfT3rRw1EgX8b0Co/VNVsnMMVzxVNLLqP3zoTv2ngK
 imyNE0/FuBz9Z1IyUbcg2yMBXpfGiNAFyltnweOLCh9P2RwdSyhn3V8M7LQH1VnOjp4d
 s/soPPb+M9D8z7ZnyFN0z98be8v6XkG+b0nipY0A5IPn2pPEGbLhHhGTCkghL6P1+VA2
 d2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773241055; x=1773845855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh9m71vS1r2zO92bncjCpyAPe2SZe0FccD4Tht2t33I=;
 b=u1EtjkziCUrVQ7iXYzeoxA21PhUI3WyLMfuWYPx1HBatVHn7nytWADYZ9qEKiPsSDO
 8k2hcWd3HhoM9ehwUrzCxwTFh4CKZXLJ7R0GYbFwdSRkB+H/faHJ+9i6yscqmREgWnn5
 +GYJCsRVZRavTkdE4zzRBJw9XuC22OBbBCWZYVOsQq1SzNBzm7yW7EkmykXd6kbjdjId
 yozPS4iTjuXJBq2FlMQZPBWJrno/R/SKhv+pUKHqbMOCH6XRDqB16vSdacE+kEh127ST
 2fnY4Frnv5h4y3Na/ZjR0zMjQOMKXSAWDxHiswzW8jrztLHxZwMfyngS6FyUImVQeCvO
 Yc7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZC9hewrrKaXcgfAnTjda3BlpMtS77Hr3+DVGp93A7W3s+aofiDrYcO7Tri2lZ68udZmjdSOxj1a46@nongnu.org
X-Gm-Message-State: AOJu0YyC2ZPZzgwRSXepGVr79+GQYi8PNI+y7GLssz0qKyNrQWj/onFR
 rXr44vOplIjyw0rov9BcrppHn3Mpqbmq1SAJVtk2YtPhG+7dJFBqFDQ2r26O/gZ8CHP4NIga6Bm
 dAVrOsXp4xpAG2no4gGziyIn17gv8GATlODnwl0Kzhg==
X-Gm-Gg: ATEYQzwdfhhGu/Jt8Hch1/XnBpqKdMHAd+o7P0mbJUdDe4A3dR4ah56pgeBPuBhXdzT
 yqCZSJfTPRZy0wJUZB+XKncq2BZopwCEzQmrQCwrJRIewMHkhF+wJQon6MHc1JbtLbqwvLa81Hc
 EYeyjIUUZgcH6KxPtoh1NYm4grahddmkQpuSwnwhBGhpAcI0iUD/a6zD8APnTcl7/0Jcw2hQeVN
 X741DNAd8raN33wCTefiHQLTwJq+fXtXg3gU1AOEVjFi6WGUtaw1GmnpQfsq42whvuNGje0B6xY
 hDLU6q9++d1/iPQ87vpV6hsRinFhQmvrxZqac1e+3g+Iftzj4ePCM9uJ6qvSAUHdf6db0O0Zttu
 o/A==
X-Received: by 2002:a05:690e:4184:b0:64a:e366:f511 with SMTP id
 956f58d0204a3-64d6569e129mr2390914d50.7.1773241054893; Wed, 11 Mar 2026
 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
In-Reply-To: <20260311143549.118720-1-shivangu@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 14:57:23 +0000
X-Gm-Features: AaiRm51qTG4MuYps8m3nAV3s4eBwmhDWUqaWh3XTC_5ToABBFzVUlllPluANh6k
Message-ID: <CAFEAcA-MHLyKvJcbSpEGQz74dgFLJm2Bhda2=xSgXigdU=32eg@mail.gmail.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 14:36, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>
> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
>
> Fixing this by generating fdt blob in `pnv_init`.
>
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


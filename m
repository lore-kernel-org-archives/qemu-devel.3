Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BE6106703C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hqV-00084R-8I; Thu, 12 Mar 2026 11:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hqU-00081o-0v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:21:06 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hqS-0003yf-EW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:21:05 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so1331103d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773328863; cv=none;
 d=google.com; s=arc-20240605;
 b=QlNzyaOQMRudlO+DGGMu5mwEs40ISTqiM8dxwx+iheWIzl2NuEdSNZjuDhOoJ3JUGF
 stEKSXYYjyullNr4si1OCZtuLWv9tY5/49vs29NGTDywqGxvzjGXsPUDJlH1Wt8RevPp
 BVhogNUDUa9YcGnq76vrVmK7nus9oOm+qIBwQKdOLjUkxw7A0r6RlYxL50m4mebz/uBm
 0bpfClETBzTRN9veuLAqF83tPIdX+wC4irC32Gl9Z493hi0qbaJ3sNzeUfpUUpuVSh/F
 geqSZRfZ+c5SUFuifPSlc42ykoQppmhs97W+vDiDCzYf1s/KzvSKIL1SWK3dAefz9fvo
 2UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ONBKTWYIcaSoI5PtEWhN67nBAn39Y3UDWLcYy+iLM4=;
 fh=QwYyyUxj49fE3r2/5S05Hg3zHNtF3HBjcsjpjamgaAA=;
 b=GUTrsq/s3zMlTrLMgiVrUzFUG8rD/o/LX6cfWxmH7KhXai2LBSUnZZyQKsN3Aq8vSr
 1TCLxv9KpEN8ts+zfWtrZOropTjuBPZHySdb77pva4RD33n7+pIhh/Mzn977LcEHjhD1
 pGubBw8ALRqadRzCqjq2LyAsnEXLA1d5mcH9zYwHNy1pXIpolLeOOueyfCdY+bl5tdQ1
 qawzr4pW4In9v+Fh7D0j7Nv3rQD3gu43EWTWpiv1pNqnDv8l2xmvNPS+qbUx0zGjLmLh
 BUXyyhIS6IphtZFA90PD3F1taswcs2zVHyj2haxx/L6iPbzy4fGdyFzRvT4PJJi54G5q
 fVcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773328863; x=1773933663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ONBKTWYIcaSoI5PtEWhN67nBAn39Y3UDWLcYy+iLM4=;
 b=ChxVcl4QoAcAu3BhI9p5Cn+VFIv5FnrysXgBT2PWbMw4cuLXLPztpFyNlxZ3kAcZ+H
 Dlz5KFyU0qmdxtAExTPw4ulN8shWR28xpxNm44FcBE1AzN3uDkpO7Vi6sliUbVr1c0cI
 XI5AnwRI8K1NiUrm5ram7Bz5+zsB2NetTZAq4C97FPJbmlVqOhKi5Hu+kwUFO2I3WPmq
 djWisoKrlAqJyabsgOePzFdaPLyrPceqLz+JJEwXm5ikss9VZKpo3WRvc9MhFPfIRQgQ
 9CQnvx61bLajS3xqHK/UHBVTHLn66NjFxx4rZMNEjoOQQMT8F1zuEmEpjZKC1m4zezcs
 qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773328863; x=1773933663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ONBKTWYIcaSoI5PtEWhN67nBAn39Y3UDWLcYy+iLM4=;
 b=K/d64vPH0t82ASCmJCApCHlYHMG02Jl80yY5zEN6TihC3gHIZpAdyIbu1voDzb8JqB
 GpfGXmY2r1HZLR4EBYuOLWUIyT23SkgdcZVPq75BO8j7qaAFH6BKDtkEaBuNUSRIHmJr
 5yZY1zun3StfEcKjIR+i3UMuLLPE2EBIipbJjaZ8zQ+Zyt8B8zxqN0JfF08BLUAuTXFt
 9NTuddw+fD7SjlGKKr+hSIno3yxdMQP4/VSl6+UtQTfZD1hToUkw0RBpmeNY9ZSTrdNO
 nGNFcnvDzTTOOjvgZFsUi0oiUZ0gNGZyKVyZQLLaKyKuuF9BadtAz03PC6eyooGZVKP5
 B0GQ==
X-Gm-Message-State: AOJu0YwknYJi2ApjO8cSVl+9b/xdrrm3DjiuvMzjPlDVVqI+zTxE2LPz
 n7yG1sTb9KEv9OToli600JrK1Fb+I4iyJEs2OLUkTs8xYpjvHnq2PjULGX72MFqUd+LV4b1IGZ9
 skTKOHU+lSEu5byCNKuOhouu5AIEupRXxNG6V/Ul9xg==
X-Gm-Gg: ATEYQzwcmKVM2JDaUNV7LDXKzewOAVYGKhxssKcPaOpjZrCsUbxKIyF7WHyDMBs3WOF
 bUBavlxT4tKd4XqCktkGMzrxYdcp13ChZa3kniWm2OYULslwbZXUaPGlvJQq33HIHmnm3yT+wjy
 xlnWvjiu67ZVDGWUzGn7LHccVKv/Sisfc4nQLyEi+poPueNWv5lsTcj074W6yQuElRtgmoU/CvW
 mMI5LhdZGdvZsRwkndVUUH4ziUTxwa3oyOUgAPRKloc6h/c6t/i7PG7Wex6cfJF/iUAWQ8P64XG
 ELe79xuGFDSgIqh7w5oUcnYY3qDW/UdCAK62OAdWzyutbqLeR04bI4FihjmBadpN6fU=
X-Received: by 2002:a53:b489:0:b0:649:df15:ae26 with SMTP id
 956f58d0204a3-64d657f5c8amr4688550d50.73.1773328862937; Thu, 12 Mar 2026
 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260311221320.22112-1-farosas@suse.de>
In-Reply-To: <20260311221320.22112-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 15:20:51 +0000
X-Gm-Features: AaiRm50OGa8kEwSZQA_PefA9eeasz80vlDSvwDn5odnXDbEnuwxhOm6S8FmZEPA
Message-ID: <CAFEAcA-Wkiyk2TFTeD8MtVcAJRk7X2FG3TVdafXWqA3hxT3rwg@mail.gmail.com>
Subject: Re: [PULL 0/3] QTest patches for 2026-03-11
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 11 Mar 2026 at 22:14, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/qtest-20260311-pull-request
>
> for you to fetch changes up to 6ba08f4acec830d12f6983b0988c901258654a12:
>
>   tests/qtest/test-x86-cpuid-compat: Switch test_feature_flag to data-driven (2026-03-11 18:43:20 -0300)
>
> ----------------------------------------------------------------
> Qtest pull request
>
> - memory leak fixes
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


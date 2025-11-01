Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A820FCCFA00
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 13:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFBQb-0007HO-H2; Sat, 01 Nov 2025 09:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFBQR-0007Gs-RY
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:13:48 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFBQM-0001jJ-PL
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:13:47 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d6014810fso34447797b3.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762002819; x=1762607619; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rrGj7hq2HnftrshwipnFn8VF9qJbrmAS+iCOj2i0r30=;
 b=O4LB0pgeB42T+tNQVTttHcn/u3+OQ/GQ4hCa6DPL+adSzTbk5P1k1muGPnvxPJQ6vQ
 IRe83nFTmJlAMPpf8cYmuNFdvN5XEhb50bt1+5poxDJ92NZZdz5T+EW0qUatG+rL2i+R
 tdss1rOta/HmWHqBVNddxpvqfq/7Ibug0j2polyNULWa4AKW+Q1Pg6dM8CRjjdTbn6AG
 xuAA1VzFI/P1IvUnoQV5J7rm2oTkXpG1bCP3FH2b3d1CboqHexNMPVvYopJB252OmfiI
 ho/lFwdfYTzIeg2P8wEE64KncUqh9x7/HmGbsc6HuHDT45m9MGCC6WyPkPlcjKsCgLwz
 5BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762002819; x=1762607619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrGj7hq2HnftrshwipnFn8VF9qJbrmAS+iCOj2i0r30=;
 b=oqG9kZADpKbOCNoYNAhcaXDK9zPvuuCA6EfSPsgbJs3yx+yQoUM55HoPLQKthkZLjo
 9zfNTDqCRTn59Jn3yU2C3hqI84KYtjrGjb3YBPAhezgP4ynjccwcbIxmpD9LQaySMz31
 6adWUFEMUW2NI5W7Zck4RsMhx+JbE7ZCOyD3Xd5Rmxp/R3rvHmwpbpIAq78KMqyWjjTl
 qMS2AWQ/BjT71FynFmV2OMGiCwsin8ALEyovOIC1LMAyVMeqmCAKu5kPlzMv9+ZVlhcO
 kZ37z4hiI9v+aT6vgGHw9WXmyLAXkpMbzt7yI5NrJN238JFVaKoaVE9UOl+GxU+y8Cvf
 xAgw==
X-Gm-Message-State: AOJu0YzUf4Zz+F03JoY+XI7u44/hdNNRKqxHWYaLOucmksTV3u4eVyCy
 KL7431Ioix53tgwVlkLWGL1vASyji2AZw/GYv0rgg9bx7Z8H/CWdqDQqhkxTESRqtW7Zdd+Rr/8
 t+2w/3qc+qHCAc7qu+zDpVBFbyOlXZcOQXRfRasQqrQ==
X-Gm-Gg: ASbGncvYmJfrsaMg+Ly5VNzg62itjEmT2WEbsNoXXxJA25RUXnhXLD8enV11IDACDKZ
 diahIu9RAzB7xEJFfVcWomGHAuaJ5fmawXOMO88wFYg7z7d+/5cqTBwHh5HGNv4kDsZtPWsttZ6
 FGrzqdHeCQduy36lwrmWAWko9jBJDFR38Gf6V14cwEUhrSHBaTJ+al1hMhwLpXm3sWPX5EFE+A1
 qQfMVw2ZsoQwP+EHAS6Gnsmm7TMZY7mXGsVMUq1SVrN+KWkYtvQYgjYESk2+hgSBbyQp03v
X-Google-Smtp-Source: AGHT+IE/KQEGbDsCsQV5e5JRq48WZUcdhlTWz3+DcZFJSiHFCO+1ZjsM42ZfvDskswwbtVakqHLCf0lhXFD0OZG0nzg=
X-Received: by 2002:a05:690c:5c01:b0:786:4fd5:e5dc with SMTP id
 00721157ae682-7864fd5f59fmr39663977b3.36.1762002818712; Sat, 01 Nov 2025
 06:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251101130330.1927-1-shentey@gmail.com>
In-Reply-To: <20251101130330.1927-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Nov 2025 13:13:26 +0000
X-Gm-Features: AWmQ_blHST7iDQ8JH02SfUzMk4KLsZo76J_txiCp5bcZHFF5SD8bj61Bbr8AUWo
Message-ID: <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install: Remove
 _com_util::ConvertStringToBSTR()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
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

On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Now that MSYS2 provides an implementation of the function it clashes with
> QEMU's, resulting in a compilation error. Remove it since it doesn't seem
> to be used anyway.

The comment says it's used by _bstr_t, which presumably
is in some Windows header or library that we're linking against.
Our code seems to use _bstr_t a lot. Is this function definitely
not required, or should we have something so we provide it only
when MSYS2 does not?

thanks
-- PMM


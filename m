Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9CED5A6E7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 07:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFpk9-0000uc-MH; Tue, 26 Nov 2024 02:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1tFpk7-0000tj-My
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:12:15 -0500
Received: from gw2.atmark-techno.com ([35.74.137.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1tFpk4-0003XL-FZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:12:15 -0500
Authentication-Results: gw2.atmark-techno.com; dkim=pass (2048-bit key;
 unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com
 header.a=rsa-sha256 header.s=google header.b=Frv/UVV2; 
 dkim-atps=neutral
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 0727C4C8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 16:12:08 +0900 (JST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7fc2bdd115cso1609304a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atmark-techno.com; s=google; t=1732605128; x=1733209928; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hTgsuWwPlj46BoHFUxw+yDh/qk+BRMu3UzWNGTJV78U=;
 b=Frv/UVV2jLj7gNaex3Fiip9aFCqaRwVcIbKFBi9M7Tys4n/AHnctx3hCStRpI8tka0
 r3SvDIhCelpn09cb1ehSqfNqHsdarb3GuCBBnhGSN0h9xxsW7g9xufA6MX5vbnT6I8uq
 dQBBM6lw1qQNcJIK4GdfI8nx/G4DOlxRg9cXGrE0nAv2K14KsvoWi6idhjxWoBNzj53B
 VL5Zmj2mPqLFlYJbf3u3gBVJ2ZAje4HujqDiBcB9qSuiN7rifBuBF6Mt3qJnnvTVdLnw
 LmT/eKgkaPatlXeoDFLnVhJnO3m38DMYlMykQJYA5srtBDG0YQ1nBs/ttGGGCJ96qDh0
 llUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732605128; x=1733209928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTgsuWwPlj46BoHFUxw+yDh/qk+BRMu3UzWNGTJV78U=;
 b=YJuZ/mZq36dGLv0SzqSaPWNQH/CdvJikZdoOfGlutdpaWr4V3Nvul55dKWUW6binl2
 Tc3H/qLgQpYxhQDKTBk3/too+Txlrw2sLmzIpr/I+sa+CCSUarXb9ZZM01gw4zkg6YMy
 t7480FTQCLbdrsT6UgE15ndpDGP8WNS+W2bl/71HQqxon5H7BuelUg+GhxRc5kexP2cR
 FUuzACGi3egW9VUMrCMc7gvxrWLBrOCB8niyoyhjwgwzg+9BuOcoUv/SWOtws9CJxgi+
 ytG41LET73AYNCsaDhErqlRaKo7eBwZopm83IysW7Pc39I/pTDI+1BRaD1v2EpqL0vbN
 kSiA==
X-Gm-Message-State: AOJu0Yxk9SkoR9M/ui1GdKlG/TC4BtEuGfB3xqxl4B5eSSDAQf8tCYBi
 HiDF+u0rgJ80qyxKRkg+2rtB0u6GZ6y21F0XnM+XiE/4GVgtZtBYNMklWCSZt3G2WjDYBzWOwKD
 Dz3PqBEsq4my+sZZ33iF5BN1v0R7MfkoHHBJoK6gDD9zYJPaAnowyWQ==
X-Gm-Gg: ASbGncvVGNwnAGAkSt9ENrQ9DbhF5NXLIqnngBzdiWewHbqph4t93+O8kVHQSGRgoHM
 PrFC8M39jbodltfgKPgUqTKse3kiC0Vt6ZW1sLgt1oRaRKz3DzgPmUSGyns+Vl/Sggd2qLKdHkU
 OwibhR3YHyXHUiFLdgRFJbf80c/MzXlV010CDTBdM6slvrPXV3+DQFLYci61aW6bDukShm5ImUQ
 yP2pF8w2M9yJ4Zg8N92EwAq86GmAjDO+QCjFMtPwkVDlj7wr3IHnHx/tEEn+3/tnXHTDFh+cYlU
 Cih/chBa54YA/+eqQvD1p3TecaBkgO4=
X-Received: by 2002:a17:90a:fb90:b0:2ea:7ba7:33b9 with SMTP id
 98e67ed59e1d1-2edebf22a2dmr3718348a91.14.1732605127807; 
 Mon, 25 Nov 2024 23:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuGUtNyRX/FlvID5fCL/ti6CF/NO9qNCUzGVHEpFtKxAaHPaUJb44AHtLL6MVacm4Gu5Frwg==
X-Received: by 2002:a17:90a:fb90:b0:2ea:7ba7:33b9 with SMTP id
 98e67ed59e1d1-2edebf22a2dmr3718327a91.14.1732605127416; 
 Mon, 25 Nov 2024 23:12:07 -0800 (PST)
Received: from localhost (76.125.194.35.bc.googleusercontent.com.
 [35.194.125.76]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724ec978e7fsm6390351b3a.171.2024.11.25.23.12.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Nov 2024 23:12:06 -0800 (PST)
Date: Tue, 26 Nov 2024 16:11:54 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, deller@gmx.de,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias [regression]
Message-ID: <Z0V0undiZVtHIy7z@atmark-techno.com>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816181437.572997-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=35.74.137.57;
 envelope-from=dominique.martinet@atmark-techno.com; helo=gw2.atmark-techno.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit is fairly old, but this appears to cause a segfault for
older versions of ldconfig:
```
$ docker run --rm --platform linux/arm64/v8 -ti docker.io/debian:bullseye-slim ldconfig
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)
```

The segfault happens inside ldconfig code (code_gen_buffer in qemu's
backtrace), so I'm not sure how to debug that further, but it doesn't
reproduce in bookworm's ldconfig so that is something that was "fixed"
in glibc at some point.

If someone needs to run older debian releases with a newer qemu that
might be a problem in the future?

[we might need to run old containers once every few years to rebuild old
projects in a similar environment they were built on, so would
eventually need to work around this problem somehow]


The failure can be reproduced just running `qemu-aarch64
./path/to/ldconfig` on an extracted container so it was easy to bisect
and I've got down to this commit; hence replying here directly with
involved people.
------
commit aec338d63bc28f1f13d5e64c561d7f1dd0e4b07e
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed Aug 16 10:32:18 2023 -0700

    linux-user: Adjust brk for load_bias
    
    PIE executables are usually linked at offset 0 and are
    relocated somewhere during load.  The hiaddr needs to
    be adjusted to keep the brk next to the executable.
    
    Cc: qemu-stable@nongnu.org
    Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to executable")
    Tested-by: Helge Deller <deller@gmx.de>
    Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
    Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
------

I've done my share of debugging linux-user last week[1] so I'll leave this
as is for now, I've downgraded to (a non-static-pie build of) 7.1 for
our build machine and am not in immediate trouble.
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053101

If this doesn't get much interest I might try to pick at it further in
a couple of weeks, assuming it's something we can/want to fix on qemu
side.

Thanks,
-- 
Dominique


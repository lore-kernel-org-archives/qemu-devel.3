Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D52EC1429
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNSz-0006Vi-GW; Tue, 03 Mar 2026 05:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNSy-0006VO-7b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:59:04 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNSw-0007Nc-JM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:59:03 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9a6d7f81so4894750d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:59:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535541; cv=none;
 d=google.com; s=arc-20240605;
 b=ORWVNQJTb+KXYQhp0YivvTU02F282wlVpWBZzD8nm3S3nZuzDK/r11/NiKsKAAMEb/
 NljT2TXoyJJ9aslEX+bFmiVDMPC9/QrSrDSgwjVyFShqqDu/1qDgcKpwPYIf/aHgtf/G
 UpfRrTPONoKiMXkB557uNUU+gthABVMu+yzmcwu6SuKrJ8Cmf7j+IFxReEzudRWCueMl
 +UcD9Q44uCd4ibqZdu8JV1LViYz2sXD65qRjk3HsnJnSpp7NV3YG7PrJAjvDRkwAr0oJ
 fQFchltOqGwhlaqyWukE9/zUoxG6lzF3w77n0EQpp3RSsLeL6UpqKYObLYBJz2UzghK1
 dl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OuOUtAA7u9Z398L/7FL7Ixn0YPCowf0iHHYo7fQ+/J4=;
 fh=+CZU4eBgQNIHr+B5U43bPey3n/J73PrnhyXwurbDGwA=;
 b=cWl6xjOL8ECoxKdcuDFpLjT4xTRSKZ13ixhUAWPTZ/O9LrvhRgM6W3PweL0g8YC98y
 FMeoAQIIjRslMbTaYvQmVudKlVPmMZkVIxaOk81SIcRmWXTHBxPXpERpz4OkKx4mgwIp
 lnCqZpievPYLTj8pEwHnlnBqe1STUByk300zn2L15aAAXrWNQzgaLlrXZwr0FVPPo1eA
 xGJG0zPkdOICxSJRfuD9htoc/Uq/Vg70rHmpBcNBCOKYW0e/w8HW8BwYYMyLytVDcsLm
 4a8EKnRJZyY7jCDPfDFts/eInct/ZdPdzZSOGovhUngn1nJPA2VAORFFH43vN800R4eu
 bLrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535541; x=1773140341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OuOUtAA7u9Z398L/7FL7Ixn0YPCowf0iHHYo7fQ+/J4=;
 b=zRB+C+DXHCtoEXq2hzMkV35HpCZjKEs7K1heR5Yxhkzf/pbRVMpBBmZLq2e56Uc7Yj
 DCco4XlqceJGQQXLXxQ8oW4KviYtIF7tdsIuhZU0xyW+5zJKlb268aufnd604XIhjDJR
 pzLz371rhmDNtZaxXZfxe02e9rqycp8xPiCQtHSzkSbE5PrZc3rsMXIrF00kgbIOEMSQ
 mhKu/i7B9c06/ggTRemXnHiTvM3k202+CA16Wt04071gGaqE0VGprmu4L/CLRscgwlWH
 Q5aPnrkBfoCM0zHyuf8v16vIQW7OHA8F2RIMy9Lk3dGPoNnqBVD4AhnjcLcT0FB0oDDJ
 +Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535541; x=1773140341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuOUtAA7u9Z398L/7FL7Ixn0YPCowf0iHHYo7fQ+/J4=;
 b=JozyaOHVj07krz8prEIp5AokeIzKt14Tqxfs0SvuMxMmHHFUG4Gh75pfIJtxVOVkWR
 ZkzuCWWtYO2j009/c60LZr6Tlye4VZ/mTTvI4MLzzntgpfr/eoN1iIXpdn92bajTroFz
 XTLDigQIpWhRA9EOUmEOGml9t78dZeo8kwXFGIvplaWYi8y2CUadqueUUCiHQAWCwrYp
 IsQpPMjv9r0kh1O7/3jwkto0jtJSRcu8Cp9jrD1apPwiv/XR73iIkK2YUNDDsTLjTRTH
 6xRNWIW+VyQ73xO9p+f05gBFendII+VkGAL5BUg8/ppEKmNl4+CQZAE3z59INrXjPHAU
 xJtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRb27+g9LyPMuxYSTKoIABXtinBzCtI7qDJsNFXmTbrubKFG4yfOKHipw90BjI6wEJ2dFXkjbKJJ1K@nongnu.org
X-Gm-Message-State: AOJu0YzrOJTM+rEry0j/9PInJnlsRUxJ55oWRtUdQje4vjEYbDEo4wny
 5jF2qlEsekKYlMmVCMHcB9thlyqJXPKjPxoeA1DbuGRl1ET2KX6BC7f55vu6Xj2x+IfYoeFrW5w
 uU8FbLFgHKFsf+/Nt7JfyQtqvpwC6ARWrwtHuieerZ2Q9d5Ud7qgBM0Y=
X-Gm-Gg: ATEYQzwYnVMPI6XNYSVyF4htqg8goTKEViSbeTJGr/bwmlcjI0xVv7zj+rbYi0+8nLB
 tzoXpkxRYx5yW6XW4zhukSuBYwaWp9CazsziK91bPcksTvtZNKiRW7YlsiK46SAkeJk/RQm5WW7
 eUly5l1N9iJtekGRXCgbXWFN3+K3V5aXJjXj/JuZdEGoqxfdJeEiTb0X1EVFPcIgAhuaZiRQWec
 TsRchu9/Lkqq5CJA3IWoG0hrmjFdsCgazfugMp8fo/EQIESjnzL9SCSj8JMLiBYEVJC6A8ewz8h
 YF3JkmRTzuoztWT2CMWAzYLbO/HBLZ9NNN3T224dAV0FYBdvXleV4gy9trEudygMnDQ=
X-Received: by 2002:a53:cf0d:0:b0:64a:ced1:4fa6 with SMTP id
 956f58d0204a3-64cc207eb33mr9746165d50.12.1772535541110; Tue, 03 Mar 2026
 02:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-5-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:58:49 +0000
X-Gm-Features: AaiRm529-MeTUVjWWwQ00t0xbktOtoPP-RRlvyU37tcYEBaikNvCcJ0bUKFq0Ng
Message-ID: <CAFEAcA8V6nAHaB89kjozmidtwXtD0v3qdYsfovaTwsuY9CW5Xw@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/arm/machine: Trace cpreg names which do not
 match on migration
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
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

On Thu, 26 Feb 2026 at 10:02, Eric Auger <eric.auger@redhat.com> wrote:
>
> Whenever there is a mismatch between cpreg indexes in the incoming
> stream and cpregs exposed by the destination output the name of
> the register. We use a print_register_name() wrapper helper. At the
> moment we are only able to do a nice decoding of the index for
> KVM regs.
>
> Without this patch, the error would be:
> qemu-system-aarch64: load of migration failed: Operation not permitted:
> error while loading state for instance 0x0 of device 'cpu': post load
> hook failed for: cpu, version_id: 22, minimum_version: 22, ret: -1
> which is not helpful for the end user to understand the actual
> issue.
>
> This patch adds the actual information about the probme:
> qemu-system-aarch64: cpu_post_load: op0:3 op1:0 crn:2 crm:0 op2:3 in the
> incoming stream but unknown on the destination, fail migration

I think it would be helpful to be slightly more specific in
both these messages by saying "system register", so in this
example

qemu-system-aarch64: cpu_post_load: system register op0:3 op1:0 crn:2
crm:0 op2:3 in the
incoming stream but unknown on the destination: fail migration

and we should use ":" rather than "," at the end between
the error and the bit about what we're going to do.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


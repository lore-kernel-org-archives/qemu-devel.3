Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGev5-0000iE-Tz; Tue, 13 Oct 2026 12:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGev2-0000gv-7f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:00 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGev0-0007Zi-7p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:59:59 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ab43af5e97so30307577b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907197; cv=none;
 d=google.com; s=arc-20260327;
 b=XbM530EM12Pa5uZInVc1Xm68MuObdsHAqXGWWHJDIow9pFDtY7GSIKFw8aB7qezEkj
 ZMrvOvl6pU2LEK6Bn6D8eN+Wg58YR0uU+sJVT6r/cfi6WgbE9pXhplWK5y7Xrbdqv9NC
 m/aZSxHvcH5rlsj/EWbViHbVFjgM265LOUJaE0gYQR08t2TesqBhQXhhpDrE/Y9pK7U9
 7yeFjvF34r2u4TGbGzdwW978kIV8YUQMvGswnr7cSam9a/srLw2GXeCVyFr2SId+4PI2
 dNRrJFXWDU0nR0wvDvcNsOMTambUDsFj3Nm8ZIaWEApjJKYPuw3szxxSV+BLL9RVg8GJ
 oO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zdyX4MUR5OiHaBAfMH/AdP6QjGz5HJgdPnXErxafrT4=;
 fh=HYteLl9CcGgNcl+XiDn1zaxVp31PdtzcQABtjAG6k/8=;
 b=CZAphUAh5UJRTfNkT8tK0ebGjId1zGi4IfyEb0NnCVAdl7g/R/0yRobCKumKy+oe5S
 pePuSZPDenOtDY19oWOMEAr29TvPI271EvdkTaBCcVvK9rKkpWBpEObOJ3VVK1xtsaYw
 LX0OUPVpJ6J567v6HesQOmoUzhmo5oA5OrOzxoo8Uv8oRXt9IOQajWXBLz1MGHTnZosa
 Qta3aTVleXJv4JvLs7s88laFaWEuAR9p4hkRux6isDfy+8RLDLNQ6F2ntKe4t4XL5nyG
 FfuFO+OPxJbBHv4t7PqdYRyVLe5v/RQtfYoLNn+pvnZ5JZbdjdJ8u+2QuU2l2Rhi57AF
 eTJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907197; x=1792511997; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zdyX4MUR5OiHaBAfMH/AdP6QjGz5HJgdPnXErxafrT4=;
 b=D5YOnfmHwRJHcpOBFYQ73j7C8++sy9yXSdRwhscWREjZCLH/7N8GvOl+qgNf0Bz4aO
 kQDhCl6eiatI2VsrgmjqJApH+YoNE2nyzNlyfP7emnfLDtHnCp2LLOo/luD406ESAPWG
 Lzl0GByLm1fs9O5j8eRAThIoIuobdJzfQiANIMv2phyGPMQSjoDXWLBl+uQfjvUxx9zL
 DOk/kwVQ5TpYNfjLi0N99eatWcBqhn3ocIWiw2gp6JkBT/RWGj+bavo8YEbg1/7aC09e
 OaRbj+yBOJUulB3CU6y6Ey6ae61ATinPF2QP5aIdjTiXkwuwEVZ3b0xa2KqkTsJvattc
 P4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907197; x=1792511997;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zdyX4MUR5OiHaBAfMH/AdP6QjGz5HJgdPnXErxafrT4=;
 b=K09z+1owOY5vclg8QAyq/B+fEQxPx/dmbLg1x4IOLOb0z+JNUGWLDkROeMfxw0L1rS
 Ldu5ICNP1BG1ZBnRNJ3K2o4zYpCSYdZ0SCSqTsoG+G4eeDBhI2tZdlDchdYAdhfkN6nh
 QGit+mPeIw3PByS9lfFobOOdp05Zeenhb4OppramWJtSXtB9v26+qnFC0u0LkmIhsiry
 ide/bDmTmFFEZuMkrfmcpkOsi0f1XCuH45+II1qZ6NFyhDK1haMe/DviiD5nj7lrD1Ds
 NzwpcGpEuWdAe3gofd6XQRryeouDRvpOuoJYyE+CVYSO6kaA9ZJLsaPc86aXZ2XXWygh
 eyNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ+D/wZKkRs1RqKnOAEps6y2yY+IfYu05UBE6ukwbg7OcDSBBfzHTKFrMuD2bhNH00azLFaKwqArNO@nongnu.org
X-Gm-Message-State: AFq9FYKA9tOKsR27Wb0zTo0RqdVpabGau9B5aHGCJwbPu8gCEakYlwUA
 K+0+t1Z5NyMFsYKjebu4RLfDf63c3DqJ2cUT50pq8Oy4vgPyvXNMaw0wgKhBgKiX22NS7G0jAc7
 YxfzZHtiJpktjbcUpW71bLRMRyx/sA0I4/abx0PSj4Q==
X-Gm-Gg: AYBFou0vUO2SJTT3CgBppViyaiVXOVbVLkcU8Xq7g/GUi8aV6RNXfDmcR5uaPbRVmXs
 8uNQfX6S4DFWIGQabn2IHoTN4On8bJIE7pNvY+ddAy83XXRARom390Qx2vKyOWhxFZfjvyMbWri
 0bdn/qADoNNC3MmvVRPLDQcwmwu/Dn/p/os5x5hpu6v55CF413frcSkCosd+2/wi/d/SPSLifX2
 6q7KQ5r+6/QOrUF9XYigpIInVrCKGPmBlWvs2Ihay6Hkjs6Zzw0UVPR4b5+WK8sqOBfS6+KtP7b
 KDb/GUa+EoX/Wx7BFH7hw9sxB6hNo+Ld6AxB96UZbUIglP4H8c4RjnhFpJrvR8R+9zBzePt8DBg
 R47ylJM1i++gQPFJ7nEOLMqmSSb37QcdgcjMR67w=
X-Received: by 2002:a05:690c:9e:b0:8a9:a1e9:2665 with SMTP id
 00721157ae682-8b07d3c4195mr46197787b3.6.1791907194410; Tue, 13 Oct 2026
 08:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-11-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-11-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:59:42 +0100
X-Gm-Features: AclHuK9me7UkpYql-63m348NYt-T3nReypZ14DzPdifhqRdkrWKep_ta3klwqT8
Message-ID: <CAFEAcA8uN6r19nQpR4okcVGWgHXxOu=BLfvSTmF4_Je94RkYBQ@mail.gmail.com>
Subject: Re: [PATCH 10/22] i8259_common.c: convert to use DEFINE_TYPES() macro
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259_common.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


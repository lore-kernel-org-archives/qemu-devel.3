Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E85606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BgBK/wpP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnhL-0005on-Nz; Tue, 10 Nov 2026 10:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQnhF-0005iX-TV
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:23:42 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQnhD-0002uq-78
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:23:40 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso2099034d50.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794324217; cv=none;
 d=google.com; s=arc-20260327;
 b=G3OTtjalOGpslJdZROfn7b1vFOkRmpEsZw6a8JIuWS+LWAv/NgRMWrOiGM6G5c5G7X
 v6OpasVmnNcEMPNcQ3RA8lpwaevVvXXjklfqzel2OtmTbYiaPsN7yCUrY9e8T8V9SwHn
 FyADe2KlBOZOoj9NFgMFvbIRjgLZSR+mJPlTutWiLbZM43KYTjV9TfPeDRkZwoudJ5vp
 VETgvELefK72xXjs25DuzRLgJdFy0knlBY4EFvR7wxyBR0yNXwxt6hVmpauF3aK+vQzf
 X11g07yWu5ODjFhPKZi43CEWy9SvAO4R/YpUm+Efx8fZD4gnqSP5e3SXwIsYEzaXdmIL
 eyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e5waCi+Rx3RCgx9NPtUXTYJTV9yC3gpWQ0oFVef13JI=;
 fh=5IubdSx2waDO5nxBxFvddCaYm+LTYs8NhKHLsC0BRWI=;
 b=CpPQLF9eDrlf1VxBC/1eLobTpFsFG7zxioGf1ViflywiTX5H7SOlO4PdlecjgHRsp4
 NHtL/C+fc6Jt3/s8nHjBazff3SE5CdaKRWzFZxzSq9zuW4KQoTiNYwjH+Z46zjrOrZT9
 BeW9+RXRg1/rsFs6Q9pzYXJyrh+qS8XtRJH+wcGS37qa12aygz5V/bjlvOfYbGe86KNZ
 q2vQ3oFIi0gRhep9s4clAWPgwR8TfKp8IbIQ7cOUJa0TcIkMsLr1zIV5NB5samGEai8S
 uBtNlxCjMnkVUlMB2OObXLKthj64h4Gk7xiE1sMzYtlvJSs7MMu0M/+qcFztaIRZ6YW6
 1OhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794324217; x=1794929017; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e5waCi+Rx3RCgx9NPtUXTYJTV9yC3gpWQ0oFVef13JI=;
 b=BgBK/wpP1f4ERgU8K/YnS9kaV8Mo6VljPqmXHle17DhvY4FD+lMKs485M8qA++YgIL
 4YKc6hc01eIU0ARcwX0Jy0rKchrNcDeeKVj+ybG11DwYT6cDgOp9dfgfHZEayJ6huJfQ
 pUQAcLxZ3wqHq4ObmNojX0S3SNb+ScSXHG7hvjVyDsFVtEohkCdZly5+KBcUCkrEdzzt
 N7d8c5l7355nbhBVLbt6c8+UWekDI8aGG+js5xqZ9CxahdBKmyaQQBZWbtIIFo781THU
 6BzQ+N+hoBLYtHY2Pd9S8Y66NpG/J3sUnpc7wZKZD97QZ/rKAaVSkHYilwH16lrKprcr
 uA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324217; x=1794929017;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e5waCi+Rx3RCgx9NPtUXTYJTV9yC3gpWQ0oFVef13JI=;
 b=QxWMlTOOLZRITgaMZK14IySR71ZI3Xcm87A6VGqQplBT7wSPAC/cAF2sQ3P1nkZK+o
 th25mI4otoEvBhxA8qB561l4SAy1SQmE4/Y1PkU7NXcj3TF+2bsT5Ffg0imalqUv01Qz
 Z5u4AUrlEiomhStTR5EOZcamra4Roldj70NR55jDfeQ8GVn9FDahWwv1wvL7cM+wGlhW
 zmfKK0alZdmKNsTxNgq+xvUy/zajKh15Uu/mZOXJZyp/dRW+pBOzsCe+zxHfJjf0mktl
 DIMrPON5Ho57knC4ZRWP6ThATCWVkuzKcdN9uhR2qcXwe9wMs077rGNObYVPt3kl6gu2
 Lmsw==
X-Gm-Message-State: APuU4Z9hTqGv0ADP8U8EZBblXCnDPCe3q2FvfbRu+xBZgEN0mj/i/XZs
 1dFSJmw7qcNynqZPOzjUEX7YBExH3Sn5RJivqOlQtwiLMHsZN/jz6H5+DD10KdnF1TN1614kOjz
 l6oIaBVklI1BDOZ+WV0EFt9vSAr4HBfiCFzDXudUECrBThyXP9Db8i7g=
X-Gm-Gg: AYBFou3fs0QUmodjqEYL5w3T4gE6ZpaUjLNycGrbv/xodQeZqnlYNZd/QtY87SNPP9C
 uin7A9bgpqY7sA8PtpvO3I1+NJ+Tmw+Wb2SmtKI2EMYoEYwJuB2n1wsZj4yTP0bnAJt1hnnonXv
 VLV0oL03a1zPg3AHykvv2k+UNN1OpvNLbVepOQvlyKZ0tNNzO8Zg8IytKA8Xp+pKLAdg0qoOXKF
 qcwohhyv0BtL2G7j2Si+EDBmtmjFTl+3Rg0ZhTLV7JbTlzyxjDmnSM4SQN6auOfyOdC3itnjYKi
 5HxTOHuQvCpcgU4ge8EOFzZsG1DiTFPHTd5lJltPBoVlFyo1vvc2Wxh4r/tbItBpYcPZ6Uy1SUM
 EQqMavugs9M+83Wqi/YXOTXvWYP8oglQ6ear3f4ELDtKJQmcm6F5GdhCPqcP5U2XJx8yupEddvp
 ZbzBUeSV3bfZyGan0pW9JH
X-Received: by 2002:a05:690e:134e:b0:67c:33ba:4356 with SMTP id
 956f58d0204a3-67c56436034mr1983308d50.14.1794324216567; Tue, 10 Nov 2026
 07:23:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110134845.1770151-1-peter.maydell@linaro.org>
In-Reply-To: <20261110134845.1770151-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:23:24 +0000
X-Gm-Features: AclHuK9GkimsBi6LzhS67S0yd1RMpKF_mGwSnP_EDPZ_HodbaPxX7Czv4t1nKvo
Message-ID: <CAFEAcA9EsZ_pz-DuidvR3oagTD-61kkyNsEM-tthzOAVCABGYg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/x86_64: Add test for ccid-card-emulated
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 13:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add a functional test for ccid-card-emulated.  This roughly follows
> the usage procedure we document in system/devices/ccid.rst of
> creating some fake certificates, pointing the device at them, and
> then inside the guest querying the smartcard for the certificates and
> checking they validate.  It deviates slightly from the suggested
> commands in the docs because the buildroot based rootfs doesn't have
> glibc and so "NSS-based smartcard integration with coolkey plus
> certutil" doesn't work.  Instead we use opensc's pkcs15-tool to read
> the certs off the card and check them with openssl.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Here's the functional test I mentioned when I sent my other
> patch for ccid-card-emulated.
> ---
>  tests/functional/x86_64/meson.build           |   1 +
>  tests/functional/x86_64/test_ccid_emulated.py | 169 ++++++++++++++++++
>  2 files changed, 170 insertions(+)

> +    DEFAULT_KERNEL_PARAMS = ('console=ttyS0')

This is a leftover from a previous iteration of this test, and isn't
used; it should be deleted.

-- PMM


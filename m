Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18F606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V85DtD2j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUzw-00042f-MM; Thu, 12 Nov 2026 08:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUzl-0003ij-Qb
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:37:43 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUzk-0001wp-7v
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:37:41 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67bee1f693bso3948402d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490659; cv=none;
 d=google.com; s=arc-20260327;
 b=EfpPao+soJqohqgo5KVS+9ICpTDFHpopQ5ii9KREw3+CJN0r+zINaqzLrwJ1MM0YBd
 r5vpcCct5TGleiyysswA9ZoRxgYNwq9njn/T0m4gwj4+7JyyK3FVJgsR1nV3w4NyLWrF
 KaiM+NtWKw3jZ9VPs5XKjxs34sl0DJg7p0EESgursEJKaIu0GU3wgFshDTOl/5AKqV3v
 9CgQtaNjTLgCHunAtnOsKL++uTAyf+rtCoKBAbax8F+VozBOVMje4t9muElVgLTGancI
 c8LC9mad3RcMUpPcU5qmNpFNSuf7K5FzCIMWDZvb1g3ZWbsLKSmoaMHhWEGKm5lQaTz4
 nrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wQPUvIXNYS48s2Q4jDpTRSsnQIcmcLIDMkdERd2E5k0=;
 fh=wgnaPnMvYWm3FRybnSfWRS7+/BZk7xvt0S7b++o4HqY=;
 b=LaK/wKI3sBB7QJ/zza0Bij8F6MB7xtmdYibvJNKl6Bc3R2UZs5r9+qDeUxtuWgFti3
 Pztd0Ut3ZG14sDm3PqduBcGARN9P0vmbm4JeHEBzc25f5DgpdhlOChylwzc8E6JqkMbj
 3z2TVXOJsQ0nWxvNS1M8DCsSzzpzFFe4JCRC4J2Y/EJquZskNGk+ucJ5Oy0F4QFbSpuS
 Sddi0xVPTgnI7T4Lpg5PV/hem1JGpvZIsTzc0cqXZMYVjMHdQ7XF+NrwmhSKRv34Erft
 V9ncXmGtJe9Y8tMqAppfRALSSqdk5pYd4SrNxwW/nffGC/xGXnCocpERAZxhbs/D8utI
 tQCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794490659; x=1795095459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wQPUvIXNYS48s2Q4jDpTRSsnQIcmcLIDMkdERd2E5k0=;
 b=V85DtD2jffG4O0+/bWgnUFSXOwlyx/YZbEq8X0rtg6vbGE5AE5dezZ7tRmjdonQNm5
 0Q3HAfTXC7HJvF9NtDlFosIo8X2Rq+7eLEMD6pwRRjnKWI9fQa6ISPHlspcIf+qXRzF1
 NLhuucBqOMUgwxwIyoqkIyNYEZP//6QfTIq1K+6ilmjBiOIqVb7cXE/RUohNng6ZUeJp
 WuMjchKDCduwv41IOr8lMlNU+TpY1GONoPkGEgYDjnlE4be/hM1HX2WLudAwavaP7DWp
 RhhF3aTxUf3YKc2szu4LzYgLX0+f18vJCKmYbZoxeEDWIljaCWUzuQMuFKCNJwtklzsi
 649A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490659; x=1795095459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wQPUvIXNYS48s2Q4jDpTRSsnQIcmcLIDMkdERd2E5k0=;
 b=ob8yx1an9U0/bZNKylFiAAg6KuCsIZYkgqwL/QMfCBYIy0IhaAy3sFS9YsfTQq10cB
 luW4WVc+wjqzTxoYXaHL4z2Y7XynNZZHsDv5woFLQcgCh3AesKLPM9WVBxq1FYzCBjCL
 2zH7r9Xk0X14T+Nq+RKZlMexBFSLPN7GuGJ7ZuxAJDS94MHfv3pJ9AVSz1lsvIV2xYtk
 Sr1BgGPulhWnjKluK0T7QzH+6IjKny3mapOAkTf1PSaCyIA7eXW2tXWQKhElj+HctbYZ
 Ca0+Ynqiq8YChOjdx8xXQP8eFAvfbCOabmmVqwvGJxudj/aCZZ51Tx4+Vx0yUshxUa0H
 n47Q==
X-Gm-Message-State: APuU4Z9BmG6AZ+svaJ+ui7uO2XsGtllqbxU3lf44J6u1ZowhwtrP3O6v
 WlyG4a6prJdC8K1p3h8yacuYPLgx2Td6hMUo/D5w4pO5RRCIwPzmHb/zw/hdyg8C0g6M8M7JfGA
 jCo9Mxa/kz6g3LpMHdBHXo4T6+Hy7wlKsKFDsTVduoQ==
X-Gm-Gg: AYBFou3K4v0FErCS75QZNfkLub4tTBWwXz3vFe0stBBlCGpqD9QaUqOrkvizwrTk+0l
 OFKm/yf6PO4ndWT6z0d36v/jggb2HDY0POtN2qoYalmFvcjg4tSoUOoTVvpFfdGTqeCg+ZysWIb
 YXvNPBMoYe21STkQd1MAT2Iyu3+LOM0mLLYXM8Pq/tEZNMeuLSUdN1STe3Kp6SKoRJ9jAyIT8QU
 NiDrYXTxU5Iex0BhJXBggE4hxwL6rJfT0D+t88kDhOLVxlfQxL1Tlml0J4eR72TPzyTaAZpVqAF
 +qAFtYG3/yp/36aAQPXZZMPgh/1Fg+J3EgYHHFY3VZDQipRvp1YUiE87leK6GbHJZHmbBu5Jsmz
 ZO/mFQsu6/KOFTck7qdHSMa1IPKdmMTpSs3YXGcRPTvE9ZLy2VU6P9VNorThI1Oc2dLRuSo+ZA7
 Ac3I1Lh/ibGGT/VSdX/S5cu4+O9PVoBhcOaaiBcKTmEg==
X-Received: by 2002:a05:690e:4891:10b0:67a:4c43:3bab with SMTP id
 956f58d0204a3-67c67f8e63dmr3044344d50.60.1794490658700; Thu, 12 Nov 2026
 05:37:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112133320.418012-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261112133320.418012-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:37:27 +0000
X-Gm-Features: AclHuK-cqP2cgM_oSm9DSQRHE_AYyWmHEKxBSE_SSc8G4E633pLI4E1-fCSXekA
Message-ID: <CAFEAcA_qh9FuCtOeOob3GVYA14oXZAb4Pv6WDGq5pbp4k-cZyw@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 13:33, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
> without a datestamp now serve content that does not match the recorded
> hashes and the tuxrun tests fail to fetch their assets. Point the
> x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
> keep the hashes that were recorded against them, instead of implicitly
> switching to the rebuilt images.
>
> Do the same for the riscv64 6.11.9 kernel assets, which still used
> non-datestamped URLs; their recorded hashes already match the 20241122
> snapshot.
>
> Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
> Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
> Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


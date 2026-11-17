Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EC7606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QHGclkmv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTHYn-0004JC-HT; Tue, 17 Nov 2026 06:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTHYJ-0004IV-EQ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:40:45 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTHYH-0001F8-R7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:40:43 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso1177375d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 03:40:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794915640; cv=none;
 d=google.com; s=arc-20260327;
 b=HyrqO55ENxbDdtnRFHYgBWIAgkl6nJGWWc0vOT8o53oLUSpiwA1KQqmXw5K4OKF+vF
 z2sZYaij2+HP6Jwlqd9G8DUtB0y63LmldSXkgcb23mpd9iZCiDQEMm63BDbLIZow+w7U
 V2aeeMBy4ClSo7mOcgHP5qUDYSKdPDIeVSJsaOjRXIBuXmQNbIf+VZTgcRRZpvQwCvh7
 sjvHshiXjdTIVc2+Wtghe5j26nircCXcuso/Oe2Zrx09XA6D+FSIDJkcGtV+1Lx1nu1C
 u5octrvQPi4vNU3qPicXoE2lNevZd+A4Ap8Sf8XUhUlP1+kc286hTyNVAn6pjQPHhEkZ
 IsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n5VpTtuBCZi6ZrzHM+fAQtp0TXaK2QAhlH282B7aOgU=;
 fh=rIY52Jt9N4YKYbC8XYKgwutP3rlOhMn29rsslqyyqrg=;
 b=dbvENa3j97+TncvwXcyYaACpgrpCUaMnI88plX10NEVUvGZ2Cmho38+Pk7D0OQNEHW
 oOsCymWp1rfpu9cL0jjggE+0Rqju0ugtjkYMPYCa0AOugXeNLnXF47+TtkKYarlfGbzu
 rlA5QzE2ez2NnySAhQKT4C7Dgdb5zyZENbz4yTX2nBg12eqw2G7qAFsIh/41KQ8l0V/8
 IYABtKBZV2I5csSdsrUU67edKRAeiT6Iu4atQT2raU+aMJoUZluLJVzDwYYsSLV3jOpV
 /cp54QXx6un/ae1IKmYXXWX3WS3roTHMDCjAZT3y+8DUHwceZ+7RTuB6t86VfeC+8JI/
 Ts3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794915640; x=1795520440; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n5VpTtuBCZi6ZrzHM+fAQtp0TXaK2QAhlH282B7aOgU=;
 b=QHGclkmv40pVw/qXsUFgCLK7X1kZEdwW6joASPJpx1LPLJle0gZaNhkbPV/FQENKMB
 2aBuOl1q0CysHALN2W+Fk57gR/if0PEv4wh/4z8/RUBeuPzdSWUnQd5QvFWAlG2BmhQR
 qT+OMuwJmrnJUICYC86AYmCMzAFnVBYV4j9NeW/t/pEhzKkMGUZnnH4vPJNJ6J5wxGMb
 T9l/3k8IWDJxMu0ATZQlYs/bs95zvlUvD3sZ0mZq8e6DJbJybzgQVsMI5yZdhJdWFO1w
 p+SNyBBvDXJMGxBnjXnzhXiGxQEDStD7LDE+dVZsRLs6YoRMVcoIameoxfCLmYSoqmOQ
 4hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794915640; x=1795520440;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n5VpTtuBCZi6ZrzHM+fAQtp0TXaK2QAhlH282B7aOgU=;
 b=k5T8Md+EsBxKcrzV029CYp4VBCbgjAGSKMkuzxWBHuxv/3FHuan/Nuz2O7dY51G5+r
 nY1GtQ+PdVbROQJ3bxJwvztBA9iIkrFyBo+S1/1W/+ZQPtDazbCIWaQV61yXGHzIdRQ3
 OosleCQSOdwfXHC8xdy3DCaH1Jav+dPq1qIBPaZsYOHls3R55aHdIZw6YZG4VhvrMVgw
 Mw3vvrdCoOinfYkmDTKmtJpKLNuQVU4BOPMwBS0YhbOPcdwY5gWsWcZRZPk/IsCJK4e/
 ZsChOQovHqbnajgF0TE0qaZKC7GhpsgW6XG/vrRvJviH76dFhM+3XCdkDIhi6znDXbuO
 TltQ==
X-Gm-Message-State: APuU4Z8iuAiK36399Tl9VZ0RYVJA3DbEFeyO72UT7O0QIJWdwedOl/pL
 yJ4Dwsdc91Lbw3ev01o8WXGshsnvhwlZ4xB5UyOzJ03UYIUQuWyNeU9EOiMzoUkq8oir+shYbDh
 f0RlyiF+veoh020IvZp7xb66xoJ7qSGcxjIO3y01XMTuillxOG2kIGJk=
X-Gm-Gg: AZFdTZfTwtZ/JSTGX5uN2KmjKlJxMk++KIsb+sQoS0OfDctPNQD9mOsXskymJ8AIaIF
 /g5DfRk2Igz9LtRSBNJAesniGzEpqjEgd8LaqSlrPhjJxi2L8+Awi9lIdvl/nD/1dO+GZ6pPuz8
 IGGMwEKiASf2l472eNPL20Nf/FG41gSGSStjIbqN27xbOghzAsGuBE+Q7i5OXhYYFRygAJXCL/S
 btUI25zS/vV7uZlhS3f1va7a7gwC8B/9ej1gBIwKph9bOiEzbaB2oXdblbpUuZdIMD6rGGvLyRy
 B6b4ENS35cvUvwE1jPDa3gq7ExN7MxbYFEYdMauvSx5qXEnGQIF9O/Rp5j1Ik/jjQzu/a7W7p6w
 ZRi9sGqEOHEk1zZEs1juVMwc5L9z0Lb+UNJoHbrLfZ+uxCnbyhP11xXtNmGF62krElIZruNxMHc
 h7GYMdYfJ8JTSso3/yIqBhT9CVF2ODUIHFnPa/9dG7bQ==
X-Received: by 2002:a05:690e:144a:b0:679:90f4:3227 with SMTP id
 956f58d0204a3-67dc74be6b2mr1354540d50.0.1794915639616; Tue, 17 Nov 2026
 03:40:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105105816.3012283-1-peter.maydell@linaro.org>
In-Reply-To: <20261105105816.3012283-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 11:40:27 +0000
X-Gm-Features: AclHuK9ygI78LcwbaozWn9nxuc2QFmc9D168IRhWux6LjlNKVOlaNbzu6_yv6-Q
Message-ID: <CAFEAcA_osj+ewemYAt1A+8LA+LuDcJXqvyLfdQS68C_TLq5qjA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/amd_iommu: Mask address when calculating large
 PTE page size
To: qemu-devel@nongnu.org
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 10:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The amd_iommu handling of the "large PTE page size" (where Next Level
> bits are 0b111) case is not correct.  We calculate the page size
> using the address in the descriptor (as per table 14 of the spec),
> but we don't explicitly pick out the Page Address field, instead
> passing the whole PTE word to cto64().  This means that a PTE which
> incorrectly sets all the reserved high bits can cause cto64() to
> return 63 or 64, and we will try to shift by an out of range amount,
> which is undefined behaviour.
>
> Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
> (matching how we do it to get the address for the next page table
> level in NEXT_PTE_ADDR).
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
> Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

As this is a small fix that's been reviewed and not yet picked
up, I'll take it through target-arm.next. I have a small set
of "oops I forgot about that" patches that I'm planning to
send today.

thanks
-- PMM


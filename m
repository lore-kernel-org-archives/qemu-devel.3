Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08160C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa9R-0003ln-Fy; Fri, 03 Jul 2026 05:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfa9K-0003lT-Ct
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:25:32 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfa9I-0006Mh-2W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:25:29 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6647bc8f900so435153d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783070727; cv=none;
 d=google.com; s=arc-20260327;
 b=X1s/i0TTQOYRG++JndCLj969vrj3ZcsfloqlvaTqEViZiUfVAShBgV/2kJP2tEjEvf
 F9b9l8VIsrAByzmE1Zxg0mLDqUCHYZtYJm4tN6L4PN3xNsOHsAPVDkLVCheLue2CKAle
 gPh4g7KvEcGO/WI7hOtoB5uU0sHyap4k4OD9aA+oS1RUWwS9JvTOZemMl3gMe9fBcVny
 8YSVAX8E1UUGC0NqxcTiWjMMbCS+5ealTNU/Uw9TVWMwgCZ8Vf8B8Y7NJ/gm5+iqTztY
 k/3A8HTUCn7v1RBTtSg0Cf9Y68XWdPBfTCx4BQJNmfdMG7tio1G40bT1sl/aRSDkcnTT
 Lu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jqzkQJPKUaNZ8QKoHFz9ExDM6PHhmw4P4mlQft0nYBA=;
 fh=bqy0m+yeoz1XHbl7T7sVJ9T3SiBr/H2N0g77d6QNBRE=;
 b=JunXmWDhLYoibkx/F2oyaRKVjoVST5S3MRfKIdwBKf+pO8gmrUxYM5iGnYCjGqF/2Y
 pNuaKOJlGpZZo0cBWoR4GL3Hya9oRy+4t52t1tTf1WiX8tLvKRejOyKR7SuMxD+KAoZS
 aGY8nZ6GUqNVWwFnrM7ReTngt6/u986Y7R6eMltABM0ZbPE71GuQXrSEtyAK4ufi+KxW
 fSsrrjPKm6TUQnNXUFobm0dMPWEFO1PmoZswcJnrK74WbeR6D4toKTUPVoz2h03zypji
 T9SMYg9p0WcBoOk5ZzVql2APZD6UVhzQMco3gFMWHFTRyj9Zfdw2oHD5o8yyWtQErSSR
 S4MA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783070727; x=1783675527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqzkQJPKUaNZ8QKoHFz9ExDM6PHhmw4P4mlQft0nYBA=;
 b=KCFYohIliQtoLXEoEYqHkYBCInkJIGWaf1+j228PgRFc6pWx+2wxYeNuz+82lAI5ni
 CVsfHSpuDM+eiPo34Uyo9P7fzl8GmgrNvDMuxnPPBV8yRvOLlJZpF+hnE1cG7d7FLrDo
 YgwfZQwHowIcEmF/P9Y4qvT5R1FHU0y8y8h7VmuOE1GN3TkN23Kux2I0TL7f9Wfm1ePP
 5XLsTv3oLTLDVGLlgq+n1e83WwwCm6JJCXfVgNswb0dA6Vo6lveuYPEC1AejURWnwaq8
 rxDuOz9q9Oi6MN4WsjpD8+uEsY21Uz1nfzKElMk2g5ATmXfsBpy4XBo55WqN2YVzKbCX
 Xoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070727; x=1783675527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqzkQJPKUaNZ8QKoHFz9ExDM6PHhmw4P4mlQft0nYBA=;
 b=S/JCZ/UNtUWBNZ4s4XDJFGLKx8BLzgnfHGppFruA5qZIBWTrQF2hyLDDSHunjjdYfj
 3U7WDqP5ZEsXmdgJFc/OFLIKx7F5UjJHd7l/YAOQRn9hgi940uC+r7deRbLaVBdJMPdf
 sWpVSTGAU7a7sVQmTAMse4YdXgja60YkgGZguHJOZP0lBSqpc/5mlzawYWMbVmdpICFD
 lZTrLPBKVShZhAsUD9hB6B9AbX5WCo1E9PYOXRwKOUHr90LLdjYcB7uqURlUlt3BhmAk
 dIYEfzgXMG0JdtSgqbCq+wY/KFqE5nTpribX7HoOoi9vk4T9V5N8ZnTNbImYZFc3D0b8
 8vwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0tKV6H1FPUpy820immPL17M7YUTqCrh/M1r7ZANnnNaRn0mkLT/EtRYDdKMVkaAI9uC4oQpOZoxnY@nongnu.org
X-Gm-Message-State: AOJu0YyhPofS309kTFgckxjDXbQbGbEMcvC8Fwo/lchjOdJT0QO0I+xi
 vRPTsghEpKdhv7qOOgl5XO5fGM/mo/Gg9xMN1Z1LLFunARuU7P5/yyHXQfkGPi5PZb0UyuB+FfW
 hjuLrOsMjdGQLHAHzQmvEWiXkKjYrhRf24lmuNH0wog==
X-Gm-Gg: AfdE7ckJGduP+juX9g0QiBe1hQTz1Os49143kd0GD0jx4fX16eEMPRykNQiOsQoAbPV
 +TY5Dulf6dH4jrOZ8710doiWx3E93/Z9CGj+gWWnR/4OAZRWv6J08qdF94kXfmjKa9P4QBZOcEp
 sxS8EKa6zs3goChaZ++Sn+fpiZ9Az8u4HAJUsEpp8auH3ZxdXXFXNTp/C0211AoeahEiByZmIA5
 bS+teUfbmYrx+EGLR+XyQwf2oDcikk6BkphsMjzyFbV7j1GAQlh0jMqvE3u16P4gKo+fTLN1wai
 AFpsPMNVWUEzMsxuQtthukjyTE4DIWgar5oYLDnF7KoVTlnK/twLu6E4
X-Received: by 2002:a05:690e:4847:b0:663:ac22:84 with SMTP id
 956f58d0204a3-66521966d7cmr6526798d50.5.1783070726557; Fri, 03 Jul 2026
 02:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260625122843.107584-1-skolothumtho@nvidia.com>
 <8cc759e8-99b7-489c-84b7-30a6a7031b34@redhat.com>
In-Reply-To: <8cc759e8-99b7-489c-84b7-30a6a7031b34@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:25:15 +0100
X-Gm-Features: AVVi8CcEk3sC8i3DBM4SSAPthBVSN56xIqBMm0k8bxzS4Kvot7REKUQskxDwNtQ
Message-ID: <CAFEAcA8FVBvGtWYhdYfnkht9VhTtPFpLJoWCdDfodY_xXzjrxQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/smmuv3-accel: Fix veventq read returning true
 on EAGAIN/EINTR
To: eric.auger@redhat.com
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 29 Jun 2026 at 16:36, Eric Auger <eric.auger@redhat.com> wrote:
>
>
>
> On 6/25/26 2:28 PM, Shameer Kolothum wrote:
> > smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
> > no data has been read into the buffer. Callers treat true as success an=
d
> > proceed to use the uninitialized buffer.
> >
> > Change the return type to int with three distinct states:
> >   0  =E2=80=94 success, buf is populated and valid
> >   1  =E2=80=94 EAGAIN/EINTR, no data available
> >  -1  =E2=80=94 error, @errp set
> >
> > Resolves: Coverity CID 1660057
> > Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for ve=
ventq read")
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Thanks



Applied to target-arm.next, thanks.

-- PMM


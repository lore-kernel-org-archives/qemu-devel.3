Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C6DCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn9z-00062R-Ks; Tue, 26 May 2026 04:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRn9y-00062J-Ig
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:29:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRn9x-0003iw-4E
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:29:10 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651bc83e74aso10521776d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779784148; cv=none;
 d=google.com; s=arc-20240605;
 b=SkFLtH6cBePJawLufAGpjKgcSBCtmXQw8TexDPdyCOadjr5gO8YjbyULEyBlkas+Md
 8i1QpyU9jcLfhQgnI3XF6fx9tuc8f6BD3b5oYt90bmgBfijSMdOhVTknOdnPy+jHlo3G
 zOCavvQggTNaHF+CY1xB6G6Gedw81GzVqhdO8W1bsTyajZLmqEKP3EW6t70UHMptV0gh
 8oaEZaW5VRhL0N90wa7UcdDkVxZGgfqGWCD0ML/CkxCilVHwyPvAv0lkZhUYOzRU8DHx
 tX7JYDMKkcBtlCfQLjXPI4/igudVpYOyhJ2QkNmprGsH2PcDPPwC3byYGK/yTnefGrba
 hrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nn3x1RDv26LQABJq/Ywa0h1jCCRknpCEbyt+hDeuZNA=;
 fh=0TpuJ5xMEdyYhxgmah8+B0r0IhovP0nnBx9IC1o47sw=;
 b=I+ywjjA78cBZe55QFE+z0il3V0c/xQQ8o3++g0PG535EyQEOQ9wVsoQJhvH1bzcYZx
 SOrxm/laL8j3nJXLC19w0tmEe5gQBzN+9fhiHkHQbCBZ2/Fq2R6yI0BjTQZX6fb+vlSI
 hQ1JEK1N31cjE2qu/hBPbfp38zC5sNGInuxcvqgRTG7yQ6vYEFF9HLXsFQWURSd3LzH7
 63vnKVj6LExaaMC7e4mVuNpEZzGGSOEJcvLZv43kkjUpwV9o+GM69MT/fmW4j6pTma8E
 gFviydlrQ/he/vdmQcYqXnNkVetxF0pBx2R/443pbCEXbdPqfcBlKO+VkUvW7amgE3au
 2bvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779784148; x=1780388948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nn3x1RDv26LQABJq/Ywa0h1jCCRknpCEbyt+hDeuZNA=;
 b=YrSRtmfQu+eqNAlM26t19DsNXP5DGL5c7NRb7v/7tmfv7zB+pSlSF2Tcyc4H/CYbYA
 0Yid/YZfotm6FSl04sH+TWQvrswUl1QBjXACuwFNadfFQX+pMobJJNhf1n/wUTz/PO34
 ChNshSPTPXJPtE6sD5iDrafLHGvkN2uRMJegrKSJlt6dqPKE8Qo4qTtQRLyTuPYEjUHO
 bHnI88fZ+nJWoWDfXpViJmVEvo3nPK5gi/NQ0AsaXuBg4Sd/NKDXkA1T9ib5TnbBOsFO
 Ltg84q8zGzjAMT6c9AWbLcqusI965DmeVJ4PJ/j/bZviOO6CKcWX041DTw6WaXr2iQzt
 n1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779784148; x=1780388948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn3x1RDv26LQABJq/Ywa0h1jCCRknpCEbyt+hDeuZNA=;
 b=EoLwVI4KPD+ZcW+d2K8LZJlEwdth7DfIwEQhi43mxGnhcX+jAmnMkbfAbe+vmK3BJ+
 UJSIOhASg8R/NlNW2JgF9xo9dj4bP9i6jZr64lRmUxxd7N7kzMgB1Qo4I72E/3aBrSzC
 wFo6qRzo348QM8O83Uaq0pVxmXj7T2vXZ+QCLcclCSh33ge6WmhGkwru1OonlFj8Yc/U
 VmNHYKnW2BYsCSldlen+dSncLBcV6abyflmFiTQIgpiAsYgg/Ll2YYS8QyVYOMCLfAeU
 MH0MhwZtfIo8byRk6SK5F7wa25HEFkrNhMtV0fGYH3BH4E/TPyXSzHyzOFSiAXg1VIQR
 TyQA==
X-Gm-Message-State: AOJu0YyiAHDDwyFRtRyDiKn4iaFKNZEh0ag/xUf7YVSnq7hIyAEs2Kgs
 sLfripi9AaJJiD4cO00LbbqKgH/Fp+/thGfQWpHze/EbNIHwwJtRLTsG+sdBpGyNFQ+qP9rr3fp
 kjfSGjKQQaVimu59JAaS8pR7Vo/xsKDyM/IkSIlGaNw==
X-Gm-Gg: Acq92OFI66JCWdVam9bREBbBN3PzkZhW6+KYszhq2+5NwRTvBS/iENUZ3qCiHJhcyU8
 zTGXUIAAk8B+5hO8zTKyzHKrKe6wjXkELnOILA2jIyyPQIqddFZ4JYIG43df48j/2ZwXleHuWGg
 RXNqnpVmaxC+L6qdznAWNjxPHxHvdZZUvQOthh7l8zZDTBFnMxP1NH2ovN3iI0OXe24TRU6YyIb
 qXW+VFzGdhp0ecRUBdykHn39wZ8MWwzHkkaL4BF6qsBn9O/uMh/M8liXNHjR6aRK+HKujI6SzYG
 Wqt4m34UTxwmfrG+h0S+hNlK/DAhBfnErLbFGv8JNVsCp9+bo6oXdakIF2lCiM5cQu0=
X-Received: by 2002:a05:690e:4382:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-65ec98de00amr11322867d50.36.1779784147955; Tue, 26 May 2026
 01:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <0bb3f577eff40a6a834d14db94a1612a2108ec67.1779748353.git.mst@redhat.com>
In-Reply-To: <0bb3f577eff40a6a834d14db94a1612a2108ec67.1779748353.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 09:28:56 +0100
X-Gm-Features: AVHnY4JNkdDREjY7IAaV1R5uWjBP7iMrjrgoQUxcrfsYPWwSfYD5Qg7qPQIrq2c
Message-ID: <CAFEAcA-QrP0BagM6Tdk7rG055+vQ8pi0JMZkAdDy72odHcXXtQ@mail.gmail.com>
Subject: Re: [PATCH] code-provenance: add exceptions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, pbonzini@redhat.com, 
 stefanha@redhat.com, imp@bsdimp.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 25 May 2026 at 23:35, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> As a first step towards moving with the times, let's add
> exceptions. Let's also do what linux does and ask for tags
> on ai generated code.
>
> This is not going far enough imho but will hopefully be
> noncontroversial.

I think we should have the discussion first and change the
policy text second, please. Especially your

+2. When the creative part of the contribution is clearly QEMU-specific
+   (so derived from the prompt).

I don't currently feel I would agree with: I think it is
a lot broader than I would like to have us permit.

I suspect that discussion consensus is likely to land somewhere
around permitting the kind of thing you have in mind in your
first bullet point, but we will likely want to be more expansive
in describing it and giving examples of what we do and don't
consider to be in-scope.

thanks
-- PMM


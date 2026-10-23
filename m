Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0F606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CKmWIQDV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKAuS-0005dA-4x; Fri, 23 Oct 2026 04:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKAuP-0005cg-3e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:45:53 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKAuL-0002dR-NL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:45:51 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8565d77c277so5955587b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792745148; cv=none;
 d=google.com; s=arc-20260327;
 b=M7rtJ68Pnz2xYzp6idV5p+lIrDK3u78vnjWRrJcjZxGR8wsI71EL5ICdiHBWswZx+S
 UjaDI7zamvhi/w4MLup6dNj8tPOvUoLdcAwslYsfbGqH38MMS7FBSGPeHNot1VYRRPzs
 1ySMrasmh9iCCFiDUgihBwhyBOVcNis0S8cNpUyKwkyl+NzJZuQ9C7P2gODJFRHvKg6F
 5p2c1Z890bn/0FM0jo6e3uRhI4hl+/w10TW2YeV4IApsQJSnDxRIollt8zLxqP/HJTCH
 1EKV4mP5fSJbUVG08TL4m75AYfOKP/f11+9CoqTxgh2yKtdvXiwMmCPpDvAP+xsj2nST
 qbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RpFsKncesBt6uv2qX6CNQSrLLAl150uERbEwIpOwA80=;
 fh=kV0P12Qen+/Nqxw9+Zn/IM2kPD3lGrN8xGov/XyUBGI=;
 b=CWP/P8XH1Zcv6yIYGn1R6ON1NkSrpYt/KUllY5n9Mu4cyIlLPg4pesQ9DWl8Ks5MzL
 YLg6Wh2UYI02AvKB3730ckg8EXx5QsN9o2yPUx5BRdAwM3aXueO7eq99GWkq9BN37ck6
 BokkHvYLkaNF3s/lqe1G0c7TPZmiAhOlBMQEeBz0z0flLX0sIyPe1m/s3pKMU+e6GH6q
 8BAfrTeEh0rpeTHgBxc+lnSpbQvJaPqMFNSVBmhehGhhdL16CBdVxBMmlr4gihNGJ0TD
 0MC1znWhypWmMFuZkWd0u51lf4Y/87+ccm5aDAF3XlCCg4OYHhBAC4aDbLBV3d8ttcNj
 ToHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792745148; x=1793349948; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RpFsKncesBt6uv2qX6CNQSrLLAl150uERbEwIpOwA80=;
 b=CKmWIQDVMhTPumKSW8kE7OPJD3NPEp2YNPygE8Pn3QQjhtFHAeSPXMZ/y3hCsb8F6/
 BZxqkE9XzLzVXe8t9h8ya7maJIMTj6ZbskbhWzCiOH1YdA5B+WZVCKV7H21daXclnqSF
 KIXYxO0JEvXUHDtW8FFwvOi7y9OHIYp/WzSIumMKj18E6kV7XMZdVyWT5TId0PQHM8sW
 6oH/iXVSqiyI7NFb/4oyaVtf1uIZFZTz/N5DF0Vu4FKk5nBJkKk3dLXKCzFsT7OKr2uf
 r2Fisv6MYuvY8X8LRqUd3wmlxZ/3XIDzYkxXh448Onn16thTSjK8eUkTIV9Pyn7l6Jip
 Sd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792745148; x=1793349948;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RpFsKncesBt6uv2qX6CNQSrLLAl150uERbEwIpOwA80=;
 b=rU/wa+03Rhi7TNmijVY3Gv1K2PE7KxZyihGV1o178XA1pujflnGxfeg7HTZD/vIH6/
 /+5GJfBzMh+avqW7TK0goKdGJjei12PLCxNb1SZT8VU5ApyQMg/MI63O/mZ2w/5/uBew
 RLTEBb1QjqCmyBLqxIgvhSQSpcI1Vwned1pkDsXgUBWTdWwovFGqKs30Lz5ugxPHmWNd
 mKfBr7PEcZwGr+i3DPcn9cCnkniQAdOB3Gb6hcz1LGnZEqHMI1p9PBKdMXlUfFvfMJZJ
 lxCq7vV1SyGjZQbd9vXgIL0ie9xCsnlJiVqgdEYEdnraLaqNGDuPmevpZVf8Ks7R4sWm
 5UzA==
X-Gm-Message-State: AFq9FYJK0tSoKg7cY0ET5xGvKXphjAnZz1xfZdC452I99uLLkXkSetVj
 mb+OleD1BdM1z7f9OJIFtpyZfH0LVQFZNdsEGQOX6a/y3FwWA7rsFfFpWqS7lt70Vt7BBbWLeHV
 343Dtm0S0PMK2Qd6LnH4va7ACPz2APdoGQ3vcFhKqLA==
X-Gm-Gg: AYBFou3WpfQI3ssSnmperxRS02e4YMmpyttlONFnB9qUPp9fUfKybVPqvEy0jlnoHzy
 IVkJcTTcDFyzd0JPtW862UyDmWY2KO0/lA1EgeE+GQY5TnRro+8HbaLf8fH1Do9GrBLwDtDBlTL
 rTd+ghcHNfQ+LbCX8D5RCBWA1cOUb1MqPVifV/E8Y2VO299mPBJoXplOFWoXSHCEduYkMAuJ7yw
 Xr4ru2ShuelGSxwkED1Y+UBAuCmMNXaGN11UOVrc6VjcLItM1KAvtZ5j0YBPX1IxO9VhshUS5Xw
 adonwIh+9EglOnCobu+8fBrUBAageHDg+QCpQvD/ohAcAnsTl2RE2UhEM8e62cc3H4kz3FCgPvA
 801TNiT+lbfdIfAlrNX6frR7FBR/9G9NVjxKX8tZegLsMhfwVNPt7/2z1z5PL4WtdzWDFEYldut
 hdEBszZGFxyfsCZRCiCe5K
X-Received: by 2002:a05:690c:e1d3:20b0:8b0:ac08:d706 with SMTP id
 00721157ae682-8b157da8d64mr8678747b3.12.1792745147565; Fri, 23 Oct 2026
 01:45:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
 <20261022201733.1941651-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261022201733.1941651-2-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 09:45:36 +0100
X-Gm-Features: AclHuK8CyRXBHqpfh6GdSOBwn-Yw95ZXYJorpxHc16spEpaB1InXZ1Bk5AkfYZM
Message-ID: <CAFEAcA8VPcYSX0rC3V0JmvsTTe_bizy5f+P2S-x5O4GZ1=N40Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests/tcg/loongarch64: restrict gdb tests to gdb >=
 16.1
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Thu, 22 Oct 2026 at 21:17, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On gdb < 16.1, there is a mismatch between our gdbstub and gdb target
> definition, visible with gdb message:
> warning: Architecture rejected target-supplied description
>
> As a result, loongarch64-softmmu-gdb-memory hangs due to gdb not
> completing a requested operation. To be safe, let's restrict all gdb
> test to this minimal version.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/loongarch64/meson.build        | 16 +++++++++++++++-
>  tests/tcg/loongarch64/system/meson.build |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE6606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qiXPV1nH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqQI-0001Ea-Mw; Tue, 24 Nov 2026 08:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqQG-0001Dx-Cr
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:19:00 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqQE-0003f6-UQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:19:00 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67db1f6f50eso4583478d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795526337; cv=none;
 d=google.com; s=arc-20260327;
 b=hpl7ddsBa9vodC5WdMW+VTGJKrlTXcXpFKkTdBWRmg4bsPsRqrqkJHpa3jRo8FlEeE
 oiB+oUkChtdY8VKOd9D6gOYitmJ8xqepcRW2Jou+5w36y7pooFVdL3jiCTZJJREjTe0c
 3B/5LwriJBE0Hj1QNy+QkpdZJRhqBLhPHEG8kdILb3i0UkY9DB/btPhow4efBGCzQFpb
 EGduyVp54ZzF1KGs6Xy1s2lDXpR5bTYhxa33EItUQDK+8TSVtHw1TwapyEElLcRzEah6
 lpfsJlZ6wuXcNsM/NqyJ2CxFFCGU/3wmBbbpyOYYkUn7/AP0pyxAX1WYBzSqVcgfW8Fe
 ZvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mJLgmfQg+yaUTXt/+m4BfyepMSwrTG183/cfhNAOj+o=;
 fh=FEnsPW1+Jeui4H3TY0+cybeCikFuKHWTt4JZ8F3LATM=;
 b=lUMsXYrdSz+qZwLqi6YtxuaelH/MvQxB7nk7LJidrSS72JpGJ0zCsK14VfQdml+4pm
 g+rEryjpHLX2syateG2JOO38vox7J+HBl6GeGO4tPigvQiuVcqkzecRVxsjrN4Jny+PN
 OBAJNdslxUBVv74XMlseI0zufZvHUgfEYTCJcbttmR62jizIM00n4oEnOeEUGdwG74k0
 Xnu9E8HCpOTw/fwYG3v1ey2NNUWpygYU5/pwPDg02FtJX+3pSAFhlWjmupPsZlKQJdos
 ZRz56wL0k9ccUfAUyEdKVBavvOxwk18go13vNrUo1Vpgx6gzVCipytXUpsi0G68QxB8u
 gs2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526337; x=1796131137; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mJLgmfQg+yaUTXt/+m4BfyepMSwrTG183/cfhNAOj+o=;
 b=qiXPV1nH0HFSnhXl1QR3GAvcUnTiG+txVIEoS2Gty+dO511XsUUMQzUOnsn77HuyyN
 mbr4sddWnZxWixMnVhTwIWhxdSWQZDvm3erb4k79iY23cv1/kVWKVMywUHEb/ScZV80Q
 aVq7TtnQB7Gxu4gvIpjDiljtb/76LtvXzuXp3fSkYBihUjL/c6yEqh6mbp2uwpxfc+MK
 3fdSk5NjUm7k+/rTZbqZrhUR8QlzqIyASxcCEcuB8R/s0LE4Fpo3vcvDC37xLbeGRWF9
 KD9v1FqYkaXCRW/9hq0LBmxpw7l+DcPkEYksy6xM3Qdsb4ARPP2eayLDVreChfKa/dmo
 YBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526337; x=1796131137;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mJLgmfQg+yaUTXt/+m4BfyepMSwrTG183/cfhNAOj+o=;
 b=pjEYB3y2w0wzyZFlQMfgpY3pf2bq7Ouv1ei95WM8cInKknV/LYY3geJRKwrXTPrQAr
 4CRfrxhLVVDwjFPlQnawoGz6V7udqfzpVT26zk4FvMFh0IoVBWKO/o3FkK7jPrk9UT7C
 W4OfOVniYlPxEwpoqL0mT1upfWYTCVzh8Qbb9Fo/S9Qxix6rJ6Ni315r7AYa2r9T+1/O
 gKYCvfqrG54XBaMGWChPFTQy1ut1MOgSqn54DBsHLSMJM7Ske7r2FWrMa4K5Q00cP9ZT
 ZJ303tgbMr0h1Rt2WTHTGKuNXLvMFXC3c7jK5zOfXAJL0ZyqOlOmo1ExxfFew1g3mHvf
 wF2w==
X-Gm-Message-State: APuU4Z87AMtXDWUIT6dQS2K/NKt7ghPjLc+AaX0IIgmNx48stzbMoKVa
 vpR9NxSuFQICx+haHvoz8p5PkOXoFsP0Ntv5HB1N+wx7iQO5MsE+lXoYV9FuweAm9Dx13SzQmh+
 x4gpm6yxGBHyT7R4J9SFzLHZYO+gw0uPCB4MSU/jXrQ==
X-Gm-Gg: AZFdTZd+AVwExUefDXY2uJzB1ufQEU3Tar4wUdsDhjYGdiN1iNJ2SXam/MElPpnea0k
 AVgSQ23qknEjtW2wmk17S10jmTtX9yKEPK44y9rEieWu2qq/O+hkbimJhaVgNnHX1d0QE7P9p8w
 Boi0z0VLMjwvhu3qx61fzQVU9rx2Bi6eVuNZPwWuy6nI39wjd9Ldj+EefbJ+0Pg1ejFnkrmvN+H
 NuDjTFR8pARIGZA90LYLIIQrQWB/4S7FmXdKysO5F18ZAxdhC/jg2RGmTrEGQOFgHPxeVCc3rHJ
 h9wpDhFm5RjdVqT5LQVF6Qt31Dvk2KZwW/w0bVmmjNQhzIjnWz4/MRSGFSsSxJdXKl7eZLHEKQY
 JGkfDsH275iLOyysw4eSeA+5wSpHIVMNT7UtUXw7sBXa8uCfIBxnzJ1g3ztoC0cwpUlPDIsqHRC
 //EdlNBU5uOJUu2Htte499jg==
X-Received: by 2002:a05:690e:1381:b0:67c:ace:30ec with SMTP id
 956f58d0204a3-67df43d0726mr5680715d50.29.1795526336918; Tue, 24 Nov 2026
 05:18:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124130622.2296899-1-farosas@suse.de>
In-Reply-To: <20261124130622.2296899-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 13:18:45 +0000
X-Gm-Features: Aa3M54pjclVZbPpd0vYJwD3BBKMb0SJ4WXKMuReJumE52Q5GzDeHvs5lt-XTWf8
Message-ID: <CAFEAcA-g2KmgAH52gCTTa7O+xjUWoRuNxfgdKoXTbsmNM7gv6g@mail.gmail.com>
Subject: Re: [PATCH v2] docs: migration: Clarify the security posture
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 13:06, Fabiano Rosas <farosas@suse.de> wrote:
>
> We have documented[0] the scenarios in which a migration bug is
> considered for a security vulnerability but some ambiguity still
> remains, mostly because of the mention of live migration in the
> untrusted entities list. Remove that mention and expand the "Security
> boundary scope" and "Sensitive configurations" sections with migration
> content.
>
> 0 - commit 8b6405a493a ("docs: Add security considerations for migration")

What's this line ?

>
> Co-authored-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> v2:
> Picked PeterM's version for the "Security boundary scope" part.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


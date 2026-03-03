Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605ECEC1426
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxN5p-0000xW-1l; Tue, 03 Mar 2026 05:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxN5n-0000wV-Lj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:35:07 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxN5m-0002Vp-8D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:35:07 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso5053760d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772534105; cv=none;
 d=google.com; s=arc-20240605;
 b=jqgNVqrc3MFZXF+mEUOHLXlalZVB0NKAvN9aH39S17/5Wcfep3i3ql9MCji5l+Ytpx
 AIf504URx2iPK8qTDYIIFxuInnpRYJC1GiJ5Psym0CoZ4flqgOzPDG+LoJBXuaaJjQDx
 buQ1wrbydlnuQ6/LkeNI1JQHek59k+u07bhfy+BbVCpqUzfTDQq/DVD+FvRxjEtGzl2V
 KwjUONZBKV5lKYkh8pKB4rPcL90G2AACO2sLdOSaQWfFrnJEvZ7htRJ28CtdkGJOL5S2
 vQEmUOLZl9WtJVa2h5OgLmK/MunNNdI6BpaiGgE7Gr+lMvvZxUOS8xk8kS0PxR3ZEwQg
 83sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dSWjrtdeIUWh6sCdK0VCX1EPJa59CvceicwHt19+cuA=;
 fh=iPxsCIn0MCVzZ1zBwvta2nfoOcdFEZz368eyHXN4s6U=;
 b=TrAiycMEfqecKyCIOvF3wLfhTU13E2a684VrQjvVS8hvXXiKYuAi1SufYPHUb3XOVH
 1sGu8lL2/NPRYPpLRe6g+v59o0gzP4bdb+qMtyai71VKPrgXHmlnFEsaFYRak85c4yOA
 B3mdOmN/6tEtMn3EbskamGuNcg896ly420QXScKoTnaTYzNMiHUZWDy6iKvTBwW4VTuf
 kks0Q9yZ6GuQaH/qYru3q49QWvN/qxp/kiSRMcyZXg1V59n5bxKf+3fNPd2R7cB78xEZ
 qf+Z9v271m1xhLbucBZ8H3/z6i0itOopZVej5Pp/9rhQm/uDHSioLEbvQ4K0odqGvq5a
 PV+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772534105; x=1773138905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dSWjrtdeIUWh6sCdK0VCX1EPJa59CvceicwHt19+cuA=;
 b=H/gY6GKN1GL0htts8qEapItx7hgjdnMteUM0Zh7z9bhkTYYPJWZ+oC7suWMSe1xk+8
 O1AWhr+Oa7YDriPnWFnU3X2Tsskl9vcknfNjWDSQHTxzu0ms8tFdqYnY2NXy3kkQl1qx
 mfHxNdE9MW9XbAEP3ysyzMlJgHLoBY13i4QoIJWyOE5NgqtyToGp5zOKCFD/N0LlpEO3
 bdXJ5EOGnwciKYRO3/zEgLuJTj1OQEn6PIcYmeCpSi96ZRf06VbOwan8RUsqXjvEaYK5
 /BfckcP34sc47Ct9s0Ks070C4pSHnho6taWCf3cQjwXMK/igTuusYv+K5lkD3OSnKctu
 QKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772534105; x=1773138905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSWjrtdeIUWh6sCdK0VCX1EPJa59CvceicwHt19+cuA=;
 b=vmtaa/6h+yXHu1djyMJpJc5vVQHl3fPK0+W7cGAVAfDbu1wdVSTb3AxeKEBcXIqYh6
 bIZHUOMffrxdc+YPYXxMf4/adPRhQkk+84E+Ks1QpIi2fpS05eTtoltxP64cg+h4kWxC
 SigrYzulYbvKSgbDTdmWyYOt3xTjWKXwSpuNi09uwYlVhMTcgz+1PFvofmRUBhcdHYRO
 b1/Jc2gNCscctxPzwQ8ugL196tkGOxL52hUS430JtmyCRt124ApnMXIll3RpeJRlToND
 nP8d68VbOpeIORom+t5IPj248iUfClqD1xHu37a2s3iRAC2SgDPo0HjAh5AK5BbfDpZ6
 anTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnx8h59JWWYQzQwjBHeCx011B4VyzajPeEIl1YdAzA4eLaQ7FitsLx40gklgl57Q8/kAxliHylnoDc@nongnu.org
X-Gm-Message-State: AOJu0YyVT6bWIhynl6LEziD3pHyAzDzxgCjJElBQqlvYAe7BQxiLXcjY
 fabFfQGJEO/RwrUwGlshg8So4cX3guTgLACkMSaWwVmk4w9iY4L5lW0OI0wbB7dU81hz4YYKu+k
 rgdkHxlzFSxhDv5bcAhC31zgh1IOgNtvKvsr2UMoZuQ==
X-Gm-Gg: ATEYQzyPPCxfvFhBwVaQnJKidqc4UiLIWmZY433TvP+a/14d50a7vzPtqtxazljMJ8p
 dwSzcmvITU5Bk0A164RaAJLNwck12embbMXbbdJ8OWVZ7vAERrlirWx8hE0emz1EhJCgadBAJIq
 9DkKwgmlWp05WoUnbGPvYT6C6gka1BVgyxQ6vx9seq03KTVjtj3BeAkHtGzNXPnxjABF2JHcq0k
 XV0c63x/xg4kIXvElnD2xv7Wzm/TFPw7lc24GvjUNQKolyK/U0XhdwhQlCoxfTPO5tE3fWqM/tk
 gi561fArhOhUTczxd5VYFDQUkN+67tMQW7RKQDsw1TcC40+3i6JnlX1R32cDm6GQqkE=
X-Received: by 2002:a05:690e:4499:b0:649:443f:ab2a with SMTP id
 956f58d0204a3-64cc2183cecmr12149354d50.37.1772534104664; Tue, 03 Mar 2026
 02:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-2-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:34:53 +0000
X-Gm-Features: AaiRm52lukkB_g8SRT_SQFgiTlm4nV64BKKWCDx_0jgabEpmvBpQqhMfVLzUwYo
Message-ID: <CAFEAcA9Mg8fdazeBtrg88k5YYHDyYNsWXWZsPfvo5sWcYGitog@mail.gmail.com>
Subject: Re: [PATCH 1/5] vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 26 Feb 2026 at 10:02, Eric Auger <eric.auger@redhat.com> wrote:
>
> Already existing VMSTATE_VARRAY_INT32 requires an array to be
> pre-allocated, however there are cases when the size is not known in
> advance and there is no real need to enforce it.
>
> Introduce VMSTATE_VARRAY_INT32_ALLOC as we currently have for UINT32
> and UINT16.
>
> The first user of this variant will be the target/arm/machine.c cpreg
> indexes/values arrays.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


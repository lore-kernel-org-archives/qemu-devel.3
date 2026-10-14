Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01FBCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtww-00037J-9W; Wed, 14 Oct 2026 04:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGtwt-000372-E2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:02:55 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGtwr-0008Br-QZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:02:55 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-535853983f0so37804961cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791964973; x=1792569773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L3cABIiGOiPelqqPLekjpwWSa/rVwb/3RNOT/UdtY4Q=;
 b=SpNQ9eAOpaNpxYiAl6Zz0bvdcZ4IOwscWyImEpjrLFmec0CCG4UiO/U5uyEP7zpsfZ
 QcWhiERoQD/38nyORMgAr6pGaLx75ZhNlM9QS2t/EJc+qp282jAYH8JA34PzyFPSzg//
 paJeOoIRfzPOv4gSf/jtdiK4qI1dMZnSUHM8qModZt6Cw+wGDo9jQGvGudSZ8NZoeI4D
 QPTa+7H/k+pMqezjVIyEEi/Wwii8kyDBGsSrlPW61kCcXxA5kIpBcdS0H4a386slgSSd
 04UvGxR1XA8NbjC7d/lqSoZ81ncYoywsn1wFXzar7cBRd9JjRDZjU5uROvBGnzHMBfQd
 CoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791964973; x=1792569773;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L3cABIiGOiPelqqPLekjpwWSa/rVwb/3RNOT/UdtY4Q=;
 b=0zPfdqyxrLNkGtYGEQho2Jq6vVJdDm4wtdYk2iojPaUtuCo/Bn5WGozzaS/cG55dAv
 x751yg69Gv6eIUvWTGj636MBG72r1zWnqflKYw+o48RElDuH6B1rAuC6S6xgmcSOYxPG
 IRKYa+dKal/Qlew3OT1Rc9GsXHWIc+5WRCwYjOezVC5lzg6pYkoYWILGLuAMU25ioFO7
 O0ZCPwT/PRlMppCk4Q+vKy4/HhsTTA03Olob8GXdIoKkl78SCqd+8vIPIkCrsn25CrUQ
 UDbgIGj5ZnvUC2tK4rxQbL4hQnkuJd69tOILjGtwR4eXAtRIS3+S2nhgjxfwmDxeaYKG
 gmuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxaBu2uqYYm93LiQvELc5H8F6lsk913bCJL0xrhsiHnhC/KlHxOJpYROQ/fNeY80Li52VZnKM0rW+s@nongnu.org
X-Gm-Message-State: AFq9FYLHyGCvLDJD/nadrWR4s/e+zgpS3yq1YYWHryRprO/JWKq96o09
 /afFKdcK7UKNGO9bONem0abPumtSya6O5Cp/Krxa/50iIKfu5DAVqKInHk5roW8QUWqSQw+OA79
 DPNDZYj4=
X-Gm-Gg: AYBFou08UJERthlJdwZ+YzYT+M8S/9bqOhbcz23XYxUZvTVhnD3Q2CDhgrHFJ3QrdXK
 bPT3C+WvxF/t2W5nqiO+uU6du5TqV0XD8RMhvqJfeqRyKQXRpVlORnGS30V/TCymXRMb4EZEcxn
 wML2dIy/yZpSAS4Q1vfejJEsgtd7uaWpY8dj4buPsXCNmbHrrybYt9zfMgJQ61l5jEQ0peQYxOf
 jN6n4BqSuG0yagTwqwzkNj7I4SrWZXlqnRpSEIukMvWVfwpQULcFkmvZbAMwmQVwnNHueSRAa/+
 lpW5ZmYXDAZsf4U+XZxjl8FSpra8xU+Fajo2IZYEvbbAXAYCIk/lkKZhnndq4TPB2DDK6sYt3+I
 cZllPAdZFbiNV5sH2PZU6j186EUkmkCbENVHUou60kmZfRusF8B/o0Gc9Zx/SK9WFqPemcTzERm
 LKj1MdbN67PPYFuU7lh/IJ1RmxvCTiywUvreW/pLHrtJYBR2PDqadHkAGQdhftiCKXylPPvWwcB
 Q9Qq6NRMCW2ytwYwC/k0e591Kqae8pajpka+nE=
X-Received: by 2002:a05:622a:5587:b0:535:33a0:520c with SMTP id
 d75a77b69052e-5359f48bd08mr245746361cf.3.1791964972544; 
 Wed, 14 Oct 2026 01:02:52 -0700 (PDT)
Received: from [10.86.151.227] ([172.56.181.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97bce15csm46819266d6.35.2026.10.14.01.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 01:02:51 -0700 (PDT)
Message-ID: <f34e4a10-6673-4d18-8e51-ce4c8f17c398@linaro.org>
Date: Wed, 14 Oct 2026 10:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/15] NBD patches through 2026-10-08
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261012212945.84275-17-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261012212945.84275-17-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/12/26 23:29, Eric Blake wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v2
> 
> for you to fetch changes up to 3d794bcd554c3dc196685faf382fdffe7243e674:
> 
>    iotests/iothreads-nbd-export: Skip on s390 (2026-10-12 16:23:50 -0500)
> 
> [v2: sending only the updated cover letter and patch 2/15]
> 
> ----------------------------------------------------------------
> NBD patches through 2026-10-08
> 
> Several fixes, including:
> - Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
> - Fiona Ebner: Report flush error on qemu-img convert
> - Guillaume Vinke: Fix NBD client on dead connection
> - Denis V. Lunev: Fix postcopy dirty bitmap migration
> - Eric Farman: Several iotest improvements

This still has 13 job failures, including check-python-minreqs.

https://gitlab.com/qemu-project/qemu/-/pipelines/2945631627


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C7CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H5I-00013o-JK; Mon, 29 Sep 2025 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3H5F-00012q-Rr
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:50:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3H58-0002Bp-Vg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:50:41 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3324fdfd54cso5118240a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759164629; x=1759769429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TU5gSdmkNyV9pB/57smTckuZZ42nVLK7jGUclAwjB1Q=;
 b=n1lBwt4iW00rMQylY1niRNPwKgfaaLvqJeMkWlGVzMsqLPqgiztncnlRuMAbIAp1S5
 h5j3m/2iolJaM6sy/CVgA9jDUJrDzhYqI1Dz1mY1b2SEtGq4uf7+BrGQHWDfYwjg1ccq
 jA5cju5C45id9uBMNf+A3oCaiDCNv3x3iBLkJtRk2RU/D9uRR4fITJf2sdFSQHOlh58T
 8JTH0Zw9RFjEFmWYe40MDsNlxsji04AlrxgF8G3dt1Ct11sslzYDvllXemdvDRdDp7B7
 8ts8tTmpcBNd23oVPshPQvcCLjWBS0E5bUJCOdTs6XhQscjmbfD3MjkEB++LkBwjAbuM
 cH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164629; x=1759769429;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TU5gSdmkNyV9pB/57smTckuZZ42nVLK7jGUclAwjB1Q=;
 b=q2YaCwA9yAMsAeARjQZQKzWHCqF4pcjWT+Oj2rV402BYduoRaWKbUGQfBPuJpDCQzr
 9r8+hvbS+d8xCUio2fkP286hZo1B00TgfNTBUgKPsGzBzwz/gifYhOr94I3nIxQ/PH/r
 cn8ycG2Tnq62XiWgfjwh+9emSk5OhL6b0BM6vxdv9lVh0+ssRBUZflm7gzCS1X7Eacf2
 IAqxFqb5tLIRnzauHnz8Rgl5LnD8ThuBw3gkHy2P3nLDN3ikP00gCFMcpCBY3iDW1Myn
 fBHBVK4I68ymtv6pyyXj/XAcOIJqu4LNLZfHQFdZC1qURbr/8bHMEkMciifcZD8W+FCh
 sAEA==
X-Gm-Message-State: AOJu0YyqSfkBvD11eECNJNDOl7GXZyeKhHR9K6UNbNbsCJsIW8eMlBWv
 0ZYqyIveUiIqpSKmJBzpcwr9BSha2axXP/d4O60hm6LdAbsSVdEpYeBqFM2Wyi+aBA039lhJdS9
 5MHrP1oo=
X-Gm-Gg: ASbGncv81epmJ4LUQgmI/7a003T9+bDVkzmQ4zaNOdTbpz6ZXRqZPxM23+Z8mm+2vef
 qy+dfcHmsYBO7KGBkQE2OMxSuXLqM8BkysmiJSX+N1uZd8PuEQmxATldjyhNGtts6++sz/9aJmi
 B/1FVdAoLH7ww4EuCCo97tE7oesmjRffOqaPK9xJbW7OfFPhjZ2HavMwPDAVee5RzF06aW5RUaC
 FCbaodycducsLEXax1eoC2zaxjqX/tFKluemhJKdjFHwVDmEaV4s3Ucje9lzJ/F5eYEhAZH/ITj
 qz6JT99kdp1SiVkd1/pVLMEEW7K5ZJmwZY1t8tu5iCzHsJIth9fyvNrNlyDU0Vu20x3SQ3PPKS5
 J8tFsBoodHhUy6dkQ7YvmHXmIf0asLZEAJct9pDtKmHZ+/CGDHQEJnpu5iTDhM2QInVk7M90AaQ
 ==
X-Google-Smtp-Source: AGHT+IEsHFN6ymq2Ee7PKSMoGiS/8oXTQOf7sxlIXCuKOvu8DpeM/cpDfOIu0iOUsuslFSF8gaE+Cg==
X-Received: by 2002:a17:90b:1d06:b0:336:bfce:3b48 with SMTP id
 98e67ed59e1d1-336bfce3befmr7107365a91.9.1759164629114; 
 Mon, 29 Sep 2025 09:50:29 -0700 (PDT)
Received: from [192.168.176.6] (51-148-40-14.dsl.zen.co.uk. [51.148.40.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3383863e7c6sm1810232a91.0.2025.09.29.09.50.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 09:50:28 -0700 (PDT)
Message-ID: <e0bcabd4-b342-4a52-9e87-a903724b069b@linaro.org>
Date: Mon, 29 Sep 2025 09:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] ppc-for-20250928 queue
To: qemu-devel@nongnu.org
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/28/25 12:26, Harsh Prateek Bora wrote:
> The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:
> 
>    Merge tag 'pull-target-arm-20250926' ofhttps://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-20250928-20250929
> 
> for you to fetch changes up to 6c51df580d2a64b4e1ef7bdbffeb3615ffe25d43:
> 
>    target/ppc: use MAKE_64BIT_MASK for mcrfs exception clear mask (2025-09-28 23:50:36 +0530)
> 
> ----------------------------------------------------------------
> ppc queue for 20250928
> 
> * Support for PowerNV11 and PPE42 CPU/Machines.
> * Deprecation of Power8E and Power8NVL
> * Decodetree patches for some floating-point instructions
> * Minor bug fixes, improvements in ppc/spapr/xive/xics.
> 
> Qemu CI:https://gitlab.com/harshpb/qemu/-/pipelines/2068351418


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


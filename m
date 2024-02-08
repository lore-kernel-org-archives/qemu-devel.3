Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7C6C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7CI-0005u6-Rf; Thu, 08 Feb 2024 11:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7CD-0005tL-CR
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:24:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7C9-00043l-UO
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:24:16 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so67030a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707409452; x=1708014252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1/3N8kqMv5Z8EP+nClXyaiPRcwz8IMdFCYnpkvoizU=;
 b=ED1y5Au8cmoMxgIGp49Sg9SW3MFN0A9SuyD02vhn/Y2+h63hFgMs8nBNSL/QEh9JRa
 kOXlKAKOyXVRBaJsRzMYd1rPjbfeP8KDf5l8e8qCx9jVUR8G+OAXgyBUlXNMqvyWj4FA
 LIlcdSMGv2HV4SpPXqYOAE2Ti9OeNisprtFuOMuAOCvZRuVlXW0S2/+e8Z6MXpxtewQ2
 M6BMqdAqW+/xIjTSf8PLnn4J9CbQ0W4pXKaj+I/4MD/kguctqiZdoqif5bRCEYUz/MWD
 98+WQy40ruF2poFQe/MD7VjzLOyAcZn6JlA13Iol8iqWDpN4hqAU0B2keAzYdjhZn15S
 fw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409452; x=1708014252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1/3N8kqMv5Z8EP+nClXyaiPRcwz8IMdFCYnpkvoizU=;
 b=w+1ucXGQ4laGb8baZkINc6RI9JhfU4dRKMQW81k9oGaoLRwZlkfbRWUnnzIkJr/+fF
 lVtTMBSgERrea+Jr1MzA2/NSzxKh5UObcP1z6EEzyfJRaJ2ik8eYAlaU53vyVjTOE57M
 9wRzpW9XhgjyIrVbzNAQ+Lsv+k7Go1yp+vXMezJOsSTEMfPRRJR8H9MskIFnxJlijJwd
 LZNAPQfhZHQt5bhi7f8kNECiEZUHeFUAcnpMfeOhEbmvtzaClIwoqPNXciCttF9W16Kl
 hpK9yyhblZauCcCRVf4a0PYt2nBthGoP+Exm1jGyC+yzdcWJktSljj4L2If1T82ZDrDv
 uMTw==
X-Gm-Message-State: AOJu0YztkM5T/aX19U7D3jrVo5phSJBkbvb6HO6usxVaLcWCxwwtyNff
 1PhIB9fdH4rF8pxTiBcoS5RUnnjRWVajypSWmqmwjsqM5FYQx/mhg7JWyyyHonAJovO/H/vza7/
 FyU822kwGhVvR6QgEY9t8HnO4hgTTqhs11x0ZiA==
X-Google-Smtp-Source: AGHT+IGOv1z3Ram/5Dyy0eUje/r+2L1L8yyKR6pKXlv3RD9BZdAhF7Kuf+H5I0jehnX8LS3h7AtjssXXzJszq83MSPk=
X-Received: by 2002:aa7:cd04:0:b0:561:1214:c9e5 with SMTP id
 b4-20020aa7cd04000000b005611214c9e5mr1475075edw.12.1707409452260; Thu, 08 Feb
 2024 08:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20240207025210.8837-1-richard.henderson@linaro.org>
 <20240207025210.8837-3-richard.henderson@linaro.org>
In-Reply-To: <20240207025210.8837-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:24:01 +0000
Message-ID: <CAFEAcA_aVb0a3=fxijwwrQChXZ1MXRVyx9ChCHSDMEjQcMYrsg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] target/arm: Fix nregs computation in do_{ld,
 st}_zpa
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 7 Feb 2024 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The field is encoded as [0-3], which is convenient for
> indexing our array of function pointers, but the true
> value is [1-4].  Adjust before calling do_mem_zpa.
>
> Add an assert, and move the comment re passing ZT to
> the helper back next to the relevant code.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


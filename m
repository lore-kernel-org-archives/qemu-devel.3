Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663BCC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ssi-0000cy-6H; Tue, 15 Sep 2026 09:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Ssd-0000cn-ER
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:07:25 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6SsX-0005N2-NT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:07:22 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-864cd11a932so3993127b3.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789477634; cv=none;
 d=google.com; s=arc-20260327;
 b=H0aGoGVbUakLoLRL0U1G8W+EGQLiUosEmOuEVyO6NY5qQJ/tBvACotc8nBmXdgFEIN
 sJgBYp/Q9rLcQf92qCWUedNCa7mDk7Rh9Js+tF+3w1GnLrKdl8wP4IBKXMUqleC6CiH5
 nLN8CjTLR9dDp1dpKvgcNrAkHj5VF7RGLzmwxaVYpZWkzrKc2UeWu2BPtbGW9aGiLTpe
 GlPlfLsVm2JzGst+2yNlqa9x57gl4Ppd2kLhnDh444EX2ejzTougVb9b1Tzkpu8q3BGo
 Bcx75hywJsti7tKUE96309LX1UbE5/vujJPKqTNIIl/nEY/TEg+mqyQno2W+/cy0ECcZ
 vmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C5e6aiAKV7rnlC1LEkdzB4WDWu8xhaoG/qz6B1jbGPE=;
 fh=cXlu1n/FtA+ancPBniKYesW2UiXK4sHJOzQQcAa0reM=;
 b=nv+r0/LT4vjzhU3GGhNx/jsc8IelXxygukNatzGqBs7GC7nnTLBY73QupcMG0uiRRA
 o51NWy+hK75udFNf/gTfLRrr/kk77taGDbpWkihBPOxR90ZcZ59n/eF4N1oOrncVXMLu
 HpdICzwInR40YThA8P+iweMhMA4g+7n752n+xMXkbDwd8fYvUsotZBZ4adoUTDXO+hc+
 zAHlsh9jtfOjLGW+wyZx2QGf2+WLVqQbJ7USedyl78MjmXzwxP/E0GsQSgn19/yD2ngJ
 WO+W2CyVxJO/2+H/8Mh0/dq6ASzVpeFiJzHuzpyVN6QzJ28mQF+CYaRvbNDm23Ycjzzw
 7YQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789477634; x=1790082434; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C5e6aiAKV7rnlC1LEkdzB4WDWu8xhaoG/qz6B1jbGPE=;
 b=EhdL9boFgpf/HnsoovLSbyStwtJYVw1eSkW0U0U2k5oEORrtgKb3LirbaIRsfG/gTr
 zjckQuuGQkNe4Jn2YGVYB6zokRVKqr+oEReiuDWvJXMohQ6i/zndclGh1Islwzfzb6sH
 7ScdDwQ9ljghia+pyDhQpk6St4NxSrc7+ehCSiBGB3lxW5YejpnFYRZRPQaSSR3JT2W6
 HwfNXGWSPT6KqEUik+U7rRDLWvi5NvTNTekxUe3rTXRkvDcSet4uAMJxDQP3cQRa14jt
 vl7dh0c6qOOB6zcoaHHZdcsZLfhPNVBiiy7yvQAh4VwGa3Behe7LFsYYQ3Xgs/alwE9e
 IKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477634; x=1790082434;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C5e6aiAKV7rnlC1LEkdzB4WDWu8xhaoG/qz6B1jbGPE=;
 b=EXb+sfhTJTmfVkg8vbq8iESevs4hYj9Pa2acWRe0bJzYdjek+9PRPsaDm6Ul5YKW+O
 bJlhMdVMA1m2Vg+4YTculD7jHDbjoiRsxoVf9mAaDwwQE7XMkA7u8Cf57p0Rcmb7o7U7
 aHr8U6mNT1oA2VUUXCRC/JgIsudColb/x/T8XxIMk1XoINgdzMLbz64p8q9ELEdqvKK0
 FEfhHjwIkQu5HJbVLEu081QSWrcTUoZcwsgVOSJXa+vKofaHS3yWiEvaeZ4vYlM6FAkw
 /VnYkCR7KzUDALKg5qp9zZ3BnMMKDSre2c0Qiks8GsWf99u7smc6VFsByfPf8eXpkopY
 48mA==
X-Gm-Message-State: AFuF++nBL7ul+fN/osf2ETcx2+EfPlzrhu2fIiTtN5l3swN/oHEY50HT
 yoDsz2LN+vL4jlwqrKgrlrqAJYmNjdD6IlcvgVqFjbp96mnBwdDFWefdq2LmcsFgGNPRb/MpEOM
 kqerg0uHwFcEjvL3Vk/sFSjnYYQZEDF9EYNmF15vDpA==
X-Gm-Gg: AYBFou225xy6PFkoNt0vj58ofhe8yOjuI1RBUwDUweli6oH9g+v1gu95AM/a44TeRz8
 6OLSnYKqkUDKxKZjZvUF5Jq9ylZ5a2SbxZIeBoiUn51D2fuJgQTiZusfBXqWpy0qIPThS7nwlqY
 g1zjyOvBWMLvvJuf2dajZk5Rfkw0ZcFJOSJDNVRTQ0PDNsbBH9qS9U3qWqRx08w/CDU07ZLqbGO
 Kpqi1BOpsfv7oNmzw3T2NhsYKQBT5Met/TXb837vhjdQIMc2hw3lnA+TumfHZUmIa3zQeJBQO3W
 2ZOE4Qki2vRvUtVZ7hw5voBCl3weDwIqPPLBbazBg8HjPlOTnHDG6hL0Wj6o3d1mRiB8f+kzdJu
 TeCeE6IxGyw2Jblfv1dIDaFRTJnNYTRcxyulr4jk=
X-Received: by 2002:a05:690c:c511:b0:861:7cb6:5790 with SMTP id
 00721157ae682-88f15725b85mr8702677b3.4.1789477633981; Tue, 15 Sep 2026
 06:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
 <20260914223159.2735262-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914223159.2735262-5-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:07:02 +0100
X-Gm-Features: AcwNN1XXyamuSKh6qEe0P-KdokFEj6A7zeG24mDbWagm1DqKXtj0J7n7QyP8Gzk
Message-ID: <CAFEAcA-BeCMPhvHLG6Jkz9q68ZJUN36diepWvEbhN-+RxZtVQw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] target/hexagon: add directory semihosting
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 14 Sept 2026 at 23:32, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>
> Bare-metal Hexagon programs use OPENDIR, READDIR, and CLOSEDIR
> semihosting calls to enumerate host directories. Directory handles are shared
> by CPUs in a cluster, allowing guest indices to resolve across calls.
>
> Use lock_user_string()/unlock_user() to read the OPENDIR path from guest
> memory instead of copying it into a fixed-size buffer.
>
> CLOSEDIR clears its slot in the directory list, so a stale index reports
> EBADF instead of dereferencing a freed pointer.
>
> Also add a functional test for the new semihosting operations.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h              |  14 ++-
>  hw/hexagon/hex-subsys.c                   |  32 ++++---
>  target/hexagon/hexswi.c                   | 108 ++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  11 +++
>  4 files changed, 153 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 62398eeb359..58bdcabe87e 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -11,6 +11,7 @@
>
>  #include "system/memory.h"
>  #include "hw/core/boards.h"
> +#include "hw/cpu/cluster.h"
>
>  struct hexagon_board_boot_info {
>      uint64_t ram_size;
> @@ -159,6 +160,17 @@ struct hexagon_machine_config {
>      union hexagon_config_table cfgtable;
>  };
>
> +#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
> +
> +struct HexagonClusterState {
> +    CPUClusterState parent_obj;
> +
> +    struct {
> +        GList *dir_list;
> +    } semihosting;
> +};

This looks very odd. Why do we need to track open directory handles
in this special per-cluster structure, but we don't need to do
that for e.g. open file handles returned by SYS_OPEN ? I can't
see anything in the semihosting specification that indicates
that SYS_OPENDIR has special behaviour like that.

thanks
-- PMM


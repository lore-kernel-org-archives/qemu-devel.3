Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C0C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x81xo-0004KI-FJ; Sat, 19 Sep 2026 16:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x81xm-0004Jq-Ij
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:47:10 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x81xk-0002o1-WB
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:47:10 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3a2015bbfceso16430191fa.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 13:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789850826; cv=none;
 d=google.com; s=arc-20260327;
 b=XE2Ygh53h0U/Y2dKNK8PyaC0C0Fu40xqN875miS0ngyrIm2oLVC8WRcVDkFE9N59Zy
 5NqfmzVoH81KCfLpPgs4tHy5/Ya3hl49SZMXv4WdBzhMOtb5fVb3kvG+P3JG9XTc1Lm4
 66+0JbNSXvHXaHClwrbS7/ll60l3SFFuHuNhUSvQLqRfNLbTWhTBkOpkBTuOwANTRjD0
 uslz9kM/JHqNB/0m/jWWlx0vZuI6irnCEUgSIqrDbmqcXsiRXsAfdTgAG0XYU1QObiHi
 mArq5F1lptn3UukoW7drza5Ihv+KO+01HLBAqaA66IF8IzrQPUyqgFHjCHpgN7A9KVir
 rFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MRpZvDF4qcnUPCIdeAJ5M6y+eqmH3zFo/HX9/kYUU+Q=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=LFCPmsPbwuyPeayjJ5iT7DjyS4dCh9SbgjaSvcS7SVMirN/4gOkA2oS+Z5Ma5CjF86
 nmrjHvVSVFS4O+PCSczIGvunHwnlJb9v4DAfgxP2f6MwEQjbfJWsrVulmxBIF5qQ0rKN
 AchXAC3h5lM6y38VrJR6iR3sAiAWOp9J/ddUvt9xHVlYCPtVzMoZfIu/7tW8T3XL0Dnb
 h/tdIxUfI7X3/W+OxUvCwpen3NNZyIM8lx46rI25jGcDfiictvtFFiUUuXJMwm0hxzHw
 FZG85c0QvYPbFYQFmMfLOw8olN2WGwRtQ9gfsaz98fSpHoqrj24z2Jn/DEwbjCdZExdr
 xVVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789850826; x=1790455626; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MRpZvDF4qcnUPCIdeAJ5M6y+eqmH3zFo/HX9/kYUU+Q=;
 b=iFSEeKB5EegrBEhKCFASKuzkRcsxhqgwfgWSsPXiraHBlBSt8E1w5Cx5msfjW47OtQ
 ahhQMPNEXBL0OFDdmvQZlSvgZ1k5l08YMRgfCtlfmQnykC8vg9DgsYJBFcds/5HMsUuM
 r4ZM2QdzBflUeSn7/G9maCprQ4Wsqd6duxKNRrMEJV9Z/Q0hBkpk0M84Uf36qIWWXWCQ
 QgRe8Rr3euYfgEnGGnu/tGUrcXmYFAfAMiXdEvFQQaYD9OYncRxQUrq13lL6s1J7StEX
 7lNVMf7Vg+XM7+tlZjI8XE1IhtuIgUiTMM3vgIObXAoLs9Qhav7IKRz7lrh9v3fDl1qk
 xecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789850826; x=1790455626;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MRpZvDF4qcnUPCIdeAJ5M6y+eqmH3zFo/HX9/kYUU+Q=;
 b=Jld20guLyAIaF4SyXIWlOzJ/Yg6ql/mlcfx4TZqTk2JNGTYNXZCXGJGBv7CkNqte1T
 OFsoWwt0q9InUAQ4G9stQA4CVBQ1cubcEqUmeGDIpAGfcCk+yVRL2kwBAcgnCttrQa6N
 +QDC0QAsIcdgBVPajmwxnFRssE8mpjWt4ueKTsbJEuQFpR4ULtooG0PBCQrYNG1oX7YD
 PeyFHfsjJGxTaAWyKu5EV2+rwrJT4xz6joDad6Zz+PPNgxKp4DfzcfIIGlDDEgqfb4nL
 nBbl2hDOrGMB8gpeg3W5YuYVwHonTwU9jis70X+V9wKyWCW7ALpNaKsCz/r0pxjk2mEK
 rdqA==
X-Gm-Message-State: AFuF++nHoyzXBMKgxAWAngtOEQS+hquujp2qIH1PIWFFiAfMTYVfE173
 1JC4j1c70zpt0eE+z0TZ11+foDfXevdzACyohoVAQWhWQ8aWV1dzQ4YEJbY2x3hnaicXHZKAEY2
 dkiXzH9e/nYjfuUsBo0OcPUyF76DHVS5GWRNNmQM=
X-Gm-Gg: AYBFou08Q7Opfvlnwu0ZPFHA0LSSDQuAqrhhy4KRWxz4Q0cDy0uK2xbJjIgaWmbkDLR
 52JgCj6OyEl1LlS/LWzbPl5jxgp32Dii/C7YPH8tiFhQVUEam77YXQK9DjMV1RCPqtvafC2slFd
 jouR9JUU/6E9PzE8+oh2vv1WvJ2lvQ3UuzYBYZHhlXy4nw1A5kovAXA5Q2QWX7ruyfHVaK2gP2K
 /ig46pQ5fz9YCFmfVA9sJGbFKihGrzfgeXPn0TEls+PdGs7feP6FXjNiLScps7cCeiF4k3k7V8Z
 2KyYnDl5tYQ6WeNBAiWh8n/k8GmDFRsd9CpO4fM1vUkqqaNObw+xH6OrgHu3oVPAhaIe+9o1Sor
 8JCcFi7kziQIzYTCwafisbvve
X-Received: by 2002:a05:651c:a332:b0:3a4:8e54:562 with SMTP id
 38308e7fff4ca-3a5e72887c0mr31309221fa.7.1789850825469; Sat, 19 Sep 2026
 13:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-2-richard.henderson@linaro.org>
In-Reply-To: <20260917082618.1076988-2-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 16:46:53 -0400
X-Gm-Features: AcwNN1X3dovx7-w8rm-uxXgnyTufhTuy20Yj4b0wDgbjoQHpkQuCtnILs_kRvJM
Message-ID: <CAEdQ38Er2whRT=rGW6gFrcCnnTUOMu5ubvpNd5HKD_q6hFjK6A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] accel: Change AccelOpsClass.update_guest_debug to
 void
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Sep 17, 2026 at 4:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The return value is never used, so drop it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/accel/accel-cpu-ops.h | 2 +-
>  include/system/hvf_int.h      | 2 +-
>  accel/hvf/hvf-accel-ops.c     | 3 +--
>  accel/kvm/kvm-accel-ops.c     | 4 ++--
>  4 files changed, 5 insertions(+), 6 deletions(-)

Two other places need updating:

  accel/hvf/hvf-accel-ops.c:266, in hvf_insert_gdbstub_breakpoint()
  accel/hvf/hvf-accel-ops.c:306, in hvf_remove_gdbstub_breakpoint()

With that fixed,

Reviewed-by: Matt Turner <mattst88@gmail.com>


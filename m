Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C73CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkK7-0008Cm-48; Fri, 16 Oct 2026 11:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkK5-0008CP-BC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:21 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkK3-0008W9-Nx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:20 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b094046a7aso299347b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166298; cv=none;
 d=google.com; s=arc-20260327;
 b=sFS2ofjOf1DI7fyPAW4mNUs0zeo0iEr3CGxbCrQV0hOiF05y6W3ortEG27+suTj4q8
 /PC0A47g6yToxDRFoKQIvxC8sqB4VzsNRz1A6YQe6MIhwQxRyr3BlIOclM03+oldof4R
 ey45+85QhZ7LurjeqNAKfGj8zqsDmmmWazynptwajlm95AxzzmmDpJnnmoVa7Mtw5UdU
 hnp7qhUflszEqLXh2fMQUYsEXAYtfl26IFedPbkCFIGNpY5Csx1X2sq/or6BOWgvAX0a
 EoApNmucIVDLPDeVdf1CYT2EfLQopql1NoGKP5Fi25JfNLl0mIZwjtoH6P3D0Gmmg+sJ
 0SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z8dvB27BD00MHKhAiviavhQ6hVBZ26dTM77I+eEYzp8=;
 fh=B2rkeyeVAyzRtjvAfebWgQodZ8xm38TrW6TQviyHEU4=;
 b=MT98Z2+RE0N6reL82nCr8qzeB78ZSa+CcBtId1vwUoBbjHWYRxZRDfF3QuqS/A7qVT
 x+mxwDJaBk9oqIURwn7uNlynmwebjgSBQOdLiVbq8645liWMbl21pb2g3NdMxdcyJ3yh
 R6VQ3KsBH9NOIsjqXhZzDMjjmqgctrR8cBB9RuOrh+oVcYHTWfNzp9RTbs5QV7gPdo7Q
 TzMcB8N1up7jWwzAoJ8TRlCvC4c/x2SSN95Oqh1yJHTh9u7Jh+gCTYGJHV/QZK8gEEyP
 Rz4AnR8GL9b1ZqwcM8HEk6Rbh92uZTxsJdfm5CDKpMIQFYDdSLmGLtaif67RmDXpRzGa
 ebNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166298; x=1792771098; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z8dvB27BD00MHKhAiviavhQ6hVBZ26dTM77I+eEYzp8=;
 b=A8FMsj0qUm/8m4C8KmB+OpZ/Nnvm3+XP5lq0kCAgy9CEqniTluKV2czUflf/t3XpsI
 1fQHOWutV9S6THLXv6Pl2ZJI1F7hi8tZpjHHsVV+xtQfAKt8+juscs5dt+A5kXJ5Lm9c
 D1H/VXCB9VCUNK1KaGb4T1TySiFAgOLK+HYp05/SpUaJme7mpnmWE4i0Zba/2sGXwxcj
 zN2sz67V9KYozA24IkqkNndUB7hzT14DWw1WtPYOl1xn9RBjxQ+7mFfDdRq/aZx2GE43
 2glQxQL/jN7IaGbz0XKhza4EsalkgEkEctzzA0bqwHDg285cggwTsDVT0/MPH2xLaubx
 j2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166298; x=1792771098;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z8dvB27BD00MHKhAiviavhQ6hVBZ26dTM77I+eEYzp8=;
 b=0I4q8cIKxJ8ybNA+WAdzRhHtUcg+7lBPzsEUokE9YUw08+9Bz6qF9LyAZt3LwJ64ru
 i82uzGwpQYMM0nC3BFkswOPncN219S+nDFiuWvU8LW7JDAmyJxAkBAEWfAKLDSYTuRKE
 2cUGEodbSI9mkVmh/ouza7a6AP9mfkM8uvSsPGAkeaOqHYEuHBgPxGErOkBEtw/jrDjY
 nu/B8mM/fx34lLlJFXdeh0ztuIBdCFRcZoO0sreZjrCQSbk2Mlxmjopf9Af1Dln38EnT
 lpg58CLpK+qI1I6iBr8JBGuIDs2w/NTZiQ8A4Ej7t66BJVi8J0vvZk4Leb4zmzD86yIR
 airg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMFhgX+oPdX78o7K5qQj7zaAs/JsDbQUYKpRR+f5WJTb/fRR84vxH54NxXCWWgd/ghYfMAv1591Rdg@nongnu.org
X-Gm-Message-State: AFq9FYJfmg9mK7ojOuGbbLfmYmgBulrzRAl35aNR+Mxln4F/xYFFRiaM
 bT2fySxIlwQH2Mx9m9ijR/phY4yRFbuP33eJGAfJpgFlkN0OZPuWJTDBYeMR5JI8E1YU/mNTHdg
 U1MbBsXTCtJYHNi9eFN8Dt30NmGLwDLKeQmHoTGLe1Q==
X-Gm-Gg: AYBFou2TuxCwvv26mequOxdnfOiA0gYPEx/7m//nwuvfQv8/Fqp/aP0SwAAfHRNYbxX
 YoiFSAZpYo358t/Dqd3+DPxn8jTHYLaq7kXsTkjATeDWkx049li31YKUuvkltwnRGcPwUFCnTce
 BK8jdCelkO3rjVN+x9su9RGetWgwr76p5EfhyDp4RvkmN5J7FcZTunhoP9vO+ZC0tJqXHRtvQVL
 eIf9K0eShKO+hzQLbUBZNRQYTdNAM7h2FhlWSP2R+62DX4Q7ETJnJaonOkBUb7R/GS9rY50P2EB
 X91pQ+Xmn3QiObWGbCiaCdMn0gtPbGLrc1FWqo5kmFjHV3qnVNULCOsbo7DYPFEswui4hjWQKAH
 h1TS33atix4SM5058kdFlXuGUUdJOK/xvzuXsFf0=
X-Received: by 2002:a05:690c:e15b:b0:8b0:e55b:9b71 with SMTP id
 00721157ae682-8b0f206613cmr1079727b3.8.1792166298506; Fri, 16 Oct 2026
 08:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-12-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-12-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:58:06 +0100
X-Gm-Features: AclHuK-Imydk1NavRlI1lSdQw3bHdUyOwWkdd3gQpE-QQexO367vic2GyURlIMo
Message-ID: <CAFEAcA9OrP2_+gmXhERe1O2ZWH=oRtF__QrOD87CsyrggEN09w@mail.gmail.com>
Subject: Re: [PATCH v2 11/27] i8259_common.c: always use cs for
 I8259CommonState variables
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 16 Oct 2026 at 15:23, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The use of consistent variable names makes it much easier to follow which
> fields are being accessed from I8259CommonState.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/i8259_internal.h |  6 +--
>  hw/intc/i8259_common.c          | 74 ++++++++++++++++-----------------
>  2 files changed, 40 insertions(+), 40 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


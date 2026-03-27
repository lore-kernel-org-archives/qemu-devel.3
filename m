Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F6410F2855
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AUm-0004qf-EO; Fri, 27 Mar 2026 12:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AUl-0004qI-BK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:57:15 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AUj-0006bo-DA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:57:14 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64e9f9226a7so2598383d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774630632; cv=none;
 d=google.com; s=arc-20240605;
 b=ROpufOvUZa02v0NFxODBhD/mE6YkZDINxfY1Zg3g9/H2vGSe8iS0nhZ1zFoGIz5zsm
 HCOf+3/awsxnHTwflhKa3IGGNSiqXnFjwJOKJQDW6zE6secs5JKLy3XKY+YQM9OkbQfU
 ObX7aAw80KK4I+7A5pmnu5wcFttO/REgfyTCP7KzNtRdfi9cTr+WjXe3FnOO740XffmS
 NKlcVAoZpAC1lYmvbO62iFqeeVPpFc7ppsBAblHcO3B1L1k1uv7Ct7SqSDEY5fj2EyAe
 jy4hstfvX2s7lUoT2K0Fek6mtLAtN1KYfOP1trrj2yWJvObR+p8gpwChy6HS9xnOK5KL
 KEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7JCGMQMhzFkGK+dxoPGks94i+If7ffYjM8LNI+e86ZE=;
 fh=DBdXKgGbYCjlI5v6YfZN5u+jD7QU7Pf5o6Muim6VRog=;
 b=f4Y1Lm+gffoSGkrgPtFITyIKulhfSb5UByIA4GzIia8GErMgRi0NFv0LyC+FErORix
 6EZqEJ0QdBUiY7RbQvJORJ9a984KmoT+ZGle/W1L2ymbsXlrDJ5zIxKOPEwnWCgDYaQx
 qbPkTPvItpabSA/9H7RWyNzqEi5BebMvjd/nEse6nLo7mDtMa9GoN4xNwt0dnsWlQx6Q
 +lgHfguDYxbcyNDzFtmvLpTJUsPIasR4E5Ex/ltVLHfd3DVh3S4TikS4D5/VbOeIueiC
 JWh8VeXKnQizLQ3KnsODaAuGyw2d+aYeheJXd+ywZ2lrw18nrmGXQm3uCRJT9cMkYdI/
 2oTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630632; x=1775235432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7JCGMQMhzFkGK+dxoPGks94i+If7ffYjM8LNI+e86ZE=;
 b=n/QAz/+fNmRBiukivYdKxiQuCJSX0VTxsCzhaiLPX2xm+vy4D4m6rk9julOvOhDvjq
 ryNUKefN12nD5v3mmsYNBWt54nMT5SAQBwnmXp/D0xjOruyItwhrD8/WsrAbgp9f38Od
 UgJhwyR5qVgSLAODiiihaxKjkY1VHbC1GjhdZiLD4gxdoCQ7xydcxRZBMs8KtXja8W6T
 DC9qvMIBV3SfAR3XvLccKYl5usb4rc6NJT+z1NN7dkBhf1wJCY+yhDNA7bysOst/kLGm
 08jiAKJIselhjgsZqNtOAPjmm89rP7XbjKSNYSIwi+8OEk4m4ObI02UFoFhWMkBk3AEk
 ptDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630632; x=1775235432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JCGMQMhzFkGK+dxoPGks94i+If7ffYjM8LNI+e86ZE=;
 b=nKZAEAaEixfHjXaggBKEHXPkCqAlpBv7HPb2AE/ZAn0BajpUF8DmC3sCZj+ac/bzU+
 1YQyIPSh0UFwtDAdOfonPUCvAlErdtQGOy1rdUMulBobI0t5v8WAx2jBJNTZDQh9OFbJ
 jisRvYlHLw4LZN+Z4zN9waCGBB8/Qu7R2h8MqbE8v2xIM8BA+0/x3ey1JiFokmulGSyh
 sXCfYTGekrH35jTLXcsAVg6tH/Dd2q2kk/4p0bNqcPvl4GliA7DUDc/BcmYkDsXf9gHo
 aanGcQzW0WL6RCFdTFGiW0jd/7k5KW3rxh8b/QpiTJrLqeWYLsZXCa+RFCYhy7vgtCgp
 RMbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVzc/CZZ45AfW0Ad+XwF8BSV1W7RNwVswj3e3yZf4OK2DQ8hcoKto5DO8BbH7FBbax3Q4VoZr/0VV0@nongnu.org
X-Gm-Message-State: AOJu0YwtKvm1fJaLMGFrMAt1Iwo37moWvps4zMUcIH2cDXM+38MAJzOo
 iO1ml6XEexceBf2KocG1/jx9Os0YIv4gl0wN3Csju8R4xR9kqLiZ76Q+oGjMUCp8t6acUXDhP5t
 +35p/v6EcBHRXFo2vpy6ZkLKL/tJb9t0EOi7P11LD7A==
X-Gm-Gg: ATEYQzzByEU17p9IqMuAhNBbL++J8VeHVDIyIPoq9vt6fk1JRx5ymKC8td/lms0u5jx
 /dgk2eJWGxWKzVxQmWgufV0S/v7VStMzDbulssHOy8W88bgqCyZ0/lr8Cqb7mbncxUHop/kKqCv
 NGNR/jtkjCIHOHzCq0NrHnYtvUnaW5laodsuHs7F1FBNuHXsulI//acZNnKnAXvSZpDvg6mf22X
 AUgmWXYQMBXmoxT8PI/pLTb0IvK8YybS8PI6BBsqgF+czD+gnGYHJKlXF2oZrD6uKS+ez0GKkCd
 DB2PutvwSAC3E7gKXtsAZpMcOOkGYmNSkXsYzaCuU4HuBw4Tm2TMlBugEl9wmH6B6d0mvkYumDJ
 Z+Q==
X-Received: by 2002:a05:690e:d42:b0:64e:f86e:9de5 with SMTP id
 956f58d0204a3-64ff720aa0dmr3237265d50.23.1774630631562; Fri, 27 Mar 2026
 09:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260324160321.96347-1-zenghui.yu@linux.dev>
In-Reply-To: <20260324160321.96347-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 16:56:59 +0000
X-Gm-Features: AQROBzDEQXjlEgKgzwmbPbcaIZOCJlaxBRcfJG-JhAlQBwfjFOjwC9GOzdt9F-E
Message-ID: <CAFEAcA-zMUr=-x=h6VRJY+dSRf5MVM=PQ+P_V8+R1pQCx5wreg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Don't skip access flag fault for
 AccessType_AT
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Mar 2026 at 16:04, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():
>
>   // Check descriptor AF bit
>   elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
>           (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
>            boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
>       fault.statuscode = Fault_AccessFlag;
>
> an access flag fault should be generated for AccessType_AT, if the AF bit
> is 0 and !param.ha.
>
> Besides, we should continue to not raise the access flag fault for
> in_debug = true which is what we've been doing previously (before commit
> efebeec13d07) for LPAE and is what intention of the debugger access
> codepath is.
>
> Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
> * From v1 [1]:
>   - handles in_debug = true (Peter)



Applied to target-arm.next, thanks.

-- PMM


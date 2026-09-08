Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6F5C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tlj-0003Qo-OB; Tue, 08 Sep 2026 07:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tlh-0003Pj-Vd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:13:38 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tlg-00043A-I5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:13:37 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8565d77c277so52271777b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788866015; cv=none;
 d=google.com; s=arc-20260327;
 b=oIjqw51uC76MJEyFt1EyYkvSSlJ+uK+hD6LImkb3hybiR3Py6nSSNShg6K62mRPU3i
 yImlFNpZSlyeHcfKUloE96zcjPOoNUPlldhwwPVq/M18StnDXPKwsWMVf9Ha5opeK/EA
 Gv3K/mWifFLU5SDGgIoZuuEXYjVh+9s5ooSt5b82B2t7fTO3il44ts3B5ZlNuSqsaedF
 ws4SKe5HTZgBnU8Hp+ezAzy4tLehfHCYlLoSNZKZNpZ8VVr9Ixrqf11UG+rX2UW0XB5k
 XNnjf+FuJUxVxFBdjLacMjPBYy68EMUqnfucD/1AOai9nqU9t364raa+SZfNy79st4ay
 a0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HGH1zNO5nAWuMSzPWQs7YvpcnSGNu4Y9KffjpjeZ29M=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Am9MtuEZKm130q3uQ8VpiVmgMrfD57K6hjZzMMMo8QivoxIrysK27NZeOyZxMIFljF
 t5oYo2UGX7gFENhO3NnI3DpVoSAzQCdXaXk1/MdKWoo2MD2l5Xs/X70tlCIILI/7VfJ6
 0laRu9y0WbXrWFWjnAuRaYZ8GLohI72e6s/QB5ew9OUodSRe7JvvXxkdRTTIuQopOVnG
 XEXO0HxsGhCtP233Pl2JyJ8mouGjo34vkdF43ZYz3lxolD3rUgvkgyLG0c1wlF/WTq2Y
 0bK0nRIP+CJ9kv7ud9myTBrD7Z/cYb0EsBwvs3Bc5/9KBn7iukWj0Xugy/58s47TVvsI
 +aow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788866015; x=1789470815; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HGH1zNO5nAWuMSzPWQs7YvpcnSGNu4Y9KffjpjeZ29M=;
 b=Wlku9ltKNOvf+7GLekUWkvmMysAdhSHLz8E67Kig4a7HoY2UqEvptQ5mmgntosLmg2
 yF1+5jQhOjTQbaHvItlvjtDUfTzPiRqBd3v8+MMUMey1rMyrDJzGZNqaUiiuoy5Jrlu4
 0zDCO3FKReYWZ/Bnz2RY1/HdlHRgWeanpwb7itD8+Lt7B1100JUQgbNL0glOwGEMQcgx
 PATw7zLDR/BYqHOtHEOhqizMkqPw9CdQ9LcTcB8XFuNtNGv95iFPCBRo1eHDUU3QU4am
 HpYjClnyevvastMF4LpfHs4m0zM7mEibobcZQyhnEGEDd3IBW8JDQ3QqtM4OWeIlJqIY
 citg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788866015; x=1789470815;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HGH1zNO5nAWuMSzPWQs7YvpcnSGNu4Y9KffjpjeZ29M=;
 b=KWDf/kwUK+LiXtOZzMyfQzQ6Vyt8l/tAnZrKEXXO2oE8IoWR2GpqcOx2lk9aq9/zq+
 35m0AKHOSYH6uT7DpvsMclEci9H+cj62JeDmexg426zKdSb8PPpXe170Ot8291FFhXYf
 hFwdmWMClTVTFQ4da1zjDB+L+sz/xtREFei43V6kYOLAHFQGW0E84Pj6bMtevudMUjDO
 KFXDbynL9ex6L/dvJU7q5pZySR82LHX1bsfiWR6XVdQvCq+wE+mcIjZxbmGRDWB4vqxJ
 ZqoessvPni1LiDRZ6wHQqUP701D2hCGbKKLLt4xMIA/uNPVPKo0KDoRlEBJorKhbAmrM
 ef6g==
X-Gm-Message-State: AFuF++k8MTYl/y0J4M9zc5xfVMy9TnUbiYDKlXdWFB0rQvAlje9tl/eS
 AiSaNjLlWygisJQ0A+nnpiDu6w+lbH1c+RD4MCTCKKej2dzrkQTKIx6VfiCIPgEQNmcxMcRJz/0
 gDbzWQSG5+AH2RNDu4n+PLvhdXy02BW+yssAGc65jgw==
X-Gm-Gg: AYBFou2/rhc+92NEsmWJgMdWFSHfCRQjD0KAbAv32F2+uM8/xsyf2lX5HNYOqFzsdE4
 R2OYxk/9tM/Di8fT9c4mGvDliwzbo5lZ+yPQTi5ocsTeDBUYqEWZrFfciQwBhsMMAEfSfDAytdY
 dbyyxisL2IpREk1EFAHcRgKRdqZAWjxVK7kX6VNqFbdjKzdxe7xt6aH9V1NIAgSVSnJBI1RC3Sz
 bOpK2mJTcLuaZz3+F26LJoVl+tlh76nAhMuvCz9sne6M10Ud+2w2+E4OJkzcJrHLzFF83oAMpGS
 /GiWJqBWrcJtpcWVCxE50lUt0YdAENCFClgBgLajPVNStKTUK6JqooL/MYZphKVWLLbx+tML7vg
 aAXI08KLk+p170Pc6g6EBkgck+KER
X-Received: by 2002:a05:690c:88:b0:873:5c6b:a2fb with SMTP id
 00721157ae682-8735c6ba60amr76671057b3.41.1788866014906; Tue, 08 Sep 2026
 04:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-13-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 12:13:23 +0100
X-Gm-Features: AcwNN1XLN4l88312c053wkNL0jo2UuK5ifDEdyLLEDoBGJAm-ONUYXFEByxlJGs
Message-ID: <CAFEAcA8xRJXzYjNyK8S6GeQTLiaVALHOsZKvZPsCNTpcBEe7vQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] target/arm: Honor PSTATE.UINJ during translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 28 Aug 2026 at 23:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c |  8 ++++++++
>  target/arm/tcg/translate.c     | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


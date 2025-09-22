Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC666CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0isH-0002cV-Ls; Mon, 22 Sep 2025 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0isE-0002YA-SL
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:54:43 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0isC-0004EA-QG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:54:42 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-60f476eab6cso2684443d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758556479; x=1759161279; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gnGuokrv4G2bHYny+kKgt8dhLP4o4g/JCPSwPbFZG3U=;
 b=f2W2oRCZLN37d/iSxWzOe7tNm50y8OZkG+M7UyAChyT6R5QMTyNkxyRWoG677hFMtE
 AKEm3wBvYCZgC7wPeXlhyLQs4iIxOh9+SjYFbKUPYAxY6RjeQzNtleYQN8FExNG3eexq
 Y4kdsW01Kvn15JRUqBKEiiaOVQ7Q+4Oro1rEJpbW6GfOD9gmS8uDynKomi7mM5XQnFCp
 I4Cu9qEokJmEfo9S5lEQQci3gc7kS/8IaF11G4hVqIDvZXbtduuBWLJIO4PmTnxLCa6I
 XqRsnCEx1L3bQb/O4lXN3N3SmkVMUk3qICudwsYQErvJOYzDGNyHDp+ru/s00+9a3n1L
 hQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556479; x=1759161279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnGuokrv4G2bHYny+kKgt8dhLP4o4g/JCPSwPbFZG3U=;
 b=Lh6f9/a9obzITMfim7vKgBamF/0g7RHSTYNU2zgoC8ssnVFo1WFoC3a0CoR3R03JdY
 NJXhAJFrEalS+K5DBBUSDmjXxpFMHcQAhrW4AitfzXeFvhcVQXrwc4IdmEaGZQCnczw+
 dWXRsOIJHpk5VhIjEaIpiM+dfsGNsDNclK685rj/61H1RB1GQ5MZm/pohpV63V606DHo
 WJk4k1AP/v7q3koMkQgEjWe4sYdeerxsQx6Glv5zfXGWDtlusd2ljJ9ToHWmRgjuvK1O
 WfG9WTYV4HYEyXunZG/78yZ7/ewdyK5uUJSKI3Lm6owV+ykPeunsHgZWyXfBA2r6qa/4
 TavQ==
X-Gm-Message-State: AOJu0YxxOyAK7W5SiQBqsd1xMLJmvh3jJOlAVQPAAvDExqFY7Zg4P1fm
 i5tguUjd+7f/IoWUX1zuakL6yV/Lg68IWtp792WaHmH8mo8L978onpQUSJLvI5M+J/6te9eUKl1
 D7l52jQMgaZIV0nwzQoKLZQV5bH035F0D6SBEtTWk1g==
X-Gm-Gg: ASbGnctl8aL/sS3DPc26OICYHRk/othTYUHXa0lg+8gGuSZKCx/bX/WC2P8kbQOySId
 ZNYvANXX+l3ZxWOwLnbGxiVDSBPAaAEIrImNnBPWSjLr4RIgUkEagc+ntEtmoohPCMDUHr5sdWb
 F9l6jd9XefQqZHpi4UIza8r4694IUX91gqBBqyMu80Z7aB3Sw2xLO8I+dY/vkM3ilA3m64Fvr0S
 NwvkESZ
X-Google-Smtp-Source: AGHT+IFAMnWmXupT176NpoAfqpKeFBfo7I016zZ+F/hYLeRfyBp+6M9CekiA+CPyj/v7XLmKMn9IHfCH8UCMoDacRFw=
X-Received: by 2002:a05:690e:2452:b0:635:4ece:20a9 with SMTP id
 956f58d0204a3-6354ece2943mr1199724d50.46.1758556478894; Mon, 22 Sep 2025
 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com>
In-Reply-To: <20250922154843.60233-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 16:54:27 +0100
X-Gm-Features: AS18NWD7NEVlrfcmVIw7ai3N2yBKkUPLt2hzwwyAZtusS-OxTeSyun7GxSnZ7vI
Message-ID: <CAFEAcA_LaywuOR7zXn6WJ-RS_mH-kfX=_4jR=jjJ2sGEztJJgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 22 Sept 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Using phrasing from https://openinfra.org/legal/ai-policy (with just
> "commit" replaced by "submission", because we do not submit changes
> as commits but rather emails), clarify that the contributor remains
> responsible for its copyright or license status.
>
> [This is not my preferred phrasing.  I would prefer something lighter
> like "the "Signed-off-by" label in the contribution gives the author
> responsibility".  But for the sake of not reinventing the wheel I am
> keeping the exact words from the OpenInfra policy.]
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 103e0a97d76..41062f29639 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -341,3 +341,9 @@ or more general revisions. This can be done by contacting the qemu-devel
>  mailing list with details of a proposed tool, model, usage scenario, etc.
>  that is beneficial to QEMU, while still mitigating the legal risks to the
>  project.  After discussion, any exception will be listed below.
> +
> +Exceptions do not remove the need for authors to comply with all other
> +requirements for contribution.  In particular, the "Signed-off-by"
> +label in a patch submissions is a statement that the author takes

grammar nit: "submission".

> +responsibility for the entire contents of the patch, including any parts
> +that were generated or assisted by AI tools or other tools.

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


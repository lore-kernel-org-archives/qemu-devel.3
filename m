Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB1FCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jiT-0007qv-V2; Fri, 17 Oct 2025 08:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9jiR-0007qU-Q9
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:37:51 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9jiH-00009B-Bi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:37:49 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7817c2d909cso20833687b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760704652; x=1761309452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h6Deg7Uhd62141L1iDoLGmiNq3Lm5epcVVZxLHhIUDw=;
 b=lznITxOfI31jfp4nZCfGq+yqP3xJt0mAeC1UUWb3ZQKnDvNHCAj+3L7e885YtD2qGI
 GZgj4/zKBXSSUdlnYUwdz6cFua7/wgni8plsKWQCJ+ca1uqVCuM4/nykxzSYWeW4T+Ax
 IHq/hqJPQwAaknOvfQwce0l1TWoym8ruTDgr/Y3fAfKKPXybdKU1E69mvEVTeNM9Nwg0
 gjQmHikABTkgFJTxJBilkRDA3KLvjDKXiQS+iIXWH4ajIDnw+KumpBeYvdqcxFNU8PCH
 PiDPLj1kM5CWxwDgpvge2BwAnC2GNpRTExyUqdvWCQLBBbpcWhWj4HXi72DhoRQEMbCa
 QkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704652; x=1761309452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6Deg7Uhd62141L1iDoLGmiNq3Lm5epcVVZxLHhIUDw=;
 b=w9fO9NpwdmMrszCmDnvKb4FwAMXBjqWx5JqAou8d1+/oyEDESFQs2jY955jQMR4GHR
 whUmMYFmOYXkE5qhrr3gUbmkFZ0P2J4RytKCIBSvrH4fCC4LaBjmsftOuJ9Ad5ShejXl
 TXMjraPxwFu4TLejbzNWmGTS7Ogc+ptrUPP++TDLnjSWWc7o8gQ7iEf8i1rsNteAZr6b
 pvrpPtlxyATVM0ThpBeHvdIluzOjwL5K4+538Oi3TuOo8CZ2BUNm0mk/YofiWjwl3HXu
 6hq6GN0+zrSqN+8sS/5W0+9DnhRFbzkOgmfGn3WOAJ0TIDflv7efYH3yFtc550rNCb1Q
 YBdg==
X-Gm-Message-State: AOJu0YzJDh+dpkLK34YTXXtzB8orNgGFYirrjQakFX6FsibIHywUlDWp
 kkexlHmTStfrWC3VZ+SQwv8f/0QywMeBddThiKuQKhy1CRmIyVnZyOA5JtP+iRahXaOhvmyRu/M
 vFedLcMrlCVTuHrDu5B5meCi2RS6H2+f0YfpBX8vdww==
X-Gm-Gg: ASbGncsS0WdRqyiMq5Aa6uso5FeWdIc5azvVJI7l5cIwdUHxKR4yyQIM2qKtaZuTeNw
 E0tKcfLd0/cXv7/6XHlOQMY2g1E4zfUJsY17DrQJxPtVDUzxr/NLWd1XYRmxALZMMdRwu8dfjtu
 97y7Oa+hJQTldsojogwdx0LK/J91FGD/2rhd8olHErB/dI+igUs3lWcPrXM9rbZ93Szb56SLrXq
 1lGPCJyIZ2+tyqlVawegpE+O2Cz1Op1M3dbmka24b0s5e0pqNcSOCrS6qb9VA==
X-Google-Smtp-Source: AGHT+IEpSLXlJUkCIfiu3AtYQ2stiJJAnxpwk/VXnfkQnJc4BzkIQSc6CaDCKQxZxU6ro3uCyNC2rSMjgT2w5GuFqyc=
X-Received: by 2002:a05:690c:6f07:b0:771:f60d:6cdc with SMTP id
 00721157ae682-7836d213e27mr57546207b3.31.1760704652376; Fri, 17 Oct 2025
 05:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-3-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 13:37:20 +0100
X-Gm-Features: AS18NWDMgZMWzJ_pb4W3r-f-fjSwLVOFdEU2z0ZXay_ipD7GQAPwPIt4lCQRXgI
Message-ID: <CAFEAcA-O85ii1-vxEb+p5YZW1Unzg22N-KB3tN0YJvFkaB=CyQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/37] target/arm: Define CP_REG_SIZE_U128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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

On Tue, 14 Oct 2025 at 21:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm-consts.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
> index 54ae5da7ce..1b3c10c0d3 100644
> --- a/target/arm/kvm-consts.h
> +++ b/target/arm/kvm-consts.h
> @@ -30,6 +30,7 @@
>  #define CP_REG_SIZE_MASK       0x00f0000000000000ULL
>  #define CP_REG_SIZE_U32        0x0020000000000000ULL
>  #define CP_REG_SIZE_U64        0x0030000000000000ULL
> +#define CP_REG_SIZE_U128       0x0040000000000000ULL
>  #define CP_REG_ARM             0x4000000000000000ULL
>  #define CP_REG_ARCH_MASK       0xff00000000000000ULL

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


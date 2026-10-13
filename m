Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49120CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGezp-0004mt-CH; Tue, 13 Oct 2026 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGezi-0004iK-TG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:04:50 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGezh-0008V3-4r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:04:50 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b06c0794cfso969907b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907488; cv=none;
 d=google.com; s=arc-20260327;
 b=Av7EKNfi1SrIZuOhxWwF62F0LT48DqrwXOoKrEshNSdGF/kc8r5fe8OeBsg1u3rn1I
 GD6NC/f8IguubOLme995Cinm3WrzKvc03V9x0DvS+SG72a6xDdKE5bsq5ovFJloXGrzj
 25OY5xrkV1JK7eBlHRYEbh+ekS6CFaMc9WUjcJQu5P+gI59PMWGtjApa9uFublGo/6Fu
 oDjy8+xBb3Y/1UQ42ICP5iG+N80rTZfWp0zMfCGi4W7ter9W9e/s68Ab7cXUKTjGwQI1
 CvLygIlP2GBdHDLYrYYBt3IczXs9Dr3AcqGcZXMFsopx2JEON+poRLIGpgtNzwrsF6xg
 PxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8QW4DnggANqKI8NSAkrr1uqBJrud3CDe4KG3w61cK6U=;
 fh=0HhfuW9lB5pM4MDazQl8nS9SbdQheD2kBFcY7jp8Kr0=;
 b=HsUOl/3V1RH0/tK5qDPTqt/1OKM4Js4a1wuOl47clVAdgxWCh2GTfFuzRagpOfy1VE
 KTH9JFRCm6Jo9WSbx0yksuVbmDRxZNJuu9ggmNRFweK94rCS5Zebvr+Tlo3MmREXW+zN
 jaC6vBDOBmr9UQWBnIZuh4s3lXHIyIV1fFBULxv7I1aauX2fw7/O07sPuYK8GfNKT46X
 D8X/BAN9ayuk3eDBma3V9mX0UGcgnQRoS3wWMmZ/NcrIvfb2FLKcdojPFLSUXT1DqReE
 AsKd1GvgngpuLladK8srGUYYA4SXz2rzpb9jUxLQx0ysRXwT1K4jB4a1MeYAektkRlWo
 0dyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907488; x=1792512288; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8QW4DnggANqKI8NSAkrr1uqBJrud3CDe4KG3w61cK6U=;
 b=Djf6RZ9vt3Mi4P2uYlF3lVGxgGDe3kZdfIBEq/Zufh1zxVmk8djBiGANg5BdW8KB7A
 XDHO/CtN6JHNzg55Dmuok8w35lwyluMFIthlkFyellPorNAwCVt/jqlnrS7Zfxc5wdnS
 6JdBSLI7XGDdlkBLRzyKdzalD1YwrMioQhWAtADC/pI837rBQODRaVOw93PyJpr83QRS
 jK3B/OVSs6Brcl62j/YxUEAEXkqiYflxGC9HRvUfxeZ0krUX9LpRZwYR/cOS0X/6b/p9
 HsjMLRVhlOt73Em0kOvLkfiFMvwIg4NQHKBLZ5mGkBWTO1F+3EuqQb4DVU/TrWd9MLJu
 z+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907488; x=1792512288;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8QW4DnggANqKI8NSAkrr1uqBJrud3CDe4KG3w61cK6U=;
 b=iE5Y2qp7E8qpBKXicvuSEAc1+BNov6f0KEC3TVg5cgTaCzuaD2vXtnUHLcISon3ZcM
 MDDngZRn2PXxkMoaJRlL0vXhZWlKawjsh/H6+jP/srn9uAE4DcJ4GNdAvCOSmtOuXNQm
 7HHQfg6BVYgMoDc+PtF0t0l48Pqd7tI1DAqGtqmt7HHF+sI19JV2dpltv2E02O1tbDaa
 6+7VR7m2T/A9P8wkUQzIyU2FX9lFl54nQYFkcPYMf0/eVZ2w5G75AuYzUChQ1W04JqBD
 SkXJMK5Vtzwmi4K/1KEmJoz8N6Yd1qdjiOTcWjUpJCx/CQuhvHboHPBIaKcXsqGUHRCX
 rd7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUQDQnW9pXYMxCGt12aOqDXTf129oZDZsBYv2dqzqnXXsNKra+YcqK6WdyqMMmt74k90FYnIeNvHev@nongnu.org
X-Gm-Message-State: AFq9FYJHzqd3toYQ+7k4GPCLtFamCes2QfmwkUeoEh1PR8TEHl54fWxr
 PpdxKt9gFhUPe4aXizzbf0CHOYhbvQcAdPziT2BD7AB8V6Sl2LGVFwISCxXFYffxmC53lcAAj3s
 zU7LifdUogZolAbaM+L53DboLXdyZCreua0uN1EHoYg8K4eXpJW0Y0dE=
X-Gm-Gg: AYBFou0vzAmZDb1PAuLRPnBczpVdyIWP0kfhvJEdPKS+MzczpkGId0jAwvzSytseFvu
 cgI8X8we4EjG3dYj6hVi3m32X6Gi0euMPjat+Dok2TxHviRTKXR+xkMFscC6Jh708bOAyjr5gcX
 HGxQW3TeH9XB6+HdPgoPOKPUxp5XDIZaHbfpjQQdNE/N6+OH4uiRV9tvncR+oi9zcPFgQNlx9hy
 QF2/mOprVwBLSTEA2GQDpj11RIqgTKVB24D/XRbIFlb8T6U0D5GCwM3Wb4ns6todqUoijVmawiu
 cy6bZMgiGmitq37JNxC7x/GbOXhtWBcgZzyjS3nNhDzfMqn2TqGSe8eNv28pPPhCToN8F0SFOgo
 ygw3mZJkJ9iIdOm3/1643ivqSSmPXzhLY8ZTOSys=
X-Received: by 2002:a05:690c:c4f9:b0:8b0:ab57:ebeb with SMTP id
 00721157ae682-8b0ab57f327mr22200377b3.8.1791907487831; Tue, 13 Oct 2026
 09:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-19-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-19-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:04:36 +0100
X-Gm-Features: AclHuK8qMJ-I4Tt3XuHQrfl6cTsPi6UaaCLI_oJn5_qEpGEZMA1nMyineaDbfqY
Message-ID: <CAFEAcA8kqYf-0vA=3NEAGyPw+euS_5CczL61gF1eoybta7B0Wg@mail.gmail.com>
Subject: Re: [PATCH 18/22] i8259_common.c: remove unused i8259_init_chip()
 function
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This function is now unused and can be removed.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/i8259_internal.h |  1 -
>  hw/intc/i8259_common.c          | 16 ----------------
>  2 files changed, 17 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C01BCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm4I-0007gs-84; Mon, 19 Oct 2026 08:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIm40-0007c6-Bm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:02:08 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIm3y-0003bi-NY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:01:59 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6740e7ae219so1579226d50.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792411315; cv=none;
 d=google.com; s=arc-20260327;
 b=c90m5EOhRCPH2/2gI/QlvJHYj2yJmiKxMwj6NCkUiUaKtQmOv5UJDVHfNX+tgynlL3
 th+86vB0Ptq6s64r+KObKm2dd8yxWL2gv8AcVFCLQh92TdFJF3sfvuKQ1N8gNNboD8P8
 eCDTosLjaJ7HBu1YAK0j0oXWAN5dDfwEncuPy43h1lmLRU5kH/d9SXqC9v86qgjY327i
 H7FhvyzucLKkKsSa37sg6tvcXUO8VQ9eiBAYGIMPo2+tpE2riuv7Y65DHP4Ug4Vh8pZZ
 tSbflFiULfcGQ+I6TBvfu/nfxxNX7eM2s/Z11GgcOt0uVjpMTclQHNoJvKk7RYHZOpsM
 BWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z4VrNj0cpeJ6IXR8KDNWQlOCfGn5qVmCnNm/xiO8XQM=;
 fh=qhtXqNHoNHqSV/1PoZZownUu6N8xOIdngJmjRr/1MnY=;
 b=ejrDCdDKDy2XiHjqojQGMG/Cmat3yJ4/9YiBhAvQGFxG8xzO5T5V1x8JMv4mwe/DUv
 KHXdISBjEmAY1LYgIAlq0WtEGLJwes1deFr63hmdcfZUgg8VvUgVZg/BO+WJ783oMhH8
 +Yz1mqAwlnM6wFSIrXBMlJ9SkVRlv3HfNtghMaoqs8T+O88habjT8wS7lI7077zhzda1
 MzC989B8KvzA9Ah9zBkwEIrb7kg1PS8+Qz8pMIZXfXqBcKHF2E8yLZk/PyuApt4LIjLD
 KqxFlegCsLMw1Ah+mqXZ3pmvcG5PtSnJcJq15JbPnuMweH+JAm8OcqBispZA/VSMuvz5
 t2+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792411315; x=1793016115; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z4VrNj0cpeJ6IXR8KDNWQlOCfGn5qVmCnNm/xiO8XQM=;
 b=x0MvUMkugnoGF7fTHmYXXoOUyAJGJHRn0fVCP8K7bC3qPm+SSmUV4Y+q51w2neis8d
 AAhpCSWGkR9P7+FS3mkNy8//ZiEaEqEpglnxVJ9QnGvXa2tSQoNFAwowGiDjsV7FPLVL
 tgRG/UenWykM06CL6SK+ZmqemQMTFRdJPYb6mFH2kU7+eVrhufLBzalJLeIwZOn0cCEG
 brXoUti8QkTfJ2mnSep956uNr/7WvbyPiALTBdKa0PE84BoDi0YP3uNjJMpCYpUcRDuM
 Xv10XWSygu6Wrw4YQpw/AGDxGfbD3Oyg4N1A0Qrg+hJF11cR+fJjqtSGqxSBPkYdhmKS
 Z+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411315; x=1793016115;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z4VrNj0cpeJ6IXR8KDNWQlOCfGn5qVmCnNm/xiO8XQM=;
 b=FXJW3QGpyjD/ehCJUuuYzdyZaOjZiYqKk5ZFyGAz3yd5DfuBMCv/I2mbx6EgGZgbXm
 53x3jieTwsDTJODrRzb41eikJqxUdvucNgqYfMguHKw/bepDD/0LgmUiF7cupNFkqOQF
 5H386V/RQDHACzDK4yLVosJkSgXZxmFMZuJiMK7xC13EJ9MDRVuokSsZ0OGt01dRyN6o
 LisGc+bqShT51Sc559p1WROiateaIiCE1IdyYQHOMapG32Lap8XTH9TcbJwka3tY2D77
 uA20LuksYp/407mM2O1Ze6lo/aCzBtIv/nLMeJ1v96N7Up0oW6VnIOGmwAXoKsXQ8U5H
 SPMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByDEaT3NaLI/kRFk4htK5eCyBlIoh0iB72kR2jDPP6r6oBh/kHiM3lAoULMMyP3TjqS5V5lcMsDplov@nongnu.org
X-Gm-Message-State: AFq9FYJ9p+w4ECJvsWIg5XkeqjBdBy9uFNN1fjLNwPleEbjS2PI2WNPI
 Duv03cdp4c6ixGFAuxcBkSv2de7+J38Ecu/dhT7c/W7zmQkoDndKsBQSpn6vOmhG98Q5zaGgy0T
 X13m/pjx6hEJijizS0nxwyAUznKMrPtSpCaJLnAsY3A==
X-Gm-Gg: AYBFou1RGt7rGqbb/71swp94sM6YzKPbQ0qcgeW9CdZ8HUHNCjip/MC5QbT1740azjr
 ZEU9aWxeYL4L+ypKIBOgDkkBVeUiTlN4SsSxQd0FPqu1So959NJTBZNtzbcgYBqBm/rDDGs0fOX
 VMIYCZmdQEu4JYzsBiMgmlPpsiAHHVVNeSlE9ukjFhfn1EFB26tgdvMu8ztXgWid3T60iOQAkiZ
 KRv4g2oS+YpRgCudUNFLPhVJ6bErxd2UY+DbQyXM3HWDBOQhYSGhGcy+76jdKgUYwYZjPpK2emU
 pxSRGSu1BIbBzwRdpLLeUmjj/8+JZiaiGCX9HJqZd8SgaQ/23nM9ZzB958Vkdk+vNFcTqmWp41r
 ATApShrr4UA0XPIPQ+5HscCng/g==
X-Received: by 2002:a05:690c:c509:b0:8b0:bf45:9622 with SMTP id
 00721157ae682-8b0f2177175mr22910667b3.30.1792411315323; Mon, 19 Oct 2026
 05:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
In-Reply-To: <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 13:01:44 +0100
X-Gm-Features: AclHuK8RS396TNxAHoYmhOi7iGPFgZj1Ym-YMspk-esSRUadSgshcrVPxpsXFv8
Message-ID: <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jinjie Ruan <2118537295@qq.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, anisinha@redhat.com, armbru@redhat.com,
 eblake@redhat.com, imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 19 Oct 2026 at 12:46, Jinjie Ruan <2118537295@qq.com> wrote:
> One honest caveat

Please don't send LLM output to qemu-devel.

thanks
-- PMM


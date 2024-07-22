Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrWx-0004Uy-CR; Mon, 22 Jul 2024 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrWt-0004IK-Vb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:48:35 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrWs-0003JW-DS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:48:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso3325776a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648913; x=1722253713; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=agF2o56NVMWoQLSkbiU99Lwva4Y5FPNElLfY3+x3OvQ=;
 b=vf8Oj/TLojG3vvYe9M2tVoOUSNDlTB4urPSV2O6nmbGl5yJXM/T3kdsOc04YyEbAAV
 aHtId2vdlVVecZ5qYASZNmxpGHILzdMyOodIn2h0ZRfgdNxq5NcgtggkAT5FJGjKrC/E
 JWAozNp+Gu/0gXecsAinYBKd6xa4CuLc99LJruoBb93oDcxKGU5sOAgpbVhMwKrTn8Zj
 K56zmeYup+7EE8hLzT1tm0k3gUO5YoT6L++FHOWCREnr0bczWzedhCTFSsscE1//+LDh
 nnt1AnrPLTDKeZ04wdjIAYf6sWtY91f2DUE8XRkBMFTNt7ASenJOM65D9dHLbnmpjWBY
 tJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648913; x=1722253713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=agF2o56NVMWoQLSkbiU99Lwva4Y5FPNElLfY3+x3OvQ=;
 b=kiC5u7wZBCZ7Kc01MljpWdNFgz6Fki1sW8AFnRbXt4aKB15kGoSaeREelQ3spe+5DS
 Oz2XaRfI0jjsSsLmf2qa+1DpYGF6Vz6HVNp516X8cqohuQYBZqxBPYeT6HjA3vjM4iT5
 9iUJQYQLnhq25mBbaHqNIql4Pqli5JdOjLovYTOCsG7nMG2HKbKQtqrRCjq04DnEcnjg
 j6QxCl3tVn+nh7oagGZ29gUXr6gPq6/xRh8Y+TDKLHHaUMa0/Uu9V5w+iMvj7Selv9TM
 RjjlWIrpT041DWlLB2DXrqEJBwDW4vj4f6XX6wyjBXPW2qs6/Ud0gs/HnONtH+FlbqsE
 ABKA==
X-Gm-Message-State: AOJu0YzrFIUXAgA+SbEt4CzPYULWXdvPOx7aLUnYdpc4LpbGcMIjtKan
 JmumrOWUbJn6+Ieuj8y7wi1xGCUUD5byL3ayHY3IWDRkzOXxcDDCPR2AvMCvtgMoUBihDHtpEYR
 Z+DAEtKGVM5fUeYSo32opYqvZew8WPtLoXFrRKw==
X-Google-Smtp-Source: AGHT+IGDqENqOnqAs2bUVY+MbHZjzOD7nfyCm6i+tXQmOqvbGwaWjC8gU9u9bZTyESosfuiKI59t3z/6zC27RF62EHY=
X-Received: by 2002:a50:9982:0:b0:5a1:1:27ad with SMTP id
 4fb4d7f45d1cf-5a3eee84c46mr4528335a12.16.1721648912794; 
 Mon, 22 Jul 2024 04:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
 <20240722091728.4334-3-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240722091728.4334-3-yaoxt.fnst@fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 12:48:22 +0100
Message-ID: <CAFEAcA8LQ1ofPxjnFQtfCaL5HDnULbcCZ1HZWC98-17+RVpxDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme/ctrl: remove useless type cast
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 22 Jul 2024 at 10:19, Yao Xingtao via <qemu-devel@nongnu.org> wrote:
>
> The type of req->cmd is NvmeCmd, cast the pointer of this type to
> NvmeCmd* is useless.
>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5b1b0cabcfc3..221818f551cd 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4167,7 +4167,7 @@ static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
>
>  static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
> +    NvmeCmd *cmd = &req->cmd;
>      NvmeNamespace *ns = req->ns;
>      /* cdw12 is zero-based number of dwords to return. Convert to bytes */
>      uint32_t data_size = (le32_to_cpu(cmd->cdw12) + 1) << 2;
> --
> 2.41.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


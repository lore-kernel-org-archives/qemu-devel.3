Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B096C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRAS3-0005sX-5C; Tue, 09 Jul 2024 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sRARu-0005ja-C7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:00:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sRARq-0002DK-09
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:00:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367a464e200so2762270f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720529994; x=1721134794; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OH8PMjNGj0lZClMO++2Cgit0qDr/sOYdin6QCfjAx3U=;
 b=Zb1aKRnG58HI4ZqW3Rz9V2W5KQuIwmwo9oVxpsfS/FgyKcoZbufjVjaBpxvE8xTTnr
 oX30GdjX70WaWr2fSWHW6f2eQ6/oh3krw4/6faGxD/3+dzQqtZp0ZSfog11f0OouCu0U
 WYBNeo+lxO64GQ01r00XOevMhDnNQeYtk1xyYdDfVbCfIr03+GCp+8sxWvNpzlrjb4k4
 JtSWC/pN01quvjmi7I0O92Z3RbTg6olvMyWyqDLKnxnYTgkhMP+dd3wXxiZ7okszLpGN
 CWIuvMcJWAzc8MJCGhVOSq2nEfeAzkFcbhvXfGQLO4YYMJ6KoabAEvEZU7pj6afwm1dd
 Zs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720529994; x=1721134794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH8PMjNGj0lZClMO++2Cgit0qDr/sOYdin6QCfjAx3U=;
 b=qAPd0H4ca/GYzPgKJ/bSV7K3yFtEC2AnXao//ccIF/CRqb68mmARU8zbY1310EZWyz
 5bxI1Bga3e/EUouSkfAjmmvquPz359oyHPaRa/aPGu/MYuVe5diIINJ3tZOAAlYnEqNq
 n6BUowO0aSKfbFGjNl36R4TbCGfraJkI4yPYYFwSNXqOAUNf5k8S2g6hORfGzxPVImBc
 VXHFJdY9zPWDBMDhnlkJWPn3+82VSPpwXiBW8pK5SZzv6zkI+hh1ENdReftmONWfLlkb
 /w5uaScE+m1lJYAHe7hcqTg9xUY+trJ2m5cnnHVwYPJaVw2XhRUDeQhHmKzepL+UvmAW
 Hc8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfsycsQBdOBNnit92/orWBk34zwSLBrnVYkAKMO2EgnJNj3JWjzDew/Va1MZRS+t91HCDrYiiyGEzhBIgovPrNJQlzaig=
X-Gm-Message-State: AOJu0Yxd7JqSZGTpQSHVux4+7gm8mNvsp4cPRSCe2/dKv+SyM8o0nj43
 I1zS0CK+InVNVr6kgZ+Xpyvo66/LIBjOi8Xx1j2tBqEs2IVfhEpxEU2w177pRNc=
X-Google-Smtp-Source: AGHT+IHa5j2Y8rjN4nn3QVxoY+dI1srnr9jU6L/pqXzK8s545HF1ZwrM8ajaNUXeYwuir6DAJVDDHw==
X-Received: by 2002:a05:6000:186e:b0:367:880f:b8d7 with SMTP id
 ffacd0b85a97d-367cea46a2cmr2009784f8f.3.1720529994581; 
 Tue, 09 Jul 2024 05:59:54 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde890f6sm2494704f8f.53.2024.07.09.05.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 05:59:54 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:00:04 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 08/19] hw/arm/smmuv3: Translate CD and TT using
 stage-2 table
Message-ID: <20240709130004.GB2189727@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-9-smostafa@google.com>
 <20240704180843.GE1693268@myrica> <Zozi-87pVHOdwJGN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zozi-87pVHOdwJGN@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Mostafa,

On Tue, Jul 09, 2024 at 07:12:59AM +0000, Mostafa Saleh wrote:
> > In this case I think we're reporting InputAddr as the CD address, but it
> > should be the IOVA
> 
> As Eric mentioned this would require some rework to propagate the iova,
> but what I am more worried about is the readability in that case, may be we
> can just fixup the event after smmuv3_get_config() in case of errors,
> something like:
> 
> /*
>  * smmuv3_get_config() Only return translation faults in case of
>  * nested translation, otherwise it can only return C_BAD_CD,
>  * C_BAD_STE, C_BAD_STREAMID or F_STE_FETCH.
>  * But in case of translation fault, we need to fixup the
>  * InputAddr to be the IOVA of the translation as the decode
>  * functions don't know about it.
>  */
> static void smmuv3_config_fixup_event(SMMUEventInfo *event, hwaddr iova)
> {
>    switch (event->type) {
>    case SMMU_EVT_F_WALK_EABT:
>    case SMMU_EVT_F_TRANSLATION:
>    case SMMU_EVT_F_ADDR_SIZE:
>    case SMMU_EVT_F_ACCESS:
>    case SMMU_EVT_F_PERMISSION:
>        event->u.f_walk_eabt.addr = iova;
>        break;
>    default:
>        break;
>    }
> }
> 
> What do you think?

Yes, I think that's also what I came up with. Maybe it would be simpler to
unconditionally do the fixup at the end of smmuv3_translate() and remove
.addr write from smmuv3_do_translate()?

A separate union field "f_common" rather than f_walk_eabt may be clearer.

Thanks,
Jean


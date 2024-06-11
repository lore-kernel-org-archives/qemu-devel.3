Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304AC27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3gH-00009d-TG; Tue, 11 Jun 2024 11:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3gG-0008WR-02
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:45:04 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3gE-0000jt-Cc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:45:03 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52bbf73f334so4159240e87.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120700; x=1718725500; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ChU/6ILkXdp9v7bMX5fsVJe48nJ6AaR7m4gBS3x1U3c=;
 b=zZV3ZkoyPyWJPWosnMPWE0OrOrwQQ59TjKkFayMTOmHb8FPEJHZbJAGaXO0R8tDBwW
 +O0yH1UWxk8Ug0lHAONtB00rRTObu2cJYcHk3wtxfd0Mo1+KaBZKeiM5P47yOpG/HyCm
 zeEfE5Czv+Lb/46mBzTz5tC3QTb3RvRmGiUn7PV3uikuOEdz9YgnboFZ31d3Ex9C5wdc
 qWEscB83h2ce5YXeNA3mGghDx01UPNTygwtNsxGbIRzYGeo1x9AWTkIZvsBvia5lOX1N
 Tz+feeWO02NFqch5vIgo07v8/gX4FfgHXgYfw4Mlvi8fBSVrSohP5UbOM91iCN8tSWFS
 giEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120700; x=1718725500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ChU/6ILkXdp9v7bMX5fsVJe48nJ6AaR7m4gBS3x1U3c=;
 b=L34cFurlhdR+nn1iODmpV2vO2x8QWz3lIRXs+4r+ARuRPIkhq2Ml9wjbBH8dZntz8W
 zVgECyIxYsjA2O977wL3GgFmU0Nwjh/i2FC77ogG33VljBdBDxQZryOlLET+co1aQmbX
 Y/psz0QLh4lVHpq+AbF57zkMj4Aur+sIaex2otsyohwbzwFnhlF2KiEMellGPCD3D0JF
 JlpANTtYX9jCsilIXEb/ZPG3NltT1M5AWGTv5SCcM2nQ6GhxWSMrDg5gKRaysu5Gyg86
 AH3hH6jyT9qDI8oKDGRxmM7bFx4JMDwpO85GQYXz9ebB+uJ8nUYWriP7Vw2TELGyFBKF
 XIPg==
X-Gm-Message-State: AOJu0YycizEW3hyXxjDGj2lq/kphiuMHRXCXIGIkMPIow5IH0OXpu7qn
 aRgmGARTKCohXgRXm1xItMXviQcxypMtPxo42lM3KZZbenUfF0WvkrLzDVzd2CLw3pLm3gm2rqR
 8PxjoDSqD+ubxVOKy7NF+O3bqltM/DB5wRkC0bw==
X-Google-Smtp-Source: AGHT+IFMNOsEdxAeKYkng45Mvi9W9LCfDmNmF6U1ckMKQkwGJYF8r43BmBNAAy3XsyT1hwL46b5gHPVjaxwbQzw88Lk=
X-Received: by 2002:a05:6512:3eb:b0:52c:886e:63e0 with SMTP id
 2adb3069b0e04-52c886e643fmr3619303e87.69.1718120700539; Tue, 11 Jun 2024
 08:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240607135310.46320-3-shameerali.kolothum.thodi@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:44:49 +0800
Message-ID: <CABQgh9G5yxsv7uy2isV1Emb8ga4+vJ2Zo530Qg6geWUfxajusg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] configure: Add uadk option
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com, 
 huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 7 Jun 2024 at 21:54, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Add --enable-uadk and --disable-uadk options to enable and disable
> UADK compression accelerator. This is for using UADK based hardware
> accelerators for live migration.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FB3C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3iX-0003fk-OR; Tue, 11 Jun 2024 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3iW-0003fN-MP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:47:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3iV-0001MG-8G
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:47:24 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52bc1261e8fso4637230e87.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120841; x=1718725641; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L/aKdqvNIlb60qzVsRZ+CFJQ4CQz5P1P/33QXQlGMCQ=;
 b=QIKFE3DRzq70aAEs7awdLOPnpspmf3CuIvRCKJA+LxS7SAuQyS888nKDCGBkv5nsAl
 uFSWbJA7iLXAdzv7i9OA/NeU1J8kmxC4U11FXwEU8iGTTNcayqV5EZyvv/tf53omtCo6
 yhCVK52yhxRNfffBqaSo9YHt14Q1DqKcBku/UsouKxRx/08fm//6YwMs5Vwzr3I4wrPE
 VC7rSZox8vt/5GmhSKIlEIWCeA38kc/s17q5Z6lMgcZD87LPcw52KvJWM9atxVdjFySp
 pI+ZZXl3pAgy7DlUfd3R2PUU23GHa/AxKTRWJ+29k/ulmh+es8lpijBwbgUiGrHWtPWf
 JMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120841; x=1718725641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/aKdqvNIlb60qzVsRZ+CFJQ4CQz5P1P/33QXQlGMCQ=;
 b=bkqYS5z1yWpMZf2DNDbdEl2LI4moIzhEzbsHLcbEhwvJknHXZTqGhz2geU8C6aI6de
 UvuzB9MKi+daSkbjYj8gHp6Jijt8B/f6Pg9lcaKVo18e+qgFLEpw0XKdt0UnrYPAHmZQ
 Ezo3hx2rqtIyhLXZIlTChzp2vIVXnKti/VZJ/Hs8tsupFG+dWnbI0kDIVRbZXLJrtXCD
 sKtZCFdi4fIZ7RBpWoZ9FWq1ZBt/RWd13uVBujpmwLCRw+1p9HJAYN5G9DnXKa74bICF
 sVNu/26lCWKNzj2XwISkHC4Dbl/C4uSM4bLXnlm0XDuHbfEz40vfDeWX11Vd28fQm1fI
 2BLw==
X-Gm-Message-State: AOJu0Yx12k2yjnbZhIzdFvrQMGrYYcMRaYv0GV2KgYCJPPsL+1dZ07ql
 /dVP8dVvplAXKSOXn41tOu28mexFV2VmIFrq4wfJmpFuAdjJpNrIqh7mR7BYLWki+jqw7m2Id3l
 Y52boFIg9nKkUe3hZs2ThdNfQyF7jP+H9QPKmxw==
X-Google-Smtp-Source: AGHT+IGOy19g3J4x3TuUitsy0i24RysSIrL8HMM0sw50D09uz4gNSbvUkioeO7OLnu+m4tuGC+dhvOcCfsi4+TrHins=
X-Received: by 2002:a05:6512:3a8a:b0:52c:93f9:e757 with SMTP id
 2adb3069b0e04-52c93f9f4e2mr1955138e87.34.1718120841095; Tue, 11 Jun 2024
 08:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-7-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240607135310.46320-7-shameerali.kolothum.thodi@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:47:10 +0800
Message-ID: <CABQgh9HrWe7qpyPT9moizDOZ+8rd_-LG4xOfDSk-KsbkseBWNA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] migration/multifd: Switch to no compression when
 no hardware support
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com, 
 huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x136.google.com
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
> Send raw packets over if UADK hardware support is not available. This is to
> satisfy  Qemu qtest CI which may run on platforms that don't have UADK
> hardware support. Subsequent patch will add support for uadk migration
> qtest.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>


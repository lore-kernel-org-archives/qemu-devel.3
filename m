Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E2C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3fV-0007yh-SR; Tue, 11 Jun 2024 11:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3fU-0007y2-EW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:44:16 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3fS-0000cY-Hs
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:44:16 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52c84a21b8cso2411630e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120652; x=1718725452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T1e1qjdaqpMV6raGY7zH6pObZdNAPbmFXeohXMTghM8=;
 b=egsosdrN13gZaC7OVyqQ2G2Kv7tYHT3Z5AmIL8leyCPP+avGAPIzd15rFO22ax6n3d
 tEQM+NMojxpQzWFou9MaXHWLgruDa3bGHp6EZzHeTQlDDz8ygJmIF4ofo5a+U2D0fKG1
 Bw1CSrCC/spTC8vUz3v6autS1ReJARXCPWx2MXG70a+glZjeTmVi1IBZdjbToi4c5Oix
 Y/jmaqS3IVhtcVKDweYc/hL5TEie87ubGHCrujgc2x92QgZ72iPhIVcyfzX4V4fjgv7y
 GRHDCS/cqUJNuUpfxFXCPzqaRDIJaEI1d6c4+V+NGTecGVTkRQsABI3SKwtCc2We4JBL
 wAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120652; x=1718725452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1e1qjdaqpMV6raGY7zH6pObZdNAPbmFXeohXMTghM8=;
 b=ILD7GDtKdBXHjBi5Lxn3MmHTkrTPWhj8z8pNe1KuCJQLGin3kwlWnx2QtxLhFh/JNm
 Jbh5+BGHoOnYLVeuhbecdGhDPY9TZiZnMQHgVIcD62JVCvDgbLOMqN0vFj6vo3Rq6oM4
 E2RLaLo+lJvV0joA0zgcpjeAcMCeevCPrMRW+LZdS5t+13du7OT5jMvyqJ0zpUe9HWIN
 O2uub3fyjyAGeO2/k9EE5Oxv0+U2IkRd4ni9T6XOeuttd8E3C89MW7E3SCcjLfVQKX/E
 o1nERYAfICaG2/xLr4T7ur51VX33uJXvv45WSLQljN+CcopKGgjpEh2l1uk/Wl0nGjbN
 Kc9Q==
X-Gm-Message-State: AOJu0YyBgTW2Abh3SQcYfFQYN6xeKWU47SCQdJGajXVpuomgpUSwq/sQ
 IY/dv7UinIyhI6WEn3pXGcOsZHQuKuByVxdJ0zAWHWzvh4QRMErWwMSvzKPTdAnHTmsTkjC8Fek
 mS7SHf/grilZpv13op6n3+IQbE0yq3IjXbgzI5A==
X-Google-Smtp-Source: AGHT+IHOo8qESay6BB3DhnXfUYB+cYzFTayH2RXQWQEjrNLPmMkl0tmpELdgccdwXIAfdHdIiSK/4OrEqNW2DVa43Ms=
X-Received: by 2002:ac2:5559:0:b0:52b:c2b8:b1d9 with SMTP id
 2adb3069b0e04-52c9262c528mr890996e87.26.1718120651823; Tue, 11 Jun 2024
 08:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240607135310.46320-2-shameerali.kolothum.thodi@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:44:00 +0800
Message-ID: <CABQgh9E+ODoBJFxA90g3JSZdQEbKjVG1Qiv5vP2JAfXK0bed9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] docs/migration: add uadk compression feature
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com, 
 huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x135.google.com
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
> Document UADK(User Space Accelerator Development Kit) library details
> and how to use that for migration.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Good job, thanks Shameer

Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>


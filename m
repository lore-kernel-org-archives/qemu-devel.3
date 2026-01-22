Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E187CC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 01:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vijwZ-0006m9-Fg; Wed, 21 Jan 2026 20:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vijwY-0006la-7c
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 20:57:06 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vijwW-0008EL-KP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 20:57:05 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59b7c2614f7so346722e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 17:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769047022; cv=none;
 d=google.com; s=arc-20240605;
 b=KEuvqCT0CuP1ZX3C81ZyN3ApbRgFlq/q0uq3btlioZMthA4xaqYoPmz+hSbyQRRDcL
 ZAsS0fyHHjEsL6Q/0tLX8F9I4hxP+NIlcsuky6lCmxapEjwhjWWUguBLyIMkkMitpFXk
 wU3VFdSsY3XrN6NIKpOv+bHFnePywUTNhwrhxbKjbaQo6zmb3Yz9O5I/9+5CzO/Y797I
 Ml+8UNdWuxE1Hd52W11VjDbpODzNVhLWQVQPW3ae/XuBFgNXemda1doCAWyjfUva6L3c
 BGXut8fGfp3KT0f+lyqvMuS+Bg5XnI03hzMGmUvfhvmtenzUoOgsrQLFQH8EYisVQXCm
 4TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vkpk7pq3esGtWXbo5pS5jSpvXFYzcH1PyeC1ISOGftY=;
 fh=CDJ1lgR9zxrlYhn6M/YD6N888voQP3h/TpqNJ56exCs=;
 b=OQ8ZGBeu2xSpS7OSD2/dJvWvldAPB9sWbaW9jHN6IV1v0u0yg/cLjulb61/rCFbM5T
 4xURmjjtBP6cQbY0zhd3aj/f/0nLYVbu7nt9lY13ogJJqKwnV8pRwWtX23Ws/ZdVpsoz
 +Ww+gojMWQthiuR/F/8OkTuNlfdPZRxbz4Tl1SCI01Anpmkj5KRrjJ6ZCifEHbvBlt5y
 XKRVqPqlMgNSaUMjaszOX/UbZXXclzC0EogJqAyIx2Oi3kvHfc+9Ul52cTDW5q9p4LHo
 ZK2g0QMCIohwpmS3WXN/AlZx37hvLwwNiFCOvoN41HsJZ/rgwN6N9KXx2rAl30Ox3dT8
 QSFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769047022; x=1769651822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkpk7pq3esGtWXbo5pS5jSpvXFYzcH1PyeC1ISOGftY=;
 b=Ijc6N4M5gOHwMckZ8DwCSewkhlKbWUPfh0seFvZgIHLGKmAnzVkBDvDGZ2PRoKoZVP
 N3H0rfHOQ4raB/m8GqmdJooDWv3KVkZaRr1NVBDADbThIvLQMHry5TMcIda0Nf2ZiRcp
 BAgBnPou7a9AQNteXpLpTeRNte5o3IoUo4ZUQmrY9EAY7FypdyyOCBcQ/WiHIux9hsz5
 SFyse9H35Mqy14TUKO9MsdOZwqChZNpmvD9DYJLIvvrLyw7fEMr6yl7FOXDtNR4sTxf7
 3Llz6rCT7agK6w6amd0WDspGXoh/8GHYsVQuiIEHRBhn9qAm0uhDlP3G5WYkrwkFcCg2
 rDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769047022; x=1769651822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vkpk7pq3esGtWXbo5pS5jSpvXFYzcH1PyeC1ISOGftY=;
 b=XLyGWCWVv9axueTBsFMR2IEZSzbapQy8xrAZX/rF6PC1P84SUQTZxtkoRKiNPd4FRl
 IuwjESFmA5byHNz8C8E8NGoeY+amb4vllwjpQkxfDR003ejCjF+/StzcNBY0EuxuaDbk
 lULVrQMTmE7UB2VFbrel6Hdb/QiqLvBi1Ld9VUz3M3EHHzPdmtQMAkGOV9Plgz6cVpg9
 GhxzyWDrVGWmmJKf7mU7TUA+zntkXL3F0qC0mtZmRUN9NUu7GGIw4eDM6z7TJ1+5z7DC
 Ru/cPMZKXcktJzY+uK1JrCMKvRdpJxxkOJK6uB9zCMqU5Mo4ZBbgj/AalUgoDE/bVGB7
 +lEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi8ZAqmidi2Lla3hJ9OaaEMLzz8o6qC0iyJHCXSBBtIsNH/xevWGOSc+FFKW+xH1gtSUaP+OqDxTcY@nongnu.org
X-Gm-Message-State: AOJu0YzTAH5Lb/Q+N9Sn7f1L9DoKv2dD744wa9oe6Jsyohfhv8Xmdcmz
 lOQiR30bf9BUXUrykrgUUgfXp+/RHL7Hi03lWBxh4hpjcXD30kOPhmGxFHYqnE8RBxapc82VqGJ
 eDuhvIgAFoFbVer/PVq05a9sVSbfvpLNKCodUQCxbCA==
X-Gm-Gg: AZuq6aKkmLUSe9F+x9X5J5wD+3XUI92YHEm5d1SttUUizImeO1adxvUDgHLs08SNWWc
 /m2fZIlTutpeqawOBMomsvqn5Lag6wbCBgeCcT0XADy15uns6zo7TRCH2fnukl9hBDLAhqdYyaR
 lyGI2ZtUTqymw2Aeu6NLAFQRu4XgEQLVrCl5+ZQR2wxtOvlhiR7skueZ+goAgvAPS2piOqsfKAP
 Py+dvD4lzQIfbbJ3KHyBC0FS7tb5m/nmCmodiRX72WxzXfPsp1yp+GJq7sdOtv8DYFWuJMT
X-Received: by 2002:a05:6512:12ca:b0:59d:d799:b7a0 with SMTP id
 2adb3069b0e04-59dd799ba84mr412298e87.36.1769047021637; Wed, 21 Jan 2026
 17:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 22 Jan 2026 09:56:50 +0800
X-Gm-Features: AZwV_QiIi7rsl9-GyCN7J4E-LYjXFexVtzPMPuaGbmlle5snTHqoiqeRq16A9E8
Message-ID: <CABQgh9G7Msyuto_S2nQdn6GHMzmD6OwL1eQQ9E_2CD5shGim0w@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org, 
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, 
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x134.google.com
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

On Thu, 22 Jan 2026 at 01:55, Shameer Kolothum <skolothumtho@nvidia.com> wr=
ote:
>
> Hi,
>
> Changes since v7:
>  https://lore.kernel.org/qemu-devel/20260111195508.106943-1-skolothumtho@=
nvidia.com/
>  -Addressed comments and collected R-by and T-by tags. Thanks!.
>  -Rebased to latest master.
>  -Reworked PASID support patches (patch #34, #36).
>
> I think this series is in good shape now and mature enough for inclusion.
>
> Patch organization:
>
> 1=E2=80=9328: Enable accelerated SMMUv3 with features aligned to the defa=
ult QEMU
> SMMUv3 implementation, including IORT RMR-based MSI support.
>
> 29=E2=80=9331: Add user-configurable options for RIL, ATS, and OAS featur=
es.
>
> 32=E2=80=9337: Add PASID support, including required VFIO changes.
>
> Please take a look and let me know your feedback.
>
> Thanks,
> Shameer
>
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v8-d=
mabuf-v4


Thanks Shameer

Retested ok
https://github.com/Linaro/qemu/tree/master-smmuv3-accel-v8


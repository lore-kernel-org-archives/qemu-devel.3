Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA12D13C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkO1e-0006VT-J9; Mon, 26 Jan 2026 09:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkO1b-0006Ok-FP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:57:07 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkO1Z-0001Hs-NL
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:57:07 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc174ada4so36623727b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 06:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769439424; cv=none;
 d=google.com; s=arc-20240605;
 b=gz+GFJ1gV9zKNtu7Xn1YXg9Zc9ePE8rIu6XrzqKuRDaRkzo0WFEgdEbxqUlHoi5dvp
 Kjk37NZ87wla7tpfdy1LOTqxPgVHSK7ga7mTwPcC6Vv700Uw52sZMuNfgwCJsaNWDKnO
 aICVdmqJORtsAqYdapt7xFmbbHyFI9E12ZxLtdaBaDb3S0/gVRERi93v0MrpR18ooPPb
 Btb1CkgQdO7a9+abE7OFTDk6+hJ9rMJh913TVhaEydIICVMe76CPewNltEERrpQ/ii9F
 /bLsPRLOKrw2AWZHs2Cl8oV/fbZcm5RuS+ok/urL4pZI8jOQzD3TwVLvITQdAozzZD/g
 YbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XvPngEILyd1XfkneDIt9fB/fYr3v3mP0gtY1lU/Qjt4=;
 fh=rut37jt3OBNO2qfenfC4LhyDRPHcFN8f+EHl+oHP3zE=;
 b=hMhcWdUPiaN9rXsoKFpaMOgCdDpyfV+yJE4qNMglQ+0EE77wIdVMkOeukVUzHbWDpb
 Ox1pwk2vaelvSwPu5LupvGCEaIuZZSwSp9Wocpns5Dz3tLqpxukkvLrhHSJXe1qF3quf
 cDXN6z3DneHRl3QXlmegev2IPFJgter1OUdH0rXGgAPZzscmrnbSv23cld5hnSIt4nq/
 46pECXu4u8moiRx4XFGp8SOHdCJS9nD7tyoXr1dRGE374hKVQeLs3jp/vMcIAne12hYi
 s+6oR9hCDTpze0eCmpt5KS2JWvF6dWb2UZXvJaubV/Dir2R0Z9DnNTMSdm9ArYI+eceq
 Q1dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769439424; x=1770044224; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvPngEILyd1XfkneDIt9fB/fYr3v3mP0gtY1lU/Qjt4=;
 b=WzE4vjvx/YwO0S4xSgzSXPyozAFhJXp/E1x5TL9zjvt+3S9fv/cHQrFLvI4D66J0xb
 5QoS9GGDm9h+eBt7zuyL9MvW5oMxFRlZkeF63upFGcRBMfCDRTrFmdiss7U9S2l3X5cY
 5GnF4q5E/IZWrAbOEs/zsKnUaiatHn2o8OrjjCKmLIdChh8Gy6tmhdvIQhGuLYXzL4GR
 ZerpHw8fBoNY/xVglnDNl2ZckyN3MOmumSdfML10R8tVAWZMeh9KT3ABWzx00HMX/Mi6
 eKdCgbQ/FwGXEE0lQpHBik8vgV1v25CxWXEwaIqoAr+hx0bUP3SS8Dacoy5+mNH9JyAb
 qdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769439424; x=1770044224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvPngEILyd1XfkneDIt9fB/fYr3v3mP0gtY1lU/Qjt4=;
 b=myxn8zR5oyGXNOxtZPEUU+TpujWoE+OfbfbtWw4FySdTFET7j72dI2sEwSoGCrOdqF
 t+6aOB5aXrC9isWDUNiJCEoZk/JoBFRDU15pe7xmJzrxZxNpAbvxxOW/m/bOhuOziUT9
 Sg5/lyR0TtfCMWG78cdPxZ9T8Y0U4fqC06EPRX9dDQGrk1QjbGitqsImUb0v52KNMmna
 9LjE/PGuL6aukOXtmsHm3uj8A7+FKnI7GOTyXS/aYh4mpU2frSwietHcDqf+k8Ykx4iv
 d5DXTNhD1DfYZm+MYnN5WfbnxWUx3ZarWau/hxmVU/l45TDYFNisIndR3eJQYAqd0v17
 DJ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ky8u38X6rywgUbL/dZhiolLABYd9QCML+/2QV8wVxD29rL8NwMCv3Ce4pV2BS3CRIRdsPTzXETRn@nongnu.org
X-Gm-Message-State: AOJu0YyQOiyGuR1yVL56XnRuM3O+Iqp29+M5soGGVRlxp8cnwPcSqyrW
 gdNbq+XjWVCseDyJUnmrP2Y5iT7OSsluWi9T8kbJOYATJAezLqWHExnzltuWFkcfYXk8sOw1gtb
 Nz1oCbjtBEa/5kAhbmo75+2CxGMfzY+c9coXZQYPJ3A==
X-Gm-Gg: AZuq6aL0kC44Oh8R1Cmq1I3DR60imxpucRgAkd8n3HMFOxni8HxtWJzVUJK+B50YETh
 MTfIkmv9GaQUn0IX1+T5EKx0+ShtwIFvLNHrJBe90XgaqVoSBAMK8s/e58zNefH32NM2KbJ5BY5
 D9r52FgKr3II6ZRGqo7n1lyxekghH0NL7uBKqR9Hgf8c/n6LUWDR7LjP0U3lJfcAwc3P7AYVApt
 wgJSFGrlvqYwueM6Hjdqnuwi1hntcJpjYRbeEJkqCqUDdVSV0N6mfjDYvpmebCgobNzSTQqB34i
 oIo2
X-Received: by 2002:a05:690c:d92:b0:793:d0ae:d8ed with SMTP id
 00721157ae682-7945a863d52mr36472867b3.18.1769439424307; Mon, 26 Jan 2026
 06:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 14:56:53 +0000
X-Gm-Features: AZwV_Qh5MV5xhvYVTM94g3pYpzo8WGWvwmk4TmBCljGeLV9ip9t35OvTT3k7Uns
Message-ID: <CAFEAcA_ziaNu_xdDVcLb8s8Jb7YnyBF=Sda5=Q-Dk7gNhRVvHg@mail.gmail.com>
Subject: Re: [PATCH v9 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 jgg@nvidia.com, nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com, 
 clg@redhat.com, alex@shazbot.org, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 26 Jan 2026 at 10:44, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Hi,
>
> Changes from v8:
>  https://lore.kernel.org/qemu-devel/20260121175248.87649-1-skolothumtho@nvidia.com/
>  - Collected R-b tags. Thanks!.
>  - Initialise the AcpiIortSMMUv3Dev struct(patch #25) to fix the reported
>    CI test failure[0]. Please find the latest CI run results here[1].

Thanks for investigating the CI failure -- I've applied this version
to target-arm.next.

-- PMM


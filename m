Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC9DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkTO-0003I2-4j; Thu, 09 Jul 2026 04:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whkTM-0003HC-C9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:51:08 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whkTK-00074F-Hu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:51:08 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664b3831a20so978351d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783587065; cv=none;
 d=google.com; s=arc-20260327;
 b=aqiQS632celx7ahwZdNziGiQC1QMTY6HeLF9h20l0MDU2nLOSf7K2czJd/yqA0QYHF
 HMMJ2nffs24YqOZf8CbOEbrsR+oJ5ItcbEn/r0SyMCDFpemr2cXb+EXDiLk9x9gs4iQT
 UaLCX6uZAnsZFlNQ32xKYtoQ7ytM307AUS2g3J6bBfAXq/CJaT4xAisXI9ggA+zIh6DW
 W0oak2EXAGN2KGQyt9SIU64qMgByKmaXo7H0N42LeUjAn8IPSP4BcGP+iPltAPghAfam
 vbuJPTPGGlBSpng1LmddrTGz6cv/cnhC/jTu5XXXBShODltUlwyAuLL4es/f8F8OHGcj
 JzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dftZzcUdQANuJzxyS9rtMD345YGI8E+HJTWY0rvb3zY=;
 fh=seLqzMn7RwRMOH4iMqxCA+O9B+H3gFtOjt3FsBQPmzw=;
 b=GC7RXvyeXs5dIi0V9Npph+hX4J60VHa87b/Hvv1mfkAvGGjkUWeplYIF3IDaqXq0y8
 EkEr7cNrKS/PYcyU0/a42nyle5Oi3SLd8uGuFraSoNr61HUZk7y0GEJJeOTvr/Db58QF
 o2naCMIz3si9XMdruP7v4T4SF7vPa6GC8N1mCOp3iFqGcr6hfu6omtGescpR+khnee2v
 E65rzRDNFsA4OI6TjWrZPqFE8J/lMyplf99CKP+4tq7YeI0whTCmyg9YgAxiUHkiQiyl
 SCMfJ+k1Oz2eTMNAytjA8OBh+RNtb704tyzWjTlII0hVVJNunM81eTEQrV+Nfhc+aA2U
 wT4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783587065; x=1784191865; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dftZzcUdQANuJzxyS9rtMD345YGI8E+HJTWY0rvb3zY=;
 b=eILftnYOWbvFpqetM/hXgu2y58tzFnoyA72TxHoxs7sP/SnU3BJLF1FSbcyHTs/vJP
 9+QhliNvonLR1kwrAMXdc3YQIz8n8tnpp0Qfc+nJc4wRn3HXhb2hLcBG5VWqCHesKw8P
 z05zE3qRt4hiYLlgJYKCEUtpW3vr2nmb68irp+5LU3CE+D0gcR1s+DHOZD1+TR12kAuv
 M7gjjhOWTBu6h49hRi6baXVhPlN6EDiXgCvnfNRxQT9OcUwtS5qv1nMiUMQjwJvfHxGm
 SSg/Wt5JtJSynviRFDZ/2CiET1UrcE7shp1MF+awinPSRH7FIMrCqPDHd/MGz5IzqReh
 CG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783587065; x=1784191865;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dftZzcUdQANuJzxyS9rtMD345YGI8E+HJTWY0rvb3zY=;
 b=hz0mKPs4zoduldn7uqRzNgRIQ8NmZQXtJ/NAwzT4nqyToI4BlKMs5bqc47ddx1q9pw
 4+9Qk8jvFZuJFw/VMWSsi8O6F6oW75jgzf84IC+4I2JNfw6/RPkW4DKalAW+lcuuK5Si
 zVF2nA+3+vTBhuMW4L+xmeYBXwlsHJMeKUyX91V9FDTV47CeWfLAoPDHh6It0Nobgy4X
 Hlu2a0nXZmYVLBIoRChN5JVKJGCsl7EsW6zEoDlgjdM+NyQ6Tcz7POj84VNOJOEebDoK
 ZqMwvhyC8NW6f84b5LY2iB6sjDQyJ0yGxqYnU+pPentsBpsbV4wm16ETK1T5B7RR0joL
 i0aA==
X-Gm-Message-State: AOJu0YwzrHdtTQg1Mknmqbr87UMbBMD83shAXUEtWI5TeyPJI8Sk6bka
 jhWfJlvzmjq3uM4rXDQegzmwhQSHzgewqFTUoa+BLrhc36o3cMxsRtkKA8hD6waEYkQNPoDFn7C
 g/Xv5X+xB07YUg27/2eY6A4CFf7tk7qS24jAXudjGgA==
X-Gm-Gg: AfdE7cl/GkxWi+APPlcj0FiL3VWUQq35YgZmjkh8Ly6J+l0fxCgIaHboVYkHn74ahlW
 ztOmZ9C0YpJKfLDlGurJE86KB/5NDf10sHckcjD1aDm9n3rs5K/JGZX3L2MVU83DkxfXQrLbqKA
 QQ0MfzWtnux86WaIWjspRZG2t7pYcbFJcaz4y6fgPfn/h4V9yyzNI60jnpRuUyImkq8EbC95PkG
 z3KYAPwqG2pjj+RbOQJ3Ba9hWUhn9AGtXohHQVkQnl+khRMCRQPtTutK0BXsTaq9xhEgDVwMorW
 W/dmA5faq0TG3n7biWckPGIGVUoTZ6Ov5X1qnK6A5JE0dBBw588Sb+hb
X-Received: by 2002:a05:690e:14cd:b0:667:ac1d:16c6 with SMTP id
 956f58d0204a3-667ac1d1a05mr3765342d50.81.1783587065081; Thu, 09 Jul 2026
 01:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260709084728.92862-1-alexander@mihalicyn.com>
In-Reply-To: <20260709084728.92862-1-alexander@mihalicyn.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 09:50:52 +0100
X-Gm-Features: AVVi8CfMMMIQr6LTs3iEgPiEmHZo7RrBtWRcBg8m2EspBCw5QODvIYCBvT34URo
Message-ID: <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Let's use GPtrArray to build a list of blocker features and then
> g_strjoinv() to build a final comma-delimited string.
>
> While previous approach was technically correct, it is fragile
> (because we need to take care of static buffer size choice) and
> Coverity dislikes it too.
>
> Note, that we use g_ptr_array_new() to allocate array which means
> that GDestroyNotify callback is not set, so we can pass pointers to
> a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
> any problems as there won't be any attempt to free that memory.
>
> Resolves: Coverity CID 1663673
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>  hw/nvme/ctrl.c | 41 +++++++++++++++++------------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891..95a586d82a9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -9352,22 +9352,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      }
>  }
>
> -#define BLOCKER_FEATURES_MAX_LEN 256
> -
> -static inline void nvme_add_blocker_feature(char *blocker_features,
> -                                            const char *feature)
> -{
> -    if (strlen(blocker_features) > 0) {
> -        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> -    }
> -    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> -}
> -
>  static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
>                                          Error **errp)
>  {
>      uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> -    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> +    g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
>      bool adm_cmd_security_checked = false;
>      bool cmd_io_mgmt_checked = false;
>      bool cmd_zone_checked = false;
> @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
>              }
>
>              if (namespaces_num > 1) {
> -                nvme_add_blocker_feature(blocker_features,
> -                                         "Namespace Attachment");
> +                g_ptr_array_add(blocker_features,
> +                                         (gpointer) "Namespace Attachment");

Is the cast here because we're dropping the const property of the
literal string?

thanks
-- PMM


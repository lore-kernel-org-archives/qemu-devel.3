Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69B4CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeyM-00034c-C9; Tue, 13 Oct 2026 12:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGexH-0001kM-QR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:02:21 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGexG-000899-7X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:02:19 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ac525c1f05so736717b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907336; cv=none;
 d=google.com; s=arc-20260327;
 b=hcpQLxaXMX9tAV7IWMrO7RE27CZcDvQEYmuA3seuKnqLCgawieTBgLrqdj7F8OdT+8
 LG0TVN4ujRbLV7PflCdRVfs44ExKZaJX5yYZwF8QaM7U4VhBFIIfAqE4kF1LO1IES8Qc
 QGABPdAZgSLHOZfuu64bUTXXsKmO5im0UFUhZyPbWL4iMsdftkYIIddypA2CaeXnjqP+
 JAFIoXPzvs4bSQE+a0xX4FKOPDxHsgrHzsXkeSovoDZm6rO3GYXR9jTff3Zvro6epeMo
 PU/8IKh9pgA0Q1gNshUS8FcAZspl+yC/+LFdbxqAfj2HnPa/M4wQv8uqRhNoA41/SWWI
 faUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y8KhLg23GxJbkZ8/oheb/mWpMcRXdz6/YyjICcKTLIo=;
 fh=1ZUN/v4q2KbgKCC7Bjd1AByTU3rr4V2i9gq24mkx8iQ=;
 b=mkTB5eBGwsK9/+7TjqN2sd5MCghU7kDJytcDXqCce4i/bJeeauOHRISWpGvKVbSjMP
 jIE6dxGPD5xRV9V3c/fdN1cm2S2cu+OZi9QFMAjgUP52oO64UHilsbDlPpoyUzV9iooX
 1wZNS+wlnJL392zu0r3yRWXEVfX/QcDb+J9LjJ3sGrloUHcWv5eNouse799L+qtKS9eD
 Jja3FIdvI1wgPd/UTG48szhxXo7SOWHPdDUyeuH55gCjBnQSGowSPIQ4h2qpgKjupzT7
 vlfJbMg/21NKxEp64ZaUhaDV9tNn/D7UbHzJGhnzEcFoJLJFX5ipU1/WmOdh5Bst/5RN
 LUkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907336; x=1792512136; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y8KhLg23GxJbkZ8/oheb/mWpMcRXdz6/YyjICcKTLIo=;
 b=oqazwbS19BRAr+uvMEIPAC4fwUC4eRJCB7xNNCFBClQNkIDyAllibgDetnq5WjDiTc
 e4pyh7IwJc+8SLzYxn1XHCS6EGuphGMdQfa3NW+tp75URwKm2DmMX52NKOmmyZD8+ipf
 0UejdYfzzC3FDDbiHrXtvKEKl9wn3Q2W1tKIFMirlCuShJkPWI0jeNrohS7t2fhg+HkZ
 wnodw+tt9ke+ghotWh24vunyFYBkpSJkPU4Onv3Oo0C9EoO29uzXnimpBXXiKooW4pyy
 FhxQSoeXcsiNfDNOF1SCl2qITk5eUH+V4z+udl7ocYmhgHnTY8U4sO13awRAR2E7m4UC
 Tq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907336; x=1792512136;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y8KhLg23GxJbkZ8/oheb/mWpMcRXdz6/YyjICcKTLIo=;
 b=rRVk9ju+aDaOr7SG0FXUadNC1kGUhvxzrCYRCMfdRAvdVhYTtYa+Hvwo0YraZzjOaE
 Fa/KL2DgP293Y9S67FwlT0i2JodxHvNoPWi580OtflyzSgJIsGyOxHjHeHXPeq1d3F4p
 4UjVTTN6c/e5ey8S9VYewtaiZ14HItLpHV9HbBqZ/hZ+6jCHauS82ZkiiHQSKjTqEW8B
 ttJ+N3TXNhRVx/H98Yx1pgHurhYmj85/H0Nuuv/Y8jjscF2JVdFA6orMTcP7gc/9FjdY
 gaohF2O85n1i0cBymjErZKpk5a2/F69vvcr4eIkSkwF3bIgqgk6IV1pnI2+D38dKAIx7
 Onvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJTcBWcQWt9yGXkLj26Cxk5S+vbl75wqJ1iI2Nag8QtNtemEiLyQAwlzWeKAJ2lygi0ZJcbdXXQvAp@nongnu.org
X-Gm-Message-State: AFq9FYIiFnXb8tOKP6MqwbnuVBE70GMVdzHNXSC6qisNp1hNyknIOyqD
 01MDxEoSfXpcxM/zlCR56YXgmyiK+OEiObnro4CDi/C3WqZWPmeTnzsA2iSJI2xFKYHk7JCBdAA
 1R+QbQaqwysqePFOW8plysRsv4S/Dadb7srFx9aTQ8w==
X-Gm-Gg: AYBFou2eq0MR6Yhelz+/uxvyLf1flXjsmpTY+QYe//WoG+7L9O7TvpAuIJQxchvP08A
 8HVzLiTkixTFzgZCkBSW5uHXVaUoNafwcHB9MIjYDJrT3DMw80v3Wj8O3hXACsiWXKdOQoBya3r
 HfU6WVkby2NRI7tghAxTIxOqU55Bhi7c+H+C09T7Fdmm4pVjGWdd0VVdv4W/7UrHezy6CiXGyAe
 G/vW6VZIxcoD/D5LPvtKksHlHSenIoaHrEkkxubA/M7JNjFsY27cqokh/OKPBTmmyC6+ZPw/EMO
 uaovHuN0SQW3AHqAGbTlmy55RlRu4E2w6EIDKTkLB92zTn2xibsYAWsVtvuI9W6GzkPZVq1pnF/
 7xV91vg/UeasR23BqjU0/ijKl8dx8N9CInyWSsIg=
X-Received: by 2002:a05:690c:e209:20b0:88e:edf8:e375 with SMTP id
 00721157ae682-8b07ec7ef7bmr37768077b3.5.1791907336383; Tue, 13 Oct 2026
 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-23-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-23-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:02:04 +0100
X-Gm-Features: AclHuK80DG6dYDmjZ4Il0zSP5W0p662tLmoBbt0KsX3X2_uqBTN8q-V7MgfYb34
Message-ID: <CAFEAcA-hOJBffCrBZq5agyV6vO+chH3ju-fpdqjXr1ZZGSiB7A@mail.gmail.com>
Subject: Re: [PATCH 22/22] i8259_common.c: add missing 0x prefixes to "info
 pic" output
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
> This indicates that the specified register values are being output in hex.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


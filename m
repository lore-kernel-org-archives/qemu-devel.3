Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B2CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQxZ-00036Z-TI; Tue, 16 Jun 2026 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQxX-000361-RX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:23:55 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQxW-0007MT-Gy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:23:55 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-660e9ea26b9so4587799d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781605433; cv=none;
 d=google.com; s=arc-20240605;
 b=lDsFbZeUdce2fOd2uYNcod/F7maiElw6oqOTAt6jMd5+J/qqikd2Kpapa4imP29h/k
 0oWc+SnmThUBJu8FUW82xktStFMZ68dELosm/flrji8c/wNoNUu+Z5Tx8uOECh1/BRQ/
 sm19RT3s/Z/9Qe/grgsfpaYP3FTui1cSnDNNIFDdMUUImrXq7uU6yyD09MjhAM/Kb/Ry
 2hT2sQJzNkmgoVTxzR56BWf0uox+Mha13I1SQgeIGEOfvxhGnAlc0Gjyb6+po4n5NXvC
 KpToIDjW4YkQZB8osEj/bc0TmanfDInRnHDpsConTpMzte9xRR0a2/fjjuHImumzDx2I
 OMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=64sCoBfIuXYmVUlEGieFuQBeLrctJsrvbr/fX56BAWU=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=SKJ2O7Am9lZWtF4XPT2ry3sDFlhUnK67aeX0QHqZRduxOGkhJeiOFST3Mi60xuvPqz
 QBbUOj8xPhDMrqaEOEp6px+aj+d2zsE7ZLN27c0PGYSEkCjpXlx+/7/tKSO4t+miewUP
 A37wTe+y1R7MVwWX03eGcoqBfWg8QQ6SgJ+xIaefCQznL3oVKaOQMi78QDH/Grfuwlcb
 YA6EAxoaoeTg62COvKB69autOvrUsNxPdi133fYRaWRw/LXwA/FpqOXmPbtkc8IdlTmx
 AIe1/Fba4nt5suKf+QyGhOm0Uqohp4/P1mze5OVHPuZTiJZ+wYIQm393r1QqFIA0hxGD
 zOpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781605433; x=1782210233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=64sCoBfIuXYmVUlEGieFuQBeLrctJsrvbr/fX56BAWU=;
 b=SCKh+6fd97X7Y5m30PEkBpiCQ0pIzlevMxrGFGC4SZsTwxBX5cMhdECPhBPzKXzmYY
 4/4ZOVQPDDuapJtVBFBPGUZI3JqDzUhiKzhCG4MWBqvOKhDDytGSzYhXaijK4/vS5l/8
 jlDYzxy/0uDMfSqcJjB7QIKQZBAvTSztDXhJRv+lq/0+pYopqbJ2/5x0Ypqi7PSDPimt
 NBd2A2QpaSGzk9VIVRuGkOd4cENR943aWyg/rfNiPjpj8MJR+dd2FrKMe4gKDASzkZpT
 kM2MPyE6lMHYGjG8Nnh5tMbvnK28Bj/Am43KqIy62nYz5kieqjtsJYOkluAfHHndh8E2
 AaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605433; x=1782210233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64sCoBfIuXYmVUlEGieFuQBeLrctJsrvbr/fX56BAWU=;
 b=bMOywnazPsULn/x+wvh3/I4FOts8YAAQ1YKgcwHGdt3109TYNDyZ3aK+UxVXJLV8qR
 DmpS3+wgLm1wQkFiJ1mtEVzUuplt8hlWwJyxb0W4Cox6VMX4IoG8S0rBGFXLX9S90AXv
 dFnpnvSqHOIkdK4f5Ft9VmJl2zC4ABYiodJdKulFGvj92kuLeXn/Gw45PFyUdFXWXZA3
 Fw85irNkbozKTNyvoPV1Gmx6YNxE4qxu1qm4CrB0FxOA8sM2caOYlJrPblj0TRB37oJ7
 cYtIw0B+IANcwBiNy8GyG6P1mVgtz61YbVLZ87PmJN0ZvDwSQedrQkSzb0HGahbKxdll
 Rt7Q==
X-Gm-Message-State: AOJu0Yz8FOH5LugQ6VfaVIQMoy9RGmW8BUoY84/BC1sXuAR1JSL0Y3jy
 /1nIDBgwX6Hc0kGUGTZC2e236k1Gi5FZ/KvwvmwsG6//XkXF34QxotAo0OaWaIMIvsrCtheXLGl
 Jl1ywqyPyGcngkaWMTBHNJDXQFp7vmwZpbLbFuAhaZj/oq/YKPrEO
X-Gm-Gg: Acq92OEx4j0L+adipRlZvRUUp9gstOzXYyXN/CTAp3krQDpZj8s+UXeETOdIuZlITnh
 d0GLsv+3N61zfGgDe/cEY0VrSSeGjbWSLVWzabfq3vh2JznrAosmnRuym47btJiY0amZf2bX4fk
 734Q05CehaEEvUQxUNqCIT8t/brPfLtCzy6EnrtMOueXnjt5YujG7YRiihCYTtqhATIultiREO4
 7sK8p897Cd7rvzYGAub+jbdSBwD5IFMxDpnVkzFqEKmLUeY4dIJayp1/+WAZLVXwp9fn4ME6O1f
 qdzHpKHCdkMVjqH0iCkLykSax2yfkLwlIR/sCLWIujiQcW8KDViiJ/7WlHqan1sD14w=
X-Received: by 2002:a05:690e:1447:b0:662:a4ee:105f with SMTP id
 956f58d0204a3-662a4ee1245mr6106244d50.48.1781605433384; Tue, 16 Jun 2026
 03:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-4-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-4-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:23:42 +0100
X-Gm-Features: AVVi8CdF-udtWh0mL_IpeFy8_rj2lgF12LKKEQj-kW0LfZzDYBUCWjHww8dsksU
Message-ID: <CAFEAcA_d0NBsEVVSMDKwaJpvLfA2LMCEzYJiUPgee9bQ9o6BSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] hw/arm: ax3000-soc: Enable Axiado SD host
 controller
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Enable SD host controller into Axiado AX3000 SoC to load kernel and rootfs
> from eMMC.
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


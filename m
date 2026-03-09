Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F98F3C250
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaYx-0003CF-Dx; Mon, 09 Mar 2026 09:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaYv-0003Bw-Ch
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:22:21 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaYt-0002AA-OQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:22:21 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so10644238d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062539; cv=none;
 d=google.com; s=arc-20240605;
 b=eV3yCviVGq/2rGxbjFEmLh8/1NVKvP+O4nl22LbN8JcpZVcwueJnwstwzBJeFoJ7EB
 bS9Et2zmhizQCFrMc4+q8FU5OwWf2dVvsh7MxkxK+dcQWwr+wh/OfLMfpuFT7G616dpD
 aZT5BRDuy38c55AKL2kD3I1VYg1/UmNWSckcI0dzDfKCutWMi5P6HJ5LN/j0FM76xZjQ
 WZ1o98yuJPp9mBHQFN47ahPI5Q33c3xCqXXFkcz22ZDm2kLHijR6wgo/Me8tSBf2DGFl
 1XyL3tqH1Z8ej3v8s8ZOApsmodtzit//KuROT0NJ8jQjEzKD48fqBA8mJJdtgC5gGdxc
 Fggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+91wLnR/ml88XGo1yfd93vaRMNM9/VSMNMg2aUuLE2U=;
 fh=lEs/cTj3BTzOBFEroLDN7JqSJCTfw/Wm5U0QDS5XBqw=;
 b=Z5lYHQIPRbDmpp/IfCeehatU7OrPILU9awAm8Q0cJ6Rn1Eidy4ufZ/Qv3DV/wRxgcd
 R4s5GQ7TVrgxxHiye1hv7AiIRMAkgsBuOM78KEjiOrH8v6JOImbwPV+PQf1P7g1o5N1m
 JGQVTcBFelLKy/01m5auqMMSq8NjzYYOzVGopUP10gz5k73Yj5QNXYrR3uEs+zTi9pPi
 tvwUcEATaMJkmBQm9LtvlQOVsAs857rn9CanVu3Ox6nwYGLi7gLc7trWb2giw5Xf0Y6B
 Zfo03Ub+Jq2gNXjdlRC3B0+lemCI5924PWVAH039r+YTDoUlWZKF/64nI3X67/iunw2v
 SXSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773062539; x=1773667339; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+91wLnR/ml88XGo1yfd93vaRMNM9/VSMNMg2aUuLE2U=;
 b=lL91XeWbUw8rpJ6eOYcdmAr6Ow4V4LBeVZP7aFHVK7qiPC3vjAjPoo4c6lopTIUsBL
 77cnkPMnCyv6WYOKrcT2dyvvPgYVzGvq3S1w8xkD9vQLtIpvER2ppGOo01HQzGbmHNi/
 zMQLLwnZNotWm0PP7Zp6QV413bXCckqWxX7mGXPY88ofBcicLbYK66qWDncrOgxACXpG
 /VaJfHOZ4jn4S+yvjIYfFQtU6HH7b+iRNlkUobRz2ntH7DuUVICGvb77hjlS0ZJmY94p
 cWky4EqBbxCjmZg8G+Mie6JlUI3YZ5AoHZ4lJ9M34D+DY7+/fjRyl60hnERUDytJDVM6
 LJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773062539; x=1773667339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+91wLnR/ml88XGo1yfd93vaRMNM9/VSMNMg2aUuLE2U=;
 b=k87qf+VNjL3/nNFg3Qg1cRSwWjL33Vh0FDJYq9QFvkZywTO3irAxtrUKskEEq6oy98
 IbOjVD37esP/YuINuZBI7Xg1Dkx3SQcq6CTfxBB/Ek4Gb9iASuJ1RH4YLCeKC+flpd0/
 8FHoadIk3LPrH5nbFvdbdsh9XH2w6atEwy+PMtLYWSRP7hk8Kr+/gYZRBOBe2YRH3rKy
 fvlfFjAfZzzk3LoGMvwXB500z1oFPeS+3+V/yuuVKKtJ4XK6ZgdMXh0FvgxrfHQNa429
 6oqUFZzdH7idJDFizeWyUql1nFVDSIkWxNwxqr3f+MltX6V4SzfwlK5VOcIrDz2UvIeH
 YD1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgPAUWw5lDMQCk11FYkxs/Wmx+zT/GfquNgqSphx17EtQgwvvBx9IGfo9vKgRSI2OXSRdMrq2kW/0o@nongnu.org
X-Gm-Message-State: AOJu0Yyji8E54A39aKPPu0hrBGOTT3vGN/v1EKWmmQPN8mE+ouoeMWgj
 GJ2amYf8yhH6bbG7HH6vQNvtpnrxPZEVC8xKOLpWCa/Rw6aZZFivCIuQoXkhzlC7QWuxDxrS6xI
 Mkysf6GdpHMURb4JuBlrc+L5sDccociZbjiVT27CsoQ==
X-Gm-Gg: ATEYQzy60qAN/jG6+kGJOiD867ZCewzRswmYjoBxeiL0ru48o04ETmy+xxOvS+6Vg7H
 t/xLpHoFw4vRUXJFk+tpS86NYa92hZYIpQTstcXRp4nKR8AP7SUZMeSiJOzrzehhDvfgkUaiTpa
 Mediia0Tzs3umXPVMsX57p5QpO7ok5zGicwkux2mrfKq6T/AZBY0egENJuYq+UjzhakYavPu69A
 Nu8EwLyNgefvH7hFRR5CgEC6KvRlFw29QPyVk23ATtPftbls+7PBY+5t8/0VSa/7Ea7SjhJ9mHW
 gsRjgu128kpilN3ogbJbGN5WgektlYp4FKXJeOMTPVwzkaUEk/wH5LeLZRe0hyAcTwc/o5OjQcb
 9RA==
X-Received: by 2002:a05:690e:1a4d:b0:64a:d705:31d0 with SMTP id
 956f58d0204a3-64d14147eeemr6931531d50.28.1773062538545; Mon, 09 Mar 2026
 06:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 13:22:06 +0000
X-Gm-Features: AaiRm5297MrNNPxp9AiUic3V-M7z2fA1RZbxUvsrvtEO9j9rYAsEDCDsOzhXyGg
Message-ID: <CAFEAcA8i4aRqCrXRwpizbAeXXQy9ntk3OQofRF3HUXPsav_jAw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series applies on top of
> [PATCH v3 0/7] Improve traces on migration failure due to cpreg number mismatch
>
> It introduces an infrastructure to explicitly tolerate some
> mismatches between cpu cpreg indexes/values on migration.
>
> We especially handle failures due to an attempt to migrate
> more registers than exposed on the destination.
>
> Once the infrastructure is in place we can handle the following
> known issues:
> KVM:
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>   from v6.13 onwards. Causes forward migration failure.
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>   register from v6.16 onwards. Causes backward migration failure.
> TCG:
> - We can eventually remove AArch32 DBGDTRTX register which was
>   erroneously defined.

Hi; I have this on my list to review, but I think this series has
unfortunately missed the 11.0 freeze deadline, so we should aim to
get it in for early in the 11.1 cycle.

thanks
-- PMM


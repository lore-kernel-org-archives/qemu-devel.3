Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D595FC6171
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 05:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbu5j-0007CI-OX; Sat, 03 Jan 2026 00:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vbu5e-0007Bp-DO; Sat, 03 Jan 2026 00:22:14 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vbu5X-0006bR-M5; Sat, 03 Jan 2026 00:22:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7Zlxp1hpZ55DBQ--.105S2;
 Sat, 03 Jan 2026 13:21:53 +0800 (CST)
Received: from [192.168.31.154] (unknown [113.246.232.176])
 by mail (Coremail) with SMTP id AQAAfwA3kO1tp1hpYJgQAA--.30162S2;
 Sat, 03 Jan 2026 13:21:49 +0800 (CST)
Message-ID: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
Date: Sat, 3 Jan 2026 13:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mohamed@unpredictable.fr
Subject: RE: [PATCH v13 07/28] hw: arm: virt: rework MSI-X configuration
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3kO1tp1hpYJgQAA--.30162S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWlYJpgAZAAAsr
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ur18CF4UAw1rCr43ZF1rtFb_yoW8Ar45pa
 yUKFy5Kr15tFy3AaySgFWxWFyYvrs7Ga1UJwn3ZrW8XF9xt3W8Xr1jyw4Fga47CF4fArZ8
 ZF1jqr18uws5XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
>
> Remove vms->its as it's no longer needed after that change.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c |   3 +-
>   hw/arm/virt.c            | 110 ++++++++++++++++++++++++++++++++-------
>   include/hw/arm/virt.h    |   4 +-
>   3 files changed, 94 insertions(+), 23 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 86024a1a73..f3adb95cfe 100644

I’m trying to clarify the current status of ITS under TCG for the virt 
machine.(may be a stupid question...)

The virt documentation states: "Note that ITS is not modeled in TCG 
mode." [1]

However, when looking at hw/arm/virt.c, I don’t immediately see a hard 
prohibition of ITS under TCG; for example, the MSI/ITS logic appears to 
allow ITS depending on machine/version settings, and the series also 
keeps tcg_its.[2] [3]


Could you please confirm the intended behavior today: is ITS expected to 
be modeled under TCG for the latest virt machine?


[1]: https://github.com/qemu/qemu/blob/master/docs/system/arm/virt.rst?plain=1#L46

[2]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3490

[3]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3656


Also, Mohamed’s recent work to support "GICv3 + GICv2m" (and to control 
MSI independently from ITS via -M msi=) looks like a very practical 
workaround for environments where GICv3 is needed but ITS is unavailable.


Best regards,

Tao



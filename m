Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A464CC2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 06:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcHOs-00055u-VY; Sun, 04 Jan 2026 01:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vcHOq-00053x-7r; Sun, 04 Jan 2026 01:15:36 -0500
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vcHOh-0004mV-KQ; Sun, 04 Jan 2026 01:15:35 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3A11kBVppqePXAg--.57375S2;
 Sun, 04 Jan 2026 14:15:00 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXMO5aBVpp4ckQAA--.15601S2;
 Sun, 04 Jan 2026 14:14:57 +0800 (CST)
Message-ID: <265a2c52-dcf6-41e1-8fc0-c7cc94b5edd2@phytium.com.cn>
Date: Sun, 4 Jan 2026 14:14:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/28] hw: arm: virt: rework MSI-X configuration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
 <47DF75FA-8539-4748-94E0-74DE080BD71D@unpredictable.fr>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <47DF75FA-8539-4748-94E0-74DE080BD71D@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXMO5aBVpp4ckQAA--.15601S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWlYJpgAZAACsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFy3Zr1UCr18JF1fJFWUurg_yoW8XF4rpa
 y8KFyYyFs0ya43GasIqr4fXF1Yv3ykGa1UXF1xZry8XF98t3WFqr1jyr4YgFyfZr1rtFW8
 ZF10qw18Wr1rZr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_PBL=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 2026/1/4 11:15, Mohamed Mediouni wrote:
>
>> On 3. Jan 2026, at 06:21, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>>
>> Hi all,
>>
>>> Introduce a -M msi= argument to be able to control MSI-X support independently
>>> from ITS, as part of supporting GICv3 + GICv2m platforms.
>>>
>>> Remove vms->its as it's no longer needed after that change.
>>>
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   hw/arm/virt-acpi-build.c |   3 +-
>>>   hw/arm/virt.c            | 110 ++++++++++++++++++++++++++++++++-------
>>>   include/hw/arm/virt.h    |   4 +-
>>>   3 files changed, 94 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> index 86024a1a73..f3adb95cfe 100644
>> I’m trying to clarify the current status of ITS under TCG for the virt machine.(may be a stupid question...)
>>
>> The virt documentation states: "Note that ITS is not modeled in TCG mode." [1]
> Hello,
>
> That’s outdated documentation, ITS emulation was added in Qemu 6.2 to cover the TCG case.
>
> Was implemented in patchset: https://lists.nongnu.org/archive/html/qemu-arm/2021-08/msg00070.html
>

Hi Mohamed,

Thanks for your reply and the pointer to the original 6.2 patchset. I 
noticed the commit([PATCH v13 09/28]) updating the virt.rst 
documentation and appreciate your effort on that. It really helps clear 
up the ITS/TCG confusion I ran into.

Best regards,
Tao



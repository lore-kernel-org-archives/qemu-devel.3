Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ECFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGlKK-0008H6-K4; Wed, 05 Nov 2025 16:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vGlKI-0008F9-J1
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:45:58 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vGlKG-0005Sh-Pu
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:45:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762379142; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=COAg5DoEwNNHYRSQq5IvATpizze3CHVdoTNBF7EW0qJMJ4W+AhDk/6QOND3ZsRBXXWsx2ceFoxVdRhEGrBWML22S6GYQyXRFFnm73fNB+dLbjqwwdwzrHSG0hhxFI02twJzy8gMZ7iSaTvI9sIypxBSlv2WNMnMHrRyXGihF11s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762379142;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YVTmINNWBw9GzquVQkPLqImSqm5XFyiJVF93MCUyxQ4=; 
 b=YJ/kIP1q7wdW6vgVoFoL8+RCMEFLppVUX7aOeLgmX+AXmteYsTdpj7UHZhn/lOq2hWUFH4+gG48/d4F3xvBlPnKDLP3hOmBvibgiB46IVHHKSYctZdV7iGJjIlKQoTMX2k38Nl7ZUxUr9MUtkZT1apSbxS/yk0ZyqXih9YWEFxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762379142; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=YVTmINNWBw9GzquVQkPLqImSqm5XFyiJVF93MCUyxQ4=;
 b=XkF/UoeKDdqiHzsl5M1pj13+t0NyBikJNcd4gQ8Chz8mA/9ldl569ew21ynoHTxR
 mzYOpeUf3XQE27uLd0mR7JN95jc824Qj/S6DA7cO04mjyCaCYoLRI5Hm8GNoxne7G7d
 8QHDM1+y/L2Bi3Wb5o70WPYrwAXydB6BSY4Y9jJo=
Received: by mx.zohomail.com with SMTPS id 1762379139453769.4345765432386;
 Wed, 5 Nov 2025 13:45:39 -0800 (PST)
Message-ID: <4f662547-4f19-4997-b6f4-dbf58db0e1fb@collabora.com>
Date: Thu, 6 Nov 2025 00:45:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v8 1/1] Honor guest PAT on x86, absent Bochs display
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <176045956423.5579.13349691093596703310-1@git.sr.ht>
 <2f9abed7-2cb8-4c96-b9cd-5e8d2084b1e7@collabora.com>
 <c54a2b69-5af0-4319-8241-65bbae399e4c@collabora.com>
Content-Language: en-US
In-Reply-To: <c54a2b69-5af0-4319-8241-65bbae399e4c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/25 23:07, Dmitry Osipenko wrote:
> On 10/14/25 23:01, Dmitry Osipenko wrote:
>> On 10/14/25 19:23, ~myrslint wrote:
>>> From: myrslint <qemu.haziness801@passinbox.com>
>>>
>>> On x86_64, where most CPUs support self-snoop, it is preferrable to
>>> always honor guest PAT. Not doing so is a quirk. There is a default
>>> enabled KVM quirk flag which enforces not doing so due to a former bug
>>> in Bochs display driver.
>>>
>>> The bug has been fixed but not enough has yet passed since so we only
>>> disable said quirk flag if a Bochs display is not configured for the
>>> virtual machine.
>>>
>>> This commit also moves around a bit of code that would be called when
>>> the initialization of a VM is done.
>>>
>>> Signed-off-by: myrslint <qemu.haziness801@passinbox.com>
>>> ---
>>>  accel/kvm/kvm-all.c        |  1 +
>>>  accel/stubs/kvm-stub.c     |  1 +
>>>  hw/display/bochs-display.c | 17 +++++++++++++++
>>>  include/system/kvm.h       |  9 ++++++++
>>>  target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
>>>  5 files changed, 63 insertions(+), 7 deletions(-)
>>
>> Looks perfect. Now up to Paolo to review further and apply the patch.
>>
>> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Ah, the commit title still isn't ideal. It should be prefixed with
> "i386/kvm:" like other kvm commits are in QEMU. Likely Paolo could
> correct it while applying if v9 won't be needed.

Tested on older Intel IVB machine where virtio-gpu hostmem doesn't work
without this patch. Please add my r-b and t-b, specify your full name
"Myrsky Lintu" in the Signed-off-by of the commit msg, correct the patch
title prefix and send the v9.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # intel-ivb

-- 
Best regards,
Dmitry


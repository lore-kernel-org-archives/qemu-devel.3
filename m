Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176BACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lL0-0003la-W7; Tue, 14 Oct 2025 16:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8lKV-000391-8l
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:09:07 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8lJK-0005SZ-3f
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:09:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760472462; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tgt0d8JCs3pnbbw2LY2cD6npWv0HHHVi/WU5l3nc4y/fL7nBRSPX+VbUHEwlXwuz7z9nbWDIghdf9Nsnysh+In+BAb0KmGBjz3Cke/daZWVxTBKE3mYz7xABwiPTaMJaNbzD96u0XAl/Y4vf2gPT2SKDg12NCMwpiPNvJjxyiBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760472462;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5anPb/Aw+6cdNC6EPvJ8LSxBvrXzY9cn0vktTw0DQ14=; 
 b=E47M5xjtjSeU5cmJlwXfGNzuaUAVGL8tYnD1mOmt60QkVnECcN75J5XEo7p9ua/Ga7foBz2hiH/dgyI3E1iRg4IzhGBSK5NhtQOiBkZJRvWKR8LCZ97YpegaZHyE3MRJD6KaHkIZxlNkIQILPvA+oDgbRkXfwCsxmZ2Y8JfQWDs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760472462; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=5anPb/Aw+6cdNC6EPvJ8LSxBvrXzY9cn0vktTw0DQ14=;
 b=PDfoBeXxPAIbVoNcF8fIu3zkVEXOA8ClFmfPBkle/aSpPOoTlEgHxgzA6iAIypcD
 f+d3E5RLeOeilDOe3JkTXnVkOtgQAT0y4DVz2V/+J7pNpWUBfOy4kU8jt8zoJ0msIU9
 JIq/ajK6IreChJZ2vFp0nkr29iUsCaKyw77A53bQ=
Received: by mx.zohomail.com with SMTPS id 1760472459377868.4205858169927;
 Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
Message-ID: <c54a2b69-5af0-4319-8241-65bbae399e4c@collabora.com>
Date: Tue, 14 Oct 2025 23:07:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v8 1/1] Honor guest PAT on x86, absent Bochs display
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <176045956423.5579.13349691093596703310-1@git.sr.ht>
 <2f9abed7-2cb8-4c96-b9cd-5e8d2084b1e7@collabora.com>
Content-Language: en-US
In-Reply-To: <2f9abed7-2cb8-4c96-b9cd-5e8d2084b1e7@collabora.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/14/25 23:01, Dmitry Osipenko wrote:
> On 10/14/25 19:23, ~myrslint wrote:
>> From: myrslint <qemu.haziness801@passinbox.com>
>>
>> On x86_64, where most CPUs support self-snoop, it is preferrable to
>> always honor guest PAT. Not doing so is a quirk. There is a default
>> enabled KVM quirk flag which enforces not doing so due to a former bug
>> in Bochs display driver.
>>
>> The bug has been fixed but not enough has yet passed since so we only
>> disable said quirk flag if a Bochs display is not configured for the
>> virtual machine.
>>
>> This commit also moves around a bit of code that would be called when
>> the initialization of a VM is done.
>>
>> Signed-off-by: myrslint <qemu.haziness801@passinbox.com>
>> ---
>>  accel/kvm/kvm-all.c        |  1 +
>>  accel/stubs/kvm-stub.c     |  1 +
>>  hw/display/bochs-display.c | 17 +++++++++++++++
>>  include/system/kvm.h       |  9 ++++++++
>>  target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
>>  5 files changed, 63 insertions(+), 7 deletions(-)
> 
> Looks perfect. Now up to Paolo to review further and apply the patch.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Ah, the commit title still isn't ideal. It should be prefixed with
"i386/kvm:" like other kvm commits are in QEMU. Likely Paolo could
correct it while applying if v9 won't be needed.

-- 
Best regards,
Dmitry


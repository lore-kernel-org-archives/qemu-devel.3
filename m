Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A791C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPsM-0000cz-Od; Tue, 20 May 2025 12:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHPsL-0000cD-CI; Tue, 20 May 2025 12:31:33 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHPsJ-000333-6E; Tue, 20 May 2025 12:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747758681; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ighi0GrDBUAqt0AFr1LsP/GaNHhLtrfDTULP4aFCHeKc0CB30b16DkI/B02Gv7/th50DA/+HB6v0zwh3AIjtaVJFbRIQp9T8bfXeu5NZs3iTj4GMpx1edbWzyNqkbkq8llIYUF4CfCH8pKW5qrYIL7tp4ByrovvfIe0EyZeMwL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747758681;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Glzj8BwTcTzwAZG+ZPJqBHa8spXR7XpenQ3SSMmVMPM=; 
 b=ZRckS2jg83SJdSQIIfzuN5M88pA8Xv9ewJ+9aBUQmzskwA/ZCYkM+bNPcrPR8ZHIjGCsd9zmpUxRLKUBtkkeoRESwczVG3Z1QlYJv0xpKh4ynrQ1JNd9qglRLT6ZA5+zzESYkYx/gQIHQM94Jzx9NcF9o8EWhcBhE2wMjBjQXFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747758681; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Glzj8BwTcTzwAZG+ZPJqBHa8spXR7XpenQ3SSMmVMPM=;
 b=KktX0a1M0h8l0Df7PGsW8ln3O0OUQ2aBVQ3P7pLVPXneg1UaCZdjVXPDbtjUvDPR
 /13O4Bk7X4jNNP78T90ojSnTiL5Up36EOmAHZ1Ihu8DZQTc5bwQ0lJAeYYx6wss5cKP
 rwUeg03Eb4XUKjncA9HITPI3qeI17QRoYDWPjf8w=
Received: by mx.zohomail.com with SMTPS id 1747758678185822.6309855049358;
 Tue, 20 May 2025 09:31:18 -0700 (PDT)
Message-ID: <89adb298-602f-43c5-bc55-a3edb96fb2ac@collabora.com>
Date: Tue, 20 May 2025 19:31:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yiwei Zhang <zzyiwei@gmail.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <87iklv9tir.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87iklv9tir.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 5/20/25 18:44, Alex Bennée wrote:
> Yiwei Zhang <zzyiwei@gmail.com> writes:
> 
>> Venus and later native contexts have their own fence context along with
>> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
>> the flags must be dispatched to be created on the target context. Fence
>> signaling also has to be handled on the specific timeline within that
>> target context.
>>
>> Before this change, venus fencing is completely broken if the host
>> driver doesn't support implicit fencing with external memory objects.
>> Frames can go backwards along with random artifacts on screen if the
>> host driver doesn't attach an implicit fence to the render target. The
>> symptom could be hidden by certain guest wsi backend that waits on a
>> venus native VkFence object for the actual payload with limited present
>> modes or under special configs. e.g. x11 mailbox or xwayland.
>>
>> After this change, everything related to venus fencing starts making
>> sense. Confirmed this via guest and host side perfetto tracing.
>>
>> Changes since v1:
>> - Minor commit msg updates based on feedbacks from BALATON
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
>> Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> 
> Queued to virtio-gpu/next (in maintainer/may-2025), thanks.
> <snip>
> 

Wanted to notify you about the patch after giving it a test, but you
beat me to it. Thanks for taking the care. Tested now, Steam games work.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3097AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPt0-0000xM-5f; Tue, 20 May 2025 12:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHPsh-0000nk-0f; Tue, 20 May 2025 12:31:58 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHPsf-00036N-5Q; Tue, 20 May 2025 12:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747758705; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mRHRBeQQazfHT/H/+IHYla43P4uQWOgJyVSkTgLGkEmD/y/HOlMlY33Bq5MNVuBGDla3eR5UPyGSpLnBu3jNzTDuYbwxlfCfU3ZBHqYmwq+vviCMLrh885kC2bdh5BDMNqArBi2vUW3qHR3WGwHqd4dY0jWvt/7YQuczMjuB+7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747758705;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6BSj208Lnz/vYWUQJOHBblBgF8fbHwikGDuiOtiu2nY=; 
 b=VtPFK9P+F5bW3p8bWkeqM9TUc/ks1Aa5GndpkoqMGv47nZ9c3kMbyte/d16vf4s8JOlq6vQJ9a41Sx4vQm0Y9UhWLib0Skd0YofD6/IuCnXYnz8xE2r2m3YXzUaQjYuqGFKg34fdaupHnVNSJ+QVnCIcrgftfT0t3KlLP+0QPqk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747758705; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6BSj208Lnz/vYWUQJOHBblBgF8fbHwikGDuiOtiu2nY=;
 b=doNl+gUme2Oz7Beg6da7YIXs0bDRDm8BJdImUC1PR7HvcD79z91frjMfBtb34U+g
 y/UAT/ETaVQExudj62gAj9lSMWERWsC86dMNB+F5zGww8AVS4lB3KyuXVuevKyR3B5S
 aHX8psTxRiZoZ+au0FSkPbf4w8g8uP060aQx3Xrg=
Received: by mx.zohomail.com with SMTPS id 1747758704239967.7842365781547;
 Tue, 20 May 2025 09:31:44 -0700 (PDT)
Message-ID: <f7d09af1-fbd2-45f6-af6b-d6c02d784513@collabora.com>
Date: Tue, 20 May 2025 19:31:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <328b1fed-f23d-4ec1-ab06-c3096a76da19@collabora.com>
 <CAJ+hS_jVxV78mifbPEqvFM9Yuf3GOS+iP-yFrpLtRksGYpFLxw@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAJ+hS_jVxV78mifbPEqvFM9Yuf3GOS+iP-yFrpLtRksGYpFLxw@mail.gmail.com>
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

On 5/20/25 11:26, Yiwei Zhang wrote:
> On Mon, May 19, 2025 at 7:29 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 5/18/25 18:26, Yiwei Zhang wrote:
>>> +#if VIRGL_VERSION_MAJOR >= 1
>>> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>>> +                                      uint32_t ring_idx, uint64_t fence_id) {
>>> +    VirtIOGPU *g = opaque;
>>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
>>> +
>>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>>> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
>>
>> What if guest kernel version is very old and doesn't support ring_idx?
>> Wouldn't this write_context_fence() cb be used by vrend for signalling
>> fences without ring_idx info?
> 
> Old kernels without CONTEXT_INIT don't have the uapi to create context
> fences. So only ctx0 fences can be created, which are retired only
> with the ctx0 specific write_fence() callback. The newer
> write_context_fence() callback is dedicated to retire context fences.

All should be good then, thanks.

-- 
Best regards,
Dmitry


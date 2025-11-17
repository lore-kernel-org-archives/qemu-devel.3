Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA877CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxXJ-0001tP-O0; Mon, 17 Nov 2025 06:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxXI-0001tG-Hj
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:36:44 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxXG-0001dA-Bk
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763379377; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h/MJ8PPyLpfgg/NmiET+kK9mMjmcZiZlfPEdFz7kZL3xYZ9CaPSu/VcENqjuFSkMWuB/kN1AyqJJ+LNXJdF73pPY2RspNopfwvLAP0OYWKd1HhAFvxjFRZajv3zjbFj0nLPKKdcPtyBG51t8iaFboKomNyHsv+8KVkXL7DmX7Wk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763379377;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kQQzQBE1mfx665VnjnrOCO6dH5yq8jyVkPNmCCvB/zc=; 
 b=UDBVQAGyMUMi7757kTmxennb79qeGtiwBWbqLhvt9r0ozn6cNQSr7IigNeuPECFBIZ34BgVLHaZU8Vt0J8H+s5eqDQQyiy6aP3le/HUJA91EdQ5sMi57l2Dvci5EPsFuqBu+LV+RIMdBAtb+joeTkoeMrt2n/ZYWxe84i3TkBS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763379377; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kQQzQBE1mfx665VnjnrOCO6dH5yq8jyVkPNmCCvB/zc=;
 b=ihGac95j0t1m91ftI5qp5d3qk8XHo/tiqKSJ+XCcYJfj0euPsE+mIUwwfp16e2vk
 4rw7JJSrQn6IsbA5HObpJ9hDSft/5RcM8qlt4SESIvU2a+nz4UlYA2VKVwvImNxCGPN
 ly7+qiBsnSTD4mTV8H5YQHSIJNoFDBkw1HcfzXiM=
Received: by mx.zohomail.com with SMTPS id 1763379375608964.7270456943281;
 Mon, 17 Nov 2025 03:36:15 -0800 (PST)
Message-ID: <60ae7642-db9c-4f1d-936c-f7a4fb4ab455@collabora.com>
Date: Mon, 17 Nov 2025 14:36:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] virtio-gpu/next - misc fixes and MR handling
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <b3d94838-8484-457e-ada4-8ed3c5b38f8a@tls.msk.ru>
 <874iqtm2c5.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <874iqtm2c5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/17/25 12:32, Alex Bennée wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
>> Hi!
>>
>> 2 changes from this series has been applied to the master branch:
>>
>>  9f714c4b20 hw/display: add blob map/unmap trace events
>>  0c6d6d79a5 ui/gtk-gl-area: Remove extra draw call in refresh
>>
>> but the rest weren't.  And it looks like some are worth to be
>> considered at least.
>>
>> Alex, maybe you can refresh the series and re-send?
>> We're entering feature freeze stage with 10.2..
> 
> There were problems with the other patches leading to leaks in
> MemoryRegions. Akihiko has been looking at alternatives patches to
> re-factor MemoryRegion handling and also investigating the sub-optimal
> RCU behaviour that causes the test case (patch 8) to lock up on the
> current master.
> 
> Longer term I wonder if there is a better backend we can use that avoids
> the need for the complex blob/MemoryRegion dance we currently do between
> threads?

The MAP_FIXED feature will close MR problems [1].

[1]
https://lore.kernel.org/qemu-devel/20251116141427.2325372-3-dmitry.osipenko@collabora.com/

-- 
Best regards,
Dmitry


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D790CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwhD-0007p4-3g; Mon, 20 Oct 2025 16:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vAwh8-0007ow-QF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:41:30 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vAwh6-0005cY-Kv
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760992874; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZlUOLcnuNaUPyIKS7P72poaHiwAW5guO5D/cdOEzYtJ1fuI7YgrkA2iEej5VHHwBJvgyLg0h0fJxONfMjJG0ZjqU8FDcipALAX2ZNUTuavvhM59KHTfLZ0mHIAcrI1HkXivsiJpZcyvVdoxKM+mDpAyAA7JCNMuHICEsZ3bqaRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760992874;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1hsbfBkta5PdOTHjEnn7MftkaKKMptqLLtF5YZj8go4=; 
 b=UOYo9ezQXdg1leSQjJjsHERW0VBEbkKMTt9CaaY86+9ISoVBUmZp1cBniaWwLBrsC3MIwUsuf1gji74W09seAt06BAIu466Sqq7QNZS9jgV2zNh22xv0gmRh5ROYM7WAGp2uKPbDfQwwND/jMaTN1D+VhLh7qXuzg10ckL1ACd8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760992874; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1hsbfBkta5PdOTHjEnn7MftkaKKMptqLLtF5YZj8go4=;
 b=iznnrKmtA410sccCpaWaL3FA2VAWm7QGVS7ln8TQpYvnYf/H9BGiK3gpXR1b07Zk
 34WwY0VrT1TyzBieurJY+F5g3VCchf7GQ0vbKRkN8UpHrB4zn28c95yzPg1OU4jwwZL
 kf9LAA9dEHqeE374DY0UMKFgFL1LLskAGkTWMUGU=
Received: by mx.zohomail.com with SMTPS id 1760992871509741.2115563051279;
 Mon, 20 Oct 2025 13:41:11 -0700 (PDT)
Message-ID: <1e63ee89-66a0-4568-aeb7-b73e72fb5a2e@collabora.com>
Date: Mon, 20 Oct 2025 23:41:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
 <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
 <626016e1-c7d8-4377-bf9f-ab0f0eef1457@rsg.ci.i.u-tokyo.ac.jp>
 <f89d4a21-635a-4779-95c1-7db0abe66863@rsg.ci.i.u-tokyo.ac.jp>
 <606c8d41-7f46-41a1-817b-27cb322bd215@collabora.com>
 <1c487aba-55e6-4a59-8755-4adedfc8cc72@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1c487aba-55e6-4a59-8755-4adedfc8cc72@rsg.ci.i.u-tokyo.ac.jp>
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

On 10/20/25 04:14, Akihiko Odaki wrote:
...
>>> So, if you know some workload that may suffer from the delay, it may be
>>> a good idea to try them with the patches from Alex first, and then think
>>> of a clean solution if it improves performance.
>>
>> Thanks a lot for the clarification. I'm seeing occasional 10ms stalls
>> with this patch applied, still it's a huge improvement. Looking forward
>> to v2.
> 
> Just for (further) clarification, but 10ms stalls are present even
> without this patch (correct me if I'm wrong). I think the stalls need to
> be resolved with another patch instead of having v2 of this unless it is
> a regression.

Stalls present without this patch and they are much worse than with your
patch. Without your patch - unmaping stalls for 50-100ms, with your
patch - unmapping stalls for 2-20ms.

There are no stalls at all with patches from Alex, unmapping finishes
instantly and performance is ideal.

>> In addition to a guest waiting for the virgl commands completion, QEMU
>> display updates on host are also blocked while unmapping cmd is
>> suspended. This is a noticeable problem for interactive GFX applications
>> running on guest.
> 
> I guess you meant that the scanout commands following unmapping commands
> are blocked. While I can imagine that can cause frames skipped and
> damage user experience, it is nice if you know reproduction cases or
> affected workloads and share them with me.

Correct, scanout commands are blocked.

Running pretty much any VK application with venus reproduces the
problem. A simple reproduction case is to run vkmark with venus, it
would noticeably stall between switching benchmark modes and when app quits.

With native contexts the problem is much more visible. Running any
Desktop Environment (KDE Plasma in my case) on guest with amd/intel nctx
would be freezing badly by moving application window around desktop.

-- 
Best regards,
Dmitry


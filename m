Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFB6CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 06:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHFfa-000719-JC; Fri, 07 Nov 2025 01:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHFfT-000704-EH
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:09:53 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHFfP-0000vB-Vw
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:09:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 96914C023F;
 Fri, 07 Nov 2025 09:09:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d76::1:1a] (unknown
 [2a02:6bf:8080:d76::1:1a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id f9gGqQ0Fk0U0-6ixbyXfZ; Fri, 07 Nov 2025 09:09:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762495783;
 bh=jRHGErk2xmWVcRmA++0IUP/3D2ciQ1tlzHzU0Ahq9V4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g2yWfTgBvLxAxC5urr4UkecNKwguINAnHYDiQ7PO/O+17T2m2N2rNL/Kd7XqR4bgB
 r3zAUQOkfMh5Z+7kl+jXE/gxFOEBJqZZsPj+BmC+iMM+vnlm/Oyvm1nQzVY/OCBvUm
 gCMqlec9k/Ld95ok546Hgtc/hHAdvKigvQYTVqg0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <abbeb31e-9f16-4770-81b3-f0c172e930d8@yandex-team.ru>
Date: Fri, 7 Nov 2025 09:09:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] qapi: introduce query-backend-transfer-support
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, thuth@redhat.com, philmd@linaro.org,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
 <20251030203116.870742-3-vsementsov@yandex-team.ru>
 <87jz03fab2.fsf@pond.sub.org>
 <75cd160f-2f70-4522-aaa0-6e8a2a3b7c01@yandex-team.ru>
 <87cy5ue7hv.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87cy5ue7hv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 07.11.25 08:28, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 06.11.25 18:30, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> We are going to implement backend-transfer feature: some devices
>>>> will be able to transfer their backend through migration stream
>>>> for local migration through UNIX domain socket. For example,
>>>> virtio-net will migrate its attached TAP netdev, with all its
>>>> connected file descriptors.
>>>>
>>>> Let's add a command to list supporting devices (no one for now),
>>>> together with necessary infrastructure in qdev code.
>>>
>>> Use case?
>>
>> Will add:
>>
>> With this command management tool can query such lists on source and
>> target, and get intersection of them, to now the set of devices, for
>> which we can enable backend-transfer for given source and target QEMUs.
> 
> I like it.  Would it make sense to add something similar to QAPI schema
> doc comments?
> 

Agree, will do.

-- 
Best regards,
Vladimir


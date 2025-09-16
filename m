Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B85CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWWP-0003e3-Q1; Tue, 16 Sep 2025 10:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyWWE-0003bn-3f; Tue, 16 Sep 2025 10:18:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyWWA-0007bf-Mn; Tue, 16 Sep 2025 10:18:52 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9987F809E1;
 Tue, 16 Sep 2025 17:18:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16c::1:b] (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fIR0wZ2GhuQ0-kcG4Qhq8; Tue, 16 Sep 2025 17:18:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758032323;
 bh=DVPDpQUvUjvulC9m3MYG7SulMPbHD6xvJxutJPlQfn0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1BoMgwCBlbbgoSPBcF8j+LjcsAjekZIb4wHWwVaN0tmeAaJvu5zkBM8C6LFfDU0vU
 oAXCjKgRX0blAPRf7oz8osCIKOLq2miVeP6w5IsPxzIIMqE5FoZwP9JrmjIim9OKYB
 ZUGvfXQ84nrNaC+JFwrEA2/xGF1QIdh0qVi8YlHE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e90ec57a-cf96-4318-b7f6-611725522994@yandex-team.ru>
Date: Tue, 16 Sep 2025 17:18:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] handle result of qio_channel_set_blocking()
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, John Levon
 <john.levon@nutanix.com>, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-5-vsementsov@yandex-team.ru>
 <aMls1F7VyCzE9-jg@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMls1F7VyCzE9-jg@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16.09.25 16:57, Peter Xu wrote:
> On Tue, Sep 16, 2025 at 04:13:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Currently, we just always pass NULL as errp argument. That doesn't
>> look good.
>>
>> Some realizations of interface may actually report errors.
>> Channel-socket realization actually either ignore or crash on
>> errors, but we are going to straighten it out to always reporting
>> an errp in further commits.
>>
>> So, convert all callers to either handle the error (where environment
>> allows) or explicitly use &error_abort.
>>
>> Take also a chance to change the return value to more convenient
>> bool (keeping also in mind, that underlying realizations may
>> return -1 on failure, not -errno).
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   block/nbd.c                      |  4 +++-
>>   chardev/char-socket.c            | 20 ++++++++++++++++----
>>   hw/remote/proxy.c                |  6 +++++-
>>   hw/remote/remote-obj.c           |  6 +++++-
>>   hw/vfio-user/proxy.c             | 11 ++++++++---
>>   include/io/channel.h             |  6 +++---
>>   io/channel.c                     |  4 ++--
>>   nbd/server.c                     |  4 +++-
>>   scsi/qemu-pr-helper.c            |  9 ++++++---
>>   tests/unit/io-channel-helpers.c  |  5 +++--
>>   tests/unit/test-io-channel-tls.c |  4 ++--
>>   tools/i386/qemu-vmsr-helper.c    |  6 ++++--
>>   ui/vnc.c                         |  2 +-
>>   util/vhost-user-server.c         |  7 ++++++-
>>   14 files changed, 67 insertions(+), 27 deletions(-)
> 
> No need to repost, but just to mention (if possible to be touched up when
> Dan queues this..).. it's still good to always have a prefix for subject.
> 
> IMHO we can use "treewide:"; qemu started using it in a few commits.  Linux
> kernel used it much more.  We can keep the trend, IMHO.
> 

Agree, sounds good.

-- 
Best regards,
Vladimir


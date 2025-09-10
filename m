Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229CCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 10:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwI8D-000125-Mf; Wed, 10 Sep 2025 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI84-00010Y-1y; Wed, 10 Sep 2025 06:32:46 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI81-0006aZ-0D; Wed, 10 Sep 2025 06:32:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6ADAB8078B;
 Wed, 10 Sep 2025 13:32:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZWH3Gq2GiW20-WgsOAxGe; Wed, 10 Sep 2025 13:32:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757500355;
 bh=521L2mU2XckcX7CCkyUZri51auG61brCAzhblCRmsQQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=csd1H3Ic6dJ1Ns95lWQ6TY6J90XtUBeO/NYJD9vx/ClpxRwB7hBmL75prloIwILQl
 aj/UzKMyNvq5KNEErMudLHkQjGqbg7qsqc1LqEP8BvMrUveLTTuY/+y69Bm+Lozi7o
 n0C62QRB6NrX4ldT2uwPax6PnB4i4yKM0c/YK2KA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b40dfde9-d6c4-49b5-be11-5ad50cce1ce0@yandex-team.ru>
Date: Wed, 10 Sep 2025 13:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aL9Vuohpnyn8IcsI@x1.local>
 <f7ca50b0-b20d-451e-addb-693772239b34@yandex-team.ru>
 <aMFHvN3MDneJ59C9@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMFHvN3MDneJ59C9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 10.09.25 12:41, Daniel P. Berrangé wrote:
> On Tue, Sep 09, 2025 at 11:19:39AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 09.09.25 01:16, Peter Xu wrote:
>>> On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Use common qemu_set_blocking() instead.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>
>>> Posix's qemu_socket_set_nonblock() asserts the retval.. While Windows's one
>>> doesn't.  IIUC that's the only reason you provided the generic error
>>> path in all callers, just in case some of them might fail on Windows?
>>
>> Honestly, I thought that checking error on Linux is good too.. It may fail,
>> why not to check, where possible?
> 
> Yep, it diagnoses the case where the FD might be invalid, or where
> QEMU might not have access to it. This could potentially avoid killing
> the VM if a FD was passed to QEMU over monitor that had access limited
> by SELinux.
> 

Good reason! I'll add it commit msg.

-- 
Best regards,
Vladimir


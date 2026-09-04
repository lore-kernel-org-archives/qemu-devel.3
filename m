Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD382C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2b27-00068o-27; Fri, 04 Sep 2026 17:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2b25-00068G-5d; Fri, 04 Sep 2026 17:01:09 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2b23-0008RE-Ek; Fri, 04 Sep 2026 17:01:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:118b:0:640:b49:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D7013C09F5;
 Sat, 05 Sep 2026 00:01:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:4d::1:17] (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 21RrxW4e9uQ0-eTAM10N8; Sat, 05 Sep 2026 00:01:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555663;
 bh=9LLmBXuzPfadkbMn/iVbRs7jJBRiWcGMNXcB39Murvc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Nc7p/Hxp7OxLSNmo1vIBsBHcO9QgTXpyJAeU8z0oP0rBVqV4TtQAUuzeQqNArL9Zq
 U9C5cFZZdKdYKOcHUH5KDfnIuuQV2pCAtcmzA8C+chMiUhUIy8axZ6ZAWLefPG8Xkq
 brkK85Aq43IlTbapOH0ifQRfAdqmgxL9rNljIKyI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <426b5a8f-8259-4e5a-8e84-95a610f71986@yandex-team.ru>
Date: Sat, 5 Sep 2026 00:01:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/30] hw/virtio: config save/load: move to new migration
 APIs
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "open list:virtio-ccw" <qemu-s390x@nongnu.org>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
 <20260825213811.3725682-5-vsementsov@yandex-team.ru> <87h5k68c77.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87h5k68c77.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03.09.26 20:41, Fabiano Rosas wrote:
>>   }
>>   
>> -static int virtio_pci_load_config(DeviceState *d, QEMUFile *f)
>> +static bool virtio_pci_load_config(DeviceState *d, QEMUFile *f, Error **errp)
>>   {
> This function is returning 0


Oops right, thanks! Will fix.


-- 
Best regards,
Vladimir


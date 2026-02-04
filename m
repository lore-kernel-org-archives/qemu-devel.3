Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF02E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXlA-0000UK-Qd; Wed, 04 Feb 2026 02:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXl6-0000U0-OE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:57:08 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnXl4-0005wZ-6f
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:57:08 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2B04BC0159;
 Wed, 04 Feb 2026 10:57:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wuj93g0ApuQ0-DIsXOI5h; Wed, 04 Feb 2026 10:57:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770191820;
 bh=RUKk/3YCZMOsMCmAm+b3T3Y8DIvxeg9MenW7EiWcOEY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dW/YSmM9yRgUE2cdLyNC+pCBWUaHjeCfVaNfvy5Mto0iUttolKFk4mrB9GZLHQk5J
 5sJTCm5ceBDrO1SDBq5+BGdrpXT5XIYM1naWmieuksvSz3WXxCKv5fskaxCjXizyh3
 yCZ7voacU3zpIElA5ddT7iMtgT5Q700exC/v/PBs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0296eb32-4a67-4f46-bc5c-e4d5f1fa642d@yandex-team.ru>
Date: Wed, 4 Feb 2026 10:56:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
To: Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>
Cc: "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local> <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
 <aYJJ17xU2iQmk5sQ@x1.local> <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
 <58d40cb1-a5fc-4dce-b843-2b08b79c477a@oracle.com> <aYJe6mPCR_XLVX8p@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aYJe6mPCR_XLVX8p@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 03.02.26 23:47, Peter Xu wrote:
> On Tue, Feb 03, 2026 at 02:04:21PM -0600, Mark Kanda wrote:
>> On 2/3/26 1:46 PM, Chaney, Ben wrote:
>>>> Well explained, thank you Vladimir. I wish some day we can move all at
>>>> least cpr-transfer users to local-migration and deprecate CPR if ever
>>>> possible. The uncertainty to me is cpr-exec, but I really don't know how
>>>> much mgmt is adopting cpr-exec.. cpr-reboot also looks pretty special and
>>>> may not be relevant.
>>>> The core idea (originated from Steve..) is really about fd sharing, and
>>>> it's great if we can do it in a cleaner way.
>>> Thanks for the clarification. If that is the case then probably Vladimir's
>>> solution is preferable. I sent some comments on the prerequisite
>>> refactoring patch set. I'll try to review the main set soon.
>>>
>>>> My understanding is there're some special mgmt (Oracle's?) that may depend
>>>> on cpr-exec; I'm not sure how far that went in any downstream deployment.
>>> That should be able to reuse mgmt channels too (relevant to chardev fd
>>> sharing, perhaps?) instead of requiring e.g. all monitor ports to reconnect
>>> to a new QEMU after migration. Said that, I always assumed re-connect is
>>> fine, and most mgmt supports live migration so the mgmt should have that
>>> infrastructure there already. Maybe Ben would know better.
>>>
>>> I'm missing a lot of context here as I only became more involved in this project
>>> recently. @Mark Kanda Can you provide any context about Steve's work before
>>> he retired, or Oracle's usage of these features?
>>
>> We (Oracle) have an internal VM manager which relies on cpr-exec, and would
>> like to continue supporting it.
> 
> IIUC that means QEMU upstream needs to start merging two solutions for not
> only migration but also vhost, and maybe more in the future.  Or we reject
> Vladimir's work, but frankly I think that's indeed superior and less hacky
> when without the need of the 2nd channel.
> 
> Can we try to reduce the duplicated logics between the two solutions?
> 
> For example, is it possible to rebase this series on top of Vladimir's
> work, reusing logics as much as possible so that those FDs can also be
> preserved via execve() and reused in the after-exec world (likely reused
> not during fd open, but instead loadvm)?
> 

I think, rebasing is not necessary, as local-fd migration (this series)
should work together with CPR, and even with CPR-exec. So Oracle can use cpr-exec,
and simply enable backend-transfer for virtio-net/tap, and it should work, I
remember we discussed this with Steve. I didn't yet tested it, but I'll try to
add a test for such setup.

-- 
Best regards,
Vladimir


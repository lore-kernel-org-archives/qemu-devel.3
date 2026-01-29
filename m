Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63348D61018
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSXt-0004jo-Ew; Thu, 29 Jan 2026 08:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlSXr-0004iM-Op
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:58:51 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlSXp-0001XL-7z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:58:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:329e:0:640:3532:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9DA8B80818;
 Thu, 29 Jan 2026 16:58:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b74::1:d] (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fwja7m2AtKo0-XirU8v9P; Thu, 29 Jan 2026 16:58:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769695122;
 bh=SmeG2TYCmYOb8XauwOJoKmg/BtLPW4X3epitBh8xWMM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vn4oGW6gJKVIaTgfWkMf10PSR7P+u8KOcgaTIHpTurDlOrSo++YaLE1a6l1qhTNfv
 xBNFuztt3jqtsko4JIAYxKIbuVEYxihmMaIqga7fnzW3PqguvTBByhYM/IBbJZV307
 1RW5XPPcq8+j6j41I+0Q6SFQGl4KCpDx8+6lKve4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
Date: Thu, 29 Jan 2026 16:58:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28.01.26 23:39, Ben Chaney wrote:
> Tap and vhost devices can be preserved during cpr-transfer using
> traditional live migration methods, wherein the management layer
> creates new interfaces for the target and fiddles with 'ip link'
> to deactivate the old interface and activate the new.
> 
> However, CPR can simply send the file descriptors to new QEMU,
> with no special management actions required.  The user enables
> this behavior by specifing '-netdev tap,cpr=on'.  The default
> is cpr=off.
> 
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
Hi!

I'd like to note again, that I'mvworking on an alternative solution for live-updating
virtio-net+TAP, passing FDs through unix domain socket, which:

1. Doesn't require second migration channel
2. Doesn't use CPR: the whole TAP state, including negotiated parameters
and opened FD are natively passed as usual migration state structure.
(look here: https://lore.kernel.org/qemu-devel/20251030203116.870742-7-vsementsov@yandex-team.ru/ )
3. Still should be compatible with CPR, and may be used in context of CPR-update

The latest version was

[PATCH v9 0/8] virtio-net: live-TAP local migration
https://lore.kernel.org/qemu-devel/20251030203116.870742-1-vsementsov@yandex-team.ru/

and I plan to post v10 soon.


-- 
Best regards,
Vladimir


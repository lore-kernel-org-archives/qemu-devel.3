Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF2BD1F9DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR8pX-0000ae-Ck; Thu, 04 Dec 2025 07:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR8pW-0000aW-GW
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:53:06 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR8pU-0005D3-1i
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:53:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8165CC01FA;
 Thu, 04 Dec 2025 15:52:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:856::1:37] (unknown
 [2a02:6bf:8080:856::1:37])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vqkXMP0F8uQ0-6c90d0Hb; Thu, 04 Dec 2025 15:52:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764852778;
 bh=cdCEijvtsfMUZBUVWtQJ3yNRXC/ut+O2t+VLDr3MNxE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=C5Ix3BGNMCAStwPxYMjfmklS4oAtV/QSbauw8yiA2N2l69ONAK4WiEaVX8M/tX9HT
 PnaaYr8OB+5tCP6Q9TSDMMi3ICO5FYQ57UqELAUMjr2GI000WTSeAFLRbfRe6NAlsL
 cr7rPRF6OIWKOJ1ka98ie4PkeBC6r3X3XTLbK4Ks=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a782e506-8e23-49dd-b8d2-d27409c99d5a@yandex-team.ru>
Date: Thu, 4 Dec 2025 15:52:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
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
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
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

On 03.12.25 21:51, Ben Chaney wrote:
> Changes since v2
> - I have taken over this patch set since Steve retired
> - Added comments to explain the order of events
> - Remove redundant reversion to cleanup git history
> - Inclusion of virtio and stub fixes
> 
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
> Signed-off-by: Ben Chaney<bchaney@akamai.com>


Hi!

Hmm, note that I have alternative in-flight series,

[PATCH v9 0/8] virtio-net: live-TAP local migration
https://patchew.org/QEMU/20251030203116.870742-1-vsementsov@yandex-team.ru/

, which bring same thing: migrate TAP device, passing FDs
though migration channel. The benefit is that it doesn't
require additional migration channel.

So, it may be used as part of CPR-migration, or with
usual migration without CPR.

-- 
Best regards,
Vladimir


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB1CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 10:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uypAF-0007j3-OW; Wed, 17 Sep 2025 06:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uypAB-0007i1-TE; Wed, 17 Sep 2025 06:13:23 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uypA9-0002rv-Ew; Wed, 17 Sep 2025 06:13:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E2E728062F;
 Wed, 17 Sep 2025 13:13:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b2a::1:6] (unknown [2a02:6bf:8080:b2a::1:6])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FDONDH0FpeA0-7VsqWdbc; Wed, 17 Sep 2025 13:13:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758103995;
 bh=JxQcXc6mP+YnbJxWzxhNF51ObZBVDrdWt80DfbXrnGg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=odOFeHDY4CsVHCm2ggxeTAE2g9KYQZhAjfLy+dyYPkhR4AS/Xh6iJyNFTBQkQTrzj
 lLg14WhipYxUcaAxBC11zrHGH2o24ajNq1dtHmdIQRnzJRBzbvWYIqDy3ETstjk8oE
 TL6fW3pvNVc7ZGSXDWcWQp1hwAmbLFaMO3+Y+12k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ea5f1352-e1f8-409e-a0cb-9568585628f1@yandex-team.ru>
Date: Wed, 17 Sep 2025 13:13:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] util/vhost-user-server: vu_message_read():
 improve error handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-14-vsementsov@yandex-team.ru>
 <aMmHUW5nqZf1RxTb@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMmHUW5nqZf1RxTb@redhat.com>
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

On 16.09.25 18:50, Daniel P. Berrangé wrote:
> On Tue, Sep 16, 2025 at 04:14:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 1. Drop extra error_report_err(NULL), it will just crash, if we get
>> here.
>>
>> 2. Get and report error of qemu_set_blocking(), instead of aborting.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   util/vhost-user-server.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 

Thanks a lot!

Now the whole series is reviewed. Will you queue it
(together with base "[PATCH v4 0/2] save qemu-file incoming non-blocking fds")?
Or we should wait for ACCs from other maintainers?

-- 
Best regards,
Vladimir


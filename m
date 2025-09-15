Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C91CAC58F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4Ho-0006IR-7P; Mon, 15 Sep 2025 04:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy4Hi-00066Y-TW; Mon, 15 Sep 2025 04:10:02 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy4Hb-0006mH-MF; Mon, 15 Sep 2025 04:10:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6649080947;
 Mon, 15 Sep 2025 11:09:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c82::1:39] (unknown
 [2a02:6bf:8080:c82::1:39])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i9KKfb1Foa60-8BstVPnL; Mon, 15 Sep 2025 11:09:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757923785;
 bh=tSbpN5xdWJQmJonxjfH8bEiZY8z9re4w+wCtvxyN6BI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cssX97My7bBz8aoqf4l+oOAB+IaykKQ/E7JjH+rHR26LutyWYnAfaMk01/fuv9Hph
 drg95kgHzWt87UrcUF1OIFjm55g1o0FWCgfYvKY3q0q4spJTaTkoJUKpFYb4tp9eQe
 kY/L2eyfAe7rp67j8onAgIItR7Gnreo0C2rfb5q0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2c934770-4296-4065-a8ef-13cc9bbb3359@yandex-team.ru>
Date: Mon, 15 Sep 2025 11:09:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-5-vsementsov@yandex-team.ru>
 <aMRRYhbRAnTu4Sew@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMRRYhbRAnTu4Sew@redhat.com>
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

On 12.09.25 19:59, Daniel P. Berrangé wrote:
> On Thu, Sep 11, 2025 at 12:20:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use common qemu_set_blocking() instead.
>>
>> Note that pre-patch the behavior of Win32 and Linux realizations
>> are inconsistent: we ignore failure for Win32, and assert success
>> for Linux.
>>
>> How do we convert the callers?
>> 3. io/channel-socket.c: here we convert both old calls to
>> qemu_socket_set_nonblock() and qemu_socket_set_block() to
>> one new call. Pre-patch we assert success for Linux in
>> qemu_socket_set_nonblock(), and ignore all other errors here.
>> Still, all callers pass errp=NULL to qio_channel_set_blocking(),
>> so after patch we ignore all errors. Switching from assertion
>> to ignoring may be not very good, but still acceptable, keeping
>> in mind that all callers of qio_channel_set_blocking() do
>> explicitly ignore the error.
> This is a bit questionable. IMHO the reason why nearly all
> callers pass errp=NULL is laziness based on the assumption
> that the code actually asserts, and no one thinking to check
> the win impl which didn't asset.
> 
> IOW, I think we need a prior patch that sets the 'errp'
> in all these callers, either to &error_abort, or to
> propage the error if practical.


To be honest, I thought about it. I'll try.


-- 
Best regards,
Vladimir


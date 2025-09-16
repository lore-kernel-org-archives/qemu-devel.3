Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EA3CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVLT-0008Iv-I0; Tue, 16 Sep 2025 09:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVKb-00087S-7A; Tue, 16 Sep 2025 09:03:00 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVKM-0004vf-0A; Tue, 16 Sep 2025 09:02:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C223DC0248;
 Tue, 16 Sep 2025 16:01:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16c::1:b] (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id v1Q66e2GwiE0-ujRnf0oA; Tue, 16 Sep 2025 16:01:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758027718;
 bh=PQmA+IBCKOpgqYsptO9TldjdWC98c3cc8wqis7M6PXw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BJum3zVSfAwcHZa3W3yOsCdthpC1o4wFoAPQ5NHuaRMqpU+f9Gtuhp7CGOR8skQmT
 HmunLHOZ2dWXtZxSbEp+TYUmnSDy/MPtj0INXw2hrS2mLFALqkNg8D49vYH5hRiDV5
 JtSJLUPdI1GTyzq7EZVatL20KX1xZeKy2R049azU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7f6b159e-6d97-4b0e-a825-7b8042c27e99@yandex-team.ru>
Date: Tue, 16 Sep 2025 16:01:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, leiyang@redhat.com,
 marcandre.lureau@redhat.com, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-6-vsementsov@yandex-team.ru>
 <aMh0sjXkQ9IYo_SB@x1.local> <aMkfn2_GBUDlUB6O@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMkfn2_GBUDlUB6O@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 16.09.25 11:28, Daniel P. Berrangé wrote:
> On Mon, Sep 15, 2025 at 04:18:58PM -0400, Peter Xu wrote:
>> On Mon, Sep 15, 2025 at 10:30:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
>>> so let's passthrough the errp.
>> This looks all reasonable in general.
>>
>> Said that, using error_abort in migration code normally are not suggested
>> because it's too strong.
> Note, that prior to this series, the existing qemu_socket_set_nonblock
> method that migration is calling will assert on failure. This series
> removes that assert and propagates it back to the callers to let them
> decide what to do. Ideally they would gracefully handle it, but if
> they assert that is no worse than current behaviour.
> 

In details, prior to series:

posix + set_nonblock -> crash on failure

other variants (posix/win32 + set_block, win32 + set_nonblock) -> ignore failure

>> I did check all of below should be on the incoming side which is not as
>> severe (because killing dest qemu before switchover is normally
>> benign). Still, can we switch all below users to error_warn (including the
>> one below that may want to error_report_err(), IMHO a warn report is fine
>> even for such error)?
> IMHO ignoring a failure to change the blocking flag status is not
> a warnnig, it is unrecoverable for the migration operation. It
> should be possible to propagate the error in some way, but it will
> potentially require changes across multiple migration methods to
> handle this.


-- 
Best regards,
Vladimir


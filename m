Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C0FC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8TY-0004qM-3e; Fri, 14 Mar 2025 13:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8TH-0004ip-K9; Fri, 14 Mar 2025 13:05:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8TA-0004XU-QS; Fri, 14 Mar 2025 13:05:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1d:6351:0:640:b430:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id ED9BC60B32;
 Fri, 14 Mar 2025 20:05:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a420::1:c] (unknown
 [2a02:6b8:b081:a420::1:c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id N3IUaS4FbCg0-qBMfzAZl; Fri, 14 Mar 2025 20:05:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1741971902;
 bh=FSiOEadAWdmSWz55lQhJjwqbiOq56nlLP3HsmGKJMbs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=i/IOK5l/WwQ6yy5IEV0ra+AUxlWjlLAPuntTcij53mPyLWR1+wxkxRxrq7FaGCvEc
 8ZvIsRD94/iSTrFjVWr2DsJT608BU9xswFKAsUuFguSeCznvTgPgjqqaRTsZnlU8ML
 R/W3wuQzTOBmZb6J8zD4B8OWfRE5wmnEtQ6O174g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3806d9f0-c689-47fa-a0cb-37b9c33685b2@yandex-team.ru>
Date: Fri, 14 Mar 2025 20:03:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.03.25 12:17, Raman Dzehtsiar wrote:
> This patch extends the blockdev-backup QMP command to allow users to specify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the user.
> 
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>    the on-source-error policy. This preserves snapshot integrity at the
>    expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>    but invalidates the snapshot and aborts related jobs. This prioritizes
>    guest operation over backup consistency.
> 
> This enhancement provides more flexibility for backup operations in different
> environments where requirements for guest availability versus backup
> consistency may vary.
> 
> The default behavior remains unchanged to maintain backward compatibility.
> 
> Signed-off-by: Raman Dzehtsiar<Raman.Dzehtsiar@gmail.com>


Hi Raman, sorry for a delay!

The patch looks good to me. Still, could you also provide a test for a new option?

Probably the simplest would be add a test-case to `tests/qemu-iotests/tests/copy-before-write`, where existing on-cbw-error option is tested. Or you can make a separate test.

-- 
Best regards,
Vladimir



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21207C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE5u-0000XH-4I; Wed, 12 Feb 2025 09:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiE5q-0000X3-B7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:52:02 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiE5e-0002bI-Ls
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:51:52 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 20B8E60C58;
 Wed, 12 Feb 2025 17:51:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:2f] (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hpQFa90IjOs0-PBG9hxpr; Wed, 12 Feb 2025 17:51:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739371904;
 bh=jbSl7Qci8wAjArxl5pTAz2oWreE0LP1quw7XfOVvs4o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jB6Arfz4kAZj+ZqoBhN8l3u22qXsyypivkGg0eJ9NoPJLqccvToPjK27HwJAd/Ai+
 HCQeRnM5ZqHXmSbhy2RFYbwXS4oGK+d8iFyQEz13C2p6PJ57olmICjzrrF+nVN/9Cq
 /sYdokhz/+yCez/H6cyVV/ODQ1WTstdBN7uJ6AEs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <be37d63c-b1c3-4c76-8113-0bad556aef37@yandex-team.ru>
Date: Wed, 12 Feb 2025 17:51:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <8099a911-88a1-4eed-a17c-5a18e25b4d68@linaro.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <8099a911-88a1-4eed-a17c-5a18e25b4d68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/12/25 5:48 PM, Philippe Mathieu-Daudé wrote:

> Hi Daniil,
>
> On 12/2/25 15:39, Daniil Tatianin wrote:
>> This will be used in the following commits to make it possible to only
>> lock memory on fault instead of right away.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   include/system/os-posix.h |  2 +-
>>   include/system/os-win32.h |  3 ++-
>>   meson.build               |  6 ++++++
>>   migration/postcopy-ram.c  |  2 +-
>>   os-posix.c                | 14 ++++++++++++--
>>   system/vl.c               |  2 +-
>>   6 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
>> index b881ac6c6f..ce5b3bccf8 100644
>> --- a/include/system/os-posix.h
>> +++ b/include/system/os-posix.h
>> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>>   void os_set_chroot(const char *path);
>>   void os_setup_limits(void);
>>   void os_setup_post(void);
>> -int os_mlock(void);
>> +int os_mlock(bool on_fault);
>
> If we need to support more flag, is your plan to add more arguments?
> Otherwise, why not use a 'int flags' argument, and have the callers
> pass MCL_ONFAULT?

Hi!

I chose this approach because MCL_ONFAULT is a POSIX/linux-specific 
flag, and this function is called in places that are platform-agnostic, 
thus a bool flag seemed more fitting.




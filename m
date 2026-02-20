Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4863DC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 07:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtLNm-0002h1-5F; Fri, 20 Feb 2026 02:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtLNk-0002gm-I6
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 02:57:00 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtLNh-0008A7-Sk
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 02:57:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 800EF804EB;
 Fri, 20 Feb 2026 10:56:52 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:449::1:8] (unknown [2a02:6bf:8080:449::1:8])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nuWOqj4A1qM0-F8ch0rQg; Fri, 20 Feb 2026 10:56:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771574211;
 bh=tBeTsaAVDUBIhZZCOW5uK6CfhX8uDdqXNqQgj4CS8xQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LaEWOgI6OY4MnGuAbE/p1pQHnMCxPcj5hBrfrEbTWuTqaJrphyO3BzS2GZakkt6F1
 0p/nZ4lv4CJLFi/jB+hTcKL0p3/Pqf7OOd4+Nssde+8YHD+aWfMnveZtCZu5qXLolE
 07Qsane+aftmyRFZm2QGj1jWSg3iEa7cTQndBIV8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b9957bbd-d673-4232-96e9-d13663033f62@yandex-team.ru>
Date: Fri, 20 Feb 2026 10:56:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/8] qapi: add local migration parameter
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 eblake@redhat.com, farosas@suse.de, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-4-vsementsov@yandex-team.ru>
 <aZeEBqiocvOeutDn@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aZeEBqiocvOeutDn@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 20.02.26 00:43, Peter Xu wrote:
> On Thu, Feb 19, 2026 at 02:55:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to implement local-migration feature: some devices will be
>> able to transfer open file descriptors through migration stream (which
>> must UNIX domain socket for that purpose).  This allows to transfer the
>> whole backend state without reconnecting and restarting the backend
>> service. For example, virtio-net will migrate its attached TAP netdev,
>> together with its connected file descriptors.
>>
>> In this commit we introduce a migration parameter, which enables
>> the feature for supporting devices (no one at the moment).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> PS: one nitpick is maybe we don't need to spell out the per-device option
> in the doc of "local", it also doesn't need to be called "local-migration"
> on every device if it will be presnet.. no strong feelings.
> 

I thought about it.. But couldn't come up with a more generic phrase.
And I think it's bad to omit the fact that the parameter doesn't
automatically enable the feature without some flag on device side.

+#     channel.  Individual devices declare the support for local
+#     migration by per-device local-migration option.  (Since 11.0)

Hmm. After merging at least virtio-net/TAP migration we can write:

     In general devices may have an option (like local-migration
     for virtio-net) which in conjunction with "local" set to true
     enables the local-migration feature for that device.

And to be prepared for it now:

     In general devices may have an option which in conjunction with
     "local" set to true enables the local-migration feature for that
     device.

-- 
Best regards,
Vladimir


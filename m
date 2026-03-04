Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DC7EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsU1-0004rf-Gu; Wed, 04 Mar 2026 15:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxsTz-0004qz-7j; Wed, 04 Mar 2026 15:06:11 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxsTw-0004zz-Nb; Wed, 04 Mar 2026 15:06:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C3AF1C01EB;
 Wed, 04 Mar 2026 23:06:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 16vEI80AwSw0-Vi8bbw5A; Wed, 04 Mar 2026 23:06:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772654762;
 bh=jLgsfj45HADlNh8UieUztU2dXalE8l6iBEBiHI/M7Tg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aULtly2DZaz25cRE6Z4EpN0/Co7WbXcQmegNMODsSLykgqWsCjd69HPlUluTgyGag
 70nhkDYOhuRoc3mTKA358z/Ej0fXx6OPIlMvALHYOk4uNBWjTVR3zyEfFI2Twfai6Y
 rjq3hSJNV9rxGXiQQocDOYeeowWvWCL6HPnPRQsQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <23c33857-65a8-4f4b-b933-f7e2e86f7ab2@yandex-team.ru>
Date: Wed, 4 Mar 2026 23:06:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, alifm@linux.ibm.com,
 "open list:virtio-ccw" <qemu-s390x@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
 <aacS1YUD0xesMufw@x1.local>
 <842c669b-21f0-4a17-bf4f-f2723f0e5466@yandex-team.ru>
 <aaiGCalvQNX3WQxl@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aaiGCalvQNX3WQxl@x1.local>
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

[add s390 channel maintainers]

On 04.03.26 22:20, Peter Xu wrote:
> On Wed, Mar 04, 2026 at 10:15:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> The only problem is that we don't have error_append() function)
> 
> I definitely wanted to type error_prepend() when replying... :(
> 
> I think it might be better when putting upfront / prepend, say, the
> original error should look like this, which is weird to me:
> 
>    "XXX != YYY NAME"
> 
> (maybe even no space???)
> 
> With append (when doing that, we may also want to add a comma and some "0x"
> prefix?), it can be:
> 
>    "NAME: XXX != YYY"
> 


Hmm. I'm now trying to find, where this .err_hint is set to not-NULL.. Don't see...

O, I see them:

in hw/s390x/css.c

const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
     " Likely reason: some sequences of plug and unplug  can break"
     " migration for machine versions prior to  2.7 (known design flaw).";

const VMStateDescription vmstate_subch_dev = {
     .name = "s390_subch_dev",
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = subch_dev_post_load,
     .pre_save = subch_dev_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),   <<<<<<<<<
         VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),    <<<<<<<<<
         VMSTATE_UINT16(migrated_schid, SubchDev),
         VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),   <<<<<<<<



"Bug" hints are obviously useless.

About err_hint_devno.. Doesn't seem a good reason to have this .err_hint
field and the whole logic, including extra parameter to several vmstate
macros through the whole code base. And at least mention about 2.7 looks
not relevant today.

I'd replace definition of err_hint_devno by a comment, and drop the whole
.err_hint feature.

What do you think?


-- 
Best regards,
Vladimir


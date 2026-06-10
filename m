Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A246CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEIT-0002DG-DR; Wed, 10 Jun 2026 04:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wXEIR-0002Ck-Fv; Wed, 10 Jun 2026 04:28:23 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wXEIN-0003Xf-8F; Wed, 10 Jun 2026 04:28:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BCFC380B4A;
 Wed, 10 Jun 2026 11:28:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:56d::1:36] (unknown
 [2a02:6bf:8080:56d::1:36])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id CSF5UM4X7Os0-uA9xAuJS; Wed, 10 Jun 2026 11:28:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1781080093;
 bh=JxE9W4c1uOWCqetcVyHzpOvjOwhjnWGh14tKTZQ5Qc8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mSSuNfx3uE3dd5cgc8GtfNJ/7ARps42rG6tIeEA0xIu4ar5e9jka2Xlv0ghgXmo9v
 zbe1BtWJbtZab8AQi3W0tNhuowS6dFNCDtxZ7CR7EeKyiPqCvIAD6/JiTq2J3kiXsV
 +/8BsPqtgMKsgy1x0e0gwjiaOWRvm3ZJdlbZ5yMw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <564fdbb7-b2f2-421a-ab39-ecc329842d2f@yandex-team.ru>
Date: Wed, 10 Jun 2026 11:28:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition in qemu-iotests nbd 205?
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Eric Blake <eblake@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <CAJSP0QU6Ko87bYaaNm6DCB7krVZgbo_YohuVKSAunBpnDJFdHA@mail.gmail.com>
 <457460b8-70ba-4edf-989d-5dca4d68bbea@yandex-team.ru>
 <aigx8G_jb7RLfbly@redhat.com>
Content-Language: ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aigx8G_jb7RLfbly@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

09.06.26 18:32, Kevin Wolf пишет:
> Am 09.06.2026 um 14:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 08.06.26 17:23, Stefan Hajnoczi пишет:
>>> Hi Vladimir,
>>> It looks like there is a race condition in qemu-iotests 205 when the
>>> NBD server is shutting down:
>>>
>>> +FAIL: test_remove_during_connect_safe_hard (__main__.TestNbdServerRemove)
>>> +----------------------------------------------------------------------
>>> +Traceback (most recent call last):
>>> + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 149,
>>> in test_remove_during_connect_safe_hard
>>> + self.assertExportNotFound('exp')
>>> + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 63, in
>>> assertExportNotFound
>>> + self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
>>> + File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
>>> 1246, in assert_qmp
>>> + self.assertEqual(result, value,
>>> +AssertionError: "Export 'exp' is already shutting down" != "Export
>>> 'exp' is not found"
>>> +- Export 'exp' is already shutting down
>>> ++ Export 'exp' is not found
>>> + : "error/desc" is "Export 'exp' is already shutting down", expected
>>> "Export 'exp' is not found"
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/14745043965#L328
>>>
>>> I have not seen this CI failure before, so it might be rare and hard
>>> to reproduce.
>>>
>>> Stefan
>>
>> Hi! Looks like a degradation in commit
>>
>>
>>      commit 3c3bc462adeb561f5dfdcbb84ae691c95ccef916
>>      Author: Kevin Wolf <kwolf@redhat.com>
>>      Date:   Thu Sep 24 17:27:06 2020 +0200
>>
>>          block/export: Add block-export-del
>>
>>          Implement a new QMP command block-export-del and make nbd-server-remove
>>          a wrapper around it.
>>
>>
>> Before that commit we search for export by nbd_export_find(), and it fails
>> with "Export 'exp' is not found" as expected, because prior
>> qmp_nbd_server_remove(mode=hard) does
>>
>>    nbd_export_remove() -> nbd_export_request_shutdown() -> QTAILQ_REMOVE(&exports, exp, next);
>>
>> when nbd_export_find() searches for that export exactly in this "exports" list
>> (static global in nbd/server.c)
>>
>>
>> Starting with 3c3bc462adeb5
>>
>> qmp_nbd_server_remove() searches for export by blk_export_find(), which searches in
>> block_exports list in block/export/export.c.
>>
>> Previous qmp_nbd_server_remove(mode=hard) does
>>
>>    qmp_block_export_del() -> blk_exp_request_shutdown() -> nbd_export_request_shutdown(),
>>
>> which removes the export only from "exports" list in nbd/server.c.
>>
>>
>> How the export is removed from block_exports list? It is done in blk_exp_delete_bh(),
>> scheduled by
>>
>> void blk_exp_unref(BlockExport *exp)
>> {
>>      assert(exp->refcount > 0);
>>      if (--exp->refcount == 0) {
>>          /* Touch the block_exports list only in the main thread */
>>          aio_bh_schedule_oneshot(qemu_get_aio_context(), blk_exp_delete_bh,
>>                                  exp);
>>      }
>> }
>>
>> ---
>>
>> I think, all the references should be removed druing qmp nbd-server-remove(hard) call,
>> but probably, we still have a (small) chance of doing this check in test
>>
>>     self.assertExportNotFound('exp')
>>
>> and get unexpected answer _before_ scheduled removal actually done.
>>
>> ---
>>
>> blk_exp_unref() does scheduling to main thread since
>>
>>      commit bc4ee65b8c309ed6a726e3ea1b73f7fa31b4bb95
>>      Author: Kevin Wolf <kwolf@redhat.com>
>>      Date:   Thu Sep 24 17:27:03 2020 +0200
>>
>>          block/export: Add blk_exp_close_all(_type)
>>
>> ---
>>
>> Not sure, how to properly fix it... Of course, better is to support old behavior,
>> when action of nbd-server-remove(hard) was synchronous.
> 
> I guess you can always add one more AIO_WAIT_WHILE(), this time to
> nbd-server-remove, but blocking QMP commands aren't really nice, so I'd
> rather avoid that. In the case of nbd-server-remove, if you analysis is
> correct, the current behaviour has been there for almost six years.
> 
> So my gut feeling is that it's better to fix the test case to wait for
> the BLOCK_EXPORT_DELETED event.
> 
> And then I saw that nbd-server-add and nbd-server-remove have actually
> been deprecated since QEMU 5.2, so maybe the best way forward is really
> to just delete them? That will still require changing the test case, of
> course.
> 

Agree, these are strong arguments, thanks. I'll prepare patches for removing
deprecated commands and changeing the test.

-- 
Best regards,
Vladimir


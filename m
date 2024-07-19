Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA02C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUlLN-0007Zu-7n; Fri, 19 Jul 2024 07:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUlLK-0007VA-UU; Fri, 19 Jul 2024 07:00:07 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUlLH-0001oH-Vb; Fri, 19 Jul 2024 07:00:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:70c6:0:640:97e8:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E23B062329;
 Fri, 19 Jul 2024 13:59:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b721::1:1f] (unknown
 [2a02:6b8:b081:b721::1:1f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vxHtvD0IjeA0-9oFsi4LM; Fri, 19 Jul 2024 13:59:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1721386797;
 bh=jz1piiOzCNEI0r70VFNPlILgL7NKf1ZsUNOHguw5htA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XtTDur4HU9ptKq1Zeb4pr6cYZFX3+YqCGGhK0pbIA4YLqsAHp9CnLt1P+s0vAW4WG
 eVuqhH+Kc6H/ByOJHZ1cu/4g/oJsUIu+9BhEBF2vT4m1SVQEML85LVHisEZzrR+OGo
 hNkSNOo1T3aKox4qCL3EpFVdflPx/Jh0+hqcrPFY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6ee792f4-804e-4312-b125-110dad30008f@yandex-team.ru>
Date: Fri, 19 Jul 2024 13:59:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] block/export: add blk_by_export_id()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-3-vsementsov@yandex-team.ru>
 <87ed7qc452.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ed7qc452.fsf@pond.sub.org>
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

On 18.07.24 14:48, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> We need it for further blockdev-replace functionality.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/export/export.c                       | 18 ++++++++++++++++++
>>   include/sysemu/block-backend-global-state.h |  1 +
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/block/export/export.c b/block/export/export.c
>> index 6d51ae8ed7..57beae7982 100644
>> --- a/block/export/export.c
>> +++ b/block/export/export.c
>> @@ -355,3 +355,21 @@ BlockExportInfoList *qmp_query_block_exports(Error **errp)
>>   
>>       return head;
>>   }
>> +
>> +BlockBackend *blk_by_export_id(const char *id, Error **errp)
>> +{
>> +    BlockExport *exp;
>> +
>> +    exp = blk_exp_find(id);
>> +    if (exp == NULL) {
>> +        error_setg(errp, "Export '%s' not found", id);
>> +        return NULL;
>> +    }
>> +
>> +    if (!exp->blk) {
>> +        error_setg(errp, "Export '%s' is empty", id);
> 
> Can this happen?
> 

Hmm, looking at the code in blk_exp_add:

     assert(exp->blk != NULL);
                                                                                  
     QLIST_INSERT_HEAD(&block_exports, exp, next);
     return exp;


seems not. And I can't find anything changing exp->blk except for blk_exp_add().

Will switch to assertion.

>> +        return NULL;
>> +    }
>> +
>> +    return exp->blk;
>> +}
>> diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
>> index ccb35546a1..410d0cc5c7 100644
>> --- a/include/sysemu/block-backend-global-state.h
>> +++ b/include/sysemu/block-backend-global-state.h
>> @@ -74,6 +74,7 @@ void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
>>   DeviceState *blk_get_attached_dev(BlockBackend *blk);
>>   BlockBackend *blk_by_dev(void *dev);
>>   BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
>> +BlockBackend *blk_by_export_id(const char *id, Error **errp);
>>   void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
>>   
>>   void blk_activate(BlockBackend *blk, Error **errp);
> 

-- 
Best regards,
Vladimir



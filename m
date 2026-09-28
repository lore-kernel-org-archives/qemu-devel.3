Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BAACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFKK-000861-Nj; Mon, 28 Sep 2026 13:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBFKF-0007xs-Q5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 13:39:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBFKB-0000lJ-T7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 13:39:38 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SHdGDf007337
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 29 Sep 2026 02:39:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SrSeQ7F6y90iAztd7tGiaw9X7rUjg3LJz1/R9yrdGy8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790617157; v=1;
 b=rknghnA3JQHDKJ0NJdIwaFHopsoNP6aGBc8eEQq/VhdR+0zkFvrzpQ9VCGZW9Iqy
 O8cr1ueMzZDiD8GvKNkDvv/rDDG/wPlvfcSUGS7HLpJZmA3mqibBNGh60bvkQPNW
 sUxxvorFOdcPaWSvrXHMw/RYzfv59YovcvgjXcG+JxR7Dzwxn4xVAiyS+axXklPQ
 i26hzdTN8CMhpPnRw7EfV2+j0hrddeF6vTP0jD4RATQ1w7oEJsyKMGSxEFLaAstb
 jpV8g+8pM3SmR1HlbUXgEUuA1V3QvvTUQr4EF5LWbIBkJleTHnFPVfoM64huN271
 iCqwsigAmMEgw6mU4qyY0Q==
Message-ID: <c5ebc7b7-63f0-4c1a-ad56-df27782c53ce@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 29 Sep 2026 02:39:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] migration: forbid snapshots in CPR migration
 modes
To: Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 peterx@redhat.com, den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
 <87fqyt8lze.fsf@suse.de>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87fqyt8lze.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/28 23:54, Fabiano Rosas wrote:
> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:
> 
>> The savevm/loadvm operation doesn't make any sense in any of the CPR
>> modes.  Saving VM state implies saving its RAM entirely, while the whole
>> point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
>> preserved in place and never put into the migration stream (see
>> migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
>> taken with such a mode set has no RAM in it, and loading a snapshot with
>> such a mode set fails in the RAM loader.
>>
>> Currently nothing stops these operations from firing with a CPR mode
>> still set, e.g. after an earlier CPR attempt.  Reject them early in
>> migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
>> well as 'snapshot-save'/'snapshot-load' QMP commands.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   migration/options.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 05b026f4bf2..f648be1302b 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -555,8 +555,15 @@ static bool migrate_incoming_started(void)
>>   bool migrate_can_snapshot(Error **errp)
>>   {
>>       MigrationState *s = migrate_get_current();
>> +    MigMode mode = migrate_mode();
>>       int i;
>>   
>> +    if (mode != MIG_MODE_NORMAL) {
>> +        error_setg(errp, "Snapshots are not compatible with migration mode %s",
>> +                   MigMode_str(mode));
>> +        return false;
>> +    }
>> +
>>       for (i = 0; i < check_caps_savevm.size; i++) {
>>           int incomp_cap = check_caps_savevm.caps[i];
> 
> +CC Akihiko Odaki
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks for CCing me. This is also relevant to my recent work on Xen
migration. The snapshot RAM-saving path does not support Xen's memory
mappings, so migrate_can_snapshot() should reject Xen as well.

If you send another revision, could you include that check? This is a
pre-existing issue, though, so it need not hold up this patch.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki


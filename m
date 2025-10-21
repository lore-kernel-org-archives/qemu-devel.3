Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEA0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDkk-0005PU-Jr; Tue, 21 Oct 2025 10:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBDki-0005LT-1v
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:54:20 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBDke-0007cR-4R
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:54:19 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C7AC980999;
 Tue, 21 Oct 2025 17:54:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4c::1:32] (unknown
 [2a02:6bf:8080:a4c::1:32])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9sXUj50bA4Y0-hfhZqJzY; Tue, 21 Oct 2025 17:54:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761058450;
 bh=VAdHesSoxs37kLDzbyR6zJ1Crp6IOCk7Vb1U9TBKeRY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=JKP6w61Nod3DPfgf0YwxW6s5B7k0KktyoEf6bTYUSH2SjkGeIFEburIomkkLJqSb8
 JwQ+GDETugP/YLV0iglF3OIhfFS9EQ8XKL5WsxDlL3M9UR4FGS78bomtDVFrcSVpPx
 xBc8IxVmTfJA8VFsjsTKz3JZBhojG1nDPQDW+3wU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
Date: Tue, 21 Oct 2025 17:54:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve error propagation via return path
To: Peter Xu <peterx@redhat.com>, Dhruv Choudhary <dhruv.choudhary@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
 <aPeaBNIzrq0Ni4IM@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPeaBNIzrq0Ni4IM@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21.10.25 17:34, Peter Xu wrote:
> On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
>> Use the return-path thread to send error details from the
>> destination to the source on a migration failure. Management
>> applications can then query the source QEMU for errors, as
>> the single source of truth, making failures easy to trace.
>>
>> Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
> 
> +Vladimir, Dan
> 
> IIUC we may still need to know whether the src QEMU supports this message
> or not.
> 
> OTOH, we have introduced exit-on-error since 9.1:
> 
> # @exit-on-error: Exit on incoming migration failure.  Default true.
> #     When set to false, the failure triggers a :qapi:event:`MIGRATION`
> #     event, and error details could be retrieved with `query-migrate`.
> #     (since 9.1)
> 
> This patch is going the other way.  That feature suggests the mgmt query
> the error from dest directly.
> 
> We should stick with one plan rather than doing both.
> 

Why?

exit-on-error=false is good anyway: when QMP connection is established, the
management of target QEMU process is the same: we do call qmp commands to
add devices, etc. We get QMP events. Actually, exiting is unexpected, better
to fit into QMP protocol, continuing to send events and wait for qmp quit
to exit.

Passing error back to the source simply improves error message on source,
which otherwise is often confusing.

Using both, we of course see same error in two places.. But we do have two
QEMU processes, which both handled by on-host managing services. We should
correctly report error on both parts anyway.

Improving error messages on source is just and improvement, which makes
current behavior better (with or without exit-on-error=false).

Removing exit-on-error=false semantics (with or without passing errors back)
would be a step backward, to violating of QMP protocol by unexpected exits.


> 
>> ---
>>   migration/migration.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a63b46bbef..123cffb286 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -87,6 +87,7 @@ enum mig_rp_message_type {
>>       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>>       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>>       MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
>> +    MIG_RP_MSG_ERROR,        /* propogate error to source */
>>   
>>       MIG_RP_MSG_MAX
>>   };
>> @@ -608,6 +609,17 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
>>       return migrate_send_rp_message_req_pages(mis, rb, start);
>>   }
>>   
>> +static void migrate_send_rp_error(MigrationIncomingState *mis, Error *errp)
>> +{
>> +    const char *rpmsg = error_get_pretty(errp);
>> +    if (!mis->to_src_file) {
>> +        mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
>> +    }
>> +    migrate_send_rp_message(mis, MIG_RP_MSG_ERROR,
>> +                            (uint16_t)(strlen(rpmsg) + 1),
>> +                            (char *)rpmsg);
>> +}
>> +
>>   static bool migration_colo_enabled;
>>   bool migration_incoming_colo_enabled(void)
>>   {
>> @@ -905,8 +917,12 @@ process_incoming_migration_co(void *opaque)
>>       }
>>   
>>       if (ret < 0) {
>> -        error_prepend(&local_err, "load of migration failed: %s: ",
>> -                      strerror(-ret));
>> +        error_prepend(&local_err, "destination error : load of migration failed:
>> +                       %s: ", strerror(-ret));
>> +        /* Check if return path is enabled and then send error to source */
>> +        if (migrate_postcopy_ram() || migrate_return_path()) {
>> +            migrate_send_rp_error(mis, local_err);
>> +        }
>>           goto fail;
>>       }
>>   
>> @@ -2437,6 +2453,7 @@ static struct rp_cmd_args {
>>       [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>>       [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
>>       [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
>> +    [MIG_RP_MSG_ERROR]          = { .len = -1, .name = "ERROR"},
>>       [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>>   };
>>   
>> @@ -2667,6 +2684,10 @@ static void *source_return_path_thread(void *opaque)
>>               trace_source_return_path_thread_switchover_acked();
>>               break;
>>   
>> +        case MIG_RP_MSG_ERROR:
>> +            error_setg(&err, "%s", (char *)buf);
>> +            goto out;
>> +
>>           default:
>>               break;
>>           }
>> -- 
>> 2.39.3
>>
> 


-- 
Best regards,
Vladimir


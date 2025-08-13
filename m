Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F074BC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 13:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umB4T-00079z-QQ; Wed, 13 Aug 2025 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1umARI-0005i1-WC
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:18:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1umARD-0005zE-7x
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:18:44 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c26hy0DlNz14MRx;
 Wed, 13 Aug 2025 20:13:22 +0800 (CST)
Received: from kwepemh200008.china.huawei.com (unknown [7.202.181.115])
 by mail.maildlp.com (Postfix) with ESMTPS id 758A41402CD;
 Wed, 13 Aug 2025 20:18:21 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemh200008.china.huawei.com (7.202.181.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 20:18:20 +0800
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
Message-ID: <a737f734-e899-d544-19c1-08a93e3c50ea@huawei.com>
Date: Wed, 13 Aug 2025 20:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.125]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200008.china.huawei.com (7.202.181.115)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=jiangkunkun@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.152,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 Aug 2025 08:58:36 -0400
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
Reply-to:  Kunkun Jiang <jiangkunkun@huawei.com>
From:  Kunkun Jiang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Avihai,

On 2025/8/12 22:08, Avihai Horon wrote:
> 
> On 11/08/2025 19:34, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello,
>>
>> + Avihai
>>
>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>> Hi all,
>>>
>>> While testing VFIO migration, I encountered an corner scenario case:
>>> VFIO migration will not be aborted when the vfio device of dst-vm 
>>> fails to transition from RESUMING to RUNNING state in 
>>> vfio_vmstate_change.
>>>
>>> I saw the comments in the vfio_vmstate_change but I don't understand 
>>> why no action is taken for this situation.
>>
>> There is error handling in vfio_vmstate_change() :
>>
>>         /*
>>          * Migration should be aborted in this case, but 
>> vm_state_notify()
>>          * currently does not support reporting failures.
>>          */
>>         migration_file_set_error(ret, local_err);
> 
> Hmm, I think this only sets the error on src. On dst we don't have 
> MigrationState->to_dst_file, so we end up just reporting the erro > But even if we did set it, no one is checking if there is a migration
> error after vm_start() is called in process_incoming_migration_bh().
Yes, that's what I mean.
> 
>>
>>> Allowing the live migration process to continue could cause 
>>> unrecoverable damage to the VM.
> 
> What do you mean by unrecoverable damage to the VM?
> If RESUMING->RUNNING transition fails, would a VFIO reset recover the 
> device and allow the VM to continue operation with damage limited only 
> to the VFIO device?
I didn't express myself clearly, let me explain again.
In my test, I ran a task inside the VM that was using this vfio device.
In this corner scenario, the task is aborted immediately and the VM is 
still running normally. I mean it is unacceptable that the task is 
aborted directly.
> 
>>> In this case, can we directly exit the dst-vm? Through the 
>>> return-path mechanism, the src-vm can continue to run.
>>>
>>> Looking forward to your reply.
>>
> The straightforward solution, as you suggested, is to exit dst upon 
> error in RESUMING->RUNNING transition and notify about it to src through 
> the return-path.
> However, I am not sure if failing the migration after vm_start() on dst 
> is a bit late (as we start vCPUs and do migration_block_activate, etc.).
I think vCPUs have not started yet. vCPUs will be started only after the 
all callbacks of vm_state_notify are executed.
If there are any problems with my analysis, please point them out.
> 
> But I can think of another way to solve this, hopefully simpler.
> According to VFIO migration uAPI [1]:
>   * RESUMING -> STOP
>   *   Leaving RESUMING terminates a data transfer session and indicates the
>   *   device should complete processing of the data delivered by 
> write(). The
>   *   kernel migration driver should complete the incorporation of data 
> written
>   *   to the data transfer FD into the device internal state and perform
>   *   final validity and consistency checking of the new device state. 
> If the
>   *   user provided data is found to be incomplete, inconsistent, or 
> otherwise
>   *   invalid, the migration driver must fail the SET_STATE ioctl and
>   *   optionally go to the ERROR state as described below.
> 
> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the 
> device config is loaded (which is the last data the device is expected 
> to receive).
> If this transition fails, it means something was wrong with migration, 
> and we can send src an error msg via return-path (and not continue to 
> vm_start()).
> 
> Maybe this approach is less complicated than the first one, and it will 
> also work if src VM was paused prior migration.
> I already tested some POC and it seems to be working (at least with an 
> artificial error i injected in RESUMING->STOP transition).
> Kunkun, can you apply the following diff [3] and check if this solves 
> the issue?
Ok, I'll try it.
> 
> And in general, what do you think? Should we go with this approach or do 
> you have other ideas?
My current approach is rather crude. As I said above, I think vcpu has 
not started yet, so I changed it like this.
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4c06e3db93..70ccb706c6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -878,7 +878,7 @@ static void vfio_vmstate_change_prepare(void 
*opaque, bool running,
  static void vfio_vmstate_change(void *opaque, bool running, RunState 
state)
  {
      VFIODevice *vbasedev = opaque;
-    enum vfio_device_mig_state new_state;
+    enum vfio_device_mig_state new_state, pre_state;
      Error *local_err = NULL;
      int ret;

@@ -899,6 +899,10 @@ static void vfio_vmstate_change(void *opaque, bool 
running, RunState state)
           * currently does not support reporting failures.
           */
          migration_file_set_error(ret, local_err);
+
+        if (pre_state == VFIO_DEVICE_STATE_RESUMING) {
+            exit(EXIT_FAILURE);
+        }
      }
> 
> Thanks.
> 
> [1] 
> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099 
> 
> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part 
> of RESUMING->RUNNING transition.
> [3]
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index e4785031a7..66f8461f02 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -267,6 +267,12 @@ static bool 
> vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
>       ret = vfio_load_device_config_state(f_in, vbasedev);
>       bql_unlock();
> 
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
> +                                   VFIO_DEVICE_STATE_ERROR, errp);
> +    if (ret) {
> +        return false;
> +    }
> +
>       if (ret < 0) {
>           error_setg(errp, "%s: vfio_load_device_config_state() failed: 
> %d",
>                      vbasedev->name, ret);
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..a707d17a5b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -737,6 +737,8 @@ static int vfio_load_state(QEMUFile *f, void 
> *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            Error *local_err = NULL;
> +
>               if (vfio_multifd_transfer_enabled(vbasedev)) {
>                   error_report("%s: got DEV_CONFIG_STATE in main 
> migration "
>                                "channel but doing multifd transfer",
> @@ -744,7 +746,19 @@ static int vfio_load_state(QEMUFile *f, void 
> *opaque, int version_id)
>                   return -EINVAL;
>               }
> 
> -            return vfio_load_device_config_state(f, opaque);
> +            ret = vfio_load_device_config_state(f, opaque);
> +            if (ret) {
> +                return ret;
> +            }
> +
> +            ret = vfio_migration_set_state_or_reset(
> +                vbasedev, VFIO_DEVICE_STATE_STOP, &local_err);
> +            if (ret) {
> +                error_report_err(local_err);
> +                return ret;
> +            }
> +
> +            return 0;
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>           {
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..fd498c864d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -91,6 +91,7 @@ enum mig_rp_message_type {
>       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to 
> resume */
>       MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
> +    MIG_RP_MSG_ERROR, /* Tell source that destination encountered an 
> error */
> 
>       MIG_RP_MSG_MAX
>   };
> @@ -884,6 +885,11 @@ process_incoming_migration_co(void *opaque)
>       ret = qemu_loadvm_state(mis->from_src_file);
>       mis->loadvm_co = NULL;
> 
> +    if (ret) {
> +        migrate_send_rp_error(mis);
> +        error_report("SENT RP ERROR");
> +    }
> +
>   trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> 
>       ps = postcopy_state_get();
> @@ -1126,6 +1132,11 @@ bool migration_has_all_channels(void)
>       return true;
>   }
> +int migrate_send_rp_error(MigrationIncomingState *mis)
> +{
> +    return migrate_send_rp_message(mis, MIG_RP_MSG_ERROR, 0, NULL);
> +}
> +
>   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
>   {
>       return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, 
> NULL);
> @@ -2614,6 +2625,10 @@ static void *source_return_path_thread(void *opaque)
>               trace_source_return_path_thread_switchover_acked();
>               break;
> 
> +        case MIG_RP_MSG_ERROR:
> +            error_setg(&err, "DST indicated error");
> +            goto out;
> +
>           default:
>               break;
>           }
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..f11ff7a199 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -553,6 +553,7 @@ void 
> migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                    char *block_name);
>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t 
> value);
>   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
> +int migrate_send_rp_error(MigrationIncomingState *mis);
> 
>   void dirty_bitmap_mig_before_vm_start(void);
>   void dirty_bitmap_mig_cancel_outgoing(void);
> 
>> I suggest you open an issue on :
>>
>>   https://gitlab.com/qemu-project/qemu/-/issues/
>>
>> with a detailed description of your environment :
>>
>>   Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.
>>
>> A template is provided when a new issue is created.
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
> .


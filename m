Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139ECA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umB46-00073L-QF; Wed, 13 Aug 2025 08:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1umARY-0005rY-V7
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:19:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1umART-00062W-Dp
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:19:00 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c26mB1NrDz2TT9S;
 Wed, 13 Aug 2025 20:16:10 +0800 (CST)
Received: from kwepemh200008.china.huawei.com (unknown [7.202.181.115])
 by mail.maildlp.com (Postfix) with ESMTPS id 80DDF1401F0;
 Wed, 13 Aug 2025 20:18:50 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemh200008.china.huawei.com (7.202.181.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 20:18:49 +0800
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Yishai
 Hadas <yishaih@nvidia.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
 <f6165e17-a926-4a59-9b59-2dd6853f20a6@redhat.com>
Message-ID: <0efe9dbd-0666-16a4-dccc-c05c0cec95e4@huawei.com>
Date: Wed, 13 Aug 2025 20:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f6165e17-a926-4a59-9b59-2dd6853f20a6@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.125]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200008.china.huawei.com (7.202.181.115)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=jiangkunkun@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.152,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 Aug 2025 08:58:40 -0400
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

Hi Cédric,

On 2025/8/12 22:56, Cédric Le Goater wrote:
> On 8/12/25 16:08, Avihai Horon wrote:
>>
>> On 11/08/2025 19:34, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello,
>>>
>>> + Avihai
>>>
>>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>>> Hi all,
>>>>
>>>> While testing VFIO migration, I encountered an corner scenario case:
>>>> VFIO migration will not be aborted when the vfio device of dst-vm 
>>>> fails to transition from RESUMING to RUNNING state in 
>>>> vfio_vmstate_change.
>>>>
>>>> I saw the comments in the vfio_vmstate_change but I don't understand 
>>>> why no action is taken for this situation.
>>>
>>> There is error handling in vfio_vmstate_change() :
>>>
>>>         /*
>>>          * Migration should be aborted in this case, but 
>>> vm_state_notify()
>>>          * currently does not support reporting failures.
>>>          */
>>>         migration_file_set_error(ret, local_err);
>>
>> Hmm, I think this only sets the error on src. On dst we don't have 
>> MigrationState->to_dst_file, so we end up just reporting the error.
>> But even if we did set it, no one is checking if there is a migration 
>> error after vm_start() is called in process_incoming_migration_bh().
>>
>>>
>>>> Allowing the live migration process to continue could cause 
>>>> unrecoverable damage to the VM.
>>
>> What do you mean by unrecoverable damage to the VM?
>> If RESUMING->RUNNING transition fails, would a VFIO reset recover the 
>> device and allow the VM to continue operation with damage limited only 
>> to the VFIO device?
>>
>>>> In this case, can we directly exit the dst-vm? Through the 
>>>> return-path mechanism, the src-vm can continue to run.
>>>>
>>>> Looking forward to your reply.
>>>
>> The straightforward solution, as you suggested, is to exit dst upon 
>> error in RESUMING->RUNNING transition and notify about it to src 
>> through the return-path.
>> However, I am not sure if failing the migration after vm_start() on 
>> dst is a bit late (as we start vCPUs and do migration_block_activate, 
>> etc.).
>>
>> But I can think of another way to solve this, hopefully simpler.
>> According to VFIO migration uAPI [1]:
>>   * RESUMING -> STOP
>>   *   Leaving RESUMING terminates a data transfer session and 
>> indicates the
>>   *   device should complete processing of the data delivered by 
>> write(). The
>>   *   kernel migration driver should complete the incorporation of 
>> data written
>>   *   to the data transfer FD into the device internal state and perform
>>   *   final validity and consistency checking of the new device state. 
>> If the
>>   *   user provided data is found to be incomplete, inconsistent, or 
>> otherwise
>>   *   invalid, the migration driver must fail the SET_STATE ioctl and
>>   *   optionally go to the ERROR state as described below.
>>
>> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after 
>> the device config is loaded (which is the last data the device is 
>> expected to receive).
>> If this transition fails, it means something was wrong with migration, 
>> and we can send src an error msg via return-path (and not continue to 
>> vm_start()).
>>
>> Maybe this approach is less complicated than the first one, and it 
>> will also work if src VM was paused prior migration.
>> I already tested some POC and it seems to be working (at least with an 
>> artificial error i injected in RESUMING->STOP transition).
>> Kunkun, can you apply the following diff [3] and check if this solves 
>> the issue?
>>
>> And in general, what do you think? Should we go with this approach or 
>> do you have other ideas?
>>
>> Thanks.
>>
>> [1] 
>> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099 
>>
>> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part 
>> of RESUMING->RUNNING transition.
>> [3]
> 
> Avihai,
> 
> Could you please send an RFC patch with Peter and Fabiano in cc: ?
> This will help to discuss the proposal and keep track of the issue.
> 
> 
> Kunkun Jiang,
> 
> Could you please share details on your environment ?
Sorry for the late reply.My test scenario is this:
Server:		Kunpeng-920
VFUI device:	SEC, a Kunpeng hardware accelerator
Host OS:	openEuler 24.03, kernel 6.6, qemu 8.2
Guest OS:	openEuler 24.03
Test steps:
1. Start a VM and run a task using SEC inside the VM
2. Start migration and inject an error into the SEC used by dst-VM
3. The SEC used by dst-VM will be reset. So RESUMING->RUNNING transition 
will fail with probability.(The timing has to be just right)

> 
> Thanks,
> 
> C.
> 
> 
> .


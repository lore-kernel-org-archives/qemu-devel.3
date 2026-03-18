Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A435103E190
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2sG2-0006gd-Ty; Wed, 18 Mar 2026 10:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w2sFo-0006dr-3i; Wed, 18 Mar 2026 10:52:15 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w2sFm-0007wX-2Q; Wed, 18 Mar 2026 10:52:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 93FA380388;
 Wed, 18 Mar 2026 15:51:57 +0100 (CET)
Message-ID: <3f4ddd09-a79b-4bfc-93d4-a3f7b6146da0@proxmox.com>
Date: Wed, 18 Mar 2026 15:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH 2/3] iotests/041: add test for mirror with throttled NBD
 export as target
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
 <20260311145717.668492-3-f.ebner@proxmox.com>
 <ad6a2467-3763-4590-8a86-097ab916a4c1@redhat.com>
Content-Language: en-US
In-Reply-To: <ad6a2467-3763-4590-8a86-097ab916a4c1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773845474822
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 16.03.26 um 6:27 PM schrieb Hanna Czenczek:
> On 11.03.26 15:54, Fiona Ebner wrote:
>> Mostly in preparation for commit "iotests/041: add test for duplicate
>> job-complete with throttled target".
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>   tests/qemu-iotests/041     | 112 ++++++++++++++++++++++++++++++++++++-
>>   tests/qemu-iotests/041.out |   4 +-
>>   2 files changed, 113 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 8452845f44..a7e1980f13 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
> 
> [...]
> 
> 
>> +    def tearDown(self):
>> +        os.remove(test_img)
>> +        os.remove(target_img)
>> +        os.remove(backing_img)
>> +        os.remove(target_backing_img)
> 
> It would be good if tearDown() could still contain the VM/QSD shutdown/
> stop.

Will do!

>> +
>> +    def test_throttled(self):
>> +        self.vm.cmd('blockdev-mirror',
>> +                    job_id='mirror',
>> +                    device='source',
>> +                    target='target',
>> +                    sync='full')
>> +
>> +        time.sleep(1)
>> +        result = self.vm.qmp('query-block-jobs')
>> +        self.assert_qmp(result, 'return[0]/ready', False)
>> +        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000}')
>> +        time.sleep(1) # in real time, the rest should now comlpete fast
> 
> I think the clock_step belongs on the export side, the QSD.  On the
> other hand, QSD has no way to enable qtest, I believe, so it won’t work
> well as an export here.  I think it works accidentally because throttle
> allows a burst, and can allow to write 3 MB in 2 seconds.

Ah, good catch! I originally did everything with just the VM, but
draining during mirror completion disables the throttling, so the issue
with the duplicate complete wouldn't trigger for the test in patch 3/3.
That's why an external target is needed.

> This whole test is also a bit fiddly. It needs to write 3 MB in one
> second, I believe, which seems prone to being flakey.  I’d be happy with
> a null export on the target side, if that still did the job (pun intended).

The one from patch 3/3 relies on the same kind of behavior. I guess
using a second VM instance rather than QSD for the export could work?
And adapting the test to make throttling actually have an effect.

Best Regards,
Fiona

> (Also *complete)
> 
> Hanna
> 
>> +        result = self.vm.qmp('query-block-jobs')
>> +        self.assert_qmp(result, 'return[0]/ready', True)
>> +
>> +        self.complete_and_wait('mirror')
>> +        self.vm.shutdown()
>> +        self.qsd.stop()
>> +        self.assertTrue(iotests.compare_images(test_img, target_img),
>> +                        'target image does not match source after
>> mirroring')
>> +
>>     if __name__ == '__main__':
>>       iotests.main(supported_fmts=['qcow2', 'qed'],
>> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
>> index 46651953e8..5273ce86c3 100644
>> --- a/tests/qemu-iotests/041.out
>> +++ b/tests/qemu-iotests/041.out
>> @@ -1,5 +1,5 @@
>> -...........................................................................................................
>> +............................................................................................................
>>   ----------------------------------------------------------------------
>> -Ran 107 tests
>> +Ran 108 tests
>>     OK
> 
> 




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F5C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 14:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shVUt-0006pb-S6; Fri, 23 Aug 2024 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1shVUr-0006oO-Ru; Fri, 23 Aug 2024 10:42:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1shVUo-0000pb-PO; Fri, 23 Aug 2024 10:42:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 176A82032A;
 Fri, 23 Aug 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724424151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7NWPSn3NjSDnQ9xXjkT1ggonuVkME4NILi2bxzGxRw=;
 b=CPwzIBJXGSbtdODMBQl1rzYA1GkHRp/9XnjpaEmjERmhEtrh7jtirAOtpPDYFelEhXk8IW
 BYcmlwyoycLGHrl9lK+0ibZPGF8utRkt0aE1fr9ABb1906dKMkVi4p250kJtRrlzA7hMrK
 sgw/ohEvGepZTe3ZvK6Vy8RVhESoJVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724424151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7NWPSn3NjSDnQ9xXjkT1ggonuVkME4NILi2bxzGxRw=;
 b=eR1eCNVK2xPgaPA3H/S8OthuEaeOlL3IDsMN92MJJ0jRsunc7n0XUM/YqP/BLocCyIx9Jo
 rf+7+lzVSmLqbHAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CPwzIBJX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eR1eCNVK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724424151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7NWPSn3NjSDnQ9xXjkT1ggonuVkME4NILi2bxzGxRw=;
 b=CPwzIBJXGSbtdODMBQl1rzYA1GkHRp/9XnjpaEmjERmhEtrh7jtirAOtpPDYFelEhXk8IW
 BYcmlwyoycLGHrl9lK+0ibZPGF8utRkt0aE1fr9ABb1906dKMkVi4p250kJtRrlzA7hMrK
 sgw/ohEvGepZTe3ZvK6Vy8RVhESoJVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724424151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7NWPSn3NjSDnQ9xXjkT1ggonuVkME4NILi2bxzGxRw=;
 b=eR1eCNVK2xPgaPA3H/S8OthuEaeOlL3IDsMN92MJJ0jRsunc7n0XUM/YqP/BLocCyIx9Jo
 rf+7+lzVSmLqbHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CA741333E;
 Fri, 23 Aug 2024 14:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id olToFNafyGZtewAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 14:42:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Arisetty, Chakri" <carisett@akamai.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake
 <eblake@redhat.com>, "Blew III, Will" <wblewiii@akamai.com>, "Massry,
 Abraham" <amassry@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Greve, Mark" <mgreve@akamai.com>
Subject: Re: Issue with QEMU Live Migration
In-Reply-To: <A658D108-2EC3-4BA1-900C-4FE9FB498B03@akamai.com>
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
 <874j7e0yjt.fsf@suse.de> <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
 <874j7czn33.fsf@suse.de> <3587C969-9BDB-4BBD-8A79-3679C3F3801A@akamai.com>
 <A658D108-2EC3-4BA1-900C-4FE9FB498B03@akamai.com>
Date: Fri, 23 Aug 2024 11:42:27 -0300
Message-ID: <87ed6fxpv0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 176A82032A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; REDIRECTOR_URL(0.00)[urldefense.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Arisetty, Chakri" <carisett@akamai.com> writes:

> Hello,
>
> Here is more data if my earlier mail did not provide enough details. I ap=
ologize for not providing the critical data points in my previous mail.
>
> - Created a file (dd if=3D/dev/urandom of=3D/orig.img bs=3D1M count=3D100=
0) before starting live migration
> - Started migration with block-job-cancel command before entering into pr=
e-switchover

Is this a type of migration that you have attempted before and it used
to work? Or is this the first time you're using the mirror job for live
migration?

I was expecting something like:

- start the mirror job
- qmp_migrate
- once PRE_SWITCHOVER is reached, issue block-job-cancel
- qmp_migrate_continue

To be clear, at this point I don't think probing the job status from the
migration code to wait for the job to finish is the right thing to
do. Let's first attempt to rule out any bugs or incorrect usage.

> - During the RAM migration, I copied the original file to new file (dd of=
=3D/migration.img if=3D/orig.img bs=3D1M count=3D1000)
> - During the RAM migration, I also started stress-ng (stress-ng --hdd 10 =
--hdd-bytes 4G -i 8 -t 72000s)
> - Issued sync command to flush the new buffer contents into the disk. VM =
stalled completely
> - Migration was completed successfully
> - Rebooted the VM and checked for the file (/migration.img). The file doe=
s not exist. So, block device contents are NOT synced.
>
> So, we have a potential for customer data loss. This is the problem we cu=
rrently have.
>
> Can someone advice?
>
> Thanks
> Chakri
>
>
> =EF=BB=BFOn 8/23/24, 6:30 AM, "Arisetty, Chakri" <carisett@akamai.com <ma=
ilto:carisett@akamai.com>> wrote:
>
>
> Hi,
>
>
> Thank you once again!
>
>
>> It's still not entirely clear to me what the situation is here. When the
>> migration reaches pre-switchover state the VM is stopped, so there would
>> be no more IO happening. Is this a matter of a race condition (of sorts)
>> because pre-switchover happens while the block mirror job is still
>> transferring the final blocks? Or is it instead about the data being in
>> traffic over the netword and not yet reaching the destination machine?
>
>
> When the migration reaches to pre-switchover with block-job-cancelled, th=
ere are no dirty blocks, But, there are dirty blocks if the block-job is NO=
T cancelled
> and there are dirty blocks, and those blocks are transferred to NBD serve=
r.
>
>
> # When the block mirror job is running before enter pre-switchover state,=
 the dirty count is '0' and job entered into 'ready' state from 'running' s=
tate.
> # block-job-cancel is NOT issued with the test.
> 1695226@1724348063.794485:mirror_run < s 0x55e5b9ffbe40 in_flight: 0 byte=
s_in_flight: 0 dirty count 0 active_write_bytes_in_flight 0 total 536870912=
0 current 5368709120 deltla 1630 iostatus 0
>
>
> 1695226@1724348063.795152:job_state_transition job 0x55e5b9ffbe40 (ret: 0=
) attempting allowed transition (running-->ready)
>
>
> # QMP command for 'query-block-jobs'
> 1695226@1724348063.845789:qmp_exit_query_block_jobs [{"auto-finalize": tr=
ue, "io-status": "ok", "device": "drive-scsi-disk-0", "auto-dismiss": true,=
 "busy": false, "len": 5368709120, "offset": 5368709120, "status": "ready",=
 "paused": false, "speed": 100000000, "ready": true, "type": "mirror"}] 1
>
>
> # RAM migration enters 'pre-switchover', dirty count keeps incrementing a=
nd NBD client sending the block pages to NBD server.
>
>
> 1695226@1724348070.968831:mirror_run < s 0x55e5b9ffbe40 in_flight: 0 byte=
s_in_flight: 0 dirty count 131072 active_write_bytes_in_flight 0 total 5368=
840192 current 5368709120 deltla 950 iostatus 0
> ...
> 1695226@1724348070.970540:mirror_run < s 0x55e5b9ffbe40 in_flight: 0 byte=
s_in_flight: 0 dirty count 2162688 active_write_bytes_in_flight 0 total 537=
1002880 current 5368840192 deltla 1547585 iostatus 0
> ..
>
>
> RAM migration to enter 'completion' state from 'pre-switchover' takes a v=
ery long time for VM with bigger RAM. Stopping/Cancelling block-job during =
the period causes the disk contents to be lost entire duration.
>
>
> Is there a way or API/callback in qemu to indicate there are no dirty blo=
cks and invoke the API from RAM migration code?
>
>
> I'd appreciate if anyone can help me with it.
>
>
> Thanks
> Chakri
>
>
>
>
> On 8/22/24, 6:47 AM, "Fabiano Rosas" <farosas@suse.de <mailto:farosas@sus=
e.de> <mailto:farosas@suse.de <mailto:farosas@suse.de>>> wrote:
>
>
>
>
> !-------------------------------------------------------------------|
> This Message Is From an External Sender
> This message came from outside your organization.
> |-------------------------------------------------------------------!
>
>
>
>
> "Arisetty, Chakri" <carisett@akamai.com <mailto:carisett@akamai.com> <mai=
lto:carisett@akamai.com <mailto:carisett@akamai.com>>> writes:
>
>
>
>
> Ugh, it seems I messed up the CC addresses, let's see if this time they
> go out right. For those new to the thread, we're discussing this bug:
>
>
>
>
> https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues=
/2482__;!!GjvTz_vk!R6zmb2ufwcYOXxYJf4aaguOQTMFPQZ0ErAQ0ekFW2yr8pLLIFJF1mw_u=
QnwBSdKtUuJad2phm7sE4ME$ <https://urldefense.com/v3/__https://gitlab.com/qe=
mu-project/qemu/-/issues/2482__;!!GjvTz_vk!R6zmb2ufwcYOXxYJf4aaguOQTMFPQZ0E=
rAQ0ekFW2yr8pLLIFJF1mw_uQnwBSdKtUuJad2phm7sE4ME$> <https://urldefense.com/v=
3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!R6zmb2u=
fwcYOXxYJf4aaguOQTMFPQZ0ErAQ0ekFW2yr8pLLIFJF1mw_uQnwBSdKtUuJad2phm7sE4ME$ <=
https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/2=
482__;!!GjvTz_vk!R6zmb2ufwcYOXxYJf4aaguOQTMFPQZ0ErAQ0ekFW2yr8pLLIFJF1mw_uQn=
wBSdKtUuJad2phm7sE4ME$>>=20
>
>
>
>
>> Hi,
>>
>> Thank you for getting back to me.
>>
>> Yes, I have opened the ticket https://urldefense.com/v3/__https://gitlab=
.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW=
4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense=
.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!S=
Cg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZN=
JdE$> <https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/i=
ssues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87y=
L3iJcxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.com/v3/__https://gitlab.c=
om/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_=
Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$>> <https://urldefense=
.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!S=
Cg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZN=
JdE$ <https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/is=
sues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL=
3iJcxuZPktLeHNNtPztJTJZNJdE$> <https://urldefense.com/v3/__https://gitlab.c=
om/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_=
Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.c=
om/v3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg=
-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJd=
E$>>>
>>
>>> So the core of the issue here is that the block job is transitioning to
>>> ready while the migration is still ongoing so there's still dirtying
>>> happening.
>>
>> Yes, this is the problem I have. RAM migration state is already moved to=
 pre-switchover and mirror block job is moved to "READY" state assuming tha=
t there are no more dirty blocks.
>> But there are still dirty blocks and these dirty block blocks are being =
transferred to destination host.
>>
>> I've created a small patch(attached) in mirror.c to put the mirror job b=
ack into the "RUNNING" state if there are any dirty pages.
>> But I still would like to prevent RAM migration state to be moved to pre=
-switchover when there are dirty blocks.
>
>
>
>
> It's still not entirely clear to me what the situation is here. When the
> migration reaches pre-switchover state the VM is stopped, so there would
> be no more IO happening. Is this a matter of a race condition (of sorts)
> because pre-switchover happens while the block mirror job is still
> transferring the final blocks? Or is it instead about the data being in
> traffic over the netword and not yet reaching the destination machine?
>
>
>
>
> Is the disk inactivation after the pre-switchover affecting this at all?
>
>
>
>
>>
>>> docs/interop/live-block-operations.rst? Section "QMP invocation for live
>>> storage migration with ``drive-mirror`` + NBD", point 4 says that a
>>> block-job-cancel should be issues after BLOCK_JOB_READY is
>>> reached. Although there is mention of when the migration should be
>>> performed.
>>
>> Thanks for the pointer, I've looked at this part (block-job-cancel). The=
 problem is that QEMU on the source host is still transferring the dirty bl=
ocks.
>> That is the reason I am trying to avoid moving RAM migration state to pr=
e-switchover when there are any dirty pages.
>>
>> is there a way in QEMU to know if the disk transfer is completed and sto=
p dirty pages being transferred?
>
>
>
>
> Sorry, I can't help here. We have block layer people in CC, they might
> be able to advise.
>
>
>
>
>>
>> Thanks
>> Chakri
>>
>>
>> On 8/21/24, 6:56 AM, "Fabiano Rosas" <farosas@suse.de <mailto:farosas@su=
se.de> <mailto:farosas@suse.de <mailto:farosas@suse.de>> <mailto:farosas@su=
se.de <mailto:farosas@suse.de> <mailto:farosas@suse.de <mailto:farosas@suse=
.de>>>> wrote:
>>
>>
>> !-------------------------------------------------------------------|
>> This Message Is From an External Sender
>> This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>
>>
>> "Arisetty, Chakri" <carisett@akamai.com <mailto:carisett@akamai.com> <ma=
ilto:carisett@akamai.com <mailto:carisett@akamai.com>> <mailto:carisett@aka=
mai.com <mailto:carisett@akamai.com> <mailto:carisett@akamai.com <mailto:ca=
risett@akamai.com>>>> writes:
>>
>>
>>> Hello,
>>>
>>> I=E2=80=99m having trouble with live migration and I=E2=80=99m using QE=
MU 7.2.0 on Debian 11.
>>>
>>> Migration state switches to pre-switchover state during the RAM migrati=
on.
>>>
>>> My assumption is that disks are already migrated and there are no furth=
er dirty pages to be transferred from source host to destination host. Ther=
efore, NBD client on the source host closes the connection to the NBD serve=
r on the destination host. But we observe that there are still some dirty p=
ages being transferred.
>>> Closing prematurely NBD connection results in BLOCK JOB error.
>>> In the RAM migration code (migration/migration.c), I=E2=80=99d like to =
check for block mirror job=E2=80=99s status before RAM migration state is m=
oved to pre-switchover. I=E2=80=99m unable to find any block job related co=
de in RAM migration code.
>>>
>>> Could someone help me figuring out what might be going wrong or suggest=
 any troubleshooting steps or advice to get around the issue?
>>>
>>> Thanks
>>> Chakri
>>
>>
>> Hi, I believe it was you who opened this bug as well?=20
>>
>>
>> https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issue=
s/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJ=
cxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.com/v3/__https://gitlab.com/q=
emu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tU=
tzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$> <https://urldefense.com/=
v3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5=
LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$ =
<https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/=
2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcx=
uZPktLeHNNtPztJTJZNJdE$>> <https://urldefense.com/v3/__https://gitlab.com/q=
emu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tU=
tzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.com/v=
3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5L=
iuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$> =
<https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/=
2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcx=
uZPktLeHNNtPztJTJZNJdE$ <https://urldefense.com/v3/__https://gitlab.com/qem=
u-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtz=
PZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$>>>=20
>>
>>
>> So the core of the issue here is that the block job is transitioning to
>> ready while the migration is still ongoing so there's still dirtying
>> happening.
>>
>>
>> Have you looked at the documentation at
>> docs/interop/live-block-operations.rst? Section "QMP invocation for live
>> storage migration with ``drive-mirror`` + NBD", point 4 says that a
>> block-job-cancel should be issues after BLOCK_JOB_READY is
>> reached. Although there is mention of when the migration should be
>> performed.
>>
>>
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 251adc5ae..3457afe1d 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1089,6 +1089,10 @@ static int coroutine_fn mirror_run(Job *job, Erro=
r **errp)
>> break;
>> }
>>=20
>> + if (cnt !=3D 0 && job_is_ready(&s->common.job)) {
>> + job_transition_to_running(&s->common.job);
>> + }
>> +
>> if (job_is_ready(&s->common.job) && !should_complete) {
>> delay_ns =3D (s->in_flight =3D=3D 0 &&
>> cnt =3D=3D 0 ? BLOCK_JOB_SLICE_TIME : 0);
>> diff --git a/include/qemu/job.h b/include/qemu/job.h
>> index e502787dd..87dbef0d2 100644
>> --- a/include/qemu/job.h
>> +++ b/include/qemu/job.h
>> @@ -641,6 +641,12 @@ int job_apply_verb_locked(Job *job, JobVerb verb, E=
rror **errp);
>> */
>> void job_early_fail(Job *job);
>>=20
>> +/**
>> + * Moves the @job from RUNNING to READY.
>> + * Called with job_mutex *not* held.
>> + */
>> +void job_transition_to_running(Job *job);
>> +
>> /**
>> * Moves the @job from RUNNING to READY.
>> * Called with job_mutex *not* held.
>> diff --git a/job.c b/job.c
>> index 72d57f093..298d90817 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -62,7 +62,7 @@ bool JobSTT[JOB_STATUS__MAX][JOB_STATUS__MAX] =3D {
>> /* C: */ [JOB_STATUS_CREATED] =3D {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1},
>> /* R: */ [JOB_STATUS_RUNNING] =3D {0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0},
>> /* P: */ [JOB_STATUS_PAUSED] =3D {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
>> - /* Y: */ [JOB_STATUS_READY] =3D {0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0},
>> + /* Y: */ [JOB_STATUS_READY] =3D {0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0},
>> /* S: */ [JOB_STATUS_STANDBY] =3D {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
>> /* W: */ [JOB_STATUS_WAITING] =3D {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
>> /* D: */ [JOB_STATUS_PENDING] =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
>> @@ -1035,6 +1035,12 @@ static int job_transition_to_pending_locked(Job *=
job)
>> return 0;
>> }
>>=20
>> +void job_transition_to_running(Job *job)
>> +{
>> + JOB_LOCK_GUARD();
>> + job_state_transition_locked(job, JOB_STATUS_RUNNING);
>> +}
>> +
>> void job_transition_to_ready(Job *job)
>> {
>> JOB_LOCK_GUARD();


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD7C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFP8-0002ba-Li; Wed, 26 Aug 2026 11:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1wzFP6-0002bC-Ux
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:19:04 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1wzFP2-00072h-Ub
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787757522; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=L7fxuY9j6ndFHjqtPR9Iu6C6z7PAAL6eA4SFmoC+ZTI=;
 b=f2OU7knvU+mDHaxSTftH8lE/QZeSN2mD/vc85bbOsPTNSSPGDVhl1n/m5QWkxB0Q5spHZ8
 I7huHGSSmHKinrVavXk1TjcQrojZHsHssAJcDAom+dZTHMcaQoCnzVAOrfZpfDU67+ERK5
 5/Y1BECOpSt2Y4mAt/wwCxs3LX5hc6dN6HKlUzKmDgGNpSozGyTH4cJnnvZbH2dMkCnNqD
 d/pkNQOUKor7nMCi5VywSlSBNJ4cYrk3OGk2AkmwZfr/mTRcuIEcfCx3HCX+mNE2joxd5U
 QYeh0wRLKIAT/hsKRyyOvyu7WufThTrFp/7D9W1+95vKSpJNC79b909NgHxnkQ==
Cc: <qemu-devel@nongnu.org>, <farosas@suse.de>, <caixiangfeng@bytedance.com>, 
 <yanfei.xu@bytedance.com>
References: <20260824122655.63646-2-hongmianquan@bytedance.com>
 <aoyYdZj2kEStUTOO@x1.local>
X-Lms-Return-Path: <lba+26a8f03d0+ae1aaf+nongnu.org+hongmianquan@bytedance.com>
To: "Peter Xu" <peterx@redhat.com>
From: "hongmianquan" <hongmianquan@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <aoyYdZj2kEStUTOO@x1.local>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 23:18:28 +0800
Message-Id: <aa4c9982-9a9c-38d4-f6e1-481a086df8ad@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
Subject: Re: [RFC v1] migration/postcopy: fix page_requested leak for
 vhost-user shared pages
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-113.ptr.blmpb.com
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

On 2026/8/25 03:16, Peter Xu wrote:
> On Mon, Aug 24, 2026 at 08:26:56PM +0800, hongmianquan wrote:
>> With postcopy-preempt enabled, a postcopy migration of a guest with a
>> vhost-user device can hang at the very end on the destination, after all
>> pages are transferred (query-migrate: status=3Dpostcopy-active, remainin=
g=3D0).
>>
>> Root cause is an add/del key mismatch on mis->page_requested:
>>
>> - add: a backend fault goes through postcopy_request_shared_page() ->
>>    postcopy_request_page() -> migrate_send_rp_req_pages(), which inserts
>>    the request and bumps page_requested_count keyed by client_addr.
>> - del: qemu_ufd_copy_ioctl() removes the entry and drops the counter
>>    keyed by this QEMU process's host address for the page.
>>
>> client_addr is a VA in the external vhost-user backend's address space a=
nd
>> never equals QEMU's host address, so the removal misses and the counter
>> leaks. postcopy_ram_incoming_cleanup() then waits for it to reach zero
>> forever, which also stalls the source (it waits for the return path).
>>
>> Racing threads:
>>    dst: postcopy_ram_listen_thread -> postcopy_ram_incoming_cleanup ->
>>         qemu_cond_wait_impl              (waits for page_requested_count=
=3D=3D0)
>>         (postcopy_preempt_thread already placed/woke the pages)
>>    src: migration_thread -> migration_completion ->
>>         await_return_path_close_on_source -> qemu_thread_join
>>         (source_return_path_thread blocked in recvmsg)
>>
>> The leak is only triggered when the vhost-user backend faults on a page
>> that has not been received yet: only then does the request take the
>> shared-fault slow path and register an entry in page_requested. If that
>> page is subsequently delivered while the request is still outstanding,
>> its entry is never removed. (Pages already present when the backend
>> faults just take the wake path and never register.) So a run may leak
>> only a few entries (9 of ~244k requests in our repro) yet still hang.
>>
>> Fix: key the request with the same host address the removal uses
>> (rb->host + aligned_rbo) instead of client_addr. The backend wake still
>> happens at placement time via postcopy_wake_shared().
>>
>> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
>> ---
>>   migration/postcopy-ram.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index a3314d3180..98268b3c55 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -992,7 +992,20 @@ int postcopy_request_shared_page(struct PostCopyFD =
*pcfd, RAMBlock *rb,
>>           return postcopy_wake_shared(pcfd, client_addr, rb);
>>       }
>>       /* TODO: support blocktime tracking */
>> -    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
>> +
>> +    /*
>> +     * The page will be placed by qemu_ufd_copy_ioctl(), which removes =
the
>> +     * matching entry from mis->page_requested (and drops
>> +     * page_requested_count) using this QEMU process's host address for=
 the
>> +     * page. Register the request with the same key, rb->host + aligned=
_rbo,
>> +     * not client_addr: client_addr is a VA in the external vhost-user
>> +     * backend's address space and can never equal that host address, s=
o the
>> +     * removal would miss forever, leaking page_requested_count and han=
ging
>> +     * postcopy teardown.
>> +     */
>> +    postcopy_request_page(mis, rb, aligned_rbo,
>> +                          (uint64_t)(uintptr_t)qemu_ram_get_host_addr(r=
b) +
>> +                          aligned_rbo, 0);
>>       return 0;
>>   }
>=20
> True.. this should have been overlooked, thanks for fixing it.
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> I haven't been looking at vhost-user path for years, now looking at it
> again, I do have this feeling that this ->handler() API is a bit awkward
> and too heavy: what we need is a translation of an HVA -> (rb, rb_offset)=
,
> then processing it the same as when the fault was generated from QEMU
> process.  The vhost-user / client code might be more straightforward with=
 a
> ->translate_hva().
>=20
> I'm not sure if you agree with that idea, or would like to work on such a
> cleanup, but if you're a serious vhost-user postcopy user (we don't have =
a
> lot on the list..), feel free to take this if this sounds beneficial.
>=20
> Thanks,
>=20
Thanks for the review.

Just to make sure I got the cleanup right: replace the PostCopyFD
->handler() callback with a lighter ->translate_hva() that only maps the
client fault address to (RAMBlock, rb_offset), and let the shared fault
thread call postcopy_request_shared_page() directly after the translation =
=E2=80=94
i.e. the same path a fault raised by the QEMU process takes. Is that=20
what you have in mind?
We do run vhost-user postcopy, so I'm happy to take this and send the=20
cleanup as a follow-up.

Thanks,


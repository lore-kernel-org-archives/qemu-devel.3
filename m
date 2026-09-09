Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4413C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Hcu-0004Ni-Vg; Wed, 09 Sep 2026 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1x4Hcp-0004NG-P0; Wed, 09 Sep 2026 08:42:04 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1x4Hcn-0005UZ-7K; Wed, 09 Sep 2026 08:42:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8D477435F4;
 Wed, 09 Sep 2026 14:41:48 +0200 (CEST)
Message-ID: <135a0f56-5fe0-4c8b-9970-256d88b52fe2@proxmox.com>
Date: Wed, 9 Sep 2026 14:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Zero block driver state before reopening
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: gerben@altlinux.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
References: <20250310104858.28221-1-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20250310104858.28221-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1788957698950
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Kevin,

Am 10.03.25 um 11:48 AM schrieb Kevin Wolf:
> Block drivers assume in their .bdrv_open() implementation that their
> state in bs->opaque has been zeroed; it is initially allocated with
> g_malloc0() in bdrv_open_driver().
> 
> bdrv_snapshot_goto() needs to make sure that it is zeroed again before
> calling drv->bdrv_open() to avoid that block drivers use stale values.
> 
> One symptom of this bug is VMDK running into a double free when the user
> tries to apply an internal snapshot like 'qemu-img snapshot -a test
> test.vmdk'. This should be a graceful error because VMDK doesn't support
> internal snapshots.
> 
> ==25507== Invalid free() / delete / delete[] / realloc()
> ==25507==    at 0x484B347: realloc (vg_replace_malloc.c:1801)
> ==25507==    by 0x54B592A: g_realloc (gmem.c:171)
> ==25507==    by 0x1B221D: vmdk_add_extent (../block/vmdk.c:570)
> ==25507==    by 0x1B1084: vmdk_open_sparse (../block/vmdk.c:1059)
> ==25507==    by 0x1AF3D8: vmdk_open (../block/vmdk.c:1371)
> ==25507==    by 0x1A2AE0: bdrv_snapshot_goto (../block/snapshot.c:299)
> ==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
> ==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
> ==25507==  Address 0x832f3e0 is 0 bytes inside a block of size 272 free'd
> ==25507==    at 0x4846B83: free (vg_replace_malloc.c:989)
> ==25507==    by 0x54AEAC4: g_free (gmem.c:208)
> ==25507==    by 0x1AF629: vmdk_close (../block/vmdk.c:2889)
> ==25507==    by 0x1A2A9C: bdrv_snapshot_goto (../block/snapshot.c:290)
> ==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
> ==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
> 
> This error was discovered by fuzzing qemu-img.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Denis Rastyogin <gerben@altlinux.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/snapshot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 9c44780e96..22567f1fb9 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -296,6 +296,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>          bdrv_graph_wrunlock();
>  
>          ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
> +        memset(bs->opaque, 0, drv->instance_size);
>          open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
>          qobject_unref(options);
>          if (open_ret < 0) {

this unfortunately causes a regression when loading a snapshot when a
throttle driver is present:

> qemu-system-x86_64: ../block/throttle.c:231: void throttle_drain_end(BlockDriverState *): Assertion `tgm->io_limits_disabled' failed.
> 
> Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
> __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
> warning: 44	./nptl/pthread_kill.c: No such file or directory
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
> #1  0x00007ffff57639ff in __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
> #2  0x00007ffff570ecc2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #3  0x00007ffff56f74ac in __GI_abort () at ./stdlib/abort.c:77
> #4  0x00007ffff56f7420 in __assert_fail_base (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=231, 
>     function=<optimized out>) at ./assert/assert.c:118
> #5  0x00005555560f40b3 in throttle_drain_end (bs=0x5555579da850) at ../block/throttle.c:231
> #6  0x00005555560a5075 in bdrv_do_drained_end (bs=0x5555579da850, parent=0x0) at ../block/io.c:417
> #7  0x00005555560a4f6b in bdrv_drained_end (bs=0x5555579da850) at ../block/io.c:426
> #8  0x000055555605cda1 in bdrv_child_cb_drained_end (child=0x5555579ebff0) at ../block.c:1219
> #9  0x00005555560a422e in bdrv_parent_drained_end_single (c=0x5555579ebff0) at ../block/io.c:76
> #10 0x00005555560ad0fa in bdrv_parent_drained_end (bs=0x5555579deb60, ignore=0x0) at ../block/io.c:91
> #11 0x00005555560a5082 in bdrv_do_drained_end (bs=0x5555579deb60, parent=0x0) at ../block/io.c:419
> #12 0x00005555560a4f6b in bdrv_drained_end (bs=0x5555579deb60) at ../block/io.c:426
> #13 0x000055555605cda1 in bdrv_child_cb_drained_end (child=0x5555579ebe10) at ../block.c:1219
> #14 0x00005555560a422e in bdrv_parent_drained_end_single (c=0x5555579ebe10) at ../block/io.c:76
> #15 0x00005555560ad0fa in bdrv_parent_drained_end (bs=0x5555579e6460, ignore=0x0) at ../block/io.c:91
> #16 0x00005555560a5082 in bdrv_do_drained_end (bs=0x5555579e6460, parent=0x0) at ../block/io.c:419
> #17 0x00005555560a5890 in bdrv_drain_all_end () at ../block/io.c:563
> #18 0x00005555559ae5d8 in load_snapshot (name=0x7fffffffed4f "snap0", vmstate=0x0, has_devices=false, devices=0x0, 
>     errp=0x5555576033d0 <error_fatal>) at ../migration/savevm.c:3562
> #19 0x0000555555dd34a9 in qmp_x_exit_preconfig (errp=0x5555576033d0 <error_fatal>) at ../system/vl.c:2828
> #20 0x0000555555dd5ecc in qemu_init (argc=70, argv=0x7fffffffdec8) at ../system/vl.c:3866
> #21 0x000055555617e12f in main (argc=70, argv=0x7fffffffdec8) at ../system/main.c:71


The bdrv_snapshot_goto() call happens in a drained section, and for the
throttle driver, the opaque object is the ThrottleGroupMember, so the
io_limits_disabled member gets set from 1 to 0 by the memset. And later,
when the drain ends, the assertion triggers.

I'm not sure how to best resolve this. Should there be a method like
bdrv_reset_opaque_after_snapshot_goto() where the throttle driver keeps
the io_limits_disabled number unaffected?

Or is there a safe way to temporarily end and later resume the drain
before/after the close/memset/open?

Or use some other approach?

Best Regards,
Fiona



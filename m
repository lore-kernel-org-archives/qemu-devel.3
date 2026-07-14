Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E64C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcTj-0006zX-GO; Tue, 14 Jul 2026 08:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjcTh-0006z8-Uv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjcTe-0007hS-NX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784032988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jyoBb7a+lFceymOCQpaDOvl2g1Hdsg7SNloRdePKpdY=;
 b=hE+lQl7P0WdOQsl5UaorfGzNFeyNy/Rs2P8Ybgg4wksJgqOpz5bOxNgHEeriAe+U9kKpUu
 tzuQeGOesdMYWI/Iq3WW1fZL/PtAjyZ9xjV/xkfAP04HFrwVUAHbWTmAjlOvAwdRKBYm1t
 u6tHTrZBg0ZHhmeXGU8xJyp7lpPqq9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-NFN2I_QENM-tZT2OuRMh5A-1; Tue,
 14 Jul 2026 08:43:07 -0400
X-MC-Unique: NFN2I_QENM-tZT2OuRMh5A-1
X-Mimecast-MFC-AGG-ID: NFN2I_QENM-tZT2OuRMh5A_1784032986
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6173B19560B7; Tue, 14 Jul 2026 12:43:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F7830001BE; Tue, 14 Jul 2026 12:43:02 +0000 (UTC)
Date: Tue, 14 Jul 2026 14:42:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] hw/block/fdc: report a missing address mark on an empty
 drive
Message-ID: <alYu0zKwtieSGFXo@redhat.com>
References: <20260710113134.43012-1-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710113134.43012-1-christian@quante.one>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Hi Christian,

really nice writeup of the problem, both here and with the additional
details in the Gitlab report. I don't generally care too much for
reviewing floppy patches, but I love this one.

Am 10.07.2026 um 13:31 hat Christian Quante geschrieben:
> READ ID on a drive with no medium terminates normally and returns the
> made-up sector ID left over from the "Pretend we are spinning" emulation.
> The only error path is a data rate mismatch, and media_rate is assigned
> solely by pick_geometry(); it is never reset when the medium is removed.
> A guest that has just ejected a diskette is therefore told that one is
> still present.
> 
> READ and WRITE have a related problem: fd_seek() returns 2 both for
> "track/head out of range" and for "no medium", and fdctrl_start_transfer()
> reports that as ST0 = ABNTERM with ST1 = 0x00.  Without ST1.MA the guest
> cannot tell an absent diskette from a transient error.

Your solution for this one is the only part where I'm not completely
convinced. You keep the ambiguous 2 as a return value from fd_seek(),
and then just perform the same check again in the caller, involving a
second call of blk_is_inserted(). Probably not terrible in practice, but
also not completely elegant.

The straightforward solution I expected would have been adding a new
return code to fd_seek() for the "no medium" case. Is there anything
that makes this harder than it seems at the first sight?

> Fail READ ID with ST0 = ABNTERM and ST1 = MA when the drive is empty, and
> set ST1.MA in the fd_seek() case 2 path when no medium is present.  This
> does not make guests detect the removal -- real hardware never completes
> READ ID on an empty drive, because there are no index pulses, and OS/2 for
> one relies on that timeout -- but it stops the controller from claiming a
> diskette that is not there.
> 
> tests/qtest/fdc-test.c starts QEMU with "-device floppy,id=floppy0" and no
> medium, so the drive is empty for the whole run, and test_read_id asserts a
> normal termination with a fabricated cylinder 8 / head 1.  That contradicts
> its neighbours test_no_media_on_start and test_media_change, which state
> that DSKCHG signals an absent medium.  Insert a medium before READ ID and
> eject it afterwards -- the rewritten test passes before and after this
> change -- and add test_read_id_no_media to cover the empty drive.
> 
> Guests checked, reading and writing, with and without a medium: Linux
> 2.0.34 and 7.0, PC-DOS 7, IBM DOS 5.02, Windows for Workgroups 3.11 and
> OS/2 2.11.  None changes behaviour.  No version of the Linux floppy driver
> from 1.2.13 to master issues READ ID at all -- FD_READID is defined in the
> uapi header for FDRAWCMD users and the driver never sends it -- so Linux
> detects an empty drive by stepping the head and reading DSKCHG instead.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3971
> Signed-off-by: Christian Quante <christian@quante.one>
> ---
>  hw/block/fdc.c         | 29 +++++++++++++++--
>  tests/qtest/fdc-test.c | 73 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 2c1681b7d0..8895e39cb6 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -196,6 +196,12 @@ static void fd_init(FDrive *drv)
>  
>  #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
>  
> +/* Is a diskette present in the drive? */
> +static bool fd_media_present(FDrive *drv)
> +{
> +    return drv->blk != NULL && blk_is_inserted(drv->blk);
> +}
> +
>  static int fd_sector_calc(uint8_t head, uint8_t track, uint8_t sect,
>                            uint8_t last_sect, uint8_t num_sides)
>  {
> @@ -1476,8 +1482,15 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
>                                    NUM_SIDES(cur_drv)));
>      switch (fd_seek(cur_drv, kh, kt, ks, fdctrl->config & FD_CONFIG_EIS)) {
>      case 2:
> -        /* sect too big */
> -        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, 0x00, 0x00);
> +        /*
> +         * Track/head out of range, or no medium at all.  Only the latter can
> +         * be told apart by the guest, through ST1.MA: with no diskette in the
> +         * drive there is no address mark to be found.  Guests that
> +         * distinguish an absent medium from an unreadable one rely on this.
> +         */
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM,
> +                             fd_media_present(cur_drv) ? 0x00 : FD_SR1_MA,
> +                             0x00);
>          fdctrl->fifo[3] = kt;
>          fdctrl->fifo[4] = kh;
>          fdctrl->fifo[5] = ks;
> @@ -2303,6 +2316,18 @@ static void fdctrl_result_timer(void *opaque)
>      FDCtrl *fdctrl = opaque;
>      FDrive *cur_drv = get_cur_drv(fdctrl);
>  
> +    /*
> +     * An empty drive has no address marks to read.  Completing READ ID
> +     * successfully, with the made-up sector ID left over from the "spinning"
> +     * emulation below, tells the guest that a diskette is still present after
> +     * it has been ejected.  The only error path left was a data rate mismatch,
> +     * and media_rate is never reset when the medium is removed.
> +     */
> +    if (!fd_media_present(cur_drv)) {
> +        FLOPPY_DPRINTF("read id on empty drive\n");
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_MA, 0x00);
> +        return;
> +    }
>      /* Pretend we are spinning.
>       * This is needed for Coherent, which uses READ ID to check for
>       * sector interleaving.
> diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
> index 1b37a8a4d2..fa57a8b7cf 100644
> --- a/tests/qtest/fdc-test.c
> +++ b/tests/qtest/fdc-test.c
> @@ -64,6 +64,12 @@ enum {
>  
>      DSKCHG  = 0x80,
>  };
> +enum {
> +    ST0_IC_MASK  = 0xc0,    /* interrupt code */
> +    ST0_IC_ABNTERM = 0x40,  /* abnormal termination */
> +
> +    ST1_MA       = 0x01,    /* missing address mark */
> +};
>  
>  static char *test_image;
>  
> @@ -270,6 +276,21 @@ static void test_cmos(void)
>      g_assert(cmos == 0x40 || cmos == 0x50);
>  }
>  
> +static void media_insert(void)
> +{
> +    qtest_qmp_assert_success(global_qtest,
> +                             "{'execute':'blockdev-change-medium', 'arguments':{"
> +                             " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
> +                             test_image);
> +}
> +
> +static void media_eject(void)
> +{
> +    qtest_qmp_assert_success(global_qtest,
> +                             "{'execute':'eject', 'arguments':{"
> +                             " 'id':'floppy0' }}");
> +}
> +
>  static void test_no_media_on_start(void)
>  {
>      uint8_t dir;
> @@ -301,10 +322,7 @@ static void test_media_insert(void)
>  
>      /* Insert media in drive. DSKCHK should not be reset until a step pulse
>       * is sent. */
> -    qtest_qmp_assert_success(global_qtest,
> -                             "{'execute':'blockdev-change-medium', 'arguments':{"
> -                             " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
> -                             test_image);
> +    media_insert();
>  
>      dir = inb(FLOPPY_BASE + reg_dir);
>      assert_bit_set(dir, DSKCHG);
> @@ -333,9 +351,7 @@ static void test_media_change(void)
>  
>      /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
>       * reset the bit. */
> -    qtest_qmp_assert_success(global_qtest,
> -                             "{'execute':'eject', 'arguments':{"
> -                             " 'id':'floppy0' }}");
> +    media_eject();
>  
>      dir = inb(FLOPPY_BASE + reg_dir);
>      assert_bit_set(dir, DSKCHG);
> @@ -414,6 +430,12 @@ static void test_read_id(void)
>      uint8_t st0;
>      uint8_t msr;
>  
> +    /*
> +     * READ ID reads the address mark of the sector currently under the head,
> +     * so it needs a medium.  The preceding tests left the drive empty.

Just as an aside, this doesn't really work like this because you can
select specific test cases to run, so we shouldn't have any dependencies
between test cases. But this is a preexisting problem in fdc-test, so I
don't expect you to fix it here.

> +     */
> +    media_insert();
> +
>      /* Seek to track 0 and check with READ ID */
>      send_seek(0);
>  
> @@ -491,6 +513,42 @@ static void test_read_id(void)
>      g_assert_cmpint(cyl, ==, 8);
>      g_assert_cmpint(head, ==, 1);
>      g_assert_cmpint(st0, ==, head << 2);
> +
> +    /* Leave the drive as the following tests expect to find it. */
> +    media_eject();
> +}
> +
> +/*
> + * An empty drive spins no diskette, so READ ID finds no address mark and must
> + * terminate abnormally.  Reporting success (with a made-up sector ID) would
> + * tell the guest that a medium is still present after it has been ejected.
> + */
> +static void test_read_id_no_media(void)
> +{
> +    uint8_t drive = 0;
> +    uint8_t head = 0;
> +    uint8_t st0, st1;
> +
> +    floppy_send(CMD_READ_ID);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    floppy_send(head << 2 | drive);
> +
> +    while (!get_irq(FLOPPY_IRQ)) {
> +        clock_step(1000000000LL / 50);
> +    }
> +
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv();                  /* ST2 */
> +    floppy_recv();                  /* cylinder */
> +    floppy_recv();                  /* head */
> +    floppy_recv();                  /* sector */
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv();                  /* sector size */
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_MA, ==, ST1_MA);
>  }
>  
>  static void test_read_no_dma_1(void)
> @@ -625,6 +683,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/fdc/sense_interrupt", test_sense_interrupt);
>      qtest_add_func("/fdc/relative_seek", test_relative_seek);
>      qtest_add_func("/fdc/read_id", test_read_id);
> +    qtest_add_func("/fdc/read_id_no_media", test_read_id_no_media);
>      qtest_add_func("/fdc/verify", test_verify);
>      qtest_add_func("/fdc/media_insert", test_media_insert);
>      qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);

One more thing I noticed during review: fdctrl_handle_readid() never
seems to call SET_CUR_DRV(), so are we potentially checking the wrong
drive? It looked suspicious to me anyway. (Out of scope for this patch,
of course, but could be a separate fix if it's real.)

Kevin



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB368C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWbi-0002er-Hg; Mon, 24 Aug 2026 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyWbg-0002cI-MW
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyWbd-0008VX-Re
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787585340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ox/qACKY0XwRdErkUd4TcxRA6mTg+5b3fXR+DhuqPhE=;
 b=Claz/F/h4jSGFRAR+EAhs0fshxhd/iln4Ph7cx5m/2S+pik1vfmlnLaA0D5S6RiIKEcSQa
 J9M12m3CCWwwnEzMzyA9GUvEgs7JTa/5L+3oeo9TDjHYGsEY3dW3fvvtDcQAnjgT/KH21p
 /Daz8Kgk1Gof77hhjsWHc0gORx3JYR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-XGxihU_RNpy-yW3DqufNzg-1; Mon,
 24 Aug 2026 11:28:57 -0400
X-MC-Unique: XGxihU_RNpy-yW3DqufNzg-1
X-Mimecast-MFC-AGG-ID: XGxihU_RNpy-yW3DqufNzg_1787585334
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A97DC19775FC; Mon, 24 Aug 2026 15:28:53 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2140E7D9; Mon, 24 Aug 2026 15:28:47 +0000 (UTC)
Date: Mon, 24 Aug 2026 16:28:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 6/8] tests/qtest: add test case for fdc sector overflow
Message-ID: <aoxjLcRuc7sHnIPz@redhat.com>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
 <20260824-fixes-for-11-2-v2-6-352c6b890402@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824-fixes-for-11-2-v2-6-352c6b890402@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 24, 2026 at 04:24:53PM +0100, Alex Bennée wrote:
> Add a test case for #3800 where we check that the last sector is
> properly bounded by the physical media that is inserted.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/issues/3800
> AI-used-for: initial draft of test

Wasn't the change in AI policy still pending a new patch
proposal from Paolo ? 

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/qtest/fdc-test.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 241 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
> index 1e1dd8659d0..3f2642fe671 100644
> --- a/tests/qtest/fdc-test.c
> +++ b/tests/qtest/fdc-test.c
> @@ -31,7 +31,8 @@
>  #define DRIVE_FLOPPY_BLANK \
>      "-drive if=floppy,file=null-co://,file.read-zeroes=on,format=raw,size=1440k"
>  
> -#define TEST_IMAGE_SIZE 1440 * 1024
> +#define TEST_IMAGE_1440KB (1440 * 1024)
> +#define TEST_IMAGE_720KB (720 * 1024)
>  
>  #define FLOPPY_BASE 0x3f0
>  #define FLOPPY_IRQ 6
> @@ -49,8 +50,11 @@ enum {
>  enum {
>      CMD_SENSE_INT           = 0x08,
>      CMD_READ_ID             = 0x0a,
> +    CMD_FORMAT_TRACK        = 0x4d,
>      CMD_SEEK                = 0x0f,
>      CMD_VERIFY              = 0x16,
> +    CMD_SAVE                = 0x2e,
> +    CMD_RESTORE             = 0x4e,
>      CMD_READ                = 0xe6,
>      CMD_RELATIVE_SEEK_OUT   = 0x8f,
>      CMD_RELATIVE_SEEK_IN    = 0xcf,
> @@ -69,9 +73,11 @@ enum {
>      ST0_IC_ABNTERM = 0x40,  /* abnormal termination */
>  
>      ST1_MA       = 0x01,    /* missing address mark */
> +    ST1_EC       = 0x80,    /* end of cylinder / sector past last_sect */
>  };
>  
>  static char *test_image;
> +static char *test_image_720k;
>  
>  #define assert_bit_set(data, mask) g_assert_cmphex((data) & (mask), ==, (mask))
>  #define assert_bit_clear(data, mask) g_assert_cmphex((data) & (mask), ==, 0)
> @@ -276,12 +282,17 @@ static void test_cmos(void)
>      g_assert(cmos == 0x40 || cmos == 0x50);
>  }
>  
> -static void media_insert(void)
> +static void media_insert_path(const char *path)
>  {
>      qtest_qmp_assert_success(global_qtest,
>                               "{'execute':'blockdev-change-medium', 'arguments':{"
>                               " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
> -                             test_image);
> +                             path);
> +}
> +
> +static void media_insert(void)
> +{
> +    media_insert_path(test_image);
>  }
>  
>  static void media_eject(void)
> @@ -586,6 +597,222 @@ static void test_verify(void)
>      g_assert(ret == 0);
>  }
>  
> +/*
> + * Query cur_drv->last_sect using the SAVE command (CMD_SAVE, 0x2e).
> + * Byte 8 of the 15 result bytes returned by CMD_SAVE holds last_sect.
> + */
> +static uint8_t get_lastsect(void)
> +{
> +    uint8_t res[15];
> +    int i;
> +
> +    floppy_send(CMD_SAVE);
> +    for (i = 0; i < 15; i++) {
> +        res[i] = floppy_recv();
> +    }
> +    return res[8];
> +}
> +
> +/*
> + * Attempt to set cur_drv->last_sect directly using the RESTORE command
> + * (CMD_RESTORE, 0x4e).
> + * While the 82078 datasheet describes RESTORE for restoring a previously
> + * saved state, a guest can issue raw RESTORE commands with arbitrary
> + * parameters without having issued SAVE. Parameter byte 9 is used by the
> + * controller to restore cur_drv->last_sect.
> + */
> +static void fake_lastsect(uint8_t last_sect)
> +{
> +    floppy_send(CMD_RESTORE);
> +    floppy_send(0); /* fifo[1] */
> +    floppy_send(0); /* fifo[2] */
> +    floppy_send(0); /* fifo[3]: drv0 track */
> +    floppy_send(0); /* fifo[4]: drv1 track */
> +    floppy_send(0); /* fifo[5]: drv2 track */
> +    floppy_send(0); /* fifo[6]: drv3 track */
> +    floppy_send(0); /* fifo[7]: timer0 */
> +    floppy_send(0); /* fifo[8]: timer1 */
> +    floppy_send(last_sect); /* fifo[9]: last_sect */
> +    floppy_send(0); /* fifo[10]: lock/perpendicular */
> +    floppy_send(0); /* fifo[11]: config */
> +    floppy_send(0); /* fifo[12]: precomp_trk */
> +    floppy_send(0); /* fifo[13]: pwrd */
> +    floppy_send(0); /* fifo[14] */
> +    floppy_send(0); /* fifo[15] */
> +    floppy_send(0); /* fifo[16] */
> +    floppy_send(0); /* fifo[17] */
> +}
> +
> +static void send_format_track(uint8_t drive, uint8_t head, uint8_t last_sect,
> +                              uint8_t *st0_out, uint8_t *st1_out)
> +{
> +    uint8_t st0, st1;
> +
> +    floppy_send(CMD_FORMAT_TRACK);
> +    floppy_send((head << 2) | drive);
> +    floppy_send(2);          /* 512 bytes per sector */
> +    floppy_send(last_sect);  /* sectors per track */
> +    floppy_send(0x1b);       /* GAP length */
> +    floppy_send(0x00);       /* filler byte */
> +
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv(); /* st2 */
> +    floppy_recv(); /* track */
> +    floppy_recv(); /* head */
> +    floppy_recv(); /* sect */
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv(); /* sz */
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +
> +    if (st0_out) {
> +        *st0_out = st0;
> +    }
> +    if (st1_out) {
> +        *st1_out = st1;
> +    }
> +}
> +
> +/*
> + * Test that guest cannot set last_sect beyond the probed media size
> + * via RESTORE or FORMAT TRACK commands (gitlab issue #3800).
> + */
> +static void test_last_sect_bounds(void)
> +{
> +    uint8_t st0, st1;
> +
> +    /* Start with 1.44 MB media inserted (last_sect = 18) */
> +    media_insert();
> +    send_seek(1);
> +    send_seek(0);
> +
> +    /* Valid last_sect values (<= 18) should succeed */
> +    fake_lastsect(18);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(get_lastsect(), ==, 18);
> +
> +    fake_lastsect(9);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(get_lastsect(), ==, 9);
> +
> +    /* Restoring to the default 18 */
> +    fake_lastsect(18);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(get_lastsect(), ==, 18);
> +
> +    /* Invalid last_sect value (> 18) must fail */
> +    fake_lastsect(19);
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv(); /* st2 */
> +    floppy_recv(); /* track */
> +    floppy_recv(); /* head */
> +    floppy_recv(); /* sect */
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv(); /* sz */
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    /* Verify last_sect was not changed to 19 */
> +    g_assert_cmpint(get_lastsect(), ==, 18);
> +
> +    /* FORMAT TRACK with valid last_sect (18) should succeed */
> +    send_format_track(0, 0, 18, &st0, &st1);
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, 0);
> +    g_assert_cmpint(st1, ==, 0);
> +
> +    /* FORMAT TRACK with invalid last_sect (19) must fail */
> +    send_format_track(0, 0, 19, &st0, &st1);
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    /* Change media to 720 kB floppy (last_sect = 9) */
> +    media_eject();
> +    media_insert_path(test_image_720k);
> +    send_seek(1);
> +    send_seek(0);
> +
> +    /* Probed geometry now has last_sect = 9 */
> +    fake_lastsect(9);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(get_lastsect(), ==, 9);
> +
> +    /* Values exceeding 9 (e.g. 10 or 18) must now fail */
> +    fake_lastsect(10);
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv();
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    fake_lastsect(18);
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv();
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    /* FORMAT TRACK on 720 kB floppy */
> +    send_format_track(0, 0, 9, &st0, &st1);
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, 0);
> +    g_assert_cmpint(st1, ==, 0);
> +
> +    send_format_track(0, 0, 10, &st0, &st1);
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    send_format_track(0, 0, 18, &st0, &st1);
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    /*
> +     * Change back to 1.44 MB floppy and verify last_sect = 18 is allowed
> +     * again.
> +     */
> +    media_eject();
> +    media_insert();
> +    send_seek(1);
> +    send_seek(0);
> +
> +    fake_lastsect(18);
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(get_lastsect(), ==, 18);
> +
> +    fake_lastsect(19);
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    st0 = floppy_recv();
> +    st1 = floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    floppy_recv();
> +    g_assert(get_irq(FLOPPY_IRQ));
> +    floppy_recv();
> +    g_assert(!get_irq(FLOPPY_IRQ));
> +    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
> +    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
> +
> +    /* Leave drive empty */
> +    media_eject();
> +}
> +
>  /* success if no crash or abort */
>  static void fuzz_registers(void)
>  {
> @@ -661,10 +888,16 @@ int main(int argc, char **argv)
>      int fd;
>      int ret;
>  
> -    /* Create a temporary raw image */
> +    /* Create temporary raw images */
>      fd = g_file_open_tmp("qtest.XXXXXX", &test_image, NULL);
>      g_assert(fd >= 0);
> -    ret = ftruncate(fd, TEST_IMAGE_SIZE);
> +    ret = ftruncate(fd, TEST_IMAGE_1440KB);
> +    g_assert(ret == 0);
> +    close(fd);
> +
> +    fd = g_file_open_tmp("qtest720.XXXXXX", &test_image_720k, NULL);
> +    g_assert(fd >= 0);
> +    ret = ftruncate(fd, TEST_IMAGE_720KB);
>      g_assert(ret == 0);
>      close(fd);
>  
> @@ -686,6 +919,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);
>      qtest_add_func("/fdc/read_no_dma_18", test_read_no_dma_18);
>      qtest_add_func("/fdc/read_no_dma_19", test_read_no_dma_19);
> +    qtest_add_func("/fdc/last_sect_bounds", test_last_sect_bounds);
>      qtest_add_func("/fdc/fuzz-registers", fuzz_registers);
>      qtest_add_func("/fdc/fuzz/cve_2021_20196", test_cve_2021_20196);
>      qtest_add_func("/fdc/fuzz/cve_2021_3507", test_cve_2021_3507);
> @@ -696,6 +930,8 @@ int main(int argc, char **argv)
>      qtest_end();
>      unlink(test_image);
>      g_free(test_image);
> +    unlink(test_image_720k);
> +    g_free(test_image_720k);
>  
>      return ret;
>  }
> 
> -- 
> 2.47.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



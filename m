Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71862C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u27JJ-0005Fm-Ld; Tue, 08 Apr 2025 07:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u27If-0005Ac-M0
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u27Id-0007yZ-AP
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744112365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIAtQEYrWFYwySnMP0BU6rNLD7hDbgkMcRtopEPE+G0=;
 b=CcraR4842OoIznqGkILHHHhnYinJDGeVmSoJEGjbhmVpl7wMnz3QdVii4LnBTb3tyuClOH
 62CvqsZ5nPxMP8TkEnmrtzi7QJqOseAyyr84oEyx1E5JHIRuTCmPH5VqD3ZdoOpVxqaPTy
 1s7J4iN7RmQ0BCe6K76Sc9fr/WWreac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-47SyR3ndOiiQ2GHI5uxC-A-1; Tue,
 08 Apr 2025 07:39:21 -0400
X-MC-Unique: 47SyR3ndOiiQ2GHI5uxC-A-1
X-Mimecast-MFC-AGG-ID: 47SyR3ndOiiQ2GHI5uxC-A_1744112359
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB979180AF57; Tue,  8 Apr 2025 11:39:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BB24180B487; Tue,  8 Apr 2025 11:39:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE4CB21E675E; Tue, 08 Apr 2025 13:39:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Steven
 Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  qemu-block <qemu-block@nongnu.org>,  Troy Lee
 <troy_lee@aspeedtech.com>
Subject: Configuring onboard devices, in particular memory contents (was:
 [PATCH v1 0/1] hw/misc/aspeed_sbc: Implement OTP memory and controller)
In-Reply-To: <254844fd-15b8-47b2-9203-b19f8279c757@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 7 Apr 2025 11:55:17 +0200")
References: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
 <9171629d-a386-4971-802b-cd26cc42e194@kaod.org>
 <99497c16-cee4-4098-9971-f61ef7174412@linaro.org>
 <c193e64d-6ce7-4e5c-bb2a-3e1d3f4f143e@kaod.org>
 <SI6PR06MB7631DDEA18B197B4C343386DF7AA2@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <254844fd-15b8-47b2-9203-b19f8279c757@kaod.org>
Date: Tue, 08 Apr 2025 13:39:05 +0200
Message-ID: <877c3ulw6e.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello Kane,
>
> + Markus (for ebc29e1beab0 implementation)
>
> On 4/7/25 09:33, Kane Chen wrote:
>> Hi C=C3=A9dric/Philippe,
>> OTP (One-Time Programmable) memory is a type of non-volatile memory
>> in which each bit can be programmed only once. It is typically used
>> to store critical and permanent information, such as the chip ID and
>> secure boot keys. The structure and behavior of OTP memory are
>> consistent across both the AST1030 and AST2600 platforms.
>> As Philippe pointed out, this proposal models the OTP memory as a
>> flash device and utilizes a block backend for persistent storage. In
>> contrast, existing implementations such as NPCM7xxOTPState,
>> BCM2835OTPState, and SiFiveUOTPState expose OTP memory via MMIO and
>> always initialize it in a blank state.=20
>
> AFAIU, Aspeed SBC is also MMIO based or is there another device,
> an eeprom, accessible through an external bus ? How is it
> implemented in HW ?
>
>> The goal of this design is to
>> allow the guest system to boot with a pre-configured OTP memory
>> state.=20
>
> Yes. This is a valid request. It's not the first time we've had
> this kind of requests. The initial content of EEPROM devices are
> an example and some machines, like the rainier, have a lot.
>
> If the device can be defined on the command line, like would be
> an EEPROM device attached to an I2C bus or a flash device attached
> to a SPI bus, we can use a 'drive' property. Something like :
>
>   qemu-system-arm -M ast2600-evb \
>       -blockdev node-name=3Dfmc0,driver=3Dfile,filename=3D/path/to/fmc0.i=
mg \
>       -device mx66u51235f,bus=3Dssi.0,cs=3D0x0,drive=3Dfmc0 \
>       -blockdev node-name=3Dfmc1,driver=3Dfile,filename=3D/path/to/fmc1.i=
mg \
>       -device mx66u51235f,bus=3Dssi.0,cs=3D0x1,drive=3Dfmc1 \
>       -blockdev node-name=3Dspi1,driver=3Dfile,filename=3D/path/to/spi1.i=
mg \
>       -device mx66u51235f,cs=3D0x0,bus=3Dssi.1,drive=3Dspi1 \
>       ...
>
> However, the Aspeed SBC device is a platform device and it makes
> things more complex : it can not be created on the command line,
> it is directly created by the machine and the soc and passing
> device properties to specify a blockdev it is not possible :
>
>   qemu-system-arm -M ast2600-evb \
>       -blockdev node-name=3Dotpmem,driver=3Dfile,filename=3D/path/to/otpm=
em.img \
>       -device aspeed-sbc,drive=3Dotpmem \
>       ...

Configuring onboard devices is an old problem, and so far we have failed
at solving it adequately.

-device / device_add let you configure the new device in a general way,
but these work only for device the user creates, not for devices the
board creates automatically.

We have a bunch of ad hoc and mostly ancient ways to configure them, but
they're all limited.  For example:

* A number of old command line options, such as -drive, -serial, -net
  nic, create device backends and additionally deposit configuration in
  some global table the board may elect to use however it sees fit.  The
  intended use is to create frontends connected to these backends.

  Some boards error out when they can't honor something in the table.
  Others silently ignore parts of the table, or all of it.  Bad UI.

  Device configuration the table doesn't support is not accessible this
  way.  If you extend the table (and the associated option) to provide
  access to some device-specific configuration, all the other devices
  will silently ignore the new configuration bits.  Again, bad UI.

  There's another serious issue with block devices: -drive is obsolete
  for configurating complex block backends.  But its replacement
  -blockdev is for backend configuration only.  If you use -blockdev,
  you can't add to the table.

* Command line option -global lets you change property defaults.  This
  can be used to configure an onboard device as long as it is the only
  such device in the system.  Limited use, and also bad UI.

A modern attempt at a solution is to have machine properties alias
properties of onboard devices, so you can specify them with -machine.
For instance, a few machines expose the "drive" property of two onboard
pflash devices as machine properties "pflash0" and "pflash1".

Commits

    e0561e60f170 (hw/arm/virt: Support firmware configuration with -blockde=
v)
    ebc29e1beab0 (pc: Support firmware configuration with -blockdev)=20

explain this in a lot more detail in their commit messages.

Sadly, this solution does not scale.  Adding alias properties to the
machine object is work, sometimes a lot of work (evidence: the two
commits above).  There are simply too many onboard devices with too many
properties to all manually alias.

Of course, even an insufficiently general / scalable solution like this
one can work well enough for specific cases.

>> To support this, the OTP memory is backed by a file,
>> simulating persistent flash behavior.
>
> The idea is good but the implementation is problematic.
>
>     +static BlockBackend *init_otpmem(int64_t size_bytes)
>     +{
>     +    Error *local_err =3D NULL;
>     +    BlockDriverState *bs =3D NULL;
>     +    BlockBackend *blk =3D NULL;
>     +    bool image_created =3D false;
>     +    QDict *options;
>     +    uint32_t i, odd_def =3D 0xffffffff, even_def =3D 0, *def;
>     +
>     +    if (!g_file_test(OTP_FILE_PATH, G_FILE_TEST_EXISTS)) {
>     +        bdrv_img_create(OTP_FILE_PATH, "raw", NULL, NULL,
>     +                        NULL, size_bytes, 0, true, &local_err);
>     +        if (local_err) {
>     +            qemu_log_mask(LOG_GUEST_ERROR,
>     +                          "%s: Failed to create image %s: %s\n",
>     +                          __func__, OTP_FILE_PATH,
>     +                          error_get_pretty(local_err));
>     +            error_free(local_err);
>     +            return NULL;
>     +        }
>     +        image_created =3D true;
>     +    }
>     +
>     +    blk =3D blk_new(qemu_get_aio_context(),
>     +                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
>     +                  0);
>     +    if (!blk) {
>     +        qemu_log_mask(LOG_GUEST_ERROR,
>     +                      "%s: Failed to create BlockBackend\n",
>     +                      __func__);
>     +        return NULL;
>     +    }
>     +
>     +    options =3D  qdict_new();
>     +    qdict_put_str(options, "driver", "raw");
>     +    bs =3D bdrv_open(OTP_FILE_PATH, NULL, options, BDRV_O_RDWR, &loc=
al_err);
>     +    if (local_err) {
>     +        qemu_log_mask(LOG_GUEST_ERROR,
>     +                      "%s: Failed to create OTP memory, err =3D %s\n=
",
>     +                      __func__, error_get_pretty(local_err));
>     +        blk_unref(blk);
>     +        error_free(local_err);
>     +        return NULL;
>     +    }
>     +
>     +    blk_insert_bs(blk, bs, &local_err);
>     +    if (local_err) {
>     +        qemu_log_mask(LOG_GUEST_ERROR,
>     +                      "%s: Failed to insert OTP memory to SBC, err =
=3D %s\n",
>     +                      __func__, error_get_pretty(local_err));
>     +        bdrv_unref(bs);
>     +        blk_unref(blk);
>     +        error_free(local_err);
>     +        return NULL;
>     +    }
>     +    bdrv_unref(bs);
>     ...
>
> IMO, this is low level block code that a device model shouldn't have
> to deal with. A 'drive' should be used instead. Now, if the qemu-block
> maintainers are OK with it, we need their approval.

Using block backends to specify the contents of a memory device is a bit
of a hack.  However, it's the hacky solution we use, and until we have a
better solution, new code is well advised to stick to the same hacky
solution we use in existing code.

Why is it a bit of a hack?  Well, memory isn't a block device.  For
read-only memory, all we want from the block device is slurping in some
image in its entirety.  We're not interesting in reading parts, or
writing at all.  For writable memory, we are interested in writing, but
there's often a awkward translation to block device blocks.

>  > The OTP memory access flow is as follows:
>> 1. The guest issues a read or write OTP command to the Secure Boot
>>     Controller (SBC)
>> 2. The SBC triggers the corresponding operation in the OTP controller
>> 3. The SBC returns the result to the guest
>> Since the guest interacts with OTP memory exclusively through the
>> SBC, the OTP logic is implemented within aspeed_sbc.c.
>> If there are existing architectural guidelines or design patterns
>> that should be followed for modeling OTP devices, I would greatly
>> appreciate your feedback. I am happy to revise the implementation
>> accordingly and submit updated patches for further review.
>
> Adding a 'drive' property to the aspeed-sbc model shouldn't change
> too much the proposal and it will remove the init_otpmem() routine,
> which is problematic.
>
> Then, we need to find a way to set the 'drive' property of the
> aspeed-sbc model. I suggest using the same method of the edk2 flash
> devices of the q35 machine. See ebc29e1beab0. Setting a machine
> option would set the drive. Something like :
>
>   qemu-system-arm -M ast2600-evb,otpmem=3Dotpmem-drive \
>       -blockdev node-name=3Dotpmem,driver=3Dfile,filename=3D/path/to/otpm=
em.img \
>       ...
>
> This machine option would only be defined for machine types needing
> it.

I don't love this solution, but it's what we use elsewhere.  I think
C=C3=A9dric is right.



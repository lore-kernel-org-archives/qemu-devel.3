Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46473FA372E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp1fm-0006x6-Aq; Fri, 13 Sep 2024 04:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1fj-0006w5-7z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1fh-0006sV-K9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726216132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxSry1MfYHkHSFlioYpUCGX6PPcgXFEOatqOEdW1NwM=;
 b=XRq6cG7FAYrW0yHi3fxFtHYwxC2zby5wqwHw1wBIEcvP5yaD8NkcXiLIu8cptjnBiw6Y1U
 /92Dg75WbO96GELQ+k1V6tbgmOm4F4VfXDi60nkNQpZc6Je2yeBi7NyOB0Nce/J4F9R4SA
 fST+IlQR1394lj+yXHHsyy6+55Tffr0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-3yLUk0GDMHOfMGEnTpxprw-1; Fri,
 13 Sep 2024 04:28:48 -0400
X-MC-Unique: 3yLUk0GDMHOfMGEnTpxprw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 683A31956096; Fri, 13 Sep 2024 08:28:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC5AB3001D13; Fri, 13 Sep 2024 08:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FC5121E6A28; Fri, 13 Sep 2024 10:28:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
In-Reply-To: <CAFEAcA_Yfcjuz+3KfiKPDY2aVU1OuJ3B-9q9F82-fGCS9PTi+Q@mail.gmail.com>
 (Peter Maydell's message of "Mon, 9 Sep 2024 16:30:29 +0100")
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
 <CAFEAcA_Yfcjuz+3KfiKPDY2aVU1OuJ3B-9q9F82-fGCS9PTi+Q@mail.gmail.com>
Date: Fri, 13 Sep 2024 10:28:43 +0200
Message-ID: <87bk0s2c04.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 3 Sept 2024 at 21:04, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> sd_set_cb() was only used by omap2_mmc_init() which
>> got recently removed. Time to remove it. For historical
>> background on the me_no_qdev_me_kill_mammoth_with_rocks
>> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
>> thing created by sd_init()").
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  include/hw/sd/sdcard_legacy.h |  1 -
>>  hw/sd/sd.c                    | 30 ++++--------------------------
>>  2 files changed, 4 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy=
.h
>> index 0dc3889555..a121232560 100644
>> --- a/include/hw/sd/sdcard_legacy.h
>> +++ b/include/hw/sd/sdcard_legacy.h
>> @@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
>>  int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
>>  void sd_write_byte(SDState *card, uint8_t value);
>>  uint8_t sd_read_byte(SDState *card);
>> -void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
>>
>>  /* sd_enable should not be used -- it is only used on the nseries board=
s,
>>   * where it is part of a broken implementation of the MMC card slot swi=
tch
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index a140a32ccd..8a30c61ce0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -112,10 +112,6 @@ typedef struct SDProto {
>>  struct SDState {
>>      DeviceState parent_obj;
>>
>> -    /* If true, created by sd_init() for a non-qdevified caller */
>> -    /* TODO purge them with fire */
>> -    bool me_no_qdev_me_kill_mammoth_with_rocks;
>> -
>
> Should we also remove the sd_init() function in this patch
> (or patchset)? It was only used by the omap-mmc, and it's
> because we have no uses of it that we can get rid of this kludge.

sd_init() is a legacy initialization function for use by non-qdevified
callers.  I'd *love* to finally get rid of it.  However, there seems to
be a use left in tree even after "[PATCH for-9.2 00/53] arm: Drop
deprecated boards": omap_mmc_init(), used by sx1_init() via via
omap310_mpu_init().  This is machines sx1 and sx1-v1.

Ignorant question: can we deprecate these?



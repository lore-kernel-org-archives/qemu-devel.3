Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB722CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 10:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqqlT-0001bX-LI; Tue, 26 Aug 2025 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqqlR-0001bJ-Jm
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqqlM-0005la-Qw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756203522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2a8mHPyqv/0hunPYdMnHGle9NftqR6JhbRsjc0Tl258=;
 b=WT+43PuQZt5UQpgwG6YbP58/801u2IbrAWph/W9850EDQfvcr0eN7j/n8l9m0VPZudfeaY
 rBZ4tau3JzjwAuUbhXWwvZLHNQAAQyEKTwiqqzqtJgfwn3GH4sp3n2S227YChq0/FE/lGr
 weCo1Rg9UuJ5oy11ojV5O5qrQMnCjoY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-DTiJozz2PDK3yjo3LhshcA-1; Tue,
 26 Aug 2025 06:18:40 -0400
X-MC-Unique: DTiJozz2PDK3yjo3LhshcA-1
X-Mimecast-MFC-AGG-ID: DTiJozz2PDK3yjo3LhshcA_1756203519
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF1B19352F1; Tue, 26 Aug 2025 10:18:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA2E21954B02; Tue, 26 Aug 2025 10:18:35 +0000 (UTC)
Date: Tue, 26 Aug 2025 11:18:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
Message-ID: <aK2J8GFi7hRdK9Nq@redhat.com>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
 <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
 <97fce5d7-eb6d-4698-950e-94d5468d5696@siemens.com>
 <c9f0e2e0-d533-4aa5-944e-cc5f0da30645@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9f0e2e0-d533-4aa5-944e-cc5f0da30645@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 25, 2025 at 06:30:52PM +0200, Philippe Mathieu-Daudé wrote:
> +Dan
> 
> On 25/8/25 18:12, Jan Kiszka wrote:
> > On 25.08.25 11:47, Philippe Mathieu-Daudé wrote:
> > > Hi Jan,
> > > 
> > > On 24/8/25 09:18, Jan Kiszka wrote:
> > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > 
> > > > Implement correct setting of the MAC field when passing RPMB frames back
> > > > to the guest. Also check the MAC on authenticated write requests.
> > > > 
> > > > As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
> > > > register the eMMC class if that is available.
> > > > 
> > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > ---
> > > >    hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 89 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > > @@ -3122,6 +3201,7 @@ static const TypeInfo sd_types[] = {
> > > >            .parent         = TYPE_SD_CARD,
> > > >            .class_init     = sd_spi_class_init,
> > > >        },
> > > > +    /* must be last element */
> > > >        {
> > > >            .name           = TYPE_EMMC,
> > > >            .parent         = TYPE_SDMMC_COMMON,
> > > > @@ -3129,4 +3209,12 @@ static const TypeInfo sd_types[] = {
> > > >        },
> > > >    };
> > > >    -DEFINE_TYPES(sd_types)
> > > > +static void sd_register_types(void)
> > > > +{
> > > > +    int num = ARRAY_SIZE(sd_types);
> > > > +    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
> > > > +        num--;
> > > 
> > > Instead, expose RPMB feature in CSD when HMAC supported?
> > > 
> > > Something in emmc_set_ext_csd() in the lines of:
> > > 
> > >    if (qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
> > >        sd->ext_csd[EXT_CSD_REV] = 5;
> > >        sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
> > >        sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
> > >    } else {
> > >        sd->ext_csd[EXT_CSD_REV] = 3;
> > >    }
> > 
> > I need to check if revision 5 still had RPMB as optional (current ones
> > definitely require it), but I don't think rolling back to revision 3
> > would be good idea. If start to add more features from newer revisions,
> > that may cause even more weird results from the user perspective. I'm
> > not saying we are fully compliant in one or the other version, rather
> > that we need to work towards becoming so. Have to support multiple
> > versions along that will not make it easier.
> 
> Daniel, do you have a rough idea how many of our build config do
> not support QCRYPTO_HASH_ALGO_SHA256?
> (looking about making the SD device unconditional to it).

That's always available, since we can get it from 'glib' even when no
crypto libs are linked.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



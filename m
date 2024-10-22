Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2669D2C56C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GjZ-0006uM-45; Tue, 22 Oct 2024 11:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3GjX-0006tr-PG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3GjU-0004vl-OU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWI0fnwJ+9Z39irALVaU8H9akbSaC1yHxWwUHDy96DA=;
 b=J1URf+UQgDB3BJCCDT10xkq219B4+5ojz45+j1Ofmgg+vrsgp256SyxrrHhjc1fPDHfIlN
 /mrZLJmstnxyWJR0YaYBpB1Zz+F3d+OvjDML/yAw5xNk+lhRz8XqHQDwsjp2TP3RBeuG1a
 c23jhIBWqu857OBieLAybUw5RHNIwkI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-BIUZs8xyMiiBAIIHAgBEHA-1; Tue,
 22 Oct 2024 11:23:36 -0400
X-MC-Unique: BIUZs8xyMiiBAIIHAgBEHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5A521956096; Tue, 22 Oct 2024 15:23:27 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF32F1956088; Tue, 22 Oct 2024 15:23:16 +0000 (UTC)
Date: Tue, 22 Oct 2024 17:23:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Subject: Re: [PATCH v2 01/18] aspeed/smc: Fix write incorrect data into flash
 in user mode
Message-ID: <ZxfDYWEyMLcnMXlh@redhat.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-2-jamin_lin@aspeedtech.com>
 <ZxeDVTBwLZsOEDvE@redhat.com>
 <b682dc55-f5e8-4fec-82f7-333dbaba240e@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b682dc55-f5e8-4fec-82f7-333dbaba240e@kaod.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 22.10.2024 um 15:40 hat Cédric Le Goater geschrieben:
> > >   static const VMStateDescription vmstate_aspeed_smc = {
> > >       .name = "aspeed.smc",
> > > -    .version_id = 2,
> > > +    .version_id = 3,
> > >       .minimum_version_id = 2,
> > >       .fields = (const VMStateField[]) {
> > >           VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
> > >           VMSTATE_UINT8(snoop_index, AspeedSMCState),
> > >           VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
> > > +        VMSTATE_BOOL(unselect, AspeedSMCState),
> > >           VMSTATE_END_OF_LIST()
> > >       }
> > >   };
> > 
> > I think this will break migration compatibility. In order to enable
> > at least forward migration, it should be:
> > 
> >      VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
> 
> This is correct. I will fix the patch.
> 
> Some background,
> 
> The aspeed machines are fully emulated and the Aspeed SoC models are not
> part of any virt* machines (yet). So migration support is a bit of a
> theory. We have done our best to maintain some support, compatibility
> not being a priority. IOW, it's not perfectly tuned as on virt machines.
> 
> Also, on ARM, migration of the CPU secure mode (I think this is the reason,
> Peter please correct me !) is not supported and if migration is initiated
> after Linux has started, the machine will hang.

That's a good reason not to implement backwards migration for now, it
would only complicate things. But as long as we claim to be migratable
by having VMStateDescriptions and even increasing version_id, we should
at least try to keep that part correct.

> However, if one day, an aspeed model becomes part of a virt machine, we
> should be more careful. I would start by resetting all vmstate versions
> to 1!

Why would you reset it? Keeping 3 (or whatever it will be by then) as
the first serious supported version shouldn't hurt and probably avoids
some confusion.

Kevin



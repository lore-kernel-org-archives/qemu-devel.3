Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BEDC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllz1-0002t5-CD; Mon, 20 Jul 2026 07:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wllyy-0002sj-Li
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wllyw-00058K-KJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784546180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86Yo74JWQJtZz1CZYI7HIkqUPwDDXM4rOK5FZfPr3ig=;
 b=LsRLcnDT3A15UR4PyuAqt6eVjAtYosLNDBVL2rkOtefFo4WdoM7bCmAVTtV9mc8/gP7NBF
 ydtwea0IdblLcck/rh2RGXiye36oK35Od3zkAda3+cXPfpYPVBHkSBoKWINxpJNzCU0EAf
 SaSr5afHZ1+JUfi7y52FKhn+pnp3Pi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-8wOdsR1xMOeErIVgcBC2EA-1; Mon,
 20 Jul 2026 07:16:19 -0400
X-MC-Unique: 8wOdsR1xMOeErIVgcBC2EA-1
X-Mimecast-MFC-AGG-ID: 8wOdsR1xMOeErIVgcBC2EA_1784546178
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 284A3195E919; Mon, 20 Jul 2026 11:16:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 894E930001BE; Mon, 20 Jul 2026 11:16:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 70FD51800391; Mon, 20 Jul 2026 13:16:16 +0200 (CEST)
Date: Mon, 20 Jul 2026 13:16:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, mcascell@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v3 5/5] hw/uefi: add post_load checks
Message-ID: <al4Czy-yzflnnkqV@sirius.home.kraxel.org>
References: <20260709104223.143594-1-kraxel@redhat.com>
 <20260709104223.143594-6-kraxel@redhat.com>
 <alDgAbyQ9zSsp3CR@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alDgAbyQ9zSsp3CR@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

  Hi,

> > +    if (uv->used_storage > uv->max_storage) {
> > +        error_report("out of variable memory (%ld > %ld)",
> 
> nit: what about replacing %ld with PRIu64?

Done.

> > +static int uefi_vars_post_load(void *opaque, int version_id)
> > +{
> > +    uefi_variable *var = opaque;
> > +
> > +    if (!uefi_str_is_valid(var->name, var->name_size, true) ||
> > +        var->attributes & ~EFI_VARIABLE_ATTRIBUTE_SUPPORTED ||
> > +        (var->digest_size != 0 &&
> > +         var->digest_size != 32 /* AUTHVAR_DIGEST_SIZE */)) {
> 
> is it worth moving that define to a common header and using it here?

Was thinking about that too, but I'd prefer to keep the AUTHVAR_DIGEST_*
#defines together and the other has a dependency on gnutls so I can't
move it around easily.

take care,
  Gerd



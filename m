Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E88E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBsH-0006hh-7E; Tue, 07 Jan 2025 10:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBsF-0006hF-B7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBsB-0007H0-PV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736265122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67jtad3cBPEM5d1SEveaWVoyBLNzvZbIaZ56sZj1Od8=;
 b=SCmC2oub/iF9X5ENr+EGDqFV33AO+C1vBsMcoGxTJE9lFKwEQHY2XFbihGDIYg+S6snREp
 FZ+NGkQdBk6CTbksaPR2lGZKzT8Klfj1XtHlVOF+3EdLyxL95Ji68CVOnxL8U8iXZMHFXu
 hsg03V9h41I+47OUOeNFKDoYJZfWI5o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-NYKYEh4IOCWighEPs3x2hA-1; Tue,
 07 Jan 2025 10:51:59 -0500
X-MC-Unique: NYKYEh4IOCWighEPs3x2hA-1
X-Mimecast-MFC-AGG-ID: NYKYEh4IOCWighEPs3x2hA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CED01955F41; Tue,  7 Jan 2025 15:51:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C67F419560A2; Tue,  7 Jan 2025 15:51:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 695B618000B4; Tue, 07 Jan 2025 16:51:55 +0100 (CET)
Date: Tue, 7 Jan 2025 16:51:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 00/21] hw/uefi: add uefi variable service
Message-ID: <kdizecanqkeitvu62x2v3ge544yqk3lnbwc6c66zylrbcdx2qh@fz7hwrjbmidt>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <Z31LJr7nKtDFVCPE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31LJr7nKtDFVCPE@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> > The design idea is to reuse the request serialization protocol edk2 uses
> > for communication between SMM and non-SMM code, so large chunks of the
> > edk2 variable driver stack can be used unmodified.  Only the driver
> > which traps into SMM mode must be replaced by a driver which talks to
> > qemu instead.
> 
> In the coconut-svsm project there's a likely need for coconut to
> provide a UEFI variable store, since we can't store plain text
> variables in host context for confidential VMs.
> 
> Am I right in thinking that this design approach could be reused
> in coconut context with coconut providing the equivalent backend
> service, and EDK2 using the same driver to talk to either QEMU
> or Coconut's service  ?

Yes, that is the idea.  Right now the edk2 driver has two modes, one
talking to the isa device and one talking to the sysbus device.  Adding
a third mode which uses a svsm protocol should be easy.

Writing the efi variable service for coconut is the more challenging
item here.  /me plans to look into that later this year.

take care,
  Gerd



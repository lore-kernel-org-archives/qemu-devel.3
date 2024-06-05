Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19B4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElC7-0006u2-7v; Wed, 05 Jun 2024 03:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sElC4-0006sY-Q6
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sElC3-0007Ds-HZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=si07Y0bLjjYsqVO37UOQw+PHM2IEPt+3tkAbNv1A9dY=;
 b=WT7VUnLiHqio/ukT2+1PgRHcIWx9iHKAkJIvyLFSG5Q+vzwlo8fstYgL63v87Z9qL5cGM5
 HsLXOcWyNxVXxua1g5sZHiRVmsrAVuP+aMarEhAtTbJ6v0eZOwWf9aLDUtGxLQj+AZ2agx
 kD3JnxNr1uSvVr1bGP4COJeWKG7qdws=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-g3I8oBvNM4KXcyD4UNR39Q-1; Wed,
 05 Jun 2024 03:36:13 -0400
X-MC-Unique: g3I8oBvNM4KXcyD4UNR39Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D8F53C025B1;
 Wed,  5 Jun 2024 07:36:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2BB6492BF6;
 Wed,  5 Jun 2024 07:36:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 97652180098E; Wed,  5 Jun 2024 09:36:11 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:36:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org, 
 Stefano Stabellini <sstabellini@kernel.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 1/3] stdvga: fix screen blanking
Message-ID: <tmtartaqh2ac4azfq4cgwh22uuc4pnrnxjpcpky24xzjrkwb5c@ung7cyha4ppa>
References: <20240603151825.188353-1-kraxel@redhat.com>
 <20240603151825.188353-2-kraxel@redhat.com>
 <CAMxuvawqf-0dKPsZP2UTcDWPWQ+8FKbZ=S4KX02hQO1qeeGVMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawqf-0dKPsZP2UTcDWPWQ+8FKbZ=S4KX02hQO1qeeGVMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 04, 2024 at 10:27:18AM GMT, Marc-André Lureau wrote:
> Hi
> 
> > +    if (is_buffer_shared(surface)) {
> 
> Perhaps the suggestion to rename the function (in the following patch)
> should instead be surface_is_allocated() ? that would match the actual
> flag check. But callers would have to ! the result. Wdyt?

surface_is_shadow() ?  Comes closer to the typical naming in computer
graphics.

take care,
  Gerd



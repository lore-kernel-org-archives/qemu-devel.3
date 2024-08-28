Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B0C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjDNF-00061w-EZ; Wed, 28 Aug 2024 03:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sjDND-0005zq-El
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sjDN9-0004r2-Qs
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724831141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yv6jjgWqKhDf5NXHyRNo4KQ89f6LnUPmwKp++L5r/Y=;
 b=cN6NeQkZSNSKIQAioHAcLuFtTVJXaitplszxgzDVlMCggN6WNJilWBTOl/ROkiMqY/nWOW
 j/Vpf7tixij+3fxI3eH2kxRnbcTkOn7DtWoK7LPjYsOKhcQ7lMvTqHHV2PyGUOfDNMIxkC
 N2r7wAhwpj8q+gGYpKAAvVguv7lmUEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-mYoUzNNPOIuPH4YJxzzdmg-1; Wed,
 28 Aug 2024 03:45:36 -0400
X-MC-Unique: mYoUzNNPOIuPH4YJxzzdmg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1A918BEE60; Wed, 28 Aug 2024 07:45:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F69A1955D48; Wed, 28 Aug 2024 07:45:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 162B51800631; Wed, 28 Aug 2024 09:45:16 +0200 (CEST)
Date: Wed, 28 Aug 2024 09:45:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Peter Lieven <pl@kamp.de>,
 Greg Kurz <groug@kaod.org>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Cleber Rosa <crosa@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH v4 19/34] modules: check arch on qom lookup
Message-ID: <sqrj3rzgdyiagoilthty7ash45djl7af6kzdcmok6tbo4lwxd6@wgk2yjb5wx3f>
References: <20210624103836.2382472-1-kraxel@redhat.com>
 <20210624103836.2382472-20-kraxel@redhat.com>
 <a1e21e7c-a2a7-4eac-8a5d-e3cd57dc6894@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1e21e7c-a2a7-4eac-8a5d-e3cd57dc6894@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 27, 2024 at 05:37:00PM GMT, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (old patch)
> 
> On 24/6/21 12:38, Gerd Hoffmann wrote:
> > With target-specific modules we can have multiple modules implementing
> > the same object.  Therefore we have to check the target arch on lookup
> > to find the correct module.
> 
> "multiple modules implementing the same object." seems a design
> mistake to me.

IIRC that is (or was?) a problem with tcg or kvm modules, not fully sure
that ever happened in mainline qemu as the tcg modularization effort
stalled at some point.  But some object had the same name on all
architectures.  Which is not a problem when linked into
qemu-system-${arch} but is a problem when built as module.

> Assuming we clean the tree of target-specific modules "implementing
> the same object" -- due to heterogeneous emulation --,

Oh, yes, when linking multiple archs into one qemu binary the name
duplication is a problem even in the non-modular case.

> is there
> another use case for this check?

I don't think so.

take care,
  Gerd



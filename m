Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F819CFC273
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0chc-0001yR-TB; Tue, 15 Oct 2024 04:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0chb-0001vU-BZ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0chZ-0002vY-GW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728980084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qo3nFYNW02UW4uzAAlwS6h/F99kIbS1UWksPmCkphA=;
 b=Qsdb8RALlR43iQiQE308WfZUeUKI3+lV20jOIr62wqdCUI6prXQQg+VqP4QN+MjXl9Dvik
 eahxQf8jYKapLfXoB3Vsr0i7PTbOSt4m/JcdD7YhTWMC1bxDaUsAVQ92s5fWsePg8sF7AC
 eIcspr+bDshV9KkCj9rHjf6DUBO1ccE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-aez8ZDuEMPCzK31DWU95jA-1; Tue,
 15 Oct 2024 04:14:40 -0400
X-MC-Unique: aez8ZDuEMPCzK31DWU95jA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D7AD19560BD; Tue, 15 Oct 2024 08:14:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15D6F19560AE; Tue, 15 Oct 2024 08:14:34 +0000 (UTC)
Date: Tue, 15 Oct 2024 09:14:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] ui/console-vc: Silence warning about sprintf() on OpenBSD
Message-ID: <Zw4kaDIn97RXZKht@redhat.com>
References: <20241014151023.85698-1-thuth@redhat.com>
 <Zw01n0A6xCG9mCm-@redhat.com>
 <67e2cb19-8de6-4ebf-ab4f-ae13b3de134d@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e2cb19-8de6-4ebf-ab4f-ae13b3de134d@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 14, 2024 at 10:50:44PM +0300, Michael Tokarev wrote:
> On 14.10.2024 18:15, Daniel P. Berrangé wrote:
> 
> > These two lines are the only place in the code that uses the
> > 
> >     char response[40];
> > 
> > so even better than switching to snprintf, how about just taking
> > buffer size out of the picture:
> > 
> >    g_autofree *response =
> >        g_strdup_printf("\033[%d;%dR",
> >                        (s->y_base + s->y) % s->total_height + 1,
> >                        s->x + 1);
> >    vc_respond_str(vc, response);
> 
> What's the reason to perform memory allocation in trivial places
> like this?  If we're worrying about possible buffer size issue,
> maybe asprintf() is a better alternative for such small things?
> Fragmenting heap memory for no reason seems too much overkill.
> But I'm old-scool, so.. :)

This is not a performance sensitive path, and using g_strdup_printf
makes it robust against any futher changes in the future. In the
context of all the memory allocation QEMU does, I can't see this
making any difference to heap fragmentation whatsoever.

snprintf with fixed buffers should only be used where there's a
demonstratable performance win, and the return value actually
checked with an assert() to prove we're not overflowing.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



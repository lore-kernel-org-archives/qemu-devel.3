Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A3CC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhlS-0003GE-VA; Mon, 24 Mar 2025 09:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twhlH-00034X-61
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twhlE-0007aj-KG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvTwkhOtLoUPMj+k+JwfZZ0DInsi1TDtipO6rh5Z85I=;
 b=gclR6K1qLmI1mw0REzWitQTtenYFJYFn3Y/bnBNPv68sENKPIQS8w3LUXitGKt41dCPvku
 CC0vxBFKbG1T7wuHuQGkQleYOAdwrp1FVL0UPYxHerBy2E8E7Svil+ayVin2fpz0i8BNsk
 EVgy/GOluAh5SF1lDxGcoYj8HOcI8pQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-7iy_CsnQNH2uE80y01Rdtg-1; Mon,
 24 Mar 2025 09:22:31 -0400
X-MC-Unique: 7iy_CsnQNH2uE80y01Rdtg-1
X-Mimecast-MFC-AGG-ID: 7iy_CsnQNH2uE80y01Rdtg_1742822550
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C65391933B44; Mon, 24 Mar 2025 13:22:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B30CE19560AD; Mon, 24 Mar 2025 13:22:29 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:22:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
Message-ID: <Z-Fcki-tGmxd8bt2@redhat.com>
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <Z-EiFdVNiVJVwOqn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-EiFdVNiVJVwOqn@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CC qemu-stable - this needs cherry-picking into all active stable
branches once accepted.

On Mon, Mar 24, 2025 at 09:12:53AM +0000, Daniel P. Berrangé wrote:
> On Sun, Mar 23, 2025 at 10:35:54PM +0100, Daan De Meyer wrote:
> > We have to make sure the array of bytes read from the path= file
> > is null-terminated, otherwise we run into a buffer overrun later on.
> > 
> > Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
> > 
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >  hw/smbios/smbios.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 02a09eb9cd..ad4cd6721e 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
> >              g_byte_array_append(data, (guint8 *)buf, ret);
> >          }
> >  
> > +        buf[0] = '\0';
> > +        g_byte_array_append(data, (guint8 *)buf, 1);
> > +
> >          qemu_close(fd);
> >  
> >          *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



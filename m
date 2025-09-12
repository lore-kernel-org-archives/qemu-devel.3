Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B40CCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6gP-0005Ks-Lz; Fri, 12 Sep 2025 12:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6gA-0004xk-M1
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6g1-0005iO-Ar
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757694667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKRmhSIEJTm00VPeMS0XaZDHoubS+qSU5h/0Z18tADU=;
 b=ZpZnJD5G5bJuT84fs6alyPKu/ymtZqd0WsiygLSbwTJ4lgA+qjRxQUgRawtGG9P0BsHB6N
 gnMigcCLUOgWXI1iznac5blM95yyZdpGkkgGqbDAAHnlrvpHXRdjn0uJBWpPOcHWiRJskl
 0SKo+hljVWkvY719nxv6SO0ZsV/D4G4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-44bu_I2PM0Cz1umJB3BkWA-1; Fri,
 12 Sep 2025 12:31:04 -0400
X-MC-Unique: 44bu_I2PM0Cz1umJB3BkWA-1
X-Mimecast-MFC-AGG-ID: 44bu_I2PM0Cz1umJB3BkWA_1757694662
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D7EC1953945; Fri, 12 Sep 2025 16:31:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 599641800452; Fri, 12 Sep 2025 16:30:57 +0000 (UTC)
Date: Fri, 12 Sep 2025 17:30:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 14/20] util: fix interleaving of error & trace output
Message-ID: <aMRKvb0LhDqBUzDQ@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-15-berrange@redhat.com>
 <b22eec99-48ae-4d77-9e63-3944247ae5d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b22eec99-48ae-4d77-9e63-3944247ae5d5@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 11, 2025 at 06:05:01PM +0000, Richard Henderson wrote:
> On 9/10/25 18:03, Daniel P. Berrangé wrote:
> > +    } else {
> > +        print_func = (error_print_func)fprintf;
> > +        print_vfunc = (error_print_vfunc)vfprintf;
> > +        print_opaque = stderr;
> > +    }
> > +
> > +    if (message_with_timestamp && !cur) {
> >           timestr = real_time_iso8601();
> > -        error_printf("%s ", timestr);
> > +        print_func(print_opaque, "%s ", timestr);
> >           g_free(timestr);
> >       }
> >       /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> > -    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
> > -        error_printf("%s ", error_guest_name);
> > +    if (error_with_guestname && error_guest_name && !cur) {
> > +        print_func(print_opaque, "%s ", error_guest_name);
> >       }
> 
> It's worth pushing these second and third if into the first else,
> so that !cur is already true.

You've probably seen now that these 'if' blocks go away in the later
patch and the "qmessage_context_print(stderr);" that replaces them
is indeed inside the first 'else'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



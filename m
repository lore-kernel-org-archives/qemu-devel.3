Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05386CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbPP-0003IR-Vg; Fri, 19 Sep 2025 09:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbPO-0003Hs-E7
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbPH-0006tN-Nd
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758289447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQGNOO8Spv0Wvgh1QkF/AXf8NauXM4WYOfCuvSMBK+M=;
 b=DB+4dEsrUYr/RSmW4EvYM/FbBOqVsbyfSQf3n7M/TASZJbQVDwY7Jbd3A2nztaDnT6U66a
 xbgtAWpRxHXsSREJxFd2tW6uuuNqiLezBBO7nnFeduwmlfN9cBlzNlshY5MYZMPGswYbhc
 8AvFuCxxssDa4aZ/Xf1NT0zSfc7AJys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-RogRV0ENMTiQCoWioLuBUw-1; Fri,
 19 Sep 2025 09:44:03 -0400
X-MC-Unique: RogRV0ENMTiQCoWioLuBUw-1
X-Mimecast-MFC-AGG-ID: RogRV0ENMTiQCoWioLuBUw_1758289442
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8AC018004D4; Fri, 19 Sep 2025 13:44:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B04FD18004A3; Fri, 19 Sep 2025 13:43:56 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:43:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 11/20] monitor: move error_vprintf() back to
 error-report.c
Message-ID: <aM1eGRtgZa1RVlz1@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-12-berrange@redhat.com>
 <874isyy6dz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874isyy6dz.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 19, 2025 at 02:27:20PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This conceptually reverts 397d30e9401d2da96dbdf0ce49805d6d4bb68833.
> > The discussion around stubs in that commit does not appear to be
> > important to the current state of the codebase.
> 
> Can we figure out why Paolo's change is no longer needed?
> 
> Discussion back then:
> https://lore.kernel.org/qemu-devel/37942764-b3c8-1ac1-5121-894ada7300f2@redhat.com/
> https://lore.kernel.org/qemu-devel/1477326663-67817-1-git-send-email-pbonzini@redhat.com/

I'm wrong, this change of mine is broken because it messes up the output
of test-vmstate still

> 
> > This makes the error_vprintf() impl source file match that
> > of error_printf(), and also match the header where it is declared.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



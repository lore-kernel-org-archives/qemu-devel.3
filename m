Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32323C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlnH-0003rs-OP; Fri, 19 Apr 2024 06:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxln9-0003p8-0X
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxln7-0005Ay-Gt
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713523704;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sg6K/rRO2To4g107/x+JAmjRmx1nTbi6aqy5giKAOmI=;
 b=QaaNxisZiB0wCbI/VqboebetFjht76RwJYekBRiCDk49ua49oGlXjvWyswWdNz97IW68we
 kKYaALTIn92SkPIJAN4k1JJF/DyxwP+es6mNqFGtWaGXUa76lGQ+pZ8+mBMs2LFCno0k1s
 mUZY5iVV7914cO/q+j9l+YTufCwpZUk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-aV1J_0-NNQCJRvG5GwWVNQ-1; Fri,
 19 Apr 2024 06:48:19 -0400
X-MC-Unique: aV1J_0-NNQCJRvG5GwWVNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852F63803922;
 Fri, 19 Apr 2024 10:48:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC49E18209F;
 Fri, 19 Apr 2024 10:48:16 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:48:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 00/12] misc: Remove sprintf() due to macOS deprecation
Message-ID: <ZiJL7rjlWw4t-kPo@redhat.com>
References: <20240410160614.90627-1-philmd@linaro.org>
 <c4c8f2b8-7ef2-4b2f-a9d4-8c1e64668570@linaro.org>
 <220fddca-0017-79c9-ec1f-23bb8a68728c@eik.bme.hu>
 <1c6cc7f0-a0c7-43c1-aadd-d4c8d76354d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c6cc7f0-a0c7-43c1-aadd-d4c8d76354d2@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 11, 2024 at 11:38:41AM +0200, Philippe Mathieu-Daudé wrote:
> On 11/4/24 00:27, BALATON Zoltan wrote:
> > On Wed, 10 Apr 2024, Richard Henderson wrote:
> > > On 4/10/24 06:06, Philippe Mathieu-Daudé wrote:
> > > > Hi,
> > > > 
> > > > sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> > > > resulting in painful developper experience.
> > > 
> > > Is snprintf also deprecated?
> > > It might be easier to convert some of these fixed buffer cases that
> > > way, if allowed.
> > 
> > I had the same thought as some of these might also have performance
> > implications (although most of them are in rarely called places).
> 
> I thought GLib/GString was recommended for formatting (IIRC some
> previous discussion with Alex / Daniel), so I switched to this
> API for style, rather than thinking of performance. Anyway, I'll
> respin using sprintf() when the buffer size maths are already done.

There are places in QEMU where the strings end up living in a fixed
size struct fields, and those would be candidates for sticking with
snprint().

For stack allocated string buffers, it is preferrable to switch to
g_autofree + g_strdup_printf(), unless there's a compelling performance
reason to avoid allocation in a hot path IMHO.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



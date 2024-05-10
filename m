Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3282C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5M9D-0004Fn-AG; Fri, 10 May 2024 05:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5M99-0004Fa-AH
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5M92-0005Ou-0p
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715331743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97mDfnW/FUswJOMAX/dOwrdbcqkjmg7XGFv1yc9/EvA=;
 b=caXyyCa4ubT1DS89VE300/5HL0QaIibvjaSbi21Ulr4SsjKBaDfxSbW78ZYPGKhg8lXDqi
 SyuuD5lTj0+yzwFuV4UTd4CjaTUdN7ugtEi8He+3ycMFYMxJtyVuWbfGu4up60UN0Y8zWU
 FEqrsnYf9gM8WXAfVflIpivDuyFD2+A=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-CJWq_xeZMrmsKBeGpgp7xQ-1; Fri, 10 May 2024 05:02:21 -0400
X-MC-Unique: CJWq_xeZMrmsKBeGpgp7xQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f04345122eso1600600a34.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715331737; x=1715936537;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97mDfnW/FUswJOMAX/dOwrdbcqkjmg7XGFv1yc9/EvA=;
 b=GbLps47CwJXuJ2q507cfwVLqwNvQwmoA8vhof7HML8G6fqnQEroBddoHkbYMNpaZWp
 a1Iw8NaMTUdqNlhN9KXqwwwqAWtxPxryhv0lwZGYFAYubGCnM5hR3H692YaiokpxyWBB
 iSBBiwWyqgfa7zaAd3wl6lbrDq0YRLRduIMxxErZ68rJQglD2wnhZy3ZLl09/FCc8Tax
 AjcS1OI3HHqNI997CJNHOLG5kbUT+JOAK1el4m+yyER+xA5MI7dXgeAsK2/JfBNuCoQN
 VHatwPQ0ZJRbHbqmeXFdrgxDh1xh8MgKIZ9MMHpVBZGFkK5sl4RHFsOZFG/IKfqhFnq/
 8zHw==
X-Gm-Message-State: AOJu0Yz4zQsqJWF9p0myJ/k4CYQc2EEjQV864iUdBNv7w09LHD9eXNGz
 mdgvfJo87xttjRZLTFgk2fuUCqxsRIyazRYHgqefftjze5Y5kjy6iADY4mDq8dNcSTZdYTvGkig
 HA9C9siLvumso94Fjb8aWNUgDRMwE9YRr2av9PWfRbVVvt8zVzHHY
X-Received: by 2002:a9d:6b13:0:b0:6f0:3c41:648 with SMTP id
 46e09a7af769-6f0e92ebdd0mr1854899a34.36.1715331736681; 
 Fri, 10 May 2024 02:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS+yvGIdSiCRmjO5JV3htohoa7imzT73tAEzIhIwCQRhky0JPErqFBrQmnkwAQlKt/MBqVUg==
X-Received: by 2002:a9d:6b13:0:b0:6f0:3c41:648 with SMTP id
 46e09a7af769-6f0e92ebdd0mr1854861a34.36.1715331736314; 
 Fri, 10 May 2024 02:02:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc67esm159370785a.74.2024.05.10.02.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 02:02:15 -0700 (PDT)
Date: Fri, 10 May 2024 11:02:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com, 
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 gmaglione@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 09/12] contrib/vhost-user-blk: enable it on any POSIX
 system
Message-ID: <zblon7kwhe5nyykiy72v7tdlj2bnx6feigcn47gewobdtz4wkw@ph7acs6hwrtj>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-10-sgarzare@redhat.com>
 <ed6199d5-63b8-4a03-8dc1-dce27bc93e92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed6199d5-63b8-4a03-8dc1-dce27bc93e92@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 08, 2024 at 12:32:08PM GMT, Philippe Mathieu-Daudé wrote:
>On 8/5/24 09:44, Stefano Garzarella wrote:
>>Let's make the code more portable by adding defines from
>>block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).
>>
>>vhost-user-server.c is a dependency, let's enable it for any POSIX
>>system.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v4:
>>- moved using of "qemu/bswap.h" API in a separate patch [Phil]
>>---
>>  meson.build                             |  2 --
>>  contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
>>  util/meson.build                        |  4 +++-
>>  3 files changed, 17 insertions(+), 3 deletions(-)
>
>
>>diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
>>index 9492146855..a450337685 100644
>>--- a/contrib/vhost-user-blk/vhost-user-blk.c
>>+++ b/contrib/vhost-user-blk/vhost-user-blk.c
>>@@ -25,6 +25,20 @@
>>  #include <sys/ioctl.h>
>>  #endif
>>+/* OS X does not have O_DSYNC */
>>+#ifndef O_DSYNC
>>+#ifdef O_SYNC
>>+#define O_DSYNC O_SYNC
>>+#elif defined(O_FSYNC)
>>+#define O_DSYNC O_FSYNC
>>+#endif
>>+#endif
>>+
>>+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
>>+#ifndef O_DIRECT
>>+#define O_DIRECT O_DSYNC
>>+#endif
>
>Could we add that in "qemu/osdep.h" instead?

Since "qemu/osdep.h" includes fcntl.h, I think it could be fine.

@Hanna, @Kevin WDYT?

>
>Otherwise,
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

Thanks,
Stefano



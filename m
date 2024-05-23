Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842EFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAA4N-0000X2-8S; Thu, 23 May 2024 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAA4G-0000VL-4h
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAA4E-0006Ge-BN
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rASbrkUVSZOgJ0tWM/L93PYfpfW9HNkvr0zb5XPp4x4=;
 b=TJoUkXGMa/N6uyU3tMQ6g0jvJWtGFoN3Cw01iyr017gdfqIakFtYcQXm43hLB+0yKQgCqn
 shkggeas3G/Cdy0VfgA/FElk1R+y7JMvKHPEBzbUKi7i/v8G8vQ/Ht6gJTB1r38e4jAfE7
 ECSjLwaxs4aWZ/RToFea/cOe13epBAs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-j-D13zK7N0Gz_hEGR6IWiQ-1; Thu, 23 May 2024 11:09:16 -0400
X-MC-Unique: j-D13zK7N0Gz_hEGR6IWiQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43f7dba5d72so2295621cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476955; x=1717081755;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rASbrkUVSZOgJ0tWM/L93PYfpfW9HNkvr0zb5XPp4x4=;
 b=hPXhX+P3omBnILlK87IB04XOOfK5+q1GGvJ8TSye0V0CL8DBw/j5q7d6BvuCRWkbt+
 Q8z6Uj8PWfkSW0bjjD0er9u/1NW964tFHvdVOwEbybl9vrXoqwkua2+VKdpykG1f3eTH
 hXZ6Y2aTzy18ZavLIYp+jVCZuTRXNtA7HtFxTcoreths58BbODxm1H+cBfH06gr9T6GZ
 5JaaD3+voXN6ErDURnKaJYdbvvDJt3JtO1dqEFtHmutOjnwCFuj5pus+zUuWnc/Nwc+W
 pgH2/vDd1ZxZGpH5o9DjWwfvxMI6sHKWB3fgotx0gvQyJVY7e2Lsa1J+WGFn3b7KNRz+
 S0pw==
X-Gm-Message-State: AOJu0YygOrpQ0+RQNEcaM7OkuPoEAyc9dGfop5Vm3atMIdNXjIiovefc
 vSEWSHHr2qMSSOq8BYdQG5znu2V2xHJdA1efPKhxaorhLIKk2HNlGUq/VLnOqLWIeOUz1M7rS4f
 3DOURuqnE81GVDiK8ErxsLDDWVpNIvgUg77iiwU6gSHiP83EV5tmGdC/OBbepbl0qor7+cFY45G
 o1KjT85vktuupEkkapvLwqNzseMKwmpd5ZBvGp
X-Received: by 2002:ac8:5fd3:0:b0:43a:c27b:df34 with SMTP id
 d75a77b69052e-43f9e0af0c9mr58705501cf.31.1716476955346; 
 Thu, 23 May 2024 08:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPCYBBh07rlOBvWIjBRnr/4ChHgaf26GMRz32Wc1c/nGpDIZnDAGusZg1C7nxdMrpJ9bR0xg==
X-Received: by 2002:ac8:5fd3:0:b0:43a:c27b:df34 with SMTP id
 d75a77b69052e-43f9e0af0c9mr58704731cf.31.1716476954563; 
 Thu, 23 May 2024 08:09:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54f216esm186581251cf.31.2024.05.23.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:09:13 -0700 (PDT)
Date: Thu, 23 May 2024 17:09:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 slp@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com, 
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 09/13] osdep: move O_DSYNC and O_DIRECT defines from
 file-posix
Message-ID: <s2la2k2uplacblbxyywyxbhixrb7flpup3cp5zqdrvsbbrll5n@bajukzj7lamt>
References: <20240523145522.313012-1-sgarzare@redhat.com>
 <20240523145522.313012-10-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523145522.313012-10-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 23, 2024 at 04:55:18PM GMT, Stefano Garzarella wrote:
>These defines are also useful for vhost-user-blk when it is compiled
>in some POSIX systems that do not define them, so let's move them to
>“qemu/osdep.h”.
>
>Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/qemu/osdep.h | 14 ++++++++++++++
> block/file-posix.c   | 14 --------------
> 2 files changed, 14 insertions(+), 14 deletions(-)

This seems to break the compilation on win64: 
https://gitlab.com/sgarzarella/qemu/-/jobs/6923403322

     In file included from ../util/osdep.c:24:
     ../util/osdep.c: In function 'qemu_open_internal':
     ../include/qemu/osdep.h:339:18: error: 'O_DSYNC' undeclared (first use in this function)
       339 | #define O_DIRECT O_DSYNC
           |                  ^~~~~~~
     ../util/osdep.c:334:41: note: in expansion of macro 'O_DIRECT'
       334 |         if (errno == EINVAL && (flags & O_DIRECT)) {
           |                                         ^~~~~~~~
     ../include/qemu/osdep.h:339:18: note: each undeclared identifier is reported only once for each function it appears in
       339 | #define O_DIRECT O_DSYNC
           |                  ^~~~~~~
     ../util/osdep.c:334:41: note: in expansion of macro 'O_DIRECT'
       334 |         if (errno == EINVAL && (flags & O_DIRECT)) {
           |                                         ^~~~~~~~
     ../util/osdep.c: In function 'qemu_open_old':
     ../include/qemu/osdep.h:339:18: error: 'O_DSYNC' undeclared (first use in this function)
       339 | #define O_DIRECT O_DSYNC
           |                  ^~~~~~~
     ../util/osdep.c:385:50: note: in expansion of macro 'O_DIRECT'
       385 |     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
           |

Indeed file-posix.c was not compiled on windows. Oops, I didn't think of 
that :-(

I'm thinking on putting a guard on CONFIG_POSIX, or just checking that 
O_DSYNC is defined. Any suggestion?

Thanks,
Stefano

>
>diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>index f61edcfdc2..e165b5cb1b 100644
>--- a/include/qemu/osdep.h
>+++ b/include/qemu/osdep.h
>@@ -325,6 +325,20 @@ void QEMU_ERROR("code path is reachable")
> #define ESHUTDOWN 4099
> #endif
>
>+/* OS X does not have O_DSYNC */
>+#ifndef O_DSYNC
>+#ifdef O_SYNC
>+#define O_DSYNC O_SYNC
>+#elif defined(O_FSYNC)
>+#define O_DSYNC O_FSYNC
>+#endif
>+#endif
>+
>+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
>+#ifndef O_DIRECT
>+#define O_DIRECT O_DSYNC
>+#endif
>+
> #define RETRY_ON_EINTR(expr) \
>     (__extension__                                          \
>         ({ typeof(expr) __result;                               \
>diff --git a/block/file-posix.c b/block/file-posix.c
>index 35684f7e21..7a196a2abf 100644
>--- a/block/file-posix.c
>+++ b/block/file-posix.c
>@@ -110,20 +110,6 @@
> #include <sys/diskslice.h>
> #endif
>
>-/* OS X does not have O_DSYNC */
>-#ifndef O_DSYNC
>-#ifdef O_SYNC
>-#define O_DSYNC O_SYNC
>-#elif defined(O_FSYNC)
>-#define O_DSYNC O_FSYNC
>-#endif
>-#endif
>-
>-/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
>-#ifndef O_DIRECT
>-#define O_DIRECT O_DSYNC
>-#endif
>-
> #define FTYPE_FILE   0
> #define FTYPE_CD     1
>
>-- 
>2.45.1
>



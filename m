Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43985CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzHB-0000mM-7K; Fri, 12 Sep 2025 04:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzH6-0000jX-7M
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzGy-0005HU-IP
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757666206;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQSbWAc6b8cJ5dHSa7CynUyt6ouGvtjJNGAFJexZgAI=;
 b=Uf3z5PcUj/Ao/mO1aRc9KjrFDoezDhRfu0UrXRxHvd9VeOMoXShvS0Q3f46fKX0CvR94tV
 eNiCnXnEfYPaTDf2zY3739zbs7eCveB9tNIz8Zsho3PGcgum7DLTt9JOkih836chYu6k2j
 dyHvFsJehAINKACGDzY5Rsbubh0iLH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-OzupcFCCMJKdAGw-oTBtlg-1; Fri,
 12 Sep 2025 04:36:43 -0400
X-MC-Unique: OzupcFCCMJKdAGw-oTBtlg-1
X-Mimecast-MFC-AGG-ID: OzupcFCCMJKdAGw-oTBtlg_1757666201
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8745418004D8; Fri, 12 Sep 2025 08:36:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7799219560B1; Fri, 12 Sep 2025 08:36:36 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:36:32 +0100
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
Subject: Re: [PATCH v3 19/20] util: add support for formatting thread info in
 messages
Message-ID: <aMPbkNL2zrXB1aSE@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-20-berrange@redhat.com>
 <0d867b92-2419-4cfd-91ca-752a95407537@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d867b92-2419-4cfd-91ca-752a95407537@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 11, 2025 at 06:11:47PM +0000, Richard Henderson wrote:
> On 9/10/25 18:03, Daniel P. Berrangé wrote:
> > --- a/storage-daemon/qemu-storage-daemon.c
> > +++ b/storage-daemon/qemu-storage-daemon.c
> > @@ -47,6 +47,7 @@
> >   #include "qemu/cutils.h"
> >   #include "qemu/config-file.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/message.h"
> >   #include "qemu/help_option.h"
> >   #include "qemu/job.h"
> >   #include "qemu/log.h"
> > @@ -65,6 +66,10 @@ static const char *pid_file;
> >   static char *pid_file_realpath;
> >   static volatile bool exit_requested = false;
> > +#define QMESSAGE_FORMAT_DEFAULT \
> > +    (QMESSAGE_FORMAT_PROGRAM_NAME | \
> > +     QMESSAGE_FORMAT_THREAD_INFO)
> > +
> >   void qemu_system_killed(int signal, pid_t pid)
> >   {
> >       exit_requested = true;
> > @@ -399,6 +404,7 @@ int main(int argc, char *argv[])
> >   #endif
> >       error_init(argv[0]);
> > +    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
> >       qemu_init_exec_dir(argv[0]);
> >       os_setup_signal_handling();
> > diff --git a/system/vl.c b/system/vl.c
> > index 9030212c50..20b655a7bc 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -145,6 +145,10 @@
> >   #define MAX_VIRTIO_CONSOLES 1
> > +#define QMESSAGE_FORMAT_DEFAULT \
> > +    (QMESSAGE_FORMAT_PROGRAM_NAME | \
> > +     QMESSAGE_FORMAT_THREAD_INFO)
> > +
> >   typedef struct BlockdevOptionsQueueEntry {
> >       BlockdevOptions *bdo;
> >       Location loc;
> > @@ -811,10 +815,9 @@ static void realtime_init(void)
> >       }
> >   }
> > -
> >   static void configure_msg(QemuOpts *opts)
> >   {
> > -    int flags = QMESSAGE_FORMAT_PROGRAM_NAME;
> > +    int flags = QMESSAGE_FORMAT_DEFAULT;
> >       if (qemu_opt_get_bool(opts, "timestamp", false)) {
> >           flags |= QMESSAGE_FORMAT_TIMESTAMP;
> >       }
> > @@ -2888,6 +2891,7 @@ void qemu_init(int argc, char **argv)
> >       module_call_init(MODULE_INIT_OPTS);
> >       error_init(argv[0]);
> > +    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
> 
> Worth a static initial value of the variable, rather than require two other startup calls?

NB, the qmessage stuff is linked into all our other binaries too,
and so I only wanted to turn on thread info for the subset of
binaries that are likely to be using multiple threads. Then
again, posibly both qemu-nbd and qemu-img might use threads
in some scenarios

> This also seems like it should be a separate patch from adding THREAD_INFO
> to qmessage_context_print.

Sure, I can do that.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



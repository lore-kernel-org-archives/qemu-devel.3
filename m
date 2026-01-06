Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BE3CDC18E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 12:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6VG-00022E-IQ; Tue, 06 Jan 2026 07:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd6VF-00020v-CK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd6VC-0005xf-SD
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767703773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/kI8WC2FyR+cUhtHtG3c1PsbdBpC54W5hng9BU3RDrU=;
 b=AKkF1/k2WXYCnDPvNgEuDaVYlw44dqSH/pQZrFAF9dJOcJ3MVi3br+41T7nWk0V6lylczG
 keVHcSlAuXVk8v1DyjIPBuqRxzgRYdhDokQDT+0eGOsb2WfXWiVJI9LfMjr/3QPq4YrNWt
 MBrr/bls98NCHmIZhqWt0TdU2EECtoM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-tHz2K7NDOFOrr8grga6a_Q-1; Tue,
 06 Jan 2026 07:49:30 -0500
X-MC-Unique: tHz2K7NDOFOrr8grga6a_Q-1
X-Mimecast-MFC-AGG-ID: tHz2K7NDOFOrr8grga6a_Q_1767703768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80BFB180066C; Tue,  6 Jan 2026 12:49:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BC918004D8; Tue,  6 Jan 2026 12:49:25 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:49:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Navid Emamdoost <navidem@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, stefanha@redhat.com, farosas@suse.de,
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com,
 zsm@google.com
Subject: Re: [PATCH v3 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
Message-ID: <aV0EtXyfCmpSUvg8@redhat.com>
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
 <20251112003637.1984547-1-navidem@google.com>
 <20251112003637.1984547-2-navidem@google.com>
 <CAHUE=o8u1snmMBGHExoZix3vFY6Y8J_jWdYKNDiuMd6jvw0qzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHUE=o8u1snmMBGHExoZix3vFY6Y8J_jWdYKNDiuMd6jvw0qzQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alexander,

I don't see this old fuzzing patch merged yet. Who is normally collecting
and merging fuzz patches ?

On Fri, Nov 14, 2025 at 09:02:06AM -0600, Alexander Bulekov wrote:
> On 251112 0036, Navid Emamdoost wrote:
> > Add a new generic fuzz target for the QEMU VNC server. This target
> > exercises both the standard VNC protocol and the VNC-over-WebSocket
> > transport layer, increasing coverage of a primary remote attack surface.
> >
> > To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
> > socket paths are generated dynamically. The fuzzer harness inspects the
> > command line for placeholders and replaces them with unique paths
> > created by mkstemp() before execution.
> >
> > ---
> >
> > This new target increases code coverage in the VNC subsystem
> > and related networking and I/O code.
> > The baseline coverage below was generated by running all existing fuzz
> > targets with the oss-fuzz corpus. The new target shows significant gains:
> >
> > ----------------------------------------------------------------------------
> > File                       New Target                Baseline        Change
> > ----------------------------------------------------------------------------
> > vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
> > keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
> > net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
> > channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
> > qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
> > vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
> > dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
> >
> > Signed-off-by: Navid Emamdoost <navidem@google.com>
> 
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> 
> > ---
> >  tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> > index ef0ad95712..9c46e106a4 100644
> > --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> > +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> > @@ -29,6 +29,52 @@ static inline gchar *generic_fuzzer_virtio_9p_args(void){
> >      "writeout=immediate,fmode=0600,dmode=0700", tmpdir);
> >  }
> >
> > +/*
> > + * Global variables and cleanup handler for VNC fuzzer sockets.
> > + * These are needed because the socket paths must be available at exit.
> > + */
> > +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
> > +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
> > +
> > +static void cleanup_vnc_sockets(void)
> > +{
> > +    if (g_vnc_socket_path[0] != '\0') {
> > +        unlink(g_vnc_socket_path);
> > +    }
> > +    if (g_vnc_ws_socket_path[0] != '\0') {
> > +        unlink(g_vnc_ws_socket_path);
> > +    }
> > +}
> > +
> > +/*
> > + * Dynamically generate VNC arguments with unique unix socket paths.
> > + * This allows multiple fuzzing jobs to run in parallel without conflict.
> > + */
> > +static inline gchar *generic_fuzzer_vnc_args(void)
> > +{
> > +    static bool cleanup_registered = false;
> > +    int fd;
> > +
> > +    strcpy(g_vnc_socket_path, "/tmp/qemu-vnc.XXXXXX");
> > +    fd = g_mkstemp(g_vnc_socket_path);
> > +    g_assert_cmpint(fd, !=, -1);
> > +    close(fd);
> > +
> > +    strcpy(g_vnc_ws_socket_path, "/tmp/qemu-vnc-ws.XXXXXX");
> > +    fd = g_mkstemp(g_vnc_ws_socket_path);
> > +    g_assert_cmpint(fd, !=, -1);
> > +    close(fd);
> > +
> > +    if (!cleanup_registered) {
> > +        atexit(cleanup_vnc_sockets);
> > +        cleanup_registered = true;
> > +    }
> > +
> > +    return g_strdup_printf("-machine q35 -nodefaults "
> > +                           "-vnc vnc=unix:%s,websocket=unix:%s",
> > +                           g_vnc_socket_path, g_vnc_ws_socket_path);
> > +}
> > +
> >  const generic_fuzz_config predefined_configs[] = {
> >      {
> >          .name = "virtio-net-pci-slirp",
> > @@ -247,6 +293,10 @@ const generic_fuzz_config predefined_configs[] = {
> >          .args = "-machine q35 -nodefaults "
> >          "-parallel file:/dev/null",
> >          .objects = "parallel*",
> > +    },{
> > +        .name = "vnc",
> > +        .argfunc = generic_fuzzer_vnc_args,
> > +        .objects = "*",
> >      }
> >  };
> >
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



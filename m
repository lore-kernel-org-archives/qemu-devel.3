Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A79CCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78vd-0000oy-BT; Fri, 10 Oct 2025 04:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78vW-0000lM-31
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78vP-0004bd-C6
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760086586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1UJbuHXT3QXfjuimEtE9kKCQS9F0OdfFPHXZ6RqXWdU=;
 b=WRW1dx0YwSG7mGdpOs7p4PYUSDe6SCZR+Vjd0pBd/y9Dj+QCJRQJ7dkNNiO/sa6vNxJoB3
 4V9XzuqrXcab3O0o3dP1Ualn/mJObBMif4QAWDzJD4FoJHbYCK1ISoClSjkeWFgGkepUYm
 D8o8ySNL4ki1ACPYjE8qZ3mO81um5bI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-NV36Qr2AMwm20HsH1wg8fw-1; Fri,
 10 Oct 2025 04:56:21 -0400
X-MC-Unique: NV36Qr2AMwm20HsH1wg8fw-1
X-Mimecast-MFC-AGG-ID: NV36Qr2AMwm20HsH1wg8fw_1760086580
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B52BB180034F; Fri, 10 Oct 2025 08:56:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3408A1800446; Fri, 10 Oct 2025 08:56:14 +0000 (UTC)
Date: Fri, 10 Oct 2025 09:56:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 zsm@google.com, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] tests/qtest/fuzz: Add generic fuzzer for VNC
Message-ID: <aOjKKgGEL5sYmhmD@redhat.com>
References: <20251009211114.2214848-1-navidem@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009211114.2214848-1-navidem@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 09, 2025 at 09:11:14PM +0000, Navid Emamdoost wrote:
> Add a new generic fuzz target for the QEMU VNC server. This allows the
> generic fuzzer to directly exercise the VNC protocol implementation by
> connecting to a VNC unix socket.
> 
> ---
> 
> This new target increases code coverage in the VNC subsystem
> and related networking and I/O code.
> The baseline coverage below was generated by running all existing fuzz
> targets with the oss-fuzz corpus. The new target shows significant gains:
> 
> ----------------------------------------------------------------------------
> File                       New Target                Baseline        Change
> ----------------------------------------------------------------------------
> vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
> keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
> net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
> channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
> qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
> dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
> vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
> 
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/fuzz/generic_fuzz_configs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> index ef0ad95712..2e802ab226 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -247,6 +247,10 @@ const generic_fuzz_config predefined_configs[] = {
>          .args = "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects = "parallel*",
> +    },{
> +        .name = "vnc",
> +        .args = "-machine q35 -nodefaults -vnc vnc=unix:/tmp/qemu-vnc.sock",

How about also adding  ",websocket=unix:/tmp/qemu-vnc-ws.sock" ?

I'm guessing the fuzz tool is not intelligent enough to be able
to negotiate TLS over the connections ?

> +        .objects = "*",
>      }
>  };
>  
> -- 
> 2.51.0.740.g6adb054d12-goog
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



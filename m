Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti94a-0003bs-AV; Wed, 12 Feb 2025 04:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti94Y-0003Uh-7Z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti94V-0001qX-Ul
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739352617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3S5H19VbRlR1KhD55z8iO+q41vO+hGPZWw1amHA2eVs=;
 b=Uc16IlT7wvDQfWvII+XNNl8ka+uc3558f1TvdfGZlzn3Np8OqmWDu3TgLsNlm+9nsnAeKT
 8eOsCqZ/3PP8RYMm4EIPdsDaNtHsfHLfNedA663U1Cc3LvEjLIq2ZLqwlpdkPeUUwj1Pmx
 VU1/fzVJksplOwgBqaRmRMMmJneGvQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-mebjj2GYM3G0KKaOb-cBaw-1; Wed,
 12 Feb 2025 04:30:16 -0500
X-MC-Unique: mebjj2GYM3G0KKaOb-cBaw-1
X-Mimecast-MFC-AGG-ID: mebjj2GYM3G0KKaOb-cBaw_1739352615
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DC51800875; Wed, 12 Feb 2025 09:30:13 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 374CF19560A3; Wed, 12 Feb 2025 09:30:11 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:30:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] scripts: improve error from qemu-trace-stap on missing
 'stap'
Message-ID: <Z6xqIHPUL7JoZE6D@redhat.com>
References: <20241206114524.1666664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206114524.1666664-1-berrange@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Stefan,

Are you ok with queuing this patch ?

On Fri, Dec 06, 2024 at 11:45:24AM +0000, Daniel P. Berrangé wrote:
> If the 'stap' binary is missing in $PATH, a huge trace is thrown
> 
>   $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>   Traceback (most recent call last):
>   File "/usr/bin/qemu-trace-stap", line 169, in <module>
>   main()
>   File "/usr/bin/qemu-trace-stap", line 165, in main
>   args.func(args)
>   File "/usr/bin/qemu-trace-stap", line 83, in cmd_run
>   subprocess.call(stapargs)
>   File "/usr/lib64/python3.12/subprocess.py", line 389, in call
>   with Popen(*popenargs, **kwargs) as p:
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/subprocess.py", line 1026, in {}init{}
>   self._execute_child(args, executable, preexec_fn, close_fds,
>   File "/usr/lib64/python3.12/subprocess.py", line 1955, in _execute_child
>   raise child_exception_type(errno_num, err_msg, err_filename)
>   FileNotFoundError: [Errno 2] No such file or directory: 'stap'
> 
> With this change the user now gets
> 
>   $ qemu-trace-stap list /usr/bin/qemu-system-x86_64
>   Unable to find 'stap' in $PATH
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/qemu-trace-stap | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-trace-stap b/scripts/qemu-trace-stap
> index eb6e951ff2..e983460ee7 100755
> --- a/scripts/qemu-trace-stap
> +++ b/scripts/qemu-trace-stap
> @@ -56,6 +56,7 @@ def tapset_dir(binary):
>  
>  
>  def cmd_run(args):
> +    stap = which("stap")
>      prefix = probe_prefix(args.binary)
>      tapsets = tapset_dir(args.binary)
>  
> @@ -76,7 +77,7 @@ def cmd_run(args):
>  
>      # We request an 8MB buffer, since the stap default 1MB buffer
>      # can be easily overflowed by frequently firing QEMU traces
> -    stapargs = ["stap", "-s", "8", "-I", tapsets ]
> +    stapargs = [stap, "-s", "8", "-I", tapsets ]
>      if args.pid is not None:
>          stapargs.extend(["-x", args.pid])
>      stapargs.extend(["-e", script])
> @@ -84,6 +85,7 @@ def cmd_run(args):
>  
>  
>  def cmd_list(args):
> +    stap = which("stap")
>      tapsets = tapset_dir(args.binary)
>  
>      if args.verbose:
> @@ -96,7 +98,7 @@ def cmd_list(args):
>  
>          if verbose:
>              print("Listing probes with name '%s'" % script)
> -        proc = subprocess.Popen(["stap", "-I", tapsets, "-l", script],
> +        proc = subprocess.Popen([stap, "-I", tapsets, "-l", script],
>                                  stdout=subprocess.PIPE,
>                                  universal_newlines=True)
>          out, err = proc.communicate()
> -- 
> 2.46.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



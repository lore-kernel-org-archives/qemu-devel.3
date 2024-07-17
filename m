Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1R5-0001Q4-VI; Wed, 17 Jul 2024 05:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sU1R4-0001PZ-Vg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sU1R2-00056J-4b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721210334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n4UN/G8Ip4oF5sElkoHDRbFeW5I8EwSdJJrjaN6KYHE=;
 b=VFZylS0eo43lLqFhWHr8o5GoeiDx90YJwRgYFLV+yQLpcxiZEMX0AN2z5dDE8TzZKJCgjc
 Wned34mSB5RTprYTLrwgEm/kk0MvwIbKOTp6YVUTc1sW67vasfeuKliffcFQn6USOjSk0H
 qSfL4E6wQtNmS81O/gJxxru7y7WPi0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78--aPcuoAiP1-qNlS-mjrK5w-1; Wed,
 17 Jul 2024 05:58:50 -0400
X-MC-Unique: -aPcuoAiP1-qNlS-mjrK5w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47227195609E
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 09:58:49 +0000 (UTC)
Received: from localhost (dhcp-192-176.str.redhat.com [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8327A1955F40; Wed, 17 Jul 2024 09:58:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] scripts/checkpatch: emit a warning if an imported file
 is touched
In-Reply-To: <20240717093752.50595-1-sgarzare@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240717093752.50595-1-sgarzare@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 17 Jul 2024 11:58:46 +0200
Message-ID: <87o76w9w6h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 17 2024, Stefano Garzarella <sgarzare@redhat.com> wrote:

> If a file imported from Linux is touched, emit a warning and suggest
> using scripts/update-linux-headers.sh
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  scripts/checkpatch.pl | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ff373a7083..b0e8266fa2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1374,6 +1374,7 @@ sub process {
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $reported_maintainer_file = 0;
> +	my $reported_imported_file = 0;
>  	my $non_utf8_charset = 0;
>  
>  	our @report = ();
> @@ -1673,8 +1674,17 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  
> -# ignore files that are being periodically imported from Linux
> -		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
> +# ignore files that are being periodically imported from Linux and emit a warning
> +		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
> +			if (!$reported_imported_file) {
> +				$reported_imported_file = 1;
> +				WARN("added, moved or deleted file(s) " .
> +				     "imported from Linux, are you using " .
> +				     "scripts/update-linux-headers.sh?\n" .
> +				     $herecurr);
> +			}
> +			next;
> +		}

Thanks, that looks useful -- just two comments (sorry, my perl-fu is
low):
- Is there a way to check that this is a proper linux headers update?
  We'd have to rely on heuristics, but OTOH, we also usually want a
  headers update to use a certain format ($SUBJECT containing "headers
  update", patch description pointing to the version this update was
  done against.) Not sure if it is worth actually trying to figure this
  out.
- A common issue is headers changes mixed in with other code changes,
  which should not happen -- can we check for that as well and advise
  to either do a headers update, or use a placeholder patch?

>  
>  #trailing whitespace
>  		if ($line =~ /^\+.*\015/) {



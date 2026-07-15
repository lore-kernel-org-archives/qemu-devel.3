Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0206C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4aQ-0005gn-Q1; Wed, 15 Jul 2026 14:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wk4aP-0005gf-HR
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:44:01 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wk4aN-0004EF-Nz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:44:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1F2F3DF5;
 Wed, 15 Jul 2026 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784141036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcA3iDQLuiosrfmFcsIs8+m8zsuf5bNbAgyqnhdCkKA=;
 b=kGs/Kcq890kvrQhpq2scw/HmEfuMSUrvcO/oOCV8W9M3P+o7isS6/T7iapNeCYC2pRbyf7
 eKZE9I8PDJQ/0B02dK62429rrxbxsGcxZWpcZ7kc2hXMoGsyJZV54pyiu1XDD/7oL+s+yk
 Mx4+MpNe6QYXOSdGdi3eIKKRHwgGNrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784141036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcA3iDQLuiosrfmFcsIs8+m8zsuf5bNbAgyqnhdCkKA=;
 b=H1iQLuL7qihnbhc/4+tDYdxdZXqz4tssS0IEuxT+/6tEUIo0OewbPRcPA96PUOmbs7iLcI
 kDkWcq4NAno1eaCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=alZVwDA7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x7hch3sz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784141035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcA3iDQLuiosrfmFcsIs8+m8zsuf5bNbAgyqnhdCkKA=;
 b=alZVwDA7KHXjFWyUlggrGrz0UWoPezPW48KnoahPd22Hhzt12ARJfilG1okZurgkiOF/vR
 vpAiTzpEbQtZkjrW2ZZOgDi9Imf6uzYjXSz353nKxfQ5hqe5IplvgdHlfkKZjaYgfVwRiy
 KNE+vD3YHfRGzp5SRlLYAFOHMy33u1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784141035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcA3iDQLuiosrfmFcsIs8+m8zsuf5bNbAgyqnhdCkKA=;
 b=x7hch3szH52+v9wieHPxsu2SehgIkKyj3MEqz1VXAcCQLBmPDoTP3210RrquOaavNOGnNG
 lLa7zaTx9dbIoOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED5F779AD;
 Wed, 15 Jul 2026 18:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LWZQFOvUV2rqSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Jul 2026 18:43:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v3 2/2] get_maintainer: add ability to report Git Lab
 handle
In-Reply-To: <20260715154029.1216464-3-berrange@redhat.com>
References: <20260715154029.1216464-1-berrange@redhat.com>
 <20260715154029.1216464-3-berrange@redhat.com>
Date: Wed, 15 Jul 2026 15:43:53 -0300
Message-ID: <87pl0o3xg6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[get_manitainer.pl:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,nongnu.org:email,euphon.net:email,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E1F2F3DF5
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> With the GitLab mapping files from the previous commit, the
> get_manitainer.pl script is now able to report the gitlab
> handle for each maintainer/reviewer when displaying output.
>
> For example:
>
>   $ ./scripts/get_maintainer.pl -f hw/scsi/lsi53c895a.c
>   Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI, gitlab:@bonzini)
>   Fam Zheng <fam@euphon.net> (reviewer:SCSI, gitlab:@famzheng)
>   qemu-devel@nongnu.org (open list:All patches CC here)
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/get_maintainer.pl | 51 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 76be402e11..9679f27413 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -365,6 +365,31 @@ sub read_mailmap {
>      close($mailmap_file);
>  }
>=20=20
> +my %gitlabmap;
> +
> +read_gitlabmap(".gitlab-map-auto");
> +read_gitlabmap(".gitlab-map-manual");
> +
> +sub read_gitlabmap {
> +    my $mapfile =3D shift;
> +    open MAP, "<$mapfile"
> +	or die "cannot open $mapfile: $!";
> +
> +    while (<MAP>) {
> +	next if /^#/;
> +	next if /^\s*$/;
> +
> +	if (/^(\S+)\t(.*)$/) {
> +	    my $handle =3D $1;
> +	    my $realname =3D $2;
> +
> +	    $gitlabmap{$realname} =3D $handle;
> +	}
> +    }
> +
> +    close MAP;
> +}
> +
>  ## use the filenames on the command line or find the filenames in the pa=
tchfiles
>=20=20
>  my @files =3D ();
> @@ -1068,6 +1093,18 @@ sub email_inuse {
>      return 0;
>  }
>=20=20
> +sub gitlab_handle {
> +    my $name =3D shift;
> +
> +    $name =3D~ s/"//g;
> +
> +    my $gitlab_handle;
> +    if (exists $gitlabmap{$name}) {
> +	return $gitlabmap{$name};
> +    }
> +    return undef;
> +}
> +
>  sub push_email_address {
>      my ($line, $role) =3D @_;
>=20=20
> @@ -1077,10 +1114,12 @@ sub push_email_address {
>  	return 0;
>      }
>=20=20
> +    my $gitlab_handle =3D gitlab_handle($name);
> +
>      if (!$email_remove_duplicates) {
> -	push(@email_to, [format_email($name, $address, $email_usename), $role]);
> +	push(@email_to, [format_email($name, $address, $email_usename), $role, =
$gitlab_handle]);
>      } elsif (!email_inuse($name, $address)) {
> -	push(@email_to, [format_email($name, $address, $email_usename), $role]);
> +	push(@email_to, [format_email($name, $address, $email_usename), $role, =
$gitlab_handle]);
>  	$email_hash_name{lc($name)}++ if ($name ne "");
>  	$email_hash_address{lc($address)}++;
>      }
> @@ -2026,10 +2065,14 @@ sub merge_email {
>      my %saw;
>=20=20
>      for (@_) {
> -	my ($address, $role) =3D @$_;
> +	my ($address, $role, $gitlab_handle) =3D @$_;
>  	if (!$saw{$address}) {
>  	    if ($output_roles) {
> -		push(@lines, "$address ($role)");
> +		if (defined $gitlab_handle) {
> +		    push(@lines, "$address ($role, gitlab:\@$gitlab_handle)");
> +		} else {
> +		    push(@lines, "$address ($role)");
> +		}
>  	    } else {
>  		push(@lines, $address);
>  	    }

Reviewed-by: Fabiano Rosas <farosas@suse.de>


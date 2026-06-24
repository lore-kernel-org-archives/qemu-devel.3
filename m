Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B4CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNSZ-00040B-Iw; Wed, 24 Jun 2026 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcNSR-0003zi-EI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:15:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcNSO-0002sQ-SN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:15:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so883074f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782306955; x=1782911755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxhZ9wZsd0nIw5N0LURB9dLNGBtfR4o1lp53dIR4c5g=;
 b=Q3GSuG5VWwc0XgT4+cSkU+ndMNBAy44w3eUS/yvEW+JZbOscCGGZ3/u2qu6vgFtA/4
 HGeNL4CKOzVAe2MD4heVHRHwiRm/wU7sLGvtzoODX8fg6S0NsyE8HZPr8MYYZTcqBDpd
 ou0lrsZUvOP4n55PCVu/B2q5n4PnBzHqGG+9m+Ev3XLkIbokp7+2EnlplJ+CeLnZkulc
 CR95ME4cRL8utDjKX7WQNjEZF1+SzZ6BOsPBJjgKDXUoIRsQN6d5TZMPW1tHi5as3caT
 RG+AnsQBmUSAELaq/d4QKEGbci5evnEA+PDEcXHjTFu4Np9yABHftYK640OmC76a1jKw
 XGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306955; x=1782911755;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GxhZ9wZsd0nIw5N0LURB9dLNGBtfR4o1lp53dIR4c5g=;
 b=d8j5DSehgjUULAhaYAu6nsibRVQsGV5G2qJzyh/zZ2YCs2brlcue5ScecoI6O/VU9H
 65kiCYWwJBJ1BLOfvDCJqUjGeNlBCb8ZTEHNIneY6piq4EiQxkdAvhxixtyM7COFEbX7
 kMm5gF+RuFhaPDBrnSJR/DVHXUMBgvdo3AGJ2NoyYHxw4PzX0OXL2DFkaezUkF8XQ+1V
 K3uxRdTXo6oIx3xT73GZ8vy2IzcYnsAmODYLNsJJudXQB7EYdBZfQVAGGELPFuIBD07r
 J4/5ZCljzMtUozZmcA9ZC0segMQzrQU4TJ3w1MPOTRkFJFSKtNdTZzhp2nT/8HW56jWJ
 In2g==
X-Gm-Message-State: AOJu0YwHjiLdgHfIi3BCLEArfmkkWEnvBC/etWbLgcmm4iThw5Jvqj2M
 6+1PDQmXN8++1eKNKbi5X9ry2DYO2Bs2b5Jp0ywhO8LUP7OeN9l3o6+KhgYZI2u6YjHTRuyni71
 tspAU3Vg=
X-Gm-Gg: AfdE7cm0/SlXlNHaUnPJfjrBP4KfpA3RG0EEIA3wdFUQaM5QJLksG39ZwYJ2xio5T5O
 OKOJuJWAUG0BEHGfFQYjNKPQrFxyZFQ47o6qJodoVBok5Pyocp61fiK5PzaNOUam4GgAM7c4MSs
 BpYIC8jnTv7+ON7F5nW6qgrNyQ5nda5QBY1iPzvQ58j7o/pV0xF7A+Uiq3ngZk4JcS46RE5hR6y
 JY4k28TfR5dCSjDBEz8cSRLoD9jmexvd3a5Kj7nvEYrbsF6CSAUjaUxeqrX7Bm959k8U2rFyoDf
 2lzOrZNDJQmvFk3jxyT2GnWZX8pFFebupg8/+LMSxBuimOWXpULdDsmKEJib50YhxYkYHxxIg9o
 7Ec8krkw+rzftjaVLqqZUEmJ4XQBSujy6ilsU05ebzKRG+/ysj9YecepCNn9aTGHzw4lNCuL3xj
 WaQ2+GW1bP6X8e
X-Received: by 2002:a05:6000:18a9:b0:460:70d1:c75 with SMTP id
 ffacd0b85a97d-46ad90f5d09mr12054946f8f.13.1782306955009; 
 Wed, 24 Jun 2026 06:15:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c225b2988sm6428913f8f.25.2026.06.24.06.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:15:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7808F5F803;
 Wed, 24 Jun 2026 14:15:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/2] get_maintainer: add ability to report Git Lab
 handle
In-Reply-To: <20260624122936.2706393-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 13:29:36
 +0100")
References: <20260624122936.2706393-1-berrange@redhat.com>
 <20260624122936.2706393-3-berrange@redhat.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 14:15:53 +0100
Message-ID: <87ik78krjq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I suspect it gets tripped up by utf-8 stuff:

  =E2=9E=9C  ./scripts/get_maintainer.pl -f contrib/gitdm/aliases=20
  "Alex Benn=C3=A9e" <alex.bennee@linaro.org> (odd fixer:GIT Data Mining C.=
..)
  qemu-devel@nongnu.org (open list:All patches CC here)

misses my tag.

However I think this approach is much cleaner. The other option would be
embedding @refs in the M: line:

  M: Alex Benn=C3=A9e <alex.bennee@linaro.org> @stsquad

and letting the script handle it. But I didn't want to hack on
get_maintainer.pl which is why I started playing with a python version.
However I need to add some features to it to reach usable parity with
the perl script.

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/get_maintainer.pl | 42 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 76be402e11..1f518b6792 100755
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
> @@ -1077,10 +1102,15 @@ sub push_email_address {
>  	return 0;
>      }
>=20=20
> +    my $gitlab_handle;
> +    if (exists $gitlabmap{$name}) {
> +	$gitlab_handle =3D $gitlabmap{$name};
> +    }
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
> @@ -2026,10 +2056,14 @@ sub merge_email {
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

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


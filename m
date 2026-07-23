Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F2FC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmna9-0000bX-7v; Thu, 23 Jul 2026 03:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmna8-0000bD-1m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmna5-00052q-P1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784790656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S8KJFivu8nsyF74exGyGdOAxF7AaGGa++oQFfgoX9uc=;
 b=Oh6fA3KALH3LP0n4ekYbKQAECx2qREIYBx3F7FC/YLJ/mtLzExkDyo9KLCywfbi3PY0DEH
 Pj8Izb2iu73Mwxxdrk/F7gqkvGNV1frSHEEOMe7UztJRvbZdbUX8P96nIbCYfuuzB+O6XL
 Jo3bcZ/6zjEfX254DcsWZcGcbYzv//U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Q4nNeXc6O9SB2HcbqVpxwA-1; Thu, 23 Jul 2026 03:10:54 -0400
X-MC-Unique: Q4nNeXc6O9SB2HcbqVpxwA-1
X-Mimecast-MFC-AGG-ID: Q4nNeXc6O9SB2HcbqVpxwA_1784790653
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so163616f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784790653; x=1785395453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S8KJFivu8nsyF74exGyGdOAxF7AaGGa++oQFfgoX9uc=;
 b=pPyxX/rkWnGVMg8TP0chvO7KNKxf2X25Ld4c3msvdE7wMGWkAodYonuTuD0F0WDAWH
 UmVcn0vIa/GLXXKCKo08MbmLkdcq2hvRhMb+AHl6cVM0itrRBs+vo0IpcR7Oqe2EyIah
 P3cleXFGZSEegMO1uPfTWnTJQgTEl3TsjQ54XLkuKW8mO4JLpliqae786Bb9uz3roSqs
 Sn84FIl9qdQGf+vOQkMZDMcsikpmcprwzhfpCT0440GjdyqvRtv7+tUWftao0kAaATc8
 TuRlyJaAnYw4zcDMcPCGNLf5rBX7J5MkDojh/3FlW9/KPsST8N1+wtEr4Kd/5oci1Qd5
 he4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790653; x=1785395453;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8KJFivu8nsyF74exGyGdOAxF7AaGGa++oQFfgoX9uc=;
 b=bWSsDYeCAx4Jx18XpKPw5nDOmCn0fxLBOpaDzjY7wJ0B6UFaA0lMNmCX5xAA8x+zrR
 Lagp/+yvSHr0u49H6GXK4BkZktMb7kzY49PevAVdFnQB+FCVPauCtVK04TtiYhshISTj
 VykszUIVADpzeUzbXkljwoLX4k0bDf8+psd5t1GDEWxv6qDyhKm5O2KQC3pB35ipCkNu
 L10pneNWPW7meKuTbalts8d8+/sPgkOlp1RR2xD7q3BN1nOogYTarlI9SfCtjR5EsQy9
 QuHxCGSQHyt7Urt4IF9mI2g8erEEPPQ59FFVfkBScEBcc2k8oBkMD/DwF9qp7fbpax2A
 ACRg==
X-Gm-Message-State: AOJu0YwhqVLIV/cifekAZmV/vVKqu7vd88Jt8O/Fq0lHnMfb8Q/bjwKO
 Qa9C4Qyd+XPrsUXq7HzxU+CbgK0oLgn+vi74EDEc2DrM6FMn48v7Xo+yAUAKuAkGz16qGnX/L8I
 +EFZLAuvPyRKm/4/uqZ71+WWI/PipVe6j3/u4n82REd2GRG9qAwaCk2VQ3wTejeyMCci5ivKmsk
 ovK8d2Wq1wZRFVepFRBcRm5fZR2JZcbAmfLw==
X-Gm-Gg: AR+sD10Pjb4wc4StXWHwH0fxlBzpFCcm1s6LFsFJlXa/hSo3TAD7MOVdPLxg4y5Ctd9
 YEdMuiFjWuOqKMOgspfJJI/RjpowWzBTDiKnK6TSwRsRvamKQgS4yhwXY498wCnafEmMuo3VT3a
 3cd3GcfIdzPdoRCfSX/nVZQ1xivm18Mct+fKcG+A4jnkiPJpp5+mcS/j/wkxF8cDO9xgtq7f8z9
 Pzg0r5vwqdLq+QCH2mwKtuDkH45oKbl9i4iEET1JtyfONIDBaQ8HWb8MQ6xrYT0uno3WnakgEbe
 YmF0Ec7ViwyyEYWGry0AfaFO9Q/fKWce8hHgCedQrJl8T/DpbIMZXix9SbKFJvkLfi1oyWSWV2G
 Cf3+3edrkzA0W1kmgm4KYUi7rkoZQ1H0dXevuFRI=
X-Received: by 2002:a05:6000:40df:b0:47f:539f:9f82 with SMTP id
 ffacd0b85a97d-47f8d754a48mr2392132f8f.39.1784790653135; 
 Thu, 23 Jul 2026 00:10:53 -0700 (PDT)
X-Received: by 2002:a05:6000:40df:b0:47f:539f:9f82 with SMTP id
 ffacd0b85a97d-47f8d754a48mr2392074f8f.39.1784790652513; 
 Thu, 23 Jul 2026 00:10:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6287csm13105416f8f.25.2026.07.23.00.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 00:10:51 -0700 (PDT)
Message-ID: <e7fac95e-1ac5-4da4-badf-dc1415f7203e@redhat.com>
Date: Thu, 23 Jul 2026 09:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>
References: <20260723065320.1314072-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260723065320.1314072-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/23/26 08:53, Cédric Le Goater wrote:
> Adapt the kernel's checkpatch Fixes: tag validation for QEMU.
> 
> Add a git_commit_info() helper to resolve commit hashes and validate
> the Fixes: tag in commit messages. The canonical form is:
> 
>    Fixes: <12+ chars of sha1> ("<title line>")
> 
> The check validates capitalization, spacing, hash length, lowercase
> hex, and quoted title. When the format is wrong and the commit can
> be resolved, suggest the corrected Fixes: line.
> 
> When running inside a git repository, also verify that the referenced
> commit is an ancestor of master.
> 
> Lines matching "Fixes: CVE-*" are skipped. The check can be disabled
> with --no-fixes-tag.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   scripts/checkpatch.pl | 70 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..65ca7d4c5e47c6eeb48647e877b8afb573176f6b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -21,6 +21,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
>   my $quiet = 0;
>   my $tree = 1;
>   my $chk_signoff = 1;
> +my $chk_fixes_tag = 1;
>   my $chk_patch = undef;
>   my $chk_branch = undef;
>   my $tst_only;
> @@ -54,6 +55,7 @@ Options:
>     -q, --quiet                quiet
>     --no-tree                  run without a qemu tree
>     --no-signoff               do not check for 'Signed-off-by' line
> +  --no-fixes-tag             do not check for 'Fixes:' tag
>     --patch                    treat FILE as patchfile
>     --branch                   treat args as GIT revision list
>     --emacs                    emacs compile window format
> @@ -94,6 +96,7 @@ GetOptions(
>   	'q|quiet+'		=> \$quiet,
>   	'tree!'			=> \$tree,
>   	'signoff!'		=> \$chk_signoff,
> +	'fixes-tag!'		=> \$chk_fixes_tag,
>   	'patch!'		=> \$chk_patch,
>   	'branch!'		=> \$chk_branch,
>   	'emacs!'		=> \$emacs,
> @@ -441,6 +444,10 @@ sub build_types {
>   build_types();
>   
>   $chk_signoff = 0 if ($file);
> +$chk_fixes_tag = 0 if ($file);
> +
> +my $gitroot = $ENV{'GIT_DIR'};
> +$gitroot = ".git" if !defined($gitroot);
>   
>   my @rawlines = ();
>   my @lines = ();
> @@ -561,6 +568,28 @@ sub which {
>   	return "";
>   }
>   
> +sub git_commit_info {
> +	my ($commit, $id, $desc) = @_;
> +
> +	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +	my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
> +	$output =~ s/^\s*//gm;
> +	my @lines = split("\n", $output);
> +
> +	return ($id, $desc) if ($#lines < 0);
> +
> +	if ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./ ||
> +	    $lines[0] =~ /^fatal: bad object $commit/) {
> +		$id = undef;
> +	} else {
> +		$id = substr($lines[0], 0, 12);
> +		$desc = substr($lines[0], 41);
> +	}
> +
> +	return ($id, $desc);
> +}
> +
>   sub expand_tabs {
>   	my ($str) = @_;
>   
> @@ -1811,6 +1840,47 @@ sub process {
>   			}
>   		}
>   
> +# Check Fixes: tag format and commit validity
> +		if ($chk_fixes_tag &&
> +		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})\s*(.*)?/i) {
> +			my $tag = $1;
> +			my $orig_commit = $2;
> +			my $title = $3;
> +
> +			if ($line !~ /^\s*Fixes:\s+CVE/i) {
> +				my $tag_case = not ($tag eq "Fixes:");
> +				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
> +				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
> +				my $id_case = not ($orig_commit !~ /[A-F]/);
> +
> +				my $id = "0123456789ab";
> +				my $description = "commit title";
> +				my $has_quotes = 0;
> +
> +				if (defined $title && $title =~ /^\("(.*?)"\)$/) {
> +					$description = $1 if ($1);
> +					$has_quotes = 1;
> +				} elsif (defined $title && $title =~ /^\(?(.*?)\)?$/) {
> +					$description = $1 if ($1);
> +				}
> +
> +				my ($cid, $ctitle) = git_commit_info($orig_commit, $id, $description);
> +
> +				if (defined($cid) && ($ctitle ne $description || $tag_case || $tag_space || $id_length || $id_case || !$has_quotes)) {
> +					my $fixed = "Fixes: $cid (\"$ctitle\")";
> +					WARN("Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")'" .
> +						" - ie: '$fixed'\n" . $herecurr);
> +				}
> +				if (which("git") ne "" && -e "$gitroot") {
> +					my $hash = defined($cid) ? $cid : $orig_commit;
> +					`git merge-base --is-ancestor $hash master 2>/dev/null`;
> +					if ($? != 0) {
> +						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
> +					}
> +				}
> +			}
> +		}
> +
>   # Check SPDX-License-Identifier references a permitted license
>   		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
>   			$rawline !~ /^-/) {

Here is a test patch.

C.


 From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Test User <test@example.com>
Date: Wed, 23 Jul 2026 12:00:00 +0200
Subject: [PATCH] test: exercise Fixes: tag validation

This is a test commit to exercise checkpatch Fixes: tag validation.

Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
Fixes: 1a0c32a9da ("vfio-user: add coalesced posted writes")
Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
Fixes:36227628d824 ("vfio-user: implement message send infrastructure")
Fixes: 36227628D824 ("vfio-user: implement message send infrastructure")
Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
Fixes: deadbeef1234 ("nonexistent commit")
Fixes: CVE-2026-16288
Signed-off-by: Test User <test@example.com>
---
  hw/vfio/pci.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1234567..abcdefg 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1,3 +1,4 @@
+/* test */




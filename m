Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275EBC54F52
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp098-0000x5-Rq; Wed, 29 Jul 2026 05:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wp095-0000vc-8q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wp08z-00035q-4T
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785315603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rEAgyHgUiwjjZohr6NjYMzk29ss2CHPSf2kKEotSxaI=;
 b=OHyHTV9jncV/kwTbHVnZtvxk3z5HklykytXbijJ8iV6GOJby5J7nWEIqfyIOwXMbEXScfi
 eaN+6FKHanBQJa64iNAJWMJ6q2gIFzy4LXiQxjMtbdJT6lNa93FF4eaQ8+MohaAb7hOvsS
 8UBLEqE8h0sCb5R379Jlr6ASHGSjzkU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-hpzuIPqHNNqiIzDEb-94Gg-1; Wed, 29 Jul 2026 05:00:01 -0400
X-MC-Unique: hpzuIPqHNNqiIzDEb-94Gg-1
X-Mimecast-MFC-AGG-ID: hpzuIPqHNNqiIzDEb-94Gg_1785315600
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so6578345e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785315599; x=1785920399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rEAgyHgUiwjjZohr6NjYMzk29ss2CHPSf2kKEotSxaI=;
 b=j3t60cnyL/MD1BjYCpR08hD23jrHsCBr1yvM/0LWnRaG3qajPwSjGTyuGtQb/jvCbY
 pW+4XecRu1xAeeTR4UEbj/7lZiMlfLT59IeyxxksmmqTYly23Yid7fVsuiHSg2gc++Kw
 F/2UynU9ZvOAkzmfe8QFgGAljEn2ErocVDWYKdD8WVtiOA1lYpNHMNQ1qaKrNYoUmUYy
 vrQjgcnKuRDpK9mbFcBMCPDJasSyi7Df07AEjWn2fa/zKIITijW7BAZYhwI4hb6nlonv
 VzQbHrQjsWDcWxJotxQTl5XgOYxtjS8piBxTyAeExXzIMt+z0NYisiYFLToK1mFEyAVL
 xWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785315599; x=1785920399;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEAgyHgUiwjjZohr6NjYMzk29ss2CHPSf2kKEotSxaI=;
 b=J65n3brb6EEBgSE+LstG2W+A/AiM/zxS/ieKp1rsVuNQkdFfED1DSLgZJoofBTsElW
 TINd7DiPqogHu11V2lwbPWfFQvehRrsH0dRcx05pjOcUtSVjSXAu+q1lGvZX2a9YHkZ+
 Iwy7jkc2cdXIxdW7yUtSpVrACtzM7jxphf2uoM3j2lZne0yNNk9PdJic9c3Pr/MRCGAm
 WFM6AkAHj/GdZdwamjtySzcQUd0kO30Fa2srGwHa0BLiv2FG4GWf95RpmqgkIwa+aodc
 kMy0lIskD3LDurimgooMWttn5KHhhgX+KwlSd69kUstgdrwH5aQwSS5SVzOM6Nu4WTwy
 LSyA==
X-Gm-Message-State: AOJu0Yzvxcyk4P8eHDFtYtNVjcKS0SqdDowZ69P1DwdSX7Qo0K8XNmRB
 bOBNdL5aHUIYTvbH02OiIl5olfZFz8l6b+PhmTriIK7oG3Cachesxp55oi75waUq07oyCPDBWQJ
 YQfAtObfN2d1vzrEFV+yQooIMY7RUONbygIpkJw0tLRirNZu4GPe8bjcCT0tqYxN4uEhuKMt4Uc
 5tZ2e7ph9KUwTo1LHqTnWBFbN2z/aRmGwitg==
X-Gm-Gg: AR+sD10yjIpxmggG7+x1dhaFe6MCNf+uRhsL4pYvghP81k8FW5MuVWuQeFms0FXOg6s
 0NJ33TBnP+b/IvivkqijN80FH/lCf5uDH+gNqqwlHsN37DxaYc7oGoA2O3dPasQ01GYhT9WEcGB
 DNwYyP6SfsTcnYJYfGfYt5RqGnMApgO2tpyfYymVvfOhf76bAUEaFXsKxO7B3InjPBUo2F0V2Yx
 2GlMjkpVWGGnpfEbpwpQoQ3TTYnwjQa3HZx5FiC0u44Y7jbrmf6m95peybzTkx7yCJMtC3NGyl8
 BR74uMytZrgz/J60fOes8hpRp2z0CLF31lNTSrDysUhxFiHNgAevEpv1+GidTZbxxakAXDbB6T/
 Z5XPbd6XcvCBXeBiywgQdclNfNp/R/47HYfG8qm8=
X-Received: by 2002:a05:600c:34d6:b0:496:c18c:f998 with SMTP id
 5b1f17b1804b1-496c657653emr62302075e9.19.1785315599721; 
 Wed, 29 Jul 2026 01:59:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34d6:b0:496:c18c:f998 with SMTP id
 5b1f17b1804b1-496c657653emr62301705e9.19.1785315599294; 
 Wed, 29 Jul 2026 01:59:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6abc703sm6405446f8f.9.2026.07.29.01.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 01:59:58 -0700 (PDT)
Message-ID: <db26deb3-60e4-42de-9157-35079d85c253@redhat.com>
Date: Wed, 29 Jul 2026 10:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scripts/checkpatch: validate Fixes: tag format and
 commit ancestry
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>, 
 Peter Maydell <peter.maydell@linaro.org>
References: <20260727122446.150456-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260727122446.150456-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/27/26 14:24, Cédric Le Goater wrote:
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
> 
>   Changes in v3:
>   - Dropped $git_command
>   - Modified git_commit_info() to use $! instead of parsing stderr when
>     calling git log
>   
>   Changes in v2:
>   - Introduced $git_command
> 
> scripts/checkpatch.pl | 65 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..069e2b53c996580717fcbde4c68f3ea6aafcccad 100755
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
> @@ -561,6 +568,23 @@ sub which {
>   	return "";
>   }
>   
> +sub git_commit_info {
> +	my ($commit, $id, $desc) = @_;
> +
> +	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +	my $output = `git log --no-color --format='%H %s' -1 $commit 2>/dev/null`;
> +	if ($? != 0) {
> +		$id = undef;
> +	} else {

This is needed here :

                 chomp $output;

Will send a v4.

Thanks,

C.

> +		$output =~ s/^\s*//gm;
> +		$id = substr($output, 0, 12);
> +		$desc = substr($output, 41);
> +	}
> +
> +	return ($id, $desc);
> +}
> +
>   sub expand_tabs {
>   	my ($str) = @_;
>   
> @@ -1811,6 +1835,47 @@ sub process {
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



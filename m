Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFDCCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJUt-0001Ej-WE; Thu, 15 Oct 2026 07:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHJUs-0001DM-3q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHJUp-0003hc-J5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UBZ8WFYovnAdP0tMBsQkLxEh8kO+0JQJCgAVpXOHzAw=;
 b=ZnIQJi3gt/CS1JJCHJ9owPFXdKBkrcvrjxm1OlEpPSdgTqB35ER3//l82YjGH8Slx8x7yr
 ABnM/YVVZD5iA5kXxqQogr+rf4dXayUz4Y2GOKsXpt+V5lK6TFVgalxJX2jz0Vqt2M1NhY
 H/Mcq8dvSCMFTWDgGbRDVURRWSny3S8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Re6bhybcOJOtpqocKKpxSw-1; Thu, 15 Oct 2026 11:19:34 +0000
X-MC-Unique: Re6bhybcOJOtpqocKKpxSw-1
X-Mimecast-MFC-AGG-ID: Re6bhybcOJOtpqocKKpxSw_1792063173
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b0679906dso3197488f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792063173; x=1792667973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UBZ8WFYovnAdP0tMBsQkLxEh8kO+0JQJCgAVpXOHzAw=;
 b=dbpipkuEGzooIfNEhaNDyRr4wPlDf4zU619F7Kgp2bYaFZYI6WiW7ESO2/Ww6jbIRN
 7t4uQlVV+KJQLl8A0lxlvu0vPQMldQX8FYcIx9McDfn7yjRu1g6JsTQDgdM20OCFcpP4
 XZ+DNYOSap5zx+eHVNR0ZRrMw5V39wV4f46ksznu0y/JSMmfB6q3hisEMfptD8wTEKRC
 cGwDjPoh/cqFDEcVL6CdP8xoFbKoh1ejBhZK2DelcvF40alF81070ff5V/7ILVdVknrP
 dLFCRpndmEmAJvG9oITo9YZ6OYNW6ZSI4/zWiV//RJj6Dol1P7WWaXxHbUq2aKYXYGck
 pOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792063173; x=1792667973;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UBZ8WFYovnAdP0tMBsQkLxEh8kO+0JQJCgAVpXOHzAw=;
 b=jbgpYzQ2qP9cRoGlM1UKtp9M5JAHNpBGcjsCa+ijYgH8GQcNBFH84haOf4/B+Qqmke
 yiEq+Tsw0cTDan90hD7HXq87pYpltn7/UoY9j+ZFuun8ykQ1HVDoZieREnoIFKp3TiOK
 /XlSZydEO2Ltw4IyMW+QcqccIhmyBnMaoyxxn0FDEizFBbJEU6V6yC44A+h2UJSFenot
 TTkkCm/QB8WEi1/lCUr4mfQ3T2/1zsEYHWQilvxPuAckuVqSu2ORqPz/3VrOKy9MiuDb
 MGmMn/3Nehdl/2u/TsoaXd3zoGYJoQjgfkcr/C2wwRduQz6Ly1fZSJUsxPvm224LnhD1
 KCug==
X-Gm-Message-State: AFq9FYK/FJ0sEdw/1jwTpxxKN6hkccLKnLHD4CxluVZox0YhpfxPRZxN
 rOSPwThyQO2wEge+LnHI3IteDctjohW5GuSBw/lRIGyfdnTK3I87AUSAtB6sdI4HEMSDcXDv0qD
 HHKuOzyqryUloGNAMEdRULeLVpkAct6/HHKnG+mUdKlRstxul33JQHTRqHcO4u5nQucbDR4rH2/
 wkeJ7OJMU0FH/4vcm7wQ2IKYP1gT97WEC0rA==
X-Gm-Gg: AYBFou16Qz2pGiMhyb4VUKqouNdqHGAfyqrReChsRchh9jhSJ1sfuDqXS4baf2qwjZT
 FoP7hYua4Sc44WhS3jZ9AZ5y2VGqV1PsfBJ919d1bsZeJWnpAnBL3MzONbnM/X88SPymyehcLM4
 Kkr4ReYvoe8WFDNmfSpTjjtFAlRstBOU0k9g06wqjLox/JTQtIP0yo44akB8ulntObKHaDDBjVz
 BeVR/4Q135DlnTLSUUvJcHKKpLeb+9NWGSpdOMuOSdo/4YLjXcOBTVzBYRwNcpEnj5VO/zJ27gu
 X8XZhb7UAAeSWGqzU9pRot1B3upCHO+7r2PU1qblz0DsJswDQl9kICIn8ot3QbeUIH6vNp9AAIY
 6o6mp+dnu3KpcbO6QvAuRHzWcm2j8XMuMbE6PkMEV
X-Received: by 2002:a05:6000:4814:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48dbaadaa3cmr33831904f8f.10.1792063173363; 
 Thu, 15 Oct 2026 04:19:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4814:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48dbaadaa3cmr33831848f8f.10.1792063172869; 
 Thu, 15 Oct 2026 04:19:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48defca3fd0sm7541088f8f.15.2026.10.15.04.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:19:32 -0700 (PDT)
Message-ID: <9534645e-c37f-4dff-ba35-405731b145a6@redhat.com>
Date: Thu, 15 Oct 2026 13:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/checkpatch: validate Fixes: tag format and
 commit ancestry
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>, 
 Peter Maydell <peter.maydell@linaro.org>
References: <20260806171333.328864-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260806171333.328864-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 8/6/26 19:13, Cédric Le Goater wrote:
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
>   Changes in v4:
>   - Added chomp to fix false positives
>   
>   Changes in v3:
>   - Dropped $git_command
>   - Modified git_commit_info() to use $! instead of parsing stderr when
>     calling git log
>   
>   Changes in v2:
>   - Introduced $git_command
> 
>   scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..d9efade05386b3fb7647097cfe3b1256d7f24dda 100755
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
> @@ -561,6 +568,24 @@ sub which {
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
> +		chomp $output;
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
> @@ -1811,6 +1836,47 @@ sub process {
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



Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.



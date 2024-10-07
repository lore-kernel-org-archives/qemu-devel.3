Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFF5CFB45F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxu6o-0007vM-Mt; Mon, 07 Oct 2024 16:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxu6n-0007vA-FQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:13:33 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxu6i-0001xm-Pu
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:13:32 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7154e7b915bso2403852a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728332007; x=1728936807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGE8fK7tq1KAv2ajvfrCLf+VIg8rAiM45bzV1J4Y8MI=;
 b=Y+P5SXgPUZdnFWTY+36opiw07dsIk2Eyowea6W50sISt2FLWHr91SDEvtc0v2f1iVV
 g96o6xLGiqSFTFGW+qpNeEXGWT9duYXbXb+nQqQSHwnXsHngtKdMkH9kaF7TaJtrB6au
 EXF91x3x8utbFkoBGmseEwFhum5dZaeeqxRoyPGxBtZjUSR4dmrQY6BsU1QqHTFRHTuA
 wSwcD19U9XDo5VBNFcBI1W9mUhEBqJDpnKYpf64w5T+Ogk+zyoEO39t/R02Ulwp0yHKS
 lITtYAWcPk1Jl+C9v29fZcWwGEH/GFw6AjUyOPFzssEBPMm2BlMaf9lU8oo+tF9vR/IQ
 L3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332007; x=1728936807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGE8fK7tq1KAv2ajvfrCLf+VIg8rAiM45bzV1J4Y8MI=;
 b=ZbCTokX+kfuun8LaNxV4e7Tc6PKCLNhI6OwEB09bk+bg+RR+w7kUMa9AftWiBe+d0A
 QTwzdisetHUKVQzDtk8OT82AjLhXNsSjtcZpD1A6XrSnoAWiiFbvPioBOVn/J7/dqcQj
 eOTQ0RcwaSLauTkDYx1fUNJ1wBEQYPJLbUNFM9q6VxTQs1fdOuomQIdjNDSftr2qNcmg
 kv0zgdamBtzHA45AX2gNXHfyh7+wfTYir0gZc5N9gmePXxGqIp0yfs0d8vzKkpGh2P2D
 ErR7UmJk8vBQOYaVRW45maHvvFxndVnnb5um23vYJdG++ow1Gjy4KsDkOkgvysJbHV3J
 h3yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp29OfT4VVwpiYE7NJQImGcNk7F4rRWUbpnb+CfFGDdzLXGvbNCmpCmuKMc0Zz3LzTvHNeoQPpG7cj@nongnu.org
X-Gm-Message-State: AOJu0Yz8GGBD70ykN2uxClpTVmRJ98Stf/6IPG3ZrVwGDWJeFZfB5TKv
 ZBt9JxLr+kPzqgnNCdxCoIekRkoGmrdpdNErxgyzYDGuYA/PI5VrqIaK7MJyJ1M=
X-Google-Smtp-Source: AGHT+IEc62em9L2PY5H51QPEG6T9u7TN8/uLRmi23qZAXEHc18t7cvff4seIq9pdJ87OXr/UHrLgYA==
X-Received: by 2002:a05:6830:2642:b0:713:7e24:6151 with SMTP id
 46e09a7af769-7154e97ab18mr7558082a34.25.1728332006776; 
 Mon, 07 Oct 2024 13:13:26 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f682decbsm5427093a12.45.2024.10.07.13.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 13:13:26 -0700 (PDT)
Message-ID: <cc177f5e-123e-4c5d-9b6a-a3515a9bc863@linaro.org>
Date: Mon, 7 Oct 2024 17:13:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241007154548.1144961-1-berrange@redhat.com>
 <20241007154548.1144961-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241007154548.1144961-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-ot1-x32e.google.com
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

On 7/10/24 12:45, Daniel P. Berrangé wrote:
> Going forward we want all newly created source files to have an
> SPDX-License-Identifier tag present.
> 
> Initially mandate this for C, Python and Perl source files, and
> encourage this for other file types.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b21249c91..cc266abdcd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1378,6 +1378,8 @@ sub process {
>   	my $in_imported_file = 0;
>   	my $in_no_imported_file = 0;
>   	my $non_utf8_charset = 0;
> +	my $expect_spdx = 0;
> +	my $expect_spdx_file;
>   
>   	our @report = ();
>   	our $cnt_lines = 0;
> @@ -1615,6 +1617,30 @@ sub process {
>   			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>   		}
>   
> +# All new files should have a SPDX-License-Identifier tag
> +		if ($line =~ /^new file mode\s*\d+\s*$/) {
> +		    if ($expect_spdx) {
> +			if ($expect_spdx_file =~ /\.(c|h|py|pl|c\.inc)$/) {

[ch]\.inc to also mandat for *.h.inc?

Otherwise, thanks!
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +			    # source code files MUST have SPDX license declared
> +			    ERROR("expected 'SPDX-License-Identifer' in new file $expect_spdx_file");
> +			} else {
> +			    # Other files MAY have SPDX license if appropriate
> +			    WARNING("Does new file $expect_spdx_file need 'SPDX-License-Identifer'?");
> +			}
> +		    }
> +		    $expect_spdx = 1;
> +		    $expect_spdx_file = undef;
> +		} elsif ($expect_spdx) {
> +		    $expect_spdx_file = $realfile unless defined $expect_spdx_file;
> +
> +		    # SPDX tagsd may occurr in comments which were
> +		    # stripped from '$line', so use '$rawline'
> +		    if ($rawline =~ /SPDX-License-Identifier/) {
> +			$expect_spdx = 0;
> +			$expect_spdx_file = undef;
> +		    }
> +		}
> +
>   # Check for wrappage within a valid hunk of the file
>   		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
>   			ERROR("patch seems to be corrupt (line wrapped?)\n" .



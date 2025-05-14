Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B8C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAfF-00081o-Jk; Wed, 14 May 2025 07:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAeW-0007UP-Tw
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAeQ-0006dx-1x
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ctXuAakmFcx34A6aGkq3dI8wFAyoaMwgDCxasASujSY=;
 b=N0GdwPQqrXFzesu7poXMcnc/q62Hv80POp2KGn/zN9tN6t7IUB5jYFth4MUWTM3thuX9qt
 /NlusRfoerXqvhTQRdEYIznjfDij6Itf0ZdbKGy1k/n9i9nDuc0AVE6ZA2pyTDU7Fak56x
 WGi44GIQaNBfwDLgbMhNHd+47tQFmn4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-eb2-VzwgP_u9GyDiLKjoBA-1; Wed, 14 May 2025 07:51:50 -0400
X-MC-Unique: eb2-VzwgP_u9GyDiLKjoBA-1
X-Mimecast-MFC-AGG-ID: eb2-VzwgP_u9GyDiLKjoBA_1747223509
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b1798d69so2503201f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223509; x=1747828309;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctXuAakmFcx34A6aGkq3dI8wFAyoaMwgDCxasASujSY=;
 b=efUzQ8xxx/AGaNfjPKWINmL9PQ9QvhP9WzV0hRD57H0p5SxepARaEYgj8F4e6/B/Mu
 B8YK8x/yhWGLGzTxb5/koJAfWCl1lR1ij2HL/Gy8JTdbZZSIBJbiZVIN0oeRweIS5iu9
 bZQo3HYJ3yBiV/Z5bZWNykhE98639UNRFpDId5A7d1KsXcvJ9dpXgMizrRXvZ3UeS5qc
 ueLLEHbrvfrlGJLfv0LS9xnogXil5MLulBnRLipZsnJ0UNJCxg2EEiT7eve7mfJcSU9K
 VwVyc/wYqTOrB/yWc7bKHZ7+daKxB6TR++gElVMWW7gOTQIPXEtvQR/ekVHL1wbu4RNq
 YDHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdEcqUmo2F28FeqMGPFhTsjAgk0EbR7VwErCcxxPn6mXSIOjt4QoRabIFvUQVeKlqymJ+huMSf3ae4@nongnu.org
X-Gm-Message-State: AOJu0YwNeuos/+YmNzE0k/kq5GhUJnw0KsExrA07MSZX18ZlPpPXBLkW
 dFFXvAs2dFD9P3wDB4JM9gx0gCa6B7IXoDSz74HFvH+O6LR5QrBJPHCWojzBjMyrvY25yNN2RjP
 DN7wBHNki+lhLWJx+j+JHFHCxDtTTPUz4Bm2AajSWM6/VFhV39xKZ
X-Gm-Gg: ASbGncuBPIDowAJRg+hKZuqT1qX51YDA9TpGZXv03sA3Q0McpJNH5T5rPwlqXUgnBgb
 prIIvkn/eKr+3hFvPL67hv5+MYK6gTQIJRi7tPIt539ALULXP05911Jp3zzawVjKBA17f9aIkyx
 vq6jBqjMN90wtMEfAk51WhHCTykPpzYFbOrKgikH4xxKwY/NdtNEPhiejap/DlTsIMzIMoQOoG9
 uYh8p86EgCfWpGHFzwbxJKnUptqkFpujGXfWNNj0VOtyhun/SqXsKy5d4d7KVUZGIPe8JFDN6eS
 YdidqVAnWI2EFcknENbkudUZX9aeTR+pWIeVNYMy24rzfYpA2A==
X-Received: by 2002:a05:6000:18a2:b0:3a0:90c3:eb0f with SMTP id
 ffacd0b85a97d-3a349699812mr2036287f8f.12.1747223509134; 
 Wed, 14 May 2025 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVy60rMm6OYrGDxV3xN/20xCI17FDNfXfPwiH2ldt5Dyo6t2MKHilyYbqNzQfPwsk/Z2qgZA==
X-Received: by 2002:a05:6000:18a2:b0:3a0:90c3:eb0f with SMTP id
 ffacd0b85a97d-3a349699812mr2036272f8f.12.1747223508759; 
 Wed, 14 May 2025 04:51:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de0b2sm19781024f8f.19.2025.05.14.04.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 04:51:48 -0700 (PDT)
Message-ID: <d1af8abb-05c1-4ecc-a513-0db6c1e82d56@redhat.com>
Date: Wed, 14 May 2025 13:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] scripts/checkpatch.pl: fix various indentation
 mistakes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-3-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512182447.1139105-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/12/25 20:24, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Various checks in the code were under-indented relative to other
> surrounding code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   scripts/checkpatch.pl | 98 +++++++++++++++++++++----------------------
>   1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d355c0dad5..7675418b0b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1681,19 +1681,19 @@ sub process {
>   
>   # Check SPDX-License-Identifier references a permitted license
>   		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
> -		    &checkspdx($realfile, $1);
> +			&checkspdx($realfile, $1);
>   		}
>   
>   		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
> -		    my $tag = $1;
> -		    my @permitted = qw(
> -			SPDX-License-Identifier
> -		    );
> -
> -		    unless (grep { /^$tag$/ } @permitted) {
> -			ERROR("Tag $tag not permitted in QEMU code, valid " .
> -			      "choices are: " . join(", ", @permitted));
> -		    }
> +			my $tag = $1;
> +			my @permitted = qw(
> +				SPDX-License-Identifier
> +			);
> +
> +			unless (grep { /^$tag$/ } @permitted) {
> +				ERROR("Tag $tag not permitted in QEMU code, valid " .
> +				      "choices are: " . join(", ", @permitted));
> +			}
>   		}
>   
>   # Check for wrappage within a valid hunk of the file
> @@ -2274,7 +2274,7 @@ sub process {
>   
>   # missing space after union, struct or enum definition
>   		if ($line =~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)?(?:\s+$Ident)?[=\{]/) {
> -		    ERROR("missing space after $1 definition\n" . $herecurr);
> +			ERROR("missing space after $1 definition\n" . $herecurr);
>   		}
>   
>   # check for spacing round square brackets; allowed:
> @@ -2569,7 +2569,7 @@ sub process {
>   
>   		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
>   		    $line !~ /^.typedef/) {
> -		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
> +			ERROR("named $1 should be typedefed separately\n" . $herecurr);
>   		}
>   
>   # Need a space before open parenthesis after if, while etc
> @@ -3118,48 +3118,48 @@ sub process {
>   
>   # Qemu error function tests
>   
> -	# Find newlines in error messages
> -	my $qemu_error_funcs = qr{error_setg|
> -				error_setg_errno|
> -				error_setg_win32|
> -				error_setg_file_open|
> -				error_set|
> -				error_prepend|
> -				warn_reportf_err|
> -				error_reportf_err|
> -				error_vreport|
> -				warn_vreport|
> -				info_vreport|
> -				error_report|
> -				warn_report|
> -				info_report|
> -				g_test_message}x;
> -
> -	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
> -		ERROR("Error messages should not contain newlines\n" . $herecurr);
> -	}
> +		# Find newlines in error messages
> +		my $qemu_error_funcs = qr{error_setg|
> +					 error_setg_errno|
> +					 error_setg_win32|
> +					 error_setg_file_open|
> +					 error_set|
> +					 error_prepend|
> +					 warn_reportf_err|
> +					 error_reportf_err|
> +					 error_vreport|
> +					 warn_vreport|
> +					 info_vreport|
> +					 error_report|
> +					 warn_report|
> +					 info_report|
> +					 g_test_message}x;
> +
> +		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
> +			ERROR("Error messages should not contain newlines\n" . $herecurr);
> +		}
>   
> -	# Continue checking for error messages that contains newlines. This
> -	# check handles cases where string literals are spread over multiple lines.
> -	# Example:
> -	# error_report("Error msg line #1"
> -	#              "Error msg line #2\n");
> -	my $quoted_newline_regex = qr{\+\s*\".*\\n.*\"};
> -	my $continued_str_literal = qr{\+\s*\".*\"};
> +		# Continue checking for error messages that contains newlines. This
> +		# check handles cases where string literals are spread over multiple lines.
> +		# Example:
> +		# error_report("Error msg line #1"
> +		#              "Error msg line #2\n");
> +		my $quoted_newline_regex = qr{\+\s*\".*\\n.*\"};
> +		my $continued_str_literal = qr{\+\s*\".*\"};
>   
> -	if ($rawline =~ /$quoted_newline_regex/) {
> -		# Backtrack to first line that does not contain only a quoted literal
> -		# and assume that it is the start of the statement.
> -		my $i = $linenr - 2;
> +		if ($rawline =~ /$quoted_newline_regex/) {
> +			# Backtrack to first line that does not contain only a quoted literal
> +			# and assume that it is the start of the statement.
> +			my $i = $linenr - 2;
>   
> -		while (($i >= 0) & $rawlines[$i] =~ /$continued_str_literal/) {
> -			$i--;
> -		}
> +			while (($i >= 0) & $rawlines[$i] =~ /$continued_str_literal/) {
> +				$i--;
> +			}
>   
> -		if ($rawlines[$i] =~ /\b(?:$qemu_error_funcs)\s*\(/) {
> -			ERROR("Error messages should not contain newlines\n" . $herecurr);
> +			if ($rawlines[$i] =~ /\b(?:$qemu_error_funcs)\s*\(/) {
> +				ERROR("Error messages should not contain newlines\n" . $herecurr);
> +			}
>   		}
> -	}
>   
>   # check for non-portable libc calls that have portable alternatives in QEMU
>   		if ($line =~ /\bffs\(/) {



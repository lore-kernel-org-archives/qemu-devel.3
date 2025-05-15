Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C3AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbsG-0007gR-5N; Thu, 15 May 2025 12:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFbsB-0007fS-2F
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFbs7-0006Vn-N1
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747328150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oXAarV1hk9Z7XOptlcJ8+fA/Pp024yNWTurRxxLQZLU=;
 b=LXR81y38FD/UVbpaI+CDzLWuHT0z52H7AWoOvIfGEkmU3n++nOhhYIJSvRARx0nBKN7nsY
 U3pB2JTuhQAEzEPsdKGNrNpCxaXLqqH1sEw2YM+zziu1dMJoQQQqbIOnRX95Tt3JN7AjkR
 Fy/suMUrobwauXi/NUb0velERbSTyec=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-oS6zFt8xNu67UvO40zE6WQ-1; Thu, 15 May 2025 12:55:48 -0400
X-MC-Unique: oS6zFt8xNu67UvO40zE6WQ-1
X-Mimecast-MFC-AGG-ID: oS6zFt8xNu67UvO40zE6WQ_1747328147
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so631598f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747328147; x=1747932947;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXAarV1hk9Z7XOptlcJ8+fA/Pp024yNWTurRxxLQZLU=;
 b=Xt1BwwZr40QdqhCtS2DTmDfUXpMDOdi8EuFLoy6Nxl97FWvrTY7bEIP+C/22Qx7va2
 7qVlmuu+u7D6tiWyUxSFWzJfRo2ReMaxA5SU6oHGF2Ki8qAGhu+HcYM4FDmjL1vU89lo
 th6LKM6Zy9rc+/Xec5qeSrDniH9ujhR8r1mQXt/JQ6UCfnmNr9G9PlYO5TmNcvOPxk5R
 eTrJrpu5J0xi+NPXbiwQDz3oYxeQJABaL7Wc5a7vXXiEiAdu2xdPLLJlE1+aSIyFiidq
 QL7LbpcCNFYZYzYDQ8f0zEiEsaHVEQK7R/muivDsmPdrNlc9I4CoKkKt9xmIbjwaEUCI
 jqAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELpqpw2XLA7Pd/+8uFhb6mbKuJjAbxHC5Chzj2a6BCySrJ7koRMi7X3fGX7NG8/5dTI76WY90mRku@nongnu.org
X-Gm-Message-State: AOJu0YyyUFNWQEzDMkT2sFWy9LrpPF8Uy4yFKlVs7K6bNrXitdrpVlSh
 LE0AyTZRLKUNkkjKTOgVkDCySCJ29mhiwnDTAkavVcXOFYtL1uepbDmKei+IQNm//aWwu22V/jB
 TKBxvuqocDje0YMX9lO568a1cRoujgczL0cVrxsgRaQGRXu5HSvB5GXzQ
X-Gm-Gg: ASbGncsreXjdlwD2+SIOvScPY4fc7MBLgwiyvhk7I2wrx/bx1nz57au89ibTSG/HBos
 JqYabsKmQcoX1j4PaKe9O+VxqrGMcSfyBc7KuIw4swffqoLFcUiCT5I4fqyext8vd7l2cbU064G
 ZZCDKWf7R57KpV2bHtMboi40H19zpxvH91jH8yiTroYXll9xXw8iXSfVgQcqtLe7caXLQ6jUhcD
 NoksFNZuJYXTztbBN93/S3NSe2/junGxxFUxQW1nfd7BQNx9w9IIHzAPMafdo3p8ANujJYGOKAJ
 BTIXehKqTI2TONHgFxxcBmbgpRvXNeiXBdawrg00glen0a7ikw==
X-Received: by 2002:a05:6000:40d9:b0:3a0:ad55:c9f1 with SMTP id
 ffacd0b85a97d-3a35c807172mr554003f8f.12.1747328147124; 
 Thu, 15 May 2025 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIjUlfTkjapenPkuzm1vPva8hknQJCBOMURWhRI6MEBe8PkA947sA+L70i9OlVbEIJ4F7G/g==
X-Received: by 2002:a05:6000:40d9:b0:3a0:ad55:c9f1 with SMTP id
 ffacd0b85a97d-3a35c807172mr553985f8f.12.1747328146753; 
 Thu, 15 May 2025 09:55:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a8c4sm60106f8f.27.2025.05.15.09.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:55:46 -0700 (PDT)
Message-ID: <9e60b3a8-e7ac-48f4-96d9-e0d40a4b25ad@redhat.com>
Date: Thu, 15 May 2025 18:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] scripts/checkpatch: use new hook for ACPI test
 data check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-5-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515135936.86760-5-berrange@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/25 15:59, Daniel P. Berrangé wrote:
> The ACPI test data check needs to analyse a list of all files in a
> commit, so can use the new hook for processing the file list.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>> ---
>   scripts/checkpatch.pl | 61 ++++++++++++++++++++-----------------------
>   1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b74391e63a..6a7b543ddf 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1330,29 +1330,6 @@ sub WARN {
>   	}
>   }
>   
> -# According to tests/qtest/bios-tables-test.c: do not
> -# change expected file in the same commit with adding test
> -sub checkfilename {
> -	my ($name, $acpi_testexpected, $acpi_nontestexpected) = @_;
> -
> -        # Note: shell script that rebuilds the expected files is in the same
> -        # directory as files themselves.
> -        # Note: allowed diff list can be changed both when changing expected
> -        # files and when changing tests.
> -	if ($name =~ m#^tests/data/acpi/# and not $name =~ m#^\.sh$#) {
> -		$$acpi_testexpected = $name;
> -	} elsif ($name !~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> -		$$acpi_nontestexpected = $name;
> -	}
> -	if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
> -		ERROR("Do not add expected files together with tests, " .
> -		      "follow instructions in " .
> -		      "tests/qtest/bios-tables-test.c: both " .
> -		      $$acpi_testexpected . " and " .
> -		      $$acpi_nontestexpected . " found\n");
> -	}
> -}
> -
>   sub checkspdx {
>       my ($file, $expr) = @_;
>   
> @@ -1437,6 +1414,34 @@ sub checkspdx {
>   # real filenames that were seen in the patch
>   sub process_file_list {
>   	my @fileinfos = @_;
> +
> +	# According to tests/qtest/bios-tables-test.c: do not
> +	# change expected file in the same commit with adding test
> +	my @acpi_testexpected;
> +	my @acpi_nontestexpected;
> +
> +	foreach my $fileinfo (@fileinfos) {
> +		# Note: shell script that rebuilds the expected files is in
> +		# the same directory as files themselves.
> +		# Note: allowed diff list can be changed both when changing
> +		#  expected files and when changing tests.
> +		if ($fileinfo->{filenew} =~ m#^tests/data/acpi/# &&
> +		    $fileinfo->{filenew} !~ m#^\.sh$#) {
> +			push @acpi_testexpected, $fileinfo->{filenew};
> +		} elsif ($fileinfo->{filenew} !~
> +			 m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> +			push @acpi_nontestexpected, $fileinfo->{filenew};
> +		}
> +	}
> +	if (int(@acpi_testexpected) > 0 and int(@acpi_nontestexpected) > 0) {
> +		ERROR("Do not add expected files together with tests, " .
> +		      "follow instructions in " .
> +		      "tests/qtest/bios-tables-test.c. Files\n\n  " .
> +		      join("\n  ", @acpi_testexpected) .
> +		      "\n\nand\n\n  " .
> +		      join("\n  ", @acpi_nontestexpected) .
> +		      "\n\nfound in the same patch\n");
> +	}
>   }
>   
>   # Called at the start of processing a diff hunk for a file
> @@ -1501,9 +1506,6 @@ sub process {
>   	my %suppress_whiletrailers;
>   	my %suppress_export;
>   
> -        my $acpi_testexpected;
> -        my $acpi_nontestexpected;
> -
>   	# Pre-scan the patch sanitizing the lines.
>   
>   	sanitise_line_reset();
> @@ -1642,7 +1644,6 @@ sub process {
>   			$fileold =~ s@^([^/]*)/@@ if (!$file);
>   			$filenew =~ s@^([^/]*)/@@ if (!$file);
>   			$realfile = $filenew;
> -	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
>   
>   			$fileinfo = {
>   				"isgit" => 1,
> @@ -1676,8 +1677,6 @@ sub process {
>   			$realfile = $1;
>   			$realfile =~ s@^([^/]*)/@@ if (!$file);
>   
> -	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
> -
>   			$p1_prefix = $1;
>   			if (!$file && $tree && $p1_prefix ne '' &&
>   			    -e "$root/$p1_prefix") {
> @@ -1770,9 +1769,7 @@ sub process {
>   		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>   		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
>   		      (defined($1) || defined($2)))) &&
> -                      !(($realfile ne '') &&
> -                        defined($acpi_testexpected) &&
> -                        ($realfile eq $acpi_testexpected))) {
> +		    $realfile !~ m#^tests/data/acpi/#) {
>   			$reported_maintainer_file = 1;
>   			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>   		}


* https://lore.kernel.org/qemu-devel/20250403151829.44858-12-philmd@linaro.org/
   WARNING: Does new file 'tests/data/acpi/aarch64/virt/APIC.its_off' need 'SPDX-License-Identifier'?
   WARNING: Does new file 'tests/data/acpi/aarch64/virt/FACP.its_off' need 'SPDX-License-Identifier'?
   WARNING: Does new file 'tests/data/acpi/aarch64/virt/IORT.its_off' need 'SPDX-License-Identifier'?
   ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c. Files
   
     tests/data/acpi/aarch64/virt/APIC.its_off
     tests/data/acpi/aarch64/virt/FACP.its_off
     tests/data/acpi/aarch64/virt/IORT.its_off
   
   and
   
     tests/qtest/bios-tables-test.c
   
   found in the same patch
   
   total: 1 errors, 3 warnings, 11 lines checked
   

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




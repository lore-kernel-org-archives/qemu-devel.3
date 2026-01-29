Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97356D73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 18:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlWHi-00056S-4k; Thu, 29 Jan 2026 12:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vlWHg-000560-Fd
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vlWHf-0005fq-1f
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769709502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NLCEojtpOTmqlhm38SDoYRDqtQl/45nx3bHqejENew=;
 b=Zsr4SmHkYwFZqDAZtJpvzEhKVA6M0/n27bMs24xpgOMx+0r4SSvcTwFo/GneEBcNuHdFAJ
 fyVpi4Cw4GGqE6kkZ6qpfNymboie1PMbK7UiRzeS0gtAkRChYiimXeEAzCh/P+R54kApxI
 j5/qzyc/QhTRAIE5bOqIJTyMa+vN2eA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-hhrwkUSxPDuu18Ps0QzI3g-1; Thu, 29 Jan 2026 12:58:19 -0500
X-MC-Unique: hhrwkUSxPDuu18Ps0QzI3g-1
X-Mimecast-MFC-AGG-ID: hhrwkUSxPDuu18Ps0QzI3g_1769709498
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806fc58fa5so9804115e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769709498; x=1770314298; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NLCEojtpOTmqlhm38SDoYRDqtQl/45nx3bHqejENew=;
 b=Ii47lfe/oJcbFe+EZ6zxw9TO95mgdMjSL8L+9+qhDhW26ffvChv1fIOwtNSC964VW5
 Kv01bbT2HXokl3yM2Cd+p5OQttfpWnh3nthtco68DCAalaTS9KwqQX+2o1p8kopd7Jun
 +tdrAaYrXwNMHJmD2i7Gg3femNQRsLulv7NACCY7Y1wCXnA8OsUuGHUexi0Z3xhRtf2a
 OAsRmz5vz4uKXtwwOha2EbdyBPqnnlED/n5CTdFhNHS4zBFQApow8FF7MxNIqOEaxBNn
 di6LcutbrD9by2B+SVQLinsa8GJwzjtcp/WiQJgnLYbZLNKAoIU0dCaRKeC6meq0fr4D
 pWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769709498; x=1770314298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NLCEojtpOTmqlhm38SDoYRDqtQl/45nx3bHqejENew=;
 b=QD/LXY+T+iB1dbGcjrg/U5hG84BrOtlgxE6rtgZkoJvhuX/zTSkDWXv3PgfFhBUl//
 RXlBfg+OCClYYf+uM+zT3RqGwmVLhQoEXKcZzK/zrfJGTtta58S5jIotpBEMLcJIQIJ8
 Wix0tywZa+SG94vl8qQFKcDEmtGj1quheEc52B4AqfHfVTJPU05HFdv5rUWGvJ+Llq/4
 PryF0L+XMHeWhwdaHZpMEN8OxI08hHK5RdDkqdouN/d7spPHg7l6amrkogxfY99GiQ8E
 UX9KTi3mwQkYVxRVUDy4/LarDrXRqqq4DZjitDz/UORNai6hR/A6SroSmiLmvxQGvIiN
 fU6g==
X-Gm-Message-State: AOJu0Yz+MYZPDeBMYTWouNOEU2qwx85Czn+r6yH78OKo/mz2Xq8NL/9L
 SiA+eRmzeOwPAdevfU0AVpNYb2/r5JP0xwfZh35H2P5GedSha9igN30d0JW+2FgC2SPzaVv4QSt
 mfYNP+zE2tf5Wpp4dA0lw6WkmsT21r4m+ONV/zjSrWo5D4BE2Hvtqp9o0
X-Gm-Gg: AZuq6aLFy6cp8O2Rfv//SpgZHJwAkfETbpEUiGAJKwqW1GfV4SP2oKQntTfw6TBG3/s
 DbjObVTTFwTtLwSFl0iEHO9Bwk+t+9ZZr1M6cy0ghITVJ7QRVNC62ppNi4WRGVmD06rsbaL0OVt
 ON92hcSVdCfVFwX8NuPvLwtAMBc28RUUsZenZBvhWPYrRxonuTLfci9XlRagkSS73X0EZaVG4dv
 fEFRcW1oM2WoOviCTK01QIe2nzrogcgfi7AzBA0U0K5JWqDk1QwV3auXCWrZ+lQjvxH9TiBGx0Z
 x48PRwGibkAD9ySu16D+lHetiVOhsWBQKrWWoZYgtkcYR0kg4XrcYDdZtJXZi84Rw9FKWCHR93v
 UWe53FAK2IE/9jLeybsO7CMnz522jjhq3RQ==
X-Received: by 2002:a05:600c:8115:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-482db447c40mr288965e9.4.1769709498079; 
 Thu, 29 Jan 2026 09:58:18 -0800 (PST)
X-Received: by 2002:a05:600c:8115:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-482db447c40mr288755e9.4.1769709497741; 
 Thu, 29 Jan 2026 09:58:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cddffc0sm182544575e9.5.2026.01.29.09.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:58:17 -0800 (PST)
Date: Thu, 29 Jan 2026 12:58:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
Message-ID: <20260129125744-mutt-send-email-mst@kernel.org>
References: <20260129164004.222-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129164004.222-1-mohamed@unpredictable.fr>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 29, 2026 at 05:40:04PM +0100, Mohamed Mediouni wrote:
> /usr/bin/bash isn't guaranteed to be present. Switch
> to /usr/bin/env bash.
> 
> Rename disassemle to disassemble in the same commit.
> 
> Adapt the correponding message in rebuild-expected-aml.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

/bin/bash then - that's in the posix standard I think.


> ---
>  tests/data/acpi/disassemle-aml.sh       | 4 ++--
>  tests/data/acpi/rebuild-expected-aml.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
> index 89561d233d..62e1991ace 100755
> --- a/tests/data/acpi/disassemle-aml.sh
> +++ b/tests/data/acpi/disassemle-aml.sh
> @@ -1,4 +1,4 @@
> -#!/usr/bin/bash
> +#!/usr/bin/env bash
>  
>  outdir=
>  while getopts "o:" arg; do
> @@ -7,7 +7,7 @@ while getopts "o:" arg; do
>          outdir=$OPTARG
>          ;;
>      \? )
> -        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
> +        echo "Usage: ./tests/data/acpi/disassemble-aml.sh [-o <output-directory>]"
>          exit 1
>          ;;
>  
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index cbf9ffe0dd..af45cf3007 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -57,7 +57,7 @@ old_allowed_dif=`grep -v -e 'List of comma-separated changed AML files to ignore
>  echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
>  
>  echo "The files were rebuilt and can be added to git."
> -echo "You can use ${SRC_PATH}/tests/data/acpi/disassemle-aml.sh to disassemble them to ASL."
> +echo "You can use ${SRC_PATH}/tests/data/acpi/disassemble-aml.sh to disassemble them to ASL."
>  
>  if [ -z "$old_allowed_dif" ]; then
>      echo "Note! Please do not commit expected files with source changes"
> -- 
> 2.50.1 (Apple Git-155)



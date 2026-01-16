Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95273D4A60D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeng-000410-Tt; Fri, 16 Jan 2026 03:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgenQ-0003y9-DV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgenO-0004tz-3a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768550581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C3ZBUHHyolbCQKXpdNTKdDZLl0KWnKMbxuoo5Sdf4PA=;
 b=DwrxmEHMbG+QCfpc/iOLS4WUxjcWnahtjzn8h3LTGTn5WnfuQeZk5CYs9e8yPHxHxaJBMX
 RZsrekYJ188dw9pgP/Ssueq5bFf4tZR47hFdeBcWAasSHgF+Q0jjbYT3NUfs8p80e5j9Sh
 iBK0zGplHLNVEMv+XoHGp1T3ZjE2OGI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-IIPcVJ22MiiaSrC0iZVgGQ-1; Fri, 16 Jan 2026 03:02:59 -0500
X-MC-Unique: IIPcVJ22MiiaSrC0iZVgGQ-1
X-Mimecast-MFC-AGG-ID: IIPcVJ22MiiaSrC0iZVgGQ_1768550578
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64b756e2fd1so1923980a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768550578; x=1769155378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C3ZBUHHyolbCQKXpdNTKdDZLl0KWnKMbxuoo5Sdf4PA=;
 b=A/mJaTlmC3Kl1q0nog0yt11xFYTTDhiWL0k9v3VE6ai3oAxLEWpJbY9ehlwkURuwmq
 dDB3XqRWoFIYDGS3e/k9zKcjfBuLgvBCOZXD4v2jm4Cjksbgue7vNxu2G84JAK2TobRH
 NY9j16wfK+WwuE7liu5Xx4SJ5jyBB15iIF+2vNUrcEt+wPV84blsbAOVHOo5AF9lAkr7
 49CpebQ3n9OWcKKkk9wlBpqruNNBiDXsNyDX9NRl5s+Aov4Xt3IhizNGYkmv1dZ76pfz
 ThpqjNNatytk+9MPvvd3RUrtPtXXUQOH0qhWC2dGDeyNCPCiQCMQBauNJCnUVUoWh2gZ
 Xcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550578; x=1769155378;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C3ZBUHHyolbCQKXpdNTKdDZLl0KWnKMbxuoo5Sdf4PA=;
 b=OcvZ7nGo6q4G0Qw6yGGxln+1/9LjYLoeNsEz6EwxnVP32Q6mys+4hHpQOtsRIFnbJ2
 kj/0ZzLieTMuFLUddeHgR4ljoWVZ0A8f4IafGlyQpu988u5oG29IgZAcP28atvYgOjya
 muAPdJKc04Hh64C9D/hWgpSGkNHv/GKNCTA8Dct9CoNYdB4NesG0S/1rzRxlWVqVpM7J
 9OtK9v0sdZtlWwnv1w7+/d1LFz/FbI3+fSLQ2fvwbBGKWCpBnb+SN/h18cltQJwrBMnV
 RrvC7XYXqIKEG8tLADKw2ZPjx+c0kbuPJpy4ti6TVriqhCRR/mtqlEABHYTPDDktpO1O
 5g2A==
X-Gm-Message-State: AOJu0Yx3pCovQEX4IXAspD3P3cTcYsHIofAT5Mw/HexOCxrJHDLfW5be
 rMWP4qfhbKfhRgpzylm1/JkdCLWIrg6GpA3mu7ehnfCKyrnKfbmDd/CfUTylvXrZZgt+sCbUHkF
 XcpUTOBBHSkYi7ZTZCrkz7/m+IGrc2NQokqEX+1LJfVhbncsfZ1VO/yA+Yq8ENKEADcqXYeHJJv
 Xqyk0qvPkx5arwgsdQ0c5GDKupxvWSEOpoQol2
X-Gm-Gg: AY/fxX6pDBCXDiCNxgNrxGc8BK4ZK3cLuYfHkavNCbNtmLQxf/yRwjZVhweazIncaCm
 xKU8pLf/K9nInNRfIHVDGfUaj9fEv7rnpFx9q57zZcNVpk/2sSPWVjKqYw9AiRZhVqs0pM4nAR6
 UmutikCPijl4B/EJDDM4R8gNFQzChLj5qGcPw8hwqkMEjslCgFlm6Ce5Sww52y7kM1Tm6TRTkox
 IkUcFDexAFKb32T7VG0Vz5aq5LbyeRdUJANGNdoRp4wlnfC1ewJ/ZDIBKrjL2TfwdHf/r1vI0J6
 dU1E6oTTv6Z3zGXmDZ8Bo3ZUidAypUxIWZ5IcpEtHBVOTbHfLcakfRPvHLZieiUg34tOReLJydl
 EF/oFR04=
X-Received: by 2002:a17:907:d8f:b0:b87:d44:81d with SMTP id
 a640c23a62f3a-b8793035657mr170098066b.45.1768550577609; 
 Fri, 16 Jan 2026 00:02:57 -0800 (PST)
X-Received: by 2002:a17:907:d8f:b0:b87:d44:81d with SMTP id
 a640c23a62f3a-b8793035657mr170096366b.45.1768550577118; 
 Fri, 16 Jan 2026 00:02:57 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959ca4casm163588866b.34.2026.01.16.00.02.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:02:56 -0800 (PST)
Message-ID: <059f0401-4743-4d58-b833-e736e9c744f1@redhat.com>
Date: Fri, 16 Jan 2026 09:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hxtool: Error on missing docs
To: qemu-devel@nongnu.org
References: <20260116005050.376616-1-dave@treblig.org>
 <20260116005050.376616-5-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260116005050.376616-5-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 16/01/2026 01.50, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> Error if a '.name' is seen after another '.name' without an intervening
> SRST, this normally indicates missing or misplaced docs.
> 
> We can't check DEF (as used in command line options) because those
> often have multiple DEF per doc.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   scripts/hxtool | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/scripts/hxtool b/scripts/hxtool
> index 51dc841479..ee98fb9c09 100755
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -1,8 +1,14 @@
>   #!/bin/sh
>   
> +print_if_not_rst()
> +{
> +    test $in_rst -eq 0 && printf "%s\n" "$str"
> +}

Add an empty line after this function?

>   hxtoh()
>   {
>       in_rst=0
> +    # .name for HMP
> +    seen_name=0
>       while read -r str; do
>           case $str in
>               HXCOMM*)
> @@ -13,6 +19,8 @@ hxtoh()
>                   echo "Error: SRST inside another RST" >&2
>                   exit 1
>                 fi
> +              # consume the name
> +              seen_name=0
>                 in_rst=1
>               ;;
>               ERST*)
> @@ -23,6 +31,16 @@ hxtoh()
>                 fi
>                 in_rst=0
>               ;;
> +            # Note the space at the start - we need to exclude something.name
> +            ( .name*)
> +              if [ $seen_name -eq 1 ]
> +              then
> +                echo "Error: Seen another .name, maybe missing docs?" >&2
> +                exit 1
> +              fi
> +              seen_name=1
> +              print_if_not_rst
> +            ;;
>               *)
>               test $in_rst -eq 0 && printf "%s\n" "$str"

I think this line could be replaced with print_if_not_rst now?

  Thomas



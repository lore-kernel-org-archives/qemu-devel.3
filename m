Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF01D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 16:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOf5f-0003DA-00; Thu, 27 Nov 2025 11:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOf5d-0003CN-7v
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 11:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOf5b-0000bK-7Q
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 11:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764261806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U/rrTJNeEyvm6rIYq8jifjOkmHqA4mYCQaPzopL3pcg=;
 b=c00QNLjejgmU+C36hzZZZ90AX1viyCSl44jQNKOl7w8Ip7qMEkJ258qyXEQmVXWG5LqlZ7
 8CsI0eM2Pu3EjBBNNr/e5m6zy0+oubji7ECcTu/bfvPDdzacJw7HLuGJRtZmIm0Izc8BGb
 eiJtnO84FS4FhTxQsApI5AcM38u1j6c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-0ZQl8989PtOKhnrL3Y-UuA-1; Thu, 27 Nov 2025 11:43:24 -0500
X-MC-Unique: 0ZQl8989PtOKhnrL3Y-UuA-1
X-Mimecast-MFC-AGG-ID: 0ZQl8989PtOKhnrL3Y-UuA_1764261804
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47799717212so8192105e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764261804; x=1764866604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U/rrTJNeEyvm6rIYq8jifjOkmHqA4mYCQaPzopL3pcg=;
 b=OK4BOI19Vt2dCGhLzA3nSM+DoGG9/P0c2TqopnlfuM+JhJICBROF1pnYZ/p+spbhce
 UXcQzB8nClKB+5gaSUbfKBPvUyP6ceL0SEeh0YKL1Dqxcs3ekb8qKRr+h3c283fDNPfE
 5HRYxaraXV20aZoFnwFDA0Ycib/rj8kBF2q14Mt3Ee9y+wqIU6cv9D2MooUPRMq7wQiN
 Hrc+s3sX94nN1/2C2LBuEDmrBTiCMLs61dPd4kHwV/QSyjlKpBDxWbamRgXnCJKWydoc
 ODMbyhg2mRDDEKa56RiQaqGhxu2UCGPJv/x1BHLIT7n8m8n2ymPOIT1VEik6f48qeAQV
 v78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764261804; x=1764866604;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/rrTJNeEyvm6rIYq8jifjOkmHqA4mYCQaPzopL3pcg=;
 b=tO5t3dS50Nv4jar6EmsY+nv/viKTbWC6DHmaUSKaOp7G6qGi2PoAMPIQVAW8A79P27
 kZpomBAoqbER0V1obg8rD9y2CFGkWghPv0IpxvVBTOe6AVFzaTduvlF7/Ht2MPdEXKg9
 5VVUNgdLtOJi1XwXHWPBl0ndiLu0IJSk3KTv4w0zfirAOGrf0SElc180w8CQjsOkc8hH
 8uuLK7KJKYLw217gBnnXda6M0qp2W3GHPD34kZDzcbLLsgqxT1tZHE5GC/No+OklJ4EZ
 EGGL1yjZO1mm8+K6RJiI28E25KjbuWks2MAX/LTGIPp5rKwI/DzBbJWnwz4Pt7efQNck
 DxXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUubAxWaxAnaaLuZIRdp3QC6nzOCKb4bGtLbJu8IiYVnR9VDiWN6BShFErJkAnBErLiRR3Jy37rh91R@nongnu.org
X-Gm-Message-State: AOJu0YyKAWj/cqmNGQrlhyfET3m28QidJ2vX++nlwvvjAvovI2pYAvSn
 8R8tfFhpiGVEIwONqTa6onuYCLPxvjrJX+2jUEIbxrjmtHnvAAFvYUImTvammit61N9VTu8mu8E
 vUBGkDLzEovR/A8GILjSs8yQljFo2xEOz75RsFmLrxX8Rz4SIxS354rOk
X-Gm-Gg: ASbGnctakvBY8XpEYXj61PwQ+G/FSyYSptZHcNxL+FX6VaSeiRTkKgU+oRoQ2vMenGU
 UyY3Mfz4MVKjlK1YP2YBjP505YP0bcET+Rjc4mArZygTjf61v1qfYB65sak2d0jkXkZ38lti4Kk
 hJY13lHAfheLW6VJSjnB7LxIAkkN3pbGQJpbmo7NEcw4PN7R/n8JcDzGC0srv9XD7v4YZmufOGS
 HXL+obw7xawdSzMziY5Z0CrVCIXyhRrqnWrssxdFWNjN5L3AoidjnebrYdCBD13vKpnHBpEJOFb
 6V/3qW+S6JMwIcZuIEt8uZtKK28M7FNe54+4wkY4Jc90mgK+yVH5ebR87OmpydFBF7sIItXMl3r
 WePW6nYK0mcjADN8fY53HMRnuwLhMHsTmfCo=
X-Received: by 2002:a05:600c:8b35:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-477c10c85d5mr228480165e9.6.1764261803631; 
 Thu, 27 Nov 2025 08:43:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyVaI9ucdvRmoMYblaZmeLlPoZ9QJbqc6cpUfUG68E7v0hH007gyL84fSvzSoXTK9pUVeKeQ==
X-Received: by 2002:a05:600c:8b35:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-477c10c85d5mr228479895e9.6.1764261803239; 
 Thu, 27 Nov 2025 08:43:23 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc6f7bsm112414735e9.2.2025.11.27.08.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 08:43:22 -0800 (PST)
Message-ID: <a0accce9-6042-4a7b-a7c7-218212818891@redhat.com>
Date: Thu, 27 Nov 2025 17:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/s390x: Fix missing interrupts for small CKC
 values
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251016175954.41153-1-iii@linux.ibm.com>
 <20251016175954.41153-2-iii@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251016175954.41153-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/10/2025 19.58, Ilya Leoshkevich wrote:
> Suppose TOD clock value is 0x1111111111111111 and clock-comparator
> value is 0, in which case clock-comparator interruption should occur
> immediately.
> 
> With the current code, tod2time(env->ckc - td->base.low) ends up being
> a very large number, so this interruption never happens.
> 
> Fix by firing the timer immediately if env->ckc < td->base.low.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

  Hi Ilya,

this patch unfortunately broke reverse debugging on the s390x target. 
Something like this used to work before:

  qemu-img create -f qcow2 /tmp/disk.qcow2 2G
  ./qemu-system-s390x -nographic \
    -icount shift=6,rr=record,rrfile=replay.bin,rrsnapshot=init \
    -net none -drive file=/tmp/disk.qcow2,if=none
  ./qemu-system-s390x -nographic \
    -icount shift=6,rr=replay,rrfile=replay.bin,rrsnapshot=init \
    -net none -drive file=/tmp/disk.qcow2,if=none

With this commit and later, the replay hangs somewhere in an endless loop.
Do you have any ideas what could go wrong here?

  Thanks,
   Thomas


> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index 6d9d601d29a..215b5b9d933 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
>           return;
>       }
>   
> -    /* difference between origins */
> -    time = env->ckc - td->base.low;
> +    if (env->ckc < td->base.low) {
> +        time = 0;
> +    } else {
> +        /* difference between origins */
> +        time = env->ckc - td->base.low;
>   
> -    /* nanoseconds */
> -    time = tod2time(time);
> +        /* nanoseconds */
> +        time = tod2time(time);
> +    }
>   
>       timer_mod(env->tod_timer, time);
>   }



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5916EC9EC9A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKTD-0003vd-Il; Mon, 12 Jan 2026 11:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfKRr-0003lp-IH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfKRp-0005gV-V5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768234035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Bb7lETFSDMh/qTpCPzAacxC2VGHHr277qmPyouuq4U=;
 b=X8i+Hw+OwRJW5WC/yfhTwljveUREP8Z3x/1C4oQQjzpsMqAujm9h9xzr3MTpp+DJtnmEog
 lrvjb+hryejp3vYiiazavphA9Zq1qXA1RaKv2kbbkxXdjQaewbbfDbm2n/J12RWKf1Hzi1
 oorLSBjhcTQy5lvVgKZ+TJoAUOJrzpk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-MfUseCYdOMewsm4rcODKPg-1; Mon, 12 Jan 2026 11:07:13 -0500
X-MC-Unique: MfUseCYdOMewsm4rcODKPg-1
X-Mimecast-MFC-AGG-ID: MfUseCYdOMewsm4rcODKPg_1768234032
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so3453501f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768234032; x=1768838832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+Bb7lETFSDMh/qTpCPzAacxC2VGHHr277qmPyouuq4U=;
 b=NR1Ygs7owSVSiZl1zcFfypqtOE6JTIdMPDZlgLb3u5YBEqUFkd+kV3kIXU3cRLKUxf
 hMqfqvoMa3Cs6TBSdR0m85/CQcnbwg/86OK2bSakcr4tpHivtNqvUV/Ad6eF1BNNf7Ao
 +b6zabEooNkvJQb+TifFU1VSFSmmsLXGuz6lXRC9tsJy5N8PY1COmoG9YdOLzNj58bQA
 sllf/GTfs44PNYTpgZNisbnlklG7SM0SYDys4PQVZ015Vg7OpYl3Bx8g4gekoZ0aCH6W
 /+RMfO3r9uLAfKlQ1YWbhPmfpp4l1yyX6Se3q4i2uQq3Dz/jK+1BzLB4vN7UoLrbyHjC
 tffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768234032; x=1768838832;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Bb7lETFSDMh/qTpCPzAacxC2VGHHr277qmPyouuq4U=;
 b=QFPAsCmf4n/gyRQO4tWg0kd4DSc51KK7zpZ23E2LbpmHMQoSWm+Gq+KtyINBacZBZC
 QFhiUGgdt63SWWvLeL69Sd3AyqhW80wcNCuPGYN1zt/LYxz4JOHpZuotvOwmoHiAyFoA
 Ui98lHGbfw+yPpQ8Vr+eyU9UZHqHpUke6WCJg580KaRKj+0HhB2F13Vkj65OqBCJGQQZ
 wMeDQIgDif3xyyejWT2CSOUxobijTucH1a/rnlrEqyf51W4BCzVu6IoJqrcPz1H/41bs
 gpgHrrtKUTgBh7z+wguI0kJVqYXRYwtEI6f+d1HM6qsPvU0KX4KpypN6f6IvAu8gzKbG
 yW8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVincNn1O27N3Shs+F2yk2X9+hZTuhCGULNMrTkoUgChSbGAnvypHR5UH2b2s/qtk9rjvO1TiNMc9hJ@nongnu.org
X-Gm-Message-State: AOJu0Yx4ZzTpMTU0xpT/qdZOoNrkpO4vUtmb0Z6cLCWZgB8r0kUFaAXz
 RL/juqKSsGoLv9hINlSGYhq1MXeUPFkkrn5LCHPJe0T37TcXYSsaZnHwtMeR5RnkJ4EW/1yk8Ao
 PrIGxiJt9c8dE3GVFgMgWQRtxxxQ17v4L2OgmFlP8FZkka5mG9hhqfqD1
X-Gm-Gg: AY/fxX7y2YqPiQWEqom+s/QnsYs6AflC6KG2XCh3GfFUzLDatikpAV8x2dvZssbQBrQ
 UUo+DZyPKb14nUctb1KTv/klVi02/gBD27LZECzncRrCIshJJzX1IpAOsNxN4z3YKHzG1omKpx2
 fa1FndZOEvI3f33A+3TAZ7L2qqxcstxRK+Pe6g4NByW0yRTn8ijKyN44bykDYb4YU40elNOCF1+
 zyi4kEfk1XBME+QNIrnldFh/0KOUC093T1BZD8PxeYl02mxCp4EgBux+Qig0hMu2EaC7Ha5OiYp
 s/Z27un1uX+1rtifWcmbPyDkxh5GQFHcSM503QUDukHhlT7VZ9X6egW1Q+Gr6u0Ey8cPjsEQ4hM
 nvUufrT0=
X-Received: by 2002:a05:6000:288b:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-432c37615a2mr22205718f8f.47.1768234032331; 
 Mon, 12 Jan 2026 08:07:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3mApXMHCCZnaHTrq+OO8zvrq/d52S68GEqgoEo5j20VuOX0XGFKyzcexLR5hh/clkQPoPRA==
X-Received: by 2002:a05:6000:288b:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-432c37615a2mr22205661f8f.47.1768234031795; 
 Mon, 12 Jan 2026 08:07:11 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm40391878f8f.22.2026.01.12.08.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:07:11 -0800 (PST)
Message-ID: <3b167280-ce21-42ce-8b7d-18c60ff39509@redhat.com>
Date: Mon, 12 Jan 2026 17:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] update-linux-headers: Remove "asm-s390/unistd_32.h"
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260112155341.1209988-1-clg@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112155341.1209988-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/01/2026 16.53, Cédric Le Goater wrote:
> The "asm/unistd_32.h" file was generated for the 31-bit compatibility
> mode on the s390 architecture and support was removed in v6.19-rc1,
> commit 4ac286c4a8d9 ("s390/syscalls: Switch to generic system call
> table generation")
> 
> unistd_32.h is no longer generated when running make header_install.
> Remove it.
> 
> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   scripts/update-linux-headers.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 844d9cb9f5e430dcb4833e6225b57173f4befb8c..d09d8cf4c6f0f6a109e899f5c8671f64373d9c6a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -154,7 +154,6 @@ EOF
>       mkdir -p "$output/include/standard-headers/asm-$arch"
>       if [ $arch = s390 ]; then
>           cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
> -        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
>           cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>       fi

I think it would make sense to remove linux-headers/asm-s390/unistd_32.h in 
this patch, too, otherwise this will stay around as a stale file, I guess?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>



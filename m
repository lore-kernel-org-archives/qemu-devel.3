Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F180CD4F28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 07:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJRmg-0004pX-Jc; Thu, 13 Nov 2025 02:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJRmY-0004kM-U5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJRmS-0007ek-2G
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763018999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mdkjDa66FvIJSa7dXjPdnAWwRSOMiQAI+EyXkL8TH4c=;
 b=fp+c/XzeTRPZvpI89PReYxOOd4w2sQwNcPyVQtVD7m57MsaxptU2ihAqVf3vue/zCMDjLC
 t7VZujwC5FA8B/P+Zxu6h04TqHDgQPL5zkPQAfwizYrig9QK5P8xN2PS3vR5Y/ZMOESXwp
 P2b9xZo04oxU2WN7Q98TYNrtnVjsn9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-0YXmuqZHP06fA_aabNcP_Q-1; Thu, 13 Nov 2025 02:29:58 -0500
X-MC-Unique: 0YXmuqZHP06fA_aabNcP_Q-1
X-Mimecast-MFC-AGG-ID: 0YXmuqZHP06fA_aabNcP_Q_1763018997
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475e032d81bso2697985e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 23:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763018997; x=1763623797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mdkjDa66FvIJSa7dXjPdnAWwRSOMiQAI+EyXkL8TH4c=;
 b=Dn8Z2gBkW9FT+tHCU6RXR0u9LDzOvilwbQyRvs5k3f2kNejOuGprbvvuf1sefdT3Yq
 dVnX8EuyNmjX1G7PgvKn1RMj0bxoTYsk6ox42113iU6KGAo/HtKGqsG2RksHMjFt1qj+
 O/+YUfFmgVn1y9HcltnnEPk1AAWGK/0EvTMu8Zf+qtfYiwRup5eHCYlYzsPzw8Jpzv2n
 SwfU1u2sv2TsQjhHyPpsFxwFAlJTaNudUN04aZGXi7coPRchYyiSb1P6sDLmOIUbRd6J
 h8vP/WSLnaKWjfICz170M5H87K8zte1Fsw/g17CzBXfdVKhl8zx+lm7X3aPZn4audMGx
 3a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763018997; x=1763623797;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdkjDa66FvIJSa7dXjPdnAWwRSOMiQAI+EyXkL8TH4c=;
 b=Lu2kmvuIKuWPRtYkanfsVqq19+lDlIwW8LNO6rwBWa11irsOwGd3/7PnBpPdJOfI6C
 Gj+DieiE+s/Zl/fAG69tsolXUrx8KR83SVgM++tfG7semXM3nbYhg9O2ecr24ejN4Mc2
 tnsXbcJ7kYtmPndJbR1PFwCzvXTu5eI8qlpU3s8DM3YNq/VSeODBeDKFXCPmZYMLJNje
 WEvbQH/pxo6iQ/qJG3ZuqEYIDp6/b0Q7h4J6iSgx87oIBtf+UZNly0J1F41e+Ikx6iR1
 4ZXkdeGA+gYNYhvgfVY7kH5eXwFlOTqYftlhG7FpNswQwWTFL4D2vGrOTED9PTp1CChI
 OA3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/eVmOU9nlJp5/cBI7xhQlswjJj1gm3Y4Q6geihW7vjXHNMVA7K5RJsSZRP25seIAJP8MKTsFRzvyY@nongnu.org
X-Gm-Message-State: AOJu0YzsfI6DgViRBJfh9LLC4K7WmGn25MiUv4/gRWznXAQoqw+C7mUy
 BouuoYQAKHcbqZZSK1wTxa1yxTyq/DVYyyxJlTiaFbxK8L/LfrQdbdST4tuGapbJq3IVsZgb3gL
 nJF/ZTLhPzcxIYr68YkeQlxoEK1al1qe8XLyP68JykRO43E6N23ZE5+/0
X-Gm-Gg: ASbGnctJI4CszPl6Bxrp0lQZbmSHCC7TKKk8nCyos63CQuSXeVJGvud0d5Og89kZw8A
 Y6c/VqyaKMGIMxbj1tQth4t7X/n48p7sEqkijh6br9R/SuLuJqpv0M3ahFLBySfURtGfBn7gEwy
 eg6U/lY5eN9rHcPOFwvB6HHydb7tGsGftRRieX9f2sfSh/S3zaxZY34cN6xp4GZqSX+xvKM8Vtu
 1FPvw/T4xlrbp8H9qPJMlAocGpG1X998IeIW5M/1i6DYecQaXQ7Lu1rhFoG/1fi+QOAxvV0X523
 S1OPic/Xe1MNK0HZaCfuDYA8JVA8OkPZOokeOmKkMnKYFDVvtq7Z5KegQDNPN7VdfoEek6I=
X-Received: by 2002:a05:600c:c4a3:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-4778704a657mr42797185e9.11.1763018997048; 
 Wed, 12 Nov 2025 23:29:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOsFEm99VX28y0AiIWqllJUYdK1T8xDeIB2hXJHKQpqemhacuW0BFcvAHI/4fiI3iTnVMSnA==
X-Received: by 2002:a05:600c:c4a3:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-4778704a657mr42797025e9.11.1763018996667; 
 Wed, 12 Nov 2025 23:29:56 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm2088385f8f.37.2025.11.12.23.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 23:29:56 -0800 (PST)
Message-ID: <f5ea38e0-e707-4222-ad69-2edf39d5fe15@redhat.com>
Date: Thu, 13 Nov 2025 08:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotest: fix iotest 024 with qed images
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251112170959.700840-1-berto@igalia.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251112170959.700840-1-berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/11/2025 18.09, Alberto Garcia wrote:
> Use 'qemu-io -c map' instead of 'qemu-img map' to get an output that
> works with both image types.
> 
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Fixes: 909852ba6b4a ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation")
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   tests/qemu-iotests/024     | 2 +-
>   tests/qemu-iotests/024.out | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> index 021169b4a1..10be2bd845 100755
> --- a/tests/qemu-iotests/024
> +++ b/tests/qemu-iotests/024
> @@ -359,7 +359,7 @@ $QEMU_IO "$OVERLAY" -c "read -P 0x00  0 1M" | _filter_qemu_io
>   $QEMU_IO "$OVERLAY" -c "read -P 0xff 1M 2M" | _filter_qemu_io
>   $QEMU_IO "$OVERLAY" -c "read -P 0x00 3M 1M" | _filter_qemu_io
>   
> -$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
> +$QEMU_IO -c map "$OVERLAY" | _filter_qemu_io
>   
>   echo
>   
> diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
> index 1b7522ba71..da8fedc08b 100644
> --- a/tests/qemu-iotests/024.out
> +++ b/tests/qemu-iotests/024.out
> @@ -266,7 +266,6 @@ read 2097152/2097152 bytes at offset 1048576
>   2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 1048576/1048576 bytes at offset 3145728
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Offset          Length          File
> -0               0x400000        TEST_DIR/subdir/t.IMGFMT
> +4 MiB (0x400000) bytes     allocated at offset 0 bytes (0x0)
>   
>   *** done

Thanks!

Tested-by: Thomas Huth <thuth@redhat.com>



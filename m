Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6764CD3429
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 16:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJDxG-0002Tc-77; Wed, 12 Nov 2025 11:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJDvw-0000Sg-NF
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 11:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJDvv-0008Cd-8r
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 11:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762965778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DeIHPZyBL7Y8OrZjwa5mNyy4mVj2s+eOMI0x62MWnfs=;
 b=T+ObcvrLKpY54p1Y9Uf9geSEZccy/gWLf0ALDFIiaM+LQxRRpEQA3N/9Rxa7Xq7sHkeAYG
 3qNFmTxDbtFlpsoItvFBqTM61BLfiPyuchl+lVPF6LKFcunXEsBdZWy46dRuFQIuRQYIfB
 cIp1FenzhqHb8AjgpzQFIzOEIIQn7FM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-6p99gLOrOsCfxwtQr0Q8KA-1; Wed, 12 Nov 2025 11:42:57 -0500
X-MC-Unique: 6p99gLOrOsCfxwtQr0Q8KA-1
X-Mimecast-MFC-AGG-ID: 6p99gLOrOsCfxwtQr0Q8KA_1762965776
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2f79759bso959495f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762965776; x=1763570576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DeIHPZyBL7Y8OrZjwa5mNyy4mVj2s+eOMI0x62MWnfs=;
 b=t/puLvJIErqNaUVwxuFmC/XbsGP2k0NZZpLILf49qIZQxdJo8UPASsa7nkFig+8Xnt
 q6OM2Btr6uNxtahtM9vEag5n0k4HWeGNfeJ/RW3x9nrHka1Yo+9aYJUuNTtRWd0/PP3k
 BgC3dR57fZvx+rxdWu4Ev16BB97Anbzt/R0PQQz8YRKe3VR58PA0mimd85eYvxZTVb5N
 vZpsnwmeKiKIxX4bFUULXfuKQkcq9voQsKTN/7jcRN7LA3+XR/UM2iih3rpRWWevBFCT
 JQ9nj2Dflh6Ud6M5PpOmo9i+MpqYHP0VZxLieH8zKvMuJmJxe/SFq++Bb93gz6p8t8cr
 8vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762965776; x=1763570576;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeIHPZyBL7Y8OrZjwa5mNyy4mVj2s+eOMI0x62MWnfs=;
 b=pxVubCfzolC4wMtVIb7PAwNc106+1oE7FChJvdaMAiAeKXUD3DsJjpPncf/FGf2/hp
 H+iIwP/N7p2fqsLkSjavlH1/r+uHypyd4/6kQ5BU8T/9BpkjOcY3JkhbJ9kaXJtCbJjE
 Nd5AJbsiQqaWRz+Z+FiCnNZ74TUAM6cVqpU4/cbHssM5rbIRy/Kang5yTMNSphi7E3NE
 FH5ZRZN/Hx2KK71Z1/46FV4F0GrnGVMDS0ZGY3lwdgnDt3HoPwqw37x4wxcr6l5DH2wQ
 0QlMwYUyxO9wVSKA9RHrSDvKlWm+f7r/GihSsBZ9/FNFv7c+HWj1Yl3X/8IgKdnJbEWG
 EaRw==
X-Gm-Message-State: AOJu0Yw5bVgwW5aSSbZ+A1AFNUWec0+JxqwDNwIZOLqcGaHSX0E6nODz
 J5zaXydlG0cwzO2Y0gsKeSMnJyIyYvGQgvkbPkG58Y+Bx0ARzmaBP/IVMzuyiuYTFQVETO9oIbb
 0lY8rxPYWJJnpaKwIiwYGHmMaEaKhhnZBaGNk3Fhg7DhdSZNn52GuzBQj
X-Gm-Gg: ASbGnctreYdWuL1coohi66eFIzLPXNAW2VkqChaK78Kba8zKfZBg/vIyqnSB9Y0H829
 L4HsFX7Vf2oVjtgD9ii6Hz4t7XjAla5Jf6D+qHrzs5M2vQjFpLObwDapb1cn3vRXTUm7JyR+kFM
 ltOo2sM1xsi5nR/4CBqP0p5Nuo//M6gat72PC2N8cHu1BhIJYbw9nCGMeDXIABozWHHLBxSKvWL
 ORaER+ewXQYFW19IZa3n/Rt+cc2QOvQ2l4S3D5SwU52XFeoXc/9PMWCn0fk91YLNNPAIHFvtcQO
 hP29qBYEjkyroBgnmzVjysAqBRdilf7Wvq+594tV2etVt2Z4RV4b4oos1QBgdbUXpTWLWSI=
X-Received: by 2002:a05:6000:3106:b0:42b:3ab7:b8a8 with SMTP id
 ffacd0b85a97d-42b4bb91763mr3510719f8f.17.1762965775832; 
 Wed, 12 Nov 2025 08:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtcyglg/uofbdlKBUFUlV9HSDFiJfzoX9UpP5Sf5JXlf2d/BDXhHR/XumTckFcx4rwohI8PQ==
X-Received: by 2002:a05:6000:3106:b0:42b:3ab7:b8a8 with SMTP id
 ffacd0b85a97d-42b4bb91763mr3510695f8f.17.1762965775425; 
 Wed, 12 Nov 2025 08:42:55 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67920fcsm34365295f8f.39.2025.11.12.08.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 08:42:55 -0800 (PST)
Message-ID: <62f768cd-6b4f-4687-b3ae-e23419c7df9a@redhat.com>
Date: Wed, 12 Nov 2025 17:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 28/28] qemu-img rebase: don't exceed IO_BUF_SIZE in one
 operation
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org
References: <20251111213238.181992-1-kwolf@redhat.com>
 <20251111213238.181992-29-kwolf@redhat.com>
 <c8184f53-b0ed-4f74-adc2-080309568795@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c8184f53-b0ed-4f74-adc2-080309568795@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/11/2025 17.40, Thomas Huth wrote:
> 
>   Hi Alberto, hi Kevin,
> 
> this patch caused the iotest 024 to fail when being run with -qed:
> 
> 024   fail       [17:35:06] [17:35:08]   2.2s   (last: 2.0s)  output 
> mismatch (see .../tests/qemu-iotests/scratch/qed-file-024/024.out.bad)
> --- .../qemu/tests/qemu-iotests/024.out
> +++ .../qemu-build/tests/qemu-iotests/scratch/qed-file-024/024.out.bad
> @@ -267,6 +267,7 @@
>   read 1048576/1048576 bytes at offset 3145728
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Offset          Length          File
> -0               0x400000        TEST_DIR/subdir/t.IMGFMT
> +0               0x200000        TEST_DIR/subdir/t.IMGFMT
> +0x200000        0x200000        TEST_DIR/subdir/t.IMGFMT
> 
> Could you please have a look?
> 
>   Thanks,
>     Thomas
> 
> 
> PS: Thank you, Kevin, for merging the "Add more image formats to the 
> thorough testing" patch! As you can see, it already helped to spot the first 
> regression :-)

Ah, never mind that last sentence, I just noticed that we had "qed" in the 
"thorough" list before that patch already, so I would also have run into 
this without that patch.

  Thomas



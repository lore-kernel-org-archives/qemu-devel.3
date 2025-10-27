Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E29ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSes-0000nu-PD; Mon, 27 Oct 2025 15:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSeq-0000mH-2m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:13:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSei-0004mS-AE
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:13:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475de184058so10625685e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592394; x=1762197194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eMgmYSj6byd6s585648zafN2yVdgrRdCeVUV6Qubnc4=;
 b=iDnxQq5ZcdUzZRTnJ6V37WXCZPTs90g04yHEDsMmm3caq+fWnTN9BURVRGl41oph90
 mhIwlSHw8Dl8AuBckD9RLL8wEN8tno3d7U1TOwJtnFt4nbrwXfZ6w0nB1UbJRcx2p22+
 srFX4JrRJAVfVBHvW13cDjaKPO8gxwYlqkAabO6dzxTcoGmI4wwJH+Q34TydgvVgi/X2
 rUwqdsC3a0sN3ee9ahYQmV1EVgVZS+rWW9obIjspK08vvlX29N9T5f0WTsLTHcYUQHgC
 Os9j5A7yVrULGHIUMyHb9f0cXOtA2S2dGvQrQq+iwxcCJB44knjxuqMSqiY5Rls4P2dm
 3I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592394; x=1762197194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eMgmYSj6byd6s585648zafN2yVdgrRdCeVUV6Qubnc4=;
 b=LxMGSllafTy1NucxRAk9EbYA/es3G5gxKs03p3iZGxn+7QY2Ev8KMckQper8XRoa9h
 dYV640Ajxj+6IUzcIRZ5PrxFXdf7R3K4mSO1b1pVDfxZdYSiIEzTpCmg1gQctBNtrlEL
 f8uqx16/sbPkks9H33FKYE/e2KJ45ujC+56t22tGzWXYT9ve/xyYxfPsipZetrGVVI2v
 BTzB1MjAAZrgnhysp318YUMm6vci+HmDNHzk0TFgI6MJ3gH9QkaQGnEvPd0YAOTZCllG
 eFl1EKERfyXE7HSuiMCHygs3SqeSe6jw3kUuCGfG7vDuqZ7J5AI+bnbDv6i3CjiLtro3
 UPYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeNo0MVV/kiguha4e6hlU4rFR+YDtkHlBkps45QlPhepmHM7OKQ2YLnwwWAkZEPpr9Z5SjkZLPide@nongnu.org
X-Gm-Message-State: AOJu0YxXXvUgoRObPuONk1BmOKh5IIkQisrF71F8hwGjjfZZE6O8m0w6
 jhCVQSu0JlqZlnpxYHHo67g1l5P7hIxoXx6/5zCl1a4hw9138HeDsmIs68vTNK/OjSi9T8J2IVk
 0k8Kem0Y=
X-Gm-Gg: ASbGncvTZYUQf9Vr820T+U4i8/wmKwZgnmc7xPt3QK1kHoJNNU1FnT6+gimz4xOKaoo
 Nt2iIN0A7w+ln/ATzQpcwBgFdST+GF3NAKwi1ZiJn9b6kxlHlJbCRqjTxik4joKtMs5Pu6ltnDM
 6dzy7wJU44z+Tv7cj66EzIBtObabrv1L82a/g7YLUUvcomn/O6wtdh5H2b4doDhgWWn7nfGtKJ9
 46PjZ6wWRPjGJ/2YuRP2gbd1ySEkXgMqGPW1kji2mSYKWbpRCYsfzoOCWQO8/xXGjTioRDWjqvK
 B93JKxBFo9UP+qTwheo57FhollvQ8xFeFhCnTPgBnCntJLNS5PEJ0d9IILAEpssskJIqzCvQRiz
 aRE3y1CfH/FG2t08dubVUO8ez+rUHBELRFeUMX1wQh5a0qWUqimmI9vJrvAkpbTAwtEdPTJI3MJ
 H//KH/fCPKno+H05/oAgk4bih4sPPVAddAD72shxO/HSlIDpoYwrAENA==
X-Google-Smtp-Source: AGHT+IG41sXZLjntQXNIenGWHt99d8Gg6PROXdPaHJJbTZreYJaOvMZrvnqsjfcPC7Tkyrf5bjczDA==
X-Received: by 2002:a05:600c:4e12:b0:46e:1fc2:f9ac with SMTP id
 5b1f17b1804b1-47717dfe76dmr5877095e9.10.1761592393651; 
 Mon, 27 Oct 2025 12:13:13 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477c92sm150413555e9.2.2025.10.27.12.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:13:12 -0700 (PDT)
Message-ID: <6bda512b-aee6-4dec-92da-727679efd2db@linaro.org>
Date: Mon, 27 Oct 2025 20:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] virtio-net: make VirtIONet.vlans an array instead
 of a pointer
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251023135316.31128-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023135316.31128-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/10/25 15:53, Michael Tokarev wrote:
> This is a v2 version of this patchset, rebased on top
> of current master branch (I had to adjust virtio-net changes
> a tiny bit).
> 
> First patch has been reviewed, but never accepted to any
> tree, - I can push it through trivial-patches maybe?
> 
> And the second is a trivial change - removal of another
> weird migration-related macro - but it requires the
> first patch to be applied.  It hasn't been reviewed.
> 
> Thanks,
> 
> /mjt
> 
> Michael Tokarev (2):
>    virtio-net: make VirtIONet.vlans an array instead of a pointer
>    migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE macro

If no objection, I'm queuing this via mu hw-misc tree.


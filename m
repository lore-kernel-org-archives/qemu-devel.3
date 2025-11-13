Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD6CD5BC2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUvO-0001DG-KY; Thu, 13 Nov 2025 05:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUvI-00013t-68
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUvE-0002Sc-Fg
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763031077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7dIJELpbXoDcfOzuujediPQnXlmQgSrqNQHlmr/Ckbs=;
 b=XDyWS1nMMPbhvinf593POOJRxhU/DKxhD2d+oAqRbnRa1dW1e/OWI8p5AgKh2dkiZ5BPPx
 U4zKFCIhu1l/RNEaA2e75hMYXWpHTBtAygk7n6mjuwPRh/qS6yfWCgyQIo24NvErwrR3Mu
 9U4IXbsfRx+tgNJpjuujS0U5nJ9Ib4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-SVvqTY39NAuoviliqRVCqQ-1; Thu, 13 Nov 2025 05:51:16 -0500
X-MC-Unique: SVvqTY39NAuoviliqRVCqQ-1
X-Mimecast-MFC-AGG-ID: SVvqTY39NAuoviliqRVCqQ_1763031075
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so500637f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763031075; x=1763635875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7dIJELpbXoDcfOzuujediPQnXlmQgSrqNQHlmr/Ckbs=;
 b=rEqVETqcdyVxbR9G7sNtMxUqUBWFcD/hnjhNJiNwcK3/Fp6ERvMGQT0VXrSumvPABP
 gk9eO3RaUgYVj919PzaDMcVioNZYeGmR6bhPSlAJGA1r6nyXidbozs+ramLcBaBDJEhL
 V7EXJDO/HNdaFBi/JioxdpgQLO/MPpErRLsaq/EiY0rYLJq1E6fGqGmYBRdM7fb77SXP
 DGfMNeQW44ESqBP/grJBdm9De8kLJx7jeERhZwRjWfWW59oN241Q3fYnN6rTCA/5H2ul
 +QpUHmHFqoB5TQ2TsSQH56SFoTliKlKL+Tjw5bKns9Weingr9gmF4SzKwc3U7nbUxir3
 cfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763031075; x=1763635875;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dIJELpbXoDcfOzuujediPQnXlmQgSrqNQHlmr/Ckbs=;
 b=fCzcoPIDx12IzPg/8yqAd6AwxGTK9Y+hn0uonjVCJ1kX5EBy9guhXvc4zscAFUkkCJ
 yNGXq+uMmBZrV/fohDoTrNyRG/Rlf5+1Jfp9VFaMn4Df5Vqp3gf5Chw1k+aadkyBuLrz
 iTRwJ+fv/ZtBBtGN26S4anHtliEaYQ60ZJxazw37iIaurR5ZfcFuRw/iZHn8v4pZti4N
 xfhLiSPZc+djMApNDdc/iJP+hp/bOHOhUROfNWgH6UnHpBwi2N/3mfh7Ex0SoGRwb7sK
 dk96ry0bySRQ8F/UjpiXOiWIfJY4h7r3U8aT/yNaXO/7HbondA+x8w+t3s3xeBqTOlL3
 IAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5pqEZ3S4s85jaAzyk/V2jSk2vvy1dvRuCzkTyxZKRU3HilCorx2Liym9gBkDQUr8b7bCw5r/FTQPK@nongnu.org
X-Gm-Message-State: AOJu0YxxUXLk+8ZP7w2AMU1cImZdU4XCvmzc73KeEUyDTMG8ey0lAwrK
 mUsx3HuoXpz3F4SexFRb/0niK42Ip9HIPcJGLu8wGUqoKt+PE6VLQogpYRduiBAypnAF/8Qg4AH
 hmMu8CDw+HFghhKquLTeuhs/FYn0Tf2PvnKu8FxkWis3Xw5QC8q12eyt6
X-Gm-Gg: ASbGncvPNIXmiRrmHf0mOH6LqyiwszCq/g6e3cSXjDKShKHAGw9yMplMt4rPpgviulX
 /aqnWUFbsMlaNIIjlueQLm6RpeI5Gf9qthjmdXgE+aqKwSnhTfwnBRKPtUQ9XvFa6dVu3D1TDx0
 3ftFCJyofKEpmL5QtusWFndzf/PCkcLPJJtbE9rBhRRQzZAmZmW4Zy0GM/+qxvqZnMpUSxQcRCr
 WBYccEoTFfA19nxZQO8x6q8+FOXuSc9fDN45nEtIEsml8EwkCg0dIf5MV76QYsPLVK/+TxctOMz
 q5M0kJF5J1PUcVf9a1ThuM7ECjhpPMDQIqlnA+ezrA7kstEMMiNi1CLGByKQEsedr9N5TEE=
X-Received: by 2002:a05:6000:40cc:b0:42b:2ea5:61b6 with SMTP id
 ffacd0b85a97d-42b4bdb7ecdmr6194878f8f.46.1763031075222; 
 Thu, 13 Nov 2025 02:51:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKz7OKHrnC+qPDDTqef2fxDqFCjUoufEltKaP2khLB6FLhp3H3xnIaE2SB/3VB2Z0nno469g==
X-Received: by 2002:a05:6000:40cc:b0:42b:2ea5:61b6 with SMTP id
 ffacd0b85a97d-42b4bdb7ecdmr6194851f8f.46.1763031074818; 
 Thu, 13 Nov 2025 02:51:14 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b074sm3086710f8f.7.2025.11.13.02.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 02:51:14 -0800 (PST)
Message-ID: <59aeb351-1cf4-4bcc-a66a-c7b4f4d5bea1@redhat.com>
Date: Thu, 13 Nov 2025 11:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] tests: move test_kvm to share.linaro.org
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Woodhouse <dwmw2@infradead.org>,
 Ed Maste <emaste@freebsd.org>, qemu-stable@nongnu.org
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
 <20251113102525.1255370-12-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251113102525.1255370-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 13/11/2025 11.25, Alex Bennée wrote:
> Linaro are migrating file-hosting from the old NextCloud instance to
> another sharing site.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> 
> ---
> v2
>    - indentation to avoid long lines
> ---
>   tests/functional/aarch64/test_kvm.py | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
> index 9fb9286139f..0a89694ca75 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -19,9 +19,7 @@
>   class Aarch64VirtKVMTests(LinuxKernelTest):
>   
>       ASSET_KVM_TEST_KERNEL = Asset(
> -        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
> -        'download?path=%2F&files='
> -        'image-with-kvm-tool-and-unit-tests.gz',
> +        'https://share.linaro.org/downloadFile?id=Dt5pQbTe5RrxEii',
>           '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')

Reviewed-by: Thomas Huth <thuth@redhat.com>



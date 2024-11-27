Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9FD609A3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 06:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGBhL-0007pL-QP; Wed, 27 Nov 2024 01:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGBhG-0007pA-3Z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGBhE-000837-Hw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732689523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+vyx0MDN540g03Itm+q2hUjSL6I4sP1r/e7cbS6fOh0=;
 b=PL4ge2T90S5v63cMTBm3rxmIy4CK+2LinotZ6rknqlzFHag2shxYh+VHrri0HRH+czO9Pd
 CWUcv240hzsSIhPTTORS0Rrb0fHIgmf/8PJFn/tGG8Hc939y6q0McN60UzX1o0/1lVs0EH
 YHOBZD+icV7ncJSERG6I8nfqq8VlRe4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-aYMHES8_M-yhWPaFf8rEVQ-1; Wed, 27 Nov 2024 01:38:39 -0500
X-MC-Unique: aYMHES8_M-yhWPaFf8rEVQ-1
X-Mimecast-MFC-AGG-ID: aYMHES8_M-yhWPaFf8rEVQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so30210485e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 22:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732689518; x=1733294318;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vyx0MDN540g03Itm+q2hUjSL6I4sP1r/e7cbS6fOh0=;
 b=ZiaLf08QDk1kbdr7+tp008z1eC/w3n6BjLpONQC/V0ftnCC3/bKwyP0ZwxPYFtV6fN
 +ihQa/oxN9d3mJeYMsm3+L1A5XArkz9F1NjGhgvSmdkLyTuu3SxO4PUdCMzSBL8S8Ixf
 s+7qyyvrOZpgFwpK86Q4Gjmj0ZlEqMbSufmjsz9oQFoMCDGZGqXATrVD70ICgi0iZiLx
 d1JrTyWNu9LgqVTtmQ85crQ55aBHFOpzsXLjkfZygkwqgR57b47MwA4tD2d+hidDHrDR
 +5dp+mLay8jGXy68wNIhKqzIR8t+JJwNINLDhqBhLMMf1cxMTKGTxWm3n8KR8Z/M3Wie
 7uuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFbnea+Z6xd7vELrsFK71uYtmq8n9tqEyw0JGvIQaXLdgBWlfN7o3dhCBjsDOTyzi0TQjRDwnBmqtd@nongnu.org
X-Gm-Message-State: AOJu0YyoIbB3MD9HjJCuNZZ9hGUTNSglEYCSw9Ktyz3a9BGoZb2GpzIw
 QHDnKJS8aPBKkqafC8mIvQjRwmbpl/ZsbP5f6o2okBi8kwTkaK4DW4Zn7ThpqZo1xcMpkHwUBFP
 /5s6vs0hEbiZ8BIhnh9JdER1my/rE41IAxuS9tDiCkQNc8CIItBPk
X-Gm-Gg: ASbGnctap158yjD24saXdddkqsrKJBTeRQya552QXT9SDG8bviCf8BsGRjfuyhvCnu2
 AfC4mouy8viVhnbvgfsdprC1lQXVZGhO2m11T9xuYE/1HyeiTbOUPrNFnBEIBaDup2njUKAnLpr
 J5itDqEMgNKUR6aWpyCXoOWsH0CwtGqIPQ2V5mzRj2I6TEpzjTxDB6JBoCufmzyLnYMrYQDVAns
 NGmZxn3jZP1D9wt4v1VBMEk35TxZetBlBOyzsQ8fb1O6/jat/scNqOh4NWK2hw74Kow9nYSVWiJ
 OoxGYw==
X-Received: by 2002:a05:600c:3590:b0:431:5f8c:ccb9 with SMTP id
 5b1f17b1804b1-434a9dcf254mr18960265e9.17.1732689518631; 
 Tue, 26 Nov 2024 22:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWda1VHW/JRNGFrqwLPQR3tohD0vY6qCEKfYM5uV50KzMla4DVRrbeD6j/qTx4elXTPnKT5A==
X-Received: by 2002:a05:600c:3590:b0:431:5f8c:ccb9 with SMTP id
 5b1f17b1804b1-434a9dcf254mr18960085e9.17.1732689518305; 
 Tue, 26 Nov 2024 22:38:38 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad60dasm15215778f8f.21.2024.11.26.22.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 22:38:37 -0800 (PST)
Message-ID: <59a3b2b4-3a9a-47c4-bbaa-6cea6b6c50e4@redhat.com>
Date: Wed, 27 Nov 2024 07:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241126211736.122285-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26/11/2024 22.17, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/style.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b500798..13cb1ef626b 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -416,6 +416,16 @@ definitions instead of typedefs in headers and function prototypes; this
>   avoids problems with duplicated typedefs and reduces the need to include
>   headers from other headers.
>   
> +Bitfields
> +---------
> +
> +C bitfields can be a cause of non-portability issues, especially under windows
> +where `MSVC has a different way to layout them than gcc
> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_.
> +For this reason, we disallow usage of bitfields in packed structures.

I'd maybe add a "in new code" in above sentence - otherwise people will 
complain that there are pre-existing examples with packed structures that 
have bitfields in them.

  Thomas


> +For general usage, using bitfields should be proven to add significant benefits
> +regarding memory usage or usability.
> +
>   Reserved namespaces in C and POSIX
>   ----------------------------------
>   



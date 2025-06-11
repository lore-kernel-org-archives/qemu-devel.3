Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED96DC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGK5-0006JG-9S; Wed, 11 Jun 2025 03:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPGK2-0006FZ-D8
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPGJy-0006Xz-Ng
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749628588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YsJbuCbe5JRneX3QV2NgxbIF88VzoALe/HxhjozhSI0=;
 b=PqjVK9aWadxYlJPNDP0c1/m4yEXLkeVQ+PmP0vKiutJfj28qGBfqHs/nZa2X8pQe4+ZcL4
 fgFz1dH9yyG08JYJFuvVPSzUQFzqM22Sb0/4Ye5zt6JBvxh6MSVP6ANvYrmH4YNYJD1wSX
 97qu1NvLT5jjFY4vxTgmW8Xr1oEXfyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-UkY8NNdXO7KS88KAA4XqZQ-1; Wed, 11 Jun 2025 03:56:26 -0400
X-MC-Unique: UkY8NNdXO7KS88KAA4XqZQ-1
X-Mimecast-MFC-AGG-ID: UkY8NNdXO7KS88KAA4XqZQ_1749628586
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so32548605e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749628585; x=1750233385;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsJbuCbe5JRneX3QV2NgxbIF88VzoALe/HxhjozhSI0=;
 b=qKDV5N/tsfqUm3NpZHcftF7Nxoqouq5IMHMtArUdMmtqEI7RjsAmHek3frvthrwKgE
 YuPOtRzchXE0dpxvc7fOjib9Rft5rOdzefzV0n/o4xSu3jzUMunlJCZhG0tY1PY+I8aO
 pk0bi+fe3Mm5kqrc6n77dd8MMbCuansTyWbzF3cB9og5gJh+rIgR9qtxRVQX8emWbRCu
 pKvjAzYNe3+YTGyhc2qdCGuOBuzlJL+zvxF7ApwtPYxxA2n2avl3XpWCOrKurVkEhtC+
 ZXxZ0ovf8NwJnyPpbQc54Vjbds+TVUc+mJqQM3Fugq3NWTZtkGtxDskKd73B9jS5XgRt
 IQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWK/oXuiK5QrAHfskHJDp15GrbXkwvfTOLViXoXXJfPhYNAlDp0O9fqMCoFdEIAbIEEyUiRvFVoFsj@nongnu.org
X-Gm-Message-State: AOJu0YwOgrI17gH8QOjPLFpiu5PAq29DuDZ5I5lMthxfTZvQqsv2AwD2
 wpQIDIDyrRW2xrOBWjReyLbdUJY+Q27qA9PV9Dn93doUGnwojrJxu6cjge4gwyqKAWAH1F3X/DV
 B2Avm7fswoLjIBoHEKU+h0SWnVVGPzFAfspVPLpPu27pTxTNqEf8F9TR61h2zw9vj
X-Gm-Gg: ASbGncs5y7JKbhDZmiSvAA5n699eqJwOfIlgqO6XYy0XMAA+V0OiTuQsTfkxT6C5oMk
 OPMbT+/83uB/t+Ww2vml9ZWXRJqIBeLmGRdWyi26agjW5F3aIgOtKOpqQBRHrRibfUP+jXlrJVK
 LTJ9q9FD7+gtQBj59EkXckUWwyONwCzsQM/4o1o97kyejBwVO//b93gzhsmx0YvHxZN5h23mz3f
 afBtOCRCqGQ8fPJA4+tH6KzKpvnP4yXrTTHHwTQFp45x0eCFPxXIC5L0iDcqp595CAHoo5sA6Yc
 07IiB/emIQfJfK/jRLhosyWO
X-Received: by 2002:a5d:6101:0:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a558a56a92mr1252445f8f.13.1749628585177; 
 Wed, 11 Jun 2025 00:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa9EhoFvN5NhHAREDbo8ZUD7GdO/aKx6OUJgy0+qnsn6oOk218rDhRrckUP54C5O1mFfSIvg==
X-Received: by 2002:a5d:6101:0:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a558a56a92mr1252430f8f.13.1749628584835; 
 Wed, 11 Jun 2025 00:56:24 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a53229e009sm14876566f8f.16.2025.06.11.00.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:56:24 -0700 (PDT)
Message-ID: <e14ce991-7cd5-4875-bd99-5dc27a22be78@redhat.com>
Date: Wed, 11 Jun 2025 09:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250610202110.2243-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/10/25 22:21, Bernhard Beschow wrote:
> +/// A macro to log messages conditionally based on a provided mask.
> +///
> +/// The `log_mask` macro checks whether the given mask matches the current log
> +/// level and, if so, formats and logs the message. It is the Rust counterpart
> +/// of the qemu_log_mask() macro in the C implementation.

Clippy complains that it wants `` around the function name.

Paolo



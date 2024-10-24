Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99675CE8E63
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 11:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3vuU-0005H5-FT; Thu, 24 Oct 2024 07:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3vuQ-0005Gl-MR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3vuO-0007HC-Ky
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729768898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B5OSalKmQY3AB4U3jlApWZKyymIwArrmTZPfvf1yANQ=;
 b=E/auXmXgwB1CHKkpk4tvkNg8ZF0HgajJJvH4Jl+XzS5g7K3BfEhtXQITWGj5ZyHHzaswHq
 90Ux9QkH0iLgWEozCIHcPTSeCUOYrfI0TiQO7EMatSu6v45v1fGKncUm62FuFGgf9NxGol
 F+lQvBzY3uNh/99YtdRKANSpGwCBcGA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-pktbFvEFO7u1O3N11YhyoQ-1; Thu, 24 Oct 2024 07:21:35 -0400
X-MC-Unique: pktbFvEFO7u1O3N11YhyoQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so389700f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 04:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729768895; x=1730373695;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5OSalKmQY3AB4U3jlApWZKyymIwArrmTZPfvf1yANQ=;
 b=K/E2Mzy8mlDK+ome/8/p4zJVWcmB8dMcv/1/+Z9cM+0/0CWpxvFwkirHpX87Dstp3b
 K5bWlOv8zdzpKnlFGH/ke1tTJXHAtRldES4Wo36xI/o0831qLDaI7TqTxAzjQMhM6R5r
 rY10U+A5vOaq6O1JAAoMn7fnouU/kX2OdD8orycKZX7IsCjeZPc8EvPVczaSBKR1+efI
 or/sIyZqH8ngD372LuWTHfek0rI7pROEWlDMlB+cGLLqr15t4ifX8+Q25tbF0w3Bo0kf
 Y88fJfj9o6cBuqduirwzEUVduRo3ZwvzdN41fM+XFyKuT04Sd9jdBtxonqEaplc5Rgc4
 zhCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyAsmwBjPgsn1qkS8hLrbYeADpoCKBlbOfgApOwzxEimalXAidvNHUuYHVdF+tyaLIEtErW1htrEOM@nongnu.org
X-Gm-Message-State: AOJu0Yz0C0AeFxglxy0Gubvp51Wk5joyxN/Ru7fasasmDr5VlITYZgNg
 A/mFf9FA8zgMAJ3LBZZiaoux7exmP9yy8MT+jY04EYjFoIrBsuB3p0Z5noca+OlR9q8tdnd0vYb
 0FH81YvT+WBfJ/kKIU38x7g3aYrBMdJiz0l/8VFRgON183DhoNfV9
X-Received: by 2002:a05:6000:1547:b0:37c:cfbb:d356 with SMTP id
 ffacd0b85a97d-37efcf1d91amr4410998f8f.28.1729768894670; 
 Thu, 24 Oct 2024 04:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/TBy4oNt1t8E5/t6+1aldGLhJkuDQr/aSlWxUavdyj7J1T6DY51bsAPGhODchodL7xIvvgg==
X-Received: by 2002:a05:6000:1547:b0:37c:cfbb:d356 with SMTP id
 ffacd0b85a97d-37efcf1d91amr4410982f8f.28.1729768894310; 
 Thu, 24 Oct 2024 04:21:34 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a4d532sm11036615f8f.46.2024.10.24.04.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 04:21:33 -0700 (PDT)
Message-ID: <8f6fef08-d3ff-4155-9ba9-6647f7411452@redhat.com>
Date: Thu, 24 Oct 2024 13:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: remove erroneous file that breaks git clone on
 Windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/23/24 09:39, Pierrick Bouvier wrote:
> This file was created by mistake in recent ed7667188 (9p: remove
> 'proxy' filesystem backend driver).
> 
> When cloning the repository using native git for windows, we see this:
> Error: error: invalid path 'scripts/meson-buildoptions.'
> Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
> ---
>   scripts/meson-buildoptions. | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   delete mode 100644 scripts/meson-buildoptions.
> 
> diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
> deleted file mode 100644
> index e69de29bb2d..00000000000

Queued, thanks.

Paolo



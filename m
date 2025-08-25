Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE2FCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTjQ-0000iO-Eb; Mon, 25 Aug 2025 05:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTjN-0000gn-Ks
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:43:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTjJ-0000rf-Rr
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:43:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c7ba0f6983so668966f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756114987; x=1756719787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0sfbVIoFEZrS888VJSEblzKkwNzfAnm+rCRYKPsamV0=;
 b=nZTnF4ofGiIYtSoNJg0uu4iG3QTmmbVgUjqeatvAW5JhizNugIRrAyR8jIUzgi8752
 89juixDdrSE1mt28srjPgy4YR9/kPNViSYCG8jdGIxhOjo66t3KaXB1rDSc41zUg35/J
 ABZ+YRvAlQfj3dSxo8806IiaqnzwdFWT7YRQzm1hAQDRz5dUNcCIqI+D1LFLBip4AzsY
 ZEj9FvKt91LrTWyMn/MNrLqRcVHHFgVJX1yB5U5mEnAEyhnNQ6JCBzQJqV9ykYHXd+3a
 Nu9OBJkLwTQu3TyYWKQ8CEbLgHs5TyKjbaUl7AZWDB4euZvrKBJ0naHWWM8RQPOLYavl
 ZENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756114987; x=1756719787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0sfbVIoFEZrS888VJSEblzKkwNzfAnm+rCRYKPsamV0=;
 b=qgrVEXVbGoysYWIRzhnDGCkI4hcLGJpxqmrj2xA1mus1wTQ6z3waKWZbjaFCKOy+Pn
 epnEOJscevcBREs6ZroPL9h2hRSowTDDwgveoCFZo0wTu9V/Diy4QWKCtcCe+dARgcds
 166UpHHNMsxmt94ejM0RpB1facqs29N+FtbOv9M2lx63sTdgB58Pe3N+g+CLFbd6gfQT
 JfIA/q4euShAG5ull0bFYxbAwzMMRgcA2ebN+TU/ygPnute3wg6GMz/C4lEoKAxFsoWD
 pD9QMZQNFDaYDizPExsSIZZLAScezsMIG6bmie+8Z0q9/gXid6sAbIriP8YSh1P871Za
 PzXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkeVdzIs4YjoA6APOLu+pY9Kkg4RaDkBWNkWjiYxJNAEHM2Jx35gyqBtzrsbPt2cLBUz4Tn6gZiGJa@nongnu.org
X-Gm-Message-State: AOJu0YxGASA42tm4Ae1u/8Q7jTCtdT2L0VtrEwhre++JQTL7QIcFLz2a
 fCrJzhw8rtN35h3oZtDNRyEg1UQALuyLNXvU+t3gcc9ra3xeqTuzle/h+/CqWROAuZ0=
X-Gm-Gg: ASbGnct9i0ZiicrzyeIO3z331EEHXP6wPiCEo0gDevVxNnuzSF58NW0Zxih8n5IvQLW
 9WMUvZ5MB9nu3QCcbtS/w923Ywbbr79JivaWVneBGrn+FU7KpUL7Ivp2iCPuPwE9kmir9o3/Dqh
 mqw1b8A5tM/xAOLB2BR2tExpJmNiAPLlgzgU4GjdPW8hBwQy/1KUG1yRlYZwt3JBMOXLz29lnBa
 pTerNjnPbPBQvQ+j81W9vZWZv8O7vUjfBCJWJfKtxD6BWV/waT5VGIGjKSSyr+a65+DRoYQOE2s
 sxS+UnFhYdv5IZEJFrTyBOceV+jZRJtKqnaEu0sBAC1gGlsI6zRc2qZbQ6hvq9fevPzDwl5jeLW
 dM+m1S8jGcsM9K+IOAMzaTGsgOrh2h0oBaeh08b3jeV7ZR/BYY1L6VWxyShgYp7D6AHL/gc2mbl
 cd
X-Google-Smtp-Source: AGHT+IHFsCXI6RyE+8Pumea9aLdErmxD5/5dh5nk6SGv5uw0KhtQlgnDvKvZPXlFwn2/l+B5AB6Pnw==
X-Received: by 2002:a05:6000:40c8:b0:3ca:5f27:46d0 with SMTP id
 ffacd0b85a97d-3ca5f274ab0mr802802f8f.4.1756114986767; 
 Mon, 25 Aug 2025 02:43:06 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b62dc6c30sm15594675e9.2.2025.08.25.02.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:43:06 -0700 (PDT)
Message-ID: <ce955ef5-69d1-47ad-9747-ea55f87d6df4@linaro.org>
Date: Mon, 25 Aug 2025 11:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] crypto/hmac: Allow to build hmac over multiple
 qcrypto_gnutls_hmac_bytes[v] calls
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <b9eadde84d8189635362e4e73a4941259be91a8f.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b9eadde84d8189635362e4e73a4941259be91a8f.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/8/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> If the buffers that should be considered for building the hmac are not
> available at the same time, the current API is unsuitable. Extend it so
> that passing a NULL pointer as result_len is used as indicator that
> further buffers will be passed in succeeding calls to
> qcrypto_gnutls_hmac_bytes[v].
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> ---
>   crypto/hmac-gcrypt.c  |  4 +++-
>   crypto/hmac-glib.c    |  4 +++-
>   crypto/hmac-gnutls.c  |  4 +++-
>   crypto/hmac-nettle.c  |  4 +++-
>   include/crypto/hmac.h | 12 ++++++++++++
>   5 files changed, 24 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



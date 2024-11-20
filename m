Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC83D6395D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 14:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDlwM-0001Z9-Tm; Wed, 20 Nov 2024 09:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDlwM-0001Yz-4j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 09:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDlwK-0006bM-IS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 09:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732113858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rdYbQ/Aoj/+krIY68V8wdmLLwU8uwwkYZeL8sdybFSc=;
 b=OMUjBHsFk/nTo6mQ0IC81Do3z55gf1nAZDymjVuyubql0Re+zkojk/eN05v0JalK/JbuZE
 w2BGEFbAeK1Zdw4fCem7gPB1ffvQs0bDrznoXM70QDr6IrRhjOaKTd5AyZRagWhdMv07aR
 2+C6DqeOrcG8oYSfLREfNahqVImg6xs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-XU9iQJ0_P4qSIvdV3rWHmg-1; Wed, 20 Nov 2024 09:44:16 -0500
X-MC-Unique: XU9iQJ0_P4qSIvdV3rWHmg-1
X-Mimecast-MFC-AGG-ID: XU9iQJ0_P4qSIvdV3rWHmg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38229779bf4so3262460f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 06:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732113855; x=1732718655;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdYbQ/Aoj/+krIY68V8wdmLLwU8uwwkYZeL8sdybFSc=;
 b=NCjEx4nXBm2HW3SvRONfRCEdpO+a7fTaSBOjuxlh/3dBdd7guVzPgJ8spZQk5GH4cS
 vUO/ShLjUD8XktunY9JFPxzsopTEZnqo0dQJoOiU0C0/YodRe7ghQ7KJwA9fYP/c+9M5
 QWUzbtHEFr/vwLdcCYo3ORG/eKl1mOR/qmPQ84lmWFlWIHvxJBFTQqNSIYtIJS1AfddY
 e9VDeHrrZP8afg2EJkWDAhJ8vXDH4PYNFis7G7pJnDWbaH7EhTQQrnjwbaZLypjBQJhK
 pqPUzpG4RWXiUufyLj1QNkkPl9pZfMUh+cXGK/uv/juHBUyPWTCOgOHZDfzMZZh8+EzE
 gKlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJtZzUT+glSy7krbBsXigcT99E0Ldpf2+mykAlweXamHqcpRYahxtoxxgL9Mi8Ogk1GxQCcL8u0VFX@nongnu.org
X-Gm-Message-State: AOJu0YwPUZ/vuW1VcRrjx/Fsje2M/+hauOX94XVq5T4SjY2eQE4PZE2g
 LzQg0/4r+0pDwptu/a+6ZWqe/DyKVqcpw5GwU9XZuAFoQG8xMfEWKnbim1FYeEv+NXduHcRyAkG
 SaZWlRd8WVRiT8R79jbLZvgG9dVlwEqS1sQYerInhmf7JNcQtu1W8
X-Received: by 2002:a5d:6da2:0:b0:382:37b2:87de with SMTP id
 ffacd0b85a97d-38254b14b66mr2786778f8f.43.1732113855405; 
 Wed, 20 Nov 2024 06:44:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfSOpI4AnI6+AaLCUfDP16N5uQqbFEqvf8mwZnBUvI1o08G692uycMqVWll2dNSn9xoqm/rg==
X-Received: by 2002:a5d:6da2:0:b0:382:37b2:87de with SMTP id
 ffacd0b85a97d-38254b14b66mr2786754f8f.43.1732113855056; 
 Wed, 20 Nov 2024 06:44:15 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38254933c32sm2293345f8f.70.2024.11.20.06.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 06:44:14 -0800 (PST)
Message-ID: <aaaf219b-dbfc-459c-a531-02b5c494c65f@redhat.com>
Date: Wed, 20 Nov 2024 15:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] chardev/char-mux: tweak mux bitset operations
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
References: <20241120075321.27143-1-r.peniaev@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241120075321.27143-1-r.peniaev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Queued, with just one change:

> Also add a static compile check that MAX_MUX never bigger than
> `sizeof(d->mux_bitset)`.

This needs to be multiplied by CHAR_BIT.

Paolo

On 11/20/24 08:53, Roman Penyaev wrote:
> Patchset tweaks bitset operations by changing a constant to unsigned
> long, introduces a static compile check and simplifies bitset operations.
> 
> v1..v2:
> 
> Rebase on latest master, incorporate review tags.
> 
> Roman Penyaev (2):
>    chardev/char-mux: shift unsigned long to avoid 32-bit overflow
>    chardev/char-mux: make boolean bit check instead of find_next_bit()
> 
>   chardev/char-mux.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> 
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Cc: qemu-devel@nongnu.org
> 
> 



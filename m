Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A59CA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utobb-0004Va-Jd; Wed, 03 Sep 2025 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1utobU-0004V8-O6
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1utobS-0002nn-9H
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756910209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=07Tm0RoNjoLA3GT4e2R/HZf+vIgfuiSfnYjYd7CX3z8=;
 b=OSdbdDbFtTPZkp3x7fXF16+q3CMY16PjSF9ztGxqKS3xjHjSZnaS7w0v56PPvrpLhg/q8W
 6UbnPZaCYZwpVIsCWbbwPTw2E8IsFMRZ6aShDRnbeXaX2WWWHVifgfifjiTYWllAEWD2Ec
 UIFDHEc43DYemItow5qiBfJuKeJ6MIs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ioFJDs7_NEm_pyCcZ0Ubwg-1; Wed, 03 Sep 2025 10:36:47 -0400
X-MC-Unique: ioFJDs7_NEm_pyCcZ0Ubwg-1
X-Mimecast-MFC-AGG-ID: ioFJDs7_NEm_pyCcZ0Ubwg_1756910206
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so371970f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 07:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756910206; x=1757515006;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07Tm0RoNjoLA3GT4e2R/HZf+vIgfuiSfnYjYd7CX3z8=;
 b=PMr0Ib7QQJSZxvZCSGMjWrZt9mL0Oz37xUVHkhj+AwwwfkAMtYE2fgf6pNz0RjeuUD
 7OKcnbYH2CC6L7EG6XIA6YOEH6JihE0kYtk7exPJBsmjMyczNn4oeqDdD2IkLe7FxQyA
 3EvHtA17wNwGa7BjcdNgh8Dqtj31B7lmdXTnLEUkJjsOxxo0DSZU8qrBj9wfIiuJImh8
 jJGiIU9hKAvFugpXgx12JnEj3L7p6svUZoTeX66cu51YNpOlry5J/2l3JsKjgPnDW5Dn
 tSRizv0OXiZSDG2b+cuzEV8lybLdQBrvNUOfrvt0U7d+3dv1k39u1L+dvSEb7+jIo5dC
 tQlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWxNnN8a4CCuLVOJeCTjYiJknibcTDoWWN46bCgh7PIYUlJU57cHm60dXuwbzeXfapZRXd9Ry+2aK@nongnu.org
X-Gm-Message-State: AOJu0YxkPXRCg6tIOGJQuoMVB0vSbbzwA9U2tB4zsf25e014qYl2FMyo
 /OdzQh8Js8zRd4YhKhe7r2AFWtTxuwWy7Qvk6D/Li7UzYGmmJFI0P6/77Wq+UD4rrHlKdmeQi1j
 3msyXrcHn4M8VoFPka01HLNuNgkzPGefuunp3qNXpAmtKb6jvqhBXSKjb
X-Gm-Gg: ASbGncvOBrfrR+Rlz5GQi/xW4EqpHP8L4/WLx2lCRo3UfKpvO1jzO3kT2cXH1ocYXoS
 fL3MGbG3yu/b5ELcdGa+gbBJCeW/vgqT4Ws5LHP3gQ4DNHttoAHvfjK+wo0xctdEkMiO+fQy5xL
 m3NJOb7Kia2/RjPBb16gXMdcDChyMC50Ksa8KpIGYwZPbz3PVBJsffnCRn1YIpvkG89BIU4zhdk
 OfqnVeWmQCXdH8ZTlJwo7pbiepD0j5Ojv7pjO1A79hmErljVx/7a1Hit4D1BVe8ph/j4PFjHoUR
 BRhZuAq+pjg5ZQizZqNklaoZIJnbkB9uFs5D3LNb18GPBBhXa8cNP1YgGJ4PG2GWKYCGR82RVyz
 keFLRs2O25qEpyn1Ov5ruMtI55z7nFj1aALpqvsd49QUI9laVne1d0LRpvg9ydsgoCU8=
X-Received: by 2002:a05:6000:3110:b0:3cd:6cd:8c2 with SMTP id
 ffacd0b85a97d-3d1df72effemr11938228f8f.60.1756910206320; 
 Wed, 03 Sep 2025 07:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWJSPVJRrLoBt79W5TaxdwacgTVsNRa61E1LSEAGw8R3surhBvLcuTTLtCJ85HSaKrACL6rQ==
X-Received: by 2002:a05:6000:3110:b0:3cd:6cd:8c2 with SMTP id
 ffacd0b85a97d-3d1df72effemr11938200f8f.60.1756910205899; 
 Wed, 03 Sep 2025 07:36:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31?
 (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de.
 [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf274dde69sm23775821f8f.14.2025.09.03.07.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 07:36:45 -0700 (PDT)
Message-ID: <83bbb239-f879-4cb3-8c07-2417ad792f93@redhat.com>
Date: Wed, 3 Sep 2025 16:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memory: Fix addr/len for flatview_access_allowed()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250903142932.1038765-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903142932.1038765-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.09.25 16:29, Peter Xu wrote:
> flatview_access_allowed() should pass in the address offset of the memory
> region, rather than the global address space. Shouldn't be a major issue
> yet, since the addr is only used in an error log.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb



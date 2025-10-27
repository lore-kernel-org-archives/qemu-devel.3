Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C73CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGKS-0001ZM-DR; Mon, 27 Oct 2025 02:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDGKQ-0001ZB-1C
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDGKO-0003bU-G7
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761545014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I2fKZPFJfIsaw6O7W8sAi+D/a3pQf/fMFHRbEOokbTQ=;
 b=YEMclKlbo7XAuQNHVLL7t6phGZ3rMjjXzFTMWSJsqwTxd5AESbZkSvuLqGLcv+BZkIy6LZ
 /mBTQoKOHNd0nnWtW7kS0qD9DBrYTFIB+7Eva2/r5wrPKJUgwoQkDM1amGJC967Go4nDhF
 e9k5AwUyB+l7jgN8tbzcEiYrf+GsPL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-5QZf3gWbN7qQCl5AN_1o-g-1; Mon, 27 Oct 2025 02:03:33 -0400
X-MC-Unique: 5QZf3gWbN7qQCl5AN_1o-g-1
X-Mimecast-MFC-AGG-ID: 5QZf3gWbN7qQCl5AN_1o-g_1761545012
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso23696655e9.0
 for <qemu-devel@nongnu.org>; Sun, 26 Oct 2025 23:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545012; x=1762149812;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2fKZPFJfIsaw6O7W8sAi+D/a3pQf/fMFHRbEOokbTQ=;
 b=XbrUNPAifrAlDwpE6Ie/Nr1zKYXrhnFyuDgUcgDksOWWKRaowOO9iL6BDo4gq6UWDG
 8O9LhDeyU2iWw8u85wD0NVjx/rKzIdGO/XwkjcvqzZfShdSMmIqEuHac8yfAIklU5M2O
 jSoUQ1dyoWUuDw3v+HmLxlK+Tgt1xIUoObn1MCMCdFrhISU8RolQ3KkSCqNAWwj6ShaA
 2cwQk8DhuPYrlyKBJEysJJfnF7hjoVxbIVOkez2ECw1a2JfNtLsMvgv+3FnXNRDJCOUy
 r7LDzO1MF3GSW68IdvHCqqp1EDDp80PYA2WuKJMjutJlCmqapu8klSMZIcHiuV+JmDGb
 L3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOhOwIGCJXDs7DisqiKRdULcNLt8owYsIWkMpkijgCdMzXSyLR32SBTiXccAAiWZy3DLs40S+rbyIQ@nongnu.org
X-Gm-Message-State: AOJu0YwSuik4PEeHMV+vw0C+w8YnvL3BizWs8B3CnTHQi6GTcU60oqhv
 umzFe8UB/b+m87h0kKa5EBrwrjy77hvsvdpUuV3sX4h4sbfxbCQ2+c7QrCTd6PysfU7zFvpE1p3
 qWTBM1cE13e7sMEso7JdGfq8ZApAMW/j/d2oOe6PARGY2MEPgr2rm8KsVVaH56/yV
X-Gm-Gg: ASbGncvNcxN4hYVEUQc6vpskN4U+EFouaJfUn9ItoutfGn3Fdb7PZ18cxUZbe0kvbjY
 UaMkE17sec1X/iNrr6omIuhOFA0MYaSFqWwV3tlNIawIbhIYGferA1G2GwMNBYu/Bn+ndj+KvEj
 qfl4Uan/r7lI0sobFdtpYLbfVJN2zQzzIrDcHGKHua635irxRQGwEmtmX4ycOmWyFNDaQ24oJ6V
 251ydHGr2m+n8m08nmCUhMWvi87+ettGcUifw68YFPanflpS2X4xHONu7e7gUjOQcaoHOgqzlD+
 ++B+nkb+rGgfQyTHx0z9xNdxaYoJnxLAWWmh530GekoFPVIZf2hfhBN07fd+HeFXMaiWmy/nvV5
 eVV2ahuBjjFKmf4skNesvI4drDs+cYCqvnxys5FU=
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr316388995e9.28.1761545011844; 
 Sun, 26 Oct 2025 23:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzOkuYH35l/DYjV6P7co6kgmO6pZBHRZfVdB6jX2wTwTXeF/nnkBVQCsI2Wk8VsLtvexSmwQ==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr316388775e9.28.1761545011432; 
 Sun, 26 Oct 2025 23:03:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm117517385e9.15.2025.10.26.23.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Oct 2025 23:03:30 -0700 (PDT)
Message-ID: <8fe414c9-6978-4775-859f-738e7f1f56cb@redhat.com>
Date: Mon, 27 Oct 2025 07:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: fix functional tests section
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
References: <20251025165809.930670-1-vsementsov@yandex-team.ru>
 <20251025165809.930670-3-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251025165809.930670-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/10/2025 18.58, Vladimir Sementsov-Ogievskiy wrote:
> Without "S: Maintained", ./scripts/get_maintainer.pl shows "unknown"
> role instead of "maintainer" for "M: " entry, it's confusing. I really
> hope that functional tests are maintained:)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f33f95ceea..27e5e93d2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4408,6 +4408,7 @@ Functional testing framework
>   M: Thomas Huth <thuth@redhat.com>
>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Daniel P. Berrange <berrange@redhat.com>
> +S: Maintained
>   F: docs/devel/testing/functional.rst
>   F: scripts/clean_functional_cache.py
>   F: tests/functional/qemu_test/

Ooops, thanks for catching it!

Reviewed-by: Thomas Huth <thuth@redhat.com>



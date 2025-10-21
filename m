Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2142CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9Gp-0004xi-So; Tue, 21 Oct 2025 06:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB9Gm-0004xR-T8
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB9Gk-0003y2-55
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761041223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xzGBkG8xhE9BkujxepmY3kGFcT8iFjVixGZRBeiBi2A=;
 b=Emv+GkaQ17JnW8ZGlhSoqvvMnYXyJLcDJm7PYl9lmHPpqmAjNsauyOXuao4/iYI/QkisDE
 1QayCLKwi23Nw3gc1C+mXgKbfHmHoXOf6vx93Ez8VXW0NFOEV/Zh4iti/VFbYhmBjoq5Ya
 cXYlxD5jkNoeLH2B2rg/mUuW1U/W2a8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-3JgssZlnO-mPW5KFbHkzsA-1; Tue, 21 Oct 2025 06:07:01 -0400
X-MC-Unique: 3JgssZlnO-mPW5KFbHkzsA-1
X-Mimecast-MFC-AGG-ID: 3JgssZlnO-mPW5KFbHkzsA_1761041220
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47113538d8cso31626315e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761041220; x=1761646020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xzGBkG8xhE9BkujxepmY3kGFcT8iFjVixGZRBeiBi2A=;
 b=SuqUjWLKb2XlWldcPINGJkoTnTRUBdCzjLKHepuBp3RJ4eubqb0CO9W//fShsmQkFQ
 G57n8hwjl3/wEq2SRwSPbYjHTkzepcgDvKwfFJkbSA6/drD3ZOflQIoz9z14/RqrNNFo
 5yHjEe1W8PxwkPtjVdwwd4vaU058cQ4aSCzGVSnlhQy0jkXdRbz68LFiuwcG9EBD38ux
 KdEjHs0IY4RbmAi9dxh0VcEGiwukyagBbf5k2FhJ9nmTZETImnLKP0u/Wuyg5/ESqkGY
 8n4QiqtUAP224YaAm4rcVKD1M2FhNExfOcZIfrpPS0cwxPpN3VGjaD6gB4YA/ykg2zOk
 V/eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr53ohUsalqqW/+O4USJy4+5wrZTKKRfBlnbjd6OyTpMMzvo48edG7rn4E8cM3ebQKt4A6rxnYCWVk@nongnu.org
X-Gm-Message-State: AOJu0YzniIM+2H7vn13U2hcj6bUiAagy7m9kH5+5D6f9OOf6jzwEXqsS
 2kTUX3azwgfJONF/q0nu42sAM5yV0kNZsGGvrEWuvn+Xd1ALtjYrb6hvnPDOEtGq2ctN5WjwWF6
 sqs5YSI7sBMt0OJQR+ANPx8T+3Ce65vRrjg/M7n/S1m1e5cWys8r+Thso
X-Gm-Gg: ASbGncsK2PoX+qytEPc1rKCbDfdsFIE38+gTQNRlARivVUMdlmHdj0NGUZ6RiDqVA5a
 HDJluCevRbfcNQ5k5aZhbV1DxHaLe1HDLaoQSCNTJrG+h6gd9f6P+5q6s0wycXzUPTUq1gyBeEf
 9tTYMkJU+w0/80UmiSX/QFWjbXmDHw8Nbum67w3sw90Rrd0pQYjcjdmAU/vPXvA7FM6n89RyY+Z
 65GqahwYAj84u8n8mff3t1YH6VRGueVX9hZxFF/pUe2WURx1T2D8RWzhyF8ulX4/ALhY6L+lo7Q
 L1YdzWOMM2/Vix5GmbL+jkEa2kRk/zDHvxkp9o3L5LmbWm175Ocx9hM7/q//aNZras5bc0csx5T
 JY6DRs8FtnCN/Dhf2kpqa0aBISio6DzOR+Ejg1Q==
X-Received: by 2002:a05:600c:540d:b0:45c:b53f:ad9 with SMTP id
 5b1f17b1804b1-4711791d215mr129350485e9.33.1761041220265; 
 Tue, 21 Oct 2025 03:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHznTXvqUHIAsdxqNgqGyxuakzkZADHhh75EEEl7/tDT5xHfKbEpMvicdQU80IQIDBImUH4Ow==
X-Received: by 2002:a05:600c:540d:b0:45c:b53f:ad9 with SMTP id
 5b1f17b1804b1-4711791d215mr129350275e9.33.1761041219840; 
 Tue, 21 Oct 2025 03:06:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fdfsm19443347f8f.40.2025.10.21.03.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 03:06:59 -0700 (PDT)
Message-ID: <b806af7e-9ee6-488e-8640-a0735f9d5a79@redhat.com>
Date: Tue, 21 Oct 2025 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: fix vfio-user console example format
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251021093550.766872-2-clopez@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251021093550.766872-2-clopez@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Carlos,

On 10/21/25 11:35, Carlos López wrote:
> The rendering for the console example for vfio-user is displayed
> incorrectly because of a missing indentation, causing the example to be
> shown as regular text. Fix this by adding the required indentation.
> 
> Fixes: c688cc165b32 ("docs: add vfio-user documentation")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>   docs/system/devices/vfio-user.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
> index b6dcaa5615..e31548b3a4 100644
> --- a/docs/system/devices/vfio-user.rst
> +++ b/docs/system/devices/vfio-user.rst
> @@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
>   
>   .. code-block:: console
>   
> --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
> +  -device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
>   
>   See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
>   information.

John sent a similar fix [1]. It's in the vfio-next branch and
should soon be merged.

Thanks,

C.

[1] https://lore.kernel.org//qemu-devel/20251009140206.386249-1-john.levon@nutanix.com



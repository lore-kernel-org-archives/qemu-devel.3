Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF13CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwZO-0007mh-E2; Thu, 21 May 2026 02:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwZN-0007mZ-AS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:07:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwZL-0007sk-NK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:07:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso44283925e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779343662; x=1779948462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mhd06E+ieQSiUE0O5T/jy8luCwSbUmO/KYwFcez+dWs=;
 b=gLc8h7zPXixBmtACGOhGu4HbbX9xbvopUZzUBldNHLuBcXm7XdkyLzB123kxy96prT
 mpnB88IiZDYlk9Tzhhp+B85BtNp7xdHLDTr4dfhi7qQIg34SnhzolyuwxYK94Tw3rso6
 puHtZ7VBb7pZ+ZtD2MApFsXWppMCKYMPt4oYUmUZxwB9ghXK+KPzyWjWW8vNUUdKZql0
 C2npVKQ7mI0UBLhIz8bUu2L9fvYGQNEzRbBz4IcefgW3CMdxLoSwS6Y9/gR/Dr53sDUk
 n9yvpztVHdgXCpQG+YVUixthWpfyGxJ+VMZbIOOrVOxR+J4TMp/alg//E7+QS7F04uqS
 okTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343662; x=1779948462;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mhd06E+ieQSiUE0O5T/jy8luCwSbUmO/KYwFcez+dWs=;
 b=OVGmHE6M9w/EUDGueXNkDdJyMFCKiaXvP7/TKdmYNyWKcWBD532eURLidb7VsdfBmS
 voRjfGfwMAeestYD4V9CfOjCRbxZmPp2tcIEKVDNIRwl4soeo57kFMyqpS4f9E4bKoGF
 +7PXMNQZMAeyeIUfIfbn3wXCKurl6ZlowXYYUFyIa1C6RDuAEV7iOo5rJUvkD8j22ZL5
 /FAkeeiZ0AyylQoEXl1vaIIyY1s1vuJNC9fxfz+voY/VLLf+NTwM/COyf/c8bJU5FTQD
 CY2g4lNvtifqwAOBUusujzS3n1XtxL0T2sgAvea1v14ON2FQ+GIFP+mQQ+YytUhGTuma
 kAUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cbv8tyl18Pvb6t7TNYvsTeTk4NuBFnsr3/9LBqNrJspseE40KRn98QtWcQHhUZcPzcxMtImgYALpJ@nongnu.org
X-Gm-Message-State: AOJu0YyCKTYcsGWwkFN8XUp4dRvfZue5UHRt1PFZwXZfYms0Y8kZ5hyZ
 v4aZ3ZX+bheRH+mFSWR5wzuLpprP+k0ThP3ua7oIckLCBTF/lpf45hJMvZSI5hKXTqlzW8sB49o
 key2OAOw=
X-Gm-Gg: Acq92OG3jLS6jgEg4QS/7qCx5ZSr6EY90tTSuYbNgdqmcl/2OUZBSvsLcUDQG5mzdjx
 Ur3qc39SiFGUE0JcdjT3sBnVW3VtQj1tEf1FuwdfDT8h1zDdsTtPV2LljlmldeslMsacYZVpVwr
 9RsrPslg9xMRlNiwubYMk9kOAzuZdNuuHlkmcPXrb5MmjHSN/zAIRZVR+x4KW7ckEWloBEOCaEX
 MMSeEs5i36dfoFvBR6JKuGtBi6VrdgPAI1LueknXDZPXTkX5EVP7yo3cGhj46fSPhGOXqpyX6Vh
 joMA/A/M0l+dc8mPX+Rar3Dee09puYPfreM8hEgLqjxMpU/936j9MTOAeJfTe7yCAfzoGb6FFLx
 NgHDPAiKy5bXeajIaOJf7CfwqK3199K0QFNGpd6lU7z/KDgTDpEfFZ4Y/y3u69+3qScQxwrygd+
 ot7K/TUEzbw3arzUx7Pnh0VttjXHh3VtKOJZ23qvjjGlPsSnzH3nunDE8D1O3Je6MVWClxJZVsX
 nJP
X-Received: by 2002:a05:600c:a108:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-49036048144mr13988385e9.5.1779343661928; 
 Wed, 20 May 2026 23:07:41 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c2297esm8153945e9.7.2026.05.20.23.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:07:41 -0700 (PDT)
Message-ID: <14ae347f-b7b8-4493-9488-f12a6641b640@linaro.org>
Date: Thu, 21 May 2026 08:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/40] hw: guard BusClass::print_dev with CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-36-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-36-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/5/26 23:49, Marc-André Lureau wrote:
> The print_dev callback is only used by HMP 'info qtree'. Guard the field
> in BusClass, all implementations, and the caller with CONFIG_HMP.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/qdev.h      |  2 ++
>   hw/char/virtio-serial-bus.c |  6 ++++++
>   hw/core/sysbus.c            |  6 ++++++
>   hw/misc/auxbus.c            | 16 +++++++++++-----
>   hw/pci/pci-hmp-cmds.c       |  2 ++
>   hw/pci/pci.c                |  2 ++
>   hw/usb/bus.c                |  6 ++++++
>   hw/xen/xen-bus.c            |  4 ++++
>   system/qdev-monitor.c       |  2 ++
>   9 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index e1476223411..22dd143acf0 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -322,8 +322,10 @@ DECLARE_OBJ_CHECKERS(BusState, BusClass,
>   struct BusClass {
>       ObjectClass parent_class;
>   
> +#ifdef CONFIG_HMP
>       /* FIXME first arg should be BusState */
>       void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);

We should fill a GString instead, avoiding the need of #ifdef'ry in hw/.

> +#endif
>       /*
>        * Return a newly allocated string containing the path of the
>        * device on this bus.



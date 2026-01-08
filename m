Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1E2CF6AB9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmbu-0004mz-FJ; Thu, 08 Jan 2026 04:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmbt-0004mj-1B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:47:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmbr-0002HH-K7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iubvZWe3vTAhSYO9BRUbW857U8xtndQNBimfOMg+aZs=;
 b=BEp5jpBkkXa8wcNa5A5POmOrkF183Tkye78TTchL0Kh1ev02b+1eYZFrXWU7xXxTa7Gnha
 nbUlUphXHFL9FqMOMKoA9XK9j8ZNLzZdV1ZbOb2uy8Vc74KsWMK7/r+WErfIkuZ1EIfR1g
 s4z3c6uTFZQawQNh+1UMToHCqQoMEkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-biS_90UoOr2bYyFt586cqA-1; Thu, 08 Jan 2026 04:47:12 -0500
X-MC-Unique: biS_90UoOr2bYyFt586cqA-1
X-Mimecast-MFC-AGG-ID: biS_90UoOr2bYyFt586cqA_1767865631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47775585257so20497225e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865631; x=1768470431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iubvZWe3vTAhSYO9BRUbW857U8xtndQNBimfOMg+aZs=;
 b=Cu+evYJACoBuqWzKKJ4pmX0vnKHoUNLno/0bYVc86EtXCMWk0pufCaeZontERp4W/0
 XCG049HXZZaMoT4XWXNWullhplaVNtPuuPXO+1GOQZCvkgLUdNZoDM+rc1/vInhwIKna
 GpTPCV171CzEC0PpGY9+Y5FLwU6T/ZE2JZAx2RYJTRl7DxPBz6krB+SSLqOE4DNR+j6f
 MfXuGhV1ILObEhZTIUf6Yr4uQj79a1vDG1VkYZXd7990fN/As7aMcImy1h3DBhdGXNAW
 O2sb202+DtJpGXYs1gcyN+7/JMq/bQ2I4QNcF0haEaNkg41WCF7G+WJ/boQFqqZcMFoZ
 FdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865631; x=1768470431;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iubvZWe3vTAhSYO9BRUbW857U8xtndQNBimfOMg+aZs=;
 b=JfZpLKh0qRlZCQHHd9dyGAI+xsM220+1vmqiRpPdVUCF26Sdh+3ZLzX2u3NLvju017
 0i85yNtcvfai1xJnIpW4SbvSufEAgQFBR/1dd+/fqi34XoGT9SP7HjOomN5610msMDK9
 7S+aQ+93Lo2ctTXKhI0/eV6XwN5J2kPZQNT+9ofvhEAMBDnYJE45/LRpq+GozH5sEV8D
 6Iyi4igSd3E5Cym1WWI4kRcT7Sbyge4JzqI2hSEtuNPfPt0HJBTxjPnnjS8bDDOJvgJT
 1O2+quxPoArRLSsCqIciORYDgc9NMn+B1WbFpF9YZE4fw92TDOeU1tUqNislzDHGjNxB
 OHBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyT30/oPbNq3DnFOTtBv65EnXsvCZRJBkwK1z88svA2XZ1mEdN7GoIKvFEweQ214lUjwNcOwgDrUfk@nongnu.org
X-Gm-Message-State: AOJu0Yy8nAvvqDCDvkpbcYUIF93YkneNtBCryzPD7/XvnCdsHaQKuv9n
 flMnfshot9QV80UAKuEWmQ0lA0KjiegSltNDI+t4mpM7wqN/ifZTWNlgCngXbjKiQUvQ/fIRvvR
 ntJyNvnwWRLlfRQICHbvynOFBPXnFmdrzxO3E3x/v32tQrCBL5fD95Eg6
X-Gm-Gg: AY/fxX6q9h7w3AuuyD6t8zsVBl97abv/dBTocFrAtX68OkdtO54n2BORQ89U5cK31e6
 za7rnnuQ6zfqwdkwD59rjhcbY7i3QPxC3uh3KIulgLYr8yyjjrM9YbSc62Sktm56masNt+1k72a
 KqNgFxLavnwbC7GLyxkSoTnHkNhjRUMktm0bhPoEUzjSq8cYh4UgxOXvHpLdC6lyfbUkaVGKgh1
 hRbQJPbNTdnI7UvUHGDg6s2G93wF3w++r36iMtM7DR684KvW48T/wv9FnbuXoUODH9d4hm9I3rM
 nJhIo2Y0S5t6lEBBaP1aQeXHiq25JPZ3jPaLhg29c/msNhCQKFSE4Pl2B/WNWOkitT1onuKzyft
 zuhyXXGo=
X-Received: by 2002:a05:600c:c8a:b0:479:3a88:de5e with SMTP id
 5b1f17b1804b1-47d84b4a079mr61579845e9.37.1767865631009; 
 Thu, 08 Jan 2026 01:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/A1C9bk3KVGPosFfySjiR5LT3QyvIinEiKHJBsGJvmzQx7hoHDri95Z7jHKZd073S9iWhIw==
X-Received: by 2002:a05:600c:c8a:b0:479:3a88:de5e with SMTP id
 5b1f17b1804b1-47d84b4a079mr61579585e9.37.1767865630633; 
 Thu, 08 Jan 2026 01:47:10 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df939sm15109601f8f.21.2026.01.08.01.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:47:10 -0800 (PST)
Message-ID: <d59e4ffe-87e5-42fd-b803-7c0092b062ce@redhat.com>
Date: Thu, 8 Jan 2026 10:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/50] *: Remove __i386__ tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-6-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Remove instances of __i386__, except from tests and imported headers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
...
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2060e561a2..63713f1992 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7449,15 +7449,6 @@ void syscall_init(void)
>                                 ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
>                   (size << TARGET_IOC_SIZESHIFT);
>           }
> -
> -        /* automatic consistency check if same arch */
> -#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
> -    (defined(__x86_64__) && defined(TARGET_X86_64))

This looks like we should keep the x86_64 part?

> -        if (unlikely(ie->target_cmd != ie->host_cmd)) {
> -            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
> -                    ie->name, ie->target_cmd, ie->host_cmd);
> -        }
> -#endif
>           ie++;
>       }
>   }
...
> diff --git a/configure b/configure
> index 2016062492..00e455be57 100755
> --- a/configure
> +++ b/configure
> @@ -377,8 +377,6 @@ fi
>   if test ! -z "$cpu" ; then
>     # command line argument
>     :
> -elif check_define __i386__ ; then
> -  cpu="i386"
>   elif check_define __x86_64__ ; then
>     if check_define __ILP32__ ; then
>       cpu="x32"

Aren't there some more spots in configure that could be removed now?
e.g.:

   i386|i486|i586|i686)
     cpu="i386"
     host_arch=i386
     linux_arch=x86
     CPU_CFLAGS="-m32"
     ;;

Or is this removed in a later patch?

  Thomas



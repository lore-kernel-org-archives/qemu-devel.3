Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD454C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 14:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmX9-0000B1-Ub; Fri, 18 Jul 2025 10:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ucmU4-0006SX-Vh
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ucmU2-0007fm-Eq
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752850483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1l0rtXolnmjnv9qWoWnZxZh+VEYJsaQ0oRptvRS9q8o=;
 b=h0c3xzUWwGAkJHT14DbHAxz01NMT+BuGDJDHAIGukPU0aNOuuQABfWWvP4J22oM66Ev0aB
 4J2iXQaznu++zI2pd33ahuqeJOLLrrXPqe8bVYePFypN0aMwYQbL/0nCjqG12ErePo0Mj8
 CMijj3ahgnXyytdrxmDg4RIxkCNA8/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-9TxvWnCNM4-9pOpv7EbHXA-1; Fri, 18 Jul 2025 10:54:40 -0400
X-MC-Unique: 9TxvWnCNM4-9pOpv7EbHXA-1
X-Mimecast-MFC-AGG-ID: 9TxvWnCNM4-9pOpv7EbHXA_1752850479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso1150640f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752850479; x=1753455279;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1l0rtXolnmjnv9qWoWnZxZh+VEYJsaQ0oRptvRS9q8o=;
 b=wVIFbGRxtty7iJAunHhL5q2tJjIhy0wA8QFmPlabPuJ1hKMrLfHCUItuyq31AqDe7T
 mHZjYwoNKc97+YLUmS6irA9psxLwSW8BC0ndfzrPO37CYVyAGyCbdUN2IaRgfjDVQbn8
 GpZBt8WCJ05AZHYLPvG3wUfdPxwUYvyKU87e8LegR/ENx+JY3DVz8ZgYsEqMPCFI2M5F
 9GHkMwtaIZuoBfkrU2eUKLQtyIR9S8owheaUAdEqH8M5K2II3aaMrTNqKAehRfcIjlQL
 iBgWctZ7FkqQLprDhgKyq9a8JjzymQZ+1yVn5dC8LsesQV7AIZNIJPsXbbcPPvnqvWKM
 A32A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4g5D3Xkk/kRjKoOS8QsgtGnvrVmFQzG0vNyNBD4I7QRFT9TY+oVA4WNxPq2+PASAUtLBsLNfL11Fd@nongnu.org
X-Gm-Message-State: AOJu0YxtumCSvbIz1ZLC8I9mo1eLc3jD9r5VaHAgO16gEg04RkcbKo52
 juNdeALuCaiuPax9kPYmSmxl859GiuTaYDRgt6VcA4TFJA17gbZfV1bxpjQPrVGOgUzi/aHdjBF
 ZobLmDNc/qydEfnO1ysNEefv5VCOVNgIZ1Xlo90WuxrKD+ScCLE3dLCPI
X-Gm-Gg: ASbGncsapWmltxOIJY9HEPSD6q7XsWWyQH8ApoXnL9/IjAa2ygsTbCSAnR1ynhNq2fs
 HBosMfaIgAZEfV7JKYUfbpbPCIlzXHZlfPYi9c5I7CJXnK6iyPmOvqr6lg9kAa13kokTZNcmlsl
 Rcq3jsn7Ff7pvN5+H4oziCNJGHgbCwi66ehXeU/n7BOpxn5uyGKWPQIME87FA3yAmURRzncE7Lm
 kcthlzlvzHztFvLmZf+agGbv8NPHET3aWEnAmMlrxMcGN6+A63HqjpcP7jSrPQM9DowML2wF/dE
 KRz+xyFyxsdFCUp7xS+/5IdR06PHKG3JyOg7jPD27t8p63DBZXlXM5iEPT9qvpOg5Ic9M4+ko9g
 pocg=
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3b61b2188bdmr2552441f8f.38.1752850478914; 
 Fri, 18 Jul 2025 07:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExJpx1ZL10at6977n1k+HbG0EoT51nvEsOAl0oBlRKvu2l8rr+2bsAnTxB53jxH8H/bFlzYg==
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3b61b2188bdmr2552419f8f.38.1752850478480; 
 Fri, 18 Jul 2025 07:54:38 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-097.pools.arcor-ip.net.
 [47.64.114.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e818525sm80781015e9.16.2025.07.18.07.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 07:54:38 -0700 (PDT)
Message-ID: <b30199ba-4c3e-4764-9b0a-fbbb8b73ce89@redhat.com>
Date: Fri, 18 Jul 2025 16:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/passt: Fix build failure due to missing GIO dependency
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250718133110.1510978-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250718133110.1510978-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 18/07/2025 15.31, Laurent Vivier wrote:
> The passt networking backend uses functions from the GIO library,
> such as g_subprocess_launcher_new(), to manage its daemon process.
> So, building with passt enabled requires GIO to be available.
> 
> If we enable passt and disable gio the build fails during linkage with
> undefined reference errors:
> 
>    /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>    net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
>    /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
>    /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
>    /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
>    /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
>    /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
>    /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
>    /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
>    /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>    net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'
> 
> Fix this by adding an explicit weson dependency on GIO for the passt
> option.
> The existing dependency on linux is kept because passt is only available
> on this OS.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index c2bc3eeedce9..5842dd026a6f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1287,6 +1287,7 @@ endif
>   
>   enable_passt = get_option('passt') \
>     .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
> +  .require(gio.found(), error_message: 'passt requires gio') \
>     .allowed()
>   
>   vde = not_found

Reviewed-by: Thomas Huth <thuth@redhat.com>



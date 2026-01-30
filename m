Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913EED49C73
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljtY-0004Hw-HQ; Fri, 30 Jan 2026 03:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljtO-0004Fq-7O
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljtL-0004cH-Pb
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769761809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbP+V9F/MWNOJll6xnY9ugnOCA14/hygh407r71BCEo=;
 b=OwTCZ7E6DwGLy/D58ZMhLo3c+o3nANNV8waLteE5is21yvRvZCNGHhkiLhTxFbxuAWQU5L
 RIXghOmgzIxSpgLPzgiXVCbmko+iyNV83FkjQtq6bXCyZ+0m55jXgMUOErOdWhUo0X4xTy
 qf5UJhS2h3uNzEOO1kHSyb/d7vx7jxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-ruwv71fbMzyJUQgDTq3knQ-1; Fri, 30 Jan 2026 03:30:07 -0500
X-MC-Unique: ruwv71fbMzyJUQgDTq3knQ-1
X-Mimecast-MFC-AGG-ID: ruwv71fbMzyJUQgDTq3knQ_1769761807
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edfdc6c1aso15118215e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769761806; x=1770366606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbP+V9F/MWNOJll6xnY9ugnOCA14/hygh407r71BCEo=;
 b=IWwooW3JTZZy/oMdbraAhqnTKXTeLLBMkKnifjQlTK5tXTa/yMS+LyMjc4XZZRT6Kh
 wlQAriuzOuv58/EIR0rhVEE7GWAZgjk6BOJA/4lEEbVH6Ax0S6KQ6UK5Ulu5cfGFePd0
 rVX673aUPiA3vU7Y2OWruomSkbDRpm37bwpUJU/d3HlhlSy55VBclFNSbzgMqyIvOqFJ
 yLT6vSTR5iHKIb0z1g0RIzk0reomG5ghlwK4/e44b7A/nVHq7weV9xYr40toaKw2g/+I
 bHticSem9FppGkvALaktmBR+ckQ59jW0uy/hgv1refYBfAJOdm7S8RNa0vpWlZTA+h9i
 2wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769761806; x=1770366606;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vbP+V9F/MWNOJll6xnY9ugnOCA14/hygh407r71BCEo=;
 b=kCVbkCFVodHdkIrlqDa7WxwTvIWkfLlU+DcIEC0OKzppbRXP3fyH3kZG0ojKJqp0+U
 tSpIe4po4o7+Z/qohN/Hm/9nwiPNHLtWiKt+ZHfLfU4mTBBY101jvr5si9eulgvlbl3+
 s8JzJemMjDnrlYTAy3MvKXQDLoHuAYdXy9P74EgOsBhkzjsnRG19hyT95GI5pZrTZuhG
 gxBKd8o2uuyHIeTKpLRLBawikn92Fj9p6iJf+iUC12VaR6wezYlgEXVH0LQsJXx9cyzd
 vFIv9bn2mUs5VrAE8pOik7DQMr54gQxtpPg/GlWNgY7CghUxaxq/hoW3S6SAXjMrwxs/
 v4vA==
X-Gm-Message-State: AOJu0YxNcKUj+/ybKRJIIPRLGAVDdG0h4VQtrIiI0ufiYkllTMEyfNQ5
 y9kQGVcu/ExbfynH3zDjdGGEiJ/weit7F5W8E3C6k6PTYgm6yHAuPOSukFbfafOupdFI/hWjnF9
 UzlPPL1y/wYv2Q4Jl4HkNG5rhvXvY0j1nnQZ6P+p2HIvEeDnr1COcHGn6
X-Gm-Gg: AZuq6aIZYlP9zDWHyoHfYbw3aTUj9P+NOjj5pAo5k7ktiQsFKK6r/8vW9/zZo3HiG5V
 w8Tz7pJ6BdKccMtmkBwJ9Ao4i2z532OFmUOKJb4oSNpneMmoOnuK75JBDldafcEyxjLlU/3oIDg
 kIIHTA834gkfpgYPm52nCNaiFa3kZqSe3/91WFchAVo0q4VR9B9cpg5PZAkvbOGMt+Cj1tsjDYx
 6FSeMdFwHfMff2aYqYYAbUc8JlW090dh52x3AySE4VffpTaf4sv8G618DLO9zFttujRiFyZGnAW
 H79u0bbkOh34YbVQ4RsKpvSZ0walwIdtg7r6B07AOjjP37YO+iGUM38Kjkd/jHf1AK1LVDB0TlN
 CQ0P6jdIT+Z1ZVuXGM5QQpHpK34550mlbXzB9MjWd8SvY8cswYKoO1u+P+UPEnckh5a4/kscmfw
 vdW0+x6EWbwfZ6Vw==
X-Received: by 2002:a05:600c:4591:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-482db45fc65mr21778645e9.9.1769761806155; 
 Fri, 30 Jan 2026 00:30:06 -0800 (PST)
X-Received: by 2002:a05:600c:4591:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-482db45fc65mr21778265e9.9.1769761805741; 
 Fri, 30 Jan 2026 00:30:05 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435e1048a54sm19381766f8f.0.2026.01.30.00.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 00:30:04 -0800 (PST)
Message-ID: <f686d34f-99c4-43bc-9da2-56ab1eb72bc6@redhat.com>
Date: Fri, 30 Jan 2026 09:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4 qemu] Avoid static definition of copy_file_range on
 GNU/Hurd
To: Damien Zammit <damien@zamaudio.com>, bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-5-damien@zamaudio.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260130031954.1661880-5-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/30/26 04:20, Damien Zammit wrote:
> glibc already has this as non-static on __GNU__ systems.
> Also, add the missing sys/ioctl.h header for the same platform.

Please just move the inclusion of sys/ioctl.h outside all #ifdefs, i.e.

...
#include <sys/ioctl.h>

#if defined(__APPLE__) && (__MACH__)
#if defined(HAVE_HOST_BLOCK_DEVICE)
#include <paths.h>
#include <sys/param.h>
...

and remove all the #includes for it after the first.

Thanks,

Paolo

> Signed-off-by: Damien Zammit <damien@zamaudio.com>
> ---
>   block/file-posix.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 6265d2e248..5e4fdba49b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -116,6 +116,10 @@
>   #include <sys/ioctl.h>
>   #endif
>   
> +#ifdef __GNU__
> +#include <sys/ioctl.h>
> +#endif
> +
>   /* OS X does not have O_DSYNC */
>   #ifndef O_DSYNC
>   #ifdef O_SYNC
> @@ -2113,7 +2117,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>   }
>   
>   #ifndef HAVE_COPY_FILE_RANGE
> -#ifndef EMSCRIPTEN
> +#if !defined(EMSCRIPTEN) && !defined(__GNU__)
>   static
>   #endif
>   ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86546D31A26
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwQ5-0003Ve-PG; Wed, 14 Jan 2026 03:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwQ4-0003Uw-Tc
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwQ2-0001Tp-Oo
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768379997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8kbfMex7/QOi3NosnbNEngwjDksl4ME1KUGOLTf9fZQ=;
 b=SXaJCTVjMbhpTAQPNBZh3CjUs/O8Eh7aeu66QYmGvGIf3WfEPYJ55QZmysWtxHJ3brzJTf
 JdIdUtXwgAwTQZYQ/M/+s13u+FRDFv9DUXdtihTwlVif02HSvaJsgN+8u/QzeYhgCpDLTP
 pF7cGpjUQ51vq75KHWeQNH0dNfiPqB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aCDIDJsoOqKQFEfqOE8vlA-1; Wed, 14 Jan 2026 03:39:56 -0500
X-MC-Unique: aCDIDJsoOqKQFEfqOE8vlA-1
X-Mimecast-MFC-AGG-ID: aCDIDJsoOqKQFEfqOE8vlA_1768379995
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5bd981c8so57315735e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768379995; x=1768984795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8kbfMex7/QOi3NosnbNEngwjDksl4ME1KUGOLTf9fZQ=;
 b=ZLWcGHukK0vSauhhEjUAi7lilqWE9a6DxCNUwv/JJZvKScm+sN38WzNf/LNlQCKx/F
 32YGpYZU2GVYY1mJTJSmzNhKz9zKPvAT2qtAjw7isHeF9f/vxbxp9E2SRrAHJV7wNK1M
 1UQ7XP+S8N4LoJGjdRERJfAUp1x1W7sqKulduwlLFyd3/H6S+kgfuhI9x94H5Osd+B3V
 Da3Jgvx0boMPEjzMb6JLeH+n8Ku9wXO52JZhGp+G4UfaCA3nQ1vTSjv+fvcfqu3xB7rS
 4CuQ6pFyjkQBAgKnYI+eLo2Wta9INzRFOeRBwbS+T963ptFsHTMD7b23zTDXtb3tH7U0
 6LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379995; x=1768984795;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kbfMex7/QOi3NosnbNEngwjDksl4ME1KUGOLTf9fZQ=;
 b=TvJVIhcAaXFaLNRXQRKBdzC3ugXcPQSRar5p3+i4woYWauNiEr1e9RNaMJA1VR4LUS
 fCVClsuehgUuYK+qdlmGqM8y6hEytKKS6YQxug1xXE0mOuKHWGJhkl7xu2AZ/A9588NS
 C3M5KVOxOw4X7InEussIbcObcMUPZT1IMruLRy+0m/2zh0AqLE7enLc0+GiZAwM5AHoA
 ULUCYV18yFpY80CbJs4pROMYDy1OxezW26NamH4TiYkYfZpbxLitOPFmVR3LIUUttiz6
 1z+k73ieb1w0NbzQpb6+o0dgTep/GLJazIc9MNOqml4VpuwVi7Grk31PayFxZ+FKdiZM
 FOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzzJww8DPlYLAUEZ/PdWDfto3Zv/g9I3Di5acIBRalhnx3TYhxDKv8k9dzpxzpBF60hLdza7l5GA1P@nongnu.org
X-Gm-Message-State: AOJu0Yz5mTY2ecA+NLAYq7+t091qBVFZ3g6eQ71jwx6iLaux8yDaxC5v
 tXmE5tbu6eyP8fRomu4EYK7zQ9elBAow4AYse/D38Z11Jhbkkc2/ifL4m9WPB1sROrZMe2HrXTd
 QOFiXBSHeiecVarbGIHdywZdwjhaqrUZkf8Te7PdrrcXWlG9vtMyEpku/
X-Gm-Gg: AY/fxX7ow/2gNTEwBRWFkURlCnbp8xWtO9vSkOSwJn9Tk2KKxSqVYaiZ/u+1rfB2Xwq
 OJSgRxZRfQqtIQO5RAxwSxQ5jojyCzFdOxmYPeS4UDa6yrJbtfrWvjHEg1O8EZzAXyc0/7uKkfr
 Q/yHB2CY/KO4PYXiNAcfPvGnLnkkyCfWb054TlaWf/s0vXNrNVqRzbZ/7VCFTRoljw/kNK0mVaw
 dD4CH2attYzfncNgrit+UqaBHliOfSJ8dXLZOF+ZtgvdT1nOGChQqvyEhI12sgQlFzECM+Xisaw
 W2fxQ0SwIogi9aQRPbu0T/LDKHALW9TQV3uVGvZB5p3CNVmFPH40bYQLrQ+UBOBmYPKWJ6A8EOm
 dwlyIpRs=
X-Received: by 2002:a05:600c:4713:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47ee33af4camr20358965e9.35.1768379994885; 
 Wed, 14 Jan 2026 00:39:54 -0800 (PST)
X-Received: by 2002:a05:600c:4713:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47ee33af4camr20358695e9.35.1768379994478; 
 Wed, 14 Jan 2026 00:39:54 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dadcfsm47780985f8f.3.2026.01.14.00.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 00:39:53 -0800 (PST)
Message-ID: <7a195ae1-69a5-482b-92be-c9ea7a56f5bb@redhat.com>
Date: Wed, 14 Jan 2026 09:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-stable@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260113203924.81560-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260113203924.81560-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 13/01/2026 21.39, Philippe Mathieu-Daudé wrote:
> Fix typo to avoid the following build failure:
> 
>    target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>    target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no member named 'vcpu_dirty'
>      988 |     qcpu->vcpu_dirty = true;
>          |         ^~
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Untested.
> ---
>   target/i386/nvmm/nvmm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index b9bd9ed985a..f808828d492 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -985,7 +985,7 @@ nvmm_init_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    qcpu->vcpu_dirty = true;
> +    cpu->vcpu_dirty = true;
>       cpu->accel = qcpu;
>   
>       return 0;

Thanks, this fixes the issue:

Tested-by: Thomas Huth <thuth@redhat.com>



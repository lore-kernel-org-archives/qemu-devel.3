Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A672EC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 20:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6oB-00047O-Kx; Sat, 04 Jul 2026 16:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6oA-00047G-M4
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 16:17:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6o9-0007rJ-4V
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 16:17:50 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c12758e75afso203148166b.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783196267; x=1783801067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6WRHxb3alsqngxScmUMRgIEvTsIFjqIte/j0dNVYqM0=;
 b=f1mhAAqz46bMxAsqPtNzoE5Jp2zrcjNalv8Le0yxegz91N2+XHm2DkkuP6V02bMYpv
 ewP4oEQTdY0KOd5eDpM3xcb2IJaGzeiiDpRYptcet+s0crWVNeHEEztjCDY/ZzxMPmB4
 L9Wsl3mXdjJR5Zjp+v4V7oJjlGCQd9mhyqfQZEDYOI6X2hG5Nbm1pOZcbQudzoPe9Dh/
 XH9mVcjc2aJ1rS2fSDqdtovkw6DS6lce+ppVK/1tG8FMFVTZhivgBd5+3n47ZkZ8zNXg
 AmN2gpJO85L/14DzGkz+gXvsRvxZLIV6qNvvb2493H8qxXEK/zSZyv3rGl9EwlWeeEky
 EwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783196267; x=1783801067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6WRHxb3alsqngxScmUMRgIEvTsIFjqIte/j0dNVYqM0=;
 b=FttuuCHge9mS7ef9GghQvO2UBVfHCeUhDgplNsUumWEzVktetd/hKxCF/9AOo31sMt
 17Apj/1KkbGeRg4/AkWOwt6GVERS4Nnwq0CcDTEB0dW3baqqAZhZajcxIO8pVhIaZytl
 jbfZGWfvaGF2PulEa9uvlcO9mbIaQ/RVRRiKv8TyJOUYDK3IBAzh2QmS1icM+kILegyp
 g4AWfZ5ILdK2y2rod77TT2nmkSEfUbP9p12fSP/DjMzXjO3Y2SMXypWpKLY2nFk3XBqH
 DTZcQ157dHBJNdNHYLIPBZUvSDKo7FrdODhzrhbc1cQjhxnB0HnmeA0CXhGXuwaLhXkC
 tmlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O+84BZzt173ZdspeI9eMG1l0XJkURqBHrtMpaS1y+3ejG5PnTxT2Al6DCd/asOg2l0v4q25Nu6PmV@nongnu.org
X-Gm-Message-State: AOJu0YycMBkTUtadJ2tNWYJ0MsKUCfusAPVXCdz9ECvCQCpodrhXFtc6
 M2OEa8mF4fHoTHQ5OJlKXtVwlgcVL/fEbKFJOLC/B3mcf7A8cVdB2Dh5+S6E206TF34=
X-Gm-Gg: AfdE7ckc+fAIB34DWcLhUFiCcJaXJBUbmcnOTYXbWkFKCRDv6Yhdwq8dqwYRJvtS+7A
 HSDOJ7c8jgHH/JQk5WblEONapM4InsANPpi0HRpSk4A8rnPieAs+cKBx4Aji4pBnlgHZ3+pnEhg
 2dZ8Tfifh/c+zQmgH1DpAhBFS5845ufMrOgJ2v2KXcOXTzFV1sndboDDxEZUEjJg0xRci8ZlQwa
 hTKwzKZjuWz5F3zKa7jQnAOEBK99NGoAxCB2runQsVHz3dEZhh1rRvHyz0jcTbMz4FlhfNBSVCt
 O8O8Sp6OFVBSDm+gQdKtiXFrkLSPEEUhS6ggJlwxlcAPtU2bxTFYB3V8xjBEq6pWVIiFJCJvWut
 XPW2mITc/ozluGlapDt6beEJqnNH92qApeebL/gnEFrASa3Ii6F6vwYASouTzXhVBMP3//X897K
 NMQ33rMIfjLvljhZS7ygEX1kg4kXIU/BHg+E0HtBPABu2qFWoPYVW058M=
X-Received: by 2002:a17:907:3e1f:b0:c12:9eb4:48bd with SMTP id
 a640c23a62f3a-c12e6c7f62dmr126144666b.50.1783196266806; 
 Sat, 04 Jul 2026 13:17:46 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b6091ba1sm453006466b.17.2026.07.04.13.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 13:17:45 -0700 (PDT)
Message-ID: <e7de5b45-7c7e-4894-983d-c33310dd2a7b@linaro.org>
Date: Sat, 4 Jul 2026 13:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/hppa: Work-around for Fast TLB insert
 instruction on HP-UX 9
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260703193224.33135-1-deller@kernel.org>
 <20260703193224.33135-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703193224.33135-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 7/3/26 12:32, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
> 0x05385400), which seem to be wrongly encoded fast TLB instructions, but
> similiar to the non-fast instructions idtlba r17,(r9) and
> idtlbp r24,(r9).
> 
> It's not clear, if those undocumented instructions were used by mistake,
> or intentionally. Either way, this patch allows qemu to handle those
> instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
> still crashes due to other reasons afterwards).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/insns.decode | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 13c6a55bf2..f700fe472e 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -164,6 +164,8 @@ ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
>   
>   # pcxl and pcxl2 Fast TLB Insert instructions
>   ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
> +# workaround for non-standard encoding as used in HP-UX 9
> +ixtlbxf         000001 01001 r:5 01 0 data:1 01000 addr:1 0 00000
>   
>   # pa2.0 tlb insert idtlbt and iitlbt instructions
>   ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt

It's either this or ignore the field entirely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


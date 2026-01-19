Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B56AD29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqFv-00049z-RA; Mon, 19 Jan 2026 09:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vhqFq-00047d-KB
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vhqFn-0004Ev-EI
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768832954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1hgk05gJ06njDBt18serQQ1IMhEMivPtWRpz68eZz5g=;
 b=heX/dEoox3TdXjeTyO9JKsKeSI3NhYdqbGt8+356atxotFCzG2fYXNyD1KzW5/Scjmia7e
 dqLU8bd7uo2mz+Uv6H4m1MeMKxfYtHwkzSfA3ghGzCfaSIQaSHahNxxYY78plyCYqYrffZ
 uf97htgZaoEqxq3tNVI/DtF1wQWy7uM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-gqihNdDmPM-qXly14fSdDw-1; Mon, 19 Jan 2026 09:29:13 -0500
X-MC-Unique: gqihNdDmPM-qXly14fSdDw-1
X-Mimecast-MFC-AGG-ID: gqihNdDmPM-qXly14fSdDw_1768832952
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801da6f5c9so37724725e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768832952; x=1769437752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1hgk05gJ06njDBt18serQQ1IMhEMivPtWRpz68eZz5g=;
 b=U6GndeB6rGuRAvlM0xI2H3ey6KLCWlWeUG6fPYq1i7koKHokXuM2f8JwUhEsehinmk
 mjEkbKyUf8aum7DUtHc9ApN/Jz1yQ37Le/jBAeH6j2vNRYLRNXlhs5KretXfXMhjEB47
 rmgL1nOX1loZRmrkPD/ITctsijhFjR1AgFngcTwbiaXW1oSzjwx5UEYBwAmeUhJ0m48W
 9U802wvdrNDBymUD4UcAKe0DcBaoUVW9LmCNDvYAefv+GZOBfqbV1WIzFPVHPPCooo2q
 WRIRgWuxNy6Jr6ExPd5DpAAoe577VjQ6DgArsez1Bh+R6FEl97EVHrVwdWO9a5hlIDNn
 EWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768832952; x=1769437752;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hgk05gJ06njDBt18serQQ1IMhEMivPtWRpz68eZz5g=;
 b=tjuUOKwLN+BW/+lmGGZGzsSv4O6Kq05uOjoZUBqR8JCeIpBPGUeh4EUOtQiswB2dmD
 KXS2T7+G/QuLQgohM/+vSxR2ZyDtGGKRCdKJze+ylMvXixbN8H4yf57HhJAJGwmSIxjW
 eyYIGObHX3rWM+4l6LXzDsFb8+FOTsaQ9qzpkJNOztiCEiRZ54/v4YxCbvMOo28Jv0QZ
 PkHCHuYGmKhBPMD1TE2qXf5MEKm9xpTqkDyfp9YNOAazjS7udnJZ4+Hk9YWu49tusgBk
 wb7PwZq33aLnsJkkP7Q+na1WtbUPQakgQAZyBh8taY7Gx3WZ8tyfxiRQr/QUqJwKIzI8
 G5vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULKstUzmLwm6Y7VeE/LgnlfSGuCpbZ/8wUrp4gHehpdC1saK6L2vf9Ar+VwChxc754wjrhymvcl8Wu@nongnu.org
X-Gm-Message-State: AOJu0Yy6G7WjbZrpDaG6hb+NsKU/6B5vPcZt5U0iWCGyEp7veMAxoOom
 wEzFmkbOF96GvaWKc+o1r+b+0gDNtd2pnanaD61eVb+q/EmsHkeTdxkCVLjb8y2zq2IZsKVSLgY
 5dO+r++oHoDJuEhDIO+Uge1cUG9gigQG6IOdmVjEd9qFStWtCPxFDRyWk
X-Gm-Gg: AY/fxX6x0g7sST1VId9BoOHgsBIimPKeO+E7xGwzXmnBOIDcDleLOSiNjo7Gm+5AH+j
 pxHuoR/af7d3Un2p384GoAuGcmFB2VBa4kpDxWqECYwEDbLcW74LZDt492ccxUniqaeDmCmj12y
 5Myb4EtCsiTa0IaEF3/75S2XimeOr7ToCedaFawmusSnG1ftD/LuM8/VaxEiHYRr4GEKYwcGLxU
 CzGDMpvrGKiMKGx8TNnXSNHxwgOj7/R99A6IUn8x+ZUSMMyU4febDq/baBQbKje/axVoLzLlulO
 L/9Muy0J4WrkQj36XJ7vaYR74+sWP4z2ZyXPDW695WlW/cBDOjD6/utAHvIc+wCg7iemlNcfRdQ
 XMFj/tXc=
X-Received: by 2002:a05:600c:e41a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48024b8a77bmr120474055e9.31.1768832952115; 
 Mon, 19 Jan 2026 06:29:12 -0800 (PST)
X-Received: by 2002:a05:600c:e41a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48024b8a77bmr120473755e9.31.1768832951741; 
 Mon, 19 Jan 2026 06:29:11 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm80266965e9.16.2026.01.19.06.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:29:11 -0800 (PST)
Message-ID: <711cdf08-7275-4c3f-be6e-ced88f874207@redhat.com>
Date: Mon, 19 Jan 2026 15:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] configure: add ppc target back to container tests
To: Florian Hofhammer <florian.hofhammer@fhofhammer.de>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org
References: <018a86fd-b831-4fd6-b479-9d73e2e95ee0@fhofhammer.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <018a86fd-b831-4fd6-b479-9d73e2e95ee0@fhofhammer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/01/2026 11.25, Florian Hofhammer wrote:
> Commit 2ff8c9a298 removed support for 32-bit PPC hosts from the build
> system. Unfortunately, the patch also removed the 32-bit PPC target for
> containerized tests, which leads to an error when trying to run tests,
> e.g., with "make check-tcg":
> "make[1]: *** No rule to make target 'docker-image-debian-ppc-cross',
> needed by 'build-tcg-tests-ppc-linux-user'.  Stop."
> 
> This patch adds the PPC target back for containerized tests.
> 
> Fixes: 2ff8c9a2984bb20e350ae52152812c5370b02e32
> Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index e69b3e474e..1b0af0cf46 100755
> --- a/configure
> +++ b/configure
> @@ -1451,7 +1451,7 @@ probe_target_compiler() {
>           container_image=debian-all-test-cross
>           container_cross_prefix=mips64-linux-gnuabi64-
>           ;;
> -      ppc64|ppc64le)
> +      ppc|ppc64|ppc64le)
>           container_image=debian-all-test-cross
>           container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
>           ;;

Reviewed-by: Thomas Huth <thuth@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F483C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKUW-0004jg-Cl; Mon, 12 Jan 2026 11:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfKTa-000469-5S
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfKTV-0005oB-4B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768234140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zZI2Yvca91/VVSCRFngnQgUEgbXHwMjUZhCkfJsQmo=;
 b=KO37jtOYr7M0TTJN2gvNhEdfeKCxWQ+2nr5RbIKFDCm8DGf3XVwjfGPS8Y76Btbc1aymk+
 +JEAALjBHhoFPx2cdpBjH/ZETIjsgbvoKw6Uq2F5bYTEma/S2ubVQZB/le8O0aM0tgF0Ys
 cpFX+kXhgAqYg9CrhnxKP5s2L7evvlw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-jQgOgQYwOEKZT3xrmFXh7w-1; Mon, 12 Jan 2026 11:08:58 -0500
X-MC-Unique: jQgOgQYwOEKZT3xrmFXh7w-1
X-Mimecast-MFC-AGG-ID: jQgOgQYwOEKZT3xrmFXh7w_1768234137
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so1295142f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768234137; x=1768838937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6zZI2Yvca91/VVSCRFngnQgUEgbXHwMjUZhCkfJsQmo=;
 b=RhJtmiu6Tb9bTVh2Xt9CL2Ivq0KUqhaBqwJDJGRUEVzXHMbcxGwcS632iRN4b18tUI
 8ZCRfVCwB77orckglmP8ETzU3eKrq3ER0br8i3mbr5c7TqqzUun6b9udQOnQP6U0xdiF
 J6Nn3IMq77ksxczekl2KDfCgvVRr+TGvkk0NK6T9I8o+F8H2KDshCXZ1fabnoZjpPu0f
 Z/4W25Nu9nQ6LslNSThlDFOOwU1Kt5frWVVc03vCMiyMde6wkIajoIuhl/Z9fnfUuS8S
 ZzGuAk2gQh7ZunOvMwGq90zDdJyAOz5r4WSxQqsCkTZkP2LA7I1iCit/t3nINJyiAZUw
 lJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768234137; x=1768838937;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zZI2Yvca91/VVSCRFngnQgUEgbXHwMjUZhCkfJsQmo=;
 b=k5cxHYhaZOvIzqMPEboR0nsUBVrllbf1EHSfOsAnsqg5XbuXW/Cx5VNwn3b3dWcdkw
 nj9gb23A2gpo8MaiCZTat6qlwQVyCrxk17HuUKIm4k/TiyAOfjGUGMdoGy0iFHvZThTl
 eio6jq1qSK0wRCgR2BxhEWdkFt3MmixLyggAHYM7fu444l+6Nc6PMyDXofYbV+2To6xe
 OtFqdihLPm47GB1i1S7GSvsVSj6VqI82KPPe0ovTK/X77qrNxaQ1Evr3dKUEwRouGE/y
 5DQtG/PoGphDr4dO/NNvDV5KYKCgoPb+C05mWK8t2rnhdzHpwNkB7K+GjluVMldq3FKN
 OB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSo7A/iiSgJPLxtphBhn4mPzS1CyfE+A/xHI8ZHNxYPHFi3aixYdlKmZ5QoGyac/MRXgYWaUVWeuf@nongnu.org
X-Gm-Message-State: AOJu0YxmgFUSRflybRFO0i9JXqMwy+a+ZoDOvCkQ0now6iizWHglC5B7
 S9kA3EB+Xvg5Tn6Xl/3XA3XaBBpAyZjejjHacVK/ecj1dzq5s8dUYjD7XXUJwSlWlpSL8IByWK7
 yOKAvsCBciIv30iOADmKkTt5UrXlOXkXrNi0LqOZjgd2gseix4J/OG5Ji
X-Gm-Gg: AY/fxX45XhO2wLLwCLqBFB0wjCX7NRG9XrU9EBEy1ntWcEsYHlQXfji7gy2EB5vdFqh
 ghP+2xsbAJh17NqCbzCUDHjxldIJl8xqGR8iLp9bHDo0tm9iOe8Ff1m63fmxlyDJcrdEWtZKoX3
 YDWyHt1pHEUhvW+iEY9s1mmj8dg6qLeVkYZoFKzrjhgm0Ir6lUBIKRHD8KAFeb8szi2SOJBQPgU
 4yBfNoxNI6PH4+oTKgp1nT/9d2Gzva21kCn8UJordRTWw0NSoriDJrrxXZ121SphVvEBeerzomm
 lFdOjjxOlAthpSnKgWzsPK24+ssI+nxif9/IS5JsszXlJKvfwmLcASb6d7PN4dgcBSlX/seR0+7
 UJu2AE/o=
X-Received: by 2002:a05:600c:3b19:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d84b3b645mr226649425e9.21.1768234137368; 
 Mon, 12 Jan 2026 08:08:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWbxUBTHhn2usIIZF4Jju4HGpJg/a4HqYZUPlRC6Pti7uNYoKmntnM8lw3LalqfhIa5IaEpQ==
X-Received: by 2002:a05:600c:3b19:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d84b3b645mr226648915e9.21.1768234136872; 
 Mon, 12 Jan 2026 08:08:56 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c61sm367325745e9.10.2026.01.12.08.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:08:56 -0800 (PST)
Message-ID: <a24713bf-3399-4e47-824e-03dbe833cf00@redhat.com>
Date: Mon, 12 Jan 2026 17:08:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: use default prefix for Windows compilation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260112160736.1028280-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112160736.1028280-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 12/01/2026 17.07, Paolo Bonzini wrote:
> The update to Python 3.13 causes meson configuration to fail, see e.g.:
> 
>     https://gitlab.com/qemu-project/qemu/-/jobs/12672816538#L397
> 
>     meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path
> 
> This is https://github.com/mesonbuild/meson/issues/14303.  Remove the
> prefix='/qemu' line in configs/meson/windows.txt, since commit d17f305a264
> ("configure: use a platform-neutral prefix", 2020-09-30) says that the
> NSIS installer doesn't care.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/meson/windows.txt | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/meson/windows.txt b/configs/meson/windows.txt
> index 55b192e71b1..9ef0fb3c8f3 100644
> --- a/configs/meson/windows.txt
> +++ b/configs/meson/windows.txt
> @@ -3,7 +3,6 @@
>   
>   [built-in options]
>   bindir = ''
> -prefix = '/qemu'
>   
>   [project options]
>   qemu_suffix = ''

Reviewed-by: Thomas Huth <thuth@redhat.com>



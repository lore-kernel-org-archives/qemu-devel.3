Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C8CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTrq-0005Rg-EC; Mon, 11 May 2026 12:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMTrL-0005QT-A9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMTrI-0003Mu-WA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778518313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MGvUONZjr3WlY0+dVIYnc5fZPaBFqwIrPvu6igsWlVY=;
 b=XmHzH2s6jM/pof33fvAi8EKh/9FmHOtcyrKPbdLqzudbDmF0TFejHM9c6z4Hu9zwybeF/+
 qocF7Rh0rqtNId04AVvG1dExYfkhOIJ75Ybv7hWa7kwhod1vlWvAqL0DFcMycrR23lmS6W
 jxxd+mDGhH25XeXyIwvK9fqnIjomX5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-KmTm9fbuOKCoJhudhn9dDA-1; Mon, 11 May 2026 12:51:51 -0400
X-MC-Unique: KmTm9fbuOKCoJhudhn9dDA-1
X-Mimecast-MFC-AGG-ID: KmTm9fbuOKCoJhudhn9dDA_1778518310
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-449b2a183d3so3350156f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778518310; x=1779123110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MGvUONZjr3WlY0+dVIYnc5fZPaBFqwIrPvu6igsWlVY=;
 b=hkxZj1A3unuuuUuW4hGD0ItdrhwzHlnlKoGzVBxVf0w7swCzxyprKuJZWQ44I7nZ5i
 XjBS9O4jwCYLQmzxmImn0AuZrluS2tBPX20gQBdKg+OhJBv/gmLnK0xtXQDJpVBUOhbW
 o5O3JFdY1RSahAwM/fMzKuRmU35/THg+vmtxLP+SHk1EeCU6RNOoiXM0cBFS+B9Mc71z
 LyjxwjKK/G7n3qgQPDX5JYsDFSuYrzIuWwxgUIYNDSJjERpsITGGEu5+aJNtL80l14s/
 fR5gepgFhE8cxk2Q/sgtEdBQi3GctwgykLwJ59exkB6sUL9WVEig5XrhQvdbAIgC8iGI
 AlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778518310; x=1779123110;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGvUONZjr3WlY0+dVIYnc5fZPaBFqwIrPvu6igsWlVY=;
 b=KkzijKc4ib7Hw033uZRb0dUli+CoE06yWAriXSe4MohYYlSzXoupGZKqgMwQihV5B7
 wquyPB8PCEvRbOkrCHluRHOptL9g1ou3D8FCGeXmlMKDnR2hkQG9gCb75gd8n7Fhhqb5
 API1Jxn8OpsgNv/WMSGbW9g3l4ggAZJWfREGShFu9E9f0kGCD9LZzdf95ofgKi9j1dnC
 Jwfmr2K7dPDPwSbbTWm6ZQ2YzPHRiqwK2o8gXIhkl7jdwlmxSgee0SfJAFv6YEdedNss
 hx0HBSU/Pv1MB1IH/p0Cmy7y4rL2himec1ACn+qvFrxLp9U9oSrt2WXvr6QMO8k/zgKD
 MOhw==
X-Gm-Message-State: AOJu0YwZ1kxnn/a+288YeEn7U1q3l35TK6FAiEenG+gmuiEyYAP5sSOg
 w7MaEsFH4MbaRxlg7s6mI1HhA8B6KJyYKv0ccOXSayr3spH8JGTnKEz0WwzGp8KTeCc5UQwjItg
 jD8719KPdiWgUF07VzYf/OUAnrgKr9UnuPpYIhl2YMKJNn07y9ulTwO+P
X-Gm-Gg: Acq92OES6tFFQ7a9ukSem6Rjdr5k/V6U4PWxlmsl9yrJwNyMFBalbmlHtHSavdnO+5M
 T2x6DWCHuXK8xJn0dndgbGTluGcx+iPhHVUSp79W5wDFuUJiIgQyCbnT0PI7J5/yNreR0NQsxUd
 x7ILKHpyAcqars44+nk6ckVb8Ap/SkaMkvpDwAvxwh3tTFEilZEiI/my8C87DimLqNH5Jdp7/BF
 cUeRUjBwnJ0J/QuUqlCU5Wsg1cw76AfLterrqfY2ouO0J2u2PU4JKSWtoN/MKh+suk0V7hvs+Cl
 33nZU4YQubOXpZz6RkIWGIGzTOLsMguCRf+3PFBnG2at5PAdFt1siRBFpZeQGoF9EDRG9e4Adfh
 03+qqQxgpYYh35HQGoJIKRKftZVdIkWL+74eFNaF0BvrLxLFGcZ52wXntc+wppTMyzQVPyKc=
X-Received: by 2002:a5d:63d2:0:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45ac3f4246amr318436f8f.29.1778518310062; 
 Mon, 11 May 2026 09:51:50 -0700 (PDT)
X-Received: by 2002:a5d:63d2:0:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45ac3f4246amr318411f8f.29.1778518309594; 
 Mon, 11 May 2026 09:51:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491304387sm25914186f8f.21.2026.05.11.09.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 09:51:49 -0700 (PDT)
Message-ID: <5f5149a0-0f72-4638-a237-5d9db718649c@redhat.com>
Date: Mon, 11 May 2026 18:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: restore cpu_models for system builds
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/11/26 18:35, Eric Farman wrote:
> Commit 0b83acf2f05 stated:
> 
>      Introduce a source set common to system / user. Start it
>      with the files built in both sets: 'cpu_models_user.c'
>      and 'gdbstub.c' No logical change intended.
> 
> Except that's not true:
> 
>      git show 0b83acf2f0 | grep cpu_models
>          with the files built in both sets: 'cpu_models_user.c'
>      +  'cpu_models_user.c',
>      -  'cpu_models_system.c',
>      -  'cpu_models_user.c',
> 
> Restore the s390x_user_ss section, move "cpu_models_user.c" back
> into it, and re-add "cpu_models_system.c" to the common_system
> section.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   target/s390x/meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 44f58ac291..6adc2b896d 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-features.h',
>   
>   s390x_common_ss.add(gen_features_h)
>   s390x_common_ss.add(files(
> -  'cpu_models_user.c',
>     'gdbstub.c',
>   ))
>   
> @@ -38,6 +37,11 @@ s390x_common_system_ss.add(files(
>     'mmu_helper.c',
>     'sigp.c',
>     'cpu-system.c',
> +  'cpu_models_system.c',
> +))
> +
> +s390x_user_ss.add(files(
> +  'cpu_models_user.c',
>   ))
>   
>   subdir('tcg')

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



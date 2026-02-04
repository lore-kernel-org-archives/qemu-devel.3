Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B2AE9D3E2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndbD-0000IN-Vz; Wed, 04 Feb 2026 09:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vndb8-0000GC-0m
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vndb3-0000hm-D7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770214266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QFzbu7+uOkaP/4gZvuVsm8v5xfxngFjJNMtqpswEYaU=;
 b=Nd1z+GtFhG9AkXxu+mnKiSZ+opyg5t5CFncgB7KG0QljXOkoOPAo0ZdwwPJUoGXVKmXJej
 fRInwPcDV95/19Dvq8Ylpqg+F4jSsWTTH5sr/25OIl/8oz7Fs574HV2Yns676RUi2hqb0t
 j6esSH9cd94ytFD1odJMPpkwzGlxp9s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-CdzvMVxfNeSTr-wThkUc_w-1; Wed, 04 Feb 2026 09:11:05 -0500
X-MC-Unique: CdzvMVxfNeSTr-wThkUc_w-1
X-Mimecast-MFC-AGG-ID: CdzvMVxfNeSTr-wThkUc_w_1770214264
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so74518505e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770214264; x=1770819064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QFzbu7+uOkaP/4gZvuVsm8v5xfxngFjJNMtqpswEYaU=;
 b=LqqzWJVYc68/g37LDGXM5gyqFWSsHq48ToJ7dUh30Hz5AyZQNDGrEHmnFGwy3mElAf
 8axE9luYnIZ+rH91jXkNaKOjntD5l76tobpPqyf4yP9p9o3nf2lwZAi43tgN14TUdZ7a
 n4Q+lBeh1xpvWxZcnwM3zE+N5WeRTT0W5q7mjAtVMxBG2efGQ+wB6brhXmBbb3LHwMZn
 O502RI23FLlpr4CXNtwL5U/6Z+FSfJ5fofP8cmNJgCAaoQhuOe3ZCOGchLI2ngXhY1m+
 0SceG4VSCBglhlsdP9i7xMuz+bAVNHmXmOhG2cE6T1t+RpPGJJHrcWS0ZiRMbzogZdUD
 7FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770214264; x=1770819064;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFzbu7+uOkaP/4gZvuVsm8v5xfxngFjJNMtqpswEYaU=;
 b=Ff52y4F+VH0nwdTpVH5gvpAhCTTOCgjjrXfq/cpFZxUMv1/2pg1sCnxEReJsahXCoi
 UkzhfDaPgCufbdsC/LIY+taXduBvbzDdqY6SPWamp6CaNGtfGG+PjViHAfWTvPiHIvWZ
 ohC7OATiqjLiETnEKKIKD0blDrDqFvvlEz8Xi6Z6fX4POm2HY05cDtX4+HY+6CWe33sa
 yWDSx3+Lpg6HfRsqZ8sElDcJki9uAoVFrQWR/oWLbnyE48UWX260+S1ZTq3QPhk4FkGD
 mUDL2BWSMK9KLpbAMHLqVTZ+rbJjtQzsUkX89HqaTGZn/t3nL5paDY3sXwUulnR1/gM/
 FxTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0tznkGmkFUmY8VvBDS5SfMpEGV9rDs2DS0NO4yX06SY/DpKBPSycKA0TCERmKJrjzcRo93I+QgYAA@nongnu.org
X-Gm-Message-State: AOJu0YwRLcXDRgDCA30CXFS+eyuk5JoOc6eTNnfvw7MSp0PRhf5gu0GI
 m/lX5E13wxux3+yeKwLdzgb/dNGM2JXxDZAgZq9DiMVYXagN3GUWUt0nKvc9xubzeOgjEHrzbpF
 ZD9Hzyus5enHzWSLgfpLVefAHyFz5pxK6ObKLW6nZ9hT+BM/fS1SXXEm/
X-Gm-Gg: AZuq6aItqFczUYWeTQcDRPhN6ei5IN7IJNCv/CoezyXDewC6rbBF8YIN4xapr/REI5Z
 CtJrV0VciEIt81i/bU6L1YHB4lyhmNM7jY14eWM56/LPr3KaFIzGo0T7AyOzoaprNkSbxPUWWYy
 ryD8JYksHG3bpnUXsTUqnjSJb0+0x6eRn3hw7Q/kVIHZ3h3o65l6ShJdzFHZrxCcXuPMa/QK9GW
 3tIubxK9Xw7XdUbB0PG2Z6TNgy/gDWYWCUBg+ffgIgsLLJPt3qlBkttEbq/9zublua0vQOtBZVh
 JAfZb8Bm7EbCUkoONWOu6A9SaS+zclBVMTNfBWYAxNM2fEsFnyp+BxEirFzbW7aXDxcuQXlve/W
 f5+w2XAHtUeAcSTSTbF++I8OeFTkXVaCpL7E=
X-Received: by 2002:a05:600c:8715:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4830e930416mr43119025e9.10.1770214264142; 
 Wed, 04 Feb 2026 06:11:04 -0800 (PST)
X-Received: by 2002:a05:600c:8715:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4830e930416mr43118675e9.10.1770214263735; 
 Wed, 04 Feb 2026 06:11:03 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec57bcdsm36644175e9.2.2026.02.04.06.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 06:11:03 -0800 (PST)
Message-ID: <a173e463-4796-4520-b91f-f5db5ae80e5d@redhat.com>
Date: Wed, 4 Feb 2026 15:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260203203512.672552-12-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 03/02/2026 21.35, John Snow wrote:
> Add the local python package group into pythondeps.toml for the
> tooling This makes qemu.qmp, qemu.machine and qemu.utils
> packages unconditionally available for tests and scripts.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 743e2a8848c..89256132fee 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -37,6 +37,7 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   # system packages, or python packages we vendor.
>   [tooling]
>   "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
> +"qemu" = { path = "python/" }

Reviewed-by: Thomas Huth <thuth@redhat.com>



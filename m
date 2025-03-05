Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A626C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpcD5-0000Pu-O3; Tue, 04 Mar 2025 19:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcCx-0000OQ-PG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:02:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcCv-00085H-Ut
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:01:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso66535735e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741132912; x=1741737712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6mMiL81tBq7dadl/UEbWgW83XnayeAp3Egzm+vVHNk=;
 b=Wkn52JudJFQqoVqzrMcF/j9pdUVALI9psGp8/erTvyQZ1lhNDcIiRnW0UnpOb5Ujg2
 RwazzCE65LN6bDeUUuPfdiI4YV6gcig+ec+MOFoI+F5r/XMVriXJvfYOuZUaesjOu2+v
 5nfUqYcPVW17gKTjF2NUBHRysV+rOuQ2SxCz39jkL7AMZ7luz+MtUeNGD4y7L+nHoZN6
 0UIK4uTHzcgRuuMKjLsoFqGvOK4DVt5QFpSSN59gcvauYXsIT0U1hKltlp6XAcXUSaEk
 U33VcyaoWnDrp24aP5b/U23vujYVQsuG5hhxtoP6AWWBhYhnijD+ryutMyjbX+AXX1ja
 momw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741132912; x=1741737712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6mMiL81tBq7dadl/UEbWgW83XnayeAp3Egzm+vVHNk=;
 b=aViOJpGfXqLqIVqxnm1h/7f0qRZtjemEgWsXMlCh37dU1jg9hgN2GxtBSMZwvbE9o+
 brhRmzqIkxSYlH+aB9YW9YcZ6V3qnIPBeAX9UTPQvXVeZWnNOz37iAFdL765a1Me0eOz
 TDp1RI2RtCtlXA/I2dsz/U13qdJ7i5LFUvLiEh1wTk4XV3tO0Cqakxnu65JAvvtuqEZD
 B0c1OCUuWLr8+cxkbfh6418LY7eaUnzKMUkMsJyo7QMOPWGPQYiAEnSl2UNGtN+XSZnk
 tyaZr0f3oPbq/orndWhcd3e+CaywdKl7uoShAjoyeyv1zuXILZf3wlj0ii3XS5X9C4s6
 dGaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkm0B+ba7v5ZPbpkaAzgoPwubjy+f2aroErFCg1wsec883LM8S58bScUP7/ypzk9j9KUbQlL3i3WQk@nongnu.org
X-Gm-Message-State: AOJu0YyBpf/7NNiXV6BOKc5GEvmuOjkJW9d2z1DacarheiRBbb+XdFXG
 xd4aFRjqqOH4vQE7aeEPgdbo0a19J9Vq4gPbg9giGKHhVRo02pSCaawmdfo4feo=
X-Gm-Gg: ASbGncvhtEr3cd1yPtDg1IhNHttqWGzgy66BZOnXUPW3+aRnEKvcpxmzFfsMo3XFze9
 W5g0ieeVKzIwbJmSa3sQIBYybvt3IkyW4EBV4Q5ghp3rpqt2inqcLDrGhdpWQ1VeN2zIxLn40zC
 TN4olhMwfxzup1VPDxP5QWC179YooXFbZTU6sWWFKlt3VCjBn85CvUuJHtciRVo/WXmE/30tyco
 9aCg5OCrL5aOobSXIbUS64KqmYzd9Xf1DCjN4n8lhOgsLjKCelRyfTICckZ3Opumeqt59b8VgV5
 JZ3egNL4jiysSd5dQNJxw2lVjI8eIMFSbsws86XkA8LLs8oPGaaAsIKfUIwgkhwarRRtpZfO2nF
 +868PT++ag47m
X-Google-Smtp-Source: AGHT+IH1Vbd87AWbycmQeSkjTrK6veDQEJpf7bkJSNA/Xj+Z9mIrkDUSCBIQ9MwbY570c8sLgFOmuw==
X-Received: by 2002:a05:600c:5114:b0:43b:8198:f713 with SMTP id
 5b1f17b1804b1-43bd292db63mr5598295e9.4.1741132912151; 
 Tue, 04 Mar 2025 16:01:52 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e486eea3sm18806425f8f.101.2025.03.04.16.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:01:51 -0800 (PST)
Message-ID: <44f7f6d6-2c13-49a0-8775-40a9a12ba86b@linaro.org>
Date: Wed, 5 Mar 2025 01:01:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/32] plugins/loader: populate target_name with
 target_name()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, qemu-arm@nongnu.org, Alexandre Iooss
 <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-22-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250304222439.2035603-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/3/25 23:24, Alex Bennée wrote:
> We have a function we can call for this, lets not rely on macros that
> stop us building once.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250226140343.3907080-17-alex.bennee@linaro.org>
> ---
>   plugins/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/loader.c b/plugins/loader.c
> index 99686b5466..827473c8b6 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
>       struct qemu_plugin_desc *desc, *next;
>       g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
>   
> -    info->target_name = TARGET_NAME;
> +    info->target_name = target_name();

Unfortunately the declaration is in "hw/core/cpu.h".

>       info->version.min = QEMU_PLUGIN_MIN_VERSION;
>       info->version.cur = QEMU_PLUGIN_VERSION;
>   #ifndef CONFIG_USER_ONLY



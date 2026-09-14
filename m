Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50EAC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6COP-0006HU-9F; Mon, 14 Sep 2026 15:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CON-0006H6-VX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:31:03 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6COM-0003OY-84
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:31:03 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1866280a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789414261; x=1790019061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BzrRLp9mH/7GyDi6mXglqMSLlljC64Yb9lrYXtBh4E=;
 b=uu1x1uVYJlQDK1cjYYX8ctxfHvHc+axihGhUJk++LZeEg+Ro4pknFCQC3B6MuRC/dC
 AvkPREu9O8WX0Ea3bqHckF16na1+dHXDS5OaPqTNVjZeC4t+UmUQx6SU/8Rm4jms4xbv
 Tsx4r5ULCAqvZu+eYlfmeNRwprUlNpXrzIX5KMhUsp3HusApZwnYTkgDmyConB5hMmJs
 9VSIrhLGtqYJptLQeZYdJjluWMbu7B9H/Bfvgqr/trMgI0jcbyhw0OJ9bnF3wXBrKbz/
 LHqgW7EctY9/JD++hi5cxbnYJCjXqRXwJMO8pyZmrTnIRNhi8ftis1FHYsaDzs2WUWai
 QN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414261; x=1790019061;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/BzrRLp9mH/7GyDi6mXglqMSLlljC64Yb9lrYXtBh4E=;
 b=Nx3KfPpbDhKKBPy5KBGNbF81robOuZTxfwaC5EbBKZcw6b93hrmxRTdWxGciOwDaVm
 5zl8ONzCesLYA3SS+4Mww9waayEsqZ29/MSK7ogOSzI+J7vsBxyMQJ/kXFM1dlVzT4rx
 SS4JCbTy3Fim/ZiIDugmQ9oiyxcyYPNCrBiyAgK8iKJerzqYcvtY0Hb0HnEWRwdJAUzF
 7wK8hx+5MWDGeentrWDoZ2qFkQ9jwAY5NjGun0I94oRzGCh2gAvpcWk3Q6VvObCWxywF
 8OUuEBPR+nbKgwnwxuG0MgaM+xTcNnvF36l8r/GR8H7fdwg9qTk+1t+F8Ts509JB9ucM
 FTEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmjp3L+hv8xIEldmJcEFL+Bu0uPyTgJbKczLbhbj6UY5uFWPE9DrwJApxXrQcKCHwJrrYDOjdIHxEz@nongnu.org
X-Gm-Message-State: AFuF++nVwQAp1sA/Ef9aW0KNySU7jAkhq4nFNfKX8isiGpfNVFWZL1kW
 nL94qumC2IM1caNCGcvCB4WcHtjCz8GT3i34Uz0IpjyTljNGy4l6GDEgDJZ17kn8eSc=
X-Gm-Gg: AYBFou3CqBuw0dUDwM7yN6TxhYqMNh9KaI793PyRBxQeIPLlSe/L6utqNvoFVE/bQcl
 aSeQPX5TzVHJ7KylRpgJ4uEDzo3e/GhxArkqqeSlGjfvxD0gn3IA+5rL5F5/f716LeDQ0ua+KtO
 5l0It0ohs4QHyEkoEAhSH1Pb5P+uxYwvXSXwTUM65C9aBeR9f8bKbMzQ0rVzZI1vVQUzeT0mT+S
 5lRQRtYx1iceFKXMhxZ14udhwkyz8uPzphbsakHlMrU2h18gzaVjccWpLKIzzhNp683AR6hvQX9
 fbYtXAgcXR+tvo5uL2VZbIByBSRvvHpcB8YoIwT9BOvSnPOPhhEY6Mo0oA7RCSTwb9qxswCCIQU
 t1N2w5CXQMPyKlYvtIaIXOpG2qNA//AgE8uW+MglHnYmNpAIxS90FFJF3CowkUAFShPHczTPFvK
 6G+/8nTtPsX8Lo+5K8oAO30KDhDaUq/lsD5djevtUc3dHM7JyVG3Pn0a5R9N5SDAzy/bpDpLQmo
 Lf1R/0+4bpbS8h9eOo39hFlgYSmuFxq2GO/oeIk6E4zkLstylFU1kJCqs909w==
X-Received: by 2002:a17:90b:1649:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39df60b8c29mr4563304a91.17.1789414260741; 
 Mon, 14 Sep 2026 12:31:00 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33baf0ea9a1sm26715694eec.8.2026.09.14.12.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:31:00 -0700 (PDT)
Message-ID: <7a47ed5e-fc50-4f13-8fac-455c6015d38e@linaro.org>
Date: Mon, 14 Sep 2026 09:30:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-13-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> @@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
>       ObjectTypeInfo *info;
>       ObjectClass *parent = object_class_get_parent(klass);
>   
> +    if (data->has_secure &&
> +        data->secure != object_class_is_secure(klass)) {
> +        return;
> +    }
> +
>       info = g_malloc0(sizeof(*info));
>       info->name = g_strdup(object_class_get_name(klass));
>       info->has_abstract = info->abstract = object_class_is_abstract(klass);
> +    info->has_secure = info->secure = object_class_is_secure(klass);

Why are you assigning to has_secure here?  I thought that was just for 
the filter test above.

Call object_class_is_secure once.


r~


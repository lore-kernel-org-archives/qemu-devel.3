Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E45DCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsz7-0004RT-Dw; Tue, 26 May 2026 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRsz5-0004R0-9H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRsz3-0007RY-TE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779806537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fZDdsIz6mWe2PYk4uTEblQ6F35azGLkwHQC1mtzNnlk=;
 b=Tj3hFiqmilokptyLG73m512v4PW6icV+NvtJqsH4vGk1cm2AJkwURZjddTnFSW5aqJmgoJ
 LCdF4w0v7CZGcSQ5MWu8bli/DgVgT8U4P44Y3z/P8iQhDNqB1ZqbJUvkoJAm9vE5ko4EYF
 cgV64molSpDlKMPBRDURzOuimYdkbcw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-I8ZRI_CvMhmLnyCAwl68Tg-1; Tue, 26 May 2026 10:42:13 -0400
X-MC-Unique: I8ZRI_CvMhmLnyCAwl68Tg-1
X-Mimecast-MFC-AGG-ID: I8ZRI_CvMhmLnyCAwl68Tg_1779806529
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44f56d5523eso9526220f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779806529; x=1780411329; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZDdsIz6mWe2PYk4uTEblQ6F35azGLkwHQC1mtzNnlk=;
 b=CeWmZ5qmSeC8iHkSxOlC7hZAWgUMmWVDgBVsVYLMcyKdNn/5Md9TzfYXMiMq8W0MV4
 zN3lxP4Pp+9DeWAhJnxLKGZDtpT8d8Eu/IBnCvtOjQLUAUWxatC3Zdkr/IGHNmwB/PCo
 NngHdnf7Xl0OQ4Ja4htgPZttmZmXvxxMFx/5tZxD5/6mGDegOuvgN35jtcCjACSSskqd
 9obkx7rh8Rw2cRmXR1GhnPqXSwqMnyXzoz9ZwNF/yEqh/03iuh60JU5TruaDc5gUAyA8
 G+XUPgqwFrFANrBi9dUqfrwWGb79qddBhljh5peu525XX77PjxbFlKMU97BFDEeEE/Gp
 POvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806529; x=1780411329;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZDdsIz6mWe2PYk4uTEblQ6F35azGLkwHQC1mtzNnlk=;
 b=dyCqR5iwfPa/OmoNiZDCF6O6kno6RkJaEXtXeXMidA3Yr5gvxtD9HOPW1/9Cmk3bnN
 YzKyaCYGW5yTiC1EWDXQcKkRk0Ce+kvMkpim5ghTR7mpC7ofnEfIxuJyzj9ZD5saREF0
 GbsLaYqwn/BpDW8QGKu8Fg0mkr1Fmdjhe0qyMcjwz+EslgLyWoV8OO2g6YqX5VUyOY4F
 z2Se+xzek3pjcSShtpEoQKc27clzwI3fwPQ9d+w/KwAw/p9Sek+Z6H++ze9ZE175HunR
 7zao1ALz6AeKggeSA9XB8UU3sfMQGzAIFVJ3a1zGFIpCA2Wh3WVBNNZjIXa8SEbYKqrq
 Jonw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ONwjRq00hNItNdEGFVfcx7XUuT93n3cPGMnS4wfIqNkdGarJPg28FqfUyU8lpjp9jKC65Lir5nx41@nongnu.org
X-Gm-Message-State: AOJu0YxDHJG2IIEMC5XBvWsrfOHF60r+ao992NRZ4Tmq+8Gh2t9rF5+V
 wlqVsKNWKuAWgVxWfSxpMG9GgDMw2ZJpJ5v7PdG1Njx0eYu8Lm8VywouevgZolyjTWHBOGUrlQ0
 kC/RIaB1eUvWDXbUm2JTZZJSFy0f2W/pGc6/3fysW1XfM/KmJGhPF1q97
X-Gm-Gg: Acq92OH8EA1/6Mu9BhhC1IZbhSLoy226TPO65WIAYnUhxHli9Slh6jm9rs250H8qx94
 9cSWfKuQizL1oDxifuyio7Wrm0o0uFAN/QJYjc0vXEIfXOExbxirCD0slLizK9yeTDXB3A/Bg9c
 oT4nvbNEYpbRH7BxxcP6OVAhFh2dhIHg9RKAXIrlEYwprt8u0msAs7MIs/zfvNo+ozgCPZpjH5r
 ofsd79QVsq0sWa6nnNaG1M2LvhepH/HOJ3xyrmlPA3/5eDFZRUAzdzn4O1iQrSlMYduxqOomA4R
 gF0Jwvyql2jN8gMW6p2egO2S63YlJ6sXByUTSYw4fXUBM08am3PYYLyWljQxdTUlt9DGd+PjnUe
 8Db9i6VqrP01MNUE2lPS5cHSgqhwMO4RqRE37i+V1kPNltsvIsTwR424GSJt5Ak0buWl1q50=
X-Received: by 2002:a5d:64c2:0:b0:45e:b2b9:705a with SMTP id
 ffacd0b85a97d-45eb38baf74mr29795841f8f.23.1779806528919; 
 Tue, 26 May 2026 07:42:08 -0700 (PDT)
X-Received: by 2002:a5d:64c2:0:b0:45e:b2b9:705a with SMTP id
 ffacd0b85a97d-45eb38baf74mr29795768f8f.23.1779806528242; 
 Tue, 26 May 2026 07:42:08 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9b980sm33049781f8f.3.2026.05.26.07.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:42:07 -0700 (PDT)
Date: Tue, 26 May 2026 16:42:06 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 13/18] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
In-Reply-To: <20260519132905.145643-14-eric.auger@redhat.com>
Message-ID: <0d3a2287-e94f-3eb1-018d-b4dd74275ab2@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 19 May 2026, Eric Auger wrote:
> This helper decode the ID reg writable mask, matches it against
> ID reg fields defined in target/arm/cpu-idregs.h.inc and
> for each writable named field, generates a uint64 property.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
[...]
> +static int
> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
> +{
> +    int i = ctz64(map);
> +    int nb_sysreg_props = 0;
> +
> +    while (map) {
> +        ARM64SysRegField *field = get_field(i, reg);
> +        int lower, upper;
> +        char *prop_name;
> +        uint64_t mask;
> +
> +        if (!field) {
> +            warn_report("%s bit %d of %s is writable but no named field "
> +                        "in target/arm/cpu-idregs.h.inc",
> +                        __func__, i, reg->name);
> +            warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
 							^
 							up-to-date?

Reviewed-by: Sebastian Ott <sebott@redhat.com>



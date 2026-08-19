Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01226C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwoGh-0004Lj-UG; Wed, 19 Aug 2026 17:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwoGc-0004LG-Vk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 17:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwoGb-0000iG-GE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 17:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787176572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJrEwhFvu1Z3MGdbdQ72Iu2us62lBAYeaGxgtziJLos=;
 b=G5GxaxaS4+R83a5P9O5o7rCxjeJXokO1YwJj31Cp470mXROrffjiA5oAh9f5pIeA0Uzwxo
 PAWeYj81LUpaxDxutFfNorztL2Xn1Hae4zsu3AuHBaMp6h8vXJ09z0DoGJHtKzPl7l/SoD
 SvKPD8oLmFDah/d/myT6f4IWQHSMiMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-tm6TiL2HPSKYroO1Y_0hsQ-1; Wed, 19 Aug 2026 17:56:10 -0400
X-MC-Unique: tm6TiL2HPSKYroO1Y_0hsQ-1
X-Mimecast-MFC-AGG-ID: tm6TiL2HPSKYroO1Y_0hsQ_1787176569
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso9680295e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787176569; x=1787781369; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PJrEwhFvu1Z3MGdbdQ72Iu2us62lBAYeaGxgtziJLos=;
 b=dUvhDmO/rSX+D2t/gcdOoUZOwcYqwHIfPYp0182ZJUnIBJimBybXUebaFTXa3WWe/x
 hMAaDDUBU1aMC8BqxwC3BAzKJP4ULw5UDhYehEcenNbBbTjDApxMyROcqsevRAUijjir
 wWimTUNc1q3ntFF1+lG/p0gFTXQTEYpwtj9K76v8l0fUtT0J30BGXqBs8wbiX/OMZTS/
 vHIIcT4vd7nZ8j+uJ1RRPJ+BW704133WVXvdVhCNYKaun0nw/9lczUf0e7tkJeZ1T8IV
 vKePQlwXg5I+asiPApQSwJH9HNbi8CQt0d7Vkn91nJqP3j347G0R6dfHtbcEknnsFAoN
 lsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787176569; x=1787781369;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PJrEwhFvu1Z3MGdbdQ72Iu2us62lBAYeaGxgtziJLos=;
 b=Df5CDr8TWshpZsROObmRkEEsI3qpfd2UitKSL5ULOj1eIm2ZLwZERHz4PFnmKfEk3F
 x1YK9HjdTVs6Y3s9T2MHLpYR4159r4WhgcXdcfErGeS/TekgBC0aN9x3h3WOxIg/mITx
 qkAbI4f1LJTTvLXlFmNeibIKgCdR/hvXFzjO0RpTOeuEXwoeRL8wwYIug/DI9JnD6b+M
 tWIuUnu6rfeShsFexXnR/Up8bWO7JoaqZzCNgRd/lcHSnPOnRuq8fp1zfM2zcp+8eJuV
 yPFxoWxkIcer1YR53VAeF2dAE6tTBPr7BlgB7RCV0WarOMKCadGC79S4sdjCRg6WE+fx
 Qzog==
X-Gm-Message-State: AOJu0YzV6nXbGM/VhPrHCW6kdmsbBQdIZw42RFEp7lO1vWsvbp1n9IMN
 cGsUt3NhB3xm2XicXa0KJ8cePO5Y+t6lFrnaixQKgaQemxG7cjEXuzJEAKPA5hCHEmOrIswFpE2
 UHPP+9yF9Ur3m7n8BJ61ilit6IwXCrN/WPwkKJ1MLxfSl5fCCPPi3FjwN
X-Gm-Gg: AR+sD13Mjiaz9bfHTGiuQFCOWImcV1l7Ru1zaYCojV6zouhB/cKmtvcPTM39MX7+wrd
 omRxLdRaASZW6UAom6dpAdICaEzriGuPbNgAlJ4t4RG+NluHnH43DwCIKoFl5Y99lGHzjfB0gNV
 kDSrTMgpeBhG1TEL5wIo2gRh6V+MKQM45kkHyICaPyJTb+gIvSWwK4h5uPCBcWOmCLuGD0tfq70
 TBGWkIsTNuFg5nHTxSXg1upNXdEkCfEPxEy7iltZ5spORVSqlvAVh4WZBgrYcJ9kEN9BbkBtmD6
 vZ7WNgf4GPCuM5ByH+byAvgJk6fsGTcd84K8zoQM7gpqs/ll/lRo63VjcFd9wxiTu0EmYQCxMuK
 3PP8dfVebazt918icVq/oymeOBTU7tE4=
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-499aa143b7cmr134690545e9.3.1787176569362; 
 Wed, 19 Aug 2026 14:56:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-499aa143b7cmr134690175e9.3.1787176568941; 
 Wed, 19 Aug 2026 14:56:08 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-173.red.bezeqint.net.
 [79.177.155.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm118925905e9.11.2026.08.19.14.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 14:56:07 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:56:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 6/6] docs: deprecate virtio-crypto
Message-ID: <20260819175408-mutt-send-email-mst@kernel.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
 <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Aug 19, 2026 at 10:22:06AM +0100, Alex Bennée wrote:
> We have outstanding guest exploitable bugs in the code which is fairly
> complex and needs some serious love to clean it up. As off-CPU
> cryptography acceleration seems to be waning in popularity lets just
> deprecate the sub-system with a view to removing it in a couple of
> cycles.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Gonglei <arei.gonglei@huawei.com>

Let's see what Gonglei thinks.

> ---
>  docs/about/deprecated.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968fc..3c22981fc8a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -276,6 +276,20 @@ future release. Where no 'dh-params.pem' file is provided, the DH
>  parameters will be automatically negotiated in accordance with
>  RFC7919.
>  
> +Devices
> +-------
> +
> +``virtio-crypto`` (since 11.2)
> +''''''''''''''''''''''''''''''
> +
> +The ``virtio-crypto`` device emulation is quite complex code with a
> +number of known flaws. It has never been migratable so is unlikely to
> +be used in any serious virtualization setting. With most modern
> +systems supporting on-CPU cryptography acceleration via their
> +ISAs sets

ISA sets?

> the need for off-CPU acceleration is also reduced. Add to
> +that the kernel has recently removed the ability to use off-CPU
> +acceleration

did it really? I thought it's just for af_alg?

and putting "recently" into cde will not age well.

> suggests the time for this sort of off-load has passed.
> +
>  Device options
>  --------------
>  
> 
> -- 
> 2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EAD75BDF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3eJ-0004qY-SW; Thu, 21 Nov 2024 04:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tE3eI-0004pm-Ar
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tE3eE-0001zk-QE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732181927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=woM2r1PzPvg1fY7AlqZ4WjlRjkVRPUorhvZTY5KZDtI=;
 b=NEkxFS/WFD0W0tav+oX3L33rutNTb6JekLj7MM1VmIl1fHYm/QXeALSp1U/pAvYYgfFVV/
 dqOyoUA9QhUgeAQ+w/W0q8FPhrgmkzGQmXaX33L3LuxlrmxU8bfJm6BcUDiYj2QbB//qOM
 x58O4UEgWRNdktJrXM+RGNUmu/xqK10=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-VI6LxNUXN76NktJS79adRQ-1; Thu, 21 Nov 2024 04:38:44 -0500
X-MC-Unique: VI6LxNUXN76NktJS79adRQ-1
X-Mimecast-MFC-AGG-ID: VI6LxNUXN76NktJS79adRQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46363ba4b31so8357961cf.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732181924; x=1732786724;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woM2r1PzPvg1fY7AlqZ4WjlRjkVRPUorhvZTY5KZDtI=;
 b=NYQrp1oxnMAogBoaUuJjuq5BSYZfxMUu5FLKfjb+hODdg9azRqw7E28lknzXAAjnrK
 yoNs+eCGv4w9LPXcienHcLGSRdulLF/fGufqjHwsJr4CzDpAccSqhm5Y5WcmBpdSoB3M
 s7q2ZOWbz/8CEuDr50V9g5cyrx1M+WRf37ctY69Lv1nvLOiNXllvqhMnLTtnzHtLR40a
 Kzw8tUe59Ie2d5dQpLs56ntKmxQuW3jRGFrV+iyLzHf0lkMzwUmIgGFWazMXRGsDqKZf
 TW3DU3ggxgK2k120yf05DfDXMYlEuiWjB198xqujYAbmYgRvyyrJ9eKhRAE2J0XKMPyh
 3Cyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqLowvWdDgD4Uj3Jk59akaqiQMptNN8YqTyIEmkptPBtBuCMHIMdl+qeOd8dhpf/pvs/6WsqwXKD9A@nongnu.org
X-Gm-Message-State: AOJu0Yywsb7cGU3nLE3F7Mp1h586G+vRaAJg8gJzW7dh31iQSvnnu8pD
 5QW+rtrLt5vEnyujeluubk12WUz16v7wcSF36B82SZcP9oScxzkunzKTmPeE7/oLqNMaGliHSpT
 lmNF6OMd/ic+SbSUylHWYcQHrjJFlUdBeR8udhtQLR2a/+MfQHQkx
X-Gm-Gg: ASbGncuefos0AA+LPwFPzO+H33Ee9fjFrWWiTF1BF+s3c8PESJLae0OuXRVOCKs1wFV
 GryUACKf7wud8p2AUvwUrib4WaP4wqppLwYeP8vXwaVPtHHbsOg2bLBWJ4Ig9z3jEGUf+dW1OLZ
 6KuDeQMAMtW9om2xWyCw2dM1tGVqvcKZvTi3NzZDNvNNomDzprBkzuyva2kLw5+BJr/TX6ozJfp
 ArH5iJZdFXqkkiyE6orvBvMiGGKdEH+Jxhs7IOGFJFMv7lLXmbb/zv9CddXVhQzhLrtJu0KdeK0
 tW+1JSQ73AbK
X-Received: by 2002:a05:622a:13c9:b0:461:4a7d:202f with SMTP id
 d75a77b69052e-46477fa7842mr69135021cf.19.1732181924134; 
 Thu, 21 Nov 2024 01:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeG+bGY2jCySQALt/yvrJjEvcgq6TbkKSjDNeEYQ72rQgXgFIrXf2lI/0cfAAD/IdskQ8OqQ==
X-Received: by 2002:a05:622a:13c9:b0:461:4a7d:202f with SMTP id
 d75a77b69052e-46477fa7842mr69134791cf.19.1732181923723; 
 Thu, 21 Nov 2024 01:38:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46467fd62absm19826611cf.17.2024.11.21.01.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:38:43 -0800 (PST)
Message-ID: <2c63bf58-108a-4785-ad7e-c7e6446970e4@redhat.com>
Date: Thu, 21 Nov 2024 10:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] ppc/e500: Avoid abuse of container_get()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bharat Bhushan <r65777@freescale.com>,
 qemu-ppc@nongnu.org
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-8-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241120215703.3918445-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/20/24 22:56, Peter Xu wrote:
> container_get() is going to become strict on not allowing to return a
> non-container.
> 
> Switch the e500 user to use object_resolve_path_component() explicitly.
> 
> Cc: Bharat Bhushan <r65777@freescale.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/pci-host/ppce500.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index b70631045a..65233b9e3f 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
>   static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
>   {
>       PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
> -    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
> -                                  "/e500-ccsr"));
> +    PPCE500CCSRState *ccsr = CCSR(
> +        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));


why not simply use :

       CCSR(object_resolve_path("/machine/e500-ccsr", NULL));

Thanks,

C.

>   
>       memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
>                                0, int128_get64(ccsr->ccsr_space.size));



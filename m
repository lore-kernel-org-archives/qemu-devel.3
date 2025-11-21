Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0ECFC519
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMOWZ-0003wD-0X; Fri, 21 Nov 2025 05:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vMORE-0001d3-D0
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vMOR1-0001mf-SD
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763721115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+RHa4p0iHR1IOHvI5B21eRkLJXWRGVFYKk675qglgs=;
 b=Kc1DZvTtFiA7EVTzQyFVH7MynNO0nf4qyfPBAz0u73LiboX0SCJGiXaA6yiZszJyahqFIa
 L4loQdcsWXUP/dsQkdk+Jka/VM4z+wmjSc0jTmz1SShpDeQDiP2N6iharn6DdtYOxy6UXF
 b8MzLJK5dE0V3EqkmkMfHpABhwYZS9M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-QdUKXpgiMCOyrxDL6QDr2A-1; Fri, 21 Nov 2025 05:31:53 -0500
X-MC-Unique: QdUKXpgiMCOyrxDL6QDr2A-1
X-Mimecast-MFC-AGG-ID: QdUKXpgiMCOyrxDL6QDr2A_1763721112
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so24368555e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 02:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763721112; x=1764325912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o+RHa4p0iHR1IOHvI5B21eRkLJXWRGVFYKk675qglgs=;
 b=hkIF0W8G/LxygTfzwi0uAi/pZmdI98Hf+rxPqZadaJKwC82RkF4WFUY2+Z915+6bW7
 69r/y1eZ78jTnGegKnQzi3ZmkbaBSPwSkelTI5JBbFsM6OvTUgICR1kwinH5m29BWn1+
 mhrBAsiiPD7MrQ9UVwNEjnEw5Ga7OefPr+2LwPglozRwH05I2vj5G99sinndwI1to9kE
 SKLaPTpq8TRRazhkIs4pEe/HzlnwbTcVYNFDzRDEN2xJwt5sHZY7t8yO6l2cQlDgihlw
 P7vxBWcyFFUc3cba+ZQIYtOAUR8w1Wa62nCuV7xeN7r3QsRL/vDFGEZ0o3tPHFIcpPoF
 oT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763721112; x=1764325912;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o+RHa4p0iHR1IOHvI5B21eRkLJXWRGVFYKk675qglgs=;
 b=cAR3AOz9oJi/aavmPKH1jwTa7MspeULc96f8VDQvbzQiLm1QeEJfqOaxM8VpfUoB/l
 Gk5hIL2B128LSn58lf9mq+QzwNpO5//VEuLQSHdUrGv7VCU260KiPeQKIcHEF77pe4t0
 gWm0dYZaGNULEvnV5ba8wXaJVuqOnale0rKl0AY3hrFP9mWB0Eot0Q7plLuzJg0NRUDw
 1LBmfe6YkYn6iJWEH3GXIuBtrr8MnB+5zv7aQfbN3/Q7Aa+0VQ17ANq6c2LTijcC7gs6
 L48bhoMKoWX23f5j/XoaI6IDxQTb9QL8KW7S4XZvfQgm+cx2m1RAoaVbPhL5uA03xwCL
 oJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/AmJk78sv/7xKULPad+AcxQtT6rPdHX/scuGmyNSYUm0N7Vy1PrvTAoMLZNfmYyNKLMcuPcjh2B4@nongnu.org
X-Gm-Message-State: AOJu0Ywjh3cm7YjwHyVZZtDyBkIg/yUAzujEMxrD3XaLEvsqe7Hi+gz2
 Ong0VzqdSiXds3j2SFFGjn7De+jcyHiwg8RdaCgjLspOQMj/RDafWVGJaJPmeIOkob5CJeQgnKH
 34h/O4WIa0hchKVIS3LH2oEgezF6FXU3PK3zS9DWxFDTJeZdkAUrfsWzT
X-Gm-Gg: ASbGncuuqirnjgmfPDA1doVv1AmPhV5PfZUr837Kuxa1zcX5PIagqkcSqu1DpsyKDGl
 CmI2UdxzUFq4YPKfbWh4LcWQlx0t+8UTM2Mi00ztPpn/BiF916zBoitbdKf8yHlL1zraYm1K+dr
 3v4wAXE+kZqVplPk+wxie2xwox+u9gpBpdzjJHJwC70e552YhHUUVyg3YtPG2GtVThp76eyUp9q
 dSeEMc73wIcvb4L66C6lNO2TZE0CYx849NyV///1q1grKfR7Ko5UwRaZaCJCAES07DZhf6oLRqf
 ZTJLt+M4GMbVcIa9XY24RCSv3L8Af1ol6DntixQ52ZJ1QgUqqgYxPwN5u7xe4lIv7pA7YKJqOsH
 0dWXeLT+5GCx+3fBAffiL9kbWePf9sbiqbgZ5g1t5U9GEfIOD
X-Received: by 2002:a05:600c:4591:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-477c018a016mr24491495e9.15.1763721111738; 
 Fri, 21 Nov 2025 02:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMlU/fnUimi22Q7bj7W0on1rYFZ2QWorAfdrtNFX1lHxh0F0QHEzy8OoH0wvr9gx+GYKD45g==
X-Received: by 2002:a05:600c:4591:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-477c018a016mr24491075e9.15.1763721111312; 
 Fri, 21 Nov 2025 02:31:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3602d1sm37064255e9.5.2025.11.21.02.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 02:31:50 -0800 (PST)
Message-ID: <684e5c25-5070-46c3-bb90-b1aede884d00@redhat.com>
Date: Fri, 21 Nov 2025 11:31:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix the typo of vfio-pci device's enable-migration
 option
To: Yanghang Liu <yanghliu@redhat.com>, qemu-devel@nongnu.org
References: <20251121094341.80038-1-yanghliu@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Cc: Mario Casquero <mcasquer@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251121094341.80038-1-yanghliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Yanghang,

Please add a 'vfio-pci:' prefix to the subject. Something like :

   vfio/pci: Fix documentation of the "enable-migration" property

It is good practice to add a commit log, even (very) short :

   The change that introduced documentation for the vfio-pci properties
   contained a typo. Fix that.

> Signed-off-by: Yanghang Liu <yanghliu@redhat.com>
> Reported-by: Mario Casquero <mcasquer@redhat.com>

Add

Fixes: 4526687bf126 ("vfio: Add property documentation")

Could please resend a v3 ?

Run ./scripts/get_maintainer.pl to get all recipients.

Thanks,

C.




> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8b8bc5a421..b46b1305a7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3871,7 +3871,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "(DEBUG)");
>       object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
>                                             "enable-migration",
> -                                          "Enale device migration. Also requires a host VFIO PCI "
> +                                          "Enable device migration. Also requires a host VFIO PCI "
>                                             "variant or mdev driver with migration support enabled");
>       object_class_property_set_description(klass, /* 8.1 */
>                                             "vf-token",



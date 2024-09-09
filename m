Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA212ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snd5u-0000dW-0T; Mon, 09 Sep 2024 08:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1snd5W-0000V3-LO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1snd5V-0003x7-3z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725883301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XpZerlyHqp6+eXqpLQJlvVyfAVQQgEEA54YLr729FFc=;
 b=dtVXRjKr3x0mOnpczkUXSeXvJqD/p31I1zioVIk5WeitIp+glnbMwp7DrPpMR+y31zoJyF
 fW8boHco8/qm+nREnZ95oGzyRNPYgb6OIe/NKIIbJN24RxX4kWFn7JMp0J3KaeM19P4J50
 I8RiIQmO9qCrEN/qSPHzFMBEcfq2rKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TkM0XzD-OP2x-PhLA1gs2w-1; Mon, 09 Sep 2024 08:01:40 -0400
X-MC-Unique: TkM0XzD-OP2x-PhLA1gs2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso10073135e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 05:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725883299; x=1726488099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XpZerlyHqp6+eXqpLQJlvVyfAVQQgEEA54YLr729FFc=;
 b=WeGmwRxTm6ivuV4Hf6Ruy5eDqaLFZFPrTz39Fl2gU5HPmQt0dpAd+zkeL3ABX+wvAl
 HOsBcZXHyRNfHfZu1Vdl9BWogQqeUy4Fz4GlIMeHU0jKI3pLni0d7wNNNrShTJPh24Nc
 us/7x9en71wtC+D9Ew0T5g5kcHqK8l16jdzBCwLy6pF0C/DlyNRy+qYJvOpcs5ZsQJ/A
 kXFCOWRDacl6PcwkvvmHXcFz7N2nAr9maUxehdqxja5X6rWXJP/qARPbALipV7hAWELZ
 c3EkazDXPcAeEbkZVWTQ8DA1a17zVDk+IKMElkBpU1L3uoA8oJ0ettfAlcH0TMMC8VDe
 hjfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW60/zNxWkKUVht4sLSlF8lQwkiQyULwZzB+Dznl3nGxdXGFx+3Xc628nfx7bX9fHFsP/OrIlv2S3nj@nongnu.org
X-Gm-Message-State: AOJu0Yx4aX5UMl3GdDbXghMRmYGZpiAugbNrg7qBYFRZ4aMtNkbHrFko
 KKanQbdfZs0rOYCZSRaJlTn3cDLqTJWwisP6x8yuGTz5HloT4tywvqrLdyzWRN3dm5fE3BLL1px
 Ki2cdebkzYC21srocruDjb4IMCitgYAI+0zMfjOSQxxxZb33RlIzfd6OkIY/rHH4=
X-Received: by 2002:a05:600c:1d14:b0:42c:a802:a8cd with SMTP id
 5b1f17b1804b1-42cad760bcfmr54241125e9.11.1725883298916; 
 Mon, 09 Sep 2024 05:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERsWeXeRF/oQzT/1+6l6QiVWeccjif/49snbTaVgp9nq+dEvmb0l/ZOBc/FX7lR1aV3lj1fA==
X-Received: by 2002:a05:600c:1d14:b0:42c:a802:a8cd with SMTP id
 5b1f17b1804b1-42cad760bcfmr54240655e9.11.1725883297989; 
 Mon, 09 Sep 2024 05:01:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee?
 (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de.
 [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb44887sm75040605e9.23.2024.09.09.05.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 05:01:37 -0700 (PDT)
Message-ID: <c80e1612-9a2a-40d5-9581-b8d6bcb79e39@redhat.com>
Date: Mon, 9 Sep 2024 14:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: kconfig: memory devices are PCI only
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20240906101658.514470-1-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240906101658.514470-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.09.24 12:16, Paolo Bonzini wrote:
> Virtio memory devices rely on PCI BARs to expose the contents of memory.
> Because of this they cannot be used (yet) with virtio-mmio or virtio-ccw.
> In fact the code that is common to virtio-mem and virtio-pmem, which
> is in hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI
> is set.  Reproduce the same condition in the Kconfig file, only allowing
> VIRTIO_MEM and VIRTIO_PMEM to be defined if the transport supports it.
> 
> Without this patch it is possible to create a configuration with
> CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
> linking failure.

I'll queue this to

https://github.com/davidhildenbrand/qemu.git mem-next

and drop it if someone beats me to up-streaming it :)

-- 
Cheers,

David / dhildenb



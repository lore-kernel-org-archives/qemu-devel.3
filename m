Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2247D1A639
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDv1-0005Ap-GU; Fri, 09 Jan 2026 09:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDuz-0005AR-Nq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDux-0002SE-HF
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L0mHEJrgVZY8vvpOU0c7gFI7E7k1cI1lhD9dgspJojE=;
 b=ER21tAraTSJZ9RFCj7ZG7IXe+jH90kKl0Bvr+nD1hZwwK5ioxTRLQdrURtDCQGqjRmmZzS
 q+U0uyu2RCZbHcMsNtPrfrbA1y3gdZXKj3zr+cTrJ8LCd+P/zIZMFf3EaWiSGhfAA38PQ3
 RKVVYVR/yIQaibWZPYx91BkKjphlC4U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-cZYvQJXqMQKb9BwcLGIaiw-1; Fri, 09 Jan 2026 09:56:44 -0500
X-MC-Unique: cZYvQJXqMQKb9BwcLGIaiw-1
X-Mimecast-MFC-AGG-ID: cZYvQJXqMQKb9BwcLGIaiw_1767970603
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso1624153f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970603; x=1768575403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=L0mHEJrgVZY8vvpOU0c7gFI7E7k1cI1lhD9dgspJojE=;
 b=i0cJu8nqyNHSoJnxzmy+Vcm71FIf61XGdLeMDfLEnp377HxsFpB6rLwlVzt1GRk1VQ
 CrDgOAwm+JVOhjA1u/AiC7LMWH7Vag+t9VjxCkFshGYRcLnARrgHDtC8mW2vmR3vTL9E
 ROWcRR6T+A7m5LQtWElenDNsJqaPCGiI+4rxmp4Ps5fXdfTlon+UEyt13peLug2I3+tg
 1n7aY4L9WnD0f7Ag4yTIQOfqIZsDWtVVt2KSlDdFtDPgTjFpxb8E9IwjwsYjHUKQcAfF
 L+T4Zibhuky+UJ4R2PgL8McDv28WFAxVwSqxogXS+2ckwNcAozP8N9OvfOvcTm/cSb+g
 XWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970603; x=1768575403;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0mHEJrgVZY8vvpOU0c7gFI7E7k1cI1lhD9dgspJojE=;
 b=cF0DJd6MX/BCeXgIOpqVwHyZr1o/pok58XtwpCCwAMjFKKVDwLfYemLo9034LnybHK
 JsotnyYA6/b5BJbn5k5VD6PdriVfBdRnJhxrR2RH4U+EHfc9YKemGihx2xLbBnmxLCp4
 5O65DqlOsXWOJrioBuJOJmq/cjpFrBCqAETSDp+EF6HQwwES6BimZ1kQ7P1lyFvWTzND
 1lLa74mYIPkR8PnL8zF1LSRBEPMxLbd3+VLomR4AtxVs3rFmuPINoYXI2i+Et/WYVmWl
 Nv8aNoj2+VzsFs26rJmWuMQ/YrfA5pKRpps69LgxZBjSFX4/PVIbHk8EQ8eeOzdcLsbn
 /FKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+tkKg0yALogxg8o8vGyXEl905i8pB7yWnbfI05CNKkH0l4RizQWw8DNBXz4v0n2Y+eDtpaWwxZU4g@nongnu.org
X-Gm-Message-State: AOJu0YxkiiLeOh4gguJ6dP77RnU6hbMy1HTgFH7sZS/b+YkgASgDAcij
 wZcCCW7qVKexddT/1dhvjVer40wIILlkVcpZN2wYDl3g4qdv2z/YCDXqWcxVqY9T0aUpbvkuWB4
 XXuW/VCbUyxCg8Pk6VBn/0FzFGcN1aU/45q5Whfj27tJ8ci27SLWZIU0a
X-Gm-Gg: AY/fxX4QA486EqRxPV4H41/zESDp1UlCvjuxiCGKgnJYJrEPA+maUMY/RhHZc9i4AaA
 NbH5h16GDC9heLRse01Aiv940ujskUH5t3cU3Hl55vsgtt+JBhIDqwqkN/ZaZLe7YN+XtF5vkGX
 Mdo8EP/HOBW94QQlanDpn7EClwtfReNSViV8aiNcgMuuQ31vOblEawkAiVGMS1YvQa9pbS3eFQr
 vU+9D+flNLdTMHI6cHQTGRgkdeTpiGEXyw7ZnoNsmkxafOtgtIByAyP9b8fboFTUE6qT2UXjDHJ
 7CtOctUtjC778/QLuRMW+NlMWxnsEnLnCnhCbYgInJXOrtNAMXBlbjx+TfBdDmqoW72yXfVSd90
 wxGi3WWT4zk4GbvnbX6TiNEt48pmO3beNb0UT+SrhOl33xePa
X-Received: by 2002:a05:6000:4287:b0:430:f74d:6e9f with SMTP id
 ffacd0b85a97d-432bcfd37b3mr17878780f8f.14.1767970603372; 
 Fri, 09 Jan 2026 06:56:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbCNZvV0m/x9DvKtqS8/GUUGSOusC4M2iV7kpYJiGjYNPtMYk9Kx7DI1yFworcinG9DcmsXQ==
X-Received: by 2002:a05:6000:4287:b0:430:f74d:6e9f with SMTP id
 ffacd0b85a97d-432bcfd37b3mr17878750f8f.14.1767970602900; 
 Fri, 09 Jan 2026 06:56:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm22837459f8f.42.2026.01.09.06.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:56:42 -0800 (PST)
Message-ID: <21e888b2-4051-481e-a384-cad4d1413e99@redhat.com>
Date: Fri, 9 Jan 2026 15:56:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess in PCI config
 read/write functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org, philmd@linaro.org
References: <20260105222029.2423-1-alifm@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260105222029.2423-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/5/26 23:20, Farhan Ali wrote:
> The VFIO pread/pwrite functions use little-endian data format. Currently, the
> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config() don't correctly
> convert from CPU native endian format to little-endian (and vice versa) when
> using the pread/pwrite functions. Fix this by limiting read/write to 32 bits
> and handling endian conversion in qemu_vfio_pci_read_config() and
> qemu_vfio_pci_write_config().
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   util/vfio-helpers.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> v1 -> v2
> v1 https://lore.kernel.org/all/20251217184253.1520-1-alifm@linux.ibm.com/
>   - Drop Philipe's r-b as code has changed.
>   - Do endian conversion in  qemu_vfio_pci_read_config() and
> qemu_vfio_pci_write_config().
> 
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 44b457c442..5a4169d1b1 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -233,31 +233,36 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>       return 0;
>   }
>   
> -static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
> +static int qemu_vfio_pci_read_config(QEMUVFIOState *s, uint32_t *buf,
>                                        int size, int ofs)
>   {
>       int ret;
> +    uint32_t val_le;
>   
>       trace_qemu_vfio_pci_read_config(buf, ofs, size,
>                                       s->config_region_info.offset,
>                                       s->config_region_info.size);
>       assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
>       ret = RETRY_ON_EINTR(
> -        pread(s->device, buf, size, s->config_region_info.offset + ofs)
> +        pread(s->device, &val_le, size, s->config_region_info.offset + ofs)
>       );
> +
> +    *buf = le32_to_cpu(val_le);
>       return ret == size ? 0 : -errno;
>   }
>   
> -static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int ofs)
> +static int qemu_vfio_pci_write_config(QEMUVFIOState *s, uint32_t *buf, int size, int ofs)
>   {
>       int ret;
> +    uint32_t val_le;
>   
> +    val_le = cpu_to_le32(*buf);
>       trace_qemu_vfio_pci_write_config(buf, ofs, size,
>                                        s->config_region_info.offset,
>                                        s->config_region_info.size);
>       assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
>       ret = RETRY_ON_EINTR(
> -        pwrite(s->device, buf, size, s->config_region_info.offset + ofs)
> +        pwrite(s->device, &val_le, size, s->config_region_info.offset + ofs)
>       );
>       return ret == size ? 0 : -errno;
>   }
> @@ -296,7 +301,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>   {
>       int ret;
>       int i;
> -    uint16_t pci_cmd;
> +    uint32_t pci_cmd;
>       struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
>       struct vfio_iommu_type1_info *iommu_info = NULL;
>       size_t iommu_info_size = sizeof(*iommu_info);



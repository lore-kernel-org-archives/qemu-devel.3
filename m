Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B09F9EDD8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXyQ-0002qk-FY; Wed, 22 Apr 2026 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFXy6-0002nw-8e
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFXxu-0005Wd-HO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776865804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UrpKreJTx6TUqUU5x+6ZiYPJi86Kbjg/3hdt0hEb848=;
 b=AB719GB+BGARy5DnVn24GFp9R9WMF92wmatX07hklpO+VWBBVN2z6vX1Hy1XVYuweSSP86
 Jdexy9IyqNUgWprSHKyJTGw2O5WebJID29bZILyceEUSw+ePRAWJGDZPXuLMFM91tG+vjk
 spi/PhL2vJE9Zp9En9246qkqEVNxR/w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-pUPHU4rMOR2GnusZ89058g-1; Wed, 22 Apr 2026 09:50:00 -0400
X-MC-Unique: pUPHU4rMOR2GnusZ89058g-1
X-Mimecast-MFC-AGG-ID: pUPHU4rMOR2GnusZ89058g_1776865800
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7982224a54so4231499a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776865800; x=1777470600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UrpKreJTx6TUqUU5x+6ZiYPJi86Kbjg/3hdt0hEb848=;
 b=G5mATE1TYBO15t9C5rejT4Ulwb2F04Ff/AHkCDqnMhEWj9JOeVXfPHykAZCt8pQdkA
 f81wvIgpTnKWg9SLY6YL/9lVol3hohOQxlILcfgbnHB3D7hcgT3wodXzUfrn/PAhFvsb
 MaOJCVWEzDiPokxsWuDQwjth90kPYnEOC0YFvJtyNW7zP1UUD+ax5yb35s1Ru10iGCup
 Cz444et6U8Rp0SzkNUlzhl4JSkDdGI/Tuj/ZLFsIzIBaojZ0nWbqH6euJzC8KSWkJ87z
 6Caa2TthhERId7A5I01wSWiAChKnv1i3hCJbBdXZU3a0cxYX0Q9iIFitTrI2tDbfWpv8
 EXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776865800; x=1777470600;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrpKreJTx6TUqUU5x+6ZiYPJi86Kbjg/3hdt0hEb848=;
 b=lol4xkcfO4ZN2zXF7xLKjmqoij+U+r91JF3Cy5cNeGrBuY3hIXvhhmT6xorUpOqWE5
 WE8eCrSu5LxJJCiMtoG/WIEeHeuiwRiSQWJyNN1BZiqKBGUyNKaGcUig/1YjFh1QyYoi
 k28Sk4gZ6K/nxQVV35Y9NSPNcw70/+hPZctJm6SJ7nkhiKJVVu1SfCdIixYwSM0dAGsU
 wwIvGSzni1PymN3cds0mn6xx0Aws/IshNxyMInJy38byTUvQEXL1OgUrx2gb9LWbz+tX
 2GX9URpcOLDjhYSXc7Ge4tXpUsogB3lqx7Uz5A4LeJgnq7E0PU85GsNHYOxEmm9LK4/i
 r38g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yuStEX9CRdlix2mm/BiaUc4T44bVaq1QTUTF9mpZ5SPmDXca7FAAyO007BkpzQ92+yP1bvusrks02@nongnu.org
X-Gm-Message-State: AOJu0YytiyTO01cYLKiERFjBbhXOgSSsU3H2Zxjm0hBaA2R290MvVT7U
 ofFt+OSeL5Gl7TmJYwgTV/hJx27KTT/fuYn4XJQqB06M5pFhrrz+T+CPGSWv1EQtcMOV9bufSoB
 JwlSZ3Lr//FFu2OCsrxGQpD+DfRvZvyw8B+7CyShw/0sKAVCUnE1VtLJQ
X-Gm-Gg: AeBDietqu2WQUSzCn2nfI4u37Xqf2VxkmOsub9LDZLuSQcFHfhlAQrgf3btp4pg7qRT
 fjSNh7wu8LuEWKsE1mP6/Yji1eYPozRX3DQQ6G6LbFTMAMATBp3EM4n0kG+xPPxOSdeERMJKoux
 vqKUKJqJM7n5AVs5TOGsxmN9EuvMiE06EJfEN762GIuaulaepMw/sdSddc8mdtZeIMiXbX3FNYp
 e85K4Eafmb/fDl0eFsHvm42JTIPoLX/aqE9jlsjDf3HQcZZXiTAgnCrDu8c5eGuElTpHtRks+wf
 VQyvVXKzVLZWaf08yfVXJ4X+eWcEXYWuXGjIYwpFRX6E7FRFD5xH7/6Q6i4+bROkIAqqc61cEtM
 z6nyYP2epQcEMwRBRes3/Zub6KY2fB9Ca65sXXZJvzrOHVLKtd5ZuSKU7y4G9z0YlbsrYpkk=
X-Received: by 2002:a05:6a20:7f9a:b0:38b:d9b5:5de2 with SMTP id
 adf61e73a8af0-3a08d90af2dmr25441434637.50.1776865799639; 
 Wed, 22 Apr 2026 06:49:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f9a:b0:38b:d9b5:5de2 with SMTP id
 adf61e73a8af0-3a08d90af2dmr25441388637.50.1776865799112; 
 Wed, 22 Apr 2026 06:49:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c798b56a758sm7905576a12.18.2026.04.22.06.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:49:58 -0700 (PDT)
Message-ID: <137b5ae2-321c-4d69-9968-1442baed26bc@redhat.com>
Date: Wed, 22 Apr 2026 15:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
 <2a5817c4-cb61-4867-9bdd-fbe68cf5601e@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2a5817c4-cb61-4867-9bdd-fbe68cf5601e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>> May be the iov API is not adequate for this purpose :
>>
>>    int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
>>                                     size_t total_size, Error **errp);
>>    void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
>>                                  size_t total_size, Error **errp);
>>
>> or the part validating the iov should be done before calling into
>> VFIO:
>>
>>      if (iov_size(iov, iov_cnt) != total_size) {
>>          error_setg(errp, "Total size of iov does not match dmabuf size\n");
>>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>      }
> 
> The value of the "total_size" parameter is actually an internal state of virtio-gpu so I have suggested to move the check to virtio-gpu and remove the parameter.
> 
>>
>>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>      }
>>
>>      for (i = 0; i < iov_cnt; i++) {
>>          if (!vfio_region_lookup(iov[i].iov_base, &region,
>>                                  first_rb, &offset, errp)) {
>>              return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>          }
>>      }
> 
> The remaining checks, however, are VFIO-specific. `vfio_device_lookup()`
> and `vfio_region_lookup()` translate the HVA/RAMBlock information into a
> VFIO device/region, so moving them into virtio-gpu would require virtio-gpu to know about VFIO device/region internals.


This likely means that the interface of these routines is not yet
well defined :

   static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
                                  RAMBlock **first_rbp, Error **errp)

   static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
                                  RAMBlock *first_rb, ram_addr_t *offsetp,
                                  Error **errp)

I don't think VFIO should to manipulate struct iovec. RAMBlock is
questionable too. A MemoryRegion would be better.

Some ideas, in vfio_device_lookup(), replace in the interface 'iovec'
by a 'void *' and :
               
   rb = qemu_ram_block_from_host(addr, false, &offset);
   region = vfio_get_region_from_mr(rb->mr);
   *vbasedevp = region->vbasedev;


And no error enum please.

Thanks,

C.



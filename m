Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FCC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUe0-0006Aa-7p; Mon, 27 May 2024 03:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBUdg-00067u-6e
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBUdb-0004uY-16
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716794358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoTiePj2SgsSyNDFQiutDJsrzjZVw0FMcnBlVOFGPVo=;
 b=EUrHOB8/MSO89AmbQ14CrQz2LGszmH3SUme+U7NPIRuakYxyA+XQO24Kh5jrWYE+bMMDGV
 h7nOPdKJWidAFodX7JhKi0KBCVnirMQ1ngWO/6x+Q2n189EvBMrzjM0TYjJmK2IsWZX+Tx
 qbjbs8pXjWxnMkcaZNzy4APDUI/+21o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225--4z1REnjNIGFw4OxBBZKmg-1; Mon, 27 May 2024 03:19:16 -0400
X-MC-Unique: -4z1REnjNIGFw4OxBBZKmg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43fb05ef704so33848011cf.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716794356; x=1717399156;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoTiePj2SgsSyNDFQiutDJsrzjZVw0FMcnBlVOFGPVo=;
 b=UAOGlKKZW3SCmITieEhM16dnELpN6YpsbU01jt6hMwEwJ9ig62GsEkkws763GzsU8T
 yKf+k2xQ+c69b3++8eDss9vTBD2zli5uc8Vec6LkB1iE3iktoYvn23GmxM49zshhHn6e
 euVxRRR1kH03+QMLn39TSjtppD+LvYoHMraKWRj+PsH4bgYmea4eTS8IQlnp1t2j9Ky7
 yLd/BOnSMp+wj58DaciQhKFaQDJrUC9EV/847n5D0YChB8pBRtPEEuVYwpnliWqw5dhH
 OwMAHpNEQeU0DoSARggFHrTn5ctC95DxoL625W3JyE+WlYoJc5G5MGEtr7vCAnR9hdX2
 hOEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLiok44y+mfbHbP1GVznszIOMlIIlgs7K5JGs+nl1oLanBsWJgbMr64UiYvsUocosxz0KBWRQnWpS361K81USy9dJGLGk=
X-Gm-Message-State: AOJu0YxPEJZxx+kMXpeaqixlFZ9mmVBn8PnEMzZw2kYyt3GMYHTk4Nde
 d3D+OlFT/+sW/wQGaZsS+gtWfgeDdnJDwSUeo0vvQCVRiWO/+r5FNoVIf3XIofEy/bGGos63xN1
 GftlL+aGlhABIeZJ+dMVS+/VLPARo9bo1V9/TL2TexXT2kdJgDw8G
X-Received: by 2002:a05:622a:188e:b0:43c:7504:32ba with SMTP id
 d75a77b69052e-43fb0e5149cmr91741821cf.10.1716794356067; 
 Mon, 27 May 2024 00:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExM2/nlFpN6xxacm/DZQWnwb57vvtqWgQW75EWgLwk087q6KqJMuI28JP+sMiV5LIZeeCvhg==
X-Received: by 2002:a05:622a:188e:b0:43c:7504:32ba with SMTP id
 d75a77b69052e-43fb0e5149cmr91741671cf.10.1716794355378; 
 Mon, 27 May 2024 00:19:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e?
 (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de.
 [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb17cc2d8sm30838891cf.26.2024.05.27.00.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:19:15 -0700 (PDT)
Message-ID: <f1fe0673-254d-494e-ba8a-d252723c1f16@redhat.com>
Date: Mon, 27 May 2024 09:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Atish Patra <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-2-bjorn@kernel.org>
 <55810d52-0360-40ad-a8d2-3b6a8aa220ae@ventanamicro.com>
 <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
 <18f217cf-6d68-4676-8674-d91f96e155fc@ventanamicro.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <18f217cf-6d68-4676-8674-d91f96e155fc@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> 
> I wonder if we should forbid users from removing memory that is 'out of place', 
> i.e. users
> should always remove pc-dimms in LIFO order. Usually this kind of control is 
> done by
> management, e.g. libvirt, but if we're not sure we'll keep consistency during 
> memory
> unplugs ...

I really don't think we should do any of that. ;)

-- 
Thanks,

David / dhildenb



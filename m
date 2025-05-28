Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56198C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDT5-0003oF-PD; Wed, 28 May 2025 05:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDT1-0003nP-KK
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDSz-000570-HY
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748425975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=enKiLFxyxDjrKV9PUnTTYCjcb5Z6w+jRFSDf9ZRUJdw=;
 b=T4/o8V1oz8oDHwoRHIvH54SziQPRLg2vcH8N5thKn4KWIR4PopJJQ807nVEq4kDS1fRCbx
 ycJClBNCtt66Gdm3thuAG3TikDyDPIrLUb6AkYf304Vp6ppG8rZwDJ4qMGm2DqC025vyq+
 jO74oApJDPdIyXcXHUPHoWaCkhld00M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-uDF9vtfmMoGae1mkFP8h1Q-1; Wed, 28 May 2025 05:52:54 -0400
X-MC-Unique: uDF9vtfmMoGae1mkFP8h1Q-1
X-Mimecast-MFC-AGG-ID: uDF9vtfmMoGae1mkFP8h1Q_1748425973
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-445135eb689so26500775e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748425973; x=1749030773;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enKiLFxyxDjrKV9PUnTTYCjcb5Z6w+jRFSDf9ZRUJdw=;
 b=tgsTlOInhTzTu/bQeoouOXBihV5wJBw0OOiT+NGfLlcSRWyCG+TvWZ2Q66eE3hbjq3
 Eg2hK9MV+ycpDJzp0OzFW370gEpym/1iiJ631uuXHhmCShcAKHIAE1AKLoysSWGW7PVZ
 hJl7ZQHZaNF9DUBT4Vv9zvKlEnWZInsufqRfzG2+DzB8Nr2p+n7TTEF/lPmiLIoV4xn1
 gk3waamwvqiB8wmcLsGdC5OnqWQOWEwDuzPolyaWp2NvmXwdMZYgscSIBjxSRNEtm/os
 IRVuy0EzfrGGAvOv95OQlVrw4lplhE57ZCyglN3+V/FsUt2zTXa8katG7m4k154HNXKk
 YT3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV2O5lWO4QCkmUIrHcaQItx9/bVnF5VQXkLr0TbV9goRBHDC2CXEH12eubKWC0SEKA45PltFNZRZAt@nongnu.org
X-Gm-Message-State: AOJu0Yy+LbutmH+n8fE4y1ZRifk6tXLwsK5kfGDws6OtemHSv1QVEZJ6
 x58WQ788Ku5QHOJdwPwpporhHFsYoOiREzC44JwNyMjFf9eNvxrOoFOo2buCV1ePt7Nwq9iZqSJ
 9JCTw6TnTB306LBAy/PFguPJ51PkJu9LaVwbsF/L8qW3cCkYGuDOksNQ6ia/EncwcS+k=
X-Gm-Gg: ASbGnculZM2CMhb4ETSuyWZUB635Z2ynjftp35n/ZIAd4pXySV6kiNuqQzNcfPKrgHo
 OlUm1RkcNvOjqkENgxo3AmqShCFqMcrVIyMyijfjVQ6D7jo7G2/fYOXBMACh1g9nVUZr8bC9VOH
 VTGlb31d0868WLivlDlMOqa5Dt3Dl/Hszl/kFZ0PmWSrYVvhwLG6cpv3jWXvmhASjmBSYrbzDRQ
 yZny+pqAjq4rZI4ldPQA3N5kKvqf3LTAVJGbSYTGhREp3Yi9OPlSKecnZzp/EgTmfdcTD3QxvyN
 sfSz6RpN+WaQomt4ihEEijJibkrPoe6N8TzCgVN8VbEA/gsUpD9K
X-Received: by 2002:a05:600c:5396:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45077e36cc8mr12591215e9.23.1748425972927; 
 Wed, 28 May 2025 02:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLsVmGGDtxyAgt33GOiyPFeYz4TEj0o1ir0tuKc+VPzjxofpnxfSg13fAeGM4Dgx+CgqCLQ==
X-Received: by 2002:a05:600c:5396:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45077e36cc8mr12590945e9.23.1748425972473; 
 Wed, 28 May 2025 02:52:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1ddaeesm15621915e9.35.2025.05.28.02.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 02:52:52 -0700 (PDT)
Message-ID: <e58a98e5-c6ae-456f-aaa5-c55924517665@redhat.com>
Date: Wed, 28 May 2025 11:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Get "Message headers fail syntax check" error when using
 git-send-email
To: Li Chen <me@linux.beauty>, Qemu devel <qemu-devel@nongnu.org>
References: <1971648603b.dce1f5d22901195.6702025346547333607@linux.beauty>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1971648603b.dce1f5d22901195.6702025346547333607@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/05/2025 11.45, Li Chen wrote:
> Hi,
> 
> My emails to the qemu-devel, qemu-riscv, and qemu-arm mailing lists regarding the
> "[PATCH v4 0/4] acpi: Add machine option to disable SPCR table" series are being
> rejected by these mailing lists, while other recipients are unaffected.
> This issue didn't occur with versions v1-v3, which I sent via Zoho webmail instead of git-send-email.
> The error messages are:
> 
> ```
> This message was created automatically by mail delivery software.
> A message that you sent could not be delivered to one or more of its recipients. This is a permanent error.
> 
> qemu-devel@nongnu.org, ERROR CODE :550 - Message headers fail syntax check
> (... qemu-riscv/qemu-arm ...)
> 
> Reporting-MTA: dns; mx.zohomail.com
> Arrival-Date: Wed, 28 May 2025 16:09:36 +0800
> 
> Original-Recipient: rfc822; qemu-devel@nongnu.org
> Final-Recipient: rfc822; qemu-devel@nongnu.org
> Status: 550
> Action: failed
> Last-Attempt-Date: 28 May 2025 08:11:19 GMT
> Diagnostic-Code: Message headers fail syntax check
> Remote-MTA: dns; eggs.gnu.org
> (... qemu-riscv/qemu-arm ...)
> ```
> 
> And below is the email header:
> 
> ```
> Received: by mx.zohomail.com with SMTPS id 1748419823397138.51964085412385;
> 	Wed, 28 May 2025 01:10:23 -0700 (PDT)
> From: Li Chen <me@linux.beauty>
> To: "Peter Maydell" <peter.maydell@linaro.org>,
> 	"Shannon Zhao" <shannon.zhaosl@gmail.com>,
> 	"Michael S. Tsirkin" <mst@redhat.com>,
> 	"Igor Mammedov" <imammedo@redhat.com>,
> 	"Ani Sinha" <anisinha@redhat.com>,
> 	"Eduardo Habkost" <eduardo@habkost.net>,
> 	"Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
> 	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
> 	"Yanan Wang" <wangyanan55@huawei.com>,
> 	"Zhao Liu" <zhao1.liu@intel.com>,
> 	"Song Gao" <gaosong@loongson.cn>,
> 	"Jiaxun Yang" <jiaxun.yang@flygoat.com>,
> 	"Sunil V L" <sunilvl@ventanamicro.com>,
> 	"Palmer Dabbelt" <palmer@dabbelt.com>,
> 	"Alistair Francis" <alistair.francis@wdc.com>,
> 	"Weiwei Li" <liwei1518@gmail.com>,
> 	"qemu-arm" <qemu-arm@nongnu.org>,
> 	"qemu-devel" <qemu-devel@nongnu.org>,
> 	"qemu-riscv" " <qemu-riscv@nongnu.org>

Blind guess: You've got a stray " in above qemu-riscv line.

  HTH,
   Thomas




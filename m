Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF17CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 05:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umQJn-0004vb-S4; Thu, 14 Aug 2025 01:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1umQJk-0004uq-Vo
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1umQJh-0005vH-Em
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755148554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tI7aHbAb1gTNUc/3WBn/ieZtyz4DWS2spgmyYThPDCU=;
 b=Hor70C5kcN3tQT7gKXbWysgIJr57aDGLXC/24sfazBO9kU87T0LRMOlv5vw1800caAIFsW
 idrApzOGJQndRjJQr8dt9AjbggoXd2+h1Yzt6eZrcWQDeF9+DHQKeLPeBudLqBeUEwIL+E
 h+4/8/FzxPI6MPfrt+ux51+RxeTCMhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-fd4oir8FMomcAdGWVC7aTA-1; Thu, 14 Aug 2025 01:15:46 -0400
X-MC-Unique: fd4oir8FMomcAdGWVC7aTA-1
X-Mimecast-MFC-AGG-ID: fd4oir8FMomcAdGWVC7aTA_1755148545
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b9edf332faso146352f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 22:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755148545; x=1755753345;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tI7aHbAb1gTNUc/3WBn/ieZtyz4DWS2spgmyYThPDCU=;
 b=jArTAjwQUxut8P/dlWGLwi1AvdvQ/TlpYIPcDo0Bmn9TbOdrYzNAtfNUZjXJNe8cUC
 jKvksqe5cCrb+5CyDWjhiTHujKmdvWS2jjtTidEcRmfl/CR2p00Tr+TYDzRu8X8zKx3V
 WZtu9zJZF+3poI3p7j5gCzQa4rOfPghIPGdAC/nQcQEwr4QOz/XrY6geAbh5j8nlCkzz
 LgK+HdWmrb2PAMx03QgW96Vim1ybAlzjrFvEnRE3gafS1MGwBHOOIexc4SbQuYO37rJb
 gWc8ABTwkfQBqf33pcoGS/JGTBHrXWx+0WITZYeM7yKVxrV5NdnXNpqrZVw8tsz9XrAJ
 J1yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSHGpDgj2asaJmv2/P3QEd13GePOKrpvDz11au9P0UNarbYQV5231nt20bw5ZP3DEmR8i2Hx6yNwIA@nongnu.org
X-Gm-Message-State: AOJu0YwuQfkYFx065Be+OApJoqA3AdPblzkcoI7qOT2OI6ckpP81yRK7
 U0LYYRy86jlxzNmIlEWplk2dgjFDoMlHqRQ0fgvks36ZS+JLj46jn3yUt+Gx1atlYcPmB6C8ufF
 Hnjw5QTCzXgNVcatSTse3jrTQhcDwD2Nncq4OQ8BEjUAj3cIe68mspDPo
X-Gm-Gg: ASbGncuuMq+8jwP49J1O3SEBo6yqTGbZkcqhmbtUIeNZthU1YSNukaRDwWF4X8YTkN+
 FJVwKNh35/Os6uQewAAuTzdRYekPqoSnFcr4jnHC0M1Y9FZ/UJQp/bhrqG5GHz8P0QBHqXTjZx9
 xwRN+bQ/eBkp2Y7GbW7SoiyN5Gld22Ivjsill8bHiGBXxoGcH0NMExeQ0fDWf5YNZMyYbVAWJgz
 TRFfpZcRuI59xizaOx9d6SuM951zs3xy4VlqbVoCNEd7MbtpvoPBttHd4s5doP81E4UCWBOG+fc
 XSE125u3W6HOd3q+HihxmlpBjD/O8IdDTg9HZAx8p9qp
X-Received: by 2002:a05:6000:1ac7:b0:3b7:9c28:f856 with SMTP id
 ffacd0b85a97d-3b9fc345ab3mr1317660f8f.48.1755148545259; 
 Wed, 13 Aug 2025 22:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsdRXh13rrLRAUtJN1pazI2ik838nzVBKO/ev76TG7RnLecBichlOMw1xPCbYcn1K2omwN6Q==
X-Received: by 2002:a05:6000:1ac7:b0:3b7:9c28:f856 with SMTP id
 ffacd0b85a97d-3b9fc345ab3mr1317643f8f.48.1755148544890; 
 Wed, 13 Aug 2025 22:15:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45a1c71068csm6559585e9.29.2025.08.13.22.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 22:15:44 -0700 (PDT)
Message-ID: <ef55eda3-fc4f-45dc-9f35-6502efeec381@redhat.com>
Date: Thu, 14 Aug 2025 07:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] DTB build housekeeping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250708204806.1898-1-shentey@gmail.com>
 <87c791c8-accb-40de-9ed8-d86bd179dd47@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87c791c8-accb-40de-9ed8-d86bd179dd47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/15/25 08:06, Philippe Mathieu-Daudé wrote:
> On 8/7/25 22:48, Bernhard Beschow wrote:
>> This series removes the bundled device tree blobs from the repository 
>> which are
>> redundant to the bundled device tree sources. To make this work, the 
>> device tree
>> compiler 'dtc' is now required whenever libfdt is used. Furthermore, 
>> dtc can now
>> be built from the bundled libfdt if needed.
>>
>> v2:
>> * Allow building dtc from bundled libfdt (Paolo)
>> * Find dtc iff libfdt is used (Paolo)
>> * Remove dtc configure option (now obsolete)
>>
>> Bernhard Beschow (3):
>>    hw/microblaze: Add missing FDT dependency
>>    configure: Ensure existance of dtc when libfdt is used
>>    pc-bios/dtb: Remove device tree blobs
>>
>>   MAINTAINERS                                   |   2 +-
>>   meson.build                                   |  16 +++--
>>   hw/microblaze/Kconfig                         |   4 +-
>>   pc-bios/dtb/bamboo.dtb                        | Bin 3211 -> 0 bytes
>>   pc-bios/dtb/canyonlands.dtb                   | Bin 9779 -> 0 bytes
>>   pc-bios/dtb/meson.build                       |  17 ++---
>>   pc-bios/dtb/petalogix-ml605.dtb               | Bin 9882 -> 0 bytes
>>   pc-bios/dtb/petalogix-s3adsp1800.dtb          | Bin 8161 -> 0 bytes
>>   subprojects/dtc.wrap                          |   1 +
>>   .../packagefiles/dtc-meson-override.patch     |  62 ++++++++++++++++++
> 
> Being not familiar enough with this meson fu, I'm only queuing the
> first patch, being a good fix in its own.

I queued the rest for 10.2.

Paolo



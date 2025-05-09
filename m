Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B241C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNnx-0004YY-LA; Fri, 09 May 2025 09:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uDNnv-0004Uo-C5
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uDNns-0000pH-Vx
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746797414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fd/h4NUss9Kl+fhdVab2bUS/LU1/DPsIc5inj0tEVmQ=;
 b=EVmI4NwbYuwOE0Pfney8HnbyKAdjxonTR1ocZUfcvTH4YCOJimg61zqL53VnHE9q9DYAft
 l1XZVvsEzu2BpjuOc/GOTwwVng5KNUSCp7jvcu10RGAmzcgVQOLF4NMW5UP2cuI2RngaUQ
 RwGIbBXek5twM6BinnXH+aRvkjHrFo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-iy9vr3hOPK6hKo3p3XDmXg-1; Fri, 09 May 2025 09:30:12 -0400
X-MC-Unique: iy9vr3hOPK6hKo3p3XDmXg-1
X-Mimecast-MFC-AGG-ID: iy9vr3hOPK6hKo3p3XDmXg_1746797411
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7124b5fso1361136f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 06:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746797411; x=1747402211;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fd/h4NUss9Kl+fhdVab2bUS/LU1/DPsIc5inj0tEVmQ=;
 b=w7T1xMTGcSnJsnYlFpPlercTubRnwCd4qbl3PBvRmuBFDr6a9XAw/9U2hzKn5t+/qd
 5AAdJQY+m0LwiCy8llUGFWQCATFnY4gNXJwBeFgMCcx8SMrEsbeHabM7AAoAzxTwGjRL
 oI/hlqSdcODrpcIlVTMW1u2poflT3dx4nQ15LcmuRluCW++/qd2WARXFoic6kv1pLbmW
 M8PwP5BJYaeujqJ9Wf7eb0ewX5QMs7U5b+KYS6UWT7x+s+z9DW08/iGHU6qEgcheB97j
 8h6BNndFnJEZLKXrDjd6+0JhN/cTzjJkWorPzT0vp95Y+oABgePKypg9gt8QT6m5Skx6
 PQbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn5H/UTh4i1oume5IqUIgNllrl6vnGAkQ1q2pJFd3xKFauFr485D7WMUOBShwOqiHvZ5CS6M82M5jp@nongnu.org
X-Gm-Message-State: AOJu0Yz4U5hHKum52d1624CCXYhiusn4s16pcfREV5I1J1yWrgMIV/1e
 Kdfu0IYLkZFcDH4l5fSPJZ5k1zBbKRfCnv5awRvoopT7RS69j7xZPihX9T0Mg+GgvDDDg1J8DDs
 yFr4yR9ougj8CWtdSm3hrBLKhZJbCpefsit5I+s3A/aXS1baFZ2Kr
X-Gm-Gg: ASbGnctfIvreJDS9epHvHTZ3nE56KYcz+AUVsU6XuqcwJTk/B4eydqhnO1MbsBnPm/y
 91fnKDyRnFJHDYcGOaZymm3YOLMnuRmQBo2sVkMGDAqjbFlUGEj9MPyGBQlRGwRdClu0GE+uJFa
 J8WDg05xayyRNola6vkjFf9iVzyGZIRGW/okph6EILcLoJdbADclp0ybLde6OtJjIY5VoxRhQpO
 3UrNeYO7jiWnN/hAHr/IonxJeZYeoIp+OUyT7FAU8bZdLW7YjP6YYK4BTG7OUJ2kBPCLo+0bCIu
 mXXsqN87ShQOB+fDTLXekt/RXjjBVFP40cqacp6A2HKezpdB8XC0
X-Received: by 2002:a05:6000:40df:b0:3a0:8383:ef19 with SMTP id
 ffacd0b85a97d-3a1f64ac258mr3040017f8f.51.1746797410702; 
 Fri, 09 May 2025 06:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5zOQO3+QKRrv3B6dJ4VIAVYMP9cVwtJOz22vPpb/OYcKCpSSQDPfOfFEzkLD1DwqUQtXvkA==
X-Received: by 2002:a05:6000:40df:b0:3a0:8383:ef19 with SMTP id
 ffacd0b85a97d-3a1f64ac258mr3039987f8f.51.1746797410342; 
 Fri, 09 May 2025 06:30:10 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c7b2sm3289807f8f.93.2025.05.09.06.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 06:30:09 -0700 (PDT)
Message-ID: <4d3d7964-2ff0-4e62-9949-bc3df4018e31@redhat.com>
Date: Fri, 9 May 2025 15:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250506143905.4961-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06/05/2025 16.38, Philippe Mathieu-Daudé wrote:
> (series reviewed)
> 
> Since v2:
> - Removed qtest in test-x86-cpuid-compat.c
> 
> Since v1:
> - Fixed issues noticed by Thomas
> 
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series only includes the 2.4 and 2.5 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow. Highlight is the legacy fw_cfg API removal :)

  Hi Philippe,

I just gave this series a try, but it fails in at least two spots.

First, you missed this:

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -112,7 +112,6 @@ static void isabus_fdc_realize(DeviceState *dev, Error 
**errp)
      }

      qdev_set_legacy_instance_id(dev, isa->iobase, 2);
-    qdev_prop_set_enum(dev, "fallback", FLOPPY_DRIVE_TYPE_288);

      fdctrl_realize_common(dev, fdctrl, &err);
      if (err != NULL) {

Second, bios-tables-test now complains about a mismatch in the ACPI tables 
somewhere...

Could you please fix that up and check in the gitlab CI whether the problems 
are gone? Thanks!

  Thomas



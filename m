Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D92C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lM7-00075V-PE; Tue, 29 Apr 2025 09:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lLy-00074W-5V
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:50:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lLv-00038Z-Ri
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:50:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so6502407f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745934625; x=1746539425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvZO1vi/PJ3mSrdrLV5JB0Ltlq5dtxV6yCArhUx/7xo=;
 b=UFski+Lfpsa8mDn8OWvMvcWG0a9uZkDcpCPAegmcMyaGyQMzujVcRQ+nup2IaW11eI
 u4OIJo1DO+0YqndpM4qhQlX01uwwIG9FVTE3kn2KNgAgQZ7IbUVGl7nsoPB64UrDsyjj
 +3f451DNVC5URvRCvx8rqdIb7GTNpp7sP+ZEgvzzc++YQBUFtSaIlbGlY1T1HEOqYwqn
 5V7mzYQYUJ4mkRZNvv2LPNGc5ehfAKBT26IqIUV4lSUiZZSMtCIG4+3mpjB4EI5STTbS
 4HKEIpjWmVbcO3aSwSbiTcaJKN2cHhGDJfwT/e6OlLlg1RZtfk0vaY7FDB8nyidCI3bT
 1TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745934625; x=1746539425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvZO1vi/PJ3mSrdrLV5JB0Ltlq5dtxV6yCArhUx/7xo=;
 b=dRNPuxTPDrg+7Bl31oBhcMQZd5XNVgL5YaFJaC4yLcKZZc4Xvs3g2jD2wuqHajF+7V
 pb4ysUXgWCOKGMOCbg9ZDjm1P1IQa5020zmViDVvhnULGvEUl59e/lZA5EdDXKo0tRsm
 zJdK+Ks3S8sqJrLy6YCOWWjZ6rBqrNrKqswLkhgPwNQHgUDvozGEzlblE5cI6wILRlGV
 2KuNhEWJ3nxowGoF133/IP/khXFEqhdDFejxJstoKhWSy0EfxRzL5HUs8x0EVpcSJNVI
 sLxMi7GZD3BirZjGzLXuMHKlYCbEeWPetlKbqze5FCF8H4FTcazXVyeyRjqgEjGLpPDp
 A48Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfQ0HhDEVlhqBvGXvdbdVdWFKc0cyGcHDuBpfISv9Df5SB3qn7VInykJMSvosv680ZZRG6li23Su6n@nongnu.org
X-Gm-Message-State: AOJu0Yy3qtO8nUnv8Qw5K6BF+c6EyKsBKSwW2Dh/wr8k7gpumtEE/S7G
 NjTm1A4txnLlt9rIAMXu5tByhQem9YvR6KQE2lvjXmLPnkgz8sKFSI7aROr1QVw=
X-Gm-Gg: ASbGnctfFbOD8JGYN5UYznjuMw7rgJ0urtI3iXPTBBX46ZMyMYST4KtQgM3u7ixG1dX
 sgau1WO0LNGnumJRIIozjclYDmzz+TjXgcEoOMlwZYBQ+yyVfayAeUnETRpNmVX5UN3y0tcGKiY
 C3CyL+904rqLztWiTcMRD1F8zsdwfVAryznIGbDLyeHLEcDj3nr9AV/YsMVrP9lAwpf1wZNC2O7
 jiwwYMcpPL+/8aRJwahAArBl/iLqWjPZvuDN0SE6tvKEGRX7q0UTYx/TVh/blpBmC4YEcY0j6Lj
 MN93k9Ygz1Qam2kIPAbRH9Do5eKfRfTBjepXPF8D0OzVi8g+wWB6q3v5sffQC5k4ezlcwxw3Ij6
 4DGWKX3QsEeWYO2eTn3jk3+90
X-Google-Smtp-Source: AGHT+IGpld5BfK8y50mkwHgjXFP9KeALLNdnIz4rwNhmdYh9pdmylf5YqZYhHkY7ACrfBwGnowZL0g==
X-Received: by 2002:a05:6000:2483:b0:39d:724f:a8ae with SMTP id
 ffacd0b85a97d-3a0891b8241mr3331761f8f.33.1745934625394; 
 Tue, 29 Apr 2025 06:50:25 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e345sm14193749f8f.94.2025.04.29.06.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 06:50:24 -0700 (PDT)
Message-ID: <3a9141ba-7916-462e-ac2e-a72f17f0767e@linaro.org>
Date: Tue, 29 Apr 2025 15:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-10-philmd@linaro.org>
 <1f4f420a-0f29-4eae-88e5-0bb100536d63@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1f4f420a-0f29-4eae-88e5-0bb100536d63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/1/25 10:06, Thomas Huth wrote:
> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>> VIRTIO_PCI_FLAG_MIGRATE_EXTRA was only used by the
>> hw_compat_2_4[] array, via the 'migrate-extra=true'
>> property. We removed all machines using that array,
>> lets remove all the code around VIRTIO_PCI_FLAG_MIGRATE_EXTRA.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/virtio/virtio-pci.h |  4 ----
>>   hw/virtio/virtio-pci.c         | 10 ----------
>>   2 files changed, 14 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/ 
>> virtio-pci.h
>> index 971c5fabd44..dd6eb9a4fc7 100644
>> --- a/include/hw/virtio/virtio-pci.h
>> +++ b/include/hw/virtio/virtio-pci.h
>> @@ -32,7 +32,6 @@ DECLARE_OBJ_CHECKERS(VirtioPCIBusState, 
>> VirtioPCIBusClass,
>>   enum {
>>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>> -    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
>>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>>       VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>> @@ -57,9 +56,6 @@ enum {
>>   /* virtio version flags */
>>   #define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << 
>> VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
>> -/* migrate extra state */
>> -#define VIRTIO_PCI_FLAG_MIGRATE_EXTRA (1 << 
>> VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT)
>> -
>>   /* have pio notification for modern device ? */
>>   #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
>>       (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index c773a9130c7..8dca3ae73e6 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -144,13 +144,6 @@ static const VMStateDescription 
>> vmstate_virtio_pci = {
>>       }
>>   };
>> -static bool virtio_pci_has_extra_state(DeviceState *d)
>> -{
>> -    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>> -
>> -    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
>> -}
>> -
>>   static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
>>   {
>>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>> @@ -2352,8 +2345,6 @@ static void virtio_pci_bus_reset_hold(Object 
>> *obj, ResetType type)
>>   static const Property virtio_pci_properties[] = {
>>       DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", 
>> VirtIOPCIProxy, flags,
>>                       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, 
>> false),
>> -    DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
>> -                    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
>>       DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
>>                       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
>>       DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
>> @@ -2601,7 +2592,6 @@ static void 
>> virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>>       k->load_queue = virtio_pci_load_queue;
>>       k->save_extra_state = virtio_pci_save_extra_state;
>>       k->load_extra_state = virtio_pci_load_extra_state;
>> -    k->has_extra_state = virtio_pci_has_extra_state;
> 
> Did you test your patches? Looking at the calling site:
> 
> static bool virtio_extra_state_needed(void *opaque)
> {
>      VirtIODevice *vdev = opaque;
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> 
>      return k->has_extra_state &&
>          k->has_extra_state(qbus->parent);
> }
> 
> ... this will return now false instead of true, so I think your patch 
> here is wrong?

Oops, good catch...



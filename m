Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5892CD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4en-0006Ja-R8; Mon, 01 Dec 2025 09:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4eb-0006I5-Bm
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4eW-0007dm-Ai
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+xYVUnOHnKVt3WC6HyCn4YiTK98PeI0aheG3XdxRJA=;
 b=AmVhZjfuX5En4T+sNV6RduERxcF3RORPYJ4KwBPRKvjKlKAxbJRcuQVAOTHrklYZFbKoc9
 9LttzM0XYfxu3mpCWa7FuoULZgJLE4led4ENkEnqMlWT+JY42QxPZtRYO5ZdLQ+3xZpnFx
 jS+DiENAnga0dKc+Af4cb0mjE/Tn4zs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-nTIBJsk0Nr2yvMRve8m5nQ-1; Mon, 01 Dec 2025 09:13:16 -0500
X-MC-Unique: nTIBJsk0Nr2yvMRve8m5nQ-1
X-Mimecast-MFC-AGG-ID: nTIBJsk0Nr2yvMRve8m5nQ_1764598395
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-297dfae179bso87045475ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764598395; x=1765203195; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+xYVUnOHnKVt3WC6HyCn4YiTK98PeI0aheG3XdxRJA=;
 b=rfJT/WN2c1cxiyHjiSuDApc98RYVs6YXbBC5kplHuiO/fXFOXJKamXjLUJCP0+ksb6
 jQwxEyql3Mhey491rxtHUpFrgy7nobmM1QvLgq0zAMo79/Hpqi5VdCtKft18C+dqqs7R
 AhGIl134MW5fsG03EQJtm0ziWWSI2R2qYyVwqFWzm+GaGznrjn27FjU1bdIyz+Dx+vmb
 ja8yi3U5Qh89fY0iMLL7IXquMTTapw7s+7AzpK7pntwFrpcdSPnIEezJUrB08dB/Xm5n
 ttXacPb8FRfPWuGENXuViga3dpSJHOsJyUE8uPuXz0xsYXhK4e7Wm7G5hVOJ/SnkrbZy
 V7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764598395; x=1765203195;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o+xYVUnOHnKVt3WC6HyCn4YiTK98PeI0aheG3XdxRJA=;
 b=Ay/eoV8ot7TQsNU8I2jrJxOQeG396kzvdo+KpFTDt8+RXW973aEzav16z91zkidvaM
 zVQS9BvEZY2gHSkBNpsiGTjEkX0SQtTehCTfV3hQLisXJrsfJHGvKJnIkaNHZY1VCjyk
 ccSdAQfZCxrpuJTVq07eWS5+rQ17W3zYfMcn3+sIM2lUyW5uWNawVJWgrj1SddHckKM3
 JWMQnA2BwsKiFp2VnIMQwp/dWbe47hVpMU0340/6yap/7MJSFL+O+qXoTVnyi/h806TM
 Q73l+7YYxjL691N2lBd7IozSwNGyxhcVQVlwpuaz4qalwLCyZG5RQZ0IUtOiJeHh4Qhp
 NdeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVExieD1A90MtZ7kEDRxSWZfS5R8wSI4F7fNoyje/irGEMa54+c6ykhY3bMAx9sprWeX9ndcjJVFV7@nongnu.org
X-Gm-Message-State: AOJu0Yzu3MgOagfSaRhDJT+WA6kwLTM4w5njCk6Rbkz5Xa8Xoy937a44
 OjpdPyQs7vEPFQAHxusAStLgvuNHmyme07tph0wlIJg5fRCWB3hVQqkUpRKPWsQymot1oTNfrzn
 f8kUgSfqbjlDig7v8bDDGHHHzLRjBFuhBCBopiXsVpPvyY9d5ZwjLdDW0
X-Gm-Gg: ASbGncvJ8QLxwU6j6qu3yfStxD09uFVYmjlEWmavH3uVwxapWl7WmNUfW7yJUaHC00w
 6Tlw7KDp4idrfiHL6znHpLqQnaCj5YQz4QYtfoQtYc6DZd4IiC58TuG308H8l+DSIoCCqnyQXvB
 oplF4qWk4aHr2h+Ry+yrCZDPwPnTA7bBpn1eeiIYzN9ZWjvl7cx/b+pivfFRv5J6BhcaC8F5bah
 nj7pvWNZFecpyPs+eNVNmKadZD19ZzWIEnO8iVHI+1mvcQ/L3De4WkumcLZaxVtAqSsIf6Oemem
 gIlKK4eJwXhbcJnKo9CkLWsAfAVUwWXNEecnqqvhyG4nDBZKixQH+ls853dDHmdmCntEx/AT9uf
 xncQNs+K7r091hgEwQamKIpxW+m6kpsKezmvsTkkgdk50AR/OHg==
X-Received: by 2002:a17:903:1904:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-29b6bec4726mr383915865ad.19.1764598394870; 
 Mon, 01 Dec 2025 06:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4R0QuwO6y/yeTU4vEGxR3OHAihjViLgk2Gmp/nqvfxe/BAHWL9PfJnlUGC9He6wWUXamjFw==
X-Received: by 2002:a17:903:1904:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-29b6bec4726mr383914985ad.19.1764598393828; 
 Mon, 01 Dec 2025 06:13:13 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb27504sm125763395ad.61.2025.12.01.06.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 06:13:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------XUASwuusH8ii6etp0obdtpr5"
Message-ID: <12b7baee-1d6d-440a-a119-971b47d7f3ad@redhat.com>
Date: Tue, 2 Dec 2025 00:13:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251201131729.615abe68@foz.lan>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251201131729.615abe68@foz.lan>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------XUASwuusH8ii6etp0obdtpr5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 12/1/25 10:17 PM, Mauro Carvalho Chehab wrote:
> On Thu, 27 Nov 2025 10:44:30 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> This series is curved from that for memory error handling improvement
>> [1] based on the received comments, to improve the error object handling
>> in various aspects.
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
>>
>> Gavin Shan (5):
>>    acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>>    acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>>    target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>>    acpi/ghes: Bail early on error from get_ghes_source_offsets()
>>    acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> 
> Patch series look ok on my eyes.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 

Thanks.

> -
> 
> Btw, what setup are you using to test memory errors? It would be
> nice to have it documented somewhere, maybe at
> docs/specs/acpi_hest_ghes.rst.
> 

I don't think docs/specs/acpi_hest_ghes.rst is the right place for that
as it's for specifications. I'm sharing how this is tested here to make
the thread complete.

- Both host and guest has 4KB page size

- Start the guest by the following command lines

   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
   -accel kvm -machine virt,gic-version=host,nvdimm=on,ras=on               \
   -cpu host -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1   \
   -m 4096M,slots=16,maxmem=128G                                            \
   -object memory-backend-ram,id=mem0,size=4096M                            \
   -numa node,nodeid=0,cpus=0-7,memdev=mem0                                 \
   -L /home/gavin/sandbox/qemu.main/build/pc-bios                           \
   -monitor none -serial mon:stdio -nographic                               \
   -gdb tcp::6666 -qmp tcp:localhost:5555,server,wait=off                   \
   -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd   \
   -boot c                                                                  \
   -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                    \
   -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                    \
   -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                    \
      :                                                                     \
   -device pcie-root-port,bus=pcie.0,chassis=16,id=pcie.16                  \
   -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=drive0      \
   -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4  \
   -netdev tap,id=tap1,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
   -device virtio-net-pci,bus=pcie.8,netdev=tap1,mac=52:54:00:f1:26:b0

- Trigger 'victim -d' in the guest

   guest$ ./victim -d
   physical address of (0xffff8d9b7000) = 0x1251d6000
   Hit any key to trigger error:

- Inject error to the GPA. "test.c" is attached

   host$ ./test 0x1251d6000

- Press enter on the guest so that 'victim' continues its execution

   [  435.467481] EDAC MC0: 1 UE unknown on unknown memory ( page:0x1251d6 offset:0x0 grain:1 - APEI location: )
   [  435.467542] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
   [  435.467543] {1}[Hardware Error]: event severity: recoverable
   [  435.467544] {1}[Hardware Error]:  Error 0, type: recoverable
   [  435.467545] {1}[Hardware Error]:   section_type: memory error
   [  435.467546] {1}[Hardware Error]:   physical_address: 0x00000001251d6000
   [  435.467547] {1}[Hardware Error]:   error_type: 0, unknown
   [  435.468380] Memory failure: 0x1251d6: recovery action for dirty LRU page: Recovered
   Bus error (core dumped)

Thanks,
Gavin





> Thanks,
> Mauro
> 

--------------XUASwuusH8ii6etp0obdtpr5
Content-Type: text/x-csrc; charset=UTF-8; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArCi8qCiAqIFRoaXMgdGVzdCBw
cm9ncmFtIHJ1bnMgb24gdGhlIGhvc3QsIHRvIHJlY2VpdmUgR1BBIG91dHB1dGVkIGJ5ICd2
aWN0aW1kJwogKiBmcm9tIHRoZSBndWVzdC4gVGhlIEdQQSBpcyB0cmFuc2xhdGVkIHRvIEhQ
QSwgYW5kIHJlY292ZXJhYmxlIGVycm9yCiAqIGlzIGluamVjdCB0byBIUEEgYXV0b21hdGlj
YWxseS4KICoKICogTk9URTogV2UgaGF2ZSB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSBndWVz
dCBoYXMgb25seSBvbmUgTlVNQSBub2RlIGFuZAogKiB0aGUgbWVtb3J5IGNhcGFjaXR5IGlz
IDRHQi4gVGhlIHRlc3QgcHJvZ3JhbSB3b24ndCB3b3JrIGlmIHRoZSBhc3N1bXB0aW9uCiAq
IGlzIGJyb2tlbi4KICoKICogQXV0aG9yOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29t
PgogKi8KCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRl
IDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNp
bmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDx0aW1lLmg+
CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxzeXMv
c3RhdC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+Cgoj
ZGVmaW5lIFRFU1RfR1VFU1RfTUVNX1NJWkUJMHgxMDAwMDAwMDAJLyogNEdCICovCiNkZWZp
bmUgVEVTVF9HVUVTVF9NRU1fU1RBUlQJMHgwNDAwMDAwMDAJLyogMUdCICovCiNkZWZpbmUg
VEVTVF9JTkpFQ1RfRVJST1JfVFlQRQkweDEwCgpzdHJ1Y3QgdGVzdF9zdHJ1Y3QgewoJaW50
IHBpZDsKCXVuc2lnbmVkIGxvbmcJZ3Vlc3RfbWVtX3NpemU7Cgl1bnNpZ25lZCBsb25nCWdw
YTsKCXVuc2lnbmVkIGxvbmcJaHZhOwoJdW5zaWduZWQgbG9uZwlocGE7Cn07CgpzdGF0aWMg
dm9pZCB1c2FnZSh2b2lkKQp7CglmcHJpbnRmKHN0ZG91dCwgIlxuIik7CglmcHJpbnRmKHN0
ZG91dCwgIi4vdGVzdCA8Z3BhPlxuIik7CglmcHJpbnRmKHN0ZG91dCwgImdwYSAgVGhlIEdQ
QSAoR3Vlc3QgUGh5c2ljYWwgQWRkcmVzcykgd2hlcmUgdGhlIGVycm9yIGlzIGluamVjdGVk
XG4iKTsKCWZwcmludGYoc3Rkb3V0LCAiXG4iKTsKfQoKc3RhdGljIHZvaWQgaW5pdF90ZXN0
X3N0cnVjdChzdHJ1Y3QgdGVzdF9zdHJ1Y3QgKnRlc3QpCnsKCXRlc3QtPnBpZAkJPSAtMTsK
CXRlc3QtPmd1ZXN0X21lbV9zaXplCT0gVEVTVF9HVUVTVF9NRU1fU0laRTsKCXRlc3QtPmdw
YQkJPSAtMVVMOwoJdGVzdC0+aHBhCQk9IC0xVUw7Cn0KCnN0YXRpYyBpbnQgZmV0Y2hfZ3Bh
KHN0cnVjdCB0ZXN0X3N0cnVjdCAqdGVzdCwgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7Cglp
ZiAoYXJnYyAhPSAyKSB7CgkJdXNhZ2UoKTsKCQlyZXR1cm4gLUVJTlZBTDsKCX0KCgl0ZXN0
LT5ncGEgPSBzdHJ0b3VsKGFyZ3ZbMV0sIE5VTEwsIDE2KTsKCWlmICh0ZXN0LT5ncGEgPCBU
RVNUX0dVRVNUX01FTV9TVEFSVCB8fAoJICAgIHRlc3QtPmdwYSA+IChURVNUX0dVRVNUX01F
TV9TVEFSVCArIHRlc3QtPmd1ZXN0X21lbV9zaXplKSkgewoJCWZwcmludGYoc3RkZXJyLCAi
JXM6IEdQQSAweCVseCBvdXQgb2YgcmFuZ2UgWzFHQiwgMUdCKzB4JWx4XVxuIiwKCQkJX19m
dW5jX18sIHRlc3QtPmdwYSwgdGVzdC0+Z3Vlc3RfbWVtX3NpemUpOwoJCXJldHVybiAtRUlO
VkFMOwoJfQoKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IGZpbmRfcWVtdV9waWQoc3RydWN0
IHRlc3Rfc3RydWN0ICp0ZXN0KQp7CglESVIgKmRpcjsKCUZJTEUgKmZwOwoJc3RydWN0IGRp
cmVudCAqZW50cnk7CgljaGFyIHBhdGhbMjU2XSwgZGF0YVsyNTZdOwoJc2l6ZV90IHN6OwoJ
aW50IHJldCA9IC1FTk9ERVY7CgoJZGlyID0gb3BlbmRpcigiL3Byb2MiKTsKCWlmICghZGly
KSB7CgkJZnByaW50ZihzdGRlcnIsICIlczogdW5hYmxlIHRvIG9wZW4gPC9wcm9jPlxuIiwg
X19mdW5jX18pOwoJCXJldHVybiAtRUlPOwoJfQoKCXdoaWxlICgoZW50cnkgPSByZWFkZGly
KGRpcikpICE9IE5VTEwpIHsKCQlpZiAoZW50cnktPmRfdHlwZSAhPSBEVF9ESVIgfHwgZW50
cnktPmRfbmFtZVswXSA9PSAnLicpCgkJCWNvbnRpbnVlOwoKCQltZW1zZXQocGF0aCwgMCwg
c2l6ZW9mKHBhdGgpKTsKCQlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIvcHJvYy8l
cy9jb21tIiwgZW50cnktPmRfbmFtZSk7CgkJZnAgPSBmb3BlbihwYXRoLCAiciIpOwoJCWlm
ICghZnApCgkJCWNvbnRpbnVlOwoKCQltZW1zZXQoZGF0YSwgMCwgc2l6ZW9mKGRhdGEpKTsK
CQlzeiA9IGZyZWFkKGRhdGEsIDEsIHNpemVvZihkYXRhKSwgZnApOwoJCWZjbG9zZShmcCk7
CgkJaWYgKHN6IDw9IDApCgkJCWNvbnRpbnVlOwoKCQlpZiAoc3Ryc3RyKGRhdGEsICJxZW11
IikpIHsKCQkJcmV0ID0gMDsKCQkJdGVzdC0+cGlkID0gYXRvaShlbnRyeS0+ZF9uYW1lKTsK
CQkJYnJlYWs7CgkJfQoJfQoKCWlmIChyZXQgIT0gMCkKCQlmcHJpbnRmKHN0ZGVyciwgIiVz
OiBVbmFibGUgdG8gZmluZCBRRU1VIFBJRFxuIiwgX19mdW5jX18pOwoKCWNsb3NlZGlyKGRp
cik7CglyZXR1cm4gcmV0Owp9CgpzdGF0aWMgaW50IGZldGNoX2h2YShzdHJ1Y3QgdGVzdF9z
dHJ1Y3QgKnRlc3QpCnsKCUZJTEUgKmZwOwoJY2hhciBmaWxlbmFtZVs2NF0sICpkYXRhID0g
TlVMTCwgKm5leHQsICpuZXh0MTsKCXVuc2lnbmVkIGxvbmcgc3RhcnQsIGVuZDsKCXNpemVf
dCBzeiwgbGVuOwoJaW50IHJldCA9IC1FSU87CgoJbWVtc2V0KGZpbGVuYW1lLCAwLCBzaXpl
b2YoZmlsZW5hbWUpKTsKCXNucHJpbnRmKGZpbGVuYW1lLCBzaXplb2YoZmlsZW5hbWUpLCAi
L3Byb2MvJWQvc21hcHMiLCB0ZXN0LT5waWQpOwoJZnAgPSBmb3BlbihmaWxlbmFtZSwgInIi
KTsKCWlmICghZnApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIiVzOiBVbmFibGUgdG8gb3BlbiA8
JXM+XG4iLCBfX2Z1bmNfXywgZmlsZW5hbWUpOwoJCXJldHVybiByZXQ7Cgl9CgoJd2hpbGUg
KChzeiA9IGdldGxpbmUoJmRhdGEsICZsZW4sIGZwKSkgIT0gLTEpIHsKCQlpZiAoIXN0cnN0
cihkYXRhLCAicnctcCIpKQoJCQljb250aW51ZTsKCgkJbmV4dCA9IHN0cmNocihkYXRhLCAn
LScpOwoJCWlmICghbmV4dCkKCQkJY29udGludWU7CgoJCSpuZXh0KysgPSAnXDAnOwoJCW5l
eHQxID0gc3RyY2hyKG5leHQsICcgJyk7CgkJaWYgKCFuZXh0MSkKCQkJY29udGludWU7CgoJ
CSpuZXh0MSA9ICdcMCc7CgkJc3RhcnQgPSBzdHJ0b3VsKGRhdGEsIE5VTEwsIDE2KTsKCQll
bmQgPSBzdHJ0b3VsKG5leHQsIE5VTEwsIDE2KTsKCQlpZiAoZW5kIC0gc3RhcnQgPT0gdGVz
dC0+Z3Vlc3RfbWVtX3NpemUpIHsKCQkJcmV0ID0gMDsKCQkJdGVzdC0+aHZhID0gc3RhcnQg
KyAodGVzdC0+Z3BhIC0gVEVTVF9HVUVTVF9NRU1fU1RBUlQpOwoJCQlicmVhazsKCQl9Cgl9
CgoJaWYgKGRhdGEpCgkJZnJlZShkYXRhKTsKCglmY2xvc2UoZnApOwoJcmV0dXJuIHJldDsK
fQoKc3RhdGljIGludCBmZXRjaF9ocGEoc3RydWN0IHRlc3Rfc3RydWN0ICp0ZXN0KQp7Cglp
bnQgZmQ7Cgl1bnNpZ25lZCBsb25nIHBpbmZvLCBwZ3NpemUgPSBnZXRwYWdlc2l6ZSgpOwoJ
b2ZmX3Qgb2Zmc2V0ID0gKHRlc3QtPmh2YSAvIHBnc2l6ZSkgKiBzaXplb2YocGluZm8pOwoJ
Y2hhciBmaWxlbmFtZVsxMjhdOwoJc3NpemVfdCBzejsKCgltZW1zZXQoZmlsZW5hbWUsIDAs
IHNpemVvZihmaWxlbmFtZSkpOwoJc25wcmludGYoZmlsZW5hbWUsIHNpemVvZihmaWxlbmFt
ZSksICIvcHJvYy8lZC9wYWdlbWFwIiwgdGVzdC0+cGlkKTsKCWZkID0gb3BlbihmaWxlbmFt
ZSwgT19SRE9OTFkpOwoJaWYgKGZkIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiJXM6IFVu
YWJsZSB0byBvcGVuIDwlcz5cbiIsIF9fZnVuY19fLCBmaWxlbmFtZSk7CgkJcmV0dXJuIC1F
SU87Cgl9CgoJc3ogPSBwcmVhZChmZCwgJnBpbmZvLCBzaXplb2YocGluZm8pLCBvZmZzZXQp
OwoJY2xvc2UoZmQpOwoJaWYgKHN6ICE9IHNpemVvZihwaW5mbykpIHsKCQlmcHJpbnRmKHN0
ZGVyciwgIiVzOiBVbmFibGUgdG8gcmVhZCBmcm9tIDwlcz5cbiIsIF9fZnVuY19fLCBmaWxl
bmFtZSk7CgkJcmV0dXJuIC1FSU87Cgl9CgoJaWYgKCEocGluZm8gJiAoMVVMIDw8IDYzKSkp
IHsKCQlmcHJpbnRmKHN0ZGVyciwgIiVzOiBQYWdlIG5vdCBwcmVzZW50XG4iLCBfX2Z1bmNf
Xyk7CgkJcmV0dXJuIC1FSU5WQUw7Cgl9CgoJdGVzdC0+aHBhID0gKChwaW5mbyAmIDB4MDA3
ZmZmZmZmZmZmZmZmZlVMKSAqIHBnc2l6ZSkgKyAodGVzdC0+aHZhICYgKHBnc2l6ZSAtIDEp
KTsKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHdyaXRlX2ZpbGUoY29uc3QgY2hhciAqZmls
ZW5hbWUsIHVuc2lnbmVkIGxvbmcgdmFsKQp7CglpbnQgZmQ7CgljaGFyIGRhdGFbMTI4XTsK
CXNpemVfdCBzejsKCWludCByZXQgPSAwOwoKCW1lbXNldChkYXRhLCAwLCBzaXplb2YoZGF0
YSkpOwoJc3ogPSBzbnByaW50ZihkYXRhLCBzaXplb2YoZGF0YSksICIweCVseCIsIHZhbCk7
CgoJZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1dST05MWSk7CglpZiAoZmQgPCAwKSB7CgkJZnBy
aW50ZihzdGRlcnIsICIlczogVW5hYmxlIHRvIG9wZW4gPCVzPlxuIiwgX19mdW5jX18sIGZp
bGVuYW1lKTsKCQlyZXR1cm4gLUVJTzsKCX0KCglpZiAod3JpdGUoZmQsIGRhdGEsIHN6KSAh
PSBzeikgewoJCXJldCA9IC1FSU87CgkJZnByaW50ZihzdGRlcnIsICIlczogVW5hYmxlIHRv
IHdyaXRlIDwlcz5cbiIsIF9fZnVuY19fLCBmaWxlbmFtZSk7Cgl9CgoJY2xvc2UoZmQpOwoJ
cmV0dXJuIHJldDsKfQoKc3RhdGljIGludCBpbmplY3RfZXJyb3Ioc3RydWN0IHRlc3Rfc3Ry
dWN0ICp0ZXN0KQp7CglmcHJpbnRmKHN0ZG91dCwgInBpZDoJJWRcbiIsIHRlc3QtPnBpZCk7
CglmcHJpbnRmKHN0ZG91dCwgImdwYToJMHglbHhcbiIsIHRlc3QtPmdwYSk7CglmcHJpbnRm
KHN0ZG91dCwgImh2YToJMHglbHhcbiIsIHRlc3QtPmh2YSk7CglmcHJpbnRmKHN0ZG91dCwg
ImhwYToJMHglbHhcbiIsIHRlc3QtPmhwYSk7CgoJc3lzdGVtKCJtb2Rwcm9iZSBlaW5qID4g
L2Rldi9udWxsIik7CglpZiAod3JpdGVfZmlsZSgiL3N5cy9rZXJuZWwvZGVidWcvYXBlaS9l
aW5qL3BhcmFtMSIsCQl0ZXN0LT5ocGEpIAkJfHwKCSAgICB3cml0ZV9maWxlKCIvc3lzL2tl
cm5lbC9kZWJ1Zy9hcGVpL2VpbmovcGFyYW0yIiwJCTB4ZmZmZmZmZmZmZmZmZjAwMCkJfHwK
CSAgICB3cml0ZV9maWxlKCIvc3lzL2tlcm5lbC9kZWJ1Zy9hcGVpL2VpbmovZmxhZ3MiLAkJ
MHgwKQkJCXx8CgkgICAgd3JpdGVfZmlsZSgiL3N5cy9rZXJuZWwvZGVidWcvYXBlaS9laW5q
L2Vycm9yX3R5cGUiLAlURVNUX0lOSkVDVF9FUlJPUl9UWVBFKQl8fAoJICAgIHdyaXRlX2Zp
bGUoIi9zeXMva2VybmVsL2RlYnVnL2FwZWkvZWluai9ub3RyaWdnZXIiLAkJMSkJCQl8fAoJ
ICAgIHdyaXRlX2ZpbGUoIi9zeXMva2VybmVsL2RlYnVnL2FwZWkvZWluai9lcnJvcl9pbmpl
Y3QiLAkxKSkKCQlyZXR1cm4gLUVJTzsKCglyZXR1cm4gMDsKfQoKaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQp7CglzdHJ1Y3QgdGVzdF9zdHJ1Y3QgdGVzdDsKCWludCByZXQ7
CgoJaW5pdF90ZXN0X3N0cnVjdCgmdGVzdCk7CgoJaWYgKGZldGNoX2dwYSgmdGVzdCwgYXJn
YywgYXJndikgfHwKCSAgICBmaW5kX3FlbXVfcGlkKCZ0ZXN0KQkgfHwKCSAgICBmZXRjaF9o
dmEoJnRlc3QpCQkgfHwKCSAgICBmZXRjaF9ocGEoJnRlc3QpCQkgfHwKCSAgICBpbmplY3Rf
ZXJyb3IoJnRlc3QpKQoJCXJldHVybiAtRUlPOwoKCXJldHVybiAwOwp9Cg==

--------------XUASwuusH8ii6etp0obdtpr5--



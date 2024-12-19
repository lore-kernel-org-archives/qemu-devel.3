Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3724E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO41t-0004JT-0L; Wed, 18 Dec 2024 19:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tO41r-0004JL-Km
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tO41p-0001hA-9f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734566671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zs/8PZ7s0TrbD0K8RPpgL4zgfAiY2pEURdyE0lU0D/o=;
 b=ZWo+poCuET8oRyW0MQaUTwkM+abGn+96W/2D8g98xDD+GrTdrjltOYPU7Hdtg7HnaGq5Ym
 84A4mwbn3E+Zo6J0rQY4Syuh+gtzPaG0SA2FCfvPh0Ex21lc3cZOo/DiSwHq8zOCxHKrcA
 8LMtRr3CbWtOacelzII1aynkbLzOeNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-S6sEYy_-NNW6Lfd0bnTdcA-1; Wed, 18 Dec 2024 19:04:29 -0500
X-MC-Unique: S6sEYy_-NNW6Lfd0bnTdcA-1
X-Mimecast-MFC-AGG-ID: S6sEYy_-NNW6Lfd0bnTdcA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso994745e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 16:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734566668; x=1735171468;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zs/8PZ7s0TrbD0K8RPpgL4zgfAiY2pEURdyE0lU0D/o=;
 b=jtgHkmCjIkryltBOvzdD028DiBwiGLsyRs17GpQnEHDzonvtmXCMJALYWBTiHo1yul
 zBPfAMjKJADT23eOs3Hx6zsV1+51cSLTspydnDzvH4hyV2DJgUpmr1jIY72piQ76jNC0
 kYvQmIuij5iOniDZk7XJnv1oep2xZPzIQNvL7h/MYC6l+KU2chjPhvErwyzFfFA9ToJK
 mZdjAk6m7s+PwCqqW0oRtyFo3bMAJTKRx4Wk4KHZg4+aWp1+TD+usKhIc1uDLYhFGRsu
 iSBYOfQKznC2PtyxIXkZwjLi9s3lLJmxr8n5Sl7T/uDirsVv7muMnhg3s9yLoj3EnXhs
 bWEA==
X-Gm-Message-State: AOJu0Yy5z4VaJ+b3ZWf23ttL80VABi4qhwrAJHR1g8oLXrQit2n+AFAB
 5JsrZNMW/eXpwidCS88fbKtBMlo2gGsnv8Jaccv8N/eIz4EaR2KcjC57whHFSYuLgjnxkH685mt
 j+U8BwDLKqRFym8x/nZlCN/4e2jWE/BUQRjgwxvZqC5dNjT/CVGXO
X-Gm-Gg: ASbGncsMlKPRDabBQ+DDKsEY8gJ4dpbPR7iEqz9V+Xr7FzsU4wltCqU+ksgc+Ob7nq5
 YgCehKCfl8oCyQ/f7IZPBxyMvJXNJfq/Fw1d29ULF255uVv0SGykSfc68ipF7vG+GXQlpLYnsGk
 wkQCkrMEGcHXRvvnD5qI/4vbKi2TB8N0fSbYMLAprSXJYAzektYslhWK9stKvEOvjTLAk1yNYXa
 tvbGp7tfud/sKiAzFtWsjLrV3WFBI/E3Gy/kUHikzUlp9LpIpLN2A69+gknwXKsp/18jw0H1IEf
 JVZNniK4QrVH3Tia8Vqyrb2qAE9UKx8WP/VIMD+PZwt5FND8u/ZSKBSbzhGXXN/oGdrKJ0jW21E
 DJmqg2jbl
X-Received: by 2002:a05:600c:3b88:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4365c77e436mr10490255e9.3.1734566668406; 
 Wed, 18 Dec 2024 16:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExUW2B5vAD9HsaUBcW1SPW7UNOxk8sLdsFxwV7dT1rxaefKKYKlKcLPf5+7vl/PhXNKCpYQQ==
X-Received: by 2002:a05:600c:3b88:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4365c77e436mr10490055e9.3.1734566668010; 
 Wed, 18 Dec 2024 16:04:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c73f:8300:a5d5:c21b:add3:cf50?
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm494055e9.14.2024.12.18.16.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:04:27 -0800 (PST)
Message-ID: <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
Date: Thu, 19 Dec 2024 01:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
 <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 18.12.24 22:09, Stefan Hajnoczi wrote:
> On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com> wrote:
>>
>> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
>>
>>    Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/davidhildenbrand/qemu.git tags/mem-2024-12-18
>>
>> for you to fetch changes up to eb5c5f1ab479e9311d8e513e3eeafaf30f2b25b3:
>>
>>    s390x: virtio-mem support (2024-12-18 09:50:05 +0100)
>>
>> ----------------------------------------------------------------
>> Hi,
>>
>> "Host Memory Backends" and "Memory devices" queue ("mem"):
>> - Fixup handling of virtio-mem unplug during system resets, as
>>    preparation for s390x support (especially kdump in the Linux guest)
>> - virtio-mem support for s390x
>>
>> ----------------------------------------------------------------
>> David Hildenbrand (15):
>>        virtio-mem: unplug memory only during system resets, not device resets
>>        s390x/s390-virtio-ccw: don't crash on weird RAM sizes
>>        s390x/s390-virtio-hcall: remove hypercall registration mechanism
>>        s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
>>        s390x: rename s390-virtio-hcall* to s390-hypercall*
>>        s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to machine code
>>        s390x: introduce s390_get_memory_limit()
>>        s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
>>        s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory layouts
>>        s390x/s390-skeys: prepare for memory devices
>>        s390x/s390-virtio-ccw: prepare for memory devices
>>        s390x/pv: prepare for memory devices
>>        s390x: remember the maximum page size
>>        s390x/virtio-ccw: add support for virtio based memory devices
>>        s390x: virtio-mem support
> 
> Please take a look at the following s390x-related CI failures:

Thanks, most of them seem related to this PULL.


> https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
> https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
> https://gitlab.com/qemu-project/qemu/-/jobs/8679972931

../hw/s390x/s390-virtio-ccw.c: In function ‘s390_set_memory_limit’:
../hw/s390x/s390-virtio-ccw.c:138:9: error: ‘hw_limit’ may be used uninitialized [-Werror=maybe-uninitialized]
   138 |         error_report("host supports a maximum of %" PRIu64 " GB",
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   139 |                      hw_limit / GiB);
       |                      ~~~~~~~~~~~~~~~
../hw/s390x/s390-virtio-ccw.c:130:14: note: ‘hw_limit’ declared here
   130 |     uint64_t hw_limit;
       |              ^~~~~~~~

Looks weird. Without kvm_enabled() ret = 0, so ret cannot be
-E2BIG and consequently that code won't be executed.

Anyhow, I'll simply initialize hw_limit to 0 to silence the warning.


> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8679972861

/usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-skeys.c.o: in function `qemu_s390_enable_skeys':
/builds/qemu-project/qemu/build/../hw/s390x/s390-skeys.c:256: undefined reference to `s390_get_memory_limit'
/usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_virtio_ccw_notify':
/builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:46: undefined reference to `virtio_ccw_get_vdev'
/usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:47: undefined reference to `virtio_queue_get_num'
/usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:56: undefined reference to `virtio_queue_notify'
/usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_storage_limit':
/builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:64: undefined reference to `s390_get_memory_limit'
/usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_virtio_ccw_notify':
/builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52: undefined reference to `virtio_get_queue'
/usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52: undefined reference to `virtio_queue_set_shadow_avail_idx'

We're building with "--without-default-devices' '--without-default-feature".
Consequently, we won't even have CONFIG_S390_CCW_VIRTIO

So we won't compile s390-virtio-ccw.c, but we will compile things like s390-stattrib.c,
s390-hypercall.c, ... which to me is extremely odd.

Is this maybe a leftover from the time when we had the old machine type? What value
is it to compile all these files without even having a machine that could make use
of these?

So I wonder if most of these files should actually only be compiled with
CONFIG_S390_CCW_VIRTIO, which is the only machine we have.


> https://gitlab.com/qemu-project/qemu/-/jobs/8679972894

  98/976 ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0) ERROR
...
――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
Traceback (most recent call last):
   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
     dump.read(dump_memory = args.memory)
   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
     section.read()
   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
     field['data'] = reader(field, self.file)
   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
     for field in self.desc['struct']['fields']:
KeyError: 'fields'
warning: fd: migration to a file is deprecated. Use file: instead.
warning: fd: migration to a file is deprecated. Use file: instead.
**
ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0)
(test program exited with status code -6)


Cannot reproduce it so far, will try again tomorrow.


-- 
Cheers,

David / dhildenb



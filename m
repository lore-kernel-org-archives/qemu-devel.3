Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60BDCDD0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 19:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3KHX-0004KO-4Y; Tue, 22 Oct 2024 15:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3KHV-0004Jr-EK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3KHT-0006kl-IE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729624256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wzU1OjjL+rBsUWzsdfeVoUpGiqB9h6nIlRDvW9bCFLA=;
 b=MqGnJnVnly9Jybb4iCz0lKkc52vw4ZkjC3qr4W4+l3Ydxu2cxjkOdMvRVxWyAv+co6Mbiv
 63iWCF1nLV0LMUrpkDsE83kSmrg8igpPpAlVRYRX0KILBjFNpk0K9JqndPoZfIVy8n3z5Z
 G+Nmvc/byJjlM1vtFKQSyEF2Zrfgz7c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-YI1grskhMBijPVWZUJUHDw-1; Tue, 22 Oct 2024 15:10:54 -0400
X-MC-Unique: YI1grskhMBijPVWZUJUHDw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso22937195e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 12:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729624253; x=1730229053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzU1OjjL+rBsUWzsdfeVoUpGiqB9h6nIlRDvW9bCFLA=;
 b=H/agErYc+OnSKZARhXbQ+kLjxUq3bxACQqWGG8jJPCRQf9rtd8Zz4fJ0TUpF6/pcHE
 eI/vid2d0Gz6RnGlak5iTv/cN+qiypPXSrbfp+NYOfuK83cZ57g5vfFQRpzn7aJypDiP
 JqqU0siMffi6XQylekBFbs9uLi1xZHlvrEISBjmLue3Nl0P+HlPxt15iiZ+WMeL8Y+ia
 zJfZ+SlNyia9NuibuT3uu51gsUOJ0Fmj5odldWAuh8MoMSU6Kt1rAyCtbdsPCnVWlpVk
 HGAwBjOOVWDjpD1a5e3WG2ux7To7aJW2gD5yq9M15nfawZlyPPlJFCDMxVfJt2Qts1tZ
 QrQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7+5lq0QhYzcd5CTq5h9zGqM2+jZlz06zGqfADavZi+ct5V50mQO9tYJi/oGeSyPTwSZ+ozR/tzDY@nongnu.org
X-Gm-Message-State: AOJu0YzX+RFrxVZEt3Jqu5xipLv/ZOIyUlDRlQDQZ7ynNXHx9avuFnIS
 fbXmtWaZjD6A9bsEKrULIpJeQihsgtYh4kWzYr/emjGacTE6EbgCPRYfOq0prf5K3r7PAfk83Zf
 B7T6vENM+88bZdsOkwJHrvzIUK1fWggrkE1Uah8QwfwVWYPdgVbf+
X-Received: by 2002:a05:600c:3b90:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-431841fdca7mr1794495e9.10.1729624253280; 
 Tue, 22 Oct 2024 12:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVcQ0sm5S0wOZoCZ4pFAWnxA8V8WJ69PnF49S6fSyBvCUKXvdJhoJl2oHIIrNCdHvPIo+22A==
X-Received: by 2002:a05:600c:3b90:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-431841fdca7mr1794375e9.10.1729624252925; 
 Tue, 22 Oct 2024 12:10:52 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de.
 [109.40.241.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc53fsm95075085e9.47.2024.10.22.12.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 12:10:52 -0700 (PDT)
Message-ID: <cae8193d-6693-45d7-959f-eef536ec4589@redhat.com>
Date: Tue, 22 Oct 2024 21:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/17] crypto/hash: Implement and use new hash API
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: Kunwu <chentao@kylinos.cn>
References: <20241010162024.988284-1-berrange@redhat.com>
 <20241010162024.988284-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241010162024.988284-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/10/2024 18.20, Daniel P. Berrangé wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Changes the public hash API implementation to support accumulative hashing.
> 
> Implementations for the public functions are added to call the new
> driver functions that implement context creation, updating,
> finalization, and destruction.
> 
> Additionally changes the "shortcut" functions to use these 4 new core
> functions.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Reworked qcrypto_hash_bytesv() error handling
>         - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free()
>           qcrypto_hash_updatev()
>         - Introduced qcrypto_hash_supports() check in
>           qcrypto_hash_new()
>         - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
>           and qcrypto_hash_finalize_base64()
>         - Re-arrranged code in qcrypto_hash_digestv() and
>           qcrypto_hash_digest()
>         - Checkpatch fixes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/hash.c | 161 ++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 131 insertions(+), 30 deletions(-)

  Hi,

something recently broke qemu-iotest 081 in raw mode and bisecting it 
pointed me to this commit here.

cd tests/qemu-iotests/ ; ./check -raw 081 ; cd ../../
[...]
081   fail       [21:07:40] [21:07:42]   1.4s   (last: 1.4s)  output 
mismatch (see 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/raw-file-081/081.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/081.out
+++ 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/raw-file-081/081.out.bad
@@ -31,7 +31,6 @@
  {"return": {}}
  {"return": {}}
  {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": 
"QUORUM_REPORT_BAD", "data": {"node-name": "drive2", "sectors-count": 20480, 
"sector-num": 0, "type": "read"}}
  read 10485760/10485760 bytes at offset 0
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  {"return": ""}
@@ -44,6 +43,7 @@
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  == checking that quorum has corrected the corrupted file ==
+Pattern verification failed at offset 0, 10485760 bytes
  read 10485760/10485760 bytes at offset 0
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

@@ -63,7 +63,6 @@
      } -device virtio-scsi,id=scsi -device 
scsi-hd,id=quorum-drive,bus=scsi.0,drive=quorum
  QMP_VERSION
  {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": 
"QUORUM_REPORT_BAD", "data": {"node-name": "file2", "sectors-count": 20480, 
"sector-num": 0, "type": "read"}}
  read 10485760/10485760 bytes at offset 0
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  {"return": ""}
@@ -71,6 +70,7 @@
  {"return": {}}

  -- checking that the image has been corrected --
+Pattern verification failed at offset 0, 10485760 bytes
  read 10485760/10485760 bytes at offset 0
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

@@ -81,7 +81,9 @@
  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  == checking that quorum is broken ==
-read failed: Input/output error
+Pattern verification failed at offset 0, 10485760 bytes
+read 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  == checking the blkverify mode with broken content ==
  quorum: offset=0 bytes=10485760 contents mismatch at offset 0
Failures: 081
Failed 1 of 1 iotests

Could you please have a look?

  Thanks,
   Thomas



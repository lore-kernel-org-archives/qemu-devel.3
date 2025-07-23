Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E76C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uecUi-0007rG-OC; Wed, 23 Jul 2025 12:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uecUh-0007lb-59
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uecUd-0005N8-F5
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753288736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f2votMLy6kkZ5teiaYCq5PpFzCEyr1Z5HnQCdqW9CIE=;
 b=jEf2EhpgOZAsXh/+XTUuaYxkSy3rsIkbZpNa+xy3uckME0wJsi5Y7CMPcKTViyu8VW8lo8
 3OYPeldUQ83p+uzDoPKJrTGtTOXBIiR2QqBzjArg9nSZ2M7qS+uNvxn7OPqPY3Hy2Ohvj+
 GPjZD5Mj+ChNc4aMW+eZln58bkkYC8s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-yrr3_t1IPjK2yV_da1YgyA-1; Wed, 23 Jul 2025 12:38:49 -0400
X-MC-Unique: yrr3_t1IPjK2yV_da1YgyA-1
X-Mimecast-MFC-AGG-ID: yrr3_t1IPjK2yV_da1YgyA_1753288728
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae6f9b15604so1728866b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753288728; x=1753893528;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2votMLy6kkZ5teiaYCq5PpFzCEyr1Z5HnQCdqW9CIE=;
 b=mk1cEAXbCzyWntagXSDwuujENSFsDcIOrvhG3zay+NoPkfso9cY0gcHHs3uOxS7MtP
 IubcEAjWN/3l5XR6uJr9jLQKWjhBfv11YAb71yeaGoaZTmo0XN059Fexp7Frgr9k9McQ
 P4xdcQPfpemiPUfm/SN0FpXmBldP6YBBd8fPOCtgQ4ZvNvOKP0ddBsYdU2qq69zgu8yB
 nNgX9RK/+GXdSdva8yuX0QZ19cUsFJrm0izeTTrYumq2kqGpD04Uz+Xj1FGqWUmFKYHI
 oR16A4Bvr80d3lZ2atNE2bpfdL9mExY2jn7drmXlLXyGWfrVdn5kwVxfiauJ/lkpU+Kd
 o0mQ==
X-Gm-Message-State: AOJu0YwCZGRe2P83H9HtrdMLWtXNQSQ3GE9Gnh0uVUiwmvHtddE74Ju1
 yKSs3y1XfgG84T5PCHAeMVJJ+mLq3Do0XKYTGIlbI9ftyNrs48swAh9orfVugz8x/BE7Fld7b6U
 ZDZnlFo/ZUoJ10hfxfsK1QjNdw5rNBQouz194O/Nt1DJdN+nx4tTSe8G7
X-Gm-Gg: ASbGncvtfggBWJ2VswUXkocvcxNw7RoRUBPs+6sSvZ5FzUqTxMrdRDAjlMJ5MxlX/jc
 zfrDqIH4SZFiTmolUxlQ3CFVccTDlaqBTku81XUpTPYsxU/plQnfBsi3lYMHAsWLHYv1Iv79LHv
 vDaNR5AfnTs1d05A5q77E0qD1+u1P9HQkC8h/ivF60GdYCOQCz17YdnMDmGmlSnOYexAj8elKZ7
 lNd6nytyCBpklCXcmbCpci9Vyd45ev10eCGLFQEwnMeIzns7bQ0kMNx8GEqzzhNZpi4glCYObIq
 Rqaa/5HIbKJamGnls+gvXzn1Fa90cTafWC9//c+Wk5K0/ztkayUuhQgjLA8MoOcvcp9Ybaa4jDY
 =
X-Received: by 2002:a17:907:980d:b0:ae3:595f:91a0 with SMTP id
 a640c23a62f3a-af2f6d1c4cemr432112366b.16.1753288727795; 
 Wed, 23 Jul 2025 09:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtF4N50asOCaCOQSl6JGLUC8OGIphPan2FG1SScMMAYrFWN++Str1Z2JDAzcWQNYIFc/J1A==
X-Received: by 2002:a17:907:980d:b0:ae3:595f:91a0 with SMTP id
 a640c23a62f3a-af2f6d1c4cemr432109666b.16.1753288727246; 
 Wed, 23 Jul 2025 09:38:47 -0700 (PDT)
Received: from [10.45.152.123] (93-41-67-218.ip80.fastwebnet.it.
 [93.41.67.218]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aec6ca7d2dasm1075454766b.127.2025.07.23.09.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 09:38:46 -0700 (PDT)
Message-ID: <ed3009be-8707-4340-a8ee-2523f77fe861@redhat.com>
Date: Wed, 23 Jul 2025 18:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qos-test is annoyingly noisy
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <87o6tbnfqx.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87o6tbnfqx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/23/25 16:28, Markus Armbruster wrote:
> Noise starting with "stdout: " has been polluting output of "make check"
> for a while.  I traced it to qos-test.  Output of "make
> check-qtest-aarch64" appended as an example.
> 
> Blessed silence if I revert commit 30ea13e9d97d (tests/qtest: use
> qos_printf instead of g_test_message).
> 
> Alex, what shall we do here?

What is printing "stdout:", is it glib?  I think glib should be using 
g_test_message() to do those "stdout:" prints. But I agree a more 
practical alternative is a revert.

Paolo

> 
> 
> 
> make: Entering directory '/work/armbru/qemu/bld'
> [1/8] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
> /work/armbru/qemu/bld/pyvenv/bin/meson test  --no-rebuild -t 1  --num-processes 14 --print-errorlogs  --suite qtest-aarch64
>   1/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/cdrom-test                        SKIP             0.11s
>   2/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test         SKIP             0.05s   0 subtests passed
>   3/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-test               OK               0.28s   5 subtests passed
>   4/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/bcm2835-dma-test                  OK               0.25s   1 subtests passed
>   5/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/fuzz-xlnx-dp-test                 OK               0.59s   1 subtests passed
>   6/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/bcm2835-i2c-test                  OK               0.38s   3 subtests passed
>   7/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/boot-serial-test                  OK               0.85s   1 subtests passed
>   8/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-versal-trng-test             OK               1.06s   5 subtests passed
>   9/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-i2c-test                  OK               1.39s   6 subtests passed
> 10/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/cxl-test                          OK               0.39s   1 subtests passed
> 11/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-gpio-test                 OK               1.60s   2 subtests passed
> 12/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/npcm_gmac-test                    OK               1.47s   4 subtests passed
> 13/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test                   OK               2.79s   3 subtests passed
> 14/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/machine-none-test                 OK               0.31s   1 subtests passed
> 15/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-can-test                     OK               3.04s   5 subtests passed
> 16/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-smc-test                  OK               2.30s   8 subtests passed
> 17/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/vnc-display-test                  OK               0.23s   1 subtests passed
> 18/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/readconfig-test                   OK               0.45s   2 subtests passed
> 19/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/arm-cpu-features                  OK               1.58s   3 subtests passed
> 20/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/qmp-test                          OK               0.94s   4 subtests passed
> 21/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/numa-test                         OK               1.67s   5 subtests passed
> 22/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-hace-test                 OK               5.64s   11 subtests passed
> 23/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/netdev-socket                     OK               4.82s   10 subtests passed
> 24/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test            OK               8.26s   6 subtests passed
> 25/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/qmp-cmd-test                      OK              13.96s   66 subtests passed
> 26/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test                    OK              24.48s   9 subtests passed
> 27/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/qos-test                          OK              36.70s   128 subtests passed
> 
> stdout: 138: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 139: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 140: UNKNOWN:     # # set_owner: start of session
> stdout: 141: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 142: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 143: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 144: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 145: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 146: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 147: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 148: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 149: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 150: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 151: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 152: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 153: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 154: UNKNOWN:     # # set_vring_addr: 0x7f9060000000/0x7f905ffff000/0x7f9060001000
> stdout: 156: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 157: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 158: UNKNOWN:     # # set_owner: start of session
> stdout: 159: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 160: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 161: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 162: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 163: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 164: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 165: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 166: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 167: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 168: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 169: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 170: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 171: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 172: UNKNOWN:     # # set_vring_addr: 0x7f1834000000/0x7f1833fff000/0x7f1834001000
> stdout: 175: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 176: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 177: UNKNOWN:     # # set_owner: start of session
> stdout: 178: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 179: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 180: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 181: UNKNOWN:     # # set_owner: start of session
> stdout: 182: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 183: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 184: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 185: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 186: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 187: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 188: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 189: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 190: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 191: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 192: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 193: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 194: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 195: UNKNOWN:     # # set_vring_addr: 0x7fba24000000/0x7fba23fff000/0x7fba24001000
> stdout: 196: UNKNOWN:     # # set_vring_num: 1/256
> stdout: 197: UNKNOWN:     # # set_vring_addr: 0x7fba24003000/0x7fba24002000/0x7fba24004000
> stdout: 200: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 201: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 202: UNKNOWN:     # # set_owner: start of session
> stdout: 203: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 204: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 205: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 206: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 207: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 208: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 209: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 210: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 211: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 212: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 213: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 214: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 215: UNKNOWN:     # # set_owner: start of session
> stdout: 216: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 217: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 218: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 219: UNKNOWN:     # # set_owner: start of session
> stdout: 220: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 221: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 222: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 223: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 224: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 227: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 228: UNKNOWN:     # # set_protocol_features: 0x43
> stdout: 229: UNKNOWN:     # # set_owner: start of session
> stdout: 230: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 231: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 232: UNKNOWN:     # # set_protocol_features: 0x43
> stdout: 233: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 234: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 235: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 236: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 237: UNKNOWN:     # # set_vring(2)=disabled
> stdout: 238: UNKNOWN:     # # set_vring(3)=disabled
> stdout: 239: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 240: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 241: UNKNOWN:     # # set_vring(2)=disabled
> stdout: 242: UNKNOWN:     # # set_vring(3)=disabled
> stdout: 243: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 244: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 245: UNKNOWN:     # # set_vring(2)=disabled
> stdout: 246: UNKNOWN:     # # set_vring(3)=disabled
> stdout: 247: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 248: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 249: UNKNOWN:     # # set_vring(2)=disabled
> stdout: 250: UNKNOWN:     # # set_vring(3)=disabled
> stdout: 251: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 252: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 253: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 254: UNKNOWN:     # # set_vring_addr: 0x7f46e0000000/0x7f46dffff000/0x7f46e0001000
> stdout: 255: UNKNOWN:     # # set_vring_num: 1/256
> stdout: 256: UNKNOWN:     # # set_vring_addr: 0x7f46e0003000/0x7f46e0002000/0x7f46e0004000
> stdout: 257: UNKNOWN:     # # set_vring_num: 2/256
> stdout: 258: UNKNOWN:     # # set_vring_addr: 0x7f46e0006000/0x7f46e0005000/0x7f46e0007000
> stdout: 259: UNKNOWN:     # # set_vring_num: 3/256
> stdout: 260: UNKNOWN:     # # set_vring_addr: 0x7f46e0009000/0x7f46e0008000/0x7f46e000a000
> stdout: 264: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 265: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 266: UNKNOWN:     # # set_owner: start of session
> stdout: 267: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 268: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 269: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 270: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 271: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 272: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 273: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 274: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 275: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 276: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 277: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 278: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 279: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 280: UNKNOWN:     # # set_vring_addr: 0x7f0550000000/0x7f054ffff000/0x7f0550001000
> stdout: 283: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 284: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 285: UNKNOWN:     # # set_owner: start of session
> stdout: 286: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 287: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 288: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 289: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 290: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 291: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 292: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 293: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 294: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 295: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 296: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 297: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 298: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 300: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 301: UNKNOWN:     # # set_protocol_features: 0x42
> stdout: 302: UNKNOWN:     # # set_owner: start of session
> stdout: 303: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 304: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 305: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 306: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 307: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 308: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 309: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 310: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 311: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 312: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 313: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 314: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 315: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 316: UNKNOWN:     # # set_vring_addr: 0x7fbd00000000/0x7fbcfffff000/0x7fbd00001000
> stdout: 431: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 432: UNKNOWN:     # # set_protocol_features: 0x200
> stdout: 433: UNKNOWN:     # # set_owner: start of session
> stdout: 434: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 435: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 436: UNKNOWN:     # # set_vring_num: 0/64
> stdout: 437: UNKNOWN:     # # set_vring_addr: 0x7f13bffff400/0x7f13bffff000/0x7f13c0000000
> stdout: 438: UNKNOWN:     # # set_vring_num: 1/64
> stdout: 439: UNKNOWN:     # # set_vring_addr: 0x7f13c0001400/0x7f13c0001000/0x7f13c0002000
> stdout: 440: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 441: UNKNOWN:     # # set_vring(1)=enabled
> stdout: 454: UNKNOWN:     # # qos_test running single test in subprocess
> stdout: 455: UNKNOWN:     # # set_protocol_features: 0x1
> stdout: 456: UNKNOWN:     # # set_owner: start of session
> stdout: 457: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 458: UNKNOWN:     # # vhost-user: un-handled message: 14
> stdout: 459: UNKNOWN:     # # set_vring_num: 0/256
> stdout: 460: UNKNOWN:     # # set_vring_addr: 0x7f4dcc000000/0x7f4dcbfff000/0x7f4dcc001000
> stdout: 461: UNKNOWN:     # # set_vring_num: 1/256
> stdout: 462: UNKNOWN:     # # set_vring_addr: 0x7f4dcc003000/0x7f4dcc002000/0x7f4dcc004000
> stdout: 463: UNKNOWN:     # # set_vring(0)=enabled
> stdout: 464: UNKNOWN:     # # set_vring(1)=enabled
> Unknown TAP output lines have been ignored. Please open a feature request to
> implement them, or prefix them with a # if they are not TAP syntax.
> 
> 28/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp                          OK              65.95s   94 subtests passed
> 29/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test                  OK              72.73s   12 subtests passed
> 30/30 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                          OK             773.17s   93 subtests passed
> 
> Ok:                 28
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            2
> Timeout:            0
> 
> Full log written to /work/armbru/qemu/bld/meson-logs/testlog.txt
> make: Leaving directory '/work/armbru/qemu/bld'
> 
> 
> 



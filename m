Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC9DC0219B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 00:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti0fT-0003ya-PP; Tue, 11 Feb 2025 19:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti0fQ-0003yE-7C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti0fN-0003kA-JK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739320305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XDTxujAkJJd3lvFnCBgx6j6dSG+qahwnnte41k2vcwA=;
 b=Qi7aJLzFyOtVL7b6ecqbZKMuQgcexPFoprSkciH2Qr3+m/RVoz2H25kyHsVH6szCMhESln
 HYCbxylz/OYP94c24xxxVBlnsZGGTXJ5pjuvVlA4zOKwpAvkEqxz/guFa3+4j4HCPB5xi/
 Kc8Tk/wCzM/g9bGnseHAdXLumJBgdD0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Mj4pj-yAPE2ea8tj24-ykw-1; Tue, 11 Feb 2025 19:31:43 -0500
X-MC-Unique: Mj4pj-yAPE2ea8tj24-ykw-1
X-Mimecast-MFC-AGG-ID: Mj4pj-yAPE2ea8tj24-ykw_1739320302
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so13112305e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 16:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739320302; x=1739925102;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDTxujAkJJd3lvFnCBgx6j6dSG+qahwnnte41k2vcwA=;
 b=kT53i71dyi1CkMaO5JY3eoTcHuDJEXMr4o1R5j50n+wLRO4i1RwjadDNF3ULMmE9GG
 mWHTF0KllLCB7tr9+k4SwVuffkKgV+HqXFPMywgzzM8eMVm+q+xpXDFQs8u8Ri9Ilux+
 B7sKCPxZBQ7zihj2HhvE0Sielw3Bk9ax++XgQXE+eP102F3ZDy+SXbDL0ppMdlenmFKH
 H3yTtUHhUoPE9ShQ9epObaH22/JSQe5/v8C83VIOjU1MhsJg6yGiPL3JsGPRL536l0As
 G7amcuDNHMRoVkivHDXDXxbVddiqIvmyZga0MLpdNYvs7LM1hrAY8Kt5IuWmdJttEzHJ
 pmOA==
X-Gm-Message-State: AOJu0YyTL8/N/axXeu+noTSxrviWwfB1/KX7S+13oqdDTidoogjBT3Y8
 k/CaoMgfb8+DG5FfJHWHQWAgeHUz0q0gptWLoyVeNAQKrvDnxUU81uj+BDxeHS1EtQeLAszUzKZ
 I2Z7PhGi0qje8Zpn0CAfQFjInyQUMz5v9TcoQ1RHzaEfLk6yIULss
X-Gm-Gg: ASbGncu8sAB7qcJmh7+Mzqea1gQo86WSDwAIODv/dlQupqNEIyIo8DVw+L4Os6coiAf
 KSr7EesQ4FvqrFKgH49SgK6D103vqaDAvQxAiC+7Oy+EgI6ktkD0Ex/cbLonLAWpA28UKzUSi2N
 JqODf2ki8M2gCe0JtDP/NxAujSksejKUtrVXY7gYV4FraoSO0tc9HMEMtKRje/yL+FAuC6x+ecu
 lO8eP1kf5iI5bozkTsPXZXQEg/hMwC+ey32p8S9RF2qjlXft4jZWrgUEbbIdUFDXptOlqbqB8vX
 8gQ25eJWu4reA13KP4csUR6UGOiQZEbHXA==
X-Received: by 2002:a05:600c:46c7:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-439581604d6mr11073305e9.4.1739320302401; 
 Tue, 11 Feb 2025 16:31:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEuratniRUKPhHFiUBPXqfytzkCDOD+d9/TqhHNjKQ4ApfuO0Z0DjE1gUxuOBx+1VXWxKGsw==
X-Received: by 2002:a05:600c:46c7:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-439581604d6mr11073135e9.4.1739320302000; 
 Tue, 11 Feb 2025 16:31:42 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055859sm3394925e9.10.2025.02.11.16.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 16:31:41 -0800 (PST)
Message-ID: <39f9b27c-cd77-411e-8944-6769999ace25@redhat.com>
Date: Wed, 12 Feb 2025 01:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eldon Stegall <egqac@eldondev.com>
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/02/2025 19.53, Philippe Mathieu-Daudé wrote:
> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>>> <philmd@linaro.org> wrote:
>>>>
>>>> The following changes since commit 
>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>>
>>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
>>>> armbru into staging (2025-02-10 10:47:31 -0500)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>>
>>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>>
>>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
>>>> (2025-02-10 21:30:44 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Misc HW patches
>>>>
>>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>>>> - Make various Xilinx devices endianness configurable (Philippe)
>>>> - Remove magic number in APIC (Phil)
>>>> - Disable thread-level cache topology (Zhao)
>>>> - Xen QOM style cleanups (Bernhard)
>>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>>>> - Invert logic of machine no_sdcard flag (Philippe)
>>>> - Housekeeping in MicroBlaze functional tests (Philippe)
>>>
>>> Please take a look at this CI failure:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
>>
>> Hmm I can not reproduce locally this error:
>>
>>    Exception: Asset cache is invalid and downloads disabled
> 
> OK, I could reproduce by blowing my cache away.
> 
> The problem seems in the "tests/functional: Have microblaze tests
> inherit common parent class" patch, which does:
> 
> -class MicroblazeelMachine(QemuSystemTest):
> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
> 
> I presume, since MicroblazeLittleEndianMachine is no more a direct
> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
> downloaded.

I guess you could fix it with:

diff --git a/tests/functional/test_microblaze_s3adsp1800.py 
b/tests/functional/test_microblaze_s3adsp1800.py
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -57,6 +57,8 @@ def do_xmaton_le_test(self, machine):

  class MicroblazeBigEndianMachine(MicroblazeMachine):

+    ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
+
      def test_microblaze_s3adsp1800_legacy_be(self):
          self.do_ballerina_be_test('petalogix-s3adsp1800')

diff --git a/tests/functional/test_microblazeel_s3adsp1800.py 
b/tests/functional/test_microblazeel_s3adsp1800.py
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -13,6 +13,8 @@

  class MicroblazeLittleEndianMachine(MicroblazeMachine):

+    ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
+
      def test_microblaze_s3adsp1800_legacy_le(self):
          self.do_xmaton_le_test('petalogix-s3adsp1800')

(this still won't help with the strange 403 error ... maybe we have to 
mirror the asset in another place now if the advent-calendar site does not 
work reliably anymore...)

  Thomas



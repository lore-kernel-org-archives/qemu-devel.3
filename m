Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF48C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmw87-0007ez-Bk; Thu, 23 Jul 2026 12:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmw85-0007e3-32
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmw83-0000vA-3b
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784823513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oIXb05T2uMaoZDdf/OzMSGPkJtBIojpzvQcM57s4b9Q=;
 b=c/+51nciVer3QSJKCOZjDrjF7QwFsvh2/cC3Wz+8B/aoEtF1fnavKLeCOOrbI6ilJTz9Rx
 tf3mDDz0avedlKyjDgEnV3VcnVjKKjd95zLMW5/VW4mq7+nA8q7eBnMfkcFcSWZ+UTuGxt
 oqn/cGJO/5aKfz30gUOi1UFZycXmlCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-kODe5rC1PM60g-cKU7B78A-1; Thu, 23 Jul 2026 12:18:32 -0400
X-MC-Unique: kODe5rC1PM60g-cKU7B78A-1
X-Mimecast-MFC-AGG-ID: kODe5rC1PM60g-cKU7B78A_1784823511
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f90dbaf84so696723f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784823511; x=1785428311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oIXb05T2uMaoZDdf/OzMSGPkJtBIojpzvQcM57s4b9Q=;
 b=LjKbW37iC8+oyhrR1N7M0wDjpObMfbRlt0Uz9MIUECjCU8yrFuCuafUjFZJSCKSdMX
 7UDGWIZSSNgzetol/OPDIiacEhtImff1aoT726aHvrwC45EsNv9jD4gMvPbJZNdzEBxM
 /uphdFcW5D7donT1Ho/5QyG3yhmEFpUaoEDMoP4PxJ9Pmrb3pIxl11d0KLW6la0GiHaP
 GgQJZOtQsKfonsQ72LuA6GlNF7gSrhAJPDGAcM5ZxURh/r86gK0IpErHRG5pOHk5aUTf
 prhmC3HNQhieOoX8+85G/SjZP8gZP+3lboVT1tdUk/4bfE7Vmmc4a2627iRmopCHNZU+
 qccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823511; x=1785428311;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oIXb05T2uMaoZDdf/OzMSGPkJtBIojpzvQcM57s4b9Q=;
 b=Ac78KCig4oja26UUb9XSiZJzwnLp0bKjvWXGZr/eyvVGWnzQeMab6jwctT7iCTAF2w
 eIfTcJG334tZYr583DAGlOIOdQhsDbEoM23PH4mpHC02QmePDlXwKYVNIm8VUlMN8ww2
 na5CIIO0G8XJCp89A31PKL3X0FwldkUEl2FPggqfdksVip5nsSkSbwvRoWk8US6if0Hk
 kiE+YefZkdIAemELHZjx8eHkyjNMFyaXbTiyrL/pNYV7BGBmxCZjd3o96tdyB8p7EAci
 GiqW0c1ZtWTBFsCKybuOU+jE8UWLn4x50SC5EFQk5aRPEWoz4fy6gnEcMwqCtevh0I0Z
 YSSw==
X-Gm-Message-State: AOJu0Yzy5e37rVyunIPJS+y6yqhQ5NFnKCOKWTrN3+1vG/6guCzhsjn3
 G5eXB6UUre4tF+HN5QpB/DptlxUqaKrMF/wBOLQDodaJPtXiNGogmRmRaQ9PmA+z2J1PXRjlAxJ
 LCTfViHFMikC0vyppE/506i7/1faZNkG9Ln1UVQJUOw4ywcNLUerY4N+5
X-Gm-Gg: AR+sD10BmAmCGlA3mxmnuIVtYWMkL9qwRNFqiGXGK/ASraONAB3SpETqMfjdX4WH35p
 CMsHwFocAkyk6UZIvXz5HsLyFgZnsiVB8Gy84rHfT0p/IyGPf/h56JFQbCIZshObi/W7ihT4/RW
 iq9QqMqtlbaKAvs6Z2V6x2AHy88rkKxkwZXM5ITb7qhAkLXX/EeDv0Hmia7SAcB3RS7KiX4mfNY
 2rnVSC5lAMi3qHOwvO0GZYRmk93XKDNZCwXybi+4OGlfCn4XHab07yp7mLbdEi6dqxKXur0BOhe
 JqvGfV488UlvCd9UY22wL2rnHu/FRsiKYXlFnSfbyLL5aOKkxobjqXRd8jJf1JN734YaCUaP9Q=
 =
X-Received: by 2002:adf:e00c:0:10b0:47f:93b4:2def with SMTP id
 ffacd0b85a97d-47f93b42e57mr1431935f8f.28.1784823510905; 
 Thu, 23 Jul 2026 09:18:30 -0700 (PDT)
X-Received: by 2002:adf:e00c:0:10b0:47f:93b4:2def with SMTP id
 ffacd0b85a97d-47f93b42e57mr1431898f8f.28.1784823510496; 
 Thu, 23 Jul 2026 09:18:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm15901652f8f.30.2026.07.23.09.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:18:29 -0700 (PDT)
Message-ID: <7f8e11c2-f7ea-4362-9840-a295a7def315@redhat.com>
Date: Thu, 23 Jul 2026 18:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723124432.353969-1-thuth@redhat.com>
 <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
 <amIwSvAAv-LWbmYT@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <amIwSvAAv-LWbmYT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/07/2026 17.16, Daniel P. Berrangé wrote:
> On Thu, Jul 23, 2026 at 03:54:41PM +0200, Philippe Mathieu-Daudé wrote:
>> On 23/7/26 14:44, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
>>> basically does:
>>>
>>>               x = vmsvga_fifo_read(s);
>>>               y = vmsvga_fifo_read(s);
>>>               args = x * y;
>>>               goto badcmd;
>>>               ...
>>> badcmd:
>>>               len -= args;
>>>               if (len < 0) {
>>>                   goto rewind;
>>>               }
>>>               while (args--) {
>>>                   vmsvga_fifo_read(s);
>>>               }
>>>
>>> Thus by supplying huge values for x and y that overflow the result of
>>> the multiplication, the guest can trigger a long-running loop here
>>> that burns the host's CPU cycles.
>>>
>>> Add some sanity checks so that this cannot happen anymore.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
>>> Reported-by: Feifan Qian <bea1e@proton.me>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
>>> Reported-by: Tristan Madani <tristan@talencesecurity.com>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
>>> Reported-by: Sunday Jiang
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value
>>>
>>>    hw/display/vmware_vga.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
>>> index f6f9edfd1d9..567806f0e47 100644
>>> --- a/hw/display/vmware_vga.c
>>> +++ b/hw/display/vmware_vga.c
>>> @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>>>                vmsvga_fifo_read(s);
>>>                x = vmsvga_fifo_read(s);
>>>                y = vmsvga_fifo_read(s);
>>> +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
>>> +                y < 0 || y >= SVGA_MAX_HEIGHT) {
>>
>> vmsvga_fifo_read() returns unsigned... otherwise:
> 
> But x & y  are declared 'int', so at least on 32-bit builds
> a large uint32_t value would wrap and become negative.
> Although we dropped support for 32-bit platforms, IMHO it would
> be better to use uint32_t for 'x' and 'y' too rather than
> assuming the 'int' value won't be negative.
x and y are used as signed int all over the place here ... so reworking that 
goes way beyond fixing this problem. Could we please get this patch merged 
first for 11.1, and if someone then still feels like reworking the code, 
this could be done for 11.2 ?

  Thomas



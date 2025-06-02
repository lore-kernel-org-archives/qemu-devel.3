Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757E2C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 09:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM1tS-0007yR-AE; Mon, 02 Jun 2025 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM1tP-0007yG-G5
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:55:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM1tN-0002Q9-Ri
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:55:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso27207385e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748858140; x=1749462940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7nhU351bq3oe6r5V7ryn9MdlX8RVO4oEPMD7zjWO+s=;
 b=swGn7qXDG57Wo85EI3I8xGQUXa2pRuPqe1k+S9k7nAULtLfjO165EbH5AuVCSdQksj
 Y+4sG8thqsgkDQ+cf3QLzTrWmOHgEoaKHEqe+HtWl/s/km0SMJYi3RRB7oy9z5TSOYml
 w8VwLZm7ENmV8ko3Lpsw4ZmhJsjtVghoEmCCpUgO6/TYRvY9sasHdtm6efGh7TOw85nb
 otyXGO8lB21VykJC2E8o6NmhiX76iFmwG7NKIN8Aka37lAF2SjwUIwLjESrLvU2ej0/O
 tV5IpHh4RgrUZAP3seUI88orWf8DwEsqA/4VZaBuYbS6y0hJPs0rphnb70Ec9jAYS4ju
 SiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748858140; x=1749462940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7nhU351bq3oe6r5V7ryn9MdlX8RVO4oEPMD7zjWO+s=;
 b=jYzbkkM33QzAqVMZOHVJsuLO2ElfLnwro8iD/eMSC9jdrTONp30ANhT95/YxbslzZW
 YvlxJWsJ7HgaspFHjVopnOgtCdmdY2TL1RH9CjhMCXXM587VoGX3BjB3VR9jcVe76+xB
 FW8zpXs792na+1sHg/lzirordmJOSaSMBHd/VgJT8x7iM9eoFuCxIbW/vgyXG60XzliU
 Sd4rX6yOAG+3mhKtvJpwUBqFA27PNBBnnWZIdvvQOqnIc3Hxfzg7a8FHMZT6XEf+Px/m
 dIHSCAAmecNt33xowSOUBt/FCOgC23n1x+Z4hthSP83mj/sUilBtq5JP1dKOGY8/rQzI
 AT0A==
X-Gm-Message-State: AOJu0YypZKg0472ehDZW0efUTXZxXc/XhbSkQKFKHLSUynoLlUJ+e5mb
 73vKULiWmNhTDh9eDsgJ+0PBSPccD2F2zvJ8/HzrGdm5BEwUYRLSNWZjvTyGfcx+CFk=
X-Gm-Gg: ASbGncsVaS2musvTUyCqgWCnUUkCej+DZzv8BCdBl+KpJwLxnLfJIIgQr0o3y1Nr1h5
 OAPlAix2Y5nXskOXABDj/KFKDzCvD3gzcaaNlhZf9ET/jycH3Zu9CU7zhgaSlWxKznYvBc/t7EN
 /5pglE81sKWn4DuGnLmcl2BkP8/KfjF+A+JRidw3HbtSKMXc4s/iJLpoTGBiGVSRnILWyjLvt3a
 1aTRtcv6UgNDtLh8nFnxiCJkIWca1m3pniUcvMwGreiQ6is2bht3B3qCpqX8+hv+GwPs8RNFzUL
 vBf9dmuVDVvKKUEULjJPGOToYbyHi+JaQdaG9+EGBhtls0/66iOmO+q7BGZZrcyhc+MeSZC+DLL
 LWNBH5EXTAnpQRKBfwFlly2GzL3hlGA==
X-Google-Smtp-Source: AGHT+IGqfinwaUygdDPPJuIdujx1luXgnEhBy0sP53XCw4B/wH35gk7EDUxGpcj07MdIpAt/7DFFfQ==
X-Received: by 2002:a05:600c:681b:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-450d887f9ecmr82314405e9.32.1748858140194; 
 Mon, 02 Jun 2025 02:55:40 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f9csm14425999f8f.50.2025.06.02.02.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 02:55:39 -0700 (PDT)
Message-ID: <61baf70b-4cff-4532-9f57-7f9b46fd5937@linaro.org>
Date: Mon, 2 Jun 2025 11:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] system/cpus: Only kick running vCPUs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250602090726.41315-1-philmd@linaro.org>
 <CAFEAcA-1w4jEq727Fs-QrXhETT_pQaTB7HVmptx_i_5Gaaw70g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-1w4jEq727Fs-QrXhETT_pQaTB7HVmptx_i_5Gaaw70g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 2/6/25 11:16, Peter Maydell wrote:
> On Mon, 2 Jun 2025 at 10:08, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We shouldn't kick a stopped vCPU, as it will be resumed.
> 
> What is this trying to fix?

Hmm I guess the bug is in the accelerator I'm trying (split).

> Do we get wrong-behaviour,

Not really.

> or is it just a bit inefficient as the vcpu thread
> goes round its loop and decides it still has nothing to do?

So far with mainstream, yes. Adding an assertion triggers:

     frame #3: 0x000000018a5aaeec libsystem_c.dylib`__assert_rtn + 284
   * frame #4: 0x000000010094b8e0 
qemu-system-aarch64-unsigned`qemu_cpu_kick.cold.1 at cpus.c:494:5
     frame #5: 0x00000001002e8380 
qemu-system-aarch64-unsigned`qemu_cpu_kick(cpu=0x0000000140028000) at 
cpus.c:494:5
     frame #6: 0x00000001006d2a7c 
qemu-system-aarch64-unsigned`memory_listener_register [inlined] 
listener_add_address_space(listener=0x00006000015e9dd8, 
as=0x00006000019eaa00) at memory.c:3107:9
     frame #7: 0x00000001006d28e4 
qemu-system-aarch64-unsigned`memory_listener_register(listener=0x00006000015e9dd8, 
as=0x00006000019eaa00) at memory.c:3195:5
     frame #8: 0x00000001006d6fd8 
qemu-system-aarch64-unsigned`cpu_address_space_init(cpu=<unavailable>, 
asidx=<unavailable>, prefix=<unavailable>, mr=<unavailable>) at 
physmem.c:783:9 [artificial]
     frame #9: 0x0000000100412c6c 
qemu-system-aarch64-unsigned`arm_cpu_realizefn(dev=0x0000000140028000, 
errp=0x000000016fdfe250) at cpu.c:2633:5
     frame #10: 0x0000000100708b9c 
qemu-system-aarch64-unsigned`device_set_realized(obj=<unavailable>, 
value=<unavailable>, errp=0x000000016fdfe308) at qdev.c:494:13
     frame #11: 0x000000010071054c 
qemu-system-aarch64-unsigned`property_set_bool(obj=0x0000000140028000, 
v=<unavailable>, name=<unavailable>, opaque=0x0000600002ee03c0, 
errp=0x000000016fdfe308) at object.c:2374:5
     frame #12: 0x000000010070e27c 
qemu-system-aarch64-unsigned`object_property_set(obj=0x0000000140028000, 
name="realized", v=0x00006000010eb400, errp=0x000000016fdfe308) at 
object.c:1449:5
     frame #13: 0x00000001007128b0 
qemu-system-aarch64-unsigned`object_property_set_qobject(obj=<unavailable>, 
name=<unavailable>, value=<unavailable>, errp=<unavailable>) at 
qom-qobject.c:28:10
     frame #14: 0x000000010070e788 
qemu-system-aarch64-unsigned`object_property_set_bool(obj=<unavailable>, 
name=<unavailable>, value=<unavailable>, errp=<unavailable>) at 
object.c:1519:15
     frame #15: 0x0000000100707bf8 
qemu-system-aarch64-unsigned`qdev_realize(dev=<unavailable>, 
bus=<unavailable>, errp=<unavailable>) at qdev.c:276:12 [artificial]
     frame #16: 0x000000010039fec4 
qemu-system-aarch64-unsigned`machvirt_init(machine=0x000000014e1071c0) 
at virt.c:2355:9
     frame #17: 0x00000001000c313c 
qemu-system-aarch64-unsigned`machine_run_board_init(machine=<unavailable>, 
mem_path=<unavailable>, errp=<unavailable>) at machine.c:1682:5
     frame #18: 0x00000001002f3000 
qemu-system-aarch64-unsigned`qmp_x_exit_preconfig [inlined] 
qemu_init_board at vl.c:2716:5
     frame #19: 0x00000001002f2fb4 
qemu-system-aarch64-unsigned`qmp_x_exit_preconfig(errp=0x0000000101996590) 
at vl.c:2812:5
     frame #20: 0x00000001002f6da4 
qemu-system-aarch64-unsigned`qemu_init(argc=<unavailable>, 
argv=<unavailable>) at vl.c:3848:9
     frame #21: 0x000000010081aaac 
qemu-system-aarch64-unsigned`main(argc=<unavailable>, 
argv=<unavailable>) at main.c:71:5

Please ignore this patch, I'll keep debugging and eventually repost
the same content described as simple optimization.

Regards,

Phil.


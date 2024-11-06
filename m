Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E4DD29F9F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 06:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Zn7-0004v5-MQ; Wed, 06 Nov 2024 01:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Zmz-0004uO-PM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 01:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Zmu-0005Pk-Ns
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 01:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730875507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wSpucpDqsDvxTAZyhxFYFsGqMLIgHO1zXDbRy6bxakg=;
 b=YONtSuflQ9nHp9x23Ufd3n4GD0gSu0zRzsRxikZCD6nEW+CA2F3r2U/OZObZyoPiDfA8tn
 SWW6bi8CJQ0jZdD4WFm+rNzjZz+n1xmHZqwh/d3KM1Lt0ONCHnJvi8FgtrSSyejRRVnrHU
 fXAbgUNnHTadLIA2O2rnu3SbAYw/lwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-EY3TPjbgPR2Kr2Wx_57VSQ-1; Wed, 06 Nov 2024 01:45:05 -0500
X-MC-Unique: EY3TPjbgPR2Kr2Wx_57VSQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so39969865e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 22:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730875504; x=1731480304;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSpucpDqsDvxTAZyhxFYFsGqMLIgHO1zXDbRy6bxakg=;
 b=nBUEyG6+XIFRfvhais+Xd6gkOL6gVWHlHwx9ykoATEfL2tga+RuF8orhSDYIYtznYw
 /46/e0aAxErlVKQe926ADKkFjpdTK4nlIyvfyu/t4WAI/bnJVk3WsfffPn0mX9UOuP6k
 N9i3WFId7O9vVXvdq17qjTT3GofSR5V22yLVVYM6H4ieTgngWSQCKtMhaF5oNE/npjW3
 vsnG4LjtquXImDqdgBBw+hHHxJKkzB4SpNsfxfcJvXjMbQOrEcrHecviOCLhaJrlhmPt
 WP/agH5kOfemtFl+K2cr8cZC9EBB/MPr8HDJXu79Ar/kgBkW7uKS1laAI+NA0IfWzsMt
 4HiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJy2wDHW0kOCKBtvaeb5v64v9x//gGDzsYa7ceQDbFbMlQZiKQsbrqMz4WYllZyNLjrA+GJCF6rdBd@nongnu.org
X-Gm-Message-State: AOJu0Yxcua9t7IkoxYeaAha8Y2UzxltvX2wFYRgnm+YjTNSENAGaXTaL
 /GoY0sdass6mm4npQ4CNJWF9+XZqDqWGqB6+e7LNHgXZrGH/vL2aK7Pk340lnG4d/HLAtnTBgD1
 Yh2LS7btglgnZde6194oL99U+2x/VpBLCosSoxuvMeNAaJuyaMyde
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-4319ad049a8mr318966525e9.27.1730875504306; 
 Tue, 05 Nov 2024 22:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj8AMtKngUgtnAixMW977eJIq0/DujWO/0SA0uuFDdtaqYp6wM7uL35k8DeBiTn2MJO+uvYQ==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-4319ad049a8mr318966305e9.27.1730875503917; 
 Tue, 05 Nov 2024 22:45:03 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7becsm18118987f8f.14.2024.11.05.22.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 22:45:03 -0800 (PST)
Message-ID: <34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com>
Date: Wed, 6 Nov 2024 07:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian
 accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-13-philmd@linaro.org>
 <eae65cf8-af71-4b6d-8bfb-b22224f8496b@redhat.com>
 <5434961f-93ec-4cda-a0be-3e35aaab5d7d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <5434961f-93ec-4cda-a0be-3e35aaab5d7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/6/24 00:29, Philippe Mathieu-Daudé wrote:
> We assumed most guest vCPUs run with the same endianness of the binary.
> 
> Now we want to swap wrt the vCPU, not the binary. So indeed this patch
> effectively undo the memory.c swapping (feature).
> 
> I suppose the better way is to modify memory.c, possibly passing MemOp
> all over. For HW accel where vCPU endianness is forced to host one,
> this would become a no-op. Lot of rework in perspective.

It should be much easier than that.  First of all, this is when memory.c
swaps according to DEVICE_*_ENDIAN:

guest      \   host    little-endian         big-endian
little-endian          BIG                   LITTLE, NATIVE
big-endian             BIG, NATIVE           LITTLE

tswap swaps in the two cases marked "NATIVE" (same as DEVICE_NATIVE_ENDIAN).
ldl_le_p swaps in the two cases marked "LITTLE" (same as DEVICE_LITTLE_ENDIAN).
ldl_be_p swaps in the two cases marked "BIG" (same as DEVICE_BIG_ENDIAN).


First of all, current code does different things for RAM vs. the other
registers.  After your patch it's the same, which seems fishy.

Anyway let's focus on RAM for now.  Current code (unconditional tswap +
DEVICE_NATIVE_ENDIAN) always performs an even number of swaps:

guest      \   host    little-endian         big-endian
little-endian          none                  tswap+memory.c
big-endian             tswap+memory.c        none

That's what Edgar says - it's just RAM.



So with your patch the behavior becomes:

guest      \   host    little-endian         big-endian
little-endian          bswap+memory.c        bswap
big-endian             memory.c              none

Behavior changes in the cross-endianness case.  LE-on-LE remains the same.
It seems to break BE hosts since petalogix is a qemu-system-microblazeel board.

If this reasoning is correct, together with DEVICE_BIG_ENDIAN you need
cpu_to_be32 instead of tswap:

guest      \   host    little-endian         big-endian
little-endian          cpu_to_be32+memory.c  none
big-endian             cpu_to_be32+memory.c  none

  

However, things are different for the R_RX* and R_TX* cases.

Before:

guest      \   host    little-endian         big-endian
little-endian          none                  memory.c
big-endian             memory.c              none


Your patch here keeps the same evenness of swaps, even if who
swaps changes:

guest      \   host    little-endian         big-endian
little-endian          bswap+memory.c        bswap
big-endian             memory.c              none

Is this just a change in migration format for the RAM ara?  Then I
guess your patch works, though I'd prefer Richard's suggestion of
flipping the endianness in the MemoryRegionOps.


However, since you said the board is LE-only, maybe the following
also works and seems simpler?

1) use DEVICE_LITTLE_ENDIAN (i.e. always the same perspective as
qemu-microblazeel)

2) use cpu_to_le32 for RAM and nothing for the other registers


But again, maybe I'm completely wrong.

Paolo




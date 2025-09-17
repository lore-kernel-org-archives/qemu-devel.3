Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB857CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 08:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uynSu-00025V-7d; Wed, 17 Sep 2025 04:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uynSs-00025D-6I
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 04:24:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uynSq-0004wX-3k
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 04:24:33 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso5348703a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758097470; x=1758702270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bb1qu/XhwU6HRJCbAFlhjec8szb7+Vc8Cu1QY+Tf4SY=;
 b=AcMx0iVRZtC2hzrQ69MzPqdippf3usTEXC6zzr4lrks9AIZcoY1h6uEvMR2SYclpWp
 lWsNG7Uw7vqjTup9eNlyOOwSryRPFaj4nmi3djYDXP3RYc9pgDPlintLJVrLUtqI92CX
 +UG1WDt/l4K2psQ7aLGjeVL7VJOGNPGNyG60WvHKMwyZ+RC31JFQMYosPf3SBpJDOuRK
 h0gIaBwVQe+rK1A6EdMDwe9qKMICRjqLoPdWdsIG8vtATJKkwG+jIBBuc3F0eYCYpbPo
 Ey6ObsB7bmZBaGi2U8KW/iam5/htMuCa9UFT1BxZBxWhJacTBAtQSCULjNHHWm/iih6D
 pTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758097470; x=1758702270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bb1qu/XhwU6HRJCbAFlhjec8szb7+Vc8Cu1QY+Tf4SY=;
 b=VHdeyG+R6fJVLmMHSktL9U93genkfOf1tnvugi2ec5Uw6qn1EypQajL7MaUZiORELC
 kned6cwYxljE1tuBjFhACnFGwr7gH7KqgvAldC6d0Gx2c/EeNCE+Nq3xTGoxInk6vPKH
 cYElNWDs4xYe1URjyZZ/yogu4NN/PXtm+CU/jiRhJiVxdCQrZ3/aFiRG8NXQ+jD4mBC/
 Yur9k+jmfM/oFdh5Dv+27/bNrONJ2sIDwuINtgWEA16xLqzIL65MFZAeE4MRUW3ntx+C
 ORTYBmKK6k+Qs2xiFbHRmXL1iHS4dZA+GfPVrsx4Fn+MDjGToMrIy7uRGJTxGoXodhjw
 hplw==
X-Gm-Message-State: AOJu0YzMNhmj7PGKNBQ+0FvoyHTro4DtHG+Niw6zBuKIE+7TrHm6r+sr
 1aJLIKUZ0AyQxAWfVSFj3SP66gbcWsIxo6w73Xr0r51jkmu0GSigyYzy
X-Gm-Gg: ASbGncs4G3zX5vsnhryHh2+AEEAtYRko1R0QJhp2dY6GCiGefLJGVjBYqi0A7Thh0hL
 1GpTU24FGeqe+5oGckfk33WBrAHPmUP2UwwAZMzaymOvsdzVjyyNbLrLqbIsogCFiujg1Di+4eI
 VGof3H8DaEYXIFKiJveJTl/uNi6c+CsLNiWffzceC8UFB9Ha6Z6yYFlamowpieqF+qJiyu4LBef
 VdVU9jWY4ktVwgqch7S5u+ZpmNMx2Iw6363xUQVXYO3Zp7LbABq7t37DYb5QjbzzKyIUihx2+Nl
 GSvWHfI1Ot6FaCnlNLFcG8p1zG9mVvPDDMXLhjWcF2VN00c1I0rVsxIGeuShQ8QuKoPO6zsJe74
 i1Vm2R0SJgtK7SRKah9Umk9xXME8MhcEicwGF8fPAQgyzAIyXU/8I+PrHbjY9
X-Google-Smtp-Source: AGHT+IEiHckRz1Pd6QrR87ciztGtE+sNJWYEmzdMjSgW1OReFuCXwMxSRC/J6boMoe2sGAoEdCwERg==
X-Received: by 2002:a17:903:1b24:b0:24d:4d8b:a17 with SMTP id
 d9443c01a7336-26813cf391amr15625365ad.56.1758097469901; 
 Wed, 17 Sep 2025 01:24:29 -0700 (PDT)
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp. [133.11.54.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-267df817ef5sm35796225ad.0.2025.09.17.01.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 01:24:29 -0700 (PDT)
Message-ID: <298f6453-fec7-4b4e-9257-9058be57c0de@gmail.com>
Date: Wed, 17 Sep 2025 17:24:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ebpf functions can fail without setting an error
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
 <87sehfsife.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <87sehfsife.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2025/08/25 21:19, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
>>> Three functions in ebpf_rss.h take an Error ** argument and return bool.
>>> Good.
>>>
>>> They can all fail without setting an error.  Not good.
>>>
>>> The failures without error are:
>>>
>>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
>>
>> Opps, yes, we really should have added error_setg() calls for diagnosis
>> if someone tries to use eBPF when QEMU build has it disabled.
> 
> Some stubs exist only to mollify the linker.  They are not meant to be
> called.  They should abort(), optionally with lipstick.
> 
> Other stubs are called and should fail nicely.
> 
> Can you tell me offhand which kind these are?
> 
>>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
>>>    reachable?
>>
>> This scenario should never happen, and we should add a call like
>>
>>    error_setg(errp, "eBPF program is already loaded");
>>
>> to report it correctly.
> 
> Is it a programming error when it happens?

I think it is a programming error if one of the user-facing features 
currently exist fails because ebpf_rss_load() is called when 
ebpf_rss_is_loaded().

Currently ebpf_rss_load() is only necessary when the "rss" QOM property 
of virtio-net is set, and setting a QOM property is an idempotent 
operation, so a user can never request to load the eBPF program for one 
context twice.

Regards,
Akihiko Odaki


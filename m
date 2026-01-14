Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED1BD37E2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0fC-0007xB-T5; Wed, 14 Jan 2026 08:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vg0ec-0007gh-7R
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vg0eZ-0000Jw-I2
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768396274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N5a9BatX2kAj7oPcj1MbS8Wny/Qj26/8D7CQnn/+ZyU=;
 b=MhUjpUMUHE63NX5IokVJRPUR70+4S5Z/rvyTzR3mszJsfgjml60mrv0ATPYdlctFtpnXJU
 ISoWy/ndQNgnWUz88Q+KyEqkbZRolMaLZkUY7NYnbFBo94ft1Rk3W8KvTraVxCI80OCZhN
 qB6gi81PbV+gnYvtHiDbZsaQVSwSY5s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-IO1i8eNsMg-4AlCY1X57Ag-1; Wed, 14 Jan 2026 08:11:12 -0500
X-MC-Unique: IO1i8eNsMg-4AlCY1X57Ag-1
X-Mimecast-MFC-AGG-ID: IO1i8eNsMg-4AlCY1X57Ag_1768396272
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so6396459f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768396271; x=1769001071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=N5a9BatX2kAj7oPcj1MbS8Wny/Qj26/8D7CQnn/+ZyU=;
 b=HTwj2NEUAAmCL3W6CelwYfXQ+xevGBlhI2PC1HHGrrG3QOadtaep126OrP5DkTt2rl
 zT3ZUBJqHepgywQ5aJBiAk83V/pK9pFNo3a1X9LpvXfS29WwRuqIdOyF0BYX7LZ/t2mN
 eDsHFc7H4fBT8hGbCFCELsFipmmi/LmWX3zEDP3ZZ46pwG5sRGZoi1sz8tzukag6VaCN
 JNhrOG9xDG1pLXN+riIOT8/myAve1wW+zD1ZZYBZGCbV2Y30LvP4hjvgM+2IzB/X8XIQ
 3aJDzs/BTNaVlGCnb4/chD/pBL/vkRrlgVo1WuvPnr/fFIUpD117nN5j6JKiZ5c9Bfeo
 7bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768396271; x=1769001071;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5a9BatX2kAj7oPcj1MbS8Wny/Qj26/8D7CQnn/+ZyU=;
 b=ubbqiUhqR1A8YqaJ5keY9vaJ5yOEW3NXg2yFdwotkRthGKWJ9u+w34hpDgNrxh4Nyn
 pE/vNxaZCPUzoTMUNZcU3kXNJtrFCcxDdOfgzLNsxNhV74ncbbLYLPmio9dTVHDsrKom
 9jt95LXuLSltMo7j+Q2fQxE8aAs2B/1siWlqSImF1RF3Mb8artf4uuBtk47I6N1lvM/n
 vmjaieC8vW70y3Rithv1++66pS9CGgd0f+oVsRFv6aKgZZOZGFyg8GD5L6R07pHbIEe2
 riXSBP/NSNBIdtH3svMRhYdBXL8YqNOCSsfe2EgjNZeZjj9A6Q2NTF6x8SX2i62JvaL2
 zQcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsSvp6xtriE8bmbdcTTHojs97z+Cu1CxM50FxYIDjFnIlDRyPEXUBe/4+W70ERg7TYXmCxES184Wcm@nongnu.org
X-Gm-Message-State: AOJu0YzA8tZck/IvQaSz70NHZ9X4GU/PxsX7bKO6q6VoTY5gOsWoahfM
 wljCap7TGVjbU6ft4SsoROue7eDQ11PiFK/5vaz8UAAMnWNRh4eRwh3KjgJ42rwaxkG9aaheWy/
 RIpxxK/IKcmbbxj97VmFIIcSb72zC5eZLCQyUozjgO77A1JBlyakkfXXk
X-Gm-Gg: AY/fxX5mSfwWXU+OQnr+dUEgj+HlJUpV925brH8wB3aAZ6e77qMhWIlWBDTuxFGR98L
 4FbloAtHKLTDMkhjUr6C+umbeFP88ELM7KBHnAEcJ2ut+xOgU8gHAkinRuwTZ++2MOWRKVxffFX
 ZXOgzuJ8f/hMIFwoLvnJbH0ljoGlgq7VrA0RtR5Ntrj43XK9ZceKOl6mkOJCfIJKzTH64koXgoD
 0Th32FC+eFwYi3THmOMZKbvzA00FtZ9hjIBWRQpbpk/BQBG87RtIR0ilDREb/p2/tGK4aDmOY/P
 4OWeAy/PFrQWMDEXBM6lT8Aeyu9xIM349y9riAnnM7CaF4JQufgm3BxjaSPu/TRy060N/3mwj8J
 kIfvGFjw=
X-Received: by 2002:a05:6000:2c0c:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-4342c570dc2mr2898031f8f.58.1768396271453; 
 Wed, 14 Jan 2026 05:11:11 -0800 (PST)
X-Received: by 2002:a05:6000:2c0c:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-4342c570dc2mr2897977f8f.58.1768396270955; 
 Wed, 14 Jan 2026 05:11:10 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm50195911f8f.20.2026.01.14.05.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 05:11:10 -0800 (PST)
Message-ID: <cee787a5-8ec9-4b54-9e98-0687fecfe6e9@redhat.com>
Date: Wed, 14 Jan 2026 14:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: Reinoud Zandijk <reinoud@NetBSD.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryo ONODERA <ryoon@netbsd.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org> <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 14/01/2026 12.28, Reinoud Zandijk wrote:
> On Wed, Jan 14, 2026 at 11:45:35AM +0100, Markus Armbruster wrote:
>> That they didn't immediately post the fix upstream is a bit of a
>> disappointment.  Deep in the weeds, I guess.
> 
> Sorry to break this but even submitting simple patches and getting them into
> the qemu source tree hasn't been an easy nor enjoyable experience to me

Sorry to hear that (and yes, I agree, it can be difficult indeed some times 
for bigger patch sets), but at least for simple patches like this one-line 
fix, you can always CC: qemu-trivial@nongnu.org which should help to get 
those in rather easily, I hope.

  HTH,
   Thomas



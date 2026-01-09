Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A21D185DC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBEt-0004RM-2w; Fri, 09 Jan 2026 07:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBEo-0004Ky-3G
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBEl-00007j-Vs
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767960302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pANelp+kxJ30dMI0tV/ozwY+uDmGE6AR288lDx3jrbM=;
 b=cZBQnWW9z6i24tYvo2d3v9GVa2IoCzszDtGGhtcmXh7U9YHKKBZGucPjdXUWBaE/5pLvO9
 NIsFVeZf3RDWWgCgTluKEhdp7fu0rbndIj2h5IF7CV5nLcz8tmJGxT6fpSYyXJn7zy6VD2
 z2vNSg4KJYXAEMTSxOMaqBlGuSDx9yY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-L9QROs3wPpOtEeCEUn8_lA-1; Fri, 09 Jan 2026 07:05:01 -0500
X-MC-Unique: L9QROs3wPpOtEeCEUn8_lA-1
X-Mimecast-MFC-AGG-ID: L9QROs3wPpOtEeCEUn8_lA_1767960300
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so40262775e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767960300; x=1768565100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pANelp+kxJ30dMI0tV/ozwY+uDmGE6AR288lDx3jrbM=;
 b=Io3fRO2gjn/aYHdw9CURi1whi0SrK3kVoSjot7KUXsffC+CAxJFhxwGMez4Cwt/UH/
 za1HRv8cHXxo2EpHco2vEJeA7UcsiZDJjzauq+ZDU60KTNC2fC3esha2zAiIRbi1gbGO
 e0B6ZkE2M12UUOAaZw8TSPN42ONymTP/COaLLKN6b3qosuWqRyGgZWJA7M6YY+TTmeUg
 hl9YRZ1l+Ut7HPCgSgAm3kHz64WgTqbRgyyowlM96lhHWA1pMlLnZAGvxqKzrYERAqFe
 0G4W54jB3kMb+I7XGb9nCGp82XmPB6t755ruw52fBUQNAhpNZR5qf90z8mOPZnoSz0dd
 fvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767960300; x=1768565100;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pANelp+kxJ30dMI0tV/ozwY+uDmGE6AR288lDx3jrbM=;
 b=E1vxRByTufb1a1JLSpAVV991j4bhCregBT5cD2dqw0mJFjYR7+awE9XYvPtqpHajB4
 qfqg3zGRjvnW4StZRmeLt6XjZNUA3JtV3Glf3LP7CCiRGst8ahAOExRYiEZhEzV+jF52
 zAq8rc0yo6huvlgp4SqQ3mXJRchoy+/KkSByDU84X9JeJFnEBN405N1OtDqGVfya0OoH
 QH69V9T5YPfjP/XKmrMFHreXMrtH0M+T898n9iTaY+GtXLvv5/QJRi0677lXy859qPc9
 2dHC5Fj/1yaBa8NLCjSOih/PlDJBiBlT6pYgGho3d1NMiEsWqwr4NQ4RxMbXsUXyR6k6
 BR9A==
X-Gm-Message-State: AOJu0YzbHSrEVlI3a28XET69oVFS8gM5+ih7uvjGFls+JnraEQ++IteT
 wwxwkIgho5x05Eatx8TCBGTg+UL3MvsW0sh6kAlXQf9zSb3SWT459J+tsTKoEWPqJtCH9LQEiOJ
 5O20Sg/gGB1H++9kvlKnR20MkUz/2c/+0itML57tuWmd+HXIOI+wmiRgn
X-Gm-Gg: AY/fxX4zG6DkDQORugwDiFuMHGvy3KndeErJEymmh6FBw5TAAT/3Oh+lTQbrRbqGBAb
 kiPuajxnqrV7LLwGHEjhti3Q5jmkAFvwxBBD1DFFzLyFxoGnB0h1+h3qBys/VcZZQQWSS77QqT2
 96LUHMJDzkfV4B3zWvHjNpYj1KSsUAI2M8adsiYiKtRCxhJvynto23IDj0mMViRhoOA9Sdb2FN7
 AdPFKZTXzaARhoHM/fMvEpV8hnNRJ/T8jZJM01FqD/1cR5cPwhSa4fpi/hl7ZbwJzZynLiTTRCm
 zPOOeFKJeaXcNN7yUsAZ/Q+mR2kUAraHvwSDWpmZmxdGraEhQ0ik73WfUG/YYhM1+RQskWQJsKU
 pT28Va/2GeOVpIbJoGJbZR6Rtu3Dwu48yN6lU8Rlkqu7NNCSZgkVKRxL1ua5bdVX408YUV3Y5hF
 TC2v1YaHc4anDEnQ==
X-Received: by 2002:a05:600d:103:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-47d84b1fce2mr83952555e9.11.1767960299845; 
 Fri, 09 Jan 2026 04:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGquHI8EWZPHsosFFWo2Jcu7TdevgLT/7LPFwtFrSkyPsVZnZeihiLQg8dyT5W6JYr9et6lg==
X-Received: by 2002:a05:600d:103:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-47d84b1fce2mr83952245e9.11.1767960299450; 
 Fri, 09 Jan 2026 04:04:59 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm22171017f8f.19.2026.01.09.04.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 04:04:58 -0800 (PST)
Message-ID: <c4c863aa-45f1-4f4c-8cfd-526c14a6d511@redhat.com>
Date: Fri, 9 Jan 2026 13:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/24] util: set the name for the 'main' thread
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-8-berrange@redhat.com>
 <5cbc1f80-aef8-4bcd-beeb-af9c54eea3c8@redhat.com>
 <aWDr6Fpbp_oDNylt@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aWDr6Fpbp_oDNylt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 12:52, Daniel P. Berrangé wrote:
> On Fri, Jan 09, 2026 at 12:45:03PM +0100, Paolo Bonzini wrote:
>> On 1/8/26 18:03, Daniel P. Berrangé wrote:
>>> The default main thread name is undefined, so use a constructor to
>>> explicitly set it to 'main'. This constructor is marked to run early
>>> as the thread name is intended to be used in error reporting / logs
>>> which may be triggered very early in QEMU execution.
>>
>> At least on Linux I don't think we want to call the pthread function.
>>
>> Since pthread_setname_np writes to /proc/self/task/tid/comm, wouldn't that
>> cause ps to show qemu processes as "main" instead of "qemu" or "qemu-kvm"?
> 
> Hmmm, it depends on the 'ps' options you use:
> 
> $ ./build/qemu-system-x86_64  &
> [3] 3859009
> 
> ⚙️ [oci:fedora-43 qemu]$ ps  | grep 3859009
> 3859009 pts/10   00:00:04 main
> ⚙️ [oci:fedora-43 qemu]$ ps -a | grep 3859009
> 3859009 pts/10   00:00:03 main
> ⚙️ [oci:fedora-43 qemu]$ ps -ax | grep 3859009
> 3859009 pts/10   Sl     0:03 ./build/qemu-system-x86_64
> ⚙️ [oci:fedora-43 qemu]$ ps -au | grep 3859009
> berrange 3859009  8.6  0.1 3893224 123700 pts/10 Sl   11:49   0:04 ./build/qemu-system-x86_64
> ⚙️ [oci:fedora-43 qemu]$ ps -af | grep 3859009
> berrange 3859009 2085609  8 11:49 pts/10   00:00:04 ./build/qemu-system-x86_64
> ⚙️ [oci:fedora-43 qemu]$ ps -axuwf | grep 3859009
> berrange 3859009 53.4  0.1 3905536 124108 pts/10 Sl   11:49   0:03  |       \_ ./build/qemu-system-x86_64
> 
> 
> and I hadn't noticed since I always use one of the latter
> sets of options that give the true name.

FWIW "top" also changes its process name to "main"; there's precedent 
for Firefox *not* changing it:

$ ps -o "%c" $(pidof firefox)
COMMAND
firefox
forkserver
Socket Process
Privileged Cont
...

Since we can't really know how the COMM is being used by monitoring 
tools, and there's a simple workaround within QEMU, I'd prefer avoiding 
this.  Sorry for not spotting it earlier.

Paolo



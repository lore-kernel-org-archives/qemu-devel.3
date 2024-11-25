Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC7D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 06:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFSdF-0004SS-DV; Mon, 25 Nov 2024 01:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFSd7-0004Rd-7m
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFSd1-0003Av-Ik
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732516279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qQG9pMRKmO8CIm/HePCDusU/NIytC5O1ZF5b9E+ocBc=;
 b=eQka4a0rXjnmz1CKghxCOiBGd3HcszH8cXxHuT6sumsH5RziznqQhYD/DADJPUKGWsp88/
 D3PUOtQrxbGBFHp+ChL1HFVsnaFBujSBFJRohyf/bwV4c0KvFDWAcK+hOn07eofsxiG522
 cdc7TdnkasBdmtfmZp5KGAHSkdkqAnU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-kaLwWDBtP_yUn_bBfw7VKw-1; Mon, 25 Nov 2024 01:31:17 -0500
X-MC-Unique: kaLwWDBtP_yUn_bBfw7VKw-1
X-Mimecast-MFC-AGG-ID: kaLwWDBtP_yUn_bBfw7VKw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa53914509eso78585666b.0
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 22:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732516276; x=1733121076;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQG9pMRKmO8CIm/HePCDusU/NIytC5O1ZF5b9E+ocBc=;
 b=g2MGVgX0t8bGsY61Cag/oaZjpO0x82vkD26gkBBA8n4jkBvBD/NHkcLmdak3PofncL
 teCdPK2rvzIMPTnV/slE7O0GvDYecfS6UvrQkA0H6YQhWLqBCBAcQwtXMLk4URplSo4L
 9MR9ZpBIOYuYIXTmahHn+HM1tNeu2LskvntI3jtTqjeA5YzKeCDfIzqZxw9QPiPIxYP4
 WyTk1fTndArvc3nIwjwdn+LpwMszRdizxLPA7oj2YeDMsO8EZoCvmqebfeyiDN/ZbyA5
 fh9kUYPXUkrNOM8i3VfzNfTrrhMoUQiJeJ/OCu41VgBTdGB1Np9dfM1X3OakzvH314h8
 jMaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV05xx4kaJSPDUb2zva3iAfZZJFtDZj3HqFr1qVJwDDGM+aTm+KuAL5TSoQ5D0cwclFkAGC6KCy9MkJ@nongnu.org
X-Gm-Message-State: AOJu0YyqDrYbJqCr0zt4sluS3c6ZxASXYKPDQSp3Ym6uzB52C/a5MWgn
 1GnXPrGqd3gxbdURKBBeVMHrmPLjpUewT8Xi/9tqOk0cWFSB0Dv+JEU/+hRtP9oxe3PeM+q85aD
 276kGFybPny6yXoueE4jngZKxX3EIgQhSNlC0L2TQk2+rToRy5E5z
X-Gm-Gg: ASbGncs1IcBsSF4E5BI+L5YqFGwFvGPzJDJH60TrzJQCE1UIsTJ7szr5oSLEP6osCnf
 ImdfiXh0rgJz7LRV4LeGngJvinwR9wOImf8n7hPW7ezanWZ7+IhYLvlHQ/FHp4ihWEMzFw4nbHh
 giAZ82jmfVPIg8ZPWDwWjzH5lWBv5+cO3QAsXjZ6qKW2/ECEwV0LXXDh5kwaxGN8GbjzZ1gf4kE
 2g1IXk+RmkUsjJW/4WJFmYuXbPREsSaB7P9MNTxFwzfnrSiPyWyJuVUoiUoC/FT9HoQvUX3DHBa
 M+8=
X-Received: by 2002:a17:906:32d2:b0:aa5:3f53:ad57 with SMTP id
 a640c23a62f3a-aa53f53afaemr525619166b.19.1732516276529; 
 Sun, 24 Nov 2024 22:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0Y+J+biyrA4f2DddX/jtrch042xS6uyifocHqKrsFPVPdp5AuJ2nAmirUTOBLexUSlG6tIQ==
X-Received: by 2002:a17:906:32d2:b0:aa5:3f53:ad57 with SMTP id
 a640c23a62f3a-aa53f53afaemr525618166b.19.1732516276191; 
 Sun, 24 Nov 2024 22:31:16 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa545de9b41sm169126266b.137.2024.11.24.22.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 22:31:15 -0800 (PST)
Message-ID: <2f9c5255-a6cf-4b39-bdc5-eaca63ce11da@redhat.com>
Date: Mon, 25 Nov 2024 07:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <ae79e5a8-d875-41c5-ace0-911be633d8c5@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ae79e5a8-d875-41c5-ace0-911be633d8c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 24/11/2024 13.28, Philippe Mathieu-Daudé wrote:
> On 24/11/24 01:21, Pierrick Bouvier wrote:
>> Hi all,
> 
> 
>> After thinking about it, a simple, exhaustive and reliable way to find 
>> this type information is the debug (dwarf) info.
>> By compiling qemu binaries with --enable-debug, and extracting info using 
>> llvm-dwarfdump plus a custom filter [4], we can obtain a text 
>> representation of all structures QEMU uses.
>>
>> As expected, turning the option globally has an effect. The exact list of 
>> structures impacted (those having bitfields, and not being packed) can be 
>> seen for each binary here: [5].
>> As there is a lot of repetition between all qemu binaries, the reduced 
>> list of structs concerned is [6]:
>> +name:ArduinoMachineClass size:0x0198
>> +name:ARMCacheAttrs size:0x04
>> +name:ARMVAParameters size:0x04
>> +name:AspeedMachineClass size:0x01d0
>> +name:_GIOChannel size:0x70
>> +name:MachineClass size:0x0188
>> +name:MicrovmMachineClass size:0x01a0
>> +name:MPS2MachineClass size:0x01a8
>> +name:MPS2TZMachineClass size:0x01e8
>> +name:MPS3RMachineClass size:0x01a0
>> +name:MuscaMachineClass size:0x01a8
>> +name:NPCM7xxMachineClass size:0x0190
>> +name:PCMachineClass size:0x01c0
>> +name:PnvMachineClass size:0x01b0
>> +name:PPCE500MachineClass size:0x01e0
>> +name:RaspiBaseMachineClass size:0x0190
>> +name:RxGdbSimMachineClass size:0x0198
>> +name:S390CcwMachineClass size:0x0190
>> +name:SpaprMachineClass size:0x01d0
>> +name:Sun4mMachineClass size:0x0190
>> +name:TriBoardMachineClass size:0x01a0
>> +name:VexpressMachineClass size:0x0190
>> +name:VirtMachineClass size:0x01a0
>> +name:X86MachineClass size:0x0190
> 
> The *MachineClass ones come from [*]:
> 
>    struct MachineClass {
>        ...
>        unsigned int no_serial:1,
>            no_parallel:1,
>            no_floppy:1,
>            no_cdrom:1,
>            no_sdcard:1,
>            pci_allow_0_address:1,
>            legacy_fw_cfg_order:1;
> 
> IMHO Using bitfield to manually micro-optimize memory size seems
> a bit a waste of developer time/focus, I'd rather see compilers
> doing that for us.
> 
> Regards,
> 
> Phil.
> 
> [*] Interestingly Thomas is also looking at those fields:
> 
> https://lore.kernel.org/qemu-devel/20241122084923.1542743-1-thuth@redhat.com/

Yes, I got curious by the msbitfield discussion last week and remembered 
that we had a look at the differences of the structs with "pahole" in the 
past already, so I wondered what might be the difference nowadays, and the 
machine class is the most prominent difference, indeed, that's why I came up 
with that patch.

  Thomas



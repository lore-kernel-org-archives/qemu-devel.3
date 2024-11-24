Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D43E66894
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 12:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFBRl-0004nB-HP; Sun, 24 Nov 2024 07:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFBRZ-0004li-Mg
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 07:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFBRU-0004Cg-9Z
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 07:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732450216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i91pl4HWRdpLNgNcoIQ6iqv8nDU9UsNYcUUGG6TRuYk=;
 b=F7h/CExm6emDgt3LVHIyd8mWObJzH7HhvbVm3jXfWumkF/Jwi2+XL0zitl4O4OFULFlurJ
 3eS9CgSR2Q22QLLKwOIqVQdfSCpdsDjMPwALziTajRrvarU9vijSwm6QB/bw6Lz00jti4t
 2/xud0eI5bO17iQdnO2iOzz2Eay5PRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-QCuAtBafPge-f9Q2Ad5o_w-1; Sun, 24 Nov 2024 07:10:12 -0500
X-MC-Unique: QCuAtBafPge-f9Q2Ad5o_w-1
X-Mimecast-MFC-AGG-ID: QCuAtBafPge-f9Q2Ad5o_w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43498af7937so6834485e9.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 04:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732450211; x=1733055011;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i91pl4HWRdpLNgNcoIQ6iqv8nDU9UsNYcUUGG6TRuYk=;
 b=ZORvGcC2ZERyz0lO+csxEPYwnSo8mjySesFSWCRYqPh2geHu1AIRTxkAxCkwq9D6n4
 XkyNEaSGazjhAAGrqMbsJXJYX1HeYue9izVvGu0P2v7j22q+zgZo+xlEyX+hhuxjs2Zx
 o7HzFaWHr09GazPVXv6Spa8OaIW+EIKKM1VKu7mlIEtE38hO8NpV3N3IdYvBfQnxN0Lc
 Tb9alfJGkNoCgDRAkKhxIomVO1p+w/Xpe7/zikMGX76fRlzJ5hWBOAks6cIj9N93BsgA
 01xy0p+aNrq3dcJljjI7Al3nya1O9fE+CRF+bQ2KWxxaAWAIPxHz8KChM3iRY2gnH53j
 aF/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYGZxgKfkPUKliokXHXEVpu1DLTfqa6hQqP7+NuxTrFRDuKkFyvSPlT0K6kDw9TiSsFNkQysFAcJfo@nongnu.org
X-Gm-Message-State: AOJu0YzPDErBbc+/HQYZb7ZOWE8Qp2yYG6TCZc3eP543F3pgz/AyUvdc
 nD80vzFChwJ863c0BY8whH1YeW+ovnk3g97vcFZ1z8raC5HTRB1Xz1gSSCQXmgJyByuH9lQ4mNM
 0Smr7iw7NkJkwIc8aS99t7+qzIwX8przM0270EzBsUk+XiqUBYFeD
X-Gm-Gg: ASbGncujfAeP7iiWTm3akc5wmoOSx0nx4vhUqqma55mIlrPSrhXeIc99dsiHBrvRhPV
 61ke0poZBWIceAlVj+gAinf+4bvVI6+BJ+U2K3MyjRa1Zd7GAtBsbJJhOp3Tt/+ww4JGN21Z25k
 vFD145GRx4XFsbxNzKLi/xnlVED9yur/T7h6mJwtfkA3HboAh0F4GhHw40HCKxvlm8mO05LzFVn
 Wx3l4xnqWuKNWhSeX8QwZ637KR8HaqCHBR9UEKKtDBToJTbQvafbg==
X-Received: by 2002:a05:600c:1548:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-433ce424846mr75971725e9.8.1732450211576; 
 Sun, 24 Nov 2024 04:10:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYqajCTbmsMVSXOPgRMnrJV0PX2OdsLhBVPzNa8tTF4eoVOikz5YVMWq5O5N9CfxCCWl+gCQ==
X-Received: by 2002:a05:600c:1548:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-433ce424846mr75971655e9.8.1732450211274; 
 Sun, 24 Nov 2024 04:10:11 -0800 (PST)
Received: from [192.168.10.3] ([151.81.113.159])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433b463abbfsm160065825e9.32.2024.11.24.04.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 04:10:10 -0800 (PST)
Message-ID: <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
Date: Sun, 24 Nov 2024 13:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 11/24/24 01:21, Pierrick Bouvier wrote:
> After thinking about it, a simple, exhaustive and reliable way to find 
> this type information is the debug (dwarf) info.
> By compiling qemu binaries with --enable-debug, and extracting info 
> using llvm-dwarfdump plus a custom filter [4], we can obtain a text 
> representation of all structures QEMU uses.

Yes, this is a good idea.

> As there is a lot of repetition between all qemu binaries, the reduced 
> list of structs concerned is [6]:
> +name:ArduinoMachineClass size:0x0198
> +name:ARMCacheAttrs size:0x04
> +name:ARMVAParameters size:0x04
> +name:AspeedMachineClass size:0x01d0
> +name:_GIOChannel size:0x70

This one unfortunately shows why the global change is wrong.  The size 
of _GIOChannel must match between glib and QEMU, otherwise you have an 
ABI mismatch.

In other words, the global default _must_ be -mms-bitfields, because all 
other libraries (and also Windows itself, though you didn't find any 
occurrences) are built with MSVC ABI compatibility.  Bitfields are 
relatively rare, and therefore you only found one occurrence; however, 
this is a constraint that we cannot get rid of.

However, your script lets you do the opposite experiment: remove 
gcc_struct QEMU_PACKED and check if anything changes, i.e. whether there 
are any QEMU_PACKED structs that do rely on the gcc_struct attribute. 
If there are any, then it should be possible to change the definition 
and fix them.

Thanks,

Paolo



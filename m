Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2052CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHHEX-0000gr-VA; Fri, 07 Nov 2025 02:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vHHER-0000g8-2W
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vHHEM-0006k8-Ln
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762501796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7xcgrHcR2eDvhDkXXGORgQlyTRASDz3Np1zev6dFUuw=;
 b=Z+u7t5UT3ScZAOqpVTYL4S96h1YcyQ2MckXFme2baNjT1TdYRIBo+/wtRKNZ49BuTdUfCu
 RuxSTqVarQNwKOhidiIWJViczdY/FkyTHNz//RoZfPIr0bH6ZNel7d8ytLepgI/01Jgtbi
 s5mb4XUgiB/5kruxoVw/ylmyoTFjjvc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-C30PtGKnOfam7XV-5GS01g-1; Fri, 07 Nov 2025 02:49:55 -0500
X-MC-Unique: C30PtGKnOfam7XV-5GS01g-1
X-Mimecast-MFC-AGG-ID: C30PtGKnOfam7XV-5GS01g_1762501794
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b72aa7eb745so38078166b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 23:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762501794; x=1763106594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7xcgrHcR2eDvhDkXXGORgQlyTRASDz3Np1zev6dFUuw=;
 b=luqMPvDgGz6yCXdzI62wZ54X3Px9SybflGXeDU1kAsBFHjlM8hjVs31htVBF4SKNXT
 4pkpMlxA3KUokSjV1cLxibyNZekoodUyIU8E/wcj6xs5NBOA9zA6Ja76xlHtBLtuEDrC
 7iVqw6ELCLo6H41uOL1bybSLfuy4fOZzjmqBMYWp2ZlIFR8GM9HBVTbCtI4oRY2kYWup
 psaymUtGm0TbmUr3evlV89nF/S4Xl/W7KoI1oNZqHMqVL78SZ79tAgX4HU2bOl/9s0gF
 56r0wwXe1GZqIRIw2oGc78bB1G6bttIZxqSZasuVZlWxsS6g/EM2QJvLOOgV774qm2Yk
 8NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762501794; x=1763106594;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xcgrHcR2eDvhDkXXGORgQlyTRASDz3Np1zev6dFUuw=;
 b=kN0EJOAGMkvKJbKtNjUBAy+R98GUpQwczbgllrFMwEx9U9j2JO/957B4FEu47Mkn0z
 a1Elql3owKLQgbi69iI9vKBSnu8uncfajvIn1xr0Y5Xkhgkv/YjpgB3k8R5lszPhhYJf
 ExpRSGo6KiCtCUtLw4JUk386AjElZ0U9LLCI2FnPrT7p0Qi3fwxRm/TZDM76fL2DdoTm
 o2RktTa/L8CHLb141y//rhPEZbHp9nU07JW6tZoigaIOUZogjPlClvHIsvFJKBbmk51s
 PM73QqSToNRwwbzwOKlmQYrae5CkhQuoyi+Lh72SIaALiznctJgYzmqKbKihiHs7ytFi
 6toQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHp/lHUnyTEOT5+tIGV05pAeTFbHQILINkpQROrWtDj6uspAjPbi/kxl2fYVmuU+CX0wflgGZWoyf@nongnu.org
X-Gm-Message-State: AOJu0YzPTpDeNNtaALC0b57kqXpuOIrr2M4ynOJnC6wtWubveJHG+k3l
 E7GLbh/C8hknlgQfX9suA/ijR2+i+HnGh8ujpnPYdRA0aN7S0TO2uEkzuF+hlY3I4ApE0DrkH5u
 V/mtEUftRpYzDvalEVXyBu2SmI9HAS8JGeXQM0qOuB6ZM6qR5uiO1DPQB
X-Gm-Gg: ASbGncvf1yVtOR4OApmsGpQH6/Xe8c98R0MvSBh5oQWcjY0WNZJFWINQqhidGICGsdt
 w+aYhbwVIlPMht5rpWQVFWM0kuJtbiwDuzadeqUQG3g1CW4se8j7VtgYayuWDZDSrPLswNxsB90
 J8xwAwWxFLGACwhls0Fou2WamALAly089jbsM5+8OBkdbp/st9NKhh3jdsIBg2dh/VUfSWCRw/S
 XXtru7WeJ4Vcvct76MOu7Z0xXTUPxYqTv0O5Q+o2IOkcWdJZiCH1rCw0WKcGhxnq9R+xMN+qLRZ
 /7yhZiZZqpDdJZE3aGlOGHmgHUtv7xy2dBDEB6ErRFgJDZMIUvno8JVbxX/igGyP1Lk/6YRNESw
 lIlwVDH+Z38OhunOmYtZKgZkq+IsA32gVHKHfAnVVxQ4pMoQZVCl6PMRh0EdhV0B1LG6SUJD/Pb
 mYLDJJ
X-Received: by 2002:a17:907:724a:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b72c0e9ae41mr228210666b.57.1762501794089; 
 Thu, 06 Nov 2025 23:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwn5g0yPiqE4sfJxroEygSupCO6+aFMNCs+RC7Fgxg4WsNdGqh4PQ3BLz5e3VIKMFvbfeYvQ==
X-Received: by 2002:a17:907:724a:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b72c0e9ae41mr228208366b.57.1762501793696; 
 Thu, 06 Nov 2025 23:49:53 -0800 (PST)
Received: from [192.168.10.81] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b72bf72337dsm170885766b.33.2025.11.06.23.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 23:49:53 -0800 (PST)
Message-ID: <84bd1674-4a38-4864-9297-fef628b51cb8@redhat.com>
Date: Fri, 7 Nov 2025 08:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
 <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
 <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
 <185927c2-9386-4935-8bfb-64eeb87f06a7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <185927c2-9386-4935-8bfb-64eeb87f06a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/7/25 08:41, Thomas Huth wrote:
> On 05/11/2025 07.29, Akihiko Odaki wrote:
>> On 2025/11/04 21:18, Paolo Bonzini wrote:
>>> In this backtrace the CPU is waking up the main loop (thread 1), but 
>>> the main loop is running so I don't think it's really a deadlock.  
>>> It's more likely that the replay is not matching the record, or 
>>> there's a similar reason why the replay is not proceeding.
>>
>> I agree. It is more likely that debugging the replay code instead of 
>> the RCU change will lead to the real cause.
> 
> This now also impacts the Gitlab-CI :
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/11984309870
> 
> How do we tackle this? It feels bad that we have such a subtle problem 
> at the beginning of the freeze period. Shall we revert the RCU patch 
> 'til the problem is understood?

I'll look at it today; if I can't make heads or tails of it we'll revert 
it, yes.

Paolo



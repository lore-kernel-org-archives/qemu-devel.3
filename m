Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2389DD5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9g3S-000469-3T; Sat, 09 Nov 2024 02:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g3Q-00045c-EN
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g3O-00084C-VE
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731137921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeWXdJ4dzccSrv5/POjutIS4o+EsyUYSikF8Q/4hqaU=;
 b=CWg4obKI3CJsjYnC9+ff+XjRk22Sm6QXYbbaBnuiqL80e4CawAaQDs1R5GAg27RPqeFrSh
 EfzpEUrSbn4xBWRRAQZpz5iSevITympgpjaNH1pHRnsLWUDvLOJyKf/suycXWpVOTxD9VY
 +qkq/6Nr4BGzW4VjRx373Pz/T8Hv5bY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-Bqw1MPuLNoahwDtM0N9e8Q-1; Sat, 09 Nov 2024 02:38:40 -0500
X-MC-Unique: Bqw1MPuLNoahwDtM0N9e8Q-1
X-Mimecast-MFC-AGG-ID: Bqw1MPuLNoahwDtM0N9e8Q
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d47127e69so1386127f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731137918; x=1731742718;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zeWXdJ4dzccSrv5/POjutIS4o+EsyUYSikF8Q/4hqaU=;
 b=aE1I9s6SSetbgb0f9A3FLi/bfvj8Q24BihWdnue8/YyV0IxZ5ELhbusYxAQx770IP2
 0dB2muI9ecbM6/hIVTHmxJZ7BbkgGAE9ZGj1gbmIXcg8G/ag7wGaYk6fvLt+O1xA0eX6
 rT56YcRhsm40/xsC3wE01x1yVbVFNP3uWUUbQr3fI25DfhhPDDgowjngbBZSFHMRO2SZ
 1kaRRYSDuTMjvyBP+8LxEmIC4oFe2SKLmSYclYGEn9MMn1FakOjdLUlwsU3M6hiErbsY
 8shLw0IJiYWFRt/0z/9sKs50ttKh2ljm8hGwTzU+JpU3h2/QSFhU5omaOiYHLZgq8NHg
 4rpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtqLOzkq7lXM6DEZ74tF7C15Q/mPM+UeHt8fo9VETrKYfFM4AvtO0131ZrPf9aE/0LDsgA66KNPBoy@nongnu.org
X-Gm-Message-State: AOJu0Yw7qhdda0wkFoV1yKpvYWbzuEKsq9coCD+AquX4OpX28uxeWguy
 i08M6qOeT3/eawG+XKUw5p+2gQW54DddK+8k9NOyRZt2hY/bEeZiqtnqjY41B55ATDwg8w/K6R7
 ip1BcvWpP+dr2bhauU0ojouwdI38Xhii21UqlyWVpIUBi1bJTDPFriUl7Edkxvkk=
X-Received: by 2002:a05:6000:18a9:b0:37d:4ebe:164f with SMTP id
 ffacd0b85a97d-381f1883d96mr4883937f8f.46.1731137918529; 
 Fri, 08 Nov 2024 23:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAVsw6NkcnhYjs7od8TNCZlPtMIoX7ZFSN3vaXFpHs8L4lGECV8zvhtxTqfgqw2U6Kg5Ml8g==
X-Received: by 2002:a05:6000:18a9:b0:37d:4ebe:164f with SMTP id
 ffacd0b85a97d-381f1883d96mr4883921f8f.46.1731137918134; 
 Fri, 08 Nov 2024 23:38:38 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea841sm7220936f8f.70.2024.11.08.23.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 23:38:37 -0800 (PST)
Message-ID: <87017c55-e01b-438c-9ddd-3376f0e07596@redhat.com>
Date: Sat, 9 Nov 2024 08:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-7.2.15 v1 00/33] Patch Round-up for stable 7.2.15, freeze
 on 2024-11-18
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 11/9/24 07:38, Michael Tokarev wrote:
> 12 64e0e63ea16a Tom Dohrmann:
>     accel/kvm: check for KVM_CAP_READONLY_MEM on VM

This only matters for SEV-SNP support, so it's not needed before 9.1. 
But it's not harmful either.

> 13 d9280ea31747 Stefan Berger:
>     tests: Wait for migration completion on destination QEMU to avoid failures
> 14 04bbc3ee52b3 Kevin Wolf:
>     raw-format: Fix error message for invalid offset/size
> 15 a7cfd751fb26 Richard Henderson:
>     tcg: Reset data_gen_ptr correctly
> 16 987b63f24afe Peter Maydell:
>     target/i386: Avoid unreachable variable declaration in mmu_translate()
> 17 b56617bbcb47 Alexander Graf:
>     target/i386: Walk NPT in guest real mode

Please add "target/i386: Fix legacy page table walk" as well on top of 
this one.  It is in my recently-sent pull request.

Thanks,

Paolo



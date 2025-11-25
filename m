Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51863CFD37F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqMn-0007VE-Ld; Tue, 25 Nov 2025 05:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqMm-0007UL-9h
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:33:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqMk-0006wd-7z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:33:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so56147555e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066824; x=1764671624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVEkuuFCR7NbtFW0OlDkWq+pV/uCWFvNJVFGsL6m1PQ=;
 b=HIIq2dw2woaaldAavs6/+Pc/e9USKMQSnUGhuV0Ajv9jyCxN+InVMcG2p37fpvzF7p
 IFtfgm9BEtYkHdo6UXZKxdSpXt7PoJEsqYaSry4N+12CyjoEjtrJrt+8trj4nBk7RHP6
 i0Su6rjPrSA+VRZ9R8LfKFd2BJ07LYGxZ8dytW7oUfeKJQUbipZfP5gzZhw6DTxvKlJX
 gCgglcMXkvXgh0Ug/Srq89KyU6WzHjKJAfQJ+XUf9Je/5ejgUaHw8gVxRGUfdBfvi9bE
 8ehrRz8Ob1hEa4xS0QgsTcr3RvL8zljI8gPLJ5OZ4cIm0mZjnmQwktIWtY02LF7UlbuI
 FAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066824; x=1764671624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVEkuuFCR7NbtFW0OlDkWq+pV/uCWFvNJVFGsL6m1PQ=;
 b=RzQjqJsPucsyCGNoeHHfNMsQbfBeCAhiCN79BDJj75CHbMopXIlgY1BM7HZD2x10QZ
 9HP1ypxLkZKgQZGDzNYd+3DV4rMCSVuGG3ShW2QdpQhOADQoyWG1T5AcqEMSubutWEHH
 QJ1n+ydxUY3k0hO4ywINtjbR7WZ9JHQ0uVGqIPpqfAvEkjOUrQ3TvOsJEIynm8Q1ff86
 BVakp4yOfzBLWmumu2eSkMq6d2bcAzNfJmUY5LBoJ+HBQ+W41ib791xlin6gqNrUiCaT
 CnmOm/pk61MC6JxmBZugD/8fVf/8u2ImhEccxUlLwXmm9dDH65jNLY1e1sD+nUteb+ef
 elew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyexeBZnuoAF9F1lzSyyM+oimL4eRPL0Hv4OdirlFicC0sFPR1Qtck1vxZuU6bY2qcNGu38QtsW6/Z@nongnu.org
X-Gm-Message-State: AOJu0YzlIvHnqHoAEYnfoCMZ2sfIg3RWd+r3FUUKu/owtIBwgimnjHi/
 9i8EiNKda0ZawXtzvQ6EC290dm8j/UM0wKGTOmkJUmUDar/+cz0gjQLjpEm9tm+jh2ZhXEgiZsc
 z/lK58iNrXw==
X-Gm-Gg: ASbGnct9m81ch46sIwkm+YpUL+TrFwaDkpprbuaX9Elk9ftNiZusH69kJjgKrCZ7vrA
 DL9incwHFesfuj37b+hFDvUsZm2Jv5VumHB9d01y67OGwIzk/ex20mSSABBHfd9gSQ/IoQMhMRp
 27PZ1bHPo3+JzOzkQiqXJ5/IeynM0zoh9yhany+ME3DQkH4JVaFgIAV6WATVcM3IlNovxOhyHw0
 QH+6PcstVLApcY/jPvI2d0EENEGbIJ4yoZeeFKXQK6R+h2rH3OmO450Zoln8jewAbi7MPSxQHpQ
 jhf5ytsj07K7QZkNwgVtkvhU/kcvef8imTsIyb/u/fOd4/uQVAOxnU448A524mjWN1FJiNCbjOT
 lHnypJrs0BV/ieShh4rd1rvaxYEPjcvHKN773gizTnM7LNF4iD+eMb5yrMMrm6vUIAUij3rY9XC
 U32k914yR/TF2Wvqwxb1NDYQNxjS7YSY/MSwGcJQ5bFsdYw/ZaCDfJGA==
X-Google-Smtp-Source: AGHT+IFApPn6Dh96fqRXcjIGHqRxteYfW2Ih6XJVhmqOm0vC/WSJ4vAgpMhfjPAF9VAusNd5lbB+qA==
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47904b2c2c5mr22072355e9.33.1764066824607; 
 Tue, 25 Nov 2025 02:33:44 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf355af6sm245789815e9.3.2025.11.25.02.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:33:44 -0800 (PST)
Message-ID: <bdbb568d-0432-4d59-bd1f-cf2eb20bc2a1@linaro.org>
Date: Tue, 25 Nov 2025 11:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: Don't assume accel_ioctl_end() preserves @errno
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, eesposit@redhat.com
References: <20251125090146.2370735-1-armbru@redhat.com>
 <875xay4h6y.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <875xay4h6y.fsf@pond.sub.org>
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

On 25/11/25 10:03, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Retrieve the @errno set by ioctl() before we call accel_ioctl_end()
>> instead of afterwards, so it works whether accel_ioctl_end() preserves
>> @errno or not.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> I did not check whether the assumption holds or not.

Indeed, on Linux the futex syscall is called via qemu_event_set.

>  If it doesn't,
> then this needs
> 
>    Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)

LGTM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



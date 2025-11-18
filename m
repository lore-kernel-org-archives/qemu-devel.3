Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3250CEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQs7-000693-OB; Tue, 18 Nov 2025 13:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQs6-00068j-Nt
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:56:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQs1-0004u6-Ld
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:56:10 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso4548281f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492163; x=1764096963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HRPXhrWNNSzG0S8YOgNc8B5Js6h82Eb3m4xTACfn0A8=;
 b=pU3c2YiZ6jKMRjc/X0NUQB9oJIFKoT99tSsTz4I1WHprN2NFThYmpb3hulSi9fjh73
 5dOhaHwYUgRvB84gr6LVYOHhoPJURUmTU0H/TViFQAgNh5N2WOlla6DCSJzbqqYjFvJ3
 Bg0y3RPilGlpZwo82je3Cfo2VJi3u+tBFGO20LF0GM3iphHKmz8xZzAzFhjiIlaEOyaa
 ezCD0ucN0cEBiqoUFMWdCN0Eb5iHCC5BeDyiIDDhQjb3KsIqhSHSCTsR6XNhS2DW0CkJ
 AJeE0pIcm4Toz/pErn60Vz8OtLy3L5ytoMs9X6mItil/vEcWO/0ADCTOmrCDPtbHEgua
 z14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492163; x=1764096963;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRPXhrWNNSzG0S8YOgNc8B5Js6h82Eb3m4xTACfn0A8=;
 b=M169ToBrh0j23e3K4gAp4rbakOu8J6jl3bcagTaIAG56bsc2VBOnPRp+3NlqIaQHx4
 YgfXckztPY6e7Pm5l1yHjlx3MmSL6/kdTsiP8xZwba6AHvYOT80IVIJ6KXkyge4gtxDr
 rMzc85h7OMCB71pR2VklAZhyJV/qdZlbF/fDWxkU4DlT48PhS081QdEGiiiLmJKWdBEs
 mEtV4T6ec7TTE5acIefS2ObRR9ElvRz1JCw4WPK4m81oODov5NTsUd5e6P0E7cbxSmYB
 CELDiTr9cDy+YgcTzac7Zgy5Tlmyu1kYGOJNic1oYbbL7LAx6LKFkhtTtDk178/5IQdl
 T2Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKAmfHylJ20VVsfs3gYE6DrqCeDD7mwaTYEGR+NB4g6EtDL0ZolvEo7t/qzVN0z3NJkbTjXDfHFGZ4@nongnu.org
X-Gm-Message-State: AOJu0YyMqxpFtNl90bO/LnFea5xR7IabO1fnDNLkUgHTXjgqJ6w2FYq0
 MwO7ss4ptnrDFySuvbhBi7qFO5Bn5gs82ltLOozb2Spg/D/hDeRhC++VC/fAVhm3gEQ=
X-Gm-Gg: ASbGnctFLhWNLSNBIEIBAwtgo3mQuMzzeXH435TkpkHREnHvOp1LwhPn2sa19+9AKk6
 GJjtugz5fDhkCrwHwdlCVk3jUgWSpGz2Q0oQruY0TD/rFcH3o0CPra8RNxU+an+ek98rOtrEU0i
 w4MGeXS2n6b6aRkk24O7Q8p7iiaUsIVvOR2TZR1pezYQK3bIep2OIb6T8P8POMotkfj7omcA+/m
 HdfQDxUDlTD2z2cdNi82fL1OJ4haBPaDAfz9NL1qSgq1OAkx4lK8dzuKQ06kHUnULxkm55I8pG8
 jh3lkZRYzEq+kLND63Iq5vq5KWeIaFcBUv0lfphg7UdFPsdO0Mui/VnBmUZsuylCsd+q5J1zHPf
 LioffD/QIWAAleQpqjiwRL3TSzZJYzxDaf+EeYHrro35h6dbKkgjrQis2UxlksWFN/7c8oX5f/1
 A6dAKg9r85qQdS3cJpNgrjmJpZH3MzIgrrylt+IlAROM5KEDntk+u8ICGVLls7skqq
X-Google-Smtp-Source: AGHT+IGA8duUJdA/Kn2BcV9VmmVX3do6Fr7r6PSccbdxzFnLtpdErNCOsTVCJSbmVII8kDf7kYWpWg==
X-Received: by 2002:a05:6000:230c:b0:429:d3e9:65b with SMTP id
 ffacd0b85a97d-42b5958a66bmr16973526f8f.59.1763492163392; 
 Tue, 18 Nov 2025 10:56:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f203afsm34314160f8f.39.2025.11.18.10.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:56:02 -0800 (PST)
Message-ID: <ce6a1c5e-04ee-4961-b47d-a79195a97982@linaro.org>
Date: Tue, 18 Nov 2025 19:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update David Hildenbrand's email address
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Hildenbrand <david@kernel.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
References: <20251103103947.384401-1-david@kernel.org>
 <eff54689-b1a3-41f2-bcad-a62941aa9fc1@linaro.org>
In-Reply-To: <eff54689-b1a3-41f2-bcad-a62941aa9fc1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 18/11/25 19:09, Philippe Mathieu-Daudé wrote:
> On 3/11/25 11:39, David Hildenbrand wrote:
>> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>
>> Switch to kernel.org email address as I will be leaving Red Hat. The
>> old address will remain active until end of January 2026, so performing
>> the change now should make sure that most mails will reach me.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
>>   .mailmap    |  1 +
>>   MAINTAINERS | 18 +++++++++---------
>>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued :)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B41BCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbug-0007aR-Cm; Wed, 06 May 2026 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbuf-0007aF-8g
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:03:41 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbud-00019L-Jf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:03:40 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6949192b840so1993213eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778072618; x=1778677418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9uIMSoLnJ/U+h2cPYIO2SGCRbm4NkKYBvZCHQynpY5M=;
 b=AGF/Jiz/w23nUpeJoGHQ9KIc/7bW8ILND1HViboUC2FzHr8LWIqZaV3PyKy54T9BNC
 yc5oTi7GHkF0/+uin7sXid9y6WgJHwiiWqwhY/chb/82CbKqtvhVs0zlf9/8IdMFbQIk
 tEVy6m0K2kH0VM4WkNda8ZA/3jOrRs+aq4xgBd/5n19a0VZ3S+NlUpnHgF2SPhEpQi2h
 OcLeEz/bBZcJsd6KOZf4ct/HeTWwPcGPA1E7UDX3wrFDtzIhivBCLqosKyCu0eE0IgM3
 m3/bLLeUzmioxCDq4u2/Uw06fAcfno73SEV6nMH6goaUUW6UHFNyKHrTfyE2OnuRJa44
 akmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778072618; x=1778677418;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uIMSoLnJ/U+h2cPYIO2SGCRbm4NkKYBvZCHQynpY5M=;
 b=Y7tme6+FV25eAgyia4bhniq754FqG7a0J9a2X3vzAAni5XxVr4E/fWGY6+QCzPd3de
 r8k10Die8Zlisqi4NWVvYwqsPer2+XLJHP98IXlUSsro96RkXpuwe4aZ6qP6kTdFB7Vo
 0uHi6FW16jnPwcdk/arcisxMnj4q8epuY9Ylues651mvhLlvilGASePTSuxIKfy//NIz
 /fkvMx2LWLS5TIeWtQlPcOFRGkmAljo2QXbZHIorLzTBolaaCZ0FP3acm1Zn2v0v6xMO
 WGiFKyGAEXY3F/Q6QVKSLaYul28/qiDbBsp9fsyCCkYt9MuDrgl4AZE6JpKb/4YLo13T
 JD5A==
X-Gm-Message-State: AOJu0Yx4X9d8LB/h8hMdvEZIjCKHlCJ49ZLXU39KX5MC3HLiEAi6YMUc
 vll7JOLLQ1/dF1G9q/ek5nF7KDU7NPqecYG3qGFc19TZL7iWkOWH9YFPJXgckt+Kf3g=
X-Gm-Gg: AeBDievF0u9RcRALMHGE7pEw+2BsJoEkQMjYurLMXmy3fqI/yRHLiDn55qncg6USpOw
 cYg8HsuHyiPnq7qntxltG3u7xWY5gWDwlgxnXGqK+Ji/RvXtF/P7JOlBIwVuoXTP/u9fkDHaQsF
 lTuICOBYN4iuaYgSVBPeB+RL799Lf26FmiiPDlsITkTG7VIosTRSPOY3ZGgXlnwfmd6GWg4/4zU
 YyBlaRklTzwWnUBwKE3XLtUrSppEis8dJx4U84G54XQxAzIAMp/Y+ERl5aNruFtUeA5a4xDbylG
 PmmHMvTGytoNfJH3GNSdlrNAZWe4FC/nQ0TUgHSgnn8VAV2wcMFOqsQ8C5wqMtpQUaytf829Yuk
 WAxEFqJ/TPqVW/lzzJAzg7KwyB9pWrxEvwcXMBv8V/5/W++Zucz/9a8UQWJfJTBUggwTPmf9laK
 IjlIQFlKSJlMnMfNTOGC4rSEe0iFyvMKsZLPxXBQMqaQ6Jp0ouPLnyju0Y5G5QtSj88gg6ZryCB
 CEybK1xpdUQEkoEeLyn
X-Received: by 2002:a05:6820:f02a:b0:694:84e9:4a35 with SMTP id
 006d021491bc7-69998d46b14mr1430498eaf.46.1778072582025; 
 Wed, 06 May 2026 06:03:02 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72cfsm9940892eaf.10.2026.05.06.06.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:03:01 -0700 (PDT)
Message-ID: <00f6760c-f84e-4fc8-a8c6-f04ac0a27a30@linaro.org>
Date: Wed, 6 May 2026 08:02:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
From: Richard Henderson <richard.henderson@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
 <c7a83814-1ce7-4092-8df5-0a845bdf5b41@linaro.org>
 <CANCZdfqofJ8J-0UQgRVvaM3C=swpbF=jfw8kApntNUnJBLSwew@mail.gmail.com>
 <7269f32e-2577-4487-a828-c9dd55d48e04@linaro.org>
Content-Language: en-US
In-Reply-To: <7269f32e-2577-4487-a828-c9dd55d48e04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 5/6/26 07:56, Richard Henderson wrote:
> On 5/5/26 17:52, Warner Losh wrote:
>> Yes. I've thought about writing test cases for maybe aarch64 16k page binaries on a 4k 
>> x86_64 mahine.
>> I don't suppose there's tests like that for linux-user today?

Actually, what we have today that makes this specific case "work" is by allowing the guest 
page size to mirror the host for various guests.  See

     /*
      * Finalize page size before creating CPUs.
      * This will do nothing if !TARGET_PAGE_BITS_VARY.
      * The most efficient setting is to match the host.
      */
     host_page_size = qemu_real_host_page_size();
     set_preferred_target_page_bits(ctz32(host_page_size));
     finalize_target_page_bits();

So, on an x86_64 host, aarch64 guests will always use 4k pages.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D95CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4mWu-00031b-13; Fri, 03 Oct 2025 16:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mWp-00030k-LD
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:37:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mWg-0007qU-S2
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:37:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so16814335e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759523829; x=1760128629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fNYRxXlyhDBtOijXkeyCOlrNdnjRK5t/zEM4Lt7t8/M=;
 b=Blv1v3Orr5whfc7vliRg01TMYPGHGW6hb0dBMNeqclZaaaHucgmKXJ01y57OPTPu5e
 AMEmhFyRQgtnle9O+iwVE1dKwuEwnYaO61Upm1+baeOGsVcc3xnApK9Pjgu+LdJ7OlEE
 xUR06pNSHE6l0WvynW0J3Pnvs8atDPMNbNlqZd8MRusuGKWbrRRU4wcIsMIGqiTQnDhu
 lr8YcBBbAglVcgtHzgdl+90i5PT9KmAsM3x22W6ISk6MGf75VfPl/dQPWYjinuIUOrVU
 YK4yS0BQ8xJ9AW3jUn3QpL3Ra0h4KDHxX0nnw1wduR6IFW75/rE3F+whBGDLOGcIH1x2
 wJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523829; x=1760128629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNYRxXlyhDBtOijXkeyCOlrNdnjRK5t/zEM4Lt7t8/M=;
 b=LS2vgUXOw4fST04VKj9q2ndNMHwijIjBgeVgwFILGY7OVLgsB4sIGGgHpLJzZbbg0M
 4YahtoFEmhbewH4Pl06hIfYIgEAwp7ZJv9wx/ENPvc2dIGnvyJPdhuv1FsMDeRzbhFbe
 xQ49gcGfPXUOiGdovGNEseDqn/J5uVa3LRVkQuQ6Iic7WscoadpkT0wp6wBCiZ/8LTa2
 TEXuPW/gneg9W3lkjSdyCSy8hDpKlctX2q89F71uk1c3qPVuy1DUTZm5K3BvsatXn9dh
 qKeWqjCIxBWQMUY+VmLPT23T2cVA8AcPCjmVmH54Km4hp1wlhcGbnE5HAWXH5EP+amJT
 /bVg==
X-Gm-Message-State: AOJu0YwXtADpvyF39xqXqDLI0+I7eYfgtCU5oN4L1X+eW9l9YXdKZ+rs
 nMg/NiZv9RE69X5gHd1+XrmyeLluwwrWTvM0kdUo+CvlyTk+Yu5czcZG3puiFSZFK2bAPf7KXa3
 XzNAB6jFxIQ==
X-Gm-Gg: ASbGncutekhEhlY3ix0BRSUTqXGKbT29y8lzeoBa6wcArRsqBMNmMrBqoaH24SYCKP9
 VpF9Vot62qhtcWwTqZBXg4SHbUibe9mmfJX//ajxOadj3XHH2ReCFfPumhppaQaaOiy3cBfX9Oj
 iQ9o+tbebz1TQjRx7mKrLUsTXRwUTLEcnQyZQL5CdevwQjsObiQ6EvP7NGSU92X9Ni/C+icQnPM
 yOxeFaUMK9kSomjFJEmCc0e7kLqMhZtTDis5BD7D7GGIi0H4IaZ/J2UoHcBLmDGRXYHFbG57BH0
 aTnkReWG0Ewy3wb3tH5w0pvgI7R5NzZsBaBgqOREuluhLzKes5QD3rcssLLdGatp2hi50lo81VP
 1UQ4O7UhTIa/Cqx8DB57iCZVt9G4tJxwBtI/hlxYWW1Sk0TuZ6FmyrJqGcawoYiFWCEYRWlGhLM
 MBV7R96k18PVVM5+07XHSrZiOGrMQz
X-Google-Smtp-Source: AGHT+IG728UvT68+4D+Tv3E6B6l6ElYPmXFRwaFbjT5iITREk+m8+c5T/kcQnUQ9F5T7TnYpk/RKMA==
X-Received: by 2002:a05:600c:4f08:b0:46d:d949:daba with SMTP id
 5b1f17b1804b1-46e7608b683mr16676265e9.4.1759523828719; 
 Fri, 03 Oct 2025 13:37:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b7e37sm140583845e9.1.2025.10.03.13.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 13:37:08 -0700 (PDT)
Message-ID: <9225c889-6f87-4571-b886-ddae24552dc5@linaro.org>
Date: Fri, 3 Oct 2025 22:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] system/ramblock: Sanitize header
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20251002032812.26069-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/10/25 05:28, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    system/ramblock: Remove obsolete comment
>    system/ramblock: Move ram_block_is_pmem() declaration
>    system/ramblock: Move ram_block_discard_*_range() declarations
>    system/ramblock: Rename @start -> @offset in ram_block_discard_range()
>    system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"

Series queued, thanks.


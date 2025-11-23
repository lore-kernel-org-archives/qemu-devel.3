Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B01CFD313
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 23:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNJV7-0002oa-5D; Sun, 23 Nov 2025 18:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJV6-0002m2-1o
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:28:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJV3-0001en-Np
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:28:11 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29845b06dd2so46772085ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763940488; x=1764545288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xjdAxfvc+iAHpF73n5dm/0Py0+bOUhIf2g4GhQmm0E=;
 b=PZDi6vJWyhkikEYfFoNXHi88R/AYzo/ZbBzUPXkZn1SAnW7JSdyJZyyLargtZVdQol
 k9+GLUEteP/vu5u0biQA1DOhTXlHbj3YCP8XjTZmM6iizm96bU0YKDkIzUYI7ofvWIiy
 c/0mJtTu9iNvLn74sogflEYVtmEjcdCcsg9fZtk0pFS0+/4SXtHsJLGCNDXTjKKk+cIE
 4aGQT/GSXPNKChO/SKMJY/QefYrFZXkQCImX0EYSQNX1geg6uJ1SXHEOoA50F99f+9XV
 kDfV9uXr/uVIM7F7K/r0TXU4azKq9RB/JiP9XYdbeslVCnc9j/MEyBswhIIzCrT3L1XR
 7wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763940488; x=1764545288;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+xjdAxfvc+iAHpF73n5dm/0Py0+bOUhIf2g4GhQmm0E=;
 b=Zb058rrNC2d+MnekOxowDaKjest/3nnk95A7UwLqiVnKbIs1ATGdqZ+KAX9wYifBr7
 4Ak/IG0od/UiNt9hzU+usYPJJuENt5Hsfg1iGZWyS5ZTxqf0C5HOUywUjA1lKtSCzwX4
 SLONGi/QqF9SRHAee+dVQpYaIx3RbnXRc/CfkSh3TBlsImHw+Mm6+J0+txODxENOH7Nx
 G6YMAw9PdrC12l8uUY1dhedWlQt1zSxj43Mtp3P7Tw/4D+iQ6iwbcnu4TE5l8BOgtSjh
 tCqnX7Q+ri3kFc+rFTGJOGBXBcXDsbLuftZCj5PTdtur5VEbNWeTN4tjJhFbqYQe/sJ/
 10OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhyFUG6XWu+6J+/IfM9gK7oPhxF3Cwj676L5OWGts4RFSLlDQzNDLobUuq5JoqLuOZKunudFvaL4/V@nongnu.org
X-Gm-Message-State: AOJu0YxwcqJMcqAIDcOzZ+qouMaQuKojOY5fCnO+symjE+p8sd401tSa
 Rucg6dBocHnEUG5lRotas6Iq3UBhpWY987R1KEhe2jSwUW+opKg9YGtjcoOTzNUUyeA=
X-Gm-Gg: ASbGncuNwkBz2ihBRkk3uuCzonUBLxGu/tSxSimkRSFEXGA8Ym2IQd2a2lp35T3fZcf
 owKcJc6Qi1BEbLtE5l7LzctEIsfpu5C90YzSU+Y796vrCwbXpeidZ4mhS6/XbDgA5sxM80dwbrl
 q0iX85xTKVBS49Xe1a/F3PKibkXXoeRbBbdqOwilptmXb1Cg1MfuWnSB9W5WuJT1MVtmo7/9dJg
 /YGdCveR2x/2wc0tojxFohD5Pkw3esd6xO6FWBesJMrgtTWq5GN3VhH2QxrzvL5Prc0aZLngV0F
 z6EcGl/WpSfsK8j5xXArJ4uyhZBVjhFJpmeevmdWgdIGz4akvvnbJWSsBOh5lXD/uk7rKwoxJVX
 yn6XrqomH4sm4J+LD8H8mN9YsO34PfLgYC5rt1uefo/ImGzjjV2hq/9MpOj/q1h1bpX3PCDCplf
 DSEbVTFa1GXFYbMCd6k9OdqkeTO9KG7MyaMzH7lS+zAxck5F5vUk2MymI=
X-Google-Smtp-Source: AGHT+IFC+cEqnsqd9G8d60D3xqTn/KAlqXTAlxUY2H/j1c2IypXbFy4FYyL7DoLBRHqYzP2I5YC1LQ==
X-Received: by 2002:a17:903:3204:b0:295:5945:2920 with SMTP id
 d9443c01a7336-29b6c575104mr105901785ad.34.1763940488006; 
 Sun, 23 Nov 2025 15:28:08 -0800 (PST)
Received: from [192.168.0.4] (174-21-128-133.tukw.qwest.net. [174.21.128.133])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345b053038fsm8338951a91.14.2025.11.23.15.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 15:28:07 -0800 (PST)
Message-ID: <c95e6f81-da56-4ead-bc40-5fe1ece54d3b@linaro.org>
Date: Sun, 23 Nov 2025 15:28:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Staging patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
References: <20251122002656.687350-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 11/21/25 16:26, Peter Xu wrote:
> The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/staging-pull-request
> 
> for you to fetch changes up to 6aef825073a751215de1ed410a5c94efa675f5ca:
> 
>    tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend (2025-11-21 19:23:46 -0500)
> 
> ----------------------------------------------------------------
> Migration pull for rc2
> 
> - Zhijian's COLO regression fix (since 10.0)
> - Matthew's fix to avoid crash on wrong list manipulations
> - Markus's error report leak fix and cleanups
> - Peter's qtest changes to merge memory_backend and use_shmem

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


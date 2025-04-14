Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B1C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HV3-0003vB-Cc; Mon, 14 Apr 2025 06:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4HUy-0003uF-JY
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4HUx-0008Nv-5r
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744628225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AU/6w6Mt/TK/rtTsO+4KvA3bUXlqruFH2A0OZ7uhg1s=;
 b=bumz265GMWV/FmDx4Ex8qG66JFtejgr0jofHb8W9kjjhHMvXYdrPI90bhv7/gx3X4Wx19M
 d7d81FI6On7u8JS2GRdc19c9b/fgCTdh7zo/l7abohybdgcKq2a+8m9e6MfDJty12kA9r+
 9IUrs6QUGQFONTQHpgIaiWffXQDxdio=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-AnXymfr4NxCZWlg8iV1D9A-1; Mon, 14 Apr 2025 06:57:04 -0400
X-MC-Unique: AnXymfr4NxCZWlg8iV1D9A-1
X-Mimecast-MFC-AGG-ID: AnXymfr4NxCZWlg8iV1D9A_1744628223
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c30f26e31so2820642f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744628223; x=1745233023;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AU/6w6Mt/TK/rtTsO+4KvA3bUXlqruFH2A0OZ7uhg1s=;
 b=dB4/p9HyvrlHlActThwtQ89Fhqe2pg1vk6cpaNz1++mV/yyX0oWNIPpVcZERPCHbWt
 aQtg72pqHOouxEH8D6KCgd/Yuh4tBPeWEwjM3t0mAElkOp4LlQBBtSAzkgCB3han6RSC
 fH5wVH1T+OJxnpIReZaSnRjne7euDWBUXpP+nBfrSv5ixPG6OfEK+IS7mnkO0J+gQLG0
 NekdSEZTH9nahpZpX4jL+zejokyYhQdKnJAc7qV8OAPjILH++KDCro35liAU0PLr0Ock
 b2nbnYqN30PoP5P1RF8fbssNMeGDiMrN+ia/XeQwqI518g0YYEhK9tZ+nnv0cOodjcNg
 y4LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUt11L2RKPzIACKG45/prfAv5iXSx5aSBNDV6YRjJw0hjwABzcuqKSKIC8Jq5SMMTWZxieBX6OVfDM@nongnu.org
X-Gm-Message-State: AOJu0YwGHgAVnQZ/ZWTONB3XaAN9WeIH9oLfXjF9qWlrL70WFRoj7JWV
 YbGapECLtQkGSiAIvbm/uZj+U6lxAXSPjI/KMWBP02kwxSvrqNrDFfPA5jnXm+bFSS1JoWIBoJE
 z2laCCOpmR+IulABZeu5q2wWM/rZI/zTFATGpmx6GGVs8NUgkQapf
X-Gm-Gg: ASbGncvA1cUV7be5aLIMfGnEQCYFxxB3IJU9XA14wM/SfxYI+VvRwVcnriIDCWcyNkZ
 bSNTcnFqDy7DmX4GPPovS/SLYKcrf9nlBg5f6c2lTtE6Y3UENpXjulboDbkmabdWuLSk7HcV2Vb
 TQjLhQ9Qfa1gdFa+D8yysoNGpJgmu/xIwR3Yb9iA2baSDk5BQI6gAxtKbBiPNb1v27ylGMzxG7T
 aZSszSQHLs2gBUz/D/wtQjPUo1w1t906a75aurFSiWuFw5tg0UDyPCfUlub71BbuxR5WON+j+KO
 GVzVJJZwky2AFao+
X-Received: by 2002:a05:6000:2401:b0:391:212:459a with SMTP id
 ffacd0b85a97d-39ea521207fmr8616627f8f.22.1744628222855; 
 Mon, 14 Apr 2025 03:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6GzRnbYHfsHjcYOVRGfR4i1sVbF1U8JrYq3DmXWXtf7sYpXMq3Kv+uuz1TD7o2eDncPJwTQ==
X-Received: by 2002:a05:6000:2401:b0:391:212:459a with SMTP id
 ffacd0b85a97d-39ea521207fmr8616607f8f.22.1744628222432; 
 Mon, 14 Apr 2025 03:57:02 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c6b8sm10730213f8f.37.2025.04.14.03.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:57:01 -0700 (PDT)
Message-ID: <4838b44b-49db-4f47-96da-52b9504b4f67@redhat.com>
Date: Mon, 14 Apr 2025 12:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/12/25 19:24, Pierrick Bouvier wrote:
> On 4/11/25 22:30, Nicholas Piggin wrote:
>> Do we actually need to hold replay mutex (or even bql) over qemu_init()?
>> Both should get dropped before we return here. But as a simple fix, I
>> guess this is okay.
> 
> For the bql, I don't know the exact reason.

In general it's better to assume that there can be other threads (and 
therefore you need BQL).

Also, Rust code panics if you access a BqlCell or BqlRefCell without 
holding the lock.

Paolo



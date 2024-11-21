Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A0E64004
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECHo-0001DT-Pt; Thu, 21 Nov 2024 13:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tECHn-0001D9-4q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tECHl-0005G2-Nj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732215132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E37ZIXZSznz8TCaavRa0nmG5qNOWsaN5/hS6/PhmAR8=;
 b=RJWaBWvWpKuR0CeRQeFr3z2oD/RdXrg3HinnQ9cGPAaDSY5YkI2Vf1XJIVzYOgTnOLtgJJ
 JJGymBwa97stVIcWr7+2h5uNQbwxc4hIDm9ZT/96RtXaXRcoWRQLdYakGTpXRnIIY3zX0I
 uKvjdvZce+w3q6AbYtVCU6csYs7H92Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-KtlDBd_BPAquYX2Wa6Xaow-1; Thu, 21 Nov 2024 13:52:11 -0500
X-MC-Unique: KtlDBd_BPAquYX2Wa6Xaow-1
X-Mimecast-MFC-AGG-ID: KtlDBd_BPAquYX2Wa6Xaow
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso8978515e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215130; x=1732819930;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E37ZIXZSznz8TCaavRa0nmG5qNOWsaN5/hS6/PhmAR8=;
 b=B6eu7zPcxGTtRMjLjvBZ8x9eaMzv39NF+Aw8Un0psHwamD29+RQL3nI4F7oiqgGu/X
 LLt7ryUD1hpCZqqzWzWZIjsnvT4ptvhRXJHpW+lZMkbod+nJvq2fpKjqmUNqYVMtqSj0
 Li2OJ9pI/M+zavHq4PtONVAT58XdJ0LYPEdsj1tvnlsxqksNdKjYCeiZ24hAqmUA7RbF
 DXHbco7L7do3Xk3ve2MRZEkUCEZfCs5KcCrGH3RUp/PvBueiLB0qrXLk7ZKUl8LRuOVw
 b4ZujHQ/tel/0GPrVb2NhTmstgSRHDGMuKRUN4H2bY8TlgsX3DsK1ZLJXMdTviR3NRY6
 BScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdys8ad1giOQphefleIp5kpupRS2WLKXZmTO8AuG5Ta3+ig3t1JR25rYsjBWFhtV+5pdmzycFX2smp@nongnu.org
X-Gm-Message-State: AOJu0YyhDeTx/vSNKAp8Mv/uP48+wXn4BGjhPHvYCey/NKwGfwneRQZ4
 2FD5Uk2UQOm4e4S1EBnrMJGvHGd26a5qXpa1j/9js8fvfTX6PQIyi3NeazJjViS8jXbCHWpoek9
 AdJBKNcK63ZXZjsFs5L1H9ejp/WKfna2AFC0pjRbW6cvSnf2JcRKc
X-Gm-Gg: ASbGncvAScjBwEojjjp2AaBRT9scsLZ8J3r4939FtH2YvPlHAx6NmxyE+rcOkkAsb6c
 OIPnwMMCZVZKG+DD3uXADv4rACCBKY57Ds8LVQ23X6luk081CG8lXKY+ugUKZ3+ef9r7dKxag2N
 XhovbaNh4jV3OIZVqNXqEZzzgF3AWFwGN4274ilfHSUs4PWncqdFH/LQqDxIgx30ktmK69huyve
 g8T3tzV4Riqe28KSuL2eP5W2aGZLeyqLWzR5234cmUb40ihpNvomA==
X-Received: by 2002:a05:600c:1385:b0:431:5c7b:e937 with SMTP id
 5b1f17b1804b1-433489d6680mr78492085e9.17.1732215130345; 
 Thu, 21 Nov 2024 10:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH6yE/9LzyKrNs4QmNQpVfVOlieyhYrgloIuktPLveVZbQXK3PoNXWW7uFScUVTXDu536rAA==
X-Received: by 2002:a05:600c:1385:b0:431:5c7b:e937 with SMTP id
 5b1f17b1804b1-433489d6680mr78491705e9.17.1732215129971; 
 Thu, 21 Nov 2024 10:52:09 -0800 (PST)
Received: from [192.168.10.3] ([151.62.196.119])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3a47sm285020f8f.73.2024.11.21.10.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 10:52:09 -0800 (PST)
Message-ID: <af349a3a-8a15-4263-9a93-180320daaca7@redhat.com>
Date: Thu, 21 Nov 2024 19:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
 <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/21/24 17:24, Xiaoyao Li wrote:
>> Could it go into cpu_common_initfn()?
> 
> It can, I think.
> 
> I'll move them into cpu_common_initfn() in v2 to avoid touching all the 
> ARCHes.

It does look better than the alternative of duplicating code.

On the other hand qemu_init_vcpu is already duplicated and I'm not sure 
I like relying on qdev_get_machine() inside the instance_init function...

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B10CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImz7-0006uy-9s; Tue, 11 Nov 2025 06:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vImyB-0004QH-E3
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vImy9-0005LJ-6I
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762862127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGgiowmDCPt5pBZQwvd890N8BsFgh9ETxA9LPRZN7Vs=;
 b=BEkP56SjWdsfQKwq0VSfw961iAB7XssMwGT3Y7iJ8ynDOB+VG0+M9Pf4n+T33J+rEt6Pys
 4K1YN87id3xRJOWTQJEaN7NgRaqk23dto6QNvABydkbNV8EkYUk94oZoqL0uEgMqaR5Wej
 jgOhaOapEjKoPQREW1Cf8NzeMJhXEZg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-3iDQ6dOLOuSkJqL0tCM9Qg-1; Tue, 11 Nov 2025 06:55:26 -0500
X-MC-Unique: 3iDQ6dOLOuSkJqL0tCM9Qg-1
X-Mimecast-MFC-AGG-ID: 3iDQ6dOLOuSkJqL0tCM9Qg_1762862125
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-297dabf9fd0so37617975ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762862125; x=1763466925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGgiowmDCPt5pBZQwvd890N8BsFgh9ETxA9LPRZN7Vs=;
 b=o1rBPVhPzwX30cp0PymNKVt7vlMpD6hEdEJNYRuDcaEbfqFcczSRlE690wTyomI+vg
 JWFrytZRSEtbxhcf721vo16IxPmqilhlmwIbT7HeOQ2EEtR2eVT4m5eAWw79CcqGQqJ9
 lebGIf+Xbw2c3hwkzn8KhtWYjcjKJ8AeLneGAsdqguU7+YvdGoaz9EmOzNKz/8qtUFFp
 pJwIsTnmc+No5NfVhHdeB8GGcgx7mtGJ2+sTdkzzcu1CwjFNmxsvK+JsFQHg/+eMhFgF
 h1kH5xNbztJyb5hANsdplXuICzOyiGMhE4S5yv+CXovV7WctZt8t8gumXrUD57plCv3E
 k0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762862125; x=1763466925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yGgiowmDCPt5pBZQwvd890N8BsFgh9ETxA9LPRZN7Vs=;
 b=aP5P8x1WvHqRFnuUaQuUWYoIvg2ydhD4VbaO13RPDg6FfmhjHuAjXDGu4iGF705YB4
 wnsF38MOMy2JiFX5ZT+r/jFJ7Xb8ouiPibeK3E03fVPNOY+itRWuYGU+VharZENeDPBv
 t6uLY2AV1kiwU+Pjf0LHSlJjI6157eOzirqsrDuKaOWbCz29b/USrB9FQ2vrmma5bprt
 Jk9B6pAianpyWXHPzw8faWBUouOpPBA9fqazuZTLPsfuxfAi8YXINGgFkrfcbyLvk4b6
 QahHJARhm6lLkegYfAOqtnDQ2AO9MleSlYwYpGikZRtM7bdUYTxMZXH9S3xbSHd/lVrs
 0T4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+gDrY9b3PNTnM/bODFDZ8Ir5f2AMe19dRLmBCJG3sIdERGjlR+k/kA/fHg/HG+tOKglH5lIOzRzC3@nongnu.org
X-Gm-Message-State: AOJu0YwAh0k3iMbQf11z1DoQ6CZlqbf6qXc4Qua8z8jZn3EUMr3uCaih
 WQwmnnFo8FC6rTMt+UjOVaVvqhFYLgbjeQd7XKLgjcjSb2iVDzv+PCIU9Gh0lGScqkny4LRF8Ya
 VNE6dEFAPHURuAl8joBoi/C646ivQ7Xsqx6RPb8ntIED2dGQpANPvUEum
X-Gm-Gg: ASbGnctPX3S2zzrxmMJkPa7mue+J3j7qBNWIq/XAOidmZoRXXnzv7Sb5//Vyih/O1Wd
 JeoamrQXiK19nhqxKVykwn+HLykYTGyW3SR0vYQq7kTXrv5nZmsLaIgpTEdZInUZOZ7p4jZVMv3
 QQ9tYB8+sfZWxwXbroVX8TmV9qQ8mR9wKfePMFyZ1yGZBhsxo9/C894HiWfOdUqtfjul6dgOqRb
 8VkkONAW7GUSYzH1qW7kVz8SUPri/gIoiwfqOfO7z8n5wCxwWIZmmH+UPwgyVyctraaAxpWU4F+
 y4isHyMACvEpxFojOy849JDK/cec8bBK6KbBHZmS0gos/2i6tDtUIC6axlEe7AKvfHAIV+ydvLY
 B+ofZNccMP5p9qP9/bpycv0vrIe/HaCqfreWZXYQ=
X-Received: by 2002:a17:903:1c7:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-297e5411a12mr151114895ad.6.1762862125409; 
 Tue, 11 Nov 2025 03:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw8jKEgfrtBGTp+Bz7jmjeTDKyqWvqu+8Yp+vqNaPLtJtxSIaTsSYdhfBfPWvvsz171jIJMg==
X-Received: by 2002:a17:903:1c7:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-297e5411a12mr151114695ad.6.1762862125063; 
 Tue, 11 Nov 2025 03:55:25 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2965096b90asm178283755ad.23.2025.11.11.03.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 03:55:24 -0800 (PST)
Message-ID: <7fe42ed3-4247-4406-b728-c6ad37a28545@redhat.com>
Date: Tue, 11 Nov 2025 21:55:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/cpu64: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20251110161552.700333-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251110161552.700333-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/11/25 2:15 AM, Osama Abdelkader wrote:
> cpregs.h is included twice.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   target/arm/cpu64.c | 1 -
>   1 file changed, 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>



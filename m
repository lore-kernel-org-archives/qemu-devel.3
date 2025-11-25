Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F8D0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqkf-0004SZ-BV; Tue, 25 Nov 2025 05:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vNqkd-0004QL-4m
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vNqka-00023h-NR
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764068302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CZ3HFICZDo+gnE0K3J3456HZv+K/rIBBnRXqD/SRhys=;
 b=H+nGvOXgkQ6pBexWqEWaj2LczSGnvxpjEiT2/3eFP6VV7GxoTuOVdWzs9dwCiP+CN8w9TP
 sc3JQc8CWs6QcPCNb5lGPqOqC5CYIzdcY7fpwRtFAc5eylwTG7SLPpEf19TSUptZYDBRxa
 mJUCn9febiJbe/eEDLUuSWf9BtqGx80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-KPo3pSY6Mc6oVfe7Q5g5zQ-1; Tue, 25 Nov 2025 05:58:20 -0500
X-MC-Unique: KPo3pSY6Mc6oVfe7Q5g5zQ-1
X-Mimecast-MFC-AGG-ID: KPo3pSY6Mc6oVfe7Q5g5zQ_1764068299
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so25019935e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764068299; x=1764673099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ3HFICZDo+gnE0K3J3456HZv+K/rIBBnRXqD/SRhys=;
 b=F8a6jJ1UvcK9NoXh8M3i+jEb7DVeKPq0CUaA8rbXHB6bExG3Vr/bLpA5+FUcc1Uueg
 XIKBXk5GniOAW4ARaua7vC1aTloRqIPdY3Dmo3IeboXfKm2P77w3w2qef89oBl5am+3e
 /fQAhm8+0eksVG68tGLL89xuovLTGLrlfIuTvU+fMNHRMPQLDk/+RtsDcph++yRfXHqg
 IajXCmrQGczrBFAELGTTQ+2kz2Q2Gnzw16AnIdZiKOz+sm5k1Q0mywpNA/qigz9UsJd4
 YFabST3adaRvDr1XzG4yPf9kGvvrb9clJRCmvjKvQCX3oPRyAPsr/sXQyU8+T+0TgM7b
 3mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068299; x=1764673099;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ3HFICZDo+gnE0K3J3456HZv+K/rIBBnRXqD/SRhys=;
 b=fdNdFqdJ2TYlmlPEuys/5bcSp7nG2Z9vMbPguOVRE5ZQcUdJYPHPljTfxNoD76iNP8
 FzQB+g91mDup5X4xPOo05iqG382LLOZC0lLs4UyzymJ8ZT3/Q29cfm1dZZq2WwVbtbbl
 AoKKhQ3ir6fOgCQrm1Mz0K1dIluGKImJj3Y1tKxWGSGnH1BZwK0lNBiWI78XU/eE8xRx
 35uNxF/tNJezC4ehhWiZ9ALomSwHPnrz0Uq2i9+7G4n867panW3GTPaQtUNtPfCnt9Gb
 5Gp6FIx2j5Lw05ZFrmyqAmzPgZoNoefGS0KgPnw1ja/pR2iSyAuOaKbgv7Yhj9FqIX1F
 Fzog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhBiaWwYN8yRv0Lo+wpQTBBZAZLjWvioqvYHwmlgVmtizv/xwPSunTV/zJUls9eGdlpqxMMJSpTon3@nongnu.org
X-Gm-Message-State: AOJu0YyMg+78YYStu3qXZkdrTFVZP2tdn9ADkUIsFy9EfICd3Sq5O5nm
 uExkQF90HEvUavDWiKMwCQpu08R4ouT2Pp628PdDlXsYSM4vIDKLjFkMpGyQthHgpWOr223jtt+
 2rwy7qdlQyThK/Ovs9XzAfA8ni/WNmSaED3QPDVlxVOwLSEqOU6HSjJRv
X-Gm-Gg: ASbGncuSBV5ybQ2sx+JqRTb27x9pJAhtSQUcNpPg0f60UFXDpB84Dd2Nwq7zz6qehqP
 8CDveVept4PnvvJN6/WhlPo9jPIGetNaMaequmMwlgresKEDOAEwLdjj+aGg3MOHVulI5QiW110
 pau/B99OX3PLwUMtMC23o9/d3dfQ6HRKJrDaLgT0qzO4k2tRE/qXNvtPm/YbA4arrgPuuTuzhVu
 cXiENYJMHNKc038Mx5qOsrdhV+dVUbypz2eloz49Vb5PW/xTj4Syenk+XildvwxFunO/2m7IXVY
 Ac7IGwoGTQC8b5APWNT4/2imUK/DCaaoLnRHw0Dcg5ddfGFe8uRBrUkP4/GglsdlMMXX+E8kxCX
 8pOeIefI=
X-Received: by 2002:a05:600c:1388:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47904b24113mr16560185e9.28.1764068299316; 
 Tue, 25 Nov 2025 02:58:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQwm12eryw/HUygv/P9gmCjk4z44BeBJbqG7DcrtRwtLjDMm3ne62dj4vuIp2i72djWeMuwQ==
X-Received: by 2002:a05:600c:1388:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47904b24113mr16560025e9.28.1764068298968; 
 Tue, 25 Nov 2025 02:58:18 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm24765654f8f.7.2025.11.25.02.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:58:18 -0800 (PST)
Message-ID: <b33a0b0a-6e69-4304-b5f5-dbd68fd241a5@redhat.com>
Date: Tue, 25 Nov 2025 11:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 05/12] target/s390x: Use little-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20251125105434.92355-1-philmd@linaro.org>
 <20251125105434.92355-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251125105434.92355-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On 25/11/2025 11.54, Philippe Mathieu-Daudé wrote:
> We only build the S390x target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.

Wrong endianness in patch description?



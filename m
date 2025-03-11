Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3cd-0004yN-Pw; Tue, 11 Mar 2025 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3cJ-0004jd-Gr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:42:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3cD-00088V-9C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:42:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fd89d036so114381465ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741714922; x=1742319722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tZTLKdtldU+kE86TWBrWWCozbm/IRIbv5m2vD1/qsDk=;
 b=cuKQ22SinVcUwNeJgiHVION9FQvTPRshE/ASn0gUI5gqrjzA9uya0zBzRLuC9/Vhu7
 PF7vtxuBcyMw6X5qfY0Cj8BedRt76w2c17qgDdrtZRw8j7A9bBFsUl5J1nBprVyYvree
 wflytl9n8az/BDdD8cA3GO/gon6wrTg0eh+BfOeNvIUhGRngjT9IEMxeT/MhqZ5V8PCO
 58jhqkg+cIaQPj9skyGlLiADR/COUHoQEKo9Um/l3D02j9+Yit4P+BANehelx8TYWKv7
 3pwd+6VwUVrujS6GE95QTPrmTzHCTDz3kJQUHg2rFjTZQAe0pz+nd3A8qk5DmMDYecy/
 6Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741714922; x=1742319722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZTLKdtldU+kE86TWBrWWCozbm/IRIbv5m2vD1/qsDk=;
 b=rvMVtP8a3kqXgU0dcypAuh8L0Rsyc55aptSvKPy9VOAX1vHzwQ+06QSLl2E29gTlqm
 qYityiAQUKUC3tlSQ/vlonBVCUN75PfxS602b4TLn4nvmXa4Fa5r2bUL9k7AXm3/evPu
 z4dxONT3rC96AA7lVib6I6VZApudGQvvthnEr9409pHbUoKiWK+LD+t2PzXy3K5+7rZw
 T4iPyBjHsN3jq+fUaenDem2x/jIbMTNNHPcuxJZSGDTZ8n/7DPJ3/Ccx14GI8ZmC7/z4
 LFC9Je0oq3TiHp4coVv+1s3nLP1N9GglxY0zuPe6Bd8WFamcPGeRBE4sWK/b+/vnnX2v
 Ml6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL4ARhHpjrV9lQBJ1bU6X+ki4EjTUttlP3KYyGtMwmnBXndASkgrfg4+Zf6PzqfBSle6MAQoB0lMed@nongnu.org
X-Gm-Message-State: AOJu0YzyBJgoqmbhETLHtuaIYNbby47MgHohF3vAxD7U89RfAvjL30Jz
 4WJHIR0h5HqRXZJY4AOrCjMPKUqkpEjBvgTbGCXUC+MSm4ErYu0zGOQ4MUQfWt4=
X-Gm-Gg: ASbGncuc6aGXyiKZ0OvEM/L0CuHS6H9IE8l44sWJEeClIxqrbG/Wu9i3FRUDLD9JLrd
 XTHZp3yvOZVFn40kG3hOtvq+WcSbO+luL3QScgPTp7ky6hqia0yde3Xbcj6GUNLt8sWmHXMowHv
 Y0fC9y5HUkEtbtmds/UTO2GrsCtiJY4ywpWSnyu7CzWvmw7lAhFb/kPoJ9qdSmYSld49KlpLZyK
 FODv7Gr6J5cvprsfrTaVWDiFFwYCGwGmD+2TlUAMatjGWwEmVMTn4pMypIvy3Sz3h9C6VenJ08E
 FYAWh+7J8vA7jNt0uNMzfvxkkwVbyNfoarRQ333gJpEKk3Xyb9nvrTbUKaboMouhikXfDbHQyY6
 A/O66jhTl0e0NTh4VAiM=
X-Google-Smtp-Source: AGHT+IEtZiEfngH1nvPM1uE6aMEgW+ajeQy4eWnIwDUg7Fnc9anWtRB5LIVe536SQqxwl4a7nn4dwA==
X-Received: by 2002:a05:6a21:1fc7:b0:1f5:915b:3e30 with SMTP id
 adf61e73a8af0-1f5915b4032mr4678930637.22.1741714922439; 
 Tue, 11 Mar 2025 10:42:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af52876259fsm4853146a12.44.2025.03.11.10.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:42:02 -0700 (PDT)
Message-ID: <79c77cfd-96ae-4d88-8269-7651d9a214a2@linaro.org>
Date: Tue, 11 Mar 2025 10:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] arm/cpu: Store aa64isar1/2 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-5-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-5-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 44 +++++++++++++++++++--------------------
>   target/arm/cpu.c          | 12 ++++-------
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu64.c        |  9 ++++----
>   target/arm/helper.c       |  4 ++--
>   target/arm/hvf/hvf.c      |  2 +-
>   target/arm/kvm.c          |  6 ++----
>   target/arm/tcg/cpu64.c    | 24 ++++++++++-----------
>   8 files changed, 48 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


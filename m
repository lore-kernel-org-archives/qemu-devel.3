Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3232BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvvl-00008H-Eq; Tue, 11 Mar 2025 05:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvvj-00007a-Vh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:29:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvvh-0007Bt-QG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:29:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39127512371so2901879f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741685377; x=1742290177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU4h8bnalSBJAoWEEZWV0oi/XrH640XTNAd7zDwjD+0=;
 b=Iy9gOAYuhaObzxM3FSy29jwHSF56EJ48Cp0C3UDoOMl6z3ttpYFGNeKIv0L/ZnDen9
 wEiQSh9CG2OTxCQxNjLVbOar9tQpdCmzAfokTrZFc+Q3t41Bo77JtTc1xbIijGRADqFe
 6dM902EEvY64Fww02YL4OJKMtAgiycn9WSSzwfW8GIiLT1Q6cjBmf+vC5Ey3TtCYH186
 s97b5q1sWy/NLah44gCbhg5yvrTTeIjj6ADMTP4Pj0RLg4szM4vNE/dp6UIogvSGnxOm
 CvsULOvg2hUf4xVws8w017Or4TeIB48d3225jmKUfoMwX4Vb7FuxVg9FWjwdmvE/xEDL
 PKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741685377; x=1742290177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU4h8bnalSBJAoWEEZWV0oi/XrH640XTNAd7zDwjD+0=;
 b=ULxJzcIvzpwVAuq9FcuEMlrUCGv6a73EvmaRERibXR+VhBH1+YrqyaXiUdbD1EdCms
 tCf5Jwo8nJU+FA+9udy4nM9mDBIKId0TxPsyqGIYxBhipAEqbsvc6Td2SqJkqHbwJloj
 Q7IzL1DC2l65XZfD5uuhJY9L87nz05pD0CEFzDCJE5kRi7qBn0Tu3GBMxvDHGQQKbFCx
 XmCkfRxJDe2efTgS5QjeKU7jezjkTjaZ0WUykbuc4JKyNqdggctU/8HrYqbGqTOfug7C
 SNVUs9O0fANZiSZfQuqOKr9DdIwOUzueW+6TUXRsKV1DaBHM4pXyVXVkvFCYBNfRd/un
 +eBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXjTplhGUc3svxz+q79wjC3BS92z3d5O0nW2MxN/VcQF6C7mGhsfB2nAd+yXXSMO2wVt84QSFXI7IP@nongnu.org
X-Gm-Message-State: AOJu0YxqSW7Vb5s1AFuMY5G2rAPfpg7YHr1UWvYXLV8WnZX5ddrrdE/A
 I3tIH9L/k3oi6VpRZQTBclVtd6mJ4ceaktivADPoUwdBJBZ0ZoQ3LtCiiPZ4s78=
X-Gm-Gg: ASbGncu89b00OqD2fhcPBo/RH6x5WR1ef9thRicNFoJ8exRPsl8Lisz6lr/DsSrKQOK
 JWvLDpNHqNx9Gx3jzwRFZco+VqjCgywKHgIdckv9u7tGmlTpnK05rlRqvqoWTQmRALBIk/cgyoO
 klT8fAThw0LkoIGimJfnkpYeSe6tk/Sd7VIYCC2barPjJw11hfrZeWJZiBh55sVAHGLq1oplgql
 pgeckW5e7VnDOsNRv7fLfiI1L8lttXoQslP8Mvghv/Ejr7yp1EIMwp55kj6SD5cjKvVtprTDbxc
 v9K/hzP/Rvz8/DZXccLoC/yT/4oxGWCnFc2DUnNtzAtrFtYNKsoLZfblJ2cJDE1giJh+U1Br8+t
 VpqJhCvUjKj0f
X-Google-Smtp-Source: AGHT+IGPXeK051B+6rSXYGYHzrjQFN47BNtVvZkQZGNmfg659vV0G70cKJeC91vefkATU7bas6becQ==
X-Received: by 2002:a05:6000:2a5:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-392646936demr3645563f8f.26.1741685376930; 
 Tue, 11 Mar 2025 02:29:36 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba8a9sm17525416f8f.9.2025.03.11.02.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 02:29:36 -0700 (PDT)
Message-ID: <82b24b20-91f0-4b2b-9ac6-226cb9704ca1@linaro.org>
Date: Tue, 11 Mar 2025 10:29:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] scsi-disk: drop unused SCSIDiskState->bh field
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 pkrempa@redhat.com, Hanna Reitz <hreitz@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-2-stefanha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250213180043.713434-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 13/2/25 19:00, Stefan Hajnoczi wrote:
> Commit 71544d30a6f8 ("scsi: push request restart to SCSIDevice") removed
> the only user of SCSIDiskState->bh.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



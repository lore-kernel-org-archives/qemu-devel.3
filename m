Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB6BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcMr-0007s9-H3; Tue, 01 Jul 2025 10:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcMb-0007gt-9k
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcMU-0002IR-Mu
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751381607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYRGg7kChBiTYVR+GrrIpqMbgRiT6csn/NxCSHKLDvs=;
 b=Qi19Cr/7AzGiS7oCZOibQFssZ+iS1ynFRk0WSDhgc7Snh4JsaLKpIl2Km2Ooyk1Lt4vla6
 D9pn4buuHUhNBPTIr6Miy2VW4brO5jjilpFj1cuQNe/Dk304QTG44xRvA9z8zC+bwIke0C
 JMtFRDVo266JU7wnn/RjTv8XtkqYkGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-F_NgOKeONc2bY2_qqVHG-A-1; Tue, 01 Jul 2025 10:53:26 -0400
X-MC-Unique: F_NgOKeONc2bY2_qqVHG-A-1
X-Mimecast-MFC-AGG-ID: F_NgOKeONc2bY2_qqVHG-A_1751381605
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so37021075e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381604; x=1751986404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYRGg7kChBiTYVR+GrrIpqMbgRiT6csn/NxCSHKLDvs=;
 b=pbivUW0giNCqY/jFqkCSn3nXYxti65Tkpb/6GR5ydbB6BF7LuTmrdwa6C4o60QcOWP
 LOHw2vqZmgxI25WIKo8FRat97IL9Cf8mK0anqVqeTdcg4h5sVa5bCysIytLwvB/Ns1gE
 zJ+fQFnxhF1TVcnOxdp76q9yBc1He68TOL2BkUSM/PDUvf4zsm0IGCiy6fbu9s0M159O
 XJ0Z2/cCDLZ0qBxpHTK1zSWCeRckuUSbbfSur0kcxGQsFSAq0SwZnwkmMqn698dO8C51
 fAdLc2P3G4vjMedDbzRhZ52Bzx6KUN6vu/cQdKFNyttOzwos7E3HUizREupVXA6LPyUx
 GxbA==
X-Gm-Message-State: AOJu0Yybzmo0rtnyI4+NIVTLyPVnAlc14ZrUtv3l67MJGBIu5rh0BNSd
 o8cnyJZvuWlh+YE6U+FVw9AoFCbAvcMcoDprCQu700ano6mq5bNIGbG4JFrHBkuepTqcTSL4zuC
 DI4SOpeGHGuTg3v+QpInGnBQnZgrMCU7XSnmPhOsjAPOFSpIQEnu8cx3FvjPza4bz
X-Gm-Gg: ASbGncu8sby1BpThm9AUYWoF9AqjsadOR6rMNTQm2wCzP/fVpyRJMgtUVnDxG8EWbe1
 +rbXR4MyC3teJuEHLvpN4cbS/Ox3zp3huY/TR07Iyw4gMckK9DxmzIlyQKP3rmRwM7YOMvYD4CT
 SW9Jhop5LMftVLv6NSEhEsGN+bQrDf0THNzRUbZ+IgMNa8ck5dbcLjp+usXp96dtUbSFwdurI5y
 2yTGQ4OccXgQVL5Qqy2SwP+6SLaDoA5z0S7XbyXR5vgflDUEyr+9GycBWzW1hgOgrAn2Dck6BBA
 c3po4/IzG1QWxne0/OOGD63Z3NpyKtQ/yl/UeGDv8N61HZ9a3Yi9/z1Ixj9yFlrQ9nLdyyc4dwn
 /9a2lIdt773Cq1+qR48Y/QBd9aoS4HG1EBN4o49OL2+SRntP8qHM=
X-Received: by 2002:a05:600c:19d4:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4539517a717mr153607465e9.12.1751381603910; 
 Tue, 01 Jul 2025 07:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyFeaEk1HMpqXJqwNa8tzGQ58+NloNjEi1a9zSmDcnX3WtcBjSWGXPpOKzdbvF7WEAypJ3CA==
X-Received: by 2002:a05:600c:19d4:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4539517a717mr153607015e9.12.1751381603488; 
 Tue, 01 Jul 2025 07:53:23 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f3aa:cbe1:b363:ae39:fc99?
 (p200300cfd700f3aacbe1b363ae39fc99.dip0.t-ipconnect.de.
 [2003:cf:d700:f3aa:cbe1:b363:ae39:fc99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b35309casm14021705e9.1.2025.07.01.07.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 07:53:22 -0700 (PDT)
Message-ID: <efb8005c-a40c-4e47-9655-2592615714bd@redhat.com>
Date: Tue, 1 Jul 2025 16:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iotests: add test for resizing a node below filters
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 fam@euphon.net
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-5-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250630113035.820557-5-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30.06.25 13:27, Fiona Ebner wrote:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qemu-iotests/tests/resize-below-filter  | 73 +++++++++++++++++++
>   .../tests/resize-below-filter.out             |  5 ++
>   2 files changed, 78 insertions(+)
>   create mode 100755 tests/qemu-iotests/tests/resize-below-filter
>   create mode 100644 tests/qemu-iotests/tests/resize-below-filter.out

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>



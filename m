Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63D4E6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wJD-0007iw-Tg; Fri, 01 Nov 2024 14:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6wJ9-0007fJ-7X
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:39 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6wJ6-0005hK-1L
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1730485407; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j+fi02N82g4wMxYP7wQJc0d3A/oJbj7r4/oCB30Q6lWo7TCczym4ev4UNFjOVse801jgHn3lnqyCqr25fO5kY8D0GwNzZyybsNPeou8kasMSo5up27zKUgQUnFlaFgpsNV3/OJ0Ab2O9gQbceNsCKB/UbT0qRHLFWAWKZ6ASG+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730485407;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eyg2sKZ8tBZJnkc0qVebvV2qHARot8VXSqqLqyN50qM=; 
 b=bVcny07kXmje8xZlsnNzaTh+MvwJGw1nNK3jUGXovccD8Iv4Crb+IkkPwL4ze5KPX2gC+kXI1LQZHSlHB8aKLv7433wfaS42LBcs3a0Zd9a1bdEatpqwBIcR6RF9RsMp3VQvLqPVQe4nb2EAztEfIGxvLcVBGkoGx6Kbt49i5bo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730485407; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=eyg2sKZ8tBZJnkc0qVebvV2qHARot8VXSqqLqyN50qM=;
 b=M6zr/vaIpVDDKf+SfsNltuyt/1CSiWpLJxuMoyXMHARG4CAVc7NbtTtl00Pkm7ry
 yN4FRo3dsXZOPtGaPJBhlrl7f592tpBbj2A7YO54/UEYpU09bEzAv+HkDDDwjxMq17R
 p+VkvK2LgGq7bxg72eMbvBe+ZXKz2XmRkEti6Bwg=
Received: by mx.zohomail.com with SMTPS id 1730485404923421.850459609931;
 Fri, 1 Nov 2024 11:23:24 -0700 (PDT)
Message-ID: <7b4c6712-ed37-4973-88ef-5ef5efdfa232@collabora.com>
Date: Fri, 1 Nov 2024 21:23:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Robert Beckett <bob.beckett@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
 <87ldy2ho24.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87ldy2ho24.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/1/24 20:16, Alex Bennée wrote:
> Also what is the subtlety behind using both stride and bytes_pp in the
> calculation. My naive thought would be:
> 
>   fb.bytes_pp * ss.r.width == fb.stride
> 
> Can anyone enlighten me?

GPUs want image line size to be aligned to a power of 2 value, like 64
bytes for example. This aligned size of the line is called stride.

GPU's DMA engine operates with a predefined granularity when it accesses
memory, it reads/writes memory chunks that are multiple of a stride.
GPUs almost never support memory accesses at a granularity of one byte,
like CPUs do it.

-- 
Best regards,
Dmitry


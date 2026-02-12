Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C927FEB48FC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 11:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqUR6-00030Q-DX; Thu, 12 Feb 2026 06:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqUQt-0002oS-7m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:00:27 -0500
Received: from sender4-pp-e106.zoho.com ([136.143.188.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqUQr-0004QH-7y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:00:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770894009; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OOd4guMZ1l8mkJaHOYd4U5nzH0vE1BSjtLgGzLuAufrthY55JZ3j9ganpSgQAcyWllNtPlvgjDTUiHY2EdR3gsD8TBdd01h9XCam1azL52664JV+BEya3gAAdTJ3Vea8yjl1JaDp0yEjd9tW9BWpJmDUUZLkN3YU+YVDT4LlQ+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770894009;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1WlvaQIcxFnRGMNhnpCXnjuCtJ4TmEzuk9m3wN+KvLI=; 
 b=GG5iIsk2J7w5PV/fMSiv7g1RbvGEy/Y0hckkwG0eCLZvol4Z76lnoprl5uzJrYJmqEXADa/MosdtxvqXlnqwn2szttoCSbK9g7qw6HAckC4lBJA52P9NpmMHIDH/WUAqNjPDf/hIyrvlHUPw1HhTdGe8yCxLzTxoVbTGSk10eEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770894009; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1WlvaQIcxFnRGMNhnpCXnjuCtJ4TmEzuk9m3wN+KvLI=;
 b=Nn8N5XvPa2nEwn5BidVpqXmhhAa66q0KLlYfeMusb8iLQK84ZUKQHsaJp5ohEE0Q
 cdgto70X6mUIF1401pTx6/j4AaR5rk54z7+oU8dHJgRynR8vPShQB7HQHz1SmLdw0KD
 c09xlA9lVobk5Oy0XAHnBoM7hDKDEVxwk4ECArAk=
Received: by mx.zohomail.com with SMTPS id 1770894007680491.7960938503561;
 Thu, 12 Feb 2026 03:00:07 -0800 (PST)
Message-ID: <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
Date: Thu, 12 Feb 2026 14:00:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: "Michael S. Tsirkin" <mst@redhat.com>, Joelle van Dyne <j@getutm.app>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260212020117-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.106;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-e106.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/12/26 10:01, Michael S. Tsirkin wrote:
> On Thu, Feb 12, 2026 at 01:53:09AM +0300, Dmitry Osipenko wrote:
>> On 2/12/26 00:32, Joelle van Dyne wrote:
>>> Yes, it does seem like v1 was picked up and not v2. v1 was broken for this
>>> reason.
>>
>> Thanks for the confirmation. Most likely you will need to send a new
>> version of the patch fixing the applied one.
>>
>> -- 
>> Best regards,
>> Dmitry
> 
> applied one was v3 according to my records
> but if it crashes pls do send a fixup.

Alright, I previosly missed v3 and see that it's identical to v1, which
has the crash problem.

Joelle, are you aware of this problem with the version that got applied
to the qemu/staging tree? If yes, could you please send patch fixing it?


-- 
Best regards,
Dmitry


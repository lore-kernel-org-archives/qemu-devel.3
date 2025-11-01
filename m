Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EACCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF8Kj-0002M0-6d; Sat, 01 Nov 2025 05:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vF8Kc-0002LI-VW
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:55:35 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vF8KZ-00011z-Um
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:55:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 57F07807FD;
 Sat, 01 Nov 2025 12:55:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OtdVZn0GsSw0-jHls1aIy; Sat, 01 Nov 2025 12:55:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761990924;
 bh=cr25XkZumh6ykVPTHqCSGRmvM2Y9tbql885hFCBUniA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=guNcsboOllqQyvccXRWUHLhXCp/t/NinzpcqJ5gKVPnd9TObLLTjx9571/VMcRP+Y
 3fn3+oXY+A2KcFUU1bOli0C2jZaPRPe2SgAJjPwPs4o2DYMQ4uqzmwawSM8QvIK99q
 tI27L0AR59fNSQiXfn1mwuOSc/bC7xRufqvVInUY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <caae2b87-cb1a-49e1-ba5a-785251b1d21a@yandex-team.ru>
Date: Sat, 1 Nov 2025 12:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
 <184b9a9f-cfc2-4595-87c4-92e7c2c789e8@linaro.org>
 <b0629f55-5e4c-4e90-9bae-80abc1cdde70@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <b0629f55-5e4c-4e90-9bae-80abc1cdde70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 01.11.25 00:11, Philippe Mathieu-Daudé wrote:
> On 31/10/25 21:56, Philippe Mathieu-Daudé wrote:
>> On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all. qemu_hexdump() wrongly indents ASCII part of the output for
>>> the list line, it it's not bound to 16-bytes boundary. Let's fix.
>>>
>>> v2: add test
>>>
>>> Vladimir Sementsov-Ogievskiy (2):
>>>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>>>    tests/unit: add unit test for qemu_hexdump()
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> And queued.

Thank you!

-- 
Best regards,
Vladimir


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48702C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOiS-0001Xh-T3; Thu, 21 Mar 2024 16:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnOiR-0001XQ-ES
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:08:43 -0400
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnOiP-0005IW-AI
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:08:43 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 923CD5431B0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 20:08:36 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2306E542038
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 20:08:34 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711051715; a=rsa-sha256;
 cv=pass;
 b=SJiV6r/Mx97YzmCg3knzA/Wicy7jbtFGh8t/XLX8NZsi4mm6/GzNyDamYR/RL23AxH4J7Z
 qAirCbuFXNISUXYPyOjkE4tN5z/STu3Lgtac6qoUTRUtMtG5UyNs/2q4KSvff9URVDBFMw
 9HeyBISwUNs/bvbNy/iWRsYE3ucMct6Gvg07M0lYSh640Kz7kxS6S72CVRmefbsECPUIxN
 b3N/oVDtxE7HWz72zNQAhs9pDsuk+Qr0ZBX3QwykXTXF/Y2TT7Nq2/Ev5ioFNQ9dmKiObj
 JWptwBz/O16NPHRfESrmpBbKr1SUm/WPUAp5RrAYy5BFkBhw9IQ9faXvbeSlOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711051715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=vuK06bO/ayvNmjwi2/dA3yDfy18tclEA2VkCMyJPZb0=;
 b=U2kYWLODe8PJKa8wv5gVlZ/RsvVyuwS0o5/iSo9T2bhhQao9qcp1cWWW2WFY1DdSrgL2LH
 TPFIBr5seAyYbSFFdDNtVuCdBhqA5emoGr93GxNyavIX7JkMEXQwdO731qZ6SyNWoDp0zu
 P/sVwgjZzqmu+WJI8rY1fxx9yni+Q/eGbkfkbT/w3eB59MrWM7on5yw965DWQiWfFSmfh8
 VncaMRJuE686fo6Ycl1PI57GsDpoD5M1WZLi6N8ZI8BN9I5O4k/OOCfiUDsCCLqbF0DL9W
 uOeE1r7tg20QvhGEPvlfIvBxH8x6MjfdTu1h12aHmO0ObhY+YCxJP2R4A1q77w==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-7k6zn;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Quick-Grain: 1ce655583b83bbc6_1711051715645_2754675783
X-MC-Loop-Signature: 1711051715645:2010586084
X-MC-Ingress-Time: 1711051715645
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Thu, 21 Mar 2024 20:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711051679; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Rh1vnKe0arvWT185Jbea3mWlnC0fFVnAZ28IyggMH1Hu6yMHBibVmzW40UqIAg0+E124H2T7Z3V+0
 c4xdrlz0DX4V78eJ32YSpw2kNRt6M5bskaFv+LRo/ne+LcekuzBsN9Cqb5BIMTPyCdPfXmxWVPlg9E
 vCqmY/8b+NGKP71NQg9mamb+LMvIaCFl43rpcn1AFGuirq7skRQ5EV0dwoI4WAg+2heTVVgaKoViz6
 4SmI5f8WsBHYisbYEes9oo4vw7PcjulkCOm11VTyN/9Um6wOq6MXAwe+1dibS11+o1Sh3iHBdolI/P
 4FTOHRk4qvUj5Mhk7OzfiopPasz1WMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=vuK06bO/ayvNmjwi2/dA3yDfy18tclEA2VkCMyJPZb0=;
 b=hDow6EjJ4x5v+Q0w9AiKxmfkbzw0Rk1cxPzJdg2IqfT/fgEPx4PJoakn0TpuZKxAw5P+WBKVvmZDX
 7KX96E+8S1EZueYjhBtvhybv1wpQIpbZUM14S5oC1RAJVDc+YBO9gVpm9NraSYN0ZMykB6eSdM4s75
 WG16OQAtA7Dx3ZMOPJeNj66mMy8L/nhvkr4kDdfs+yfEykl8xQOihOJ9nZ+/xds/+/9u2hcBuQJNU7
 UOo4C3rEayrAQyPm22WxLBEW+D1COvuWdo7YQ/slPLuLN/5/GBb1uBwQZ1gxRkNl7Mo0nn+hrsOIVC
 AEkq1+T84GT/F52/MYRAvxfF3ivVqZA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=SX5zO8sY; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=vuK06bO/ayvNmjwi2/dA3yDfy18tclEA2VkCMyJPZb0=;
 b=ZwG7LzFhrHq54ZUlFP8vadtMN30vt7ZVnUHYF3UoLnDAHNG5qSI6hvTebmjyNd8d2vClH+0RLTpGc
 T3jkWoq4sDXgRIyZtPC01uOI+jfe0u0dPPL4bv8cXwepzaC/DhoYl231nHtVw5aclZzma6JQlXGbcN
 DePo2z5qpwYFhAbc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=vuK06bO/ayvNmjwi2/dA3yDfy18tclEA2VkCMyJPZb0=;
 b=UdhtL/ocJvnB6wAzmA9eXx3aWMJCXgHbxQxV9wFxo6FEYOo5D6El5PMMhfHwiliNHHI85TWEBGZIq
 CKZ26J9KmBdVq4W0AaiEI92kXB+suHUi3Rx02mnW/CQnFpndXfAYwECLIKYNGrPJNdNMgVIzxWDgEU
 LskP0xNInUZTysi9fBiqINBfQVHXTkYseV5D28k2SPkAFs1UL1iUeAYs5GNZN3gUe3AsNN6OTwrDn8
 Z3uDnnLU8HSxoYVqqZf/df+ouKJ5/76Sr6/pZgJ1fZ5icqQmswzViN8kV3lVMNbcfoaIsxhTLgsaO5
 455WlKrm7vifxVl+P1dyOu0rqU97XGg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: b4f8c0b1-e7be-11ee-b21b-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id b4f8c0b1-e7be-11ee-b21b-eda7e384987e;
 Thu, 21 Mar 2024 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vuK06bO/ayvNmjwi2/dA3yDfy18tclEA2VkCMyJPZb0=; b=SX5zO8sY/Hw+MMj2XEDvD1SV4k
 KTRDoTzWzk3TeqhTPtAR/0q9swxOg54WhTtRagbKOYenlmx/yCuIVv++E7uvReIK99DYAbsB5p4In
 Wc+4sw0CHdmCOZlroB9ew2Hha3PVSRumO71lGa3kFhtYRiSRaHueC2CnwSQm/jXtvdoCV7WY++ZGu
 Ire/CR2bpKb+efdPwisc4e8TDojRLWo8emhjuTNgsCDklZhemuK47NO+mk5sanTHk3jTwBmYBsooW
 4zle01WLS5qMRgRxYS81vw97osCKn4jU21Td/1cZhD7qhyLDrr4k37OiRWqQHNIZ1GN1cdU+ezAHC
 VL6iIHEw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnOiE-004uwn-0u;
 Thu, 21 Mar 2024 21:08:30 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: sub: fix trap on overflow for narrow mode
In-Reply-To: <ee2d2e6c-1843-4be9-9a0a-3505b20d9926@linaro.org> (Richard
 Henderson's message of "Thu, 21 Mar 2024 10:03:56 -1000")
References: <20240321184228.611897-1-svens@stackframe.org>
 <20240321184228.611897-2-svens@stackframe.org>
 <ee2d2e6c-1843-4be9-9a0a-3505b20d9926@linaro.org>
Date: Thu, 21 Mar 2024 21:08:29 +0100
Message-ID: <878r2bmjpe.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/21/24 08:42, Sven Schnelle wrote:
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>   target/hppa/translate.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index f493e207e1..4d2b96f876 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -1213,6 +1213,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
>>       if (is_tsv || cond_need_sv(c)) {
>>           sv = do_sub_sv(ctx, dest, in1, in2);
>>           if (is_tsv) {
>> +            if (!d) {
>> +                tcg_gen_ext32s_i64(sv, sv);
>> +            }
>>               gen_helper_tsv(tcg_env, sv);
>>           }
>>       }
>
> Difficult to pinpoint exactly which patch should have added this.  :-)

Yes, after missing the Fixes: tags on all of my patches in the last
patchset, i tried add one but wasn't sure either. :-)

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


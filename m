Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F91CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bYR-0003y0-2K; Wed, 08 Oct 2025 17:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v6bYN-0003we-9a
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:18:32 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v6bYI-0001pH-Pj
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:18:31 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 36ECA7C204D;
 Wed, 08 Oct 2025 21:18:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com
 (100-113-89-78.trex-nlb.outbound.svc.cluster.local [100.113.89.78])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id DED837C2056;
 Wed, 08 Oct 2025 21:18:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759958297; a=rsa-sha256;
 cv=none;
 b=ioR1WFCTKc1uOK+/38w6mbYKxiScK8krTwm8uSlpj+f9M/k10GHMzCztYWcJIgJanAOd2a
 CNYlPKnSH5BeEKAFfIxot3oFWhlIKzsM4Pn7g1qfNa13VJRjfj4z0xfQwMocbtbt6II0kI
 5vYfv/BBPJOYcqedQUeFF/L5j4GIQ7/5toTwLftfu7uyZD25qA8yryXmArdjWqzZGwNFgm
 zTb3wW1rd2NjFORC5txWjbNLxPyxpayBPyUVy2GeSXtNxLRWRpzBmCC4by3BCR/n18VYMk
 4yqddak/mJwfmCpP/IfuGnl+i7upcsWkjxSMS8IG5C9JiC+ETkp1LGcae9DrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1759958297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=faInuJmaitxJNlLzd+Hj8eiUZA4wlG9mCNfdN1JRXow=;
 b=9289PPyv///u8ImnrgWwNy7X9gXVsH+iLa2bki3HrA1LOMe6M4+lDrPjlMtLRPHuo7yu85
 A5lEBWMAvWQ7z58KEOZWVZgGKyKy/dLq2h9ykrSxC0UpX9kJoflj2fWTOP/scOdYBuat6a
 Uf5BWqrEdV3uDGseW5kBN0Z0jHs4gdjJPZEqu1AxdfHnRHQlLLieZEasn4WIDwQ5Z4uIZf
 qPivVCyik9vNIq+QE79K4j2B9fu9HEdIGgtVJ68v2PliN8wZh4frR29nz/g85pHOIj7FdU
 BBRxmrzTtwfgsSPnJM5uxlekT8eT9N09fAC32rFZH+Emit+alKr4In/JwO0u6w==
ARC-Authentication-Results: i=1; rspamd-777888ddf6-gq2g8;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Language-Arithmetic: 4c1300eb067ae1e1_1759958297012_2466273450
X-MC-Loop-Signature: 1759958297012:1894003615
X-MC-Ingress-Time: 1759958297012
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.89.78 (trex/7.1.3); Wed, 08 Oct 2025 21:18:17 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4chm7r1rBvz2x; 
 Wed,  8 Oct 2025 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1759958296;
 bh=faInuJmaitxJNlLzd+Hj8eiUZA4wlG9mCNfdN1JRXow=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=PjO1d3RiPc3UoRAk2OSJ+1TOj+PV7oGujqUNUM0lUYniBtFTz0L9/LsCYmwa6pCUF
 MQgl+5PnbzchbTF33LonRpdFzFJtIyWgM1KrfKgzm+3ZmdB0p/Wvv0AfoBBrWQDOTa
 PAuqvdm7UIidtNTXafYtHNifsHoLs97YQ1gyShtBz7xsVwYoDktEWhgblFyS8gvWZ5
 gOxIr63XwaobR51gamL/uqMLXUGZ+AEzfiGBHEOEDY4tabhs1PcumhMJOurYxL+lpD
 Q1oT4t5TgP40IWm3ZiA5d7MBOvxX1YwT86ql3H50wjXbfxuWsDaY5LT6SosjQYd6bA
 /BikYs2j6FS4A==
Date: Wed, 8 Oct 2025 14:18:13 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: ira.weiny@intel.com, lucerop@amd.com, a.manzanares@samsung.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/cxl: Support type3 HDM-DB
Message-ID: <20251008211813.7n55fre2nbdu7raa@offworld>
References: <20250930032153.1127773-1-dave@stgolabs.net>
 <20250930032153.1127773-5-dave@stgolabs.net>
 <20250930163636.00006770@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250930163636.00006770@huawei.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 30 Sep 2025, Jonathan Cameron wrote:

>On Mon, 29 Sep 2025 20:21:52 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Add basic plumbing for memory expander devices that support Back
>> Invalidation. This introduces a 'hdm-db=on|off' parameter and
>> exposes the relevant BI RT/Decoder component cachemem registers.
>>
>> Some noteworthy properties:
>>  - Devices require enabling Flit mode.
>>  - Explicit BI-ID commit is required.
>>  - HDM decoder support both host and dev coherency models.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr,
>
>Comments inline mostly focus on the bi parameter.  I think flipping
>it to true for components where we are hard coding it as true will
>move that logic decision up a layer and make the code easier to follow.

Agreed.

...

>> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
>> index e5a0d1fb308c..4bc185df8c87 100644
>> --- a/hw/pci-bridge/cxl_upstream.c
>> +++ b/hw/pci-bridge/cxl_upstream.c
>> @@ -136,7 +136,7 @@ static void latch_registers(CXLUpstreamPort *usp)
>>      uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
>>
>>      cxl_component_register_init_common(reg_state, write_msk,
>> -                                       CXL2_UPSTREAM_PORT);
>> +                                       CXL2_UPSTREAM_PORT, false);
>
>Obviously different structure but still seems odd that bi is false yet we create
>BI_RT structure in this call.

I'm thinking maybe use usp->flitmode instead. Yeah it's not ideal to associate
them like that, but it makes less sense to always export the registers if 256B
is not even enabled. Otherwise now this would have to be hard coded to true as well.

Thanks,
Davidlohr


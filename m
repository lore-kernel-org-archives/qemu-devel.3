Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C559C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 02:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcFpY-0002U2-Eu; Mon, 19 Feb 2024 21:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1rcFpO-0002Q9-Vv; Mon, 19 Feb 2024 21:25:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1rcFpM-0003ou-Td; Mon, 19 Feb 2024 21:25:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9C889CE1742;
 Tue, 20 Feb 2024 02:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8270CC433C7;
 Tue, 20 Feb 2024 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708395938;
 bh=Mofg09nfXhlm6YjjbwEDvN412J+w36WUYYeeTd2nICE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ADO7dcbyyznlUQMq1wR8j/7mN3hWmgcvlG3Q1YxxRFOUCl2BAgOgwkGg/6mL9rC5S
 C5Bm+u+k7zd28kz8T2GTYpkWgU3aWwhqXtoH06XwnVcHzqim8Lrz7dDwaVSWDRgcRB
 I2JvbZwIAgxDevj+0Z2iUyZ9pBlVn4TK1wNhqIxmrL2UNqi/Jex9wmCLyRmCqA5rlV
 fI7qIWk+JaaJHMG0RgZUMes4LFTOTPPrswulhlcYTaxYAHE98+rTfG/8SyfKOoXhqb
 ay4a4z+ytQapyZHdoOymlLUeViKGDnt/ThXEvRFA9EwNFBfcTwcXPn6ZIJg2Hsjtpb
 HOFu3erIjxb9A==
Message-ID: <768197a3-bfdb-4bca-a550-acad6a94c726@kernel.org>
Date: Tue, 20 Feb 2024 11:25:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com>
 <87plwsfyyv.fsf@pond.sub.org> <87edd8fyme.fsf@pond.sub.org>
 <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
 <877cj0jz5u.fsf@pond.sub.org>
 <CAAAx-8JYR2r7BzWWVtcY9h8ZgNq1an4=eTCwBnDNe+HwbkgHeg@mail.gmail.com>
 <87a5nwh2h6.fsf@pond.sub.org>
 <CAAAx-8+Am5ehs6tyA64Vms713+34iq44yR6SvWr7CpHX_dq-MA@mail.gmail.com>
 <87o7ccfaok.fsf@pond.sub.org>
 <CAAAx-8KvZv=vfGB8+h73Nh=8DwsyD-nD_FjgGrgW2O+h66FdeA@mail.gmail.com>
 <871q98f94t.fsf@pond.sub.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <871q98f94t.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=dlemoal@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/24 06:15, Markus Armbruster wrote:
>>>>> Making this member @size mandatory means we must specify it when
>>>>> BlockdevCreateOptionsQcow2 member @zone is present and @zone's member
>>>>> @mode is "host-managed".  Feels right to me.  Am I missing anything?
>>>>
>>>> That's right. And the checks when creating such an img can help do
>>>> that. It's not specified in the .json file directly.
>>>
>>> What would break if we did specify it in the QAPI schema directly?
>>
>> Nothing I think. We can keep the current schema and add a default zone
>> size like 131072.
> 
> I believe making the member mandatory makes a lot more sense.
> 
> I guess we can keep @capacity and @max-append-bytes keep optional *if*
> we can come up with sensible defaults.

Yes, @capacity can be optional and default to the zone size.  @max-append-bytes
can also be optional and default to the regular read/write max size.

However, defining a "sensible" default for the zone size is rather tricky. The
reason is that zones are generally sized according to the device speed. Zones
are 256MB on HDDs (which takes about 1s to fully write sequentially) while NVMe
ZNS devices will more likely have a zone size of 1-2 GB (because the device is
much faster). If we stick with such approach, a sensible zone size would depend
on how fast the qcow2 image backing is. I.e. 256 MB would be more appropriate
for a qcow2 image on a file stored on HDD while larger sizes may be better for
SSD backed images. But that is also not accounting for the host page caching
which can "show" the qcow2 image as being much faster than its backing storage
really is.

So I would be tempted to say that defaulting to 0 to force the user to specify a
zone size would be safer. But if you really want a non-0 default, then maybe
256MB or so may be OK as that is the most commonly used value out there for
zoned storage (there are literally millions of SMR drives running in production
systems out there and NVMe ZNS devices are not widely used yet).


-- 
Damien Le Moal
Western Digital Research



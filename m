Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E73CE6F06D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6u8g-0002fH-Hc; Fri, 01 Nov 2024 12:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6u8e-0002eq-NC
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:04:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6u8c-00078i-Ec
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1730477065; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xxb1b7qo3AjmPqUQKQtDrVammhNNN9Md+c+juVdEvuGNG+c6m0coXGB2dyPOlYXecirUr2witsiFk/AQfj3PeSElEekExDeWemxLUNOmhZ21WcU8gE3N+NDC+ztrtFTnC7absNVmneNUw7HaHpvWDW4HdKBDj5NVWL0/XcK9qDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730477065;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5FTdUKuC8nCEXBCEwik4vOKbkJPip4j2tVYxhH4cxug=; 
 b=JNLIvQU5urs3cd/CmpvaVtbV10LDsyHPzVwXDNblOFKclN/3bI70GymUBFCBrfNfYvLCRZRfKA8W9R/+Xi9a35c7kGOG9Y0narpoT2dGn9BKTMGZ4fq9xVaClHZeRWy9xvUT/pI3UQtvzNQGfAnupDVYzf4tK/GtPOSolFs47qg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730477065; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=5FTdUKuC8nCEXBCEwik4vOKbkJPip4j2tVYxhH4cxug=;
 b=FOTHctiqp3bhQw6pg9PswnxK1CETg1YTU3qKUazTNacDb5ww94+SvbL3Ne3YX9Lh
 Cm+NMrlqMKGmP+HB4RVooU6pGP5rpdMyVGKjfTQx2hvjx3ocsr2heB+1LJysJ6Olx7l
 tguF4f6FM1hMGHK6K5Yqjrj5jFBQQ5gWXvrVCJjM=
Received: by mx.zohomail.com with SMTPS id 1730477063447436.45407887834665;
 Fri, 1 Nov 2024 09:04:23 -0700 (PDT)
Message-ID: <73bc5cb8-0540-47cd-8a1e-aed8bf772d3a@collabora.com>
Date: Fri, 1 Nov 2024 19:04:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Robert Beckett <bob.beckett@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
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

On 11/1/24 18:35, Peter Maydell wrote:
> On Tue, 29 Oct 2024 at 12:11, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Support BLOB resources creation, mapping, unmapping and set-scanout by
>> calling the new stable virglrenderer 0.10 interface. Only enabled when
>> available and via the blob config. E.g. -device virtio-vga-gl,blob=true
>>
>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_scanout_blob
>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Message-Id: <20241024210311.118220-12-dmitry.osipenko@collabora.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Hi; Coverity points out some possible issues with this commit:
> 
> 
>> +    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
>> +    fb.width = ss.width;
>> +    fb.height = ss.height;
>> +    fb.stride = ss.strides[0];
>> +    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
>> +
>> +    fbend = fb.offset;
>> +    fbend += fb.stride * (ss.r.height - 1);
>> +    fbend += fb.bytes_pp * ss.r.width;
> 
> Here 'fbend' is a uint64_t, but fb.stride, fb.bytes_pp,
> ss.r.height and ss.r.width are all uint32_t. So these
> multiplications will be done as 32x32->32 before being
> added to fbend, potentially overflowing. This probably
> isn't what was intended.
> 
> (This is Coverity CID 1564769, 1564770.)
> 
> The calculation of fb.offset also might overflow, but
> Coverity doesn't spot that because fb.offset is uint32_t
> and so the whole calculation is 32-bit all the way through
> without a late-32-to-64 extension.

Will make patch to silence this Coverity warning. AFAICT, there are
other ways to cause integer overflows in that code, though I assume it
all should be harmless. Thanks!

-- 
Best regards,
Dmitry


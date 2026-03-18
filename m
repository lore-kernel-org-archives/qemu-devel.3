Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B71B107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2wv2-0002D5-Qy; Wed, 18 Mar 2026 15:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2wup-0002Bk-Bv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:50:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2wum-0001AC-DM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:50:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD9625969F3;
 Wed, 18 Mar 2026 20:50:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id SQDuJ0QCS268; Wed, 18 Mar 2026 20:50:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD1545969E4; Wed, 18 Mar 2026 20:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB4AC5966F4;
 Wed, 18 Mar 2026 20:50:28 +0100 (CET)
Date: Wed, 18 Mar 2026 20:50:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 1/6] ati-vga: Fix colors when frame buffer endianness
 does not match host
In-Reply-To: <DH633G213QPR.2EMRCN626JXVS@jablonski.xyz>
Message-ID: <ec4a000e-cac6-01d0-a8cd-b21ef7aba431@eik.bme.hu>
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <40f0e42b1fa51bea1d9199eb0cd519a5b8da6fdd.1773797056.git.balaton@eik.bme.hu>
 <DH633G213QPR.2EMRCN626JXVS@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 18 Mar 2026, Chad Jablonski wrote:
>> +static uint32_t make_filler(int bpp, uint32_t color)
>> +{
>> +    if (bpp < 24) {
>> +        color |= color << 16;
>> +        if (bpp < 15) {
>> +            color |= color << 8;
>> +        }
>> +    }
>> +    return color;
>> +}
>> +
>
> Does this assume that the upper bits of color are zeroed when bpp < 24? Is that
> a safe assumption or could those bits be garbage?

I think to be a valid <24 bit color the upper bits should be 0 here. In 
practice this is called with register values where we only support 32 bit 
writes so the only way to get garbage there if the guest does a 32 bit 
write with garbage bits. (I.e. it can't do an 8 or 16 bit write and leave 
garbage in upper bits from earier value.) It seems unlikely that a guest 
doing 32 bit write would leave garbage in upper bits and if this could 
happen it's better to take care of that at register write not here so I'd 
assume color is some valid color for the bpp and the caller should make 
sure if needed. This function just expands that to 32 bits so we don't 
have to care about other sizes later.

Regards,
BALATON Zoltan


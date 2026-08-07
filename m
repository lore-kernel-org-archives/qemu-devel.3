Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FF0C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMBF-0005Lc-VH; Fri, 07 Aug 2026 11:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsMBD-0005LM-Ua
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:08:15 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsMBB-000402-Pu
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786115287; x=1786720087; i=deller@gmx.de;
 bh=a2m3YHtzdYxcuPcWtkwGDk/DYmze/jMVarbTofw9kG0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dhR5iTAItVlh4RYqlJRCLubUzYgj0Ecv9kY3XM4yYSrNDcXE1bEJbocmERrf2QKy
 siv1RwQZSSgJ/SffgL6LhwZnyyiJwDUgn6VOyejedty+xxLXVKCGAmeG0D5w6Eb8R
 js65J+tw0on0+ZCkiJd+JmUv83FfV90JeTMvWObWeBha7AH5DkPTmJso6LMLwaZEl
 MuaY37x7nDslbhyqDoeJtMgEaqJVYfZctgvqdUr/1n+ZtLFxJVe10EwHQTwdE+nSF
 bvOQT7sqQHkEkVbsnvdNdTxOoeWep1nIKjMafwmQrRkTSIk6T5OmCB9QQsNgwrU42
 21VM+5uoEqo6OISnJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUZ4-1xFGnr2rjI-00k4xN; Fri, 07
 Aug 2026 17:08:07 +0200
Message-ID: <090faa9e-0ba2-4620-8d27-8fa4b7ac17af@gmx.de>
Date: Fri, 7 Aug 2026 17:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Peter Maydell <peter.maydell@linaro.org>,
 Andreas Schwab <schwab@linux-m68k.org>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de> <87ecgfkrg9.fsf@igel.home>
 <anEBr8nK-4nKmuXj@p100> <87y0emkhjo.fsf@igel.home>
 <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
 <CAFEAcA8Mof1EDHoF0hBRcu+to0W6ny-KvX7mUwch+SGVgRD3MA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA8Mof1EDHoF0hBRcu+to0W6ny-KvX7mUwch+SGVgRD3MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9WYys/Jjq/e46qXUbLd6AAVo5pmD1Ffk9Ry7p+JIhLuZG50wIya
 I8OjME113z2rNwt0Mfx90msc160LI451Q77beaxaHFtILNhw7kQ0re4pJa89a7F7Pfbug6T
 Pyya+kesczegi0dmVRpFAHot+uTXJBCKE6tTEgVJKvmEFcGsAAjr7CEI8W6YcSche1WPvd2
 8S3BH8HssGywF1HCRzN5Q==
UI-OutboundReport: notjunk:1;M01:P0:lWaEGlNiZVE=;cVtu4TpfgZK3pB86aSZZDSJ86Ap
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/7/26 15:12, Peter Maydell wrote:
> On Tue, 4 Aug 2026 at 07:30, Helge Deller <deller@gmx.de> wrote:
>>
>> On 8/3/26 23:42, Andreas Schwab wrote:
>>>   This "preferred" approach does not really make any sense at all.
>>
>> Right. IMHO this "preferred" (aka padding behind 32-bit time value even=
 on big-endian)
>> doesn't make any sense for big-endian. The lower 32-bit value then ends=
 up in the upper
>> 32-bits of a 64-bit time_t value and thus you have problems when mixing=
 32- and 64-bit
>> time_t applications.
>> I think m68k needs to follow the other 32-bit big-endian arches I menti=
oned above
>> and provide an own uapi/asm/msgbuf.h:struct msqid64_ds file/struct.
>> And this stupid "preferred" sentence in the kernel should be dropped.
>=20
> If every 32-bit big-endian architecture is avoiding the asm-generic
> msqid64_ds struct in order to provide its own, and they are all
> exactly the same, could the asm-generic one be made to do what all the
> 32-bit BE archs actually want rather than something that nobody wants?
Yes. I fully agree.
Andreas, do you agree as well, that all 32-bit kernel architectures
should follow this path and we should drop the "preferred" thing and switc=
h
to a native 64-bit time value?
If so, I'd willing to come up with a kernel patch...

Helge


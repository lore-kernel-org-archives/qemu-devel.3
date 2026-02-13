Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39DEEDF168
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtmk-0005Pj-Us; Fri, 13 Feb 2026 09:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqtmj-0005Oi-1r
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:04:41 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqtmf-0006Ep-Kp
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:04:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770991455; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WdqEMacxY69LqlhD0gBDJCtO/k5WGaKE1zkM3t9KrZ6ncuo0jUG57KlFQJeWlzgp5n0snoJPNoi/1DvszjGvWsaMI6wSZB3vrKhtl+8ya38a0qhb3smg1kMcXs30jim5dB9IkyMYaFO/3JR5/MCg/6WLAeErBGcJ1AsDnV1XfaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770991455;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mAYvbNbe1wjsp2aqHhbj2ycfFLkoTTrsEN+L+lEIvcM=; 
 b=Qi9q8/A3KxYIrcc+uJfK19YGJD+5te/dJqcN+sMrIMse+rOPO1f0QNYjPf6HJ1Wi4nZnYR8hlZzeymX+9X6+pEQQaX4CGkmMjkmcJG7ta+M2om6johKM8S/cryubMsR/HPRwxQw1ENS8iM/FDHamYP02Hf0Gkwq+9kbuL4Bknec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770991455; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mAYvbNbe1wjsp2aqHhbj2ycfFLkoTTrsEN+L+lEIvcM=;
 b=Ca2aGEEIhoiJovVvP4oMiDGWz3gUXe5uuj+NxEpfGmapNXFk8pwGlm4+8l65mtFR
 MVqKajlGxqQ5Wu6dLZJem6UdkZwHgCryo/9Xbu7qOTcGSXLoLyoe84E8RUw9v2BdMXl
 MM/bEHM5ddRjj62DknpempkGOZEHBOk5D57ezWj8=
Received: by mx.zohomail.com with SMTPS id 1770991453053721.5901120697578;
 Fri, 13 Feb 2026 06:04:13 -0800 (PST)
Message-ID: <7ffe6db4-d43f-480b-8607-438baad412ab@collabora.com>
Date: Fri, 13 Feb 2026 17:04:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Michael Tokarev <mjt@tls.msk.ru>, Joelle van Dyne <j@getutm.app>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
 <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
 <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
 <2fb2bae5-6c2c-45e0-adb8-96eb32bcc659@tls.msk.ru>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <2fb2bae5-6c2c-45e0-adb8-96eb32bcc659@tls.msk.ru>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/13/26 16:30, Michael Tokarev wrote:
> 13.02.2026 02:57, Joelle van Dyne wrpte:
>> On Thu, Feb 12, 2026 at 3:00 AM Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:...>> Joelle, are you aware of
>> this problem with the version that got applied
>>> to the qemu/staging tree? If yes, could you please send patch fixing it?
> 
>> Unfortunately, this means that the patch should not have been back
>> ported. It is possible that the crash which this patch was addressing
>> was introduced as a result of changes elsewhere. For example
>> https://lore.kernel.org/all/20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-
>> tokyo.ac.jp/
>> changed some internal mechanics of finalize. I didn't raise any
>> objection to the back port because it seemed like the original code
>> where the object was its own parent was wrong but I guess it was
>> working fine somehow. I think in the meantime the best course of
>> action is to revert the patch in the stable branches.
> 
> Ok, it was me who thought it's a good idea to apply it to stable branches.
> Sure thing, if it's wrong, I should revert it.
> 
> Do I understand it correctly that in current master, this change is okay,
> due to other changes (maybe like the above-mentioned one), but in previous
> stable versions, it is not?
> 
> Should I make another stable release to fix this one?  I mean, how serious
> it is?
> 
> I'm sorry for the trouble.

I tested master and stable 10.1.4 in addition to the staging branch, all
three are broken by this patch. Hence the patch is wrong in the first
place and not fixing anything.

-- 
Best regards,
Dmitry


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47007C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeN9-0006SW-Lq; Tue, 28 Jul 2026 05:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woeN6-0006Qm-Su; Tue, 28 Jul 2026 05:45:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woeN2-0008AL-TK; Tue, 28 Jul 2026 05:45:12 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S9ivuC096132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 18:44:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nOIci4ba09JQ2PquXLmlZXVxiIAZWGNDnNFK7+Rrmvc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785231897; v=1;
 b=bZwx6XZ/fX+7yweqqUPOl2RyanQT/WlQ+amnGQDkP5NGLylzzl+cSkD1vNxbpRmP
 xiEFQA1Ni6mzTEEMgZv7bFY4ejubVxoxHz0LoEf8WOer/O6b/rIog5V11DdWvt+a
 ZYfmwe85wRxxr+mIu9fE2Yg5FAgW0ggJ05YFa1g7Ztysgvr9mSlQoST1VcbcYZnM
 OeSia9kcH0KAiuAPbvZVcsc6dipBA+CuD3KysBj3Vch+ha8s/ycVbCrhHbziPeSp
 lSXDEK2BLUVZWrgU6OXDvJXi8kKuhtjhTQhRSeUGdJ/qIv5EYYbQRC5U1GVM6NWV
 KeJ09YeTiCQqSVvJeAk4rA==
Message-ID: <43d31e12-f140-4918-8150-e6cf7c9e4732@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 18:44:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Fix empty blob discrimination
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
 <b0951125-f714-4bdf-a178-1a7658bef43d@tls.msk.ru>
 <81a781bb-a4e2-4cfc-a9d1-0316cfb2f17a@rsg.ci.i.u-tokyo.ac.jp>
 <7d152a87-03db-44f9-b2e4-a6aa8729a0d5@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7d152a87-03db-44f9-b2e4-a6aa8729a0d5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/28 16:47, Michael Tokarev wrote:
> On 7/28/26 09:54, Akihiko Odaki wrote:
> ...
>> The consequence of the bug this patch fixes is a NULL pointer 
>> dereference and denial-of-service. docs/devel/stable-process.rst says:
>>
>>  > Generally, the following patches are considered stable material:
>>  >
>>  > * Patches that fix severe issues, like fixes for CVEs
>>  > * Patches that fix regressions
> 
> In these two cases, changes are *definitely* for-stable.  Other changes -
> fixing bugs but without regressions or CVEs - might also be for stable,
> but it is more case-by-case material.
> 
> You haven't quoted the very next paragraph from this document though:
> 
>    If you think the patch would be important for users of the current 
> release
>    (or for a distribution picking fixes), it is usually a good candidate
>    for stable.
> 
> Without "regular bug fixes" in stable we wont survive ;)
> 
>> And I don't think this match with the description. It still does fix a 
>> bug, and I think you can cleanly backport it and you tend to backport 
>> such a patch.
> What I'm thinking is more like - all at once - does the bug affects users
> (is the subsystem in question actually used or not (it might be some
> very niche thing); is it a fast-moving target so only very recent code
> makes sense in the first place and so there's no reason to back-port
> fixes; can the bug be triggered in real life or just theoretical (like,
> it is not a problem in current code but future changes might trigger it);
> is it more a cosmetic thing or something like a crash; and so on.  And
> on the other hand, whenever this is a trivial fix or something more
> complex which might cause bugs by its own.
> 
> In this particular case, the fix is trivial and the subsystem is in
> use, but if this bug can be seen in real life I still don't know.
> 
> At least now I know why you haven't considered it for-stable in
> the first place - because you assumed only CVE and regression fixes
> should go there :)

Indeed I forgot to quote the paragraph. This bug can only be triggered 
by a malfunctional guest and does not have a practical impact. I usually 
consider a fix that address a user-provided bug report for stable.

Regards,
Akihiko Odaki


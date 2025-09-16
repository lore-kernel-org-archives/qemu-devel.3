Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD162CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyU9V-0002Wa-5X; Tue, 16 Sep 2025 07:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyU9D-0002Ux-RU; Tue, 16 Sep 2025 07:47:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyU97-0003wj-00; Tue, 16 Sep 2025 07:46:59 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58GBjG7r018377
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 16 Sep 2025 20:45:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S9yBHbOuQHz7OtsZ3ZE4uXu8YsxVjNHZfCc/goAi65U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758023117; v=1;
 b=kIwv+kh3uljN3SW9gh6HhWSuJQ20ZzudPouxrNKbjyJ3X6L1F20CXX8Vbdg1yQuR
 G1fuxDKhC2e4M/w9dvWh9N044bzLgrwkacSPdarm6zC0GgV3hqhDJ2KOkvPGcvCk
 iMNwS3KpE+vUdZ5SV8ZhjKzeYC5MkQ4gMXljQqRTDlWeigO3yvo4sLrf7qps+mwO
 FWseXsWUso/lDzGirKt4W/9h97q8s58I0hr2HiKLoxSw+1aN1RLIGoV+CDzcqniq
 GJd5AgFMK2FBdLTb2eHRgSU6vRQ2JtcF6JUhEW2WiY31HBKKdpytO75rn5gfzvMR
 e9GGPv4Dy7eIGipcUkFtyg==
Message-ID: <bee45185-a244-47d3-a210-c7f630ab95f8@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 16 Sep 2025 20:45:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <aMHidDl1tdx-2G4e@x1.local>
 <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNBJF9E4BYrWEHO@x1.local>
 <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
 <aMSQDuVacnSG3MTV@x1.local>
 <04eac866-74ea-46ae-9170-aa3ad5fc1b11@rsg.ci.i.u-tokyo.ac.jp>
 <aMh3ZfUQ3Ksjn56e@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aMh3ZfUQ3Ksjn56e@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/16 5:30, Peter Xu wrote:
> On Sun, Sep 14, 2025 at 06:06:44PM +0900, Akihiko Odaki wrote:
>> It makes sense to have a through review, but my argument here is the
>> de-duplication of object_unparent() and the replacement of g_free() with
>> object_new() are logically distinct and should be split into distinct
>> patches. Each patch can independently have through review, be
>> applied/backported, or be reverted in case of regression.
> 
> We're discussing a change in the memory.rst on suggested way to use dynamic
> MRs, so I think we can do it in one shot rather than making it confusing.
> It's not a huge change even in one go.
 > > It's fine.  You're right we can remove the object_unparent() first when
> it's always a no-op.  We'll update the doc twice, though I assume it's fine.
> 
> If you would, please consider sending this part as a separate series.
> 
> The subject should be something like "remove unnecessary object_unparent()
> for dynamic MRs" or something like that.  It has nothing to do with
> memleaks on this part.

I think "Do not unparent in instance_finalize()" is good enough.

"unnecessary" sounds it is correct but only extraneous; in reality it is 
semantically problematic.

"In instance_finalize()" is more appropriate to represent the scope of 
the change than "for dynamic MRs". Unparenting objects when finalizing 
their parents is wrong, whether they are MRs or not. On the other hand, 
unparenting MRs before instance_finalize() is still allowed.

In v2, I dropped patches to fix memory leaks so the series only contains 
ones to fix use-after-finalization. I'll rename the series accordingly.

> 
> Please cover tests as much as possible and if we touch the doc we need to
> convert everything that uses dynamic MRs, including the missing ones in
> VFIO, and also the rest occurances.

I'll search for object_unparent() called from instance_finalize().

Regards,
Akihiko Odaki


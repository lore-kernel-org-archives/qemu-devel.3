Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF462CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 10:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7AFh-0005zM-Bb; Fri, 10 Oct 2025 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7AFZ-0005y5-HQ; Fri, 10 Oct 2025 06:21:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7AFV-0008WH-Ds; Fri, 10 Oct 2025 06:21:25 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59AAK498061262
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 19:20:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0BQmMj3dqVZtAqGuHHlC8WVY7AKpHYkbM3DbYZ7Oj2Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760091605; v=1;
 b=GX6+f0JQqLxHFR7V/khLhFm2SYMbOLl2JPYJaX2SQj7s3JSR56LwK42XEmqTRRJZ
 yR8W5jVe3zf/oyfXj/dNrsLSe63o5Z0y3gqQ3W5HWd1sIgwvcqBY3kUKDMtcv37Z
 eaYn2fQQBFjmMNkEsiENbt+XkF0rjkS2c2p7pw/fVmVZScZLXIvCadiXUV+kib7M
 nZz/0d2K72AUlBrzcj36yEl403z02Nzeg2zgd4x47sk1uBkK4vB2SgjlzfSaT9bi
 TwGgFxTsjluiLRvnBlw51wDVfjMUhr5Ro0XBxYwN+BQvhOI8WiX8VLCKgEkHaQx1
 0+CFzL5u5GaNWOi9xsVacA==
Message-ID: <036d19ce-490b-49d2-b114-0b5a91e5e66c@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 19:20:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Fix memory region use-after-finalization
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
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
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <4664fcb7-c747-42dd-966f-6f282abece89@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4664fcb7-c747-42dd-966f-6f282abece89@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/03 0:03, Paolo Bonzini wrote:
> On 9/17/25 12:32, Akihiko Odaki wrote:
>> Based-on: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
>> ("[PATCH v3 0/7] Do not unparent in instance_finalize()")
>>
>> This patch series was spun off from "[PATCH v2 00/15] Fix memory region
>> leaks and use-after-finalization":
>> https://lore.kernel.org/qemu-devel/20250915-use-v2-0- 
>> f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp/
>>
>> When developing the next version of "[PATCH 00/16] memory: Stop
>> piggybacking on memory region owners*", I faced multiple memory region
>> leaks and use-after-finalization. This series extracts their fixes so
>> that the number of Cc: won't explode.
>>
>> Patch "qdev: Automatically delete memory subregions" and the succeeding
>> patches are for refactoring, but patch "vfio-user: Do not delete the
>> subregion" does fix use-after-finalization.
>>
>> * https://lore.kernel.org/qemu-devel/20250901-mr-v1-0- 
>> dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp/
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> This makes sense, but I think it is not bisectable, because of this in 
> memory_region_del_subregion():
> 
>      assert(subregion->container == mr);
>      subregion->container = NULL;
> 
> You would need to add a temporary
> 
>      if (subregion->container == NULL) {
>          return;
>      }
> 
> and undo it at the end of the series.  Do you agree?  With this change I 
> can apply it.

It is unnecessary because patch "qdev: Automatically delete memory 
subregions" satisfies the following:

1. the device-specific code can assume that subregions they added are 
present until it finishes unrealization. The unrealize() callback can 
also assume the subregions are present and delete them. qdev satisfies 
this by deleting subregions only after calling the unrealize().

2. qdev should delete the remaining subregions before it finishes 
unrealization to ensure that the devices are hidden from the guest. qdev 
satisfies this by checking if memory regions have containers before 
deleting.

Regards,
Akihiko Odaki


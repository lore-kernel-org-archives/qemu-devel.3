Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30519C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 08:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnXdi-0007x9-LD; Sat, 25 Jul 2026 04:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnXdg-0007vg-99; Sat, 25 Jul 2026 04:21:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnXdd-0002EK-30; Sat, 25 Jul 2026 04:21:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P8KYKv094736
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 17:20:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WQYS/xI8RrPJl491thw/TlxkgIKItmOqVyaGKFsbaa0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784967634; v=1;
 b=Ge7+55X62ajyD1RiTmHCAWDd2BuLMVIpT2zhbl40EjLObKaUQk0m/XubkkY2emDs
 liPW9MLfy19VooMOiGwtZ1/gIpYYzzkKBKkxcRj4nTm3aIVzzvuyJVuHnwITnie9
 36ymyyoRIoadCRUaKwy4uxoVJJB1UI0DikJFowu3hIKz0LFdYiEHHFRwKLUSj5wu
 lY5Mt6wpDpEy3lfBbvHeEqij3N79o2fd+1b/jz9yK5Doc0L66Cdn4L56Yl2t3w7R
 QW4yG3dlAnaoxcT6j5+u7hYQy9+/K7P9SZBuaGYaejzvdQ1n1OzYit4EjveVt/cP
 qgoEojKdLXt0VXYoLIDSGA==
Message-ID: <ae547323-1df0-436c-80a8-4681ecbbf2ea@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 17:20:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 00/15] qdev: Clarify and enforce the device
 realization lifecycle
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <874ihoa9z3.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <874ihoa9z3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/07/24 20:44, Markus Armbruster wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> qdev currently represents a device's realization state with a single
>> boolean. This cannot distinguish a device that has never been realized
>> from one whose realization has failed or that has been unrealized, nor
>> can it represent realization in progress. Consequently, the same device
>> can enter DeviceClass::realize() reentrantly or more than once.
> 
> .realized is initially false.  It is only ever modified in
> device_set_realized(), which is the setter of QOM property "realized" of
> "device" and its subtypes.  device_set_realized() is only called when
> the property is set.  It does nothing when the new value is the same as
> the old value.
> 
> Code changes property "realized" only in qdev_realize() and
> qdev_unrealize().
> 
> Implementations of .realize may call qdev_realize() for their
> components.  Having this loop back would be a bug.
> 
> If your claim "can enter reentrantly" is correct, we have bugs to fix.
> I believe it is incorrect.
> 
> There are two kinds of devices, onboard and user-created.
> 
> User-created devices go through qdev_device_add_from_qdict().  If
> qdev_realize() fails, the device is immediately destroyed.
> 
> Onboard devices get created and realized by board code.  It commonly
> treats qdev_realize() failure as fatal error.  Trying again instead
> would be a bug.
> 
> If your claim "can enter more than once" is correct, we have bugs to
> fix.  I believe it is incorrect.
> 
> Exception, sort of: users can manipulate properties with QMP command
> qom-set.  This is generally unsupported and a Very Bad Idea[*].  There
> might be supported exceptions (I don't know), but "realized" is
> definitely not among them.  Unsurprisingly, it's a fast path to grief:
> 
>      $ qemu-system-x86_64 -S -display none -monitor stdio -nodefaults
>      QEMU 11.0.90 monitor - type 'help' for more information
>      (qemu) qom-set /machine/i440fx realized false
>      (qemu) qom-set /machine/i440fx realized true
>      qemu-system-x86_64: ../system/memory.c:2585: memory_region_add_subregion_common: Assertion `!subregion->container' failed.
> 
> I figure your series rejects the second qom-set.  I'm pretty sure the
> first qom-set already wounds the VM fatally[**].  Same as for a
> multitude of other properties that aren't prepared to be qom-set at
> arbitrary times.
> 
> Mind, I'm not objecting to adding additional guards against .realize()
> getting called more than exactly once.  I'm only challenging your cover
> letter, and probably your commit messages (which I haven't read).
> 
> [...]
> 
> 
> [*] One could argue that having command qom-set is a Very Bad Idea.
> 
> [**] It just doesn't crash a stopped VM right away for me.
> 

You are right. The change assumes that the same device enters realize() 
twice in no supported scenario; otherwise it will break a real use case, 
so Philippe has requested confirmation from Igor [1].

The primary point the cover letter meant to convey is that the current 
QOM property itself does not actively prevent the "realized" state from 
being incorrectly toggled, as your qom-set example clearly demonstrates. 
This change is meant to align the setter's explicit checks with our 
actual assumption.

Since the cover letter omitted this explicit assumption, it 
inadvertently sounded like I was challenging it. Commit messages have 
the same issue. I will fix the wording in both the cover letter and the 
commit messages for the next version.

[1] 
https://lore.kernel.org/qemu-devel/a79f2ad8-d1ad-4536-85d1-0a01ad2f9513@oss.qualcomm.com/

Regards,
Akihiko Odaki


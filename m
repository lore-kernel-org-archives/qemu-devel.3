Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E756AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0O2T-0005pi-6x; Fri, 26 Apr 2024 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s0O2R-0005oH-Jg; Fri, 26 Apr 2024 12:03:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s0O2P-0001Io-Bl; Fri, 26 Apr 2024 12:03:03 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4DD354E606E;
 Fri, 26 Apr 2024 18:02:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5wk-KGWAIU7m; Fri, 26 Apr 2024 18:02:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 10E744E605B; Fri, 26 Apr 2024 18:02:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D42974570D;
 Fri, 26 Apr 2024 18:02:54 +0200 (CEST)
Date: Fri, 26 Apr 2024 18:02:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <th.huth@posteo.de>, 
 Prasad Pandit <pj.pandit@yahoo.in>, 
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 Alexander Bulekov <alxndr@bu.edu>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Sven Schnelle <svens@stackframe.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
In-Reply-To: <e2fb1d51-b5a6-4c25-a9af-af1e1ed42475@linaro.org>
Message-ID: <2691730d-795b-d60c-0932-f2e941343d91@eik.bme.hu>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
 <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
 <1497808863.2030924.1713955286878@mail.yahoo.com>
 <088ec61c-39ab-4b58-a02f-8897a3e7ae68@posteo.de>
 <81397221-8144-47cd-bce9-b3ab7d94c626@daynix.com>
 <e2fb1d51-b5a6-4c25-a9af-af1e1ed42475@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-78233328-1714147374=:20485"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-78233328-1714147374=:20485
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 26 Apr 2024, Philippe Mathieu-Daudé wrote:
> On 26/4/24 14:37, Akihiko Odaki wrote:
>> On 2024/04/24 21:32, Thomas Huth wrote:
>>> On 24/04/2024 12.41, Prasad Pandit wrote:
>>>> On Wednesday, 24 April, 2024 at 03:36:01 pm IST, Philippe Mathieu-Daudé 
>>>> wrote:
>>>>> On 1/6/23 05:18, Akihiko Odaki wrote:
>>>>>> Recently MemReentrancyGuard was added to DeviceState to record that the
>>>>>> device is engaging in I/O. The network device backend needs to update 
>>>>>> it
>>>>>> when delivering a packet to a device.
>>>>>> In preparation for such a change, add MemReentrancyGuard * as a
>>>>>> parameter of qemu_new_nic().
>>>>> 
>>>>> An user on IRC asked if this patch is related/fixing CVE-2021-20255,
>>>>> any clue?
>>>> 
>>>> * CVE-2021-20255 bug: infinite recursion is pointing at a different fix 
>>>> patch.
>>>>    -> https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2021-20255
>>>> 
>>>> * And the this patch below has different issue tagged
>>>> -> https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg08312.html
>>>>    Fixes: CVE-2023-3019
>>>> 
>>>> 
>>>> * They look different, former is an infinite recursion issue and the 
>>>> latter is a use-after-free one.
>>> 
>>> I assume the eepro reentrancy issue has been fixed with:
>>> 
>>>   https://gitlab.com/qemu-project/qemu/-/issues/556
>>>   i.e.:
>>>   https://gitlab.com/qemu-project/qemu/-/commit/c40ca2301c7603524eaddb5308a3
>> 
>> I agree. Commit c40ca2301c7603524eaddb5308a3 should be what fixed 
>> CVE-2021-20255, not this patch.
>
> Thank you all for clarifying!

$ git log -p c40ca2301c7603524eaddb5308a3 --
fatal: bad revision 'c40ca2301c7603524eaddb5308a3'

It seems to actually be commit a2e1753b8054344f32cf94f31c6399a58794a380

Regards,
BALATON Zoltan
--3866299591-78233328-1714147374=:20485--


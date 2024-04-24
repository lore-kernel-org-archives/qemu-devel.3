Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E59C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzboL-0005EB-Og; Wed, 24 Apr 2024 08:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1rzboK-0005D7-2U
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:33:16 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1rzboF-0003zB-Pm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:33:15 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 49D69240033
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 14:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1713961988; bh=9Ev9618ma5vERQhBo1JV5P5yZ6fPuNrS0jsrcfWeBHU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=ptv7qhbbNkf//eI2Nh9He1fmIKvifrvkBbId62jUXUbHffLCiCgT2gC/UxCD40QJf
 S/csiDg+SiKUem4x+H9XEYjGhmVzrjVJItNNweoSQu88/HZdoxqMsLQB6zMCJEFflH
 nqgkUP+6VeQC0qXurWQazaL7sS6hLcvRhJebf1NLm7lE+yaxV/bFwVQXYIm16NmwoO
 Ua/ltPSIkQrhjQrfL1HGbCG9QVhXn1X/ZYhr/EomV4N6v9hUVEgWGcQy6EQ4jNAU68
 Y/hCZ/ePP9xAwMjuBu+1gd1+3t+8ormTy2IWarKJuy11QfazKZI2+br5yTFAHVgMau
 NC1DWjGe6L8Jw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VPdgC5dCpz6twh;
 Wed, 24 Apr 2024 14:32:55 +0200 (CEST)
Message-ID: <088ec61c-39ab-4b58-a02f-8897a3e7ae68@posteo.de>
Date: Wed, 24 Apr 2024 12:32:55 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
To: Prasad Pandit <pj.pandit@yahoo.in>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
 <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
 <1497808863.2030924.1713955286878@mail.yahoo.com>
From: Thomas Huth <th.huth@posteo.de>
Content-Language: en-US
In-Reply-To: <1497808863.2030924.1713955286878@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/04/2024 12.41, Prasad Pandit wrote:
> On Wednesday, 24 April, 2024 at 03:36:01 pm IST, Philippe Mathieu-Daudé wrote:
>> On 1/6/23 05:18, Akihiko Odaki wrote:
>>> Recently MemReentrancyGuard was added to DeviceState to record that the
>>> device is engaging in I/O. The network device backend needs to update it
>>> when delivering a packet to a device.
>>>   
>>> In preparation for such a change, add MemReentrancyGuard * as a
>>> parameter of qemu_new_nic().
>>
>> An user on IRC asked if this patch is related/fixing CVE-2021-20255,
>> any clue?
> 
> * CVE-2021-20255 bug: infinite recursion is pointing at a different fix patch.
>    -> https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2021-20255
> 
> * And the this patch below has different issue tagged
>    -> https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg08312.html
>    Fixes: CVE-2023-3019
> 
> 
> * They look different, former is an infinite recursion issue and the latter is a use-after-free one.

I assume the eepro reentrancy issue has been fixed with:

  https://gitlab.com/qemu-project/qemu/-/issues/556
  i.e.:
  https://gitlab.com/qemu-project/qemu/-/commit/c40ca2301c7603524eaddb5308a3

  HTH,
   Thomas




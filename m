Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD1FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 10:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHjF-0003Qx-MK; Wed, 10 Sep 2025 06:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uwHjD-0003Qd-Ed
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 06:07:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uwHjA-0003Ok-6k
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 06:07:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C7EE656F31B;
 Wed, 10 Sep 2025 12:06:54 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lZeMQeZ5wwrA; Wed, 10 Sep 2025 12:06:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 724CA56F2CA; Wed, 10 Sep 2025 12:06:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7097256F2C1;
 Wed, 10 Sep 2025 12:06:52 +0200 (CEST)
Date: Wed, 10 Sep 2025 12:06:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Julian Ganz <neither@nut.email>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
Message-ID: <a18a99ca-8415-71bf-3022-c9a98e46c2b5@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
 <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 9 Sep 2025, Julian Ganz wrote:
> September 7, 2025 at 10:21 PM, "BALATON Zoltan" wrote:
>> I have uploaded some PPC binaries for the STREAM benchmark that I tested with before here:
>> http://zero.eik.bme.hu/~balaton/qemu/stream-test.zip
>> which may excercise this if run on sam460ex or ppce500 machines but I don't have a scripted test case for that. There is some docs on how to run Linux on these machines here:
>> https://www.qemu.org/docs/master/system/target-ppc.html
>
> After spending too much time looking for usable root-images (and then
> giving up and just stuffing the executables in an ext2), I got to run
> these beanchmarks on Linux 4.4.5 configured for the Sam460ex from [1].

Thank you for testing this.

> I ran streamPPCpowerpcO3 on qemu with these patches:
>
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            2867.6     0.056828     0.055795     0.061792
> Scale:           1057.5     0.153282     0.151305     0.158115
> Add:             1308.8     0.187095     0.183380     0.193672
> Triad:           1111.6     0.220863     0.215902     0.230440
> -------------------------------------------------------------
>
> After doing a clean build, with the fans still audible:
>
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            2932.9     0.055131     0.054554     0.055667
> Scale:           1067.9     0.151520     0.149832     0.155000
> Add:             1324.9     0.184807     0.181150     0.191386
> Triad:           1122.0     0.220080     0.213896     0.229302
> -------------------------------------------------------------

What was different between the above two runs? I guess maybe one is with 
plugins disabled but it's not clear from the description.

> On qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
> patches, but plugins enabled:
>
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            2972.1     0.054407     0.053834     0.054675
> Scale:           1068.6     0.151503     0.149726     0.154594
> Add:             1327.6     0.185160     0.180784     0.193181
> Triad:           1127.2     0.219249     0.212915     0.229230
> -------------------------------------------------------------
>
> And on qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
> patches, with plugins disabled:
>
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            2983.4     0.055141     0.053630     0.060013
> Scale:           1058.3     0.152353     0.151186     0.155072
> Add:             1323.9     0.184707     0.181279     0.188868
> Triad:           1128.2     0.218674     0.212734     0.230314
> -------------------------------------------------------------
>
> I fail to see any significant indication that these patches, or
> plugins in general, would result in a degredation of performance.

With worst case Copy test it seems to be about 3.5% (and about 1.7% with 
plugins disabled?) and should be less than that normally so it does not 
add much more overhead to plugins than there is already so this should be 
acceptable. It may still be interesting to see if the overhead with 
plugins disabled can be avoided with a similar way as logging does it.

Regards,
BALATON Zoltan

> Regards,
> Julian
>
> [1]: http://www.supertuxkart-amiga.de/amiga/sam.html#downloads
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43699C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 07:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGuTq-0007sS-1d; Mon, 19 May 2025 03:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGuTg-0007oU-M1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:00:00 -0400
Received: from mail-106101.protonmail.ch ([79.135.106.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGuTc-0000PB-KJ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1747637992; x=1747897192;
 bh=dy8QWlyCVxATh85hQFDbbNJaboD8V41cjUhdGo+/daE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Vx9gvJHLrdS2m5SOBcodPPddg9LE9PSJ4zIJgOwUN84QcxJeYT4oVD/bAdZn8nR/b
 pkbqaGczUtf/+et9xxAX0o397gQPiiCgM2Q5K5y1RyaEB2qS1apGIV7s2jWDGADywf
 MwTwPIFsjNW5A7KMqYSBivjwIoyHt47Oi7Mu7n2wZiUcgXWwwX53nIqp0PzIcxE4Z7
 bofuJCyLkUTO9Ur3tp/FFyJ7RJ/FJT4FV8mM6BvN6CSgA7XWvvMcx2n47K7c0IkHPt
 oxXF/WFcDpFrtVqUTZUZ7oPNQHGQKUE/HKs+J3UWYHnxq9KvjW9BsU5SCf58McbjxE
 7m3uEoZrBFZTw==
Date: Mon, 19 May 2025 06:59:48 +0000
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
Subject: Re: [PATCH] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <E4Tw043i3BaGIoDJcv2goFAjtxMAUUdCctQUsQX7YX-lRIZBR8RgJuQ4twN-AQcGS0A5Q6fdjNPSKwMDW0qmZkx832IJjV4XnCZ8oaEmh6Q=@proton.me>
In-Reply-To: <96ecbe23-c3b6-488f-99d6-7875e5b3ed4c@kaod.org>
References: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
 <20250518171730.1ba5bc31.alex.williamson@redhat.com>
 <6TP1d19UA0waLH71Mea1s2U0yFtyKMpqqf6miU7O44BYZm04F4vOJ5c565O09PliXCbSNJJxuIm0zh2Re-gWa6jo08YraLuPOdebgp30n5M=@proton.me>
 <96ecbe23-c3b6-488f-99d6-7875e5b3ed4c@kaod.org>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: fd924681b56d479fd0b8f93cfe80b56c93159456
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.101;
 envelope-from=edmund.raile@proton.me; helo=mail-106101.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "edmund.raile" <edmund.raile@proton.me>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>Hello,
>
>On 5/19/25 02:01, edmund.raile wrote:
>>>> Restore SR-IOV Intel iGPU VF passthrough capability:
>>>> Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk and
>>>> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
>>>> respected despite subsequent attempt of automatic
>>>> IGD opregion detection.
>>>>
>>>> Fixes: 7be29f2f1a3f ("Merge tag 'pull-vfio-20250509' of https://github=
.com/legoater/qemu into staging")
>>>
>>> Can you bisect to a specific commit from the merge?  The merge may be
>>> where the issue was introduced to mainline, but the merge commit itself
>>> is more than likely not the source of the issue.  Thanks,
>>>
>>> Alex
>>
>> I have to admit, I have no idea how to pluck apart
>> that merge pull using git.
>
>Please use git-bisect. The manual contains enough information to get
>you on the right track.

I'm quite impressed that git bisect in main repo has the power
to bisect into commits on a branch of a fork repo despite
being summarized into one commit on the main repo.
I did not think this was possible which is why I said I don't know
how to do this.

c0273e77f2d7aab3312eb557b49332da528ff66b is the first bad commit

So merging it into the main qemu repo changed the commit number
but it's the very commit I found; it adds the automatic IGD
opregion detection.

Should I send in a patch v2 and correct the Fixes tag or can you do
this while committing?

This would then be the correct tag:
Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
>
>
>Thanks,
>
>C.



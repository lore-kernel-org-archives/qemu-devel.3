Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B150FA3737
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2os-0001kk-S4; Fri, 13 Sep 2024 05:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp2or-0001ih-B0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp2oo-00062f-M8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726220526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJkhQPiSKdRkmVyUKXUtQbZEtA7PXpxPZiria9pOzYY=;
 b=VbEZbe01PvLiM5GvHcZDYbZwpBXA/MnLq6vIzyMhI7SblzFU9o/8TryTg1YlRfyibw+fnO
 NfiUunmHrpsjCpw1IVHpMjKpoqOCPNBG516cg9JWkM2NUHhidPY5FHih3384c/0UNo2LHv
 X46cjcCoe+D3klV818FPfxP9AsRoLQI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-O6PNLa85MTqqL2w6A9UNgA-1; Fri,
 13 Sep 2024 05:42:03 -0400
X-MC-Unique: O6PNLa85MTqqL2w6A9UNgA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D06DE1955D45; Fri, 13 Sep 2024 09:42:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ADB419560AA; Fri, 13 Sep 2024 09:42:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13CB621E6A28; Fri, 13 Sep 2024 11:41:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Bin
 Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
In-Reply-To: <CAFEAcA_SvWnSy8gs0G5dK2rgCYX19yE-QBPaF5kWEqAXP53wsg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 13 Sep 2024 10:39:20 +0100")
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
 <CAFEAcA_Yfcjuz+3KfiKPDY2aVU1OuJ3B-9q9F82-fGCS9PTi+Q@mail.gmail.com>
 <87bk0s2c04.fsf@pond.sub.org>
 <CAFEAcA_SvWnSy8gs0G5dK2rgCYX19yE-QBPaF5kWEqAXP53wsg@mail.gmail.com>
Date: Fri, 13 Sep 2024 11:41:58 +0200
Message-ID: <878qvv28m1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 13 Sept 2024 at 09:28, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 3 Sept 2024 at 21:04, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
>> >>
>> >> sd_set_cb() was only used by omap2_mmc_init() which
>> >> got recently removed. Time to remove it. For historical
>> >> background on the me_no_qdev_me_kill_mammoth_with_rocks
>> >> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
>> >> thing created by sd_init()").
>> >>
>> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

[...]

>> > Should we also remove the sd_init() function in this patch
>> > (or patchset)? It was only used by the omap-mmc, and it's
>> > because we have no uses of it that we can get rid of this kludge.
>>
>> sd_init() is a legacy initialization function for use by non-qdevified
>> callers.  I'd *love* to finally get rid of it.  However, there seems to
>> be a use left in tree even after "[PATCH for-9.2 00/53] arm: Drop
>> deprecated boards": omap_mmc_init(), used by sx1_init() via via
>> omap310_mpu_init().  This is machines sx1 and sx1-v1.
>
> Ah, I hadn't noticed that. I'll have a re-read of this
> patch based on that knowledge...
>
>> Ignorant question: can we deprecate these?
>
> We put them up as candidates when we were deprecating the
> rest of this, but the feedback was that kernel developers
> were still using sx1:
> https://lore.kernel.org/qemu-devel/20240214012749.GA203324@darkstar.music=
naut.iki.fi/
>
> It is indeed a bit of a pity from our end that we couldn't
> drop all of the OMAP code entirely. We might get another
> chance after the next round of kernel machine type culling
> if they drop armv4t.
>
> Once my patchset to drop all these Arm machines has got
> code review and gets into git we can reassess what we
> still have and look at modernising the stuff we've kept.

Makes sense.  Thanks!



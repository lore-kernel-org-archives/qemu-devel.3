Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA1CC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVU0J-0008HO-3I; Thu, 01 Feb 2024 05:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rVU0I-0008Gr-4m
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rVU0G-0008J2-Nq
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706782143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GPcIKuV20VGbamqWN++eX56LYzLZjNaVkBFFDyuZLKE=;
 b=FhFWtOT4LroDXq7QPObEyRiOHMRuH9M2qBKNhUaZdgYQG+fCpSVZggQMaOEjRu7n5FWf94
 qMF2OTCbOWSE8bh4MQE78bzLRSfH+ofaHM7B5vYY+eprrcW/FTkkJ0T5JK/Cv3bzaihyMt
 OC+sZ8FhfLuYAqKLVHFBcLKa/FY28DI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-RaaTcfR2O5-nRK_XHsOceg-1; Thu,
 01 Feb 2024 05:08:58 -0500
X-MC-Unique: RaaTcfR2O5-nRK_XHsOceg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E81193C0C102;
 Thu,  1 Feb 2024 10:08:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA4A400D5CE;
 Thu,  1 Feb 2024 10:08:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 771961800908; Thu,  1 Feb 2024 11:08:35 +0100 (CET)
Date: Thu, 1 Feb 2024 11:08:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Re: why various devices are loading x86 roms on non-x86
 architectures?
Message-ID: <7lhikobeiyf5r4bprv64l4lwtfwk3lrum4rwh3h4wrzr3mldu4@x6oanlwyimqj>
References: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
 <CAFEAcA_qxALhqHgd0zO6v6ufTaHvmiyyHuCDcHZdxRvbh+x_Hg@mail.gmail.com>
 <a2b12e13-1e6c-82d2-f1c5-63e76158945d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b12e13-1e6c-82d2-f1c5-63e76158945d@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  Hi,

> There are also some PPC machines that have BIOS emulator in firmware and
> would need the ROM to init the device but these have problems with QEMU's
> gcc compiled ROMs that contain i386 opcodes and can't run these.

That used to be standard practice in linux.  Before we got kernel mode
setting the Xserver ran the vgabios code to set video modes.  On i386 in
vm86 mode, on all other architectures (including x86_64) in an emulator
(x86emu fork IIRC).

Fun fact:  There are a bunch of hacks in seabios to avoid certain
instructions in vgabios binaries, to workaround emulator limitations.
And, yes, i386 opcodes are problematic, even though at least the Xserver
emulator became better over time.

take care,
  Gerd



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72353C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ede-0003k5-GD; Fri, 18 Sep 2026 15:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7eda-0003jX-5I; Fri, 18 Sep 2026 15:52:48 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7edY-0003Tk-25; Fri, 18 Sep 2026 15:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=w+9Oc1G
 Z+tSc2422JUufOk85mLpBtgfjlwkY0HBK0iQy2+DKIWVsTI+RG6GwEI89nE+4yES9RBWB4
 25qbHD2mGjNDOTKUOZYr1BigSn5Wps42evAnytg9u9tMKPFl6it5uaN9X5IkdWrP7FjEzs
 Wk+s9O1DMt7IWGwUTHTWQZF12/F3dNvdCcm2RbgnfUHHnfQUWHId6G61rbtlnQSJtjy5pm
 CT/oRoTI36Gj0bs/kq5iMilOnMBZ5YU+tVPh5PZ6lpypHlXPUg5TtJrXQys7HtiYw6jdm9
 HLEl1SXCzUtdFCq6+ZMAzx5V/G/F5mQJEnQYGM7dv2SODZZ92YXfOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=V
 KEZJZ1wvNuD36ERDKSH5tVfm0IejyRum9qish0hOIE=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ewbYg+uyvjI6kFDtiy6iFTVe/L8ZDyc1s4997cdqVvNHpvKFak414zZI46c+b8p8iOnu
 gWMel2v+zG5ynzpZH79Y5suvZsEkKVzkZZA8lMGNA7Ci5BLpr/9QLGvpkA5vR20LVd7a2h
 HSD7cCGaqUrWH+7D8PeuyhlRmcbfIFhNfSlOBkVZm5gJ9n4otmBdyl8gj17OR8nU0hOOfv
 Lz+XZXFwI1hP1nii4qjB1Ydjv3or9p/+hFRICsIboFqnyr3FJ4CuH94d1OuLANGK71PNo1
 796sxIwrnXc59TKiMDnwXxF0SauM3dxKx2KcvElsAi3PRYgY5qNsMk6ngm43VxYg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=TQk8ZoVn; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=0Ud1RvhT;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=VKEZJZ1w
 vNuD36ERDKSH5tVfm0IejyRum9qish0hOIE=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=TQk8ZoVncvwxWWZR2q11SwfXbnvb2O
 ydiQlibwzIq7/Sm/4xOjoEt9YY3qnxkaWqrIbvSXGLZFqn6SEee9eJoYYnqxYU4zer44Bg
 0diXxNowMgQJK+2oBmloQSfPBxzsXZFaryRn1qhiPQfYZBLhy7RPIkcE4/ZXV+uVdzcarD
 AyXX8rTZYI3B50C/0B4XqgbTCEd3SPRCAG83lO9adFRJ6Xh53A2eFGvxNH1f0RhlMZnABN
 yiSUN7au+mvpOc++ZIFAB0/HJrBDfhC5YJM+7h1rerBuHA0bOlIOwSVtncGOoW1P38+6Ti
 8SAkdpBopBHR61moj132t2+iSmPMfXdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=VKEZJZ1wvNuD36ERDKSH5tVfm0IejyRum9qish0hOIE=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=0Ud1RvhTt4dLL+PTqv
 YlbgXmvlZJfih5807dcxnXYh4RKONyEhN8DbShxUVLHN9nI4diXi+oIIT7JNKQRWgHAg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 28078bd0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 18 Sep 2026 21:52:34 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 56eb637c;
 Fri, 18 Sep 2026 21:52:31 +0200 (CEST)
Date: Fri, 18 Sep 2026 21:52:31 +0200
Message-ID: <87h5jmuykg.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 5/5] tests/functional: Boot OpenBSD on mac99
In-Reply-To: <0a82d49f-61ad-32e5-fd78-9adbe2e6c2c6@eik.bme.hu>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-6-kirill@korins.ky>
 <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
 <0a82d49f-61ad-32e5-fd78-9adbe2e6c2c6@eik.bme.hu>
User-Agent: Wanderlust
Mail-Followup-To: balaton@eik.bme.hu, mark.cave-ayland@ilande.co.uk,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Fri, 18 Sep 2026 16:18:52 +0200,
BALATON Zoltan <balaton@eik.bme.hu> wrote:
> 
> Isn't via=cuda still the default? But why not use via=pmu instead that
> actually emulates something that exists in real life as opposed to G4
> with cuda which does not match the rest of the hardware mac99 emulates.
> With mac99,via=pmu it is close to a real PowerMac3,1 Mac which is also
> what OpenBIOS tells the guest so I think that's a better config to use.
> 

When I figured out how to make it works I had tested both via=pmu and
via=pmu-adb and both reached mounted rd0 but hangs.

If I recall right (it was in begining of summer) I had some issue with PMI
tick and some IRQ.

-- 
wbr, Kirill


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A562C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eb2-00036W-Hs; Fri, 18 Sep 2026 15:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7eam-00036C-J0; Fri, 18 Sep 2026 15:49:52 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7eak-0002yX-Un; Fri, 18 Sep 2026 15:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=tjRd+3F
 GpX0t/llGO6leqiabrLFjSpdlj350XvamsXKfg/gx8Qbbyd9Ooji8eXPEjII2HJl7T5wWW
 Y94lKwKo832wEhnFD+cA5iTyDGI1oX5P4xiDGYV8qI5ZTOYgJKE9BfZts/vD0uME8rUjrX
 3rjmGJHfQN3KMpHXQKMFMr9k8yHPB0U0irTvyDT7J/7wCy/k6B9wyP3L7VVOua+9bMLvmB
 fK330c9KesmwJjGFQsM6yUFZy+Z5nNUou+q+ixPOqQGHP1wJTJsUreXbcNry6ps/WiQaWS
 08n4hrLjztPd+1Iz9hSj75mgg3VROlA4keUsG6ZgwWrUhZchb8+TbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=g
 UbBF+qVUuEm+gsBHH/snw71XluK/8HURrB3/7ZmKJw=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=NEriHdlF3yFadruwiXuDwpmn3Evaf192o6Wu8sat7aAN1j+7MXLXe4w71fsb8FW++O3a
 QpgMgmjv3AO7UEgE6VsvoOpHzTeUkqsi8cqcOBYK1kAaXo9L+ADeOxF3cGliWDJVMT4OM6
 J0g+ARBTjd7gAP4+Rm9Hr0rIBBLnStD90lnjY/cFvRHCFK3xeWMjz8ufGOAEbZLwRivyZ9
 uzbBiTExxQOGIJfyVXfq9dPb1Sj5PTK8npLfCWRjsSHqOIGhnkbKMNhmtq4isI5QMCTWjM
 jQ8JufUV+QsM2nUAp/wpHRC6UJqba39K0cPlkHKYtN6Y5kcwle4JCBMOwevq7mBQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=y7dmDuSi; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=6Zuk2RCu;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=gUbBF+qV
 UuEm+gsBHH/snw71XluK/8HURrB3/7ZmKJw=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=y7dmDuSia236UoMqcWD1dEvTA7Kf6z
 oHuYWaXPLBLySiMGaYATudf6fWagywtdhWJniIrnXsm8rBKXAt/pc9ZGp4/qc2iEAN6sY8
 kBnWRyXpktZZloLUK4KVrhU+6nGcMTZKM5LKJBXZFltw21DwEFpQHI69NtbHmfaR2emY29
 emxJV/hCEx1OhBSneLIVZBh3NfRR3qIWHZc6u4BZ90TKPLUwDBXAEDJkHQXDOhJyc0bAmw
 KfG8t18pdCXcxKj/hq58VirovLEPukxeGkZug/6hgKNHkVb0RWcWAggVtGWwq3/Qqtj2Hg
 pt9FkQ79kSz+quqoGy20dbOAp/7169JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=gUbBF+qVUuEm+gsBHH/snw71XluK/8HURrB3/7ZmKJw=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=6Zuk2RCurIbI2SYWin
 pFRhsFuDK9Sil17XSXjXpZROVMROyT+CJIXkhtpuukJ8a2yYLgZrWO2abUz5oaZDdzCw==
Received: by mx1.catap.net (OpenSMTPD) id 6b813e17;
 Fri, 18 Sep 2026 21:49:45 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 21cda148;
 Fri, 18 Sep 2026 21:49:43 +0200 (CEST)
Date: Fri, 18 Sep 2026 21:49:43 +0200
Message-ID: <87ik42uyp4.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 5/5] tests/functional: Boot OpenBSD on mac99
In-Reply-To: <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-6-kirill@korins.ky>
 <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
User-Agent: Wanderlust
Mail-Followup-To: mark.cave-ayland@ilande.co.uk, rathc@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Kirill A. Korinsky <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
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

On Fri, 18 Sep 2026 15:28:39 +0200,
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> LGTM, although I'm curious as to why you need to set usb=off - given
> that USB is mandatory for mac99 machines, presumably this means there is
> a bug somewhere in our OHCI emulation somewhere being tickled by
> OpenBSD?
> 

I haven't dig into it, but my survived notes states that I had: unsupported
OHCI revision from OpenBSD kernel.

Disable USB and move on was a simple solution.

-- 
wbr, Kirill


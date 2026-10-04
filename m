Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DD6CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDNuT-0002Ql-8x; Sun, 04 Oct 2026 11:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNuR-0002QN-Sq
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:13:52 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNuQ-0004zY-Hz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:13:51 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so7696767b3.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791126829; cv=none;
 d=google.com; s=arc-20260327;
 b=oJQB8r53ITbEsmXNT9DclTc8/iPPKCz49u1DwNVFT4eRZnbl02D/Qg/cyIDfW/2uM7
 tx7OIKyNxR/TePnpujmHfYhUI6xUePpc8eSG1TxhiBPxU3YglF+6gV5yGC7zT22nU3Ds
 22q08rL8l6ZDylp8WvNomtA548TeKfbbWi5Y0cE4DApDJWlx3anOMA5RjkH9NN1X2JNl
 SvHs1EX3z7vDEetSzbaR0LA/4L5JnJDs95epcY3R2Og+PpH5ZKzhsOx9XlTHqnii8LKl
 ksWfn845Jp3hI9ENb1l+JEOM/tkn4HtYwT8+2IcPzZgqiSYSULx0lxM/59ZT+t9Uiqlo
 EyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H28ncu6frmzApRnUTc09JypBbs/vijoLmtv7rbrufYE=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=rpT9OnmWm77phn3EON4CcAA8Et34p8eouHAC4l1RcWp62IbllkK786t9AfcaNbfzHD
 W6O8Etmd1asXKQpE3vvi5q9ebOTyKLWpnmybW2TCuxZse9Pti7hOZ7lS54M4eTid9gk/
 bn6QzXsROa/OCHica+w6GIj5fk2VwHPdMRGhtdbVzYpLX0V1xDMzbPCPDq0F9h/Gyal4
 HoPtYFXKsjHQKieqabiPHX1Am3VsLaM3qTlA4jf1GcoBWGiUYHsaFKOmkBHCPNWQQmyv
 e8PwqNE/UH0NpVIs//CCYtSxH/HqkovcMIHI/kRITPsmQydoEzjloXdTQRZ82KNBJ8d1
 ZD/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791126829; x=1791731629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H28ncu6frmzApRnUTc09JypBbs/vijoLmtv7rbrufYE=;
 b=iI0ojyBHPzg6boSgCTOCYEBkgDmkXe9bg+6WIBXrlDENSYgt8VirThXI4INE3FakFJ
 EM2oFLAFRUqbO/FktdkiN2TVTJcFR89zF/ayiqdZGnOWYmiHbilG9w/KJzr/kVOlPBNQ
 QD7UCbHLB0LL0AFm7IFf4MWiYT/RCP6xWrALI/wd5w9/DKy0zLqn+u1PAYqbPcC+sSvM
 nPGvKfriDSuu8GisM/WWMf3bAXq58x65HHVA47FdfFWaLY4P+97kh+padn04S/czxMOG
 9RzOHIVo5Sdnc3U466SDICQD0InpwvyuYNhQPrFaieZmXKPZssGSwoXZbgBodb0ayKQ3
 EA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791126829; x=1791731629;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H28ncu6frmzApRnUTc09JypBbs/vijoLmtv7rbrufYE=;
 b=O9404B05uKFnDdJtYf/ahDBEvF7zI05iduesbh0Wn0RCgZuUTFtse6ixdWa8V3QDC5
 TUzxjWh/pTCWLCome80LLSrdZW+EIXXDOAOyxLbYvW006TvrDkTtqLXbV7sum4dbEczt
 Z+262wyQMYExfZ2XyIsYO17GRI8MQ0yHngs5njqP0ZuzfiRl6p3dZlTbC6k1JJRjwKrz
 nB2rmiXb7o7t+bIa2USfER/Ji6ZaS8/hEEHz3ZdUVziIAMYqKEiJhn9HZNYO5lAAHGFj
 BaEF9vUpZ4bCex4qBAWHbMcwbCKXS784EPr2EigI+kMvvq4EtAvr53O5Csyg9A9KN9Ye
 C5LQ==
X-Gm-Message-State: AFq9FYLSXGmswAeVZuElCw6U/JZT3sSMbK9GXBXqazbEpXDttFE06glk
 4kfq+qcE4tBFsJdehQm4+r/ImSrcU/7GxyOjZz65DLVbiBMyyvXwDhOgX9uvU+YCETY0qRqYU5i
 LpcZgfS28R4BdaMUUq8xQHR1sEyqiqRs=
X-Gm-Gg: AYBFou3n5ccHzczftS2jrFIC18IqE1WkkBVND53o1tsGwCFti/0/v5MC81p15qC3JXD
 HNsM/ycVhigJ0k8H75TSC3COho3JCQ9xml9j+o36Npb9ncSkTY+bpyTRab+cX1XXcC1Hpyy7+Av
 Vm5IS5pUxF6ENPLxIK2rhIUXRbdAmABBvCp+rwpob+bsI/vUex6wRZb5SZE8jawo9UGBukAP9FJ
 GTHv+iOE6BlX6k5esSByYpz5UX9jmyGTD1PD5lgOM5zlweX5JSnsX29QlsHj4N4EHP8uzKbvPdL
 1yDWZuHH4lKrfykaAW7wJgjbfy5J4Gh4x+RHBAE04T0za3e/LGdQik9B9fHynCAje76Pn+hixyj
 dKXfbtNYL60JaFVo=
X-Received: by 2002:a05:690c:e3ce:b0:8ae:9080:2c1f with SMTP id
 00721157ae682-8ae951f3caamr20383677b3.36.1791126828716; Sun, 04 Oct 2026
 08:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-3-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-3-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:13:36 +0800
X-Gm-Features: AclHuK9dWQ6Zx5K--ao2lV4SD2QXTQc1YtePyBOawwK_3Dhrcaa9a_CnMnq3g1E
Message-ID: <CAEUhbmUtDSiqoV3tP9XfWW+8PM5jeE3r=8Zn21MHcNx1y6JSew@mail.gmail.com>
Subject: Re: [PATCH v2 02/30] hw/watchdog/wdt_imx2: Clear WDT lock on reset
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> The WDT bit gets reset and becomes writeable after power on reset which
> imx2_wdt_reset() represents. While the WDT bit in the WCR register
> already gets reset, its locked attribute wasn't. Fix this inconsistency
> by adding the missing unlock of its locked attribute.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
> cc: qemu-stable
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h | 2 +-
>  hw/watchdog/wdt_imx2.c         | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


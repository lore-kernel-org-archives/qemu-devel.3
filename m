Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0BBD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 20:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlYXN-0005ZS-Bh; Thu, 29 Jan 2026 15:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlYXL-0005W5-PR
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:22:43 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlYXK-0003is-7x
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:22:43 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79407df9391so15990307b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 12:22:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769718161; cv=none;
 d=google.com; s=arc-20240605;
 b=VF+RjgieY+blWhigz6p61oc9s5sekRZoPGpSfXuD+OBRt6PQhQ3z2vEkuWYiX35nih
 /ECFXywOSOYdj9QYS7kMRLSQvaFrrwSwz8oqDPEG4VfqH4sFQQm12ricHNx+O4Jpru/5
 67KDtgAfeA4jepCdYsTZOW4K2V3FTGMvRW52Eep4zyRGp6NnNfqcCTpe4e4kTTd3aWu1
 l1HSZcrtMccFMv2MXyUdwDI4xYbPRZW0dMxg2BkluNc7vlmjAw+IO1V738CYINm7Zfbl
 bXBhNSpQdgBcczr/N052Q8tlU9fOfp0LflI2hGer1XZEnZ1ayyvA/BeTA56R0SGamhzO
 C6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aU2z3bNks0j3bkdBlILKsSzCqe9sIlvTDoNxUtgSmNI=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=ibCRNMz0edJrBPCBxSW8kmrwA1C030nwE+mUAi6mI1lYF5m9Rq44I1e2KdgbaAxn7u
 27pzM06xUe5AZ6TrcwqQGWd9dG4MZ2m/Qm0+hZ8djT1oqpGqZcGHq6Yq/OubKPyACMLJ
 jA597gUbcX4VjTJYZ+Uk/6K1+zb66RkhEFdkvdL6IGVF/72BvnBaJ1Zvaigbr5xNDNcI
 ixXXJm4AQ3Hj5b1382XFfBleq4MkqQ2Bq/1jScItvj3xsh1oBzMVk3t0MD34PWP4OTN/
 wjDQLfTeDXhvrQ9l4XV+XjMzIke9T83qPJc4B7alpagRruXdUn6S/IXUIFFq151/NQL0
 ZXKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769718161; x=1770322961; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aU2z3bNks0j3bkdBlILKsSzCqe9sIlvTDoNxUtgSmNI=;
 b=NVnw7PnTHDnBxIlGnyAZLMvqOIHRxVn0PKkzL4dzsQMKeSKBsodbf4WRizfWI4XE//
 TGnSrGurPJEMD48qQym0O2rgfwR4aIqFsktQLXVr7SSJh9MtuXvfnvyJuSaYJAW1xTr0
 +Pwm157P/C0eSHXp99xH42i14VUmjiLG5UG5hBV70J2crN//hnb10wS0Cv2hTEM6of3Y
 HrwDGW/Jas3rNy78pCj0UGQXzTAzymJjWkkfg2MGRb/eYPO3qtv0fVD4aRTJNYY4BlTf
 PiplsLMgV2pp9J8PIWL8ZYC++8S4TiyTpjpYr8MYAtrZl5BeNxdV9b4/11qV/BGRrfNi
 MGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718161; x=1770322961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aU2z3bNks0j3bkdBlILKsSzCqe9sIlvTDoNxUtgSmNI=;
 b=YWK+ALE9sSPFzMt99vP0AjsZMaDRNNxFcvRMfaq2uOzlo0NP+bgT7ZTpk5WAUWux8D
 15/CLYFbd677Rk/Tz5ilaWrisX+IDzgZJ391nKo3vM2F7IW3OsUFLK2NrhDXylrTE9le
 TrtabtGEECt26LulfFmGGG9EG3PxHUmQcWyZgQlAJiR7KHlDWux6HjR4q0o0LiVrS7gc
 wQEWD/mkPbVPQyQxfKaBAoEgxobsYynvoj4pySEVdyeUbtMfW4rsrpS9vfdoHKq9d24g
 3JdI9nyc10vaSfAtk4tiX3gKVYwkmBBupkc+YVsd4t+ZVxjVcmVCK70qnFpO02vbd2AO
 5ZJg==
X-Gm-Message-State: AOJu0Yyu0oTOdwcpOzQIgABFIJFAK/+gx9UqVCgtmml9Ecc43X4ngqRd
 3vFD9JWHeZIo+XdD+nAld7FU2YJ4KCkR20SVkXnDwtvN0vqiWC10yUwAfx4RJL7tGlTu6KDh1j5
 1aaIAVsksUpxYyw8IuyGHK82J2Z8G2t06u9WpVcC21w==
X-Gm-Gg: AZuq6aLjEK4jDGH/T//lAJjK/DHZhh9x0l1GgOjz2SaE0wVkValAzqEaHcG3CkgIlLY
 mTifZSmXLCouR0XO7emHZgjQv8qDOynv+kdoTxuXYMnx7X+x28IzN65WrH4vS1R4uG2GvO84eJ3
 AoWe/0FBtTozk0Hi1OLMPPwBz4D7We3+0FxI7DSXuWKJ4wVWyO4fXdysLASr2VL4eTHDGge4HN4
 3Uv6qKeJfancOSzb+xZdY8WvRb+MYahWcf8a+M0irJbbVof4DdTOLttAnZMLGIN9j6uQ3mOdgO2
 Sayj
X-Received: by 2002:a05:690c:22c7:b0:787:fa8f:beac with SMTP id
 00721157ae682-7949dfe6cdbmr6933887b3.46.1769718160682; Thu, 29 Jan 2026
 12:22:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
 <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
 <CAFEAcA9htbxy0fHZAvdX6Rneina-r_a1ajN3w3FHUL=hykcyug@mail.gmail.com>
 <69ca374e-960f-89a7-0f74-b42977a51d3e@eik.bme.hu>
In-Reply-To: <69ca374e-960f-89a7-0f74-b42977a51d3e@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 20:22:28 +0000
X-Gm-Features: AZwV_QjRsf_2qPjdgp9lwRhomvRyE0Mitgrn80VOXccQaawxoIoDiTaITeVBbCA
Message-ID: <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 29 Jan 2026 at 19:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 29 Jan 2026, Peter Maydell wrote:
> > On Thu, 29 Jan 2026 at 17:20, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >> On Thu, 29 Jan 2026, Peter Maydell wrote:
> >>> On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >>> This is a migration compatibility break, because the
> >>> memory_region_init_rom() function registers the MR
> >>> for migration via vmstate_register_ram(), which picks
> >>> an ID string for the memory that includes the path
> >>> of the device, whereas vmstate_register_ram_global()
> >>> picks an ID string for the memory that does not include
> >>> the path of any device. It is this difference that is the
> >>> reason why they're still using the _nomigrate functions.
> >>
> >> I thought it might be the case but wasn't sure. How was this handled in
> >> all other machines where they were converted to not use _nomigrate? Only
> >> some Sun machines still seem to use this and this may be a good
> >> opportunity to bring them inline with all other machines.
> >
> > If I remember correctly, we converted all the machines where
> > we were happy at the time to have a compat break. The remainder
> > are not only Sun machines -- you can see in your patch 4 that xtensa
> > and vga are also affected.
>
> Well, almost all of the usages are because of the Sun machines and those
> could be easily converted accepting one time migration break. The VGA one
> seems to be because of isa cards which may not have been QOM'ified so
> could not be converted before but maybe could be now but I haven't checked

We can't change the the vga usage, because it's a migration compat
break, and you can use vga on x86 PC machines, where we do care
about not breaking migration.

-- PMM


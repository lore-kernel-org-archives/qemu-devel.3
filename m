Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F7F31E22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAq7Q-0007o0-LA; Thu, 09 Apr 2026 10:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAq7N-0007np-1T
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:12:25 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAq7L-0000ad-DO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:12:24 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6501547d7edso1049184d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775743942; cv=none;
 d=google.com; s=arc-20240605;
 b=Jnjg0IqzNhRPlq33VMF7d4hZEqprR+21rz8+zqPB51/sklUl/SJNvSY2KQTK21no/b
 gUtGrRKe43uT5uww8FNoLX1G3VAY+JYoZJGTTV0idy0I0SL895uLTXzB+zQ6Ue8wz8jy
 ohbMKImr+Ut/NG17xSFSxWIb7wACSG1sg0G4vGO9616ooEJ/2iQ8LGCvkl3AnEU6lSTX
 j2YRexWo30znqmd/medH8hJVZTcRWdxXfBl/JP78uqE60qLnmlsGPcKCuswZeHNA5eKX
 dr9T0UBZOSEVolrL2sJOIlV4nh+1HwsmtoXHm3gPX+pE69C+2+m7chIhmyW+bfuwe6F+
 DBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b2z42WOuLOI7rDV2kLC4AvaPFIpQG3uUaTwCXq5nxfs=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=itQiDA+k9fb+8w8b32cvV3mTOc3Dy0K0vyVgRZaBcSTe2MZqsmTRx7SN303GJgWSuI
 0JM8DvtfOHLYqoK3o8rZKeAJk8TsTR/qksbcajlzDFDtho/rzrfOhol/cPwBnnqYD9xD
 +Ew2UO8m5acOewvm80SbuCqeoa3eltjYCTqo1HLhQruwwYCI2HghSI6xYkoaQmRr8G9y
 EZNr4sxiwg8ey5YuGtnwoqibHhsKLBhmgiX1IDkCNfDRJDhe8f0AoQ707FrU2t/cqhYT
 lZGH8BjPYzdg2E4GDrJyGhQHI1B0hci3jgVGhPTRVKY0JF3OIixDD8r5ZiCkzKQg2VII
 Pydw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775743942; x=1776348742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b2z42WOuLOI7rDV2kLC4AvaPFIpQG3uUaTwCXq5nxfs=;
 b=IDeWyYcKjiimd/NAUlyzoR/QqYhH6n7qwuFdqeEVc4YWIw+PBM5xr+so3YVgqiZY0a
 4ATidQgKUp5orF2150N7ptiZk5DQUKvh5sdUXVEN/PD7buJ8owkgTBs6O197nsD1XnJh
 dwQ4XSG29ewU+9gw6B6RwK4KZu9KSh5qkxW2fstj6CQbgxLbAxYDe+mdpi01TbM83bAE
 MIYvPa4jDgBtSSAWjNBDlpvYcSnlJo9i7woN4eDpvOVEz7extWvQmpFg9bRA2D6/0ObG
 xfqrRkwJZzO4G2KbQhrI/gdU81S8etzk82zJGjSXXEiO9QS1Flxki//dP/vmUb4aOUzG
 qZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775743942; x=1776348742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2z42WOuLOI7rDV2kLC4AvaPFIpQG3uUaTwCXq5nxfs=;
 b=PEJdEVhupYRq3ED6uZvkpxdTGhlUU4BoBdJdsVFqep2dzEbWpzrprE0GmSwQE2h+i0
 5rBMp0KfuFNfxy9ReGpib3wrmy7JeYc8duWybUFzsRGGRITAAzMEjFrpdAxgufqQhLlf
 V51uK3hcoX0Snl5svgZhHeiAvc3C/6aEULbujyzT2Ul4EzppK2V49QWE1sb1vytPjMUe
 fcp9SE1Ml24rG91gO5JjHK8QlAyoPFlYrmfE6zgnhH/hOGTMmwlIBIt0ROQwW4UaDGsd
 mDec6fAWsfKUNDsROrC0rnG1cg8KJ02FRaLAwtXLAqgyeBPC+NIAHIY5aFE79hteMkfB
 Iq1w==
X-Gm-Message-State: AOJu0YwiMsIwpsO8AIdeURDvgW4kT2uLMB0VuLrJ3JD8lZ8q/j71/2fx
 82IsV69hdt+X3nP7f3LK+08AMFeJU532s8YqYrxl2W7KUNuIpdCIMyyvf4F9boJxr1QNI9Wu/3z
 E2KT/iTgOX0zeo5XpQ5HQbeb6zXg23pXhNsl5i8mV9Q==
X-Gm-Gg: AeBDiesH9ZhwOQFoNcV8c3rjGi/YMnxnk631mMuXf5oaBpft6RGf5oeGcdJJbWJ9rIT
 9l8BSmF83Fr8TWMHK8sw2TMEUR6WYTrUa4JPJGhei/GEfcfJNwd7SOXvUmOpdRtZ+RmqqnW1d65
 BR+4htz2/6ymMik8+veAchtdP88l7jzq8ioMxMbm5IAZHRcPsThWoqxPl/CsreE6KpVGipIr1bv
 PoOs2WUTDwzPJCWbtAQy5tBxmW1+aVpmt4ZvnePVbH1wIE4pFuYzOLDbtW2FiE8JvGfw9scZKVr
 K9Ytb2LTC/ypPSKkRh64jxQo1b9X2+W21kwufE24g45mmFiIO4+8efOWzxuc6qvkDrA=
X-Received: by 2002:a53:b009:0:b0:650:1aa5:8581 with SMTP id
 956f58d0204a3-65048828bc3mr20315481d50.37.1775743941660; Thu, 09 Apr 2026
 07:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260409103310.1884968-1-pbonzini@redhat.com>
In-Reply-To: <20260409103310.1884968-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 15:12:09 +0100
X-Gm-Features: AQROBzC7ajkHGKmjCdVDCczUslK2In9z_3_olhOIQ31QPsbgGGrPJdq7BbeC_bw
Message-ID: <CAFEAcA9oGac5aF6q68_wRw_pWeNrgQMfesPGCEaKWuvZhOwBzg@mail.gmail.com>
Subject: Re: [PULL 0/1] virtio-scsi patch for QEMU 1.10-rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 9 Apr 2026 at 11:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:
>
>   Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6c0f11de6118a870e6dd5e1928586885e4363ae7:
>
>   virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare (2026-04-09 12:29:49 +0200)
>
> ----------------------------------------------------------------
> * virtio-scsi: fix cdb_size issue
>
> ----------------------------------------------------------------
> Paolo Bonzini (1):
>       virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare



Applied, thanks (the 7997130293 version with the CVE tag in the commit message).

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


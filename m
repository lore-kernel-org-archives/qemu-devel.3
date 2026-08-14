Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BB0C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuk3s-0005VA-P4; Fri, 14 Aug 2026 01:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuk3n-0005Tj-LX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:02:28 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuk3l-000731-VU
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:02:27 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80bb41f7f3cso5636987b3.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 22:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786683743; cv=none;
 d=google.com; s=arc-20260327;
 b=l3vqiVvAgiGxQEn3/+99RjG/zNDSFr1pqZgT7M0UmvJ57zZfqPPoL1d0jIoiuI3AaA
 3mNjZuj1jpaLmQLSRveETd8OVr2Q6OekIS5VA5vjC9fyIi3rRGc31FK65WhI+Nhfmpyz
 /46E/AJ5GFOz/5XsCeUVuT09btXc+czUY7eyNXAoru68xOe+NURsZ8uNMPzIpWrRC0kU
 Y0rPePnotCPa+TUfw1UuXpUlmXZl0SBP27xvEwDHWXDiPS5fWl9zNy9jdrapk4OHystf
 pLOSfQKjFXM5Ccl/pj0n7K7OTy3NsfCTH5sYFyDPIXrMCSBvSpQPiWxQDnMHqOO21o48
 epLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dNgofWQnLPkFtMt3ZXR0GlQHKpzwk0/r/K0KUvcZom0=;
 fh=hfWgyKtApfcVzP8A6JVezReLN8nzYooFbZFDD8TUi0c=;
 b=j+mejd8qGUe4tCfcKknDyq0/MsKglnFQqNNUAEE2iDyk+hMqqvZP9o3mkbwVEVa67B
 IBKc2okg4+XPeLbseTak4SVv38RTxVPdCSPim2e0pMs01WY5n65daEjq18yz9k9YMudg
 H4MWIqoJuZMhTz1qN0S7EsE17mAvGJOKWWHaxt0EKLYIaSd6Cjp/NYbLPJYwXr2o+C+o
 x0iW2qkPOJAJaSXu0RcCSqkhcI+bgVbXtnD/v2m72S2r63Kr0+J1XyHDcLlEseGWU/oV
 sg9lW+BYQVyHLAc6TiRZSOZ2mMrELW5j9lrzqtHS/b3LQU8vNaxgHHOOn6GbaCVIpgmj
 ImnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786683743; x=1787288543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dNgofWQnLPkFtMt3ZXR0GlQHKpzwk0/r/K0KUvcZom0=;
 b=rm3OJlbVIjxbJm4mYgbmPyEO1AocAO2Zehq/RgoQH7WOqTUiiLgEA9AELiG6W03m/r
 DDUjVLEuDeLTXH8ahPZTm/eDKPlhKpnG2G2awRVD1xr0dDrWqOLXX9wbzmybwmlu/L0g
 bW4lkZuVPqaNo7br4PPUCakUxBjeskh2POSPT4z19+GFOBupixRnACqsvsMyJlveERHY
 1pbD5SG2g3nrEL9jmdKwrxfUvm/0cV4YWoT70KZP4CAbGxyOKJnOHUCRzIQfK9K/+6p3
 4iAaEl8dTJpo18Yk9rbDjHkfV/2Q9W398ttwFoRNqa8ZTf306C2cdd1Z1t2orBYABoGr
 HRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683743; x=1787288543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNgofWQnLPkFtMt3ZXR0GlQHKpzwk0/r/K0KUvcZom0=;
 b=bIzt/WtdajDMGDfToPLX4xuZvi2N/pn1v0hq532Xe6YayuQWZVXNa/gNbiaavN79o7
 e0cPVZA75M6gzy9sXV5Q+rQAAHKpo0oQyAZp9upOGLxh78lScJDRrZOwXUPgznjprgML
 ul2laftiKswV//aLo9rSurcNfy65XHnfUB/YzFRnEU+X2SLNNlqeaSzCFzjizR0mQHOm
 NLKpbDBd/a/+oRw0igmCWjTG9TrOR1xtcdQA7FJt1l7fyFsa6Yo6JNkYo6QcSc8vB3Wz
 3Z8zRIovcJXsAoXFA3wcrvnkr38XC0KcL43utQuDFvta3wLbfofXpkGuSaAGobJGHfdm
 cYxw==
X-Gm-Message-State: AOJu0Yw8UursHNiEz9+ECy+P5757PvLlA2NuRGBYSq7LvNGMpbkWdyS+
 Hdva9QKjvOvObU8IV9ZphfopD6ibDN8Kra2dl08anrLNgpEB9W0vQNXvhHCIWQwf+a71/sX6/7H
 pn7tkSE2yGY6UR3bLGL6m+l/W9tyES314W4EPdnbJ4w==
X-Gm-Gg: AR+sD10sYFm8qUCm1BE6i8WP0D0AI3yNzvZ+qHk12HBLu0G1B0YGYfRIVxjcl57XJVq
 Sds/F3YA5D2DHnMUisMdIsB5ZNJeU5Bo9Z0QNyjQqYea+Nxu0iJWtxvNGyPnF9H8d/QuGh5T41W
 9lQtvZ70o0SH9QkCZU6iUf4REdLpUrnpjYLm4djDuTQuVlVAYeOCLrhy9J4Nfs3la/hFQ0Jv5Hx
 aIR68+dP1KA9cr+RJ72KqOqXcI83akheQf86x8H4vXS8LqfR331XMonwzDCcF92T7s1d1WpdLDr
 qAOOvvXV/9b/Ci7qbPRYGRsDOxJOknICxPwdgtR9Nv2WDfKdSW5iBw==
X-Received: by 2002:a05:690c:e68d:10b0:80c:ebd4:762 with SMTP id
 00721157ae682-8370ce2c2femr9822057b3.7.1786683743651; Thu, 13 Aug 2026
 22:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
In-Reply-To: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 14 Aug 2026 13:02:09 +0800
X-Gm-Features: AUfX_myBIojZkn2bltD2j2WChdyNcL_vfYBIdsklq8O1tGfhj9-ZGUGaxOv7uIo
Message-ID: <CAAW0U4azckLqyWEy=bGRH3Js8AOeW=rpN2+rgkhVStzC0Jv5mA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/riscv: Add K230 DWC SSI Standard PIO support
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kangjie Huang <flamboyant.h.01@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=889=
=E6=97=A5=E5=91=A8=E6=97=A5 02:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Testing:
>
> * Built qemu-system-riscv64 and the K230 DWC SSI qtest target.
> * Ran all 14 K230 DWC SSI qtests, including Standard PIO modes, register
>   contracts, interrupts and PLIC routing, and Standard SPI NOR reads.
> * Standard 1-1-1 transfers were also exercised manually through the K230
>   SDK U-Boot and Linux SPI paths against the attached flash.
> * git diff --check passed.
> * checkpatch.pl reported no code errors; its MAINTAINERS coverage warning=
s
>   are expected because this series does not modify MAINTAINERS.
>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Suggested-by: Chao Liu <chao.liu@processmission.com>
> Suggested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Hi Bin, Chao, and Anirudh,

  Just to clarify, I added the Suggested-by tags in this patch based on the
 concrete suggestions during the v1v2 review. None of the tags was explicit=
ly
 provided by you. Sorry for any confusion this may have caused.

  Thanks again for your suggestions. Looking forward to your reviews!

  Best regards,
  Kangjie


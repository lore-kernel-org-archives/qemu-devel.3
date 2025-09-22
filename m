Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F5FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0grC-0007GT-68; Mon, 22 Sep 2025 09:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gr9-0007DM-AK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:45:27 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gr5-0000tz-5X
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:45:26 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6352c8b683eso1732620d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758548718; x=1759153518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8sjjumbn4JBIclp1F0hI+lAKAn1WjOH5l5djxjRmZA=;
 b=dhVnfbkSbcG8JjkXvkQtGvv9cLYD+IpOD6K+H9b8yiffFzBlibohdULZqH+wVYKlvZ
 6+9h40xsH/EQ2fd7JYsmXuJkfM+3kmj3GOR+oBFUMDr6QAK3uSUsiZ7xR872z7CsqHg/
 3A81GnJ3RGMRc1FXL8MwVKr8JdRDbTCuN1th+pCU8/BnlY8gH2tf8FMNVCCazFrJYMou
 BHKWHSGfZbXLPA6b82k8V47hsW7m9Eoca0AvfeHhukJukDJVCJqducTI3mnZ7c1ilhyV
 bcVs1qUOjchS4UAhYsIadEsrJxaEOz69vdqw2A3XaPS4HATdbG1v9CLvAs71SY2cwPuQ
 JLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758548718; x=1759153518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8sjjumbn4JBIclp1F0hI+lAKAn1WjOH5l5djxjRmZA=;
 b=K50W+fypL+MLvkPoqFWjzX6ZLs8nOpd6bFSCHiXaS0iNkNXCNO7DKeremPBQ6YHdhL
 rIwwQ0GRnNN30k1vCc3hMAV9O7RQujmZJILP+f4vCYZ+x1ywA/n64K5mInl1bz34nntW
 lT5Wcm8eLVtjxAbijL0Ntu/Q2WD3PUsQdyK0fkD++wj2WHZlXQC2IWSfO7bEUmKOvSX8
 PxRbQOhnFlDFxh+JDfbSKBhUmju7WZtQ9dzUMN6RJ0biZvO17IOxoFJobBlkXOnFZoHc
 i0NGb4S0pMbIuI8TmfdXUOoQfxmPv9VwsFo1HjpjXQRJN7sAMCCXDkoYt/HzuDwDDkec
 KQzQ==
X-Gm-Message-State: AOJu0Yya9ukBJgNuFIB/zzUbyk/MFsHDUROFBBFGCpXEpN+50dvxpRyZ
 Zof/krrXicr3WhdVm2EKUAtbVEcpcFNsaUCCwzpxqQ9JZrzPbdY8pBcUv2a7eJfJjQ9cuFaouxH
 xNQB9Nd7J86/AdJbrMzNhIfMql62hp4bUs/dz/ddiWw==
X-Gm-Gg: ASbGnctaguxbW2VaAeg3uV8DWStwoLPWBppMxmemAGJgZjA3j8rvYfaMHBt3E92FUT5
 UuVuUVeWnzOLJTlk4rrbvZmRJ2Ol4ZWw0Kw1Bpx9wzLqfVpA9sZEKIM4NeJYCHlJkHErsBbCmlT
 KW75Fl1RtFzGig6NtfTvY4kEjpckSAhRtZlgBphdCW/Ovn/0QXFqwNX45FliyGgJQ9ErRueM6xR
 jNDT2gl
X-Google-Smtp-Source: AGHT+IH26FMcUs6hEUBPdKjcdcczzX4rU7GplcMb+9VPZTNC8BelfgwoubWy11mn6tUGppR3MsTSWOjLIWGLiO7RkPw=
X-Received: by 2002:a53:ac8d:0:b0:635:2ba3:c264 with SMTP id
 956f58d0204a3-6352ba3c3bemr8676387d50.19.1758548717863; Mon, 22 Sep 2025
 06:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-15-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-15-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 14:45:06 +0100
X-Gm-Features: AS18NWAytbopHV_sqAbRooQHLq7rtMpwhmMsEf6VOoQUF9G2rLDlCGubkELpJiM
Message-ID: <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
Subject: Re: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, 
 Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Weil <sw@weilnetz.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Bandan Das <bsd@redhat.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 19 Sept 2025 at 12:55, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Every caller already support errp, let's go further.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Coverity reports a bug in this change (CID 1630444):


> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index a9e8c5e0d7..89e9cb849c 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
>          }
>      }
>
> -    qemu_chr_open_fd(chr, in, out);
> +    if (!qemu_chr_open_fd(chr, in, out, errp)) {
> +        qemu_close(out);
> +        qemu_close(in);

Here 'in' can be -1 (if there is only an output file
and no separate input file specified), so we can
try to close(-1). Suggested fix:

         if (in >=3D 0) {
             qemu_close(in);
         }

> +        return;
> +    }
>  #endif
>  }

-- PMM


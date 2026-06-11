Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96FACD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdt3-0005Az-O3; Thu, 11 Jun 2026 07:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXdt1-0005Ac-LF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:47:51 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXdt0-0005WL-5q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:47:51 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso3646231eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781178468; cv=none;
 d=google.com; s=arc-20240605;
 b=AuY6tM497Y2PEi6UCuMWdAozwaaMVsaDXY54NMKWCs5WHPN7WmMQLTbVUAA7u+8fUo
 0EGyXMFmztKw5NT7Nr/u0JcB6+DI8RFC0sQyyGCdjEnxJD7VLOSiMV+kKq7+6bXUu9Kt
 Vciv6DEONyT26eXiRj68LUKnymGsN3mqKVd9eReKKSm6jPEGQE7aF+q2IhQoGv4A4v/+
 nCAeDphN2E0AUjVCFMgXb2KhGW5oUZe47rZCZgJ5aQ/B9nenhmlJKaYU9Dp5wMBoNhSg
 CfyHuTuE987MdScyAoMx2L8clvn7X4dSizVdl6bWIM/Mh2VSy2nOIoZOq5DhT5MeFC+/
 y2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1jAZK5SwB7E4BWIl6CEflk7RSK48WyCigyVzo6e6V/k=;
 fh=3XcdnKPPujWCgsoSlfyTIC7mLtr3DNVpLRjg7tPS1Nk=;
 b=ZLEbl2BpQJAc82EC3/jp7QzsXBhVyxUARmsRB5gkHc58ZCfatWFCKspKVb6zAK2Pjo
 kb8XLtbZi7q0pi/50yy9/5gWRZVUg9329LEu1fJWPs3M0OVDKatdF+/9KUCztg56WzCs
 o2ZHtulb14A+8U7okAlV2fkMd3gtto2yjHyxjOrulV0i5ZblzMJJ27yXta/tgex8ldqW
 pSQGU9ciai1jpieIql9zBQTzg6kB2LpEei35MNYFnX+RkLapAyHGhGoCD06wRZ2+Dg3z
 9fGA9NXnZuuXDKFwCjN/0GE0+C3XCMLM4f4opP5SK5yQwUeQ1maWGGZjwuEJhR+DXbxz
 ohoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781178468; x=1781783268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jAZK5SwB7E4BWIl6CEflk7RSK48WyCigyVzo6e6V/k=;
 b=a0C0HdIWPAvQxXfpTUDVRuWxVw3gtXe5ZVzf0xqaPDnho8cHLAsDIoLkTkQLcGubB4
 22rjCAm9EOdf6WMS7BA+FFVt7EPblhM1IC5mjx2W8LA+JT1jhocTy7yr2F1whAq8RzGq
 1bbgf4ZNvSLrmMGQcYX9ZrLHbMGTjxBklrIp48FDeTR/HKjbqzyiqowERU4qWml55UrS
 2TE36EMDIBiH/mfNZWbRThFHkIb5NAJmJpRHAB+8Q98+WsLpS0i7tZXglWF1CEWQSvG9
 8hyRZ9U6TdPMHIjXeXTmuHjgoL1gAiHOdShIUZGdjAs7C8XhmOCQZr8xmAHIOebyr4cF
 WKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781178468; x=1781783268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1jAZK5SwB7E4BWIl6CEflk7RSK48WyCigyVzo6e6V/k=;
 b=NLRFzBXLu3o+pymAMwQ/hEWmCUww+BkgVMEc5dxQjqVHw7u5ccUX8at3lgYE6ZLAeX
 FqzhUMmfBV9YQSxlHq122cSf+M/5QyKarw1HPuHR2mxTY4eIP8e7JzrTgTbd652EI+r+
 fKynABhbq4xTdgDP0M8xHmvNNZlz4n726Sh8Wkc03llAgG978RtJFV6sTPlVBj2rARis
 U/HU4wF9g9dDfE15z+utXrdSHfQ3ujtIpMU4DybDTya8G9yl5BrA9p1tz4vB0PYMX664
 stA4lSyNEHVwJxVMS7ydnpIqHUoPjewQGGDdWddx0AfF8VXkR86R9i8sxtnz30/KlAB4
 UfOg==
X-Gm-Message-State: AOJu0YwOFKxx6yWImnkVBoEHIPCpAiENDDaU5QNmdEKYREFJjwaRUaMC
 18J519D7L22OIvD56HLuPx9xtf7H/u4XfB4jGCsLZhTuur0SvASw3l4oTQglEM8gbamRWT5we7R
 o+jIgUEeKg8WHNMpYavjTrDJ9dy/RT4s1uyNU9uA=
X-Gm-Gg: Acq92OGDF4e8vGQz6xASVEGYq+hXSlh45kwLjbhO7ZuKNzdlhOyckpLBJMTJx4eP+zR
 9yyOJi2s41Dx0sIOZ7p6xZMA2lr8NU5GGzfP+X7YDt+HGXEAsrgDZpSrZmqd0C4J/S9gBes5TOM
 9YOC9gYwWBaViKEZCIkxvsaJBLgBaga4VR3QX3DoSepjsZQ4CHQxTiGaXp6fJdwzENd7B4DPt6d
 IhQe9sbCprTbqcnPZzo4LDT/LOMGvbZegyGONMocql2Y32ziD2ePRU/1NR1XUNJ5LFCG8B/bO3J
 D19vrXHeA6AlpDryg7KfIKsKX07oWUB4YzeetV1T1+5a8DL/6A==
X-Received: by 2002:a05:7300:8606:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-3080478daefmr2088013eec.14.1781178468447; Thu, 11 Jun 2026
 04:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260611114212.27472-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260611114212.27472-1-philmd@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 15:47:36 +0400
X-Gm-Features: AVVi8Cf3kDX3vOix7rVFvqN3FHY4mYqZ-DTZ0QKmQgsiBrwqCSeJLhEiGrIKYDM
Message-ID: <CAJ+F1CKAjy9QQ6rq5z4AN5VmgNevFpOq9-4-eSWS2AW6N4sY6A@mail.gmail.com>
Subject: Re: [PATCH 0/2] ui/input: Constify qemu_input_is_absolute()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 11, 2026 at 3:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Notes while reviewing Marc-Andr=C3=A9's "ui: retire input-legacy.c" serie=
s
> (20260610-ui-input-v2-0-f68452dd6a22@redhat.com).
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   tools/qemu-vnc: Have console_get_mouse/keyboard take const QemuConsole
>   ui/input: Have qemu_input_is_absolute() take a const QemuConsole
>

thanks

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  include/ui/input.h        | 2 +-
>  tools/qemu-vnc/qemu-vnc.h | 4 ++--
>  tools/qemu-vnc/display.c  | 4 ++--
>  tools/qemu-vnc/input.c    | 2 +-
>  ui/input.c                | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> --
> 2.53.0
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E2D2E9DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASti-0003fm-CJ; Mon, 11 Nov 2024 06:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAStf-0003fD-Tg
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tASte-0005S7-1P
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731325672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjoCHtfDtLkhSHAu4AL0luQA8p5g3727P5DR6sg//CY=;
 b=aKaI1s0AJUAyKmpLRnx1IWWCpKEValb88jwf5vG7uAA5Y0J5O71et3lvgGRL7M8tLV435v
 8ovTLQu6b78uEa8KdWkoD2zwFBMle4MpTdPhvbq7Y69PS66PtAOrdkVW8iqddnkLCSu8gp
 aeP3mtjNn4rB/ah/WC1cWgh5PE2aqMc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-DmfTcvKxOum6411LIIPveQ-1; Mon, 11 Nov 2024 06:47:49 -0500
X-MC-Unique: DmfTcvKxOum6411LIIPveQ-1
X-Mimecast-MFC-AGG-ID: DmfTcvKxOum6411LIIPveQ
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539e13b8143so4671098e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731325668; x=1731930468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjoCHtfDtLkhSHAu4AL0luQA8p5g3727P5DR6sg//CY=;
 b=rbya8MS0EzIfKOjoY1QF9IjHzFzGFVUEOupBHGCYIMS1jlwcq+R/+rsL5az7Wst4bG
 drQuUbcEL19VDCAgVDKahIDmGQ1FZIjuwYJ7Z7CrsIfhBCDdMTYsQ9XOrNFpLvLCgIA/
 ga8ZDYzQKDv3ZmT6C4acM2dX+4MeJypVXro+6x7sOP2OQ5ni0H6rned7EyHdeHNXt46X
 8DALxYk+64Hyzr8abD7A0/fw0gdC8IUZvrbwqtZyOPyqe6ke19lRQY65/VUwI/XH4lic
 qSEBz7Urx/WOlv91RlbMDc9ZP/Ri5is8nazIqRuS83LeuXUpRQDliknmd0vWvZGwFbnx
 FEDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZFssYSxHK83kFIOjAuWseN298BM/hlnKBv7nZhApEOjZ20AvO/9s57W/ZrllTWg9Gss1ubhhVdhts@nongnu.org
X-Gm-Message-State: AOJu0Yx7yRMRreRIPfyA+tWFAJ0gqygbbtucimEZe9XGpqbjyabPcrae
 ENox9KOIKYjqgOwxe/zc9C+pEB0H77xnj+9m3z9aIT0q/Y/WHzcoKMvkDUSjNmVQYxdfImB3m96
 9LCOOJxWbcPMfUhE57uzm9nPYy4vkHwnutx0hLYqzS35AJVzRlChCafXWwC/3nTcKHtERZ8qG8T
 RSl+8atl4L+kr3cnk1iy98vtgyKXM=
X-Received: by 2002:a05:6512:3d1d:b0:539:fc45:a292 with SMTP id
 2adb3069b0e04-53d8626c94amr5166064e87.43.1731325668191; 
 Mon, 11 Nov 2024 03:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6/q2rCE/R+yV4AS6HmPPFpN7C2xnZ28ohCQKM6PSMAg+jqKNSyHuL0+t8pmJI/9PPd21dKffX02Hi91ULU80=
X-Received: by 2002:a05:6512:3d1d:b0:539:fc45:a292 with SMTP id
 2adb3069b0e04-53d8626c94amr5166053e87.43.1731325667830; Mon, 11 Nov 2024
 03:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20241111090534.66439-2-frolov@swemel.ru>
In-Reply-To: <20241111090534.66439-2-frolov@swemel.ru>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 11 Nov 2024 17:17:31 +0530
Message-ID: <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: fix heap-use-after-free
To: Dmitry Frolov <frolov@swemel.ru>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 11 Nov 2024 at 14:37, Dmitry Frolov <frolov@swemel.ru> wrote:
> "int main(int argc, char **argv, char** envp)" is non-standart
> Microsoft`s extention of the C language and it`s not portable.
> In my particular case (Debian 13, clang-16) this raises wild-pointer
> dereference with ASAN message "heap-use-after-free".
...
>          qos_printf("ENVIRONMENT VARIABLES: {\n");
> -        for (char **env = envp; *env != 0; env++) {
> +        for (char **env = environ; *env != 0; env++) {
>              qos_printf("\t%s\n", *env);
>          }

* For heap-use-after-free, there needs to be a free(*env) call
somewhere. In the 'tests/qtest/qos-test.c' file, I couldn't see
environment variables being free'd anywhere. Above loop is only
printing them. Following small test.c did not reproduce the
'heap-use-after-free' error.
===
#include <stdio.h>
int
main(int argc, char *argv[], char **envp)
{
    int n = 0;
    for (char **p = envp; *p != 0; p++) {
        printf("environ[%d]: %s\n", n++, *p);
    }
    return 0;
}
$ cc -xc -o test test.c -lasan
===

* While the patch is okay, it is not clear why it fixes the
wild-pointer dereference and "heap-use-after-free" errors.

Thank you.
---
  - Prasad



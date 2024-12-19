Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A00AE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4XW-00046U-18; Wed, 18 Dec 2024 19:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4XU-00045z-9k; Wed, 18 Dec 2024 19:37:16 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4XS-0000uK-C3; Wed, 18 Dec 2024 19:37:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-218c80a97caso2367125ad.0; 
 Wed, 18 Dec 2024 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734568632; x=1735173432; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKGUY1foE0cUbFr4KsvnEUBIae89hqc0R2DUH8OuzwI=;
 b=FF6tEYx1TkFHD4OFy9+SRkwQmJNwu24uTwzPBneuNOwEP+ED9Kfa6tsVvprywmRCND
 egs6u+4xXOc9IWomniCPAjPO1PlC7lyN/cqriZR5PjYgXwIDPWLLtucAQO/SUvT5qer4
 3dpBbAx+2erKbbJ53LCMSAOy8Pmu3Ao1VdWzoKbZgxAhX4HlAg7IbfDLDfvCfO8HqaJ3
 8G8Z6iB1xbSXUk10mrFwnudGFYyCQnZ/Hmg7YnQMlWTAm9yWtdJ0nejqRnDvw5cR+c5F
 b6uJw4MoWB8hnq7yiLhRTHpzr0ySjR1Y47nwC6lOzC+wr8MOpW56SAkkajZeVx2aawJR
 d2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734568632; x=1735173432;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mKGUY1foE0cUbFr4KsvnEUBIae89hqc0R2DUH8OuzwI=;
 b=KAbDTGS0znSZmX13MbcRiOlYTtE+XO9bWvF/iFtns2S0SowzHm7goAAhkxLcYtI16c
 2fCoFF02DOuYVyqXN9f2mNAyYC+5cZMzBKSXe1xDTrYtZ1sUOEmy4mfTTdvFR5GuHpuB
 sfk45Dx0nJ4WXdkqYb6H061kAXRaVYtrBk+4bOif4EBi4Mlq5z98C4O5ZZbJwpAf8SVj
 H176sUhTsfNgaK4VI6UrEW6dP3JSoNZfgG9+MhVg1plcKkt8fwYN9s8a5ow/2nL6q16+
 eUKwG0YNs0Dg3eeLp4i2Io9XMv/rZEaugyS4ndmvHTWJ345qNnWyF3VZuR3bHU6FJNbL
 tuDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzPZRcsCRKJ3H3XdtCeYzXAYprMpoMt4NZNHHAN70dU/MWeOCSsdUd+OcbokwC2D5TOSgWPpeaO021@nongnu.org,
 AJvYcCWpOioTex73IpHrCLNkvJoU1dgX+WXEHX+JpxyQzrJ/lT1IYYzZQyyux9AtrJTpF0LZsBIgWVG0KII=@nongnu.org
X-Gm-Message-State: AOJu0YyQJgHUkgEpyPLZKs7ZnmsOHc3BGuhIyU7KZOdgQb1rTHujJDKi
 0SSPwzmbalZenvbd8dPG25EM6yOqRzFBCHiDbleApSxGVG5Alf5H
X-Gm-Gg: ASbGnct+dImoSQDkMeXgpdzvLp88GDsMxEujKYm7vcoJykGeuP9OA1MP2xzH0W/AA9r
 wHi/xHn9/49CgQObY7KEbrqcf8pqIRiZ+atcvuxLg2ECAmpPM4OXeaKhLUBq9lI+huOqI3U36gQ
 eq6FOsUbEdQaZWS27Pson89zzuXnd3jbpEkiggqQVF0BGRcaF4oxgKq0g0DATA5Aive5xcktt2i
 RY4SFjcGqq/YFbdu5zWb+zeHlKU6656y7RiF4mNF10VPWFqV7r+OfXZPfO43xqJ/ATBjc9psak=
X-Google-Smtp-Source: AGHT+IHC0vXgNl1YJzZQ9CnlwH/LT09uMq6DQQkV0I3Z95E4W5GlqZa8YUPobzxEVbMdeO+0RXYVig==
X-Received: by 2002:a17:902:ecc7:b0:215:7421:27c with SMTP id
 d9443c01a7336-218d7216702mr67364925ad.29.1734568632231; 
 Wed, 18 Dec 2024 16:37:12 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d462asm1239445ad.127.2024.12.18.16.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:37:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:37:05 +1000
Message-Id: <D6F99DW9FQ1Y.268COFM41BN5X@gmail.com>
Subject: Re: [PATCH v3 1/7] meson: Run some compiler checks using
 -Wno-unused-value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-2-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-2-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Thu Dec 19, 2024 at 4:21 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> When running Clang static analyzer on macOS I'm getting:
>
>   include/qemu/osdep.h:634:8: error: redefinition of 'iovec'
>     634 | struct iovec {
>         |        ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_ty=
pes/_iovec_t.h:31:8: note: previous definition is here
>      31 | struct iovec {
>         |        ^
>   1 error generated.
>
> Looking at meson-logs.txt, the analyzer enables -Wunused-value
> making meson generated code to fail:
>
>     Code:
>     #include <sys/uio.h>
>             void bar(void) {
>                 sizeof(struct iovec);
>             }
>     -----------
>     stderr:
>     meson-private/tmpe8_1b_00/testfile.c:3:13: error: expression result u=
nused [-Werror,-Wunused-value]
>         3 |             sizeof(struct iovec);
>           |             ^~~~~~~~~~~~~~~~~~~~
>     1 error generated.
>     -----------
>     Checking for type "struct iovec" : NO
>
>     Code:
>     #include <utmpx.h>
>             void bar(void) {
>                 sizeof(struct utmpx);
>             }
>     -----------
>     stderr:
>     meson-private/tmp3n0u490p/testfile.c:3:13: error: expression result u=
nused [-Werror,-Wunused-value]
>         3 |             sizeof(struct utmpx);
>           |             ^~~~~~~~~~~~~~~~~~~~
>     1 error generated.
>     -----------
>     Checking for type "struct utmpx" : NO
>
>     Code:
>
>             #include <getopt.h>
>             int main(void) {
>                 /* If it's not defined as a macro, try to use as a symbol=
 */
>                 #ifndef optreset
>                     optreset;
>                 #endif
>                 return 0;
>             }
>     -----------
>     stderr:
>     meson-private/tmp1rzob_os/testfile.c:6:17: error: expression result u=
nused [-Werror,-Wunused-value]
>         6 |                 optreset;
>           |                 ^~~~~~~~
>     1 error generated.
>     -----------
>     Header "getopt.h" has symbol "optreset" : NO
>
>     Code:
>
>             #include <vmnet/vmnet.h>
>             int main(void) {
>                 /* If it's not defined as a macro, try to use as a symbol=
 */
>                 #ifndef VMNET_BRIDGED_MODE
>                     VMNET_BRIDGED_MODE;
>                 #endif
>                 return 0;
>             }
>     -----------
>     stderr:
>     meson-private/tmpl9jgsxpt/testfile.c:6:17: error: expression result u=
nused [-Werror,-Wunused-value]
>         6 |                 VMNET_BRIDGED_MODE;
>           |                 ^~~~~~~~~~~~~~~~~~
>     1 error generated.
>     -----------
>     Header "vmnet/vmnet.h" has symbol "VMNET_BRIDGED_MODE" with dependenc=
y appleframeworks: NO
>     ../meson.build:1174: WARNING: vmnet.framework API is outdated, disabl=
ing
>
> Fix by explicitly disabling -Wunused-value from these meson checks.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: Probably meson should do that in has_header_symbol() / has_type()?

I don't know about the build system to answer this, but should we
instead disable -Werror on these tests to be a bit more future-proof?
Compilers often add new warnings or catch more cases of existing
warnings.

Alternative would be to keep -Werror but fail the build if a test
throws a warning, but that seems like a lot more work for little
benefit...

Thanks,
Nick

> ---
>  meson.build | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 85f74854735..9d93dcd95d7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1189,7 +1189,8 @@ cocoa =3D dependency('appleframeworks',
>  vmnet =3D dependency('appleframeworks', modules: 'vmnet', required: get_=
option('vmnet'))
>  if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
>                                                'VMNET_BRIDGED_MODE',
> -                                              dependencies: vmnet)
> +                                              dependencies: vmnet,
> +                                              args: '-Wno-unused-value')
>    vmnet =3D not_found
>    if get_option('vmnet').enabled()
>      error('vmnet.framework API is outdated')
> @@ -2713,7 +2714,7 @@ config_host_data.set('CONFIG_RTNETLINK',
>  config_host_data.set('CONFIG_SYSMACROS',
>                       cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
>  config_host_data.set('HAVE_OPTRESET',
> -                     cc.has_header_symbol('getopt.h', 'optreset'))
> +                     cc.has_header_symbol('getopt.h', 'optreset', args: =
'-Wno-unused-value'))
>  config_host_data.set('HAVE_IPPROTO_MPTCP',
>                       cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP=
'))
> =20
> @@ -2731,10 +2732,12 @@ config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY'=
,
>  # has_type
>  config_host_data.set('CONFIG_IOVEC',
>                       cc.has_type('struct iovec',
> -                                 prefix: '#include <sys/uio.h>'))
> +                                 prefix: '#include <sys/uio.h>',
> +                                 args: '-Wno-unused-value'))
>  config_host_data.set('HAVE_UTMPX',
>                       cc.has_type('struct utmpx',
> -                                 prefix: '#include <utmpx.h>'))
> +                                 prefix: '#include <utmpx.h>',
> +                                 args: '-Wno-unused-value'))
> =20
>  config_host_data.set('CONFIG_EVENTFD', cc.links('''
>    #include <sys/eventfd.h>



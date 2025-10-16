Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7120CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9O4i-00080e-CQ; Thu, 16 Oct 2025 09:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9O4a-0007tn-12
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:31:17 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9O4P-00022X-7u
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:31:13 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-78142734156so9942017b3.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760621459; x=1761226259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SO1iDXAk7EUhTggSDOqi1/t5IggvdLbMVa0XYaZ2ZH4=;
 b=YG7LG0CU8zCaKsV1oqsYgwsKbwkejgLBlbsILQhI1+3S8poMpGYt1DblDaJeBfHT1A
 tA0EEeMHGRa/D1EUo5smPME3npGJnm4+3isTEmSzBkB1cvvSlwdiFLoIjr3sPXLrC+3o
 qVKtQ5Y69hH4auLYdo9V0xWHK9yspUlQWtDWwLk8dtdMWtzZgDdhOkMrWeDF4b4M+XQp
 1GLQD76yehGPwz0wtu1nYoFSL4Xix8rMw5wTXJ30+XHQgB6Y488GcDF3UiT0CIYaAEwT
 HJP9psAqpx9wQxPmGAcyNKRIctA7p7di1fkbYVU1JP3+TrhIYyNLZ5qGMqj2gKNdjNKC
 GTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621459; x=1761226259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SO1iDXAk7EUhTggSDOqi1/t5IggvdLbMVa0XYaZ2ZH4=;
 b=IcmmAZxzMSoI0318yT45PbuxWM7WAn9PJAweMqkaFjGFTV/k5CUJ9iV2TUBPz2znA4
 61Pt//o0C9VRt07K35VtMj7Z3QtzFlDSPJTCV12xLUeSdmC0ZVsdZkFrfiyKGDFLoYv2
 BRgLB3FhpP56S1UT09xbHlW3gemyz0P9vXpG/i0NobDmRTo0JN1yIdht7hOwuoTNihh4
 viCocRXat4QnQU50uBruDNPVazyOQyOXKzpsTnrhCSFd1ARkWI0YTRnnodN0qRuPonS4
 eWnoRoF+Kn5kgm+el7BfaY/tjOitEhf4o0kE65pyR8pFTqz7gCOD7Tw/3n3OThXUlqgm
 q5GQ==
X-Gm-Message-State: AOJu0YzJIOfaYj8Dd6C1wq6dUarA4ZfF+G3ZLwCGgx+7YPJMp5S05km9
 5mLLnGzdfAqT+oGwtj+sfc7pyHFzhnNZeK24gZFdv8O7djsZCGaM2CGupuMJaRkMGyuqynuZOi3
 3/IjYqRRCYXCrCO6Q3U+33ZPTCWEKMHWjJBzdThm0yA==
X-Gm-Gg: ASbGncvSW5csneZatyPi7gil4G5379mr+oDjwR9ErigyVgn87q4dqBm9BiS7qQnXff2
 Qx5c3K8fAVWZK//WQNBjlNIKnCxvLjfsTPe/ioaceKPXe92Y5c6wNUCK3v9AYKRmTf2OBXSygdk
 Wnfbs2j/hwJKezyHGAVXxWpOIb953206ZeHD6qvyOgB50O3UBnc3MgZ/dzXWqKBHplA4B3+zpYa
 yOsGwj4TC4sJOCD+CrH2k57CPEsgZ5yQk7h5eujhq5p5x9d0FNzw8cEHAqKSw==
X-Google-Smtp-Source: AGHT+IHTxbyGqIYq96olEQzB0LcnjxM9DkP6BOZCPdUeV2iYaqPHxeDhjBq2BoDklHFBIYkHD03I4mELenlAVPCsNwM=
X-Received: by 2002:a05:690e:150a:b0:63e:109b:d9ed with SMTP id
 956f58d0204a3-63e160e9937mr230148d50.13.1760621459384; Thu, 16 Oct 2025
 06:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251016132548.1654627-1-berrange@redhat.com>
In-Reply-To: <20251016132548.1654627-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 14:30:47 +0100
X-Gm-Features: AS18NWDSX0yufdO_09aesQMdnyQ-hyHrPa_RrRj-00kXvYqStnlPHcf4Nl4Q5Jg
Message-ID: <CAFEAcA8J+ELMCdVBuqTTDg=seO4h4q9LdtXBya421Z3FH6__wg@mail.gmail.com>
Subject: Re: [PATCH] tests: use macros for registering char tests for sockets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 16 Oct 2025 at 14:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The test-char.c has a couple of helper macros for registering tests that
> need to be repeated for both IP and UNIX sockets. One test case was not
> using the macro though.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/unit/test-char.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index f30a39f61f..3c9f0a68e8 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -1969,19 +1969,17 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/reconnect-error/" # name, =
\
>                           &client7 ##name, char_socket_client_test);     =
\
>      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, =
\
> -                         &client8 ##name, char_socket_client_dupid_test)
> +                         &client8 ##name, char_socket_client_dupid_test)=
; \
> +    g_test_add_data_func("/char/socket/server/two-clients/" # name,     =
\
> +                         addr, char_socket_server_two_clients_test)
>
>      if (has_ipv4) {
>          SOCKET_SERVER_TEST(tcp, &tcpaddr);
>          SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> -        g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcp=
addr,
> -                             char_socket_server_two_clients_test);
>      }
>  #ifndef WIN32
>      SOCKET_SERVER_TEST(unix, &unixaddr);
>      SOCKET_CLIENT_TEST(unix, &unixaddr);
> -    g_test_add_data_func("/char/socket/server/two-clients/unix", &unixad=
dr,
> -                         char_socket_server_two_clients_test);
>  #endif

This is a "server" test, but it looks like you've added it to
the SOCKET_CLIENT_TEST macro instead of the SOCKET_SERVER_TEST macro ?

thanks
-- PMM


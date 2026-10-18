Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0758CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 17:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIV17-00019u-Ep; Sun, 18 Oct 2026 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xIV15-00019F-Gd
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 13:49:51 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xIV13-0006Br-Qg
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 13:49:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so2010706a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792345788; x=1792950588; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oMVUjdN95Ah216cN1pN8bb1DsQthi+djBQhpKaH/wHk=;
 b=CcyliHOULuSTemMwSaRk81KsisRxVP4SqTMCK9z//yRb40t/kT6Bk4f1iNxgE3nlC9
 Tl6FVXg6vTtIeb2YxGDa/UYFrUxly0+JcWev+lmOCwUlLATpcHNIFAO4aRAkyO5xFvEZ
 3PSwHUt/c+gEyh3x5eh8UhTWcEguHPelqOkmaUlRTerVQgVDpGiCalkwuhxjDl0sGgK8
 WCBXu5GCfzoYLMJItDY5QCMwC7SNme3U+qiOqL/R49mruOLKDrZG6go70jBXrS2W2NWo
 BNt44t9Rtj8M/VQ41vbhUL5Ua5Dx1Hxj9fAHyJDXKOUL42gMjrxlGhRpV04AVVtYGX+K
 guow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792345788; x=1792950588;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oMVUjdN95Ah216cN1pN8bb1DsQthi+djBQhpKaH/wHk=;
 b=JRFDIggGAG/hdRzNVJX7ilqIRaZcx0M1RTt6lXFCOshbIWES3wLkpmkxEzvSDj3Y9y
 VZGGyCe0IGGOFwAkmL+EbKK1h/HrgoXHX7spc4aU5DAx0PrhHLxt8jlt4PWq1Ff9kGXO
 RvHdf8TEmsFjLupYYQjcOKs4CGozRl/b97sPgIbytCDVisYgjgkX0GP4Aud1JMafeYZb
 I6wD9mQl886EPpklWtIIsiOnJUerCUa9nZaaXLTjNg+tH6APoq1ADipoEpHBJH1fYRZO
 +ASwbeYrKPS0btWEcX9By8/ev5BZ04Jd5BQX5kVI5DfYpnMte4d7tni5xYflkoB4532o
 ZB8Q==
X-Gm-Message-State: AFq9FYINfi4jAquOWTDngK1aDFVIq1sBXltV9poFniRcR4QLswJriPJP
 vs2NxXntP3rgveLXK96/l/biBvp0v25tTK8+smZ/9ZNwlI4qjsnJUzKy
X-Gm-Gg: AYBFou0pv/PZD7bubpgEUFQmpz43xY1jOWaULx0622FuQqUieMdedjKv21sIm4qvDtA
 XzJpHzJj61F6Ffs/LqM5O7SP2NzbmzCx5qd7gGOjAWqyLOfpC5l3PLw93/WXYy3REWISn+Ywbs0
 lwPQJlMPBp+5IJnnue3RzznOlXdsLX5uMMUaC3jpT38qj+yeEoRYtMTlN+6CIRJUv8yxJaWSnOM
 eWVSff5MIQeEfepbkZo3pxl2zssXAq4drTPfT6TVziPw+AkIT79tSJwfp7ScGotKsEhdh/eMGe4
 BUFaLNUd7dL6ee9nk2C/x4Hhn+5fqGxQ/n58309MNZNszygHCT+vO49wP3gQaXdQA1FBDEKhwax
 t4q59v5YaiFeqzS33OrRTEikXXNNVkXhmMBRVO6W1DPuX2hk0Tyioj2J/e0ynRpbe7cHO8/NOr4
 UxeXx9erzqpjpvCmFpUAQY6rUJ/qB8QyMzyxjNrNHIEOV7s/5FC6mBAyzooovadw0vNwwpnxRnx
 WRvGYB1wYBblkY1yq/LRZwwKCG9WRu//YlRbmnZkMijXUV4fD+Q6iMtYCrmcTh88MPu01tM
X-Received: by 2002:a05:6402:4344:b0:6b1:e4a0:4848 with SMTP id
 4fb4d7f45d1cf-6b3a81c2048mr3608480a12.43.1792345787397; 
 Sun, 18 Oct 2026 10:49:47 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b3cbe98563sm542261a12.27.2026.10.18.10.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 10:49:46 -0700 (PDT)
Date: Sun, 18 Oct 2026 19:49:01 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Oleksij Samorukov <samm@net-art.cz>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
Message-ID: <atUGjXcdSBqQWAIx@tulp>
References: <20261017201905.12211-1-samm@net-art.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017201905.12211-1-samm@net-art.cz>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

  Oleksij Samorukov wrote:

> On FreeBSD the virtio-console port is a tty, unlike Linux's
> /dev/virtio-ports which is a character device.  It defaults to canonical
> mode with echo and software flow control enabled, so the QGA stream
> protocol does not work: the initial guest-sync handshake is held in the
> line discipline and the host eventually times out.
> 
> The existing FreeBSD-specific code only clears ECHO.  Configure the port
> the same way as the ISA serial path: disable canonical mode, echo and
> software flow control, and set VMIN/VTIME.  Use TCSANOW instead of
> TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is
> not discarded.
> 
> Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.  Before the change
> utmctl ip-address timed out and the guest received zero bytes; after the
> change QGA commands and guest-set-time work.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de ("qga: Add initial FreeBSD support")
> Signed-off-by: Oleksij Samorukov <samm@net-art.cz>
> ---
>  qga/channel-posix.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 9ccc8b7..c6dfb2d 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -156,9 +156,10 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
>  #endif
>  #ifdef __FreeBSD__
>          /*
> -         * In the default state channel sends echo of every command to a
> -         * client. The client program doesn't expect this and raises an
> -         * error. Suppress echo by resetting ECHO terminal flag.
> +         * FreeBSD's virtio-console port is a tty (unlike Linux's
> +         * /dev/virtio-ports, which is a character device) and defaults to
> +         * canonical mode with echo and software flow control enabled.
> +         * QGA uses a raw stream protocol, so put the port in raw mode.
>           */
>          struct termios tio;
>          if (tcgetattr(fd, &tio) < 0) {
> @@ -166,8 +167,19 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
>              close(fd);
>              return false;
>          }
> -        tio.c_lflag &= ~ECHO;
> -        if (tcsetattr(fd, TCSAFLUSH, &tio) < 0) {
> +        tio.c_iflag &= ~(IGNBRK | BRKINT | IGNPAR | PARMRK | INPCK | ISTRIP |
> +                         INLCR | IGNCR | ICRNL | IXON | IXOFF | IXANY |
> +                         IMAXBEL);
> +        tio.c_oflag = 0;
> +        tio.c_lflag = 0;
> +        tio.c_cflag |= CLOCAL | CREAD;
> +        tio.c_cc[VMIN] = 1;
> +        tio.c_cc[VTIME] = 0;
> +        /*
> +         * Use TCSANOW rather than TCSAFLUSH: the host may already have sent
> +         * the initial handshake between open() and tcsetattr().
> +         */
> +        if (tcsetattr(fd, TCSANOW, &tio) < 0) {
>              error_setg_errno(errp, errno, "error setting channel termios attrs");
>              close(fd);
>              return false;
> -- 
> 2.54.0 (Apple Git-157)
> 

Interestingly, the issue does not apply to libvirt (bhyve and qemu
drivers) talking to the guest agent, likely because libvirt terminates
guest agent commands with '\n'.

Either way, I have tested this change on:

 - FreeBSD 16-CURRENT amd64 guest under libvirt/qemu
 - FreeBSD 14.4 amd64 guest under libvirt/bhyve
 - FreeBSD 15.0 aarch64 guest under libvirt/bhyve

and did not notice any regressions.

Tested-by: Roman Bogorodskiy <bogorodskiy@gmail.com>


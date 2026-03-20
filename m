Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22506109319C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3W3F-0004H2-8f; Fri, 20 Mar 2026 05:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1w3W3E-0004Gs-19
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:21:52 -0400
Received: from mail-4398.protonmail.ch ([185.70.43.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1w3W3A-0005zi-DP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1773998503; x=1774257703;
 bh=9t3VraiifliDfje7GA3oEyQ2QO/BNWRW//D48Ogdl6s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=sPVw0ru6awiwqXrwWlRy/RQY3z7bupHiTwrVdCBnqjsTCx2KZna5Uuhk3WuM2DB4i
 hXjmHNWgT7Q0DR/DHjzgbfcRrQojzX5eZDEtL4BqmhiNU53UyFdcPI7sjThG5khQ+v
 g8AZg8i93f5nNya1aB4vEec0TwXp7uz65bzLLp9FzU75LpTjTKSgUhd70DsJnuqtHQ
 KQsxZ26x2RH+3ZaG9pt2XgQdEpvJlr37wtbnmlRtQaq015CBywv1FYCZl/p4nX0W49
 ZKgKTV9SKK9jM8jY1LeidEt0t30p91yk3cUYUEiki6GrS+ILEuNyivvCE7O/8GWEVX
 rgx8nXJN0iI1Q==
Date: Fri, 20 Mar 2026 09:21:39 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/char: clear dangling GLib event source tag
Message-ID: <yPd8QBKcAflQCNJ4OJD86STH4fWmQnnTfrcuEDYUiG9VwTjUstJ-rMloNB3SoScmpCfPtOCS0mNPlPFJ3nENBNMjIJp3tXJbqizbG3omRfA=@matthewpenney.net>
In-Reply-To: <20260305213308.96441-1-matt@matthewpenney.net>
References: <20260305213308.96441-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 7ffbd63b800dd6a5120a6fa7105eacf4496dfd1e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.98; envelope-from=matt@matthewpenney.net;
 helo=mail-4398.protonmail.ch
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Just a gentle ping regarding the v2 patch I sent a couple of weeks ago.
Patchew: https://patchew.org/QEMU/20260305213308.96441-1-matt@matthewpenney=
.net/

Thanks for your time.

Best regards,
Matthew Penney



Sent with Proton Mail secure email.

On Thursday, 5 March 2026 at 21:33, Matthew Penney <matt@matthewpenney.net>=
 wrote:

> Clear dangling GLib event source tag when virtio-console is
> unrealized. This prevents a stale tag from being used, and
> maintains consistency with the rest of virtio-console.
>=20
> v2:
> Use g_clear_handle_id() per advice from Marc-Andr=C3=A9 Lureau
>=20
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/virtio-console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 25db0f019b..efe7cd6772 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -257,7 +257,7 @@ static void virtconsole_unrealize(DeviceState *dev)
>      VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
> =20
>      if (vcon->watch) {
> -        g_source_remove(vcon->watch);
> +        g_clear_handle_id(&vcon->watch, g_source_remove);
>      }
>  }
> =20
> --=20
> 2.53.0
>=20
> 


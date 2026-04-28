Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB29BFF886C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdlP-0005nu-F7; Tue, 28 Apr 2026 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wHdlM-0005nS-B6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:25:49 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wHdlJ-0001oU-TW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:25:48 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id C0C852F07A;
 Tue, 28 Apr 2026 10:25:39 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id hHmkLup_7MoP; Tue, 28 Apr 2026 10:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1777364738;
 bh=0jcRybkN6G5z/JK+FLZiqhP5P9CmBDxt/1E9pkxbQh0=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=omApbhxxx6dnf8H+X+d6NB25YqeCEeCxF1Pvt4q/C6c9vQHyNhbiM1TjpKEfYZZ7Z
 HdsI6JP6zE2Nwf7ettf55WEFAjL9mPBjS4/dJVR+qAdAsusnQ3z3Z1Y3vNhn6muunM
 Zumcxxzt4ckV+KJVHHNLwxuVdE38naZ2io9VjrYWW8J2O7Ejp++xXkuCTvWYJbGuGN
 iCp7e9j4mHxgORnwDQy1Yz6oQFcHXHg9PTAy11J21ieSjF55dIG6RPl1HGkOEaWxAS
 PlTOwVvCTe97EpsMDzrfwJMe0YfcbbFzhU/ZOUqQ69adkr52NrUA8bQUKDaMD3Uxe0
 xTGO7HD9TeHhA==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id ECFFE2F079;
 Tue, 28 Apr 2026 10:25:37 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "=?utf-8?q?Marc-Andr=C3=A9?= Lureau" <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 23/41] net/can: free ifname on socketcan finalization
Date: Tue, 28 Apr 2026 10:25:36 +0200
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-23-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-23-c413f3605311@redhat.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202604281025.37014.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.387, SPF_HELO_NONE=0.001,
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

Hello Marc-Andr=C3=A9,

thanks for the catch of the missing free

On Monday 27 of April 2026 21:42:22 Marc-Andr=C3=A9 Lureau wrote:
> can_host_socketcan_set_if allocates ifname via g_strdup, but no
> instance_finalize existed to free it.
>
> Fixes: ea15ea8a7c67 ("net/can: support for connecting to Linux host
> SocketCAN interface.") Signed-off-by: Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com>
> ---
>  net/can/can_socketcan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 8a57ae07178..be67ed7f5a9 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -319,11 +319,19 @@ static void can_host_socketcan_class_init(ObjectCla=
ss
> *klass, chc->disconnect =3D can_host_socketcan_disconnect;
>  }
>
> +static void can_host_socketcan_finalize(Object *obj)
> +{
> +    CanHostSocketCAN *c =3D CAN_HOST_SOCKETCAN(obj);
> +
> +    g_free(c->ifname);
> +}
> +
>  static const TypeInfo can_host_socketcan_info =3D {
>      .parent =3D TYPE_CAN_HOST,
>      .name =3D TYPE_CAN_HOST_SOCKETCAN,
>      .instance_size =3D sizeof(CanHostSocketCAN),
>      .instance_init =3D can_host_socketcan_instance_init,
> +    .instance_finalize =3D can_host_socketcan_finalize,
>      .class_init =3D can_host_socketcan_class_init,
>  };

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


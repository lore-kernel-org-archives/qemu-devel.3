Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F8606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UgnBS/2D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3R2-00057r-SU; Sat, 31 Oct 2026 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3Qz-00057F-Kc
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3Qy-0005Bd-2t
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793431403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVn+cNAiCIVXBwyn7mAgQ8OTU1dzPRumeM/0ex9u6/A=;
 b=UgnBS/2D3eiuteU0w6Z+qMTiJaBhD8j/IilPtriP8M3hjbjs1T+oTriWWwX1R6MoAxdOci
 Y1ZGjYqhoXyfHuOKD6wC7TODrt44KwCq0T11vJFyI8HqB1Iz6a/1rBY1lIMfegoZKKj1Qb
 U4pP1dPQcbaUAeF/fw5RmXjHOjUB03E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-UHww1qQcOCWbAuHA8qtXAw-1; Sat,
 31 Oct 2026 03:23:20 -0400
X-MC-Unique: UHww1qQcOCWbAuHA8qtXAw-1
X-Mimecast-MFC-AGG-ID: UHww1qQcOCWbAuHA8qtXAw_1793431399
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611E9195609F; Sat, 31 Oct 2026 07:23:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C14A1800495; Sat, 31 Oct 2026 07:23:16 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/4] ui/clipboard: keep track of clipboard peer side
From: marcandre.lureau@redhat.com
To: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
 <20261030141442.264308-3-lucas.kornicki@nutanix.com>
Date: Sat, 31 Oct 2026 11:23:07 +0400
Message-Id: <179343138750.2067999.4231298981143140799.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=r+c5/Z+Ob6cr+ePxL8eqFTKpzU/oby2yHFBlcrv59ig=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ZdesjTxfJrkxjoJyU4kwcvaPyG07NOxiZZDE
 EYRLxY0GMuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauWXXgAKCRDa6OEJdZac
 5TBHD/4wMdhYfoQqRwS+c2ixNqr0D4AXaQ3+ACqO/JJR58hBme0SMrKrwBCHJf8yF6rM7mKT6ly
 ToyiHHJ4Ie4ZsQiOHPqPalc4faIsmYj3P1YtkoYcjhQpAXtz9Ct6uU28zStH2G5/GsLoKVzSiqB
 zHnrJqLvqV5x5cPNVWf2rgqFQ8LJQIHECXTOcgEzpYFEHD+4Y0XthkVMj8ZhxQBDrVqxfC6aaQK
 M67pbuknRGmqNspe1te9+nv7KKxlzspGoBOXgiwkf9L3jY/kq5RlfEbi7DOH8MnYqyXMVgniBoa
 dbYnNYlbtSu6EsDVljALxqBA3xYnkqX8E+z6ez97UQDtjnNvh93V5wEIYV4bh/5WcGP2+gtVOQ5
 K0bj5k4WTLslB08pvappxo73Lf3nlTxVQT4TuYo5lwKSqmNOxxvUVRYp2XCCtsAuSJ299nUzBo3
 89igceS5MdKa8cp3SVpMKZZtsALtfFovFj2PlLyrOOs/WO5q9qu5pDArgKuZWadn/u41nQsZhfG
 dpbiauL6/ayNcesVJfCwcpM6oe4uLPMtuOC36JfbScZqSHbw0lMRItr8b/bVQkFuVyyf+LTbuc8
 dXxO10peGoN9DQ2ygbOeFetUNEtOFTgaVhNDSPvPrZCWcve8tac9cYC+yLeAVN+6Ycc7DenVeDi
 Pq1bdx02Ynj8QuA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.
> 
> Use the flag to keep track of number of registered guest peers and
> allow to query for their presence with
> qemu_clipboard_guest_peer_present().
> 
> This change makes it possible for a clipboard peer to determine if
> any guest side peers are present so they can tell whether a guest is
> actually able to participate in clipboard exchange.
> 
> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
> Message-ID: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
> ---
>  include/ui/clipboard.h |  9 +++++++++
>  ui/clipboard.c         | 17 +++++++++++++++++
>  ui/vdagent.c           |  1 +
>  3 files changed, 27 insertions(+)
>
> diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
> index 6166af513906..250f1d8ea53e 100644
> --- a/include/ui/clipboard.h
> +++ b/include/ui/clipboard.h
> @@ -62,6 +62,7 @@ enum QemuClipboardSelection {
>   * struct QemuClipboardPeer
>   *
>   * @name: peer name.
> + * @guest: is peer guest side.
>   * @notifier: notifier for clipboard updates.
>   * @request: callback for clipboard data requests.
>   *
> @@ -69,6 +70,7 @@ enum QemuClipboardSelection {
>   */
>  struct QemuClipboardPeer {
>      const char *name;
> +    bool guest;
>      Notifier notifier;
>      void (*request)(QemuClipboardInfo *info,
>                      QemuClipboardType type);
> @@ -179,6 +181,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
>   */
>  void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
>  
> +/**
> + * qemu_clipboard_guest_peer_present
> + *
> + * Return TRUE if a guest side clipboard peer is currently registered.
> + */
> +bool qemu_clipboard_guest_peer_present(void);
> +
>  /**
>   * qemu_clipboard_peer_owns
>   *
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index 3d8f58a85508..f750b494eb6b 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
>  
>  static bool cb_reset_serial_on_resume = false;
>  
> +static int guest_peer_count;

Rather than adding an extra global (that must be sync), why not simply
iterate the clipboard_notifiers?

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



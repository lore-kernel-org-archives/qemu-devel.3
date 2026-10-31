Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AF606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkbjLpcU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3R7-000595-St; Sat, 31 Oct 2026 03:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3R6-00058Z-Uy
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3R5-0005Bs-Le
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793431411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U00Yb/mRP1BDvFoSpYMrxEtd49vADPWR1bVdBqSodkI=;
 b=WkbjLpcUZrZUFUla86HB9NPnN5caTglmRCPwMo6w9JojPypyxmMx95dht4ujqwUz54t7Tl
 /yZK7bO5JXz2Cg6Yg3R7xiwBVRhh8MzA+bJgzSSZBW/BKysDam624BCPUj8X+qmnzoy31A
 A6R/DDks6YmJH727JsgeZWst34oazJU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-DZbNdAY5NqSqO9IdOIp5wA-1; Sat,
 31 Oct 2026 03:23:27 -0400
X-MC-Unique: DZbNdAY5NqSqO9IdOIp5wA-1
X-Mimecast-MFC-AGG-ID: DZbNdAY5NqSqO9IdOIp5wA_1793431405
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E44C195604E; Sat, 31 Oct 2026 07:23:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E0F11956086; Sat, 31 Oct 2026 07:23:24 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/4] ui/vnc: notify client of clipboard availability
From: marcandre.lureau@redhat.com
To: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261030141442.264308-5-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
 <20261030141442.264308-5-lucas.kornicki@nutanix.com>
Date: Sat, 31 Oct 2026 11:23:07 +0400
Message-Id: <179343138752.2067999.6634402384187900156.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5krWWjdaity8ENZWR+wrR55jfRn6fhry9eAwcqHIU2Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ZdePL2reWN1wbdZ5iH0p3nz55YLXfe6T4Il4
 NihzPm3/xOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauWXXgAKCRDa6OEJdZac
 5W49D/4x0tTx/m98PTroIWWjcQ9zjqFjO/SYxJ9pfOb3UUtCkn4WILkkTzJedwD9J/rKR3p/tHF
 WXh/NHtvjo4ExQhgPV20ENvkT8JuaYQBMl4IEBVDD2hNcjuYqHjx8dwMA3vbs7mBmoi9jJPHfwP
 0ivvFcl4M+QO24PmtCYyefWMbf9Xpcoau6Y5Koa/yIwotJoExjpAY9rkEcqZTMxhC4K1oUU1aHB
 OEZ8Q6tjonuo7G9db0jvrQbrJdjWbkLRfFpS+C+S4kbAIbJy9tynChi09a0z5iBJ2N+lmbbZpny
 ATY/TIrPuT0yg7En6K5Yzvg0FrDb3PQl770A3OzEhpuIuTSpGXscokFvpzegKGky0nCdNCW/IdU
 4lPhkuRTVqqoC9D+P62L17Mtv2qA8HQrTxrdonuB2Oy9JBJy0ljfwEm070S/XrcgHQZsvrZE90Z
 CvYJJEXL+//tfb4mdpk14mkrJoweOd6am66GwnT1B2sNtGF9WVnEwwTy3Vua4KiEvesQpaN61CB
 3Mql2sJzhz/YguQEFgFyWnA1OAYMIbVJIKqSkZ+x6/FgzPyG1UHZWEoaPwT5t8X2cf2Bc+tyPrD
 iSPP/EwXz2f8eRKPef/4xmL68iFCLhmIeCPmyRPj5WCYgwcss5TJcXRPGO/shIvW0WxCdEf19Jh
 oBHaSL9tkonu/5w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 15:14:42 +0100, Lukasz Kornicki <lucas.kornicki@nutanix.com> wrote:
> Adds support for vnc ClipboardAvailability pseudo-encoding.
> 
> When a client requests this feature, the server will inform the client
> whether a guest clipboard peer is present. The server will repeat the
> notification each time availability of a guest clipboard peer changes.
> 
> This change enables the VNC client to determine if a guest side
> clipboard peer is available for clipboard exchange and react to
> changes of its availability.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



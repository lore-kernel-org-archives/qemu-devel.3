Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1172FFB44BB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGANR-0003RJ-KK; Fri, 24 Apr 2026 02:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGANI-0003Ps-Ul
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGANG-0006P4-JC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777013447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEGRmiI+o5TYoEwWnDpkiwdkRroX4jm7BGZSaJpZ5W0=;
 b=gOniUpt7D29KTRMNQH1lK7Q25TLVtR5HY8jYK7KXcDKUwPrUT09hA6U0UyxWuA3uhM6GWr
 v/oEs8zl4LviZXNiRI7qR4PK14gmJi0ztOed+R69JfKsWI/YK5kab/wvN9bpkBuH517egG
 ri3+sfxchKohywwkRrdqT8XaceroKw0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-cL_K3lbKPiOWaUzWSEpLow-1; Fri,
 24 Apr 2026 02:50:46 -0400
X-MC-Unique: cL_K3lbKPiOWaUzWSEpLow-1
X-Mimecast-MFC-AGG-ID: cL_K3lbKPiOWaUzWSEpLow_1777013445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB0C18003F6
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:50:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D83B1800351
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:50:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BCCC21E6A28; Fri, 24 Apr 2026 08:50:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
In-Reply-To: <20260422202646.272081-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 23 Apr 2026 00:26:46 +0400")
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
Date: Fri, 24 Apr 2026 08:50:42 +0200
Message-ID: <87eck4x35p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> This commit removes the QemuConsole from the global "consoles" list when
> it is finalized.
>
> Previously, there was a TODO comment indicating this path needed
> checking. The assertions added ensure that `dcls`, `gl_block`, and the
> `dump_queue` are empty before removal, confirming the console is in a
> clean state.
>
> Fix potential use-after-free crashes when a display console is removed.

Suggest to mention reproducers: QMP command qom-list-properties with
typename "qemu-text-console", "qemu-fixed-text-console" or
"qemu-graphic-console".

> Reported-by: Markus Armbruster <armbru@redhat.com>

Please add

  Cc: qemu-stable@nongnu.org

and Fixes: if it's not too much trouble.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



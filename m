Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7EECC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGVxw-00038f-05; Tue, 13 Oct 2026 02:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGVxs-000388-Aw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGVxq-0003UD-Dc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791872776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPf/WdHqj7Ih3lzTZM71BoFgncWt0R0ArwK5mYzR8DM=;
 b=JyUdNM/ZfZqHk8c1FDiGlvk0NJ3z+zlXdhpVDWUdUChDlh7/Z0kCb5Btvd+7N33Wxnmmpv
 n7RwhaImo8tsIixyup/Rc9xc7hkY5rTGS0o76QSApe0IfQ3iK6kNuGBJEwPc6Aem04vhxM
 ZGWkLG9m8dMZnun/qINEphSUVV4AeRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-SfUpTWuXNBajTNjlkIY3_A-1; Tue,
 13 Oct 2026 06:26:15 +0000
X-MC-Unique: SfUpTWuXNBajTNjlkIY3_A-1
X-Mimecast-MFC-AGG-ID: SfUpTWuXNBajTNjlkIY3_A_1791872774
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D9821944B35; Tue, 13 Oct 2026 06:26:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 715DC195604B; Tue, 13 Oct 2026 06:26:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] io: report a warning when a file channel is
 created from a stdio fd
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20261013-fix-stdio-close-v1-2-4ecfa416c7bc@gmail.com>
References: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
 <20261013-fix-stdio-close-v1-2-4ecfa416c7bc@gmail.com>
Date: Tue, 13 Oct 2026 10:26:04 +0400
Message-Id: <179187276453.2349553.9371659700810441385.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Q3YwYm1HL/SgGiSl6c3lF8koyskM1JUkqXTpWkeux4M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzc7/RDebXRiwbshzHBWtMxxSSSq4T+HmNgssp
 w29eHaodJ6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas3O/wAKCRDa6OEJdZac
 5X+BD/sGGD1+kt8epe/LM+QmBG3V2BUIMmp2LH3JP8/rFNcE3HZqatcmOLHaDLRB7UYQ9y/5Rws
 0vzS54eWltf3GG5el+R5qzTIYZ1+m1SxynBT6wmMFmxHLOfx8NYAyar6fdJ0DimCf+Hu6Ce08x2
 exQN0YWIL9tTvq1T/u+v59wRAdr/hLHtP5URDy42N2vm1ky2mNjDl3i6A4JCoCoVNoS3VEBwPc0
 Jd9YNKM/L5HXvL7QLQVnOmY7UAqK2eqGwLO4t/54v1l56IIzcKiRTMga8geOmXD559IB8Ktud0J
 YnCS8+fsLugkK9+EI8hqrWSWTAEK9FDXWkwpGASWcuEpwXgDHB+Tfj1jZTxuKXDi3znSkz/G3DC
 +ByuFLEOKBjVjbUdZRh1LAwWk/I02HoJ9pkBBX5scXZ/WSBgPn8FyG5uSAnFwU8AMRu/UDLADsu
 6896PQMCtx9HcChHiD/nW1FaOKHZQadDUPV/h13HUohLuJ7NXShpzmAgsfvTqpW2SblpeNNxuiS
 v4qNh0qD+brtbQCl4LZP3+6rpEomoO6MS0UfuwmMrRJQgNRLgnAkyR4i3aulQuHR8NvTW9ZmLiz
 AoGjzIn94ntDFleYcn9iTIFkCDBWWl3DsmmwTIUo6stfvo8TE4f2ENmuN8O2D4Z3s7LfCGtTSkg
 6B7QDcJSClhRYjg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> A channel closes its fd when the last reference to it is dropped.
> Closing stdio fds is typically unwanted, so warn when they are passed to
> qio_channel_file_new_fd().
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20261013-fix-stdio-close-v1-2-4ecfa416c7bc@gmail.com>
>
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c62..98ed8a973e76 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"

place it below, with other qemu/ headers to preserve alphabetical ordering

>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
>  #include "io/channel-watch.h"
> @@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
>  {
>      QIOChannelFile *ioc;
>  
> +    if (fd <= STDERR_FILENO) {
> +        warn_report("potential bug: creating a channel from stdio fd %d; "
> +                    "the fd will be closed when the channel is destroyed", fd);
> +    }
> +
>      ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>  
>      ioc->fd = fd;

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



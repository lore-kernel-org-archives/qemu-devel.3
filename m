Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F17DCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGVxz-00038u-Ao; Tue, 13 Oct 2026 02:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGVxw-00038h-5S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGVxu-0003UQ-3e
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791872781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pq2kRgcACuB35lr9U6k57EfOR/92zcHU/6NpD/goke0=;
 b=emAq8lolzIERBybMHN9S8xST8XDLm804JYRxfeGKnEXFphhcsBms0nB/GMOpbSZfyC3JGV
 X0wvfKOZQDLzvSFEANtSUgvGUS94U6fSCPg1+n+qrxnJ5m56G5S/Bu0ioHrwVLiRK9X75i
 e7Zp4CPrK3UUUaA8Fv/qaZ1pfP2Pcvs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-jfO_0zOZNbWnT6wmAKAlDg-1; Tue,
 13 Oct 2026 06:26:12 +0000
X-MC-Unique: jfO_0zOZNbWnT6wmAKAlDg-1
X-Mimecast-MFC-AGG-ID: jfO_0zOZNbWnT6wmAKAlDg_1791872771
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BBE11944DF4; Tue, 13 Oct 2026 06:26:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E900B1956086; Tue, 13 Oct 2026 06:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] char-stdio: avoid closing stdio fds
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20261013-fix-stdio-close-v1-1-4ecfa416c7bc@gmail.com>
References: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
 <20261013-fix-stdio-close-v1-1-4ecfa416c7bc@gmail.com>
Date: Tue, 13 Oct 2026 10:26:04 +0400
Message-Id: <179187276452.2349553.13288965768424055300.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aVCAroju87y0WkQjUfSPA1D/PhQBjk7AnUwQg+y1ycU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzc7+HGdIO1nZtuzWzUqRoPhR2e9yP5kEWKnWk
 qo/vTM7ZOmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas3O/gAKCRDa6OEJdZac
 5eRMD/wK3n6biZVboTKIanRZml+cBINEfVp/lmIgxMpBnIoW4eIxDuSr+63Vwzy5tNltmh5YNoW
 gDbNvrXiUmM7ziS7VjY+2OtFeTxaGP20sOrTinVhWP53vdbHWr7EJbHlB0fCxo4kVs4AjZHz76M
 fcC/capOJ+8hlHYT0pWV+xzeiPvlKJNqoBUWZMRyrCEFcYDoz+VtGesgPNocy72MGstfz5p3V/6
 2br+0zxKpvfgTmiNm1EIW/x02DH+jxLM0DSb/84VBKea+OiZ6mxzH8SQN1TonXJzswAGlt8ZNlP
 Zm64/L08Ya3KGHJ0CpZlyNlnGCFYpaF9bv9M+LaDzTl5o2JiaoBFUl7egewL2jF8q4M1mMzUHSY
 KUPykUE0pJlcwka0omUHM7FASE1YZZQnLE8ERBEiYsmuacV/x/ilsP8pth5DUe8pnazzAzOZBAF
 EnYtMktsbtfFq2QTv0YW6r1TAE1RDP+t4otQXtB080tt8FslGhnPWF3qRIJwvo8Wopj7WTivITm
 kr6RaTzKrxihKxbGTRTSaUhnsq/IaHpXNo+/Z1h7LATadzGlH1bmWhBbGEnO35Ixkm5zYFNLWuT
 gJ1gFSEdERVi8b0fvFJz1hzn9NPI8vT+pxoxWGYC5tZwEzeBMGm+HaxfKU2URpXfW+DKrY78Qbf
 36ii7TBaq7p+GDg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> Use a duplicate of stdin and stdout fds to avoid closing the standard
> descriptors when the stdio chardev is destroyed.
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20261013-fix-stdio-close-v1-1-4ecfa416c7bc@gmail.com>
>
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index fe1cbb2d880f..79092c4a7562 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -108,7 +108,18 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>          return false;
>      }
>  
> -    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
> +    int fd_in = qemu_dup(0);

QEMU style requires declarations at the beginning of blocks. Same applies to
fd_out below.

> +    if (fd_in < 0) {
> +        return false;

qemu_dup() can fail (EMFILE, EBADF). This returns false without setting *errp.
Should be:

    error_setg_errno(errp, errno, "Failed to dup stdin fd");

> +    }
> +    int fd_out = qemu_dup(1);
> +    if (fd_out < 0) {
> +        qemu_close(fd_in);
> +        return false;

Same

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



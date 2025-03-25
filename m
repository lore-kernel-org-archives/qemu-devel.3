Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B55C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6nz-0004QS-Ay; Tue, 25 Mar 2025 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6nw-0004Pj-Fb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6nu-0007Jr-7a
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehiVzbvvOQFr7YUJ9/vdGbUS2C1aGZiIVOQbC1KmTxg=;
 b=JqDEjOt1Ts+OeWJN/PYDQsfoo/3P2pabCsSRW+AhSNzcPkRlV1KNejhXH4NKExJ+wcKs/+
 62FWr0CQl0Gk2u0meUNQ3lFFdJ90Rp6JO2rmZb+YZudNHXmk3t205HPyClSxthtsHw4Ptm
 ukR3IQ74G9daVZuSCO7+CzmTEkTcQqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-L--i5pZHOoquXAD6gUS4Aw-1; Tue, 25 Mar 2025 12:06:59 -0400
X-MC-Unique: L--i5pZHOoquXAD6gUS4Aw-1
X-Mimecast-MFC-AGG-ID: L--i5pZHOoquXAD6gUS4Aw_1742918818
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso3136578f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918818; x=1743523618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehiVzbvvOQFr7YUJ9/vdGbUS2C1aGZiIVOQbC1KmTxg=;
 b=Vb0440iJZYzMRdAF09PlwkquAur2AjJVgBbxikLGDBMGaAUUM9ixUMIvalkRLGLWwE
 wpU6sAuauy/1TCiE+mKsJBoQaGeSReUvywLuWsp1xLzzABYI9accp3UkOFEHmlwzF/gY
 VizG+e/IlW6My3JCXKIZrswU8eb+bM7HcfRxfIeQhOSFekmR8zz9WTqjRBn5oyPrP+Nh
 3vhMIf3dTVyKuGvy2oTey7FZY5Vikk2RL19bDSD5V02HEN/6rZrjvI5U+Vsx7oX1+OnE
 1jZ1RKXXt8zPf68J42EjecdnIqMv7upQrIDpCkH+xmniEiEJd46XZzHT+MFQ0ppajJhj
 66SQ==
X-Gm-Message-State: AOJu0YwY38jDmdyzXsMBT+cx8Eo0sjuwA8+6/NzFjTehk6LHJJwNIJJH
 YpfOZc67wwcZnbiZ7Klyjc0wF1YtGo+wIp9LsMTzc4gGmmR4sTSEcQp+z0MNw2JXYEkZI7iAFhD
 HQyJ/eWqVneeSPPRSfbZWaP7gW+VYekXKs0deVxHgU54xwIanIvOr
X-Gm-Gg: ASbGncszgjgucVGg/TwYE0ae6CyC0QizfIDg+bVs10exlYzerq+EoZHk8Uja1i4Yx9A
 h8Sj5ajdPJn1Mi9+Jrp6oOWOgL4hUuKySSlWSfDYiRJ9uc5il0yr93fbV4ZxFcKNJqgSCbfnqlT
 HzR/8qG0dBd4FrmH3ZvLMgJl047ixsZoe0cufrUgJHaCzaW9bd/w3tXzR+tkfzW8fuGpFTjq9hb
 /4CriNDYeKO61KMPa3ij1BWnmx6o/H6zcVn6vI/TSYhSA6BWjmHjmoJ1zO2cEaArxH8yHRfaCkk
 owNw1FFAemUSD7JC6g+mcTVEsPLU2P5essuEA5pLO/sZada6EsQ9GWgrW+FK+Pku8oP26pJnPg=
 =
X-Received: by 2002:a05:6000:2801:b0:39a:c9cb:8296 with SMTP id
 ffacd0b85a97d-39ac9cb82ffmr1855246f8f.22.1742918817855; 
 Tue, 25 Mar 2025 09:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzjwPgzg4o/qXq6inyog6I78Gddk11DDmqtMmY52xljdoT7Rvla6jHSHRiRdM2pLcDj7Fnrw==
X-Received: by 2002:a05:6000:2801:b0:39a:c9cb:8296 with SMTP id
 ffacd0b85a97d-39ac9cb82ffmr1855218f8f.22.1742918817530; 
 Tue, 25 Mar 2025 09:06:57 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556afsm203550785e9.19.2025.03.25.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:06:56 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 02/15] fuse: Ensure init clean-up even with error_fatal
Date: Tue, 25 Mar 2025 17:06:42 +0100
Message-ID: <20250325160655.119407-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When exports are created on the command line (with the storage daemon),
errp is going to point to error_fatal.  Without ERRP_GUARD, we would
exit immediately when *errp is set, i.e. skip the clean-up code under
the `fail` label.  Use ERRP_GUARD so we always run that code.

As far as I know, this has no actual impact right now[1], but it is
still better to make this right.

[1] Not cleaning up the mount point is the only thing I can imagine
    would be problematic, but that is the last thing we attempt, so if
    it fails, it will clean itself up.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a12f479492..7c035dd6ca 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               Error **errp)
 {
+    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
     int ret;
-- 
2.48.1



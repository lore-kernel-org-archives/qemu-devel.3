Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B522606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NNLjBmfC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLi9V-000690-HZ; Tue, 27 Oct 2026 10:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLi9U-00066Z-7B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLi9Q-0004jv-V6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793111263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UywOY/U+w9g8a9IKQFT36FlPqql+j0niuHbPMwVeKAQ=;
 b=NNLjBmfCoq6EVZ3FoLWV0QLP2rANgz7ezirPMlzx279EHHArWKr94CrwG9oicPxAHxCFyZ
 rEm3yDI8xDDytlO7i7yKvRcJaU6FDNORcQop1pop6QlyBFiFTuKYC7hvuyquCjCw6ORxx2
 WFlUQDdEsauhTxCoHrexLzFekQKZW8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-szleQdnUN2aVfCwxPZYb5g-1; Tue,
 27 Oct 2026 10:27:41 -0400
X-MC-Unique: szleQdnUN2aVfCwxPZYb5g-1
X-Mimecast-MFC-AGG-ID: szleQdnUN2aVfCwxPZYb5g_1793111260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897E9180257A
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:27:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7C631803A5D; Tue, 27 Oct 2026 14:27:39 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] crypto: avoid overwriting Error object erasing
 keyslot
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20261026111237.660633-2-berrange@redhat.com>
References: <20261026111237.660633-1-berrange@redhat.com>
 <20261026111237.660633-2-berrange@redhat.com>
Date: Tue, 27 Oct 2026 18:27:34 +0400
Message-Id: <179311125460.913211.3496484666027902541.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wtw0e0hGK80eM+Pbkv6olHkWCkyoTNfQDqviELPKTyE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq4LTYQLKyffoMu891UpkrRI23KhqKRLkniXytr
 iPxc+/Hc+qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauC02AAKCRDa6OEJdZac
 5YzeD/9TRQ3KjQYv1MBHncA37Jmj79dO0cghYMKnIMyTthEBjQ98G3hEgKXX45Vwjz6GZ5rLj+v
 dQg4TpISBuZBsxUqGulll0L12ykQ+UIgu8MWzDclRWvPNO+nnNxRGU0rVNbN4+5NYpM3C7eYNvT
 Tzvd53zBVSMY6vxPC0hErpGTNyzu8XshruoyRArq9MaymSZAyx+9tGgUzV0HSkawZ9zsOWOVbSw
 NGZDfHYWfbIjpK62MnqbIWMXZT9wa1bOxZK/je778YE6m/rC8/OPs8Wp8zCgoROQbkiA1GGUD4m
 loOd9fWVe4OxRoLGCrRoQHUxDlrX1A5QNDhoViI/YiixdmQYJV4w1BvIAEpAruWXUZ9F9Ej80hl
 XuW+LCjygbYw4qOYaUrGHfDcncTtvIuFVfIL9SiKMDP71NRQ0idKK9SGdyaiIoxvlYuqv4R4uyd
 KQ4cyPjVFq1kmC3aMsHuxmoQW78Hg3h/S9lWkZFHzGVZxdp0IOu/gsmFsSVEyd9SztTUmFLK6Hd
 k2oF7t5j5PRyVp32rDd1jCCNCygRow8GtuskozcHwW8K3IaqbwdUT0B22nzZ+t+ZubaepCiex/Q
 V27/+zGYJbv7LJz2oqT6lLv2uQ2AwsQVQCfcEqeOX/HMAuzJ7Fkxo1X1PHzm2vMOZ10xzgfLF0u
 TolRpi1WGNiqIKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> When erasing a keyslot we deliberately ignore some errors and
> carry on trying to erase as much as possible. This results in
> overwriting Error objects and triggering an assertion. Don't
> pass in the &local_err, if errp is already set.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261026111237.660633-2-berrange@redhat.com>
> ---
>  crypto/block-luks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 0926ad28f0cd..277a51106072 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1152,6 +1152,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
>  
>      if (ret < 0) {
>          error_propagate(errp, local_err);
> +        local_err = NULL;
>      }
>      /*
>       * Now try to erase the key material, even if the header
> @@ -1169,6 +1170,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
>              if (i > 0) {
>                  return -1;
>              }
> +            local_err = NULL;

This is the recoverable path: the comment says we still write zeros and
carry on, so a first-iteration random failure is not meant to be fatal. But
error_propagate(errp, local_err) has just stored that error in *errp.

Keep the first-iteration failure as non-fatal but do not hand it to errp?
(e.g. error_free(local_err) instead of error_propagate() when i == 0)

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771DCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvuH-0001a4-5j; Mon, 20 Oct 2025 15:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vAvuC-0001Zt-6M
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vAvuA-00008U-AF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760989852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byfjxkoC9O5XWVfdQK/g7va4FKeo0tzpFx8xDKKPxBs=;
 b=HHCWsZyLxzPj1JEvCTJMzI9k0Na/Koojo50RuoR0SBK8tI4ckVJbusO2EjLJYFzduSmBck
 Ecg+2w85gfguu3QPALCAe87APbg0okZMUKshZB626nXFWsMZyZN68AL2HPgQfzwNcNP8mY
 nZg20xDvQPvUipDW5fADeQ2RzvFeL08=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-czn-x-7wOciGq48mc6113g-1; Mon,
 20 Oct 2025 15:50:51 -0400
X-MC-Unique: czn-x-7wOciGq48mc6113g-1
X-Mimecast-MFC-AGG-ID: czn-x-7wOciGq48mc6113g_1760989850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A7D7180035D
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 19:50:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BF1A180057D; Mon, 20 Oct 2025 19:50:49 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:50:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] crypto: fix error reporting in cert chain checks
Message-ID: <5tbmnwtkv3ff6yekfbedv6t4c6ohoyediq247sbck4fkrnspv5@32kpxcdd6ks7>
References: <20251020141237.2621796-1-berrange@redhat.com>
 <20251020141237.2621796-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020141237.2621796-5-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 20, 2025 at 03:12:34PM +0100, Daniel P. Berrangé wrote:
> The loop that checks the CA certificate chain can fail to report
> an error message if one of the certs in the chain has an issuer
> that is not present in the chain. In this case, the outer loop
> 'while (checking_issuer)' will terminate after failing to find
> the issuer, and no error message will be reported.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlscredsx509.c                 | 33 ++++++++++++++++++---------
>  tests/unit/test-crypto-tlscredsx509.c | 12 ++++++++++
>  2 files changed, 34 insertions(+), 11 deletions(-)
> 

> diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
> index 85f51aee1b..5f78fe7d6f 100644
> --- a/tests/unit/test-crypto-tlscredsx509.c

> @@ -652,6 +661,9 @@ int main(int argc, char **argv)
>      TLS_TEST_REG(certchainwithexpiredcert, false,
>                   WORKDIR "cacertchain-with-invalid-ctx.pem",
>                   clientcertlevel2breq.filename, false);
> +    TLS_TEST_REG(chainincomlpete, true,

chainincomplete

> +                 WORKDIR "cacertchain-incomplete-ctx.pem",
> +                 servercertlevel3areq.filename, true);

With the typo fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



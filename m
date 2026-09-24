Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C7FC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5W-0000Y9-Qf; Thu, 24 Sep 2026 03:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e57-0000UY-Rc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e55-0001Wz-9c
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0BZCR5BZEdmhFaw6NxyZfEd7Qgm4Ws7yT0+MjABQaU=;
 b=EK6SAHPi71DHQjUyctyxZajvZ0wyKLH/oUgZdvQjdIB+nuBSMho2PyD8Z/1+7RlSutMWt6
 927sJoB4/Rehwnp/UiekeDbVUhCtLpBmEHddhEohDkY38WutWhXYn1Q84sPIyiMXXqqJvo
 ybafthMn1plLgTTTecToqZoNgupkozM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PEp78vXPP328q5opQeeYBQ-1; Thu,
 24 Sep 2026 03:41:18 -0400
X-MC-Unique: PEp78vXPP328q5opQeeYBQ-1
X-Mimecast-MFC-AGG-ID: PEp78vXPP328q5opQeeYBQ_1790235677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9170A180215C; Thu, 24 Sep 2026 07:41:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC07E18005B3; Thu, 24 Sep 2026 07:41:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/10] tpm_emulator: Reject sending commands smaller
 than the request header
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-4-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-4-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566485.1794827.3207875692317981911.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YkyogN+lZ7lajw0HJQS52KzYIvnbR3TA2w9Tu75ZZiY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQSOiR9gc046Kt81yjwUXbo4E8CLL0zWLV3E
 MsUj+bXT4qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEgAKCRDa6OEJdZac
 5aKnD/9a8dFmfHRZ0986wE3T3ESEu4nD8VH4GBc5/DljcwqBzqJrs3YsLN/lwC1EiVFaRdBgASn
 /WQJwAhgYVrYswzfdUjfBrBGnX9GFVLby4+1HaeNFM0VR0hq8zGpMkWBiPkMiH/V1ajQNAPtNUX
 bm2Zhi+xMfBMO4Cf8VZKMZWt5xgq0GK+AU57xhtEKaoUWk0Z0TOz0pCRUtPmhWLu/B70YZNHjhO
 Ylr938dmR62AgvUJ9x92N8dzqXs3OwR6ziRkSUew/GN9eyJhjTAjnUJcq9gXLm3rfM6eevCOWEM
 ptsrlOwzxJ8JXpTAXhyEytfsejoKEc61V8yVg3XdvR/tsq22ByGkl6n68zpa2BISGXYkqkJmctU
 P39iuP4G5OFY/fiRomCbDVgKtOv7+lMvsvXp0HBnpStOrjPo/QzsMGhTrn6w96DGSrKWBELQmZT
 ULuPIPznGgp4Bad6Aat/jqvD96djIvUZAZ+Wj4HRFYvhSxf28Puzm+EGuJztu01kXBMa8qVIr80
 QvSBguzGrGbnih4mEEwHddTRybz8CuprHjti7e06wrUBAdKi1RDi5xr05p0nRg1TinyAU92qzox
 SE/asXyIp6XSYVpEJuL1tkRCDf2EsJta7ZkQ5bIeU4/PYwCU9EwY+pVk96nTap/rHpJnxmS8fzy
 8p/kmfM2JQZNG+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

> Reject any TPM request from being sent to the TPM emulator that is shorter
> than the size of the request header.
> 
> Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-ID: <20260924012527.858527-4-stefanb@linux.ibm.com>
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 9c95b4d878b5..0c9e32f36a53 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>      uint32_t to_read;
>      ssize_t ret;
>  
> +    if (in_len < sizeof(struct tpm_req_hdr)) {
> +        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
> +        return -1;
> +    }

It could probably be an assert() instead.

> +
>      if (selftest_done) {
>          *selftest_done = false;
>          is_selftest = tpm_util_is_selftest(in, in_len);

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



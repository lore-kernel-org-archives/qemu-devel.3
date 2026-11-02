Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49906606A334
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhlthVSa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsjb-0001Ef-0N; Mon, 02 Nov 2026 09:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi6-00082n-NA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi5-0005Fk-BE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=030gJmT9UekNLg5uV1gpIRhINlOB7XDE6KrDWsvJ1K0=;
 b=NhlthVSaW/UcP1VZHapWYH3vRVXojlVwnsEhAewcRhX0YuPOWdke1eKXTjeEza/C2YFwRJ
 0s5yieaBqld8Kfbd+w+YWlupGx5N2cB9LfmXA0GHDtIyHXW4aUCK1EAw4dDchKNFXYJOBr
 G0oeK1Ak/5BZN+LgXWIPoWp/jI+StJY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-mJ4JNnACMwicqCOteu9lag-1; Mon,
 02 Nov 2026 09:08:25 -0500
X-MC-Unique: mJ4JNnACMwicqCOteu9lag-1
X-Mimecast-MFC-AGG-ID: mJ4JNnACMwicqCOteu9lag_1793628502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2FB9195422C; Mon,  2 Nov 2026 14:08:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE84730000E7; Mon,  2 Nov 2026 14:08:21 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 15/18] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-16-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-16-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845020.3960472.7447031612361559961.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=688;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+KSs9MRyfQyRbvEU+lEOIbs6SMYIAp0GuAa4j3Lwip4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkPcqWQnGOPrWOAku7tGCS7NAyoNCBQ2w3D
 1ptE1OyWTmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5Xy1D/wNJtCfhTJSS2+MPdCGTSdjyPGv6qKvL2LbjZRRrUkpZDsqkkW0cbdiq1XIbTGJjuNk4Tw
 n12Meo+cPm09uleBjvKo7e4L5/9BAfm6GjYyVuK/rMddDRhGScaS3r8oNUzPsVZq9NlyuRkruWj
 E4IfcPybW373Q9BnyddjTQdjYj7fO7TV5oRCNjyYq1akDzq4xAA2dxnrXXKLoRtSH9o1BHJpW8d
 VCeWQPpnEambZ42lOXj01Ko5mwXqZdDe5mE0R3pFJWCwoMTiNd4TjV75YA6uL6ImggWD6ZFxgnZ
 YtFYdca60pcrtAx85xbkKQJFGTGHRq7Ez4cvsxj0yXS/M/cJsM8AsnnNzX3pisJ01d5UHx7VN6m
 7AsvT5fK//9p4D+icQHUakIODNQ/N5DcgRKV3hB3Bp/2ZymG8gs6UQB7NOD2mu2xJiYMpZ/CQXA
 VONw/Oc/iWtCiOhJyS2qH1Pm5cmklqVcVlOqeKS3juDtyjFNHKHE9ES+p+bKCkY5RtXPqm9BpkW
 nmvKo2RXx9wGhTXXXkUiMs5dEZaWXP/vSn8bdTxAYBdNC7Rhb2ISg8abxwf+fhTtPcMtYu0/QlT
 EvwkgSGXH7Sbh+7zuwmgbS2qOpfzVmBkNtSQpu1T6twffEia6Okg8rvRB3qFlyfhrWls3n3dg4T
 qXPMxSmMKGfmrzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 02 Nov 2026 09:22:24 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Send bulk and interrupt packets to the device and return the result to
> the host. Each one is a request and an answer, so they reuse the packet
> tracking and the NAK handling added for control transfers.
> 
> A bulk request carries a 32 bit length, so the host can ask us to
> allocate up to 4 GB. Refuse a request that big. Do not answer it with
> fewer bytes instead: the host counts the bytes it gets back, and it
> resets the device when some are missing.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B520CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCqx-0008Nb-7I; Mon, 12 Oct 2026 06:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCql-0008Ks-56
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqj-0001cW-J7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Sutg9DXHSGWhavJIR+QhIrCJDkZ/DWA1IzcBn3s9ro=;
 b=VEmlNv6FB9xoTr+VHg/5KsH1YYf4R3aeY4m0eai0fQsuNBbEVZ3ysmj4Zgf0Yv/ZYoNqEb
 MNVHZGFi7vaU/0qSVnimUPtcIIjUVS42agitYnaUuPa1me4pk46KEtDRqcVNtxNPTUvuqU
 0KC7WVhRPUKCDHF0c0Ssn12oIBVnC1g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-6VzrhQ5TPSei82QRbipfVw-1; Mon,
 12 Oct 2026 10:01:36 +0000
X-MC-Unique: 6VzrhQ5TPSei82QRbipfVw-1
X-Mimecast-MFC-AGG-ID: 6VzrhQ5TPSei82QRbipfVw_1791799294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0CA1194510D; Mon, 12 Oct 2026 10:01:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA9F51955D47; Mon, 12 Oct 2026 10:01:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-7-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-7-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927146.1642373.2907711602131535978.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5va7ZZ9EFUfD0+PbbgI/GFbLy5jLTfCdfLz9i401JpU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/pOSGP3a6iTF3lgtlrW71tw1OmaKVfrglih
 ezP6sCeD52JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6QAKCRDa6OEJdZac
 5Y0MD/4oOEtiy+oltQtWFUSLvvwVR8WXU+0ybwAsR3Vyvt4LefCmZxs2IjzKGdeGgzuXwjDYn+j
 f79CNXNzv251IHBMgpAEndrImdhPH5iKCl4ETobja0x7hm5nzE4NTpXQEpyRYOHiUZo/Eb/dEwP
 6706T5e4U8zrPwGjAU26AE6uE0+Q0DgD7ySoSC9fpcajTMSREbtG5qyyjeGqVG8Jq7dqnMc/7PO
 kv5WkBXXUIFokxrdh/4BHC+M29QmmLq1AN5y4gXnU990lma6vDf5UJOKwgMUCyHT249V/vy94qg
 ELPB7ModKap2+rLQ4cR8ra5xXJjyAYcrEq7yU/Egafn+gS1PPcRCQMpZT/+i03jvl51Jx5TXpCN
 pE9oJdr5JRgPJOiPC4Ar4kVv9DszCe+OXhK3iyU1GpW62KKwd3GhdPDF02jSmVdX/oRZt7J+hLY
 WH9EPk0ip46N2Fmk4avh9Q6OtVC53L/tYI5qOtwubaKxrYWQzdIiOgXcGhgjImyGK1nWJMrkWTV
 EfHAIu8KKdNXazoAGwz4HdSNNY2QoRWXVEkycREOlYDFY1E6tFysxFp6bzJegTCa901ZdsML6Dd
 TcSSTwIDFLdYYGvnNIM2v9ISjUNfczcoQ8ilTbV3mNMsn1CkJpjyjkvPhd8miI2Zr3D/93hDqYp
 nYIFbBXKdb7pijg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Mon, 12 Oct 2026 02:16:42 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Send bulk and interrupt packets to the device and return the result to
> the host. Each one is a request and an answer, so they reuse the packet
> tracking added for control transfers.
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



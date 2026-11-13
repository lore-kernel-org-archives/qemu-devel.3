Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87357606A8BA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ml6t68tF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmiq-00038X-V1; Fri, 13 Nov 2026 03:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmil-00037z-DQ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmik-0002c2-0m
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794558797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcmyKt77hjVEh0CP5MM56x3BySBRXZhit76Lp1Xh6C4=;
 b=Ml6t68tFc98bUkURMswhmuotcYu+Xd1g5X4PCAIZKiiNIn6Ksm2gx22jTGUb7mprQzHWPw
 ZKkTbMWfpU04J8UOLEtnSi0kPFgc8uu2A5L339zOqnXWmmlDwgDXeXTi9z//5ST1qrGlap
 wzuyGUEYwDh7DtPSeKauvtSt8AHct2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-dZhqQQqBMbOa-HRNNsD0Og-1; Fri,
 13 Nov 2026 03:33:12 -0500
X-MC-Unique: dZhqQQqBMbOa-HRNNsD0Og-1
X-Mimecast-MFC-AGG-ID: dZhqQQqBMbOa-HRNNsD0Og_1794558791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ED2418004F8; Fri, 13 Nov 2026 08:33:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8B2330001BE; Fri, 13 Nov 2026 08:33:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/9] hw/usb/dev-mtp: Check length of class control request
From: marcandre.lureau@redhat.com
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Junjie Cao <junjie.cao@linux.dev>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
In-Reply-To: <20261112174907.158825-4-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-4-tcalifano@redhat.com>
Date: Fri, 13 Nov 2026 12:33:00 +0400
Message-Id: <179455878072.754321.15251897429967459069.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=509;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F8yGoDMB5ZCfW8AmTiWU0dmgHkFQp92WMwsvpirX6yA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9ss+YhbL+uOBVfDiPyi+czhMPArj8k8KGsBnK
 fSpTafmAVuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbLPgAKCRDa6OEJdZac
 5UgJD/9GhmlX+H5mCPr1xP/rYNK0AVpCsLA3P5Y1RxTgZemfgGDKeeqHBddUVmF0eg+L04wuXVo
 Hu08fFfdAyI6pyK5HEAyBQCnB0SkaWNAN7uDSSsYXGbcQ+Lk/SP8uVeCCNeiBa22HrWe7cgYRMy
 8JMM2Tvqe15RXPF7aPlSPXKMDwRZ5vl2YUEOtHA4dpMGPfHl6oo76tLVtTXINWiIoQ2kXL5xWSM
 Pp0WOOkxxFvOs90Rzm9Xy93PPZWmyXoJqUZ38E4ZLD6hX9im+iohuBn0HLzhre15iRq8ImXWG3t
 B7TyAMGJoeTV8DxZXofLX75Msa6Nfyy2r5bZCZpYZw1yhWG57PmcT/BMoVWZ5Ym2fFdk1hOk5JV
 Hb2i3DFshcraOLPSEMIkcFVrET62j41DyVMmKtUjjocvUgXbzZCf8oS4KLJTPg4Sy8ynwWbHJYy
 rn194aXymNFdZyqjskh2I44Dt4DYU+X0+oUF1Yq6k2fVzSoxWrlCnblAz0gnqWDHVsgm851v9tP
 zgXKoQLIauhSshXIzCiAufDxTfTj0tpWN0au1ox6wGyGyIqaezQmJOTxmxt5/aquRKOfE58fd5/
 3zAzxQ8PVT94mNwqtCzHXabGzDfZ1C7PENsNXWCv5lOIHtSB+jS+Y5LZ4MS6JehBhAd0zTTc6Kl
 A0yzgugpsQktmEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 12 Nov 2026 18:49:00 +0100, Tommaso Califano <tcalifano@redhat.com> wrote:
> usb_mtp_handle_control() reads a 16-bit event code from the request
> data without checking that the host actually sent it. A request with
> wLength < 2 makes the device act on stale bytes left in the control
> buffer.
> 
> STALL requests that are too short to hold the event code.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



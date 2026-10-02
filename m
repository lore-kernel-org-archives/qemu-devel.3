Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27CCCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzn-0005ip-8B; Fri, 02 Oct 2026 13:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0000XT-2v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxz-0003nw-Qz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZbreQQHhvp91loUpdeP4aZ/RKrcLPZbF/PAGSeQWno=;
 b=KGGL8HOdbsaoDxYsN+YmLWT5CtaTOzGbpdiHgNevJKRNfZtY3Jx9+v1j+SIY1yn2pnIjc6
 jPzwoutTFYoy1ApEysjX1+22L4XpjFZEUAB5TZP1U6AX3QqHDc/ptEH0F2oTQ2wEt6h7rY
 G5eSGm06/6cGyBiDSikULjislBrh5D4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-Nuf6dyyKM0SdfCEFBrS6Zw-1; Fri,
 02 Oct 2026 13:22:36 -0400
X-MC-Unique: Nuf6dyyKM0SdfCEFBrS6Zw-1
X-Mimecast-MFC-AGG-ID: Nuf6dyyKM0SdfCEFBrS6Zw_1790961754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A459118F4BEE; Fri,  2 Oct 2026 17:22:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8A071956086; Fri,  2 Oct 2026 17:22:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 25/28] hw: mark KVM clock and RTC devices as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-26-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-26-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166135.3025252.15042445966657484711.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=302;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RgriddRIoJ5Fdcu+Zvv88tHI9dTC0oc9vQqbXoJtYoM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gC2A0XRcSs7EOe5/RnSBZGhpsE+XBGBXq2F
 6yA7zcaGCeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5SVSD/4is/H8riITQOd0QCjoRhVdRECSA7+r++NfQE/FpZ5QM4k+wdqKqmrvd8oj66rN9yRaqUE
 jr9I57OwAhPxYQHSc1OBlC9BMU19ogNbLLUesBeQjly+oo72m76m9/vt6mOCOnlWvuSUEeppaDx
 FsQZhEmPXXdpGgY8EfygrNjIkMjjjA7n9UP9/rto6MuNzj4iTONGPmIKGhU9990itaUSaAH5su9
 JoXFAy+N05CEEaEIMud3pCHNtUwPxRUjIIRET3nWMIXyxHRUCAnhShDhoRSksNPNqwPSX892DLG
 XPhpVMdtl2PTZUZUCEE8SnsdVCepw5THrVPwfrI188MjlbBszrfreYYcmjNYIBS++X9aPIrjvti
 qwdd5zRoIBUL2qZpHcBrZirMTB6s3y+RAzTPuph8nx34k0jRVywAZc+XReB5JWNFlLWrS8tFtX5
 W/MmD6Ck2AwnNnfYKskA++WQq7e9aBihxrIpc7nzvG9BBufI4P6x3+So3DcFxYeaRiPRzHj91A4
 UT50+dPZsvYlHJnSq3S8Lu7jDCHuLBLFaAzoySfIUYRz12lVC5wukW0Rw/ZpjmjNN1fHEB2+xrt
 hLfs6JS1XBvt48y9VCdWOT6v6uJGlE3BeoNo1bfF4KzOu22yFu+kfmDaDncuPoeLTkqzEVQhhPz
 w4BUd0J2Zn8ojhg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:24 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These are core infrastructure in virtualization cases so must
> provide a security boundary.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



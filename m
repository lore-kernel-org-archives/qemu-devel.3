Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B4ACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzV-0004HX-MF; Fri, 02 Oct 2026 13:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxY-0000Cp-JD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxX-0003ea-0f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57WwPXiri8ItGsFv7myBZwLi/3rudhXRfRGMr5PeG68=;
 b=Z726x7UNW/uFbulvLObGbrBoIEDuHlCVmxagLNT5wcUWtpNNxZMcQgyPVGDMrJ74I0Ub0C
 4MtD8JV4KMFaQzPVaqAJAtD+KlIvRuBkWvsWu8ziUHcdgeRMUT66BrbZR5b80C+v8Gbh1j
 in76yA/EnvseKuy5kyAx2UT3hdlhFNo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-3fHADws5NEKkG64FdeYlCw-1; Fri,
 02 Oct 2026 13:22:06 -0400
X-MC-Unique: 3fHADws5NEKkG64FdeYlCw-1
X-Mimecast-MFC-AGG-ID: 3fHADws5NEKkG64FdeYlCw_1790961725
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFB711955BC6; Fri,  2 Oct 2026 17:22:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FAB81956086; Fri,  2 Oct 2026 17:22:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 16/28] hw/pci-host: mark common x86, ppc, arm and s390
 PCI hosts as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-17-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-17-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166125.3025252.6382515951011639582.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=434;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a6PS2bf06cWqaNRA9LviE1UK4mmPhD6vsHBc0nvPGR8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gC2lhKiGV5+4pem5Y08Jr42+7fML77Zq8ZY
 D+UpTlNwgeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5TFOD/4r782ffdw/HJtRv2KNyjAQEKod4DsYtlXrtjK2X24h+3XLRvAP0USENWkPc95obEsvg0D
 Lz5cw7OBRfkJVrjU22t7tRXUqCwN826lTe0GpYPPoohID/MZqyJVzgAd/C/+SN0EGLQRGbq/nZ+
 v20D8swUtXr6LOhzBxNfD+6HyeiElB2xbSLsEXlaWDKV0x0RFtY6lcPgbVAuzyERTN+luacFywS
 wNT6higrjGwTaz9ay9xh/dnvaga7aL66mRkK1XKSQeG85XXuT6aI67Qy/b3JIqeLvsCEIyA1s/u
 8Yclm0DBI3dBtmzxOulYMS6xkDuGke3fDBOEL+fNyyTW9OzoEJRXOCMuml4dab7/7kNi6uGvdDI
 /C4oy0387rRrOY7IU/LdlKhXmbJKfXQul4NpPgs55fyB/26WpbCZIPEDQtmpV+ixw2VslXROqS5
 RF/479K4hsxLe2IcjutMY9xCbWePyFK8kShyDI/gOsNUFNh614mHdO0LtG0Ed0XUSEV4ZJJy9gw
 n0FeVjlLa/wNZW/mwGTXgWgvitFWepS2RYs3SrV9jJZBzzK+LSJOIh/soeo62h/y9WL9D/DgRNF
 mZQ/Kp7jfQMEjFWxSSrmqcotEq0Gq+9J/ZYivJ9m2h+hK7fafg6aoKgnHp0HSno6BnOfQYNWAfn
 CT65tKa/jeamHiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:15 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Mark the PCI hosts secure if they are used from machine types
> that are considered for the virtualization use case.
> 
> There is also a special case for the 'remote' type and the
> Xen passthrough type.
> 
> 
> [...]

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



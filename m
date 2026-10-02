Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBFACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzf-0004uy-R8; Fri, 02 Oct 2026 13:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxU-000093-7x
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxS-0003cv-PE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nTk5h441BlUCx/NZYxRViDuR1MPXYhtJViIj4n3aPc=;
 b=d8y3VlEPSg3AJCuc9rjlyxu5u3MS6lqGhTclv6Lfdr9CkdK8N4NwiDclB01ugViaKjsuTZ
 jw71b8Gd5ieH8yCmw2EYNdQ7RnlqNzS3vYC7zvp2m6owlbuWrhp8F1x2GLspCXKLhW6aqv
 BAXfqw3V04plVo7upnFTWX5krMGC7QQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-lVaX_vJSOX6-g8URbd2QEA-1; Fri,
 02 Oct 2026 13:22:02 -0400
X-MC-Unique: lVaX_vJSOX6-g8URbd2QEA-1
X-Mimecast-MFC-AGG-ID: lVaX_vJSOX6-g8URbd2QEA_1790961721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 851721954B20; Fri,  2 Oct 2026 17:22:01 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A41B01800351; Fri,  2 Oct 2026 17:22:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 15/28] hw: define most common PCI types as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-16-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-16-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166122.3025252.2345560702508398440.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=305;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S5LgpxEbmDgv4nz2+w3MAekw+e8ZUjn4pTaaJOhl7I4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gClYQc6x9HdvVuTz3orxL5k19B0JWDKbBeO
 2UgDlZ3atSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5QCGD/4v3MxlW9xcT2gilvuqgxjpT1DxHwa00sDRs5T+gRudU6o1ntWoLU1qAc7JZwaJ/aqChOd
 IKsduJD+1Yalyd+onaPKwClZFmIj9njmtkFoJwrqiK0G5YZJDw5Lru0MvY97a1t2EuSQMVZfjim
 z2F+s4CJm7MsgLBZV4Uvcv7ON+jwC3kLFiMH1rl89BmM/FmVWCPE175WC2mdtLoj5xq6bt3+FY3
 ZLEMvjIn0YLigHAmkKeWitG8N8SZuCCP8GK4EVxHTj3+b1sTbexIng7XhmDleJlUtMeHJf6gck2
 BrknT+6fYa9FNDyuoI5kOPwGONw3mbBxpLSTcFWBsAKyAJZyaVjVVAzIk4B6Amki3NFeFde8ZFl
 1bnaSYcMCZh7UAnNJDTvWTWWNJZkAJWG+uZVVoHI9YdB1hhkpI4qrz61UNvUy0vgvAz8BgIbSL2
 fUgE1s76avvtH6uGlnp+tK68m/7haS/kJsSrQNw/03rkPBLsTNEdBVBGX1oF4d2NOOX7eLRkRBT
 S4kLfXZ/jIK232Bg2hpMqUEWvIxPbemtrDq/ofdByqfw1RiUvhLLH5UKUHjJWgUU7UkbN7taxj3
 xYthEKHzY5c0A8E0thzpO8xoGF91S61FwW5b+VrOIDC9CycnIJWAuTzg8Ggx0/c70BXc7hzd34R
 1AGq6NK7FV7PPiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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

> Essentially all PCI infrastructure is in scope for the virtualization
> use case, aside from the niche simba bridge.
> 

You should exclude the CXL bits though, as stated on cover letter.

Also questionable perhaps: xio3130, pcie_pci, pxb

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



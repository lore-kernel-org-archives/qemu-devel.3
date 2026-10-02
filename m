Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAE9CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzM-000396-Hc; Fri, 02 Oct 2026 13:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxO-00005X-8B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxL-0003Zd-4a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nIRzmOZNrJ9s+xcf4J8MYpSLOxpzXpuBIwo4NigH5A=;
 b=Kf7VcFTxTigEvR4qxXLv/M4ydiT8Va9pD8a2S/zQukrV0rvg1Ttbl79G68tp7QIOUiJArt
 lmYOlrBVR3dJxIoW12ADQMH3FuD2ly+XU+Ri3dJVDDjcyxS8GnD8WDnbAwpSCGEckAeAiA
 7t9n99J8CQebKQFR88DSs5Z2Jp8haoM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-op3WwH2ZNA2u0Cg8MOEiXQ-1; Fri,
 02 Oct 2026 13:21:53 -0400
X-MC-Unique: op3WwH2ZNA2u0Cg8MOEiXQ-1
X-Mimecast-MFC-AGG-ID: op3WwH2ZNA2u0Cg8MOEiXQ_1790961711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA7FC1955EAB; Fri,  2 Oct 2026 17:21:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E63161956086; Fri,  2 Oct 2026 17:21:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 12/28] hw/scsi: mark spapr and vmware SCSI controllers
 as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-13-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-13-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166120.3025252.9810140897534239421.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=373;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bJJ3aIFsZ99ktF+Pq5lKTPnYoOPh8mqQDX2p00a8g08=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBaL7aPZEvnSAKIzO8UKS9uB5CuA5E9XGSZ
 n9yRIT/2ciJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5eNOEACCc2b2xlEhPjvdMWpeR8ZDcVVNGeP2txruwI553hlMp1/aJMpBohXCClMaLrnmLEp8HNt
 bFnHLcWB52W1+OG7AqqEoUAD+yBvSPlsDKLx7sdqxjMPnYMzMRNKEHkUwJ5sF0X23HNOPYpu3Pb
 gRSRYuiNijD4rYRxBfx2yF5sohNNV4O60QJWOLtpiKRkmiHiazE/+7W+rHt2Jvde6EPYyYUb33s
 P9lADxG9ryRqiOcFYbBLNdRre2PQr9x+OT14+vMhkRMpLrQ4l6G/YX2+ZAqgrtJUqddlWlyFsRc
 INAw2MPGIusoQ409eyJWo8e1D45xhU7SVLDG1DcLeykobHsLcpb8VCyDwBgQ8DCzSUhY+mdypUz
 1A/oa/aovg+uSMOMNYFgviMxsh3QUaUJdfbzxC4TAyLlCzQxGNJcEHy6RXHnUTnaYil6yn9bGp5
 kXYA2CVnZLbKNNQxHMQXBr8nzkPG6xfBoPpkecsB3c6nhBvQHFsQ9+F8oBN9iYPbD+l8fpi9MYY
 dORMvi2PUJ/Wp0KiBgMvoBnle648wr5EGqONsULUjk2fbiZmcy0/+YZl69HXtUdvJnzFmBaHqtj
 /zrZQsoSKDbIevferN3SLV8bKDPXOjlFBF1SF6FDUz6iU+anGOKbRWs3Y9g3efVtoKiA803JDS1
 Ihl9jai5EMa1uoA==
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

On Fri, 11 Sep 2026 15:36:11 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The spapr vscsi controller is used by default with spapr machines
> in a virtualization use case. The vmware SCSI controller supports
> a virtualization use case.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



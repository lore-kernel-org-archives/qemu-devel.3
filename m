Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55D4CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK94Z-00026H-Lt; Tue, 05 May 2026 02:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94X-00025G-Px
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94W-0001ut-8A
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777961754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAsYiZb/9tynAzUfV+AWwMN36b6A0Ku82QK950H5eJc=;
 b=HmzvGeRHaeyVSC+qZrFbotXPxqaLPB7gu1CZ8d/9hXEBsZ1qnzNVE0gfZOOZ76MqzKLzbI
 cogQjrH/cZgVloXFNhXdmFZBpw5UtMDwT4mtCZs0rcPZIO27iodJyPEXGb6CGzaxDI3lrT
 y8Dzx/Bf2bN6RhLGiJjK/mWJLi72k00=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-3h5IqXwgNyedv3QCem80sg-1; Tue,
 05 May 2026 02:15:50 -0400
X-MC-Unique: 3h5IqXwgNyedv3QCem80sg-1
X-Mimecast-MFC-AGG-ID: 3h5IqXwgNyedv3QCem80sg_1777961749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 071B319560BB; Tue,  5 May 2026 06:15:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F39AD1944CED; Tue,  5 May 2026 06:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 4/6] hw/tpm: Implement TPM CRB chunking logic
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com, 
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260504174234.13556-5-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
 <20260504174234.13556-5-armenon@redhat.com>
Date: Tue, 05 May 2026 10:15:40 +0400
Message-Id: <177796174021.65777.6842763654584777964.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YjzMsqLQg30S2H9LrodJS/041Omss5tcJuzCVFNkdc4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+YsO0WNRArFJjN1EnAtS2nmZy9JV1a6wAa4x+
 cqqIA/dG8GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafmLDgAKCRDa6OEJdZac
 5R3aD/9fLyOMyft6ljK5eSIm+ysuRLRiNvpNKdd4lDx0G95iCmG8I7uRmV3YXbCG0F//OfQB2BZ
 no6qp+8CnCF1RBP06BeC9FWr4Qv7oIoSiVHYcFiDrb6zDcsYQd3l0slzAowuJ0z62duoKGzkZwu
 mZjZJieQmHBY0tWi8v3xl96hMM27y8RbYOaHM09G0UaStOX7ISmVzQRcEN7QyIrjCuCwgdiLIJs
 LItZ0qfswA/2SKYdLaiSfEVzgNwtZGGuoaFuUL7BoSNs8e3jlOJ1C6DkohUAX/9lO3fQXkG/iz/
 mvpCgxrinLYxCdNWKLJmN3s6E+M32uEEa8Z2GFQGzgshIafeCiMHIPkLmLfGFfrBVUjL32mvg1u
 B1vZBeY5bOAv6Y6Ex/QX6ofJl6hkms6hRXQufEsy1fwRrdmfxrzjoAowGmMy8eDjndRvLzUouyA
 EiL0MWXp1wD7KMYPUrRcBJZGv9sSFWga3LgiJ6DOj7b4UppS0lbYR4y4T1sQbNrNtZ/uBBi1asM
 XGGHPnVJzXPrluuzLYgXHsCRsvdwJwAPmxzdhTF3d1z5risXeZJ4rcpQUsWxT2+BpF4m1s5vuMa
 vPsyiutXteCXcdzeFwosr6+EobbWvmNkgWHTdOJdfkPRW4czXSBgMnnyfPOSmIse9/EjcWTuc4j
 CQkN7nvx1nZx1/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 04 May 2026 23:12:32 +0530, Arun Menon <armenon@redhat.com> wrote:
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 1c944d7ef27..5572d892686 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -153,20 +220,61 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> [ ... skip 22 lines ... ]
> +             * Backend TPM is busy processing a request.
> +             */
> +            break;
> +        }
> +        if (val & CRB_START_INVOKE) {
> +            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {

This inner condition is always true: we already break at the guard
above when CRB_START_INVOKE is set.

> [ ... skip 33 lines ... ]
> +        } else if (val & CRB_START_RSP_RETRY) {
> +            if (!s->cap_chunk) {
> +                break;
> +            }
> +            if (s->response_buffer->len > 0) {
> +                trace_tpm_crb_mmio_write(addr, size, val);

Duplicate trace: trace_tpm_crb_mmio_write() is already called
unconditionally at the top of tpm_crb_mmio_write().

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



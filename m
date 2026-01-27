Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17BD34096
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklOh-0006XJ-7O; Tue, 27 Jan 2026 10:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vklOf-0006Tp-LZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vklOc-0005wK-Vu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769529264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Rxro/wnNpgWRWsNBmVd/2tsLR8YpotfU/ZcytZE+Lo=;
 b=NZinehQc2Tc1yWzS/w61EdrRqoI0sSQ2NoS3HepZfmW3qjb+mW1ZYa936CE30fZqylwG2k
 0ZW1PBirlL7h3MEAZ+o8TIQyd3KGSp+cLZnUxmq2OzBNo0B3EkA+pApf1ejR3gYkwEmyKG
 PTbwLhMHF2pVTB46aFNfH5jV+D+eByc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-VElgGfzENkWp5aaehIL90A-1; Tue,
 27 Jan 2026 10:54:23 -0500
X-MC-Unique: VElgGfzENkWp5aaehIL90A-1
X-Mimecast-MFC-AGG-ID: VElgGfzENkWp5aaehIL90A_1769529261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A43D1800447; Tue, 27 Jan 2026 15:54:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 921C618002A6; Tue, 27 Jan 2026 15:54:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4B917180009C; Tue, 27 Jan 2026 16:54:18 +0100 (CET)
Date: Tue, 27 Jan 2026 16:54:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v5 6/6] igvm: Fill MADT IGVM parameter field
Message-ID: <aXje_WdH0TegZNoe@sirius.home.kraxel.org>
References: <20260127100257.1074104-1-osteffen@redhat.com>
 <20260127100257.1074104-7-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127100257.1074104-7-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> +static int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data,
> +                                Error **errp)
> +{

[3358/3616] Linking target qemu-system-s390x
FAILED: [code=1] qemu-system-s390x 
cc -m64 @qemu-system-s390x.rsp
/usr/bin/ld: libsystem.a.p/backends_igvm.c.o: in function `qigvm_directive_madt':
/home/kraxel/projects/qemu/build/default/../../backends/igvm.c:800:(.text+0x1bdc): undefined reference to `acpi_build_madt_standalone'
collect2: error: ld returned 1 exit status

Moving the function to target/i386/igvm.c and adding a stub version to
stubs/igvm.c should fix that.

take care,
  Gerd


